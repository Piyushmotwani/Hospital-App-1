// import 'package:hospital_app/pages/hospital_registration_screen.dart';
// import 'package:hospital_app/utils/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   // formkey
//   final _formkey = GlobalKey<FormState>();
//   // text editing controller
//   final TextEditingController emailcontroller = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   // firebase
//   final _auth=FirebaseAuth.instance;
//   // string for displaying the error Message
//   String? errorMessage;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     bool obs_text=true;
//     final emailField = TextFormField(
//       autofocus: false,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value){
//         if(value!.isEmpty)
//         {
//          return ('Please enter some text');
//         }
//         // // reg expression email for validation
//         // if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
//         // {
//         //   return ('Please Enter a valid Email');
//         // }
//         return null;
//       },
//       controller: emailcontroller,
//       onSaved: (value) {
//         emailcontroller.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.email),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'E-mail',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )),
//     );
//     final passwordField = TextFormField(
//       obscureText: obs_text?true:false,
//       autofocus: false,
//
//       validator: (value)
//       {
//        RegExp regex = new RegExp(r'^.{6,}$');
//         if(value!.isEmpty)
//         {
//           return 'Please enter password';
//         }
//         if(value.startsWith("user")){
//           return "Password should contain 'user' at starting";
//         }
//         if(!regex.toString().startsWith("user"))
//         {
//           return '(user characters are required)';
//         }
//       },
//       controller: passwordController,
//       onSaved: (value) {
//         passwordController.text = value!;
//       },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//
//           prefixIcon: Icon(Icons.vpn_key),
//           suffixIcon: IconButton(icon:Icon(Icons.remove_red_eye),onPressed: (){
//                           obs_text=false;
//                           setState(() {
//
//                           });
//                         },),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Password',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )),
//     );
//
//     final loginButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(40),
//       color: Colors.lightBlueAccent,
//       child: MaterialButton(
//         padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//         onPressed: () {
//           signIn(emailcontroller.text, passwordController.text);
//
//         },
//         child: Text(
//           'Login',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 15.6,
//           ),
//         ),
//       ),
//     );
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(left: 8, right: 8),
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(36),
//               child: Form(
//                   key: _formkey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                           height: 200,
//                           child: Image.asset(
//                             "Assets/doc_pat.jpg",
//                             fit: BoxFit.contain,
//                           )),
//                       SizedBox(
//                         height: 35,
//                       ),
//                       emailField,
//                       SizedBox(
//                         height: 35,
//                       ),
//                       passwordField,
//                       SizedBox(
//                         height: 40,
//                       ),
//                       loginButton,
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Don't have an account "),
//                           GestureDetector(
//                             child: Text(
//                               'Sign Up',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Colors.lightBlueAccent),
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           RegistrationScreen()));
//                             },
//                           )
//                         ],
//                       )
//                     ],
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//      void signIn(String email, String password) async {
//     if (_formkey.currentState!.validate()) {
//       try {
//         await _auth
//             .signInWithEmailAndPassword(email: email, password: password)
//             .then((uid) => {
//                   Fluttertoast.showToast(msg: "Login Successful"),
//                    Navigator.pushNamed(context, MyRoute.homeRoute),
//                 });
//       } on FirebaseAuthException catch (error) {
//         switch (error.code) {
//           case "invalid-email":
//             errorMessage = "Your email address appears to be malformed.";
//
//             break;
//           case "wrong-password":
//             errorMessage = "Your password is wrong.";
//             break;
//           case "user-not-found":
//             errorMessage = "User with this email doesn't exist.";
//             break;
//           case "user-disabled":
//             errorMessage = "User with this email has been disabled.";
//             break;
//           case "too-many-requests":
//             errorMessage = "Too many requests";
//             break;
//           case "operation-not-allowed":
//             errorMessage = "Signing in with Email and Password is not enabled.";
//             break;
//           default:
//             errorMessage = "An undefined Error happened.";
//         }
//         Fluttertoast.showToast(msg: errorMessage!);
//         print(error.code);
//       }
//     }
//   }
//
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_app/Authentication/registration_screen.dart';
import 'package:hospital_app/HospitalAuthentication/Hospital_Methods.dart';
import 'package:hospital_app/HospitalAuthentication/hospital_registration_screen.dart';
import 'package:hospital_app/Service/Auth_Service.dart';
import 'package:hospital_app/pages/DoctorHomePage.dart';
// import 'package:hospital_app/pages/DoctorHomePage.dart';
// import 'package:hospital_app/pages/doctor_home_page.dart';
import 'package:hospital_app/pages/home_page.dart';
// import 'package:untitled/Authentication/SignUp.dart';
// import 'package:untitled/Screen/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    bool obs_text = true;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        //backgroundColor: Colors.greenAccent,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, "/"),
          ),
          title: Center(
            child: Text(
              "Hospital App",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Container(
              child: IconButton(
                  onPressed: () {
                    //hospitalLogOut(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color(0xff8f94fb),
                  )),
            )
          ],
          elevation: 0,
          //backgroundColor: Colors.greenAccent,
          backgroundColor: Color(0xff8f94fb),
        ),
        //backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: Container(child: CircularProgressIndicator()))
            : SingleChildScrollView(
                padding: EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "Assets/images/password.png",
                            fit: BoxFit.fitHeight,
                            height: 146,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          height: size.height / 14,
                          width: size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            //color: Color.fromRGBO(250, 228, 252, 1),
                          ),
                          child: TextField(
                              controller: _email,
                              cursorColor: const Color(0xff8f94fb),
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff8f94fb)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff8f94fb)),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xff8f94fb),
                                  // color: Color.fromRGBO(
                                  //     254, 23, 72, 1),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Email",

                                // labelText: "Name"
                              )),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: size.height / 14,
                          width: size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            //color: Color.fromRGBO(250, 228, 252, 1),
                          ),
                          child: TextField(
                              controller: _password,
                              cursorColor: const Color(0xff8f94fb),
                              obscureText: true,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff8f94fb)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff8f94fb)),
                                ),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Color(0xff8f94fb),
                                  // color: Color.fromRGBO(
                                  //     254, 23, 72, 1),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Password",

                                // labelText: "Name"
                              )),
                        ),
                        // SizedBox(
                        //     height: 30
                        // ),TextField(
                        //     autofocus: false,
                        //     controller: _profession,
                        //     textInputAction: TextInputAction.next,
                        //     decoration: InputDecoration(
                        //       prefixIcon: Icon(Icons.school),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10)
                        //       ),
                        //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        //       hintText: "Hospital/User",
                        //     )
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: size.height / 14,
                          width: size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Colors.white,
                            // color: Color.fromRGBO(250, 228, 252, 1),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                            onTap: () {
                              if (_email.text.isNotEmpty &&
                                  _password.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });

                                hospitalLogIn(_email.text, _password.text)
                                    .then((user) {
                                  if (user != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()));
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              } else {
                                print("please fill the form correctly");
                              }
                            },
                            child: Container(
                                height: size.height / 14,
                                width: size.width / 3.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    //color: Colors.indigoAccent,
                                    color: Color(0xff8f94fb)),
                                alignment: Alignment.center,
                                child: Text("Log In",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignUpScreen()));
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                            fontSize: 16,
                                            //color: Colors.white,
                                            color: Color(0xff8f94fb),
                                            // color: Colors.blue,
                                            fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      ]),
                )));
  }
}

  // Widget buttonItem(
  //     String imagepath, String buttonName, double size, Function()? onTap) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 60,
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             side: BorderSide(width: 1, color: Colors.grey)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SvgPicture.asset(
  //               imagepath,
  //               height: size,
  //               width: size,
  //             ),
  //             SizedBox(
  //               width: 15,
  //             ),
  //             Text(
  //               buttonName,
  //               style: TextStyle(fontSize: 17),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

