import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculaImc(),
      routes: {
        '/info': (context) => InfoScreen(),
      },
    );
  }
}

class CalculaImc extends StatefulWidget {
  @override
  _CalculaImcState createState() => _CalculaImcState();
}

class _CalculaImcState extends State<CalculaImc> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _imc;
  String _message = '';

  void _calculadora() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      setState(() {
        _imc = weight / (height / 100 * height / 100);
        if (_imc! < 18) {
          _message = 'Seu IMC é ${_imc!.toStringAsFixed(2)}: Baixo Peso';
        } else if (_imc! >= 18 && _imc! < 24) {
          _message = 'Seu IMC é ${_imc!.toStringAsFixed(2)}: Peso Normal';
        } else {
          _message = 'Seu IMC é ${_imc!.toStringAsFixed(2)}: Sobrepeso';
        }
      });
    } else {
      setState(() {
        _message = 'Por favor, insira valores válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculadora,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (_imc != null)
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.pushNamed(context, '/info');
                },
              ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações sobre IMC:'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Baixo Peso',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'IMC menor que 18.5.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Peso Normal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'IMC entre 18.5 e 24.9.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Sobrepeso',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'IMC entre 25 e 29.9.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
