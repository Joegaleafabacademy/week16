import processing.serial.*;

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



void setup() {
  size(1000, 300);
  // I know that the first port in the serial list on my mac
  // is always my FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  println(Serial.list());
  myPort = new Serial(this, "COM5", 9600);

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
    }
    //EXPERIMENT WITH THE VISUALIZATION BELOW
    background(322);             // Set background to white
    int scale = 10;
    rect (20,20,value,20);
  }
}