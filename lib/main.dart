import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Device Orientation',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Orientation Builder'),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: setPortraitAndLandscape,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? buildPortrait()
                    : buildLandscape(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.rotate_left),
          onPressed: () {
            final isPortrait =
                MediaQuery.of(context).orientation == Orientation.portrait;

            if (isPortrait) {
              setLandscape();
            } else {
              setPortrait();
            }
          },
        ),
      );

  Future setPortrait() async => await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  Future setLandscape() async => await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

  Future setPortraitAndLandscape() =>
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  Widget buildPortrait() => ListView(
        children: [
          buildImage(),
          const SizedBox(height: 16),
          buildText(),
        ],
      );

  Widget buildLandscape() => Row(
        children: [
          buildImage(),
          const SizedBox(width: 16),
          Expanded(child: SingleChildScrollView(child: buildText())),
        ],
      );

  Widget buildImage() => Image.network(
      'https://images.unsplash.com/photo-1585129819171-80b02d4c85b0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80');

  Widget buildText() => const Column(
        children: [
          Text(
            'Hair Styling',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '''The oldest known depiction of hair styling is hair braiding which dates back about 30,000 years. In history, women's hair was often elaborately and carefully dressed in special ways. From the time of the Roman Empire[citation needed] until the Middle Ages, most women grew their hair as long as it would naturally grow. Between the late 15th century and the 16th century, a very high hairline on the forehead was considered attractive. Around the same time period, European men often wore their hair cropped no longer than shoulder-length. In the early 17th century, male hairstyles grew longer, with waves or curls being considered desirable.''',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
}
