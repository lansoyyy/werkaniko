// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:go_router/go_router.dart';
import 'package:motor_rescue/src/widgets/toast_widget.dart';
import 'package:google_maps_webservice/places.dart' as location;
import '../controllers/auth.dart';
import 'package:google_api_headers/google_api_headers.dart';

class DriverSignup extends StatefulWidget {
  const DriverSignup({super.key});

  @override
  State<DriverSignup> createState() => _DriverSignupState();
}

late TextEditingController fnameController;
late TextEditingController lnameController;
late TextEditingController emailController;
late TextEditingController passwordController;
late TextEditingController confirmpasswordController;
late TextEditingController addressController;
late TextEditingController phoneController;

final _formKey = GlobalKey<FormState>();

class _DriverSignupState extends State<DriverSignup> {
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    isButtonEnabled = false;
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();

    fnameController.addListener(_validateForm);
    lnameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmpasswordController.addListener(_validateForm);
    addressController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    fnameController.removeListener(_validateForm);
    lnameController.removeListener(_validateForm);
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    addressController.removeListener(_validateForm);
    phoneController.removeListener(_validateForm);
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isButtonEnabled = fnameController.text.isNotEmpty &&
          lnameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          confirmpasswordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff24688e)),
        toolbarHeight: 75,
        leadingWidth: 75,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Signup',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                fontFamily: 'Bold',
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(child: buildFirstName()),
                      SizedBox(width: size.width * 0.03),
                      Flexible(child: buildLastName()),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  buildEmail(),
                  SizedBox(height: size.height * 0.03),
                  buildPassword(),
                  SizedBox(height: size.height * 0.03),
                  buildPassword1(),
                  SizedBox(height: size.height * 0.03),
                  buildAddress(context),
                  SizedBox(height: size.height * 0.03),
                  buildPhone(),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    height: 75,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                      ),
                      onPressed: isButtonEnabled
                          ? () => confirmpasswordController.text ==
                                  passwordController.text
                              ? _signUp(context)
                              : showToast('Password do not match')
                          : null,
                      child: const Text(
                        'SIGNUP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go('/driverLogin'),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------

Widget buildFirstName() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          controller: fnameController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.person,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'First Name',
          ),
        ),
      ),
    ],
  );
}

//-----------------------------------------------------------

Widget buildLastName() {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          controller: lnameController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              null,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'Last Name',
          ),
        ),
      ),
    ],
  );
}

//-----------------------------------------------------------

Widget buildEmail() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.email,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'Email',
          ),
        ),
      ),
    ],
  );
}

//------------------------------------------------------

Widget buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          obscureText: true,
          controller: passwordController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.lock,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'Password',
          ),
        ),
      ),
    ],
  );
}

Widget buildPassword1() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          obscureText: true,
          controller: confirmpasswordController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.lock,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'Confirm Password',
          ),
        ),
      ),
    ],
  );
}

//-----------------------------------------------------

Widget buildAddress(context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          location.Prediction? p = await PlacesAutocomplete.show(
              mode: Mode.overlay,
              context: context,
              apiKey: 'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
              language: 'en',
              strictbounds: false,
              types: [""],
              decoration: InputDecoration(
                  hintText: 'Search Address',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white))),
              components: [
                location.Component(location.Component.country, "ph")
              ]);

          location.GoogleMapsPlaces places = location.GoogleMapsPlaces(
              apiKey: 'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
              apiHeaders: await const GoogleApiHeaders().getHeaders());

          location.PlacesDetailsResponse detail =
              await places.getDetailsByPlaceId(p!.placeId!);

          addressController.text = detail.result.name;

          // addMyMarker1(detail.result.geometry!.location.lat,
          //     detail.result.geometry!.location.lng);

          // mapController!.animateCamera(CameraUpdate.newLatLngZoom(
          //     LatLng(detail.result.geometry!.location.lat,
          //         detail.result.geometry!.location.lng),
          //     18.0));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
              ),
            ],
          ),
          height: 60,
          child: TextField(
            enabled: false,
            controller: addressController,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.house,
                color: Colors.blue,
                size: 30,
              ),
              hintText: 'Home Address',
            ),
          ),
        ),
      ),
    ],
  );
}

//------------------------------------------------------

Widget buildPhone() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ],
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.phone,
              color: Colors.blue,
              size: 30,
            ),
            hintText: 'Phone',
          ),
        ),
      ),
    ],
  );
}

//----------------------------------------------------

//---------------------------------------------

Future<void> _signUp(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    // Logging in the user w/ Firebase
    String result = await AuthMethods().signUpDriver(
        fname: fnameController.text,
        lname: lnameController.text,
        email: emailController.text,
        password: passwordController.text,
        address: addressController.text,
        phone: phoneController.text);
    if (result == 'success') {
      GoRouter.of(context).go('/driverLogin');
    } else {
      print(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  GoRouter.of(context).pop();
}
