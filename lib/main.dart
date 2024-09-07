import 'package:flutter/material.dart';
import 'dart:async';
import 'new.dart';
void main() => runApp(MyApp());
const color1 = Color(0xFF1D1E33);
const color2 = Color(0xFF111328);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'my_HCI_Project',
      //home:StopwatchApp(),
      home: myStopWatchAppForHCI(),
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.pink,
        buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
      ),
        themeMode:ThemeMode.dark ,
        darkTheme: ThemeData(
    /* dark theme settings */
    brightness: Brightness.dark,
    scaffoldBackgroundColor: color2,
    primaryColor: color1,
        ),);
  }
}

class myStopWatchAppForHCI extends StatefulWidget {
  @override
  _myStopWatchAppForHCIState createState() => _myStopWatchAppForHCIState();
}

class _myStopWatchAppForHCIState extends State<myStopWatchAppForHCI> {

  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer timer;

  void start(){
    stopwatch.start();
    timer = Timer.periodic(Duration(milliseconds: 1), update);
  }

  void update(Timer t){
    if(stopwatch.isRunning){
      setState(() {
        timeString =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") + ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") + ":" +
                (stopwatch.elapsed.inMilliseconds % 1000 / 10).clamp(0, 99).toStringAsFixed(0).padLeft(2, "0");
      });

    }
  }

  void stop(){
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });

  }

  void reset(){
    timer.cancel();
    stopwatch.reset();
    setState((){
      timeString = "00:00:00";

    });
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
              child: Text("STOPWATCH",
                  style: TextStyle(
                    fontSize: 40,
                    fontStyle:FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.teal,
                  )
              ),
            ),
            Expanded(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    shape: BoxShape.circle,
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.timer, size: 90, color: Colors.grey.shade900),
                    Text("00:00:00",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey.shade900
                        )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      onPressed: (){reset();},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            ),
                        child: Icon(Icons.refresh, size: 60,color: Colors.teal,),
                      )
                  ),
                  FlatButton(
                      onPressed: (){
                        stopwatch.isRunning ? stop() : start();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            ),
                        child: Icon(stopwatch.isRunning ? Icons.pause : Icons.play_arrow, size: 60,color: Colors.redAccent,),
                      )
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
