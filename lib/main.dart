import 'package:flutter/material.dart';
import 'package:lat_responsi/dashboard.dart';
import 'package:lat_responsi/weapon/selected_weapon.dart';
import 'package:provider/provider.dart';
// Reytama Syahdewa Purba_123200021

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedWeapon>(
      create: (_) => SelectedWeapon(),
      child: MaterialApp(
        title: 'Genshin Impact App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
