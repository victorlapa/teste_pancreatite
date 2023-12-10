import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Novo paciente'),
          centerTitle: true,
        ),
        body: const PatientForm(),
      ),
    );
  }
}

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController leucocitosController = TextEditingController();
  TextEditingController glicemiaController = TextEditingController();
  TextEditingController astController = TextEditingController();
  TextEditingController ldhController = TextEditingController();

  bool litiaseBiliar = false;

  int pontuacao = 0;
  bool grave = false;
  String mortalidade = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Nome:',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: nomeController,
          ),
          const SizedBox(height: 16),
          const Text(
            'Idade:',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: idadeController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: litiaseBiliar,
                onChanged: (value) {
                  setState(() {
                    litiaseBiliar = value!;
                  });
                },
              ),
              const Text('Litiase biliar?'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Leucocitos: (cel./mm3)',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: leucocitosController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text(
            'Glicemia: mmol/L',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: glicemiaController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text(
            'AST/TGO: (UI/L)',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: astController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text(
            'LDH: (UI/L)',
            style: TextStyle(fontSize: 18),
          ),
          TextField(
            controller: ldhController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _adicionarPaciente();
            },
            child: const Text('ADICIONAR PACIENTE'),
          ),
          const SizedBox(height: 16),
          grave
              ? const Text(
                  'Pancreatite grave',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                )
              : const SizedBox(height: 0),
          Text('Pontuacao: $pontuacao'),
          Text('Mortalidade: $mortalidade'),
        ],
      ),
    );
  }

  void calculoSemLitiaseBiliar() {
    int score = 0;
    int idade = int.parse(idadeController.text);
    int leucocitos = int.parse(leucocitosController.text);
    int glicemia = int.parse(glicemiaController.text);
    int ast = int.parse(astController.text);
    int ldh = int.parse(ldhController.text);

    if (idade > 55) {
      score += 1;
    }

    if (leucocitos > 16000) {
      score += 1;
    }

    if (glicemia > 11) {
      score += 1;
    }

    if (ast > 250) {
      score += 1;
    }

    if (ldh > 350) {
      score += 1;
    }

    if (score >= 3) {
      grave = true;
    }

    setState(() {
      pontuacao = score;
      mortalidade = calculaMortalidade(score);
    });
  }

  void calculoComLitiaseBiliar() {
    int score = 0;
    int idade = int.parse(idadeController.text);
    int leucocitos = int.parse(leucocitosController.text);
    int glicemia = int.parse(glicemiaController.text);
    int ast = int.parse(astController.text);
    int ldh = int.parse(ldhController.text);

    if (idade > 70) {
      score += 1;
    }

    if (leucocitos > 18000) {
      score += 1;
    }

    if (glicemia > 12.2) {
      score += 1;
    }

    if (ast > 250) {
      score += 1;
    }

    if (ldh > 400) {
      score += 1;
    }

    if (score >= 3) {
      grave = true;
    }

    setState(() {
      pontuacao = score;
      mortalidade = calculaMortalidade(score);
    });
  }

  String calculaMortalidade(int pontuacao) {
    if (pontuacao <= 2) {
      mortalidade = '2%';
    }

    if (pontuacao > 2 && pontuacao <= 4) {
      mortalidade = '15%';
    }

    if (pontuacao > 4 && pontuacao <= 6) {
      mortalidade = '40%';
    }

    if (pontuacao > 6) {
      mortalidade = '100%';
    }

    return mortalidade;
  }

  void _adicionarPaciente() {
    if (litiaseBiliar == true) {
      calculoComLitiaseBiliar();
    } else {
      calculoSemLitiaseBiliar();
    }
  }
}
