import 'package:flutter/material.dart';
import 'package:todoapp/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Todo List Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> lsTodo = [];
  TextEditingController txtTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: lsTodo.isEmpty
          ? const Center(child: Text("Todo List has not been created"))
          : ListView.builder(
              itemCount: lsTodo.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      lsTodo[index].active = !lsTodo[index].active;
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.lightBlue,
                              height: 30,
                              width: 30,
                              child: Center(
                                  child: Text(
                                lsTodo[index]
                                    .activity!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          lsTodo[index].active
                              ? Text(
                                  lsTodo[index].activity!,
                                  style: const TextStyle(fontSize: 15),
                                )
                              : Text(
                                  lsTodo[index].activity!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                )
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Todo List'),
                  content: TextField(
                    controller: txtTodo,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Todo toDo =
                                Todo(activity: txtTodo.text, active: true);
                            lsTodo.add(toDo);
                            Navigator.pop(context);
                            txtTodo.clear();
                          });
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
