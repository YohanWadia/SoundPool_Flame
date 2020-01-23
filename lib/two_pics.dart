

import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flame_soundpool/page1.dart';

class TwoPics{

  final Page1 game;
  Rect rectTank, rectAcce;
  Sprite tank,acce;

  TwoPics(this.game) {
    rectTank = Rect.fromLTWH(100,game.screenSize.height-100,100,100);
    rectAcce = Rect.fromLTWH(250,game.screenSize.height-100 , 45, 100);
    tank = Sprite('tank.png');
    acce = Sprite('acce.png');
  }

  void render(Canvas c) {
    tank.renderRect(c, rectTank);
    acce.renderRect(c, rectAcce);
  }



}
