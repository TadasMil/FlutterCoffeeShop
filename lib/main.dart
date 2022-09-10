import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/pages/menupage.dart';
import 'package:coffee_masters/pages/offerspage.dart';
import 'package:coffee_masters/pages/orderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Greet extends StatefulWidget {
  const Greet({super.key});

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var name = '';

  @override
  Widget build(BuildContext context) {
    var greetStyle = const TextStyle(fontSize: 28);
    return Column(children: [
      Row(
        children: [
          Text("Hello $name", style: greetStyle),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            onChanged: (value) => setState(() {
                  name = value;
                })),
      )
    ]);
  }
}

class HellowWorld extends StatelessWidget {
  const HellowWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello World',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text('!!!');

    switch (selectedTabIndex) {
      case 0:
        currentWidgetPage = MenuPage(dataManager: dataManager);
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = OrderPage(dataManager: dataManager);
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Image.asset("images/logo.png"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          onTap: (index) {
            setState(() {
              selectedTabIndex = index;
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.yellow.shade400,
          unselectedItemColor: Colors.brown.shade50,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer), label: "Offers"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_checkout_outlined),
                label: "Order"),
          ],
        ),
        body:
            currentWidgetPage // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
