import 'package:airplane_me/models/user_model.dart';
import 'package:airplane_me/services/auth_services.dart';
import 'package:airplane_me/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        AuthLoading(),
      );

      UserModel user = await AuthServices().signIn(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthServices().signUp(
        email: email,
        password: password,
        name: name,
        hobby: hobby,
      );

      emit(
        AuthSuccess(user),
      );
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void signOut() async {
    try {
      emit(
        AuthLoading(),
      );
      await AuthServices().signOut();
      emit(
        AuthInitial(),
      );
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);
      emit(
        AuthSuccess(user),
      );
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }
}
