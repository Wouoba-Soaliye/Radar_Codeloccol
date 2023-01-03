
#include <Servo.h>. 
#include <DHT.h>

#define DHTPIN 8
#define DHTTYPE DHT22

DHT dht(DHTPIN, DHTTYPE);

// Defines Tirg and Echo pins of the Ultrasonic Sensor
const int trigPin = 5;//orange
const int echoPin = 2;//red white - vcc grey -gnd
// Variables for the duration and the distance
long duration;
int distance;
Servo myServo; // Creates a servo object for controlling the servo motor
void setup() {
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  Serial.begin(9600);
  myServo.attach(9); // Defines on which pin is the servo motor attached on 9 purple
  dht.begin();
}
void loop() {
  
  // rotates the servo motor from 15 to 165 degrees
  for(int i=0;i<=180;i++){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    Serial.print(i); // Sends the current degree into the Serial Port
    Serial.print(","); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
    Serial.print(distance); // Sends the distance value into the Serial Port
    Serial.print("A"); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
    Serial.print(String(dht.readTemperature())+ ";");
    Serial.print(String(dht.readHumidity())+ ":");
  }
  
  //Repeats the previous lines from 165 to 15 degrees
  for(int i=180;i>0;i--){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print("A");
    Serial.print(String(dht.readTemperature())+ ";");
    Serial.print(String(dht.readHumidity())+ ":");
  } 

  

}
// Function for calculating the distance measured by the Ultrasonic sensor
int calculateDistance(){ 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(2);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // Reads the echoPin, returns the sound wave travel time in microseconds
  distance= (duration*0.034)/2;
  return distance;    
}