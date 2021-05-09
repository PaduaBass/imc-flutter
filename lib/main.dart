import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home:  Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoConroller = TextEditingController();
  TextEditingController alturaConroller = TextEditingController();
  String _infoText = "Informe Seus Dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState> ();

  void _reset () {
    pesoConroller.text = ""; 
    alturaConroller.text = "";
    setState(() {
      _infoText = "Informe Seus Dados";
    });
  }

  void _calcular () {
    setState(() {

        double peso = double.parse(pesoConroller.text);
        double altura = double.parse(alturaConroller.text) / 100;
        double imc = peso / (altura * altura);
        if (imc < 18.6) {
          _infoText = "Abaixo Do Peso IMC (${imc.toStringAsPrecision(3)})";
        }
        else if (imc >= 18.6 && imc < 24.9) {
          _infoText = "Peso Ideal IMC (${imc.toStringAsPrecision(3)})";
        }
        else if (imc >= 24.9 && imc < 29.9 ) {
          _infoText = "Levemente Acima do Peso IMC (${imc.toStringAsPrecision(3)})";
        }
        else if (imc >= 29.9 && imc < 34.9) {
          _infoText = "Obesidade Grau I IMC (${imc.toStringAsPrecision(3)})";
        }
        else if (imc >= 34.9 && imc < 39.9) {
          _infoText = "Obesidade Grau II IMC (${imc.toStringAsPrecision(3)})";
        }
        else if (imc >= 40) {
          _infoText = "Obesidade Grau III IMC (${imc.toStringAsPrecision(3)})";
        }
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculdora de IMC "),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _reset,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline,
                    size: 120.0, color: Colors.lightBlue),
                TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.lightBlue),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue, fontSize:  25.0),
                  controller: pesoConroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira Seu Peso!";
                    }
                  },
                ),
                TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.lightBlue),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue, fontSize:  25.0),
                  controller: alturaConroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira Sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Container (
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calcular();
                        }
                      },
                      child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.lightBlue,

                    ),
                  ),
                ),
                Text (_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                )

              ],
            ),
        ),
      ),
    );
  }
}
