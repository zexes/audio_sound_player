import 'package:audioplayers/audio_cache.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlayer = AudioPlayer();
  String filePath = 'file path';
  String path;

  final player = AudioCache();

  void playSound(int soundNumber) => player.play('note$soundNumber.wav');

  Expanded soundPlayer({Color color, int soundNumber}) => Expanded(
        child: FlatButton(
          onPressed: () {
            playSound(soundNumber);
          },
          color: color,
          child: Text(''),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('zikozee Audio Player'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud),
              ),
              Tab(
                icon: Icon(Icons.phone_android),
              ),
              Tab(icon: Icon(Icons.web_asset)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Tab(child: Icon(Icons.cloud)),
            Tab(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text('$filePath'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () async {
                          path = await getFileName();
                          setState(() {
                            filePath = path;
                            print('value is now $filePath');
                          });
                        },
                        child: Text('Select Audio'),
                        color: Colors.lightGreen,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async => await audioPlayer.stop(),
                          child: Icon(
                            Icons.stop,
                            color: Colors.blueGrey[900],
                            size: 100,
                          ),
                        ),
                        FlatButton(
                          onPressed: () async =>
                              await audioPlayer.play(filePath, isLocal: true),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.blueGrey[900],
                            size: 100,
                          ),
                        ),
                        FlatButton(
                          onPressed: () async => await audioPlayer.pause(),
                          child: Icon(
                            Icons.pause,
                            color: Colors.blueGrey[900],
                            size: 100,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Tab(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  soundPlayer(color: Colors.red, soundNumber: 1),
                  soundPlayer(color: Colors.deepOrange, soundNumber: 2),
                  soundPlayer(color: Colors.yellow, soundNumber: 3),
                  soundPlayer(color: Colors.green, soundNumber: 4),
                  soundPlayer(color: Colors.teal, soundNumber: 5),
                  soundPlayer(color: Colors.blue, soundNumber: 6),
                  soundPlayer(color: Colors.purple, soundNumber: 7),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<String> getFileName() async {
    String path = await FilePicker.getFilePath(type: FileType.ANY);
    return '$path';
  }
}
