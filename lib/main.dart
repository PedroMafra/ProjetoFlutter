// ignore: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'view/login.dart';
import 'view/cadastro.dart';
import 'view/recuperar.dart';
import 'view/menu.dart';
import 'view/sobre.dart';
import 'view/mapa.dart';
import 'view/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FECAM SP',
    initialRoute: 'splash',
    routes: {
      'login': (context) => LoginView(),
      'cadastro': (context) => CadastroView(),
      'recuperar': (context) => RecuperarView(),
      'menu': (context) => MenuView(),
      'sobre': (context) => SobreView(),
      'mapa': (context) => MapaView(),
      'splash': (context) => SplashView(),
    },
  ));
}
