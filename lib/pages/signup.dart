import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/login.dart';

class Signup extends StatefulWidget {


  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = " ";
  var password = " ";
  var confirmPassword = " ";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registration() async{
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print (userCredential);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(' Registered Successfully. Please Sign In ',
          style: TextStyle(fontSize: 20.0),
          ),
          ),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),),);
      }on FirebaseAuthException catch (error){
          if(error.code == 'weak-password'){
            print (' Password is too weak ');

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black45,
              content: Text(' Password is too weak ',
                style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
              ),
            ),
            );
          }
          else if(error.code == 'email-already-in-use'){
            print (' Account is already exist ');

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black87,
              content: Text(' Account is already exist ',
                style: TextStyle(fontSize: 20.0, color: Colors.indigo),
              ),
            ),
            );
          }
    }
    }
    else {
      print (' Password and Confirm Password do not match');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black87,
            content: Text(' Password and Confirm Password do not match ',
            style: TextStyle(fontSize: 20.0, color: Colors.indigo),
            ),
      ),
      );
            }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(30.0),
                child: Image.asset("images/signup.png"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: ' Email: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                      TextStyle(color: Colors.black87, fontSize: 15.0),
                  ),
                  controller: emailController,
                  validator: (value){
                    if ( value == null || value.isEmpty){
                      return ' Please enter email ';
                    }
                    else if (!value.contains('@')){
                      return ' Please enter valid email ';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: ' Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black87, fontSize: 15.0),
                  ),
                  controller: passwordController,
                  validator: (value){
                    if ( value == null || value.isEmpty){
                      return ' Please enter password ';
                    }
                    else if (!value.contains('@')){
                      return ' Please enter valid password ';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: ' Confirm Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black87, fontSize: 15.0),
                  ),
                  controller: confirmPasswordController,
                  validator: (value){
                    if ( value == null || value.isEmpty){
                      return ' Please enter confirm password ';
                    }
                    else if (!value.contains('@')){
                      return ' Please enter valid confirm password ';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                          confirmPassword = confirmPasswordController.text;
                        });
                        registration();
                      }
                    },
                        child: Text(' Signup',
                        style: TextStyle(fontSize: 18.0),
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' Already have an account ?'),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => LoginPage(),
                      transitionDuration: Duration(seconds: 0),),);
                    },
                        child: Text('Login'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
