import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

void main() {
  CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [
      ConsoleHandler(),
    ],
    logger: CustomCatcherLogger(),
  );
  CatcherOptions releaseOptions = CatcherOptions(PageReportMode(), [
    ConsoleHandler()
  ]);

  Catcher(
      runAppFunction: () {
        runApp(MyApp());
      },
      debugConfig: debugOptions,
      releaseConfig: releaseOptions);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ChildWidget()),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("Generate error"),
        onPressed: () => generateError(),
      ),
    );
  }

  void generateError() async {
    Catcher.sendTestException();
  }
}

class CustomCatcherLogger extends CatcherLogger {
  void info(String message) {
    print("Custom Catcher Logger | Info | $message");
  }

  void fine(String message) {
    print("Custom Catcher Logger | Fine | $message");
  }

  void warning(String message) {
    print("Custom Catcher Logger | Warning | $message");
  }

  void severe(String message) {
    print("Custom Catcher Logger | Servere | $message");
  }
}
