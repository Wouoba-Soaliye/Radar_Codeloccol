import processing.serial.*;
Serial myPort;

PFont font, fnt;

String data = "";
String angle = "";
String distance = "";
String temperature = "";
String humidity = "";

int index1 = 0;
int index2 = 0;
int index3 = 0;

int iAngle;
int iDistance;
float pixDistance;
float iTemp;
float iHumid;
float tempera;
float humida;

int iT=0;
String sT;

int[] tempVals;
int[] humiVals;


void setup(){
  size(700, 1024);
  smooth(8);
  background(888);
  font = createFont("Technopollas.otf", 20);
  fnt = createFont("ExpletusSans-VariableFont_wght.ttf", 10);

  
  myPort = new Serial(this,"/dev/cu.usbserial-1440", 9600);
  myPort.bufferUntil(':');
  body();
  
  tempVals = new int[470];
  humiVals = new int[470];
  
  pixDistance = iDistance*5;
}

void draw(){
  radar();
  texto();
  
  //object();
  drawLine();
  object();
  movem();
  
  drawTemp();
  textTemp();
  temp();
}



void serialEvent (Serial myPort) { // starts reading data from the Serial Port
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil(':');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(",");
  index2 = data.indexOf("A");
  index3 = data.indexOf(";");
  
  angle= data.substring(0, index1);
  distance = data.substring(index1+1, index2);
  temperature = data.substring(index2+1, index3);
  humidity= data.substring(index3+1, data.length());
  
  // converts the String variables into Integer
  iAngle = int(angle);
  iDistance = int(distance);
  iTemp = float(temperature);
  iHumid = float(humidity);
}


void textTemp(){
  pushMatrix();
  translate(500, 900);
  fill(222);

  for(int i=0; i>= -600; i -= 30){
    iT = i/6;
    text(iT, 5, i+4);
  }
  for(int i=0; i>= -600; i -= 30){
    iT = i/6;
    text(iT, 5, i+4);
  }
  for(int i=0; i>= -470; i -= 40, iT -= 1){
    //iT = i/6;
    text(iT+100, i-10, 15);
  }
  
  popMatrix();
}
void drawTemp(){
  pushMatrix();
  translate(500, 900);
  line(0, 0, 0, -600);
  line(0, 0, -470, 0);
  
  

  // Tracer d'echelle 5°C
  for(int i=0; i>= -600; i -= 30){
    line(-5, i, 5, i);
  }
  // Tracer d'echelle 1°C
  for(int i=0; i>= -600; i -= 6){
    line(-3, i, 3, i);
  }
  // Tracer d'echelle Temp 1s
  for(int i=0; i>= -470; i -= 40){
    line(i, -5, i, 5);
  }
  popMatrix();
}
void temp(){
  pushMatrix();
  translate(30, 900);
  noFill();
  //rect(0, 15, 500, -265);
  tempera = iTemp*(-6);
  humida = iHumid*(-6);
  //line(0, tempera, -100, tempera);
  //stroke(30,0,60);
  //line(0, humida, -100, humida);
  
  for(int i=1; i<470; i++){
    tempVals[i-1] = tempVals[i];
    humiVals[i-1] = humiVals[i];
  }
  tempVals[470-1] = int(tempera);
  humiVals[470-1] = int(humida);

  for(int i=1; i<470; i+=2){
    //background(888);
    stroke(#FF3200);
    point(i, tempVals[i]);
    stroke(#FF00ED);
    point(i, humiVals[i]);
  }
  
  popMatrix();
}


void object(){
  pushMatrix();
  translate(470, 225);
  stroke(255,10,10);
  pixDistance = iDistance*5; // covers the distance from the sensor from cm to pixels
  if(iDistance<40){
  line(pixDistance*cos(radians(iAngle)),-pixDistance*sin(radians(iAngle)),150*cos(radians(iAngle)),-150*sin(radians(iAngle)));
  }
  popMatrix();
}

void body(){
  fill(222);
  line(10, 30, (width/2)-120, 30);
  line((width/2)-120, 30, (width/2)-100, 10);
  line((width/2)-100, 10, (width/2)+100, 10);
  line((width/2)+100, 10, (width/2)+120, 30);
  line((width/2)+120, 30, width-20, 30);
  line(width-20, 30, width-20, 800);
  line(width-20, 800, width-10, 820);
  line(width-10, 820, width-10, 900);
  line(width-10, 900, width-20, 920);
  line(width-20, 920, width-20, 950);
  line(width-20, 950, width-250, 950);
  line(width-250, 950, width-290, 1000);
  line(width-290, 1000, width-650, 1000);
  line(width-650, 1000, 10, 950);
  line(10, 950, 10, 400);
  line(10, 400, 30, 370);
  line(30, 370, 30, 170);
  line(30, 170, 10, 150);
  line(10, 150, 10, 30);
  textFont(font);
  text("Processing", width-250, height-50);
  text("..........................", width-270, 1000);
  text("Dashboard", 255, 30);
}
void radar(){
  pushMatrix();
  translate(470, 225);
  stroke(1);
  //stroke(98,245,31);
  stroke(3, 4, 5);
  noFill();
  line(-150, 0, 150, 0);
  arc(0,0,300,300,PI,TWO_PI);
  arc(0,0,200,200,PI,TWO_PI);  
  arc(0,0,100,100,PI,TWO_PI);
  
  line(0,0,150*cos(radians(30)),-150*sin(radians(30)));
  line(0,0,150*cos(radians(60)),-150*sin(radians(60)));
  line(0,0,150*cos(radians(90)),-150*sin(radians(90)));
  line(0,0,150*cos(radians(120)),-150*sin(radians(120)));
  line(0,0,150*cos(radians(150)),-150*sin(radians(150)));
  popMatrix();
}
void texto(){
  pushMatrix();
  translate(470, 225);
  textSize(10);
  fill(211);
  smooth(20);
  text("10", 42, 10);
  text("20", 92, 10);
  text("30", 142, 10);
  //rotate(radians(10));
  text("0°",160*cos(radians(0)),-160*sin(radians(0)));
  text("30°",160*cos(radians(30)),-160*sin(radians(30)));
  text("60°",160*cos(radians(60)),-160*sin(radians(60)));
  text("90°",160*cos(radians(90)),-160*sin(radians(90)));
  text("120°",160*cos(radians(130)),-160*sin(radians(120)));
  text("150°",165*cos(radians(160)),-160*sin(radians(150)));
  text("180°",178*cos(radians(180)),-160*sin(radians(180)));
  
  popMatrix();
}
void movem(){
  pushMatrix();
  translate(280, 245);
  noStroke();
  fill(0, 2);
  rect(0, 0, 380, -190); 
  
  fill(0, 9);
  translate(-250, 45);
  rect(0, 0, 500, 630);
  stroke(30,250,60);
  popMatrix();
}
void drawLine() {
  pushMatrix();
  translate(470, 225);
  stroke(30,250,60);
  line(0,0,155*cos(radians(iAngle)),-155*sin(radians(iAngle)));// 155*cos....
  popMatrix();
}
