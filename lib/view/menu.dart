// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import '../model/fretes.dart';
import '../model/credencial.dart';

const List<String> droplisteixo = <String>['2', '3', '4', '5', '6', '7', '9'];
const List<String> droplistfrete = <String>[
  'Lotação',
  'Somente Automotor',
  'Lotação - Auto Desempenho',
  'Somente Automotor - Alto Desempenho'
];
const List<String> droplistcarga = <String>[
  'Carga Geral',
  'Granel Sólido',
  'Granel Líquido',
  'Frigorificada',
  'Conteinerizada',
  'Neogranel',
  'Perigosa (Granel Sólido)',
  'Perigosa (Granel Líquido)',
  'Perigosa (Carga Frigorificada)',
  'Perigosa (Containerizada)',
  'Perigosa (Carga Geral)',
  'Carga Granel Pressurizada'
];

class MenuView extends StatefulWidget {
  MenuView({Key? key}) : super(key: key);
  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String dropdownValueEixo = droplisteixo.first;
  String dropdownValueFrete = droplistfrete.first;
  String dropdownValueCarga = droplistcarga.first;

  bool box1 = false;
  bool box2 = false;

  List<loginSenha> usuarios = [];
  var usu = loginSenha("admin@gmail.com", "admin", "Pedro", "(19)999999999");

  var pageIndex = 0;
  var pageController = PageController(); //faz a troca

  List<fretesRealizados> fretes = [];
  var index;
  var origem = TextEditingController();
  var destino = TextEditingController();
  var distancia = TextEditingController();
  var eixos = TextEditingController();
  var tipoFrete = TextEditingController();
  var tipoCarga = TextEditingController();
  var custo = TextEditingController();

  @override
  void initState() {
    index = 0;

    fretes.add(fretesRealizados('São Paulo', 'Rio de Janeiro', '400', 'Granel',
        'Líquido', '3', '1', '0', '1000'));
    fretes.add(fretesRealizados('Belo Horizonte', 'Goiania', '400', 'Granel',
        'Líquido', '3', '1', '0', '1000'));
    fretes.add(fretesRealizados('Salvador', 'Fortaleza', '400', 'Granel',
        'Líquido', '3', '1', '0', '1000'));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bem Vindo: ${usu.nome}'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('FECAM SP'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: PageView(
        controller: pageController,
        children: [
          Expanded(
            flex: 1,
            child: calculo(),
          ),
          Expanded(
            flex: 1,
            child: lista(),
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      //BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex, // quem está exibindo no momento
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: [
          //Vetor com os items da NavBar
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Calcular Frete'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Lista de Fretes'),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }

  calculo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Cálculo de Frete',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),

          //TextField Origem
          TextField(
            controller: origem,
            decoration: InputDecoration(
              labelText: 'Origem',
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(),
              prefixIcon: IconButton(
                onPressed: () {
                  //Vai para o Mapa
                  Navigator.pushNamed(
                    context,
                    'mapa',
                  );
                },
                icon: Icon(Icons.location_pin),
              ),
            ),
          ),
          SizedBox(height: 10),

          //TextField Destino
          TextField(
            controller: destino,
            decoration: InputDecoration(
              labelText: 'Destino',
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: IconButton(
                onPressed: () {
                  //Vai para o Mapa
                  Navigator.pushNamed(
                    context,
                    'mapa',
                  );
                },
                icon: Icon(Icons.location_pin),
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),

          //TextField Distancia
          TextField(
            controller: distancia,
            decoration: InputDecoration(
              labelText: 'Distancia',
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(Icons.map),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),

          //Dropdown Eixos
          Row(children: [
            Expanded(
              flex: 8,
              child: Text('Número de Eixos: ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Flexible(
              flex: 2,
              child: DropdownButton<String>(
                style: TextStyle(fontSize: 18),
                iconSize: 40,
                value: dropdownValueEixo,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.blue.shade900,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValueEixo = value!;
                  });
                },
                items:
                    droplisteixo.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ]),
          SizedBox(height: 10),

          Text('Tipo de Frete: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          //DropDown Frete
          Row(
            children: [
              Flexible(
                child: DropdownButton<String>(
                  style: TextStyle(fontSize: 18),
                  iconSize: 40,
                  value: dropdownValueFrete,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.blue.shade900,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValueFrete = value!;
                    });
                  },
                  items: droplistfrete
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          Text(
            'Tipo de Carga: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child:
                    //DropDown Carga
                    DropdownButton<String>(
                  style: TextStyle(fontSize: 20),
                  iconSize: 40,
                  value: dropdownValueCarga,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.blue.shade900,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValueCarga = value!;
                    });
                  },
                  items: droplistcarga
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          //Ida e Volta
          Row(
            children: [
              Checkbox(
                value: box1,
                onChanged: (value) {
                  setState(() {
                    box1 = value!;
                    if (!box1) {
                      box2 = false;
                    }
                  });
                },
                activeColor: Colors.blue.shade900,
                checkColor: Colors.white,
              ),
              Text('Ida e Volta'),
              //Retorno Vazio
              Checkbox(
                value: box2,
                onChanged: box1
                    ? (value) {
                        setState(() {
                          box2 = value!;
                        });
                      }
                    : null,
                activeColor: Colors.blue.shade900,
                checkColor: Colors.white,
                tristate: !box1,
              ),
              Text('Retorno Vazio'),
            ],
          ),
          SizedBox(height: 5),

          //Confirma Button
          ElevatedButton(
            onPressed: () {},
            //Conteudo
            child: Text('Calcular', style: TextStyle(fontSize: 24)),
            //ButtonStyle
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              minimumSize: Size(200, 50),
            ),
          ),
        ],
      ),
    );
  }

  lista() {
    return ListView.builder(
        padding: EdgeInsets.all(20),
        //definiar a quantidade de elementos
        itemCount: fretes.length,

        //Definir a aparencia dos elementos
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              //Icone do lado direito
              leading: Icon(Icons.map),
              title: Text('${fretes[index].origem} - ${fretes[index].destino}'),
              subtitle: Text('Distancia: ${fretes[index].distancia} Km'),
              //Icone do lado esquerdo (Botao de Remover)
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  //Remover
                  setState(() {
                    fretes.removeAt(index);
                  });
                  mensagem('Frete apagado com sucesso!');
                },
              ),

              //On Tap
              onTap: () {
                setState(() {
                  //Pega a posição selecionada na lista
                  this.index = index;
                  origem.text = fretes[index].origem;
                  destino.text = fretes[index].destino;
                  distancia.text = fretes[index].distancia;
                });
              },

              //Alterar a cor do item selecionado
              tileColor:
                  (this.index == index) ? Colors.blue.shade400 : Colors.white,
            ),
          );
        });
  }

  mensagem(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(msg),
    ));
  }
}
