import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/dialog_service.dart';
import 'package:provider_start/core/services/location_permission_service.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/theme_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class SettingsModel extends BaseModel {
  final _dialogService = locator<DialogService>();
  final _locationPermissionService = locator<LocationPermissionService>();
  final _themeService = locator<ThemeService>();
  final _keyStorageService = locator<KeyStorageService>();

  bool get isNightMode => _keyStorageService.nightMode;

  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  void launchAppPermissions() {
    _locationPermissionService.openAppPermissions();
  }

  Future<bool> deleteSomething() async {
    bool success = false;

    final dialogResult = await _dialogService.showDialog(
      title: 'Delete Something',
      description: 'Are you sure you want to delete this',
      buttonTitle: 'Yes delete this',
    );

    if (dialogResult.confirmed) {
      success = true;
    }

    return success;
  }

  Future<void> toggleNightMode() async {
    bool enabled = _keyStorageService.nightMode;

    if (!enabled) {
      await _themeService.changeTheme(ThemeType.dark);
      _keyStorageService.nightMode = true;
    } else {
      await _themeService.changeTheme(ThemeType.primary);
      _keyStorageService.nightMode = false;
    }

    notifyListeners();
  }
}