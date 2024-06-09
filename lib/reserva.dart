import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import'package:flutter/src/material/dropdown.dart';

class reserva extends StatefulWidget {
  const reserva({super.key});

  @override
  State<reserva> createState() => _reservaState();
}

class _reservaState extends State<reserva> {
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();
  String selectedRoomType = "Selecione o Quarto";
  double valorReserva = 0.0;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  double _getRoomRate() {
    switch (selectedRoomType) {
      case "Econômico":
        return 100.0;
      case "Básico":
        return 150.0;
      case "Premium":
        return 200.0;
      default:
        return 0.0; // Valor default para "Selecione o quarto"
    }
  }

  void calcularReserva() {
    if (checkInController.text.isEmpty ||
        checkOutController.text.isEmpty ||
        selectedRoomType == "Selecione o quarto") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Por favor, preencha todos os campos e selecione um quarto válido")),
      );
      return;
    }
    DateTime checkInDate =
        DateFormat('dd/MM/yyyy').parse(checkInController.text);
    DateTime checkOutDate =
        DateFormat('dd/MM/yyyy').parse(checkOutController.text);

    if (checkOutDate.isBefore(checkInDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Data de check-out deve ser posterior à data de check-in")),
      );
      return;
    }
    int daysDifference = checkOutDate.difference(checkInDate).inDays;
    double roomRate = _getRoomRate();

    setState(() {
      valorReserva = daysDifference * roomRate;
    });
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotel Sunshine - Reservas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              "assets/logoHotel.jpg",
              height: 254,
            ),
            const Text(
              "Hotel Sunshine",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: checkInController,
              decoration: InputDecoration(
                labelText: "Check-in:",
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, checkInController),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: checkOutController,
              decoration: InputDecoration(
                labelText: "Check-out:",
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, checkOutController),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedRoomType,
              items: ["Selecione o Quarto", "Econômico", "Básico", "Premium"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedRoomType = newValue;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: "Quarto:",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            FilledButton(
              onPressed: calcularReserva,              
              // onPressed: () {
              //   if (checkInController.text.isEmpty ||
              //       checkOutController.text.isEmpty ||
              //       selectedRoomType == "Selecione o quarto") {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(
              //           content: Text('Por favor, preencha todos os campos')),
              //     );
              //   } else {
              //     // Processo de reserva
              //   }
              //   // setState(() {
              //   //   //inserir ação;
              //   // });
              // },
              child: Text(
                "Reserva",
                style: TextStyle(fontSize: 20),
              ),
            ),
            if (valorReserva > 0)
            Text(
              'Valor da Reserva: R\$ ${valorReserva.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
