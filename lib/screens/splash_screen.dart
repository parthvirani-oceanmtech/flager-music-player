import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flager_player/utilities/app_router.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  BuildContext? buildContext;
  @override
  void initState() {
    super.initState();
    //loadAudioFiles();
    Future.delayed(
      Duration.zero,
      () {
        if (buildContext != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _initFetch(buildContext!));
        }
      },
    );
  }

  _initFetch(BuildContext context) async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
    buildContext?.router.replace(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: 100.0, width: 100.0),
            const SizedBox(height: 10),
            const SizedBox(width: 100, child: LinearProgressIndicator(minHeight: 3))
          ],
        ),
      ),
    );
  }
}
