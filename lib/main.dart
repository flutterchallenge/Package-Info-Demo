import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Package Info Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState(){
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoCard(IconData icon, String title, String subtitle) {
    return Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(icon, size: 25),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Welcome to flutterchallenge.com',
              style: TextStyle(
                  fontSize: 18.0
              ),
            ),
            Divider(
                color: Colors.black
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Divider(
                      color: Colors.black
                  ),
                  Text(
                      "Package Information",
                      style: TextStyle(
                          fontSize: 20.0
                      )
                  ),
                  _infoCard(Icons.android, _packageInfo.appName.toString(), 'App Name'),
                  _infoCard(Icons.info, _packageInfo.packageName.toString(), 'Package Name'),
                  _infoCard(Icons.format_list_numbered, _packageInfo.version.toString(), 'Version'),
                  _infoCard(Icons.confirmation_number, _packageInfo.buildNumber.toString(), 'Build Number'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
