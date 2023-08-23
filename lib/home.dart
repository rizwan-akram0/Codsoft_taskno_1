import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashlight app"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Flashlight",
              style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (check == false) {
                  try {
                    TorchLight.enableTorch();
                    // isOn = true;
                  } on EnableTorchNotAvailableException catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Flashlight not available!")));
                  } on EnableTorchException catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Flashlight can't be turned on!")));
                  }
                } else {
                  try {
                    TorchLight.disableTorch();
                    // isOns = false;
                  } on DisableTorchNotAvailableException catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Flashlight not available!")));
                  } on DisableTorchException catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Flashlight can't be turned off!")));
                  }
                }
                setState(() {
                  check = !check;
                  if (check == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Flashlight is on!")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Flashlight is off!")));
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
              ),
              child: check
                  ? const Text("OFF", style: TextStyle(fontSize: 32))
                  : const Text(
                      "ON",
                      style: TextStyle(fontSize: 32),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
