import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<void> redirect(Uri url) async {
  // Client implementation detail
}

Future<Uri> listen(Uri url) async {
  // Client implementation detail
  return Uri();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> _login() async {
    // This URL is an endpoint that's provided by the authorization server. It's
    // usually included in the server's documentation of its OAuth2 API.
    final authorizationEndpoint =
        Uri.parse('https://cmcinfinity-dev-ed.my.salesforce.com/services/oauth2/authorize');

    // The user should supply their own username and password.
    final username = 'tqtai@cts.com.vn';
    final password = 'anhtaimmk@1234';

    // The authorization server may issue each client a separate client
    // identifier and secret, which allows the server to tell which client
    // is accessing it. Some servers may also have an anonymous
    // identifier/secret pair that any client may use.
    //
    // Some servers don't require the client to authenticate itself, in which case
    // these should be omitted.
    final identifier = '3MVG9YDQS5WtC11rWdcCAUYsljvKVu5IzgImWYMf_7GjORIztH1G_pO8GDxX4P3r6mSw3kZknaQ6W5CBOKAbq';
    final secret = 'B3E1C3349AAFEB99A98E29A9F7CB3D8F7B56A62B640651F0869F74A09EA2B092';

    // Make a request to the authorization endpoint that will produce the fully
    // authenticated Client.
    var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint, username, password,
        identifier: identifier, secret: secret);

    // Once you have the client, you can use it just like any other HTTP client.
    // var result = await client.read('http://example.com/protected-resources.txt');

    // Once we're done with the client, save the credentials file. This will allow
    // us to re-use the credentials and avoid storing the username and password
    // directly.
    File('~/.myapp/credentials.json').writeAsString(client.credentials.toJson());
    print('asdasdas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TutorialKart',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Login with Salesforce'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text('Login'),
                      // onPressed: () {
                      //   print(nameController.text);
                      //   print(passwordController.text);
                      // },
                      onPressed: _login,
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
