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
            'Dolar':
                "Alış: ${data['USD']['AlÄ±Å']}\nSatış: ${data['USD']['SatÄ±Å']}",
            'Euro':
                "Alış: ${data['EUR']['AlÄ±Å']}\nSatış: ${data['EUR']['SatÄ±Å']}",
            'Sterlin':
                "Alış: ${data['GBP']['AlÄ±Å']}\nSatış: ${data['GBP']['SatÄ±Å']}",
            'Gram Altın':
                "Alış: ${data['gram-altin']['AlÄ±Å']}\nSatış: ${data['gram-altin']['SatÄ±Å']}",
            'Dolar Değişim': data['USD']['DeÄiÅim'],
            'Euro Değişim': data['EUR']['DeÄiÅim'],
            'Sterlin Değişim': data['GBP']['DeÄiÅim'],
            'Gram Altın Değişim': data['gram-altin']['DeÄiÅim'],
            'Saat': data['Update_Date'],
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
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 20, top: 0),
              child: Column(
                children: [
                  // güncel saat
                  Container(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Son Güncelleme: ${_currencyRates['Saat']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final key = _currencyRates.keys.elementAt(index);
                        final value = _currencyRates[key];
                        return ListTile(
                          leading: Image.asset(
                            'assets/images/$key.png',
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            key,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            value.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            _currencyRates['$key Değişim'].toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: _currencyRates['$key Değişim']
                                        .toString()
                                        .contains('-')
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
