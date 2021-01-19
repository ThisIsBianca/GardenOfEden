//the intro was not drawn anymore

//Method drawArrow draws the body features of the shapes; "arrow" contains the body features of Eve, while "arrow2" contains the body features of Adam

void drawArrow(float scale) {
  o.pushState();
 fill(0,0,255);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4 );
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(180+o.towards(Ax, Ay));
  if (o.isReflecting()) {
    if(adam == false){
    o.setStamp("arrow.svg");}
    else {o.setStamp("arrow2.svg");}
  }
  else {
     if(adam == false){
    o.setStamp("arrow.svg");}
    else {o.setStamp("arrow2.svg");}

  }
  
  o.stamp(80*scale, 230*scale);

  o.popState();
} 


void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,0);
  
  drawPoint("A", Ax, Ay, 0, -20);
  drawPoint("B", Bx, By, -15, 0);  
  drawPoint("C", Cx, Cy, 15, 0);  
  drawPoint("D", Dx, Dy, 0, 15);  


  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}

void highlightGroup(float scale){
  o.pushState();
  o.setPenColor(0,0,0);
  groupPositions(scale);
  o.popState();
}

void showGrid(){
  pushStyle();
  stroke(128);
  float x = 0, y = 0;
  fill(128);
  textFont(font,16);
  while(y<height){
    y +=100;
    text((int)y, 10, y );
    text((int)y, width-40, y );
    line(0, y, width, y);    
  }
  while(x<width){
    x+=100;
    text((int)x, x, 20 );
    text((int)x, x, height-15 );
    line(x, 0, x, height);
  }
  popStyle();
}