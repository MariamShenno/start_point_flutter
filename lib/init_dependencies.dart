import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/localization/language_cache_helper.dart';
import 'config/theme/theme_mode_cache_helper.dart';
import 'core/cubits/locale/localization_cubit.dart';
import 'core/cubits/network/network_connection_cubit.dart';
import 'core/cubits/theme_mode/theme_mode_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// dio
  sl.registerLazySingleton<Dio>(() => Dio());

  /// SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  ///// core & config /////

  /// INTERNET-CONNECTION-->
  /// core/network-cubit
  sl.registerFactory(() => NetworkConnectionCubit());

  /// LOCALIZATION-->
  /// config/LanguageCacheHelper
  sl.registerFactory(() => LanguageCacheHelper(sharedPreferences: sl()));

  /// core/Localization-cubit
  sl.registerLazySingleton(() => LocalizationCubit(languageCacheHelper: sl()));

  /// THEME_MODE-->
  /// config/ThemeModeCacheHelper
  sl.registerFactory(() => ThemeModeCacheHelper(sharedPreferences: sl()));

  /// core/ThemeMode-cubit
  sl.registerLazySingleton(() => ThemeModeCubit(themeModeCacheHelper: sl()));

  ///// Features /////


}
