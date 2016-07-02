import processing.serial.*;
import controlP5.*;

Serial myPort;  // Create object from Serial class
int value;      // Data received from the serial port
int sensorData; // Data received from the serial port with 1,2,3,4 framing numbers filtered out

int up_low = 0;
int up_high = 0;
int down_low = 0;
int down_high = 0;
int up_value = 0;
int down_value = 0;

int byte1 = 0;
int byte2 = 0;
int byte3 = 0;
int byte4 = 0;

ControlP5 cp5;

int myColorBackground = color(0,0,0);
int knobValue = value;
float remap = 0;




Knob myKnobB;

void setup() {
  size(700,700);
  smooth();
  noStroke();
  // I know that the first port in the serial list on my mac
  // is always my FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  println(Serial.list());
  myPort = new Serial(this, "COM4", 9600);
  
   
  
   
      
              
      
               
}



void draw()
{
  while (myPort.available() > 0) {    // If data is available
    byte1 = byte2;
    byte2 = byte3;
    byte3 = byte4;
    byte4 = up_low;
    up_low = up_high;
    up_high = down_low;
    down_low = down_high;
    down_high = myPort.read();

    if ((byte1 == 1) & (byte2 == 2) & (byte3 == 3) & (byte4 == 4)){                // Filter out the framing numbers: 1,2,3,4
       up_value = 256*up_high + up_low;
       down_value = 256*down_high + down_low;
       value = (up_value - down_value);
       
     

       println("THE VALUE IS " + value); //print to the screen
       
      remap = map(value, 6800, 15700, 0, 10); //this is where you place the remapped vaulues
       
     
    }
    
    
  
  
}
{
    cp5 = new ControlP5(this);
    
    
    
  for(float knobValue = remap; knobValue < 20; knobValue = 20) {
      if (knobValue > 3) {
        
  myKnobB = cp5.addKnob("volume (ml)")
               .setRange(0,10) //minimum amount of liquid vs max in cubic mm
               .setValue(remap)
               .setPosition(150,150)
               .setRadius(200)
               .setNumberOfTickMarks(80)
               .setTickMarkLength(8)
               .snapToTickMarks(true)
               .setColorForeground(color(0, 204, 0))
               .setColorBackground(color(64, 64, 64))
               .setColorActive(color(0, 204, 0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
               
      } else if (knobValue < 3) {
        myKnobB = cp5.addKnob("volume (mm^3)")
               .setRange(0,10)
               .setValue(remap)
               .setPosition(150,150)
               .setRadius(200)
               .setNumberOfTickMarks(80)
               .setTickMarkLength(8)
               .snapToTickMarks(true)
               .setColorForeground(color(255, 0, 0))
               .setColorBackground(color(64, 64, 64))
               .setColorActive(color(255, 0, 0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
               
      }
  }
}
}