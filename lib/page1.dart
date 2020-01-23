
import 'dart:typed_data';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_soundpool/two_pics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Page1 extends Game{
  Size screenSize;
  TwoPics imgs;
  Soundpool pool;
  int engineId, shotId,engineStream;
  double myRate=0.5, incRate=0.005;
  bool accePressed=false, longShot=false;

  Page1(){
    startInit();
  }
  void startInit() async{
    screenSize = await Flame.util.initialDimensions();
    imgs = TwoPics(this);
    getSoundPoolReady();
  }

  void getSoundPoolReady() async{
    pool = Soundpool(streamType: StreamType.notification, maxStreams: 4 );
    engineId = await rootBundle.load('assets/sounds/engine.ogg').then((ByteData soundData) {
      return pool.load(soundData);
    });
    engineStream = await pool.play(engineId,repeat: -1,rate:myRate);

    shotId = await rootBundle.load('assets/sounds/fire.mp3').then((ByteData soundData) {
      return pool.load(soundData);
    });

    print('$engineId...$engineStream');
    print('$shotId...');
  }


  @override
  void render(Canvas canvas) {
    imgs.render(canvas);
  }

  @override
  void update(double t) {
    if(accePressed && myRate<1.995){
      myRate+=incRate;
      pool.setRate(streamId:engineStream, playbackRate: myRate);
    }
    if(accePressed==false && myRate>0.505){
      myRate-=incRate;
      pool.setRate(streamId:engineStream, playbackRate: myRate);
    }
  }




  void onTapDown(TapDownDetails d) {
    if(imgs.rectAcce.contains(d.globalPosition)){
      accePressed=true;
    }
    else if(imgs.rectTank.contains(d.globalPosition)){
      longShot= !longShot;
      if(longShot) {
        pool.play(shotId,repeat: 0,rate:1.0);
      }
      else{
        pool.play(shotId,repeat: 0,rate:2.0);
      }
    }
  }

  void onTapUp(TapUpDetails d) {
    if(imgs.rectAcce.contains(d.globalPosition)){
      accePressed=false;
    }
  }




}