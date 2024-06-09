/*O hotel Sunshine tem 600 suítes e possui uma rotatividade média de 6000 hóspedes por ano. 
Eles fazem suas reservas antecipadamente, via web site. 
Durante o processo de reserva é solicitada a data de entrada e saída de sua hospedagem, 
bem como as suas preferências de acomodações(Existem acomodações com preços diferentes). 
Crie um aplicativo que solicite essas informações e calcule o valor total da hospedagem.*/

import 'package:flutter/material.dart';
import 'package:reserva_hotel/reserva.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Sunshine',      
      theme: ThemeData(        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const reserva(),
    );
  }
}
