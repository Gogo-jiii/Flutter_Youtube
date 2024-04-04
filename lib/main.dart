import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Youtube Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var result = "";
  Color _color = Colors.blue;
  late var _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'tcodrIK2P_I',
      autoPlay: false,
      startSeconds: 60,
      endSeconds: 90,
      params: const YoutubePlayerParams(
          showFullscreenButton: false,
          color: "green",
          mute: true,
          showControls: true),
    )..listen((event) {
        setState(() {
          if (event.playerState.name == "ended") {
            _color = Colors.amber;
          } else {
            _color = Colors.red;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 400,
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(result),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                _controller.pauseVideo();
                // setState(() {
                //   //_controller.playerState.then((value) => result = value.name.toString());
                //
                //   //_controller.videoUrl.then((value) => result = value.toString());
                //   //_controller.currentTime.then((value) => result = value.toString());
                // });
              },
              child: Text(
                "Click",
                style: TextStyle(color: _color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
