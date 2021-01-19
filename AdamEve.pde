//This code is based on the C3C3C6C6 tessellation code example from the Oogway library created by Jun HU

//Modifications have been made by Irina Bianca Serban, M1-1 student, Industrial Design, TU/e
//29-01-2018

//This example creates a tessellation of Adams and Eves

import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

//variable that is true when Adam si drawn
boolean adam = false;     

//sides and angles defining the shape
float AB = 100;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy;

////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(1920, 1200); 
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "AdamEve" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.right(150);

  o.setPosition(380, 5);
  tesselate(0.9);

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

//draw a tessellation with three rows and 5 columns
  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<5; j++) {
     //whenever there is an even column, make variable adam equal to true
     if(j%2 == 0){
      adam = true;
    } else {adam = false;}
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }
    o.popState();
    o.shift(vHeading, vDistance);
    if (i%2==0) o.shift(180+hHeading, hDistance);
  }
  
  o.popState();
  
  if(annotate) highlightGroup(scale);
}

//The method draws every shape; whenever variable adam is false, BD (body of Eve) is loaded; Whenever variable adam si true, BD2 (body of Adam) is loaded
void drawPiece(float scale) {
     fill(0,0,255);

  o.pushState();

  // Turn the arbitrary line AB around A by 120 degrees into the position AC.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //AC
  o.recall("A");
  o.left(120);
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Let D together with C and B form an equilateral triangle, which does not contain A.

  //BD
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.right(60);
  if(adam == false){
  o.pathForward(o.distance(Cx, Cy), "BD.svg"); 
  } else {o.pathForward(o.distance(Cx, Cy), "BD2.svg"); }
  Dx = o.xcor(); 
  Dy = o.ycor();

  //CD
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Dx, Dy));
  if(adam == false){
  o.pathForward(o.distance(Dx, Dy), "BD.svg"); 
  } else {o.pathForward(o.distance(Dx, Dy), "BD2.svg"); }
  o.popState();
  
  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.pushState();
  o.setPosition(Dx, Dy);
  hHeading = o.towards(Cx, Cy);
  hDistance = 2 * o.distance(Cx, Cy);
  o.popState();

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.pushState();
  o.setPosition(Dx, Dy);
  vHeading = o.towards(Cx, Cy);
  vDistance = 2 * o.distance(Cx, Cy);
  o.popState();  

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.popState();
}