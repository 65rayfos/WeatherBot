import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  print('Python path: ${Platform.script}');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Bot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherBotTestHomePage(),
    );
  }
}

class WeatherBotTestHomePage extends StatefulWidget {
  @override
  _WeatherBotTestHomePageState createState() => _WeatherBotTestHomePageState();
}


class _WeatherBotTestHomePageState extends State<WeatherBotTestHomePage> {
  String _output = 'No data yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Bot'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _runWeatherBotTest();
              },
              child: Text('Get Weather Update'),
            ),
            SizedBox(height: 20),
            Text(_output),
          ],
        ),
      ),
    );
  }

  Future<void> _runWeatherBotTest() async {
    try {
      print('Checking weather and sending noti');
      String pythonScriptPath = 'D:/Programming Projects/Python/WeatherBot/WeatherBot-Test.py';

      print('Python script path: $pythonScriptPath');
      if (!File(pythonScriptPath).existsSync()) {
        print('Python script does not exist at $pythonScriptPath');
        return;
      }

      final result = await Process.run('python', ['D:/Programming Projects/Python/WeatherBot/WeatherBot-Test.py']);


      print('Running Python script');
      print('Stdout: ${result.stdout}');
      print('Stderr: ${result.stderr}');

      setState(() {
        _output = result.stdout.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error running weather bot: $e';
      });
    }
  }
}
