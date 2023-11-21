import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).orientation);
    return Scaffold(
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildVerticalLayout()
                : _buildHorizontalLayout();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeRight]),
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return const Text(
      'Vertical',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget _buildHorizontalLayout() {
    return const Text(
      'Horizontal',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
