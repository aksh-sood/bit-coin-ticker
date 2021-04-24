import 'dart:ffi';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedCountry="AUD";
List<String>prices=[];
bool isWaiting=false;

  Widget getPicker(){
    if(Platform.isAndroid){
      return DropdownButton<String>(
        style: TextStyle(color: Colors.white),
        value: selectedCountry,
        icon: Icon(Icons.arrow_downward_rounded, color: Colors.grey),
        underline: Container(
          height: 2,

          color: Colors.grey,
        ),
        onChanged: (value) {
          setState(() {
            print(value);
            selectedCountry = value;
            print("this is dropdown value $selectedCountry");
            prices=[];
            getData('BTC',selectedCountry);
            getData('ETH',selectedCountry);
            getData('LTC',selectedCountry);

          });
        },
        items:currenciesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }else{
return CupertinoPicker(itemExtent: 35,
  onSelectedItemChanged: (selectedIndex){
  print(selectedIndex);
  selectedCountry=currenciesList[selectedIndex];
print(selectedCountry);
prices=[];
getData('BTC',selectedCountry);
  getData('ETH',selectedCountry);
  getData('LTC',selectedCountry);
},
  children:currenciesList.map<Text>((String value) {
    return Text(
      value,
      style: TextStyle(color: Colors.white),
    );
  }).toList(),
  looping: true,);
    }
  }


  String bitvalue='?';


 void getData(state, String selectedCountry)async{
isWaiting=true;
  try{
    var data=await CoinData().getInfo(state,selectedCountry);
    isWaiting=false;
    setState(() {
      bitvalue=data.toStringAsFixed(0);

      prices.add(bitvalue);
    });
  }catch(e){
    print(e);
  }
}
  @override
  void initState() {

    super.initState();

getData("BTC","AUD");
    getData('ETH','AUD');
    getData('LTC','AUD');

  }



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 ${cryptoList[0]} = ${isWaiting ? '?' :prices[0]} $selectedCountry",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 ${cryptoList[1]} = ${isWaiting ? '?' :prices[1]} $selectedCountry",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 ${cryptoList[2]} = ${isWaiting ? '?' :prices[2]} $selectedCountry",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(

            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Center(
              child: getPicker(),
            )
          ),
        ],
      ),
    );
  }
}

