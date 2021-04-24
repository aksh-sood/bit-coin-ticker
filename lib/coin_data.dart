import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  // CoinData({@required this.crypto,@required this.country});




 Future getInfo(crypto ,country)async{
   final url="https://rest.coinapi.io/v1/exchangerate/$crypto/$country?apikey=6D2AE5E1-449B-4853-B6CD-39583F8C97B2";
   var urlParse = Uri.parse(url);
http.Response response=await http.get(urlParse);
if (response.statusCode == 200) {
  var data = response.body;
  var decodedData=jsonDecode(data);

  return decodedData["rate"];

} else if (response.statusCode == 404) {
  return (response.statusCode);
}
 }
}
