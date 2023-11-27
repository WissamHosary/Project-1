import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CoinGeckoApi api = CoinGeckoApi();
  double? bitcoinPrice;
  double? bitcoinPrice2;
  double? bitcoinPrice3;

  @override
  void initState() {
    super.initState();
    getBitcoin();
  }

  Future<void> getBitcoin() async {
    final marketChart = await api.coins.getCoinMarketChart(
      id: 'bitcoin',
      vsCurrency: 'usd',
      days: 1,
    );
    final marketChart2 = await api.coins.getCoinMarketChart(
      id: 'ethereum',
      vsCurrency: 'usd',
      days: 1,
    );
    final marketChart3 = await api.coins.getCoinMarketChart(
      id: 'dogecoin',
      vsCurrency: 'usd',
      days: 1,
    );
    if (!marketChart.isError) {
      setState(() {
        bitcoinPrice = marketChart.data.first.price;
      });
      if (!marketChart2.isError) {
        setState(() {
          bitcoinPrice2 = marketChart2.data.first.price;
        });
      }
      if (!marketChart3.isError) {
        setState(() {
          bitcoinPrice3 = marketChart3.data.first.price;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Crypto prices'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/bitcoin.jpeg",
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text('Bitcoin'),
                  ],
                ),
                trailing: bitcoinPrice == null
                    ? const CircularProgressIndicator()
                    : Text('\$$bitcoinPrice'),
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/etherium.png",
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    const Text('Ethereum'),
                  ],
                ),
                trailing: bitcoinPrice2 == null
                    ? const CircularProgressIndicator()
                    : Text('\$$bitcoinPrice2'),
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/dogecoin.jpeg",
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    const Text('DogeCoin'),
                  ],
                ),
                trailing: bitcoinPrice3 == null
                    ? const CircularProgressIndicator()
                    : Text('\$$bitcoinPrice3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
