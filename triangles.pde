void triangleblur(){
  if(!done){
   for (int i = 0; i < 32000; i+=1){
    int x = int(random(0, img.width));
    int y = int(random(0, img.height));
    if(original){
    img.loadPixels();
    int index = x + img.width*y;
    float red = red(img.pixels[index]);
    float green = green(img.pixels[index]);
    float blue = blue(img.pixels[index]);
    float size = random(1, 5);
    noStroke();
    fill(red,green,blue);
    triangle(x, y, size);
    } else {
    img2.loadPixels();
    int index = x + img2.width*y;
    float red = red(img2.pixels[index]);
    float green = green(img2.pixels[index]);
    float blue = blue(img2.pixels[index]);
    float size = random(1, 5);
    noStroke();
    fill(red,green,blue);
    triangle(x, y, size);
    }
    done = true;
    }
    save("happytriangles.jpg");
  }
}

void triangles2(){
  if(!done2){
  for (int i = 0; i < 300; i+=1){
    int x = int(random(0, img.width));
    int y = int(random(0, img.height));
    img.loadPixels();
    float color1 = random(0, 255);
    float color2 = random(0, 255);
    float color3 = random(5, 255);
    float size = random(1, 20);
    noStroke();
    fill(color1,color2,color3,80);
    triangle(x, y, size);
    done2 = true;
    }
    save("happytriangles.jpg");
    
  }
}

void triangle(float x, float y, float size){
  float angle1 = random(300,300)*PI/180;
  float angle2 = random(0,360)*PI/180;
  beginShape();
  vertex(x,y);
  vertex(x+size*cos(angle2),y+size*sin(angle2));
  vertex(x+size*cos(angle1+angle2), y + size*sin(angle1+angle2));
  vertex(x,y);
  endShape();
}