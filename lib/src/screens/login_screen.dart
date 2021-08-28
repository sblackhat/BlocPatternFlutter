import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            emailField(bloc),
            passwordField(bloc),
            submitButton(bloc),
          ],
        ));
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'Email',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
        );
      },
      stream: bloc.email,
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          autocorrect: false,
          obscureText: true,
          enableSuggestions: false,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Pasword',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
          ),
        );
      },
      stream: bloc.password,
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed:
              snapshot.hasError || !snapshot.hasData ? null : bloc.submit(),
          child: Text('Log in'),
          style: ElevatedButton.styleFrom(primary: Colors.lightBlue[800]),
        );
      },
    );
  }
}
