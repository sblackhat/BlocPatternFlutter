import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/bloc/validator.dart';

class Bloc with Validator {
  // ignore: slash_for_doc_comments
  /**Change from StreamController to BehaviourSubject in order to take a look
  /at the value
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();
  **/
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  //Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is $validEmail');
    print('Password is $validPassword ');
  }

  //Call it whenever we are done with this class
  void dispose() {
    _email.close();
    _password.close();
  }
}
