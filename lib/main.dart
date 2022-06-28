import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void valores() {
    String systolicText;
    String diastolicText;

    setState(() {
      systolicText = systolicController.text;
      diastolicText = diastolicController.text;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Risco(systolicText, diastolicText)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Entre com a pressão sistólica e diastólica (mmHg):",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Insira sua pressão sistólica",
                  hintText: "Exemplo de entrada: 120mmHg",
                  border: OutlineInputBorder(),
                ),
                maxLength: 3,
                controller: systolicController,
                validator: (value) {
                  var valor = double.parse(value);

                  if (valor < 0) {
                    return "Insira uma pressão válida";
                  }

                  if (value.isEmpty) {
                    return "Insira  sua pressão sistólica!";
                  }

                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Insira sua pressão diastólica",
                  hintText: "Exemplo de entrada: 80mmHg",
                  border: OutlineInputBorder(),
                ),
                maxLength: 3,
                controller: diastolicController,
                validator: (value) {
                  var valor = double.parse(value);

                  if (valor < 0) {
                    return "Insira uma pressão sistólica válida";
                  }

                  if (value.isEmpty) {
                    return "Insira sua pressão diastólica válida!";
                  }

                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 70,
                  width: 120,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate()) {
                        valores();
                      }
                    },
                    child: Text(
                      "Risco",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////// SEGUNDA TELA //////////////////////////////////

class Risco extends StatefulWidget {
  String systolicText;
  String diastolicText;
  Risco(this.systolicText, this.diastolicText);

  @override
  _RiscoState createState() => _RiscoState();
}

class _RiscoState extends State<Risco> {
  final _formKey = GlobalKey<FormState>();
  String _infoTeste = "";
  void pressao() {
    setState(() {
      double systolic = double.parse(widget.systolicText);
      double diastolic = double.parse(widget.diastolicText);

      if (systolic <= 120 && diastolic <= 80) {
        _infoTeste =
            "Sua pressão está normal!\n Monitorização residencial da pressão arterial\n\n Reavaliação em 1 ano";

        Builder(builder: (context) {
          return OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              icon: Icon(Icons.keyboard_return_sharp, size: 50),
              label: Text(
                'VOLTAR',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(300, 100),
              ));
        });
      } else if (systolic < diastolic) {
        _infoTeste =
            "Coração não está bombeando para corpo\n\n Possível débito cardíaco";
      } else if (systolic < 90 && diastolic < 60) {
        _infoTeste = "Sua pressão arterial está baixa!";
      } else if ((systolic > 120 && systolic <= 129) && diastolic <= 80) {
        _infoTeste =
            "Sua pressão está elevada!\n Terapia não farmacológica\n\n Reavaliar em 3 meses a 6 meses.";
      } else if ((systolic >= 130 && systolic <= 139) &&
          (diastolic <= 89 && diastolic >= 80)) {
        _infoTeste =
            "Sua pressão está alta em estágio 1!\n Verifique em um posto de saúde seu risco cardiovascular\n\n Caso aponte >10% em 10 anos\n Terapia não farmacológica e farmacológica\n\n Caso não, terapia não farmacológica e reavaliar em 6 meses";
      } else if (systolic >= 140 && diastolic >= 90) {
        _infoTeste =
            "Sua pressão está alta em estágio 2!\n Terapia não farmacológica e farmacológica\n\n Reavaliar em 1 mes\n\n Caso meta atingida da diminuição, reavalie em 3 a 6 meses\n\n Caso não acompanhar e otimizar aderêcia\n Considerar intensificação da terapia";
      } else if (systolic >= 180 && diastolic >= 120) {
        _infoTeste = "Você está em crise de hipertensão!";
      } else if (systolic == diastolic || (systolic - diastolic) <= 20) {
        _infoTeste =
            "Possível insuficiência cardíaca.\n\n Enrijecimento dos vasos sanguíneos e a tendência de desenvolvimento de hipertensão arterial!\n\n Pressões Sistólica e Diastólica próximas";
      } else if (systolic != null || diastolic != null) {
        _infoTeste = "Entre com valor real de pressão sistólica e distólica";
      } else {
        _infoTeste =
            "Entre com valor real para sístole e diástole!\n\n Ou procure imediatamente um médico!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pressao();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seu Grau de Risco Cardiovascular :",
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(

                  //width: 200,
                  //height: 200,
                  ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
              Text(_infoTeste,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 25)),
            ], //Widget
          ), //Column
        ), //Form
      ), //SingleChildScrollView
    ); //Scaffold
  }
}
