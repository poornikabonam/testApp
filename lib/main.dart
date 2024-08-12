import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print('Amplify is already configured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Text('You are logged in!'),
          ),
        ),
      ),
    );
  }
}

 /* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationPage(),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController = TextEditingController();
  final TextEditingController _signUpRetypePasswordController = TextEditingController();
  final TextEditingController _signUpNameController = TextEditingController();
  final TextEditingController _signInEmailController = TextEditingController();
  final TextEditingController _signInPasswordController = TextEditingController();

  String _signInMessage = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Authentication'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign Up'),
              Tab(text: 'Sign In'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSignUpTab(),
            _buildSignInTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _signUpEmailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _signUpPasswordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextField(
            controller: _signUpRetypePasswordController,
            decoration: InputDecoration(labelText: 'Retype Password'),
            obscureText: true,
          ),
          TextField(
            controller: _signUpNameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          ElevatedButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _signInEmailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _signInPasswordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: _signIn,
            child: Text('Sign In'),
          ),
          Text(_signInMessage),
        ],
      ),
    );
  }


  Future<void> _signUp() async {
      final email = _signUpEmailController.text.trim();
      final password = _signUpPasswordController.text.trim();
      final name = _signUpNameController.text.trim();

      if (password != _signUpRetypePasswordController.text.trim()) {
        // Passwords don't match
        return;
      }

      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: {CognitoUserAttributeKey.name: name}),

      );

      print('Sign up successful. Confirmation code sent to $email');
      // Navigate to the verification page
      final verificationResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerificationPage(email: email)),
    );

    // If verification is successful, navigate back to the authentication page
    if (verificationResult == 'Verification successful!') {
      setState(() {
        _signInMessage = verificationResult;
      });
    }
    
  }

  Future<void> _signIn() async {

      final email = _signInEmailController.text.trim();
      final password = _signInPasswordController.text.trim();

      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      setState(() {
        _signInMessage = 'You have logged in.';
      });
      // Navigate to the home page
    } 
  }

  class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _verificationCodeController = TextEditingController();
  String _verificationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _verificationCodeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verify'),
            ),
            Text(_verificationMessage),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyCode() async {
      final verificationCode = _verificationCodeController.text.trim();

      // Call Amplify method to verify the code
      final result = await Amplify.Auth.confirmSignUp(
        username: widget.email,
        confirmationCode: verificationCode,
      );

      setState(() {
        _verificationMessage = 'Verification successful!';
      });

      
      await Future.delayed(Duration(seconds: 2));

      // Navigate back to the authentication page with a success message
      Navigator.pop(context, 'Verification successful!');
    } 
  }
*/



