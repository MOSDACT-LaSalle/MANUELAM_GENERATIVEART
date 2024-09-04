/*---------------------------------
 Name: Manuela Montenegro
 Date: Sept 2024
 Tittle: Galaxytrip
 Description: 
 In representation of the galaxy, is like a small trip you take when the sun is shinning.

 -----------------------------------*/
float angle = 0; // Used for creating circular motion in the animation (angle)
float[] dotSizes; // (list) manipulate the size of the dots

void setup() { 
  size(1920, 1080); 
  background(0);    // color negro
  
  int gridSize = 35;  // amount of dots inside 
  int numDots = ((width - gridSize) / gridSize) * ((height - gridSize) / gridSize); // number of dots 
  dotSizes = new float[numDots];  // list
  
  // random size
  for (int i = 0; i < dotSizes.length; i++) { 
    dotSizes[i] = random(2, 50); // here i modify the size
  }
}

void draw() {
  background(0); 
  int gridSize = 35;
  float radius = 100; 
  
  int index = 0; 

  for (int x = gridSize; x <= width - gridSize; x += gridSize) {
    for (int y = gridSize; y <= height - gridSize; y += gridSize) {
      noStroke();
      
      // generate a small change of color for the dots to have more depth
      float noiseValue = noise(x * 0.06, y * 0.02);
      fill(200 * noiseValue, 90 * noiseValue, 200);
      
      // random size of the dots (big and small)
      dotSizes[index] += random(-0.4, 0.4);
      
      // range of size for dots
      dotSizes[index] = constrain(dotSizes[index], 2, 9);
      
      // oscillating movement for the dots
      float offsetY = sin(angle + x * 0.15) * 25; // wiigle vertically
      float offsetX = cos(angle + y * 0.10) * 25; // wiggle horizontaly
      
      // draw dots with their ellipse and position
      ellipse(x + offsetX, y + offsetY, dotSizes[index], dotSizes[index]);
      
      // circular motion using Perlin noise 
      float noiseFactor = noise(x * 0.02, y * 0.04, angle * 0.5); //control motion
      float circularOffsetX = radius * cos(angle + noiseFactor * TWO_PI);
      float circularOffsetY = radius * sin(angle + noiseFactor * TWO_PI);
      
      // Interaction with the mouse, calculate distance to the mouse
      float distanceToMouse = dist(x, y, mouseX, mouseY);
      
      // If the mouse is close, change the direction of the lines and their color
      if (distanceToMouse < 150) { // if the mouse is close to a dot, the line changes direction and color
        float angleToMouse = atan2(mouseY - y, mouseX - x);
        circularOffsetX += cos(angleToMouse) * 20; // Push the lines towards the mouse
        circularOffsetY += sin(angleToMouse) * 20; // Push the lines towards the mouse
        stroke(255, 100, 100, 150); // color of the line when the mouse is near
      } else {
        stroke(245, 200, 0, 100); //original line color
      }
      
      // starting point of the lines
      line(x + circularOffsetX, y + circularOffsetY, width / 2, height / 2);
      
      index++; // Move to the next dot
    }
  }
  
  angle += 0.01; // make it spin
}



  

  
   
 
 
 
 
 
 
 
 
 
