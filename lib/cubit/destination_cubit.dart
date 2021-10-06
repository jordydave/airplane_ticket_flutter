import 'package:airplane_me/models/destination_model.dart';
import 'package:airplane_me/services/destination_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationInitial());

  void fetchDestinations() async {
    try {
      emit(
        DestinationLoading(),
      );

      List<DestinationModel> destinations =
          await DestinationService().fetchDestinations();

      emit(
        DestinationSuccess(destinations),
      );
    } catch (e) {
      emit(
        DestinationsFailed(
          e.toString(),
        ),
      );
    }
  }
}
