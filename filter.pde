String name;
PImage img;
PImage img2;
float keys = 0;
boolean done = false;
boolean done2 = false;
boolean original;
slider slider1;

void setup(){
  name = "rainbowHex.jpg";
  surface.setResizable(true);
  img = loadImage(name);
  
  surface.setSize(int(img.width-1), int(img.height-1));
  img2 = loadImage(name);
  slider1 = new slider(img.width/2, img.height-50, width-200, 50);
}

void draw(){
  choosePic();
  slider1.update();
  //slider1.display();
}
void choosePic(){
  if(keys == 0){
    background(0);
    image(img,-1,-1);
  }
  if(keys == 1){
    background(255);
    greyscale();
  }
  if(keys == 2){
    background(255);
    contrast();
  }
  if(keys == 3){
    background(255);
    blur();
  }
  if(keys == 4){
    background(255);
    edge();
  }
  if(keys == 5){
    background(255);
    sharpen();
  }
  if(keys == 6){
    sharpen();
    edge();
    myTint();
  }
  if(keys == 7){
    triangleblur();
  }
  if(keys == 8){
    triangles2();
  }
}

void keyPressed(){
  if(key == SHIFT){
    original = true;
  }
  if(key == CONTROL){
    original = false;
  }
  if(key == '0'){
    keys = 0;
  }
  if(key == '1'){
    keys = 1;
  }
  if(key == '2'){
    keys = 2;
  }
  if(key == '3'){
    keys = 3;
  }
  if(key == '4'){
    keys = 4;
  }
  if(key == '5'){
    keys = 5;
  }
  if(key == '6'){
    keys = 6;
  }
  if(key == '7'){
    done = false;
    keys = 7;
  }
  if(key == '8'){
    done2 = false;
    keys = 8;
  }
}

void sharpen(){
  colorMode(RGB);
  img.loadPixels();
  img2.loadPixels();
  float[][] matrix = {{0,-1,0}, {-1,5,-1}, {0,-1,0}};
  
  for (int x = 1; x < img.width-1; x++) {
    for (int y = 1; y < img.height-1; y++) {
      float red = 0;
      float green = 0;
      float blue = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          int index = (x + i - 1) + img.width*(y + j - 1);
          red += red(img.pixels[index]) * matrix[i][j];
          green += green(img.pixels[index]) * matrix[i][j];
          blue += blue(img.pixels[index]) * matrix[i][j];
        }
      }  
    red = constrain(abs(red), 0, 255);
    green = constrain(abs(green), 0, 255);
    blue = constrain(abs(blue), 0, 255);
    img2.pixels[(x) + img.width*(y)] = color(red,green,blue);
    img2.updatePixels();
    }
  }
  
  
  image(img2,-1,-1);
}

void greyscale(){
  colorMode(RGB);
  img.loadPixels();
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      int index = x + img.width*y;
      float red = red(img.pixels[index]);
      float green = green(img.pixels[index]);
      float blue = blue(img.pixels[index]);
      float avg = (red+blue+green)/3;
      img2.pixels[index] = color(avg,avg,avg);
    }
  }
  img2.updatePixels();
  image(img2,-1,-1);
}

void contrast(){
  colorMode(HSB);
  img.loadPixels();
  img2.loadPixels();
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      int index = x + img.width*y;
      float hue = hue(img.pixels[index]);
      float saturation = saturation(img.pixels[index]);
      float brightness = brightness(img.pixels[index]);
      if(brightness < 123){
        //brightness = brightness - slider1.getPos()*100;
        brightness = brightness - 10;
      }else{
        //brightness = brightness + slider1.getPos()*100;
        brightness = brightness + 10;
      brightness = constrain(abs(brightness), 0, 255);
      }
      img2.pixels[index] = color(hue, saturation, brightness);
    }
  }
  img2.updatePixels();
  image(img2,-1,-1);
}

void blur(){
  colorMode(RGB);
  img.loadPixels();
  img2.loadPixels();
  float[][] matrix = {{.0625,.125,.0625},{.125,.25,.125},{.0625,.125,.0625}};
  
  for (int x = 1; x < img.width-1; x++) {
    for (int y = 1; y < img.height-1; y++) {
      float red = 0;
      float green = 0;
      float blue = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          int index = (x + i - 1) + img.width*(y + j - 1);
          red += red(img.pixels[index]) * matrix[i][j];
          green += green(img.pixels[index]) * matrix[i][j];
          blue += blue(img.pixels[index]) * matrix[i][j];
        }
      }  
    red = constrain(abs(red), 0, 255);
    green = constrain(abs(green), 0, 255);
    blue = constrain(abs(blue), 0, 255);
    img2.pixels[(x) + img.width*(y)] = color(red,green,blue);
    img2.updatePixels();
    }
  }
  
  
  image(img2,-1,-1);
}

void edge(){
  colorMode(RGB);
  img.loadPixels();
  img2.loadPixels();
  float[][] matrix = {{-1,0,1},{-1,0,1},{-1,0,1}};
  float[][] matrix2 = {{-1,-1,-1},{0,0,0},{1,1,1}};
  
  for (int x = 1; x < img.width-1; x++) {
    for (int y = 1; y < img.height-1; y++) {
      float red = 0;
  float green = 0;
  float blue = 0;
  float red2 = 0;
  float green2 = 0;
  float blue2 = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          int index = (x + i - 1) + img.width*(y + j - 1);
          red += red(img.pixels[index]) * matrix[i][j];
          green += green(img.pixels[index]) * matrix[i][j];
          blue += blue(img.pixels[index]) * matrix[i][j];
        }
      } 
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          int index = (x + i - 1) + img.width*(y + j - 1);
          red2 += red(img.pixels[index]) * matrix2[i][j];
          green2 += green(img.pixels[index]) * matrix2[i][j];
          blue2 += blue(img.pixels[index]) * matrix2[i][j];
        }
      }
    red = sqrt(red*red+red2*red2);
    green = sqrt(green*green + green2*green2);
    blue = sqrt(blue*blue + blue2*blue2);
    red = constrain(abs(red), 0, 255);
    green = constrain(abs(green), 0, 255);
    blue = constrain(abs(blue), 0, 255);
    img2.pixels[(x) + img.width*(y)] = color(red,green,blue);
    img2.updatePixels();
    }
  }
  
  
  image(img2,-1,-1);
}

void myTint(){
  colorMode(RGB);
  img2.loadPixels();
  for(int x = 0; x < img2.width; x++){
    for(int y = 0; y < img2.height; y++){
      int index = x + img2.width*y;
      float red = red(img2.pixels[index]);
      float green = green(img2.pixels[index]);
      float blue = blue(img2.pixels[index]);
      float newcolor = green;
      green += 50;
      red += 100;
      blue -= 50;
      
      blue = constrain(abs(blue),0,150);
      red = constrain(abs(red),0,255);
      green = constrain(abs(green),0,255);
      img2.pixels[index] = color(red,green,blue);
    }
  }
  img2.updatePixels();
  image(img2,-1,-1);
  save("happytriangles.jpg");
}
