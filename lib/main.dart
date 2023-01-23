import 'dart:async';
import 'dart:convert';
//import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import  'package:intl/intl.dart';

var lineNum;
var targetQty;
var achievementQty;
var wipQty;
var hourNo;
var dhuValue;
var achieveEfficiencyVal;
var BuyerStyleName;
var buyerName;
var currentTime;
var currentDate;
var checkGarments;
var rejection;
//List<HourQtyDBModel> samplePosts = [];
//final _dbHourModel = <HourQtyDBModel>[];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Production App',
      theme: ThemeData(      
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.grey[700],
      ),
      home: const MyHomePage(title: 'Hourly Production'),
      color: Colors.grey[700],
    );
  }
}

class MyHomePage extends StatefulWidget {  
  const MyHomePage({super.key, required this.title});
  final String title;      

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
   List<HourQtyDBModel> samplePosts = [];
  @override
    void initState() {
    super.initState();
   getDashboardData();  
   getHourlyDashboardData(); 

   Timer.periodic(Duration(seconds: 10), (timer) { 
    setState(() {
      getDashboardData();
      getHourlyDashboardData();
    });
   });


   Timer.periodic(Duration(seconds: 1), (timer) { 
    setState(() {
      String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
      currentTime = tdata;
    });
   });
  } 

Future<List<HourQtyDBModel>> getHourlyDashboardData() async {
    samplePosts = [];
    final response = await http.get(
      Uri.parse('https://apps.bitopibd.com/BIMOBAppsCoreAPI/api/DailyProduction/DailyProductionLineHourWiseDashboard',),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePosts.add(HourQtyDBModel.fromJson(index));
      }
      return samplePosts;
    }
    else {
      return samplePosts;
    }
  }

 Future getDashboardData() async{
  String currentDateName = DateFormat("EE, dd, yyyy").format(DateTime.now());  
    final uri = Uri.parse('https://apps.bitopibd.com/BIMOBAppsCoreAPI/api/DailyProduction/DailyProductionLineWiseDashboard');

    http.Response response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
      
    List<DashboardDBModel> _dbModel = [];    

    for(var u in jsonData){
      DashboardDBModel _row = DashboardDBModel(u["lineNumber"],u["target"],u["achieveQuantity"],u["wip"],u["hourNo"],u["dhu"],u["achieveEfficiency"],u["styleName"],u["buyer"]);     
      setState(() {
          lineNum = u["lineNumber"];
          targetQty = u["target"];
          achievementQty = u["achieveQuantity"];
          wipQty = u["wip"];
          hourNo = u["hourNo"];
          dhuValue = u["dhu"];
          achieveEfficiencyVal = u["achieveEfficiency"];
          BuyerStyleName = u["styleName"];
          buyerName = u["buyer"];
          checkGarments = u["checkGarments"];
          rejection = u["rejection"];
          currentDate = currentDateName;
        });
       
      _dbModel.add(_row);
    }
    return _dbModel;
  }
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar( 
        toolbarHeight: 90,     
        title: Row(          
  children: <Widget>[
    Expanded(
      //child: Text("Style Name: "+ BuyerStyleName.toString(), style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center),      
      child: Column(                      
              children: [   
                Container(
                child: Text("Style Name", style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center), 
                ), 
                Container(
                 child: Text(BuyerStyleName.toString(), style: TextStyle(fontSize: 35.0, color: Colors.white), textAlign: TextAlign.center),
                 ),
              
            ]),
    ),
    Expanded(
      //child: Text("Buyer: "+ buyerName.toString(), style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center),
      child: Column(                      
              children: [   
                Container(
                child: Text("Buyer Name", style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center), 
                ), 
                Container(
                 child: Text(buyerName.toString(), style: TextStyle(fontSize: 35.0, color: Colors.white), textAlign: TextAlign.center),
                 ),
              
            ]),
    ),    
    Expanded(
      //child: Text("Line: "+ lineNum.toString(), style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center),
       child: Column(                      
              children: [   
                Container(
                child: Text("Line Number", style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center), 
                ), 
                Container(
                 child: Text(lineNum.toString(), style: TextStyle(fontSize: 35.0, color: Colors.white), textAlign: TextAlign.center),
                 ),
              
            ]),
    ),
    Expanded(
      //child: Text("Hour No: "+ hourNo.toString(), style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center),
      child: Column(                      
              children: [   
                Container(
                child: Text("Hour No", style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center), 
                ), 
                Container(
                 child: Text(hourNo.toString(), style: TextStyle(fontSize: 35.0, color: Colors.white), textAlign: TextAlign.center),
                 ),
              
            ]),
    ),
    Expanded(
      //child: Text("Hour No: "+ hourNo.toString(), style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center),
      child: Column(                      
              children: [   
                Container(
                child: Text("Production Date", style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center), 
                ), 
                Container(
                 child: Text(currentDate.toString(), style: TextStyle(fontSize: 35.0, color: Colors.white), textAlign: TextAlign.center),
                 ),
              
            ]),
    ),
  ],
),
        
      ),
      body: 
      Flex(
        direction: Axis.horizontal,        
        children: [
          Expanded(            
            child: Column(                      
              children: [   
                Container(
                child: Text(achievementQty.toString(), style: TextStyle(fontSize: 160.0, color: Colors.white), textAlign: TextAlign.center), 
                height: 150.0, 
                width: double.infinity,
                color: Colors.grey[700]
                ), 
                Container(
                 padding: const EdgeInsets.all(10),                
                 child: Text("Achieve Quantity", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 70.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),                                      
              Container(
                 child: Text(targetQty.toString(), style: TextStyle(fontSize: 160.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 150.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
                 Container(
                  padding: const EdgeInsets.all(10),    
                 child: Text("Target Quantity", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 50.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),                 
              
              Container(
                child: Text(achieveEfficiencyVal.toString(), style: TextStyle(fontSize: 160.0, color: Colors.white), textAlign: TextAlign.center), 
                height: 150.0,
                width: double.infinity, 
                color: Colors.grey[700]
                ),
              Container(
                padding: const EdgeInsets.all(10),    
                 child: Text("Achieve Efficiency", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 50.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
            ]),
          ),
          Expanded(            
            child: Column(                      
              children: [   
                Container(
                child: Text(wipQty.toString(), style: TextStyle(fontSize: 150.0, color: Colors.white), textAlign: TextAlign.center), 
                height: 150.0, 
                width: double.infinity,
                color: Colors.grey[700]
                ), 
                Container(
                  padding: const EdgeInsets.all(10), 
                 child: Text("Day Variance", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 80.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),                                      
              Container(
                 child: Text(dhuValue.toString(), style: TextStyle(fontSize: 150.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 150.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
                 Container(
                  padding: const EdgeInsets.all(10), 
                 child: Text("DHU(%)", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 80.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
              //    SizedBox(height: 10,),
              // Container(
              //    child: Text(currentDate.toString(), style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
              //    height: 40.0, 
              //    color: Colors.grey[700],
              //    width: double.infinity,
              //    ),
                 SizedBox(height: 30,),
              Container(
                child: Text(currentTime.toString(), style: TextStyle(fontSize: 100.0, color: Colors.white), textAlign: TextAlign.center), 
                height: 150.0,
                width: double.infinity, 
                color: Colors.grey[700],
                padding: EdgeInsets.all(15)
                ),
              
            ]),
          ),
          Expanded(
            child: Column(                      
              children: [   
                Container(
                 child: Text(rejection.toString(), style: TextStyle(fontSize: 150.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 150.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
                 Container(
                  padding: const EdgeInsets.all(10), 
                 child: Text("Today's Rejection", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 80.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),
                Container(
                child: Text(checkGarments.toString(), style: TextStyle(fontSize: 150.0, color: Colors.white), textAlign: TextAlign.center), 
                height: 150.0, 
                width: double.infinity,
                color: Colors.grey[700]
                ), 
                Container(
                  padding: const EdgeInsets.all(10), 
                 child: Text("Style WIP", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),  
                 height: 80.0, 
                 color: Colors.grey[700],
                 width: double.infinity,                                  
                 ),                                      
              
              
            ]),
            // child: ListView.builder(
            //   itemCount: samplePosts.length,
            //   itemBuilder: (context, index){               
            //     return Container(
            //     height: 48,
            //     color: Colors.grey[700],                
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 5,
            //       horizontal: 5,
            //     ),
                

            //     //margin: const EdgeInsets.all(8),

            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           'Hour No: ${samplePosts[index].hourNo}  Target Qty: ${samplePosts[index].target}   Achieve Qty: ${samplePosts[index].achieveQuantity}',
            //           style: const TextStyle(fontSize: 15, color: Colors.white)                      
            //         ),
            //       ],

            //     ),

            //   );
            //   },
            //   ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[700],
    );
    
  }
}

class DashboardDBModel{
 final int lineNumber = 0, target = 0,achieveQuantity=0,wip = 0,hourNo = 0,	dhu = 0,	achieveEfficiency = 0;
 final String styleName="",buyer="";	

 DashboardDBModel(lineNumber,target,achieveQuantity,wip,hourNo,dhu,achieveEfficiency,styleName,buyer);

}

//class HourQtyDBModel{
 //final int hourNo = 0, target = 0,achieveQuantity=0;
 //HourQtyDBModel(hourNo,target,achieveQuantity);
//}

List<HourQtyDBModel> samplePostsFromJson(String str) => List<HourQtyDBModel>.from(json.decode(str).map((x) => HourQtyDBModel.fromJson(x)));
String samplePostsToJson(List<HourQtyDBModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HourQtyDBModel {

    HourQtyDBModel({
        required this.hourNo,
        required this.target,
        required this.achieveQuantity
    });

    int hourNo;
    int target;
    int achieveQuantity;

    factory HourQtyDBModel.fromJson(Map<String, dynamic> json) => HourQtyDBModel(
        hourNo: json["hourNo"],
        target: json["target"],
        achieveQuantity: json["achieveQuantity"]
    );

    Map<String, dynamic> toJson() => {
        "hourNo": hourNo,
        "target": target,
        "achieveQuantity": achieveQuantity
    };

}