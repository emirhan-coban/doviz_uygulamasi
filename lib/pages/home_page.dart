import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _currencyRates = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrencyRates();
  }

  Future<void> _fetchCurrencyRates() async {
    const url = 'https://finans.truncgil.com/today.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        setState(() {
          _currencyRates = {
            'DolarAlış': data['USD']['AlÄ±Å'],
            'Dolar':
                "Alış: ${data['USD']['AlÄ±Å']}\nSatış: ${data['USD']['SatÄ±Å']}",
            'Euro':
                "Alış: ${data['EUR']['AlÄ±Å']}\nSatış: ${data['EUR']['SatÄ±Å']}",
            'Sterlin':
                "Alış: ${data['GBP']['AlÄ±Å']}\nSatış: ${data['GBP']['SatÄ±Å']}",
            'Gram Altın':
                "Alış: ${data['gram-altin']['AlÄ±Å']}\nSatış: ${data['gram-altin']['SatÄ±Å']}",
          };
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load currency rates');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Döviz Kurları',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SFPro",
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ),
      body: _isLoading
          ? const CircularProgressIndicator()
          : Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "DOLAR",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 5,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              _currencyRates['Dolar'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "SFPro",
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "EURO",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 5,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              _currencyRates['Euro'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "SFPro",
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "STERLİN",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 5,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              _currencyRates['Sterlin'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "SFPro",
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "GRAM ALTIN",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "SFPro",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 4,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              _currencyRates['Gram Altın'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "SFPro",
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
