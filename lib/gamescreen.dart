import 'package:flutter/material.dart';
import 'package:hangman/utils.dart';
import 'dart:math';
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  String word = wordlist[Random().nextInt(wordlist.length)];
  List guessedalphabets =[];
  int points=0;
  int status= 0 ;
  List images=[
    "images/hangman0.png",
    "images/hangman1.png",
    "images/hangman2.png",
    "images/hangman3.png",
    "images/hangman4.png",
    "images/hangman5.png",
    "images/hangman6.png",
  ];
  
opendialog(String title){
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height:180,
          decoration:BoxDecoration(color: Colors.purpleAccent),
          child: Column(
            children: [
              Text(title,style:retroStyle(25, Colors.white, FontWeight.bold),
            textAlign:TextAlign.center,),
            SizedBox(height: 5,),
            Text("Your points:$points",style:retroStyle(25, Colors.white, FontWeight.bold),
            textAlign:TextAlign.center,),
            Container(
              margin:EdgeInsets.only(top:20),
              width: MediaQuery.of(context).size.width/2,
              child: TextButton(onPressed: (){},child: Center(
                child:Text("Play Again")
              ),),
            )
            ],
          ),
        ),
      );
    },
  );

}
  handledtext(){
     String displayword="";
     for(int i=0;i<word.length;i++){
      String char=word[i];
      if(guessedalphabets.contains(char)){
        displayword+=char +" " ;
      }
      else{
        displayword +="? ";
      }
     }
     return displayword;
  }

  checkletter(String alphabet){
      if(word.contains(alphabet)){
        setState(() {
          
        guessedalphabets.add(alphabet);
        points += 5;
        });
      }else if(status!=6){
        setState(() {
          status +=1;
          points -=5;
        });
      }else{
        print("You lost");
        opendialog("You lost");
      }
      bool isWon =true;
        for(int i=0;i<word.length;i++){
      String char=word[i];
      if(!guessedalphabets.contains(char)){
       setState(() {
          isWon =false;
        });
        break;
      }
      if(isWon){
        print("Won");
      }
     }


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title:Text("HangMan",
        style:retroStyle(30,Colors.white,FontWeight.w700),
        ),
        actions: [
          IconButton(
          iconSize:40,
          onPressed: (){}, 
          color:Colors.purpleAccent,
          icon: Icon(Icons.volume_up_sharp))
        ],
        ),

        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child:Container(
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/3.5,
                decoration: BoxDecoration(
                  color:Colors.lightBlueAccent
                ),
                height: 30,
                child: Center(
                  child: Text("$points points",
                  style:retroStyle(15, Colors.black, FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Image(
                width: 155,
                height: 155,
                color: Colors.white,
                fit:BoxFit.cover,
                image:AssetImage(images[status]),
              ),
              SizedBox(height: 20,),
              Text(" ${7 -status}Lives left",style: retroStyle(15, Colors.grey, FontWeight.w700),
              ),
              SizedBox(height: 30,),
              Text(
                handledtext(),
                style:retroStyle(35,Colors.white,FontWeight.w700),
                textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding:EdgeInsets.only(left:10),
                  childAspectRatio:1.3,
                  children:letters.map((alphabet){
                    return InkWell(
                      onTap: ()=>checkletter(alphabet),
                      child:Center(
                        child: Text(
                          alphabet,
                          style: retroStyle(20, Colors.white, FontWeight.w700),
                        ),
                      ),
                      );
                       }).toList(),
          ),
          ],),
          ) ),
      );
  }
}