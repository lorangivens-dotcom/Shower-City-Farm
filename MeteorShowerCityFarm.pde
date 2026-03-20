// Meteor Shower City & Farm
// Press SPACE to switch between City and Farm scenes

int scene = 0; // 0 = city, 1 = farm

int meteorCount = 12;
float[] meteorX = new float[meteorCount];
float[] meteorY = new float[meteorCount];
float[] meteorSpeed = new float[meteorCount];
float[] meteorSize = new float[meteorCount];

void setup() {
  size(1000, 700);
  smooth();

  for (int i = 0; i < meteorCount; i++) {
    resetMeteor(i);
    meteorX[i] = random(width);
    meteorY[i] = random(-300, 200);
  }
}

void draw() {
  drawSky();

  if (scene == 0) {
    drawCityScene();
  } else {
    drawFarmScene();
  }

  drawStars();
  drawMoon();
  updateMeteors();
  drawInstructions();
}

void drawSky() {
  background(15, 18, 45);
  
  noStroke();
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(10, 12, 35);
    color bottomColor = color(40, 60, 120);
    color c = lerpColor(topColor, bottomColor, inter);
    stroke(c);
    line(0, i, width, i);
  }
}

void drawStars() {
  noStroke();
  fill(255, 255, 220);
  
  for (int i = 0; i < 80; i++) {
    float x = (i * 127) % width;
    float y = (i * 53) % 250;
    ellipse(x, y, 3, 3);
  }
}

void drawMoon() {
  noStroke();
  fill(245, 245, 210);
  ellipse(850, 100, 90, 90);

  fill(15, 18, 45, 120);
  ellipse(870, 90, 70, 70);
}

void drawCityScene() {
  drawGroundCity();
  drawBuildings();
  drawRoad();
}

void drawFarmScene() {
  drawGroundFarm();
  drawBarn();
  drawFence();
  drawTree(180, 430);
  drawTree(850, 420);
}

void drawGroundCity() {
  noStroke();
  fill(35, 35, 45);
  rect(0, 500, width, 200);
}

void drawGroundFarm() {
  noStroke();
  fill(45, 120, 50);
  rect(0, 500, width, 200);

  fill(60, 160, 70);
  ellipse(150, 530, 300, 120);
  ellipse(500, 540, 400, 130);
  ellipse(850, 530, 350, 120);
}

void drawBuildings() {
  noStroke();

  fill(45, 50, 80);
  rect(60, 260, 120, 240);

  fill(55, 60, 95);
  rect(210, 210, 110, 290);

  fill(40, 45, 75);
  rect(350, 170, 140, 330);

  fill(60, 65, 100);
  rect(530, 230, 100, 270);

  fill(50, 55, 85);
  rect(680, 190, 130, 310);

  fill(38, 42, 70);
  rect(840, 240, 100, 260);

  drawWindows(60, 260, 120, 240, 4, 6);
  drawWindows(210, 210, 110, 290, 4, 7);
  drawWindows(350, 170, 140, 330, 5, 8);
  drawWindows(530, 230, 100, 270, 3, 7);
  drawWindows(680, 190, 130, 310, 4, 8);
  drawWindows(840, 240, 100, 260, 3, 6);
}

void drawWindows(float bx, float by, float bw, float bh, int cols, int rows) {
  float spacingX = bw / (cols + 1);
  float spacingY = bh / (rows + 1);

  fill(255, 220, 120);
  for (int r = 1; r <= rows; r++) {
    for (int c = 1; c <= cols; c++) {
      rect(bx + c * spacingX - 8, by + r * spacingY - 10, 16, 20, 3);
    }
  }
}

void drawRoad() {
  fill(25);
  rect(0, 560, width, 140);

  stroke(255, 220, 0);
  strokeWeight(4);
  for (int i = 0; i < width; i += 60) {
    line(i, 630, i + 30, 630);
  }
  strokeWeight(1);
}

void drawBarn() {
  // barn body
  noStroke();
  fill(170, 40, 40);
  rect(370, 340, 260, 180);

  // roof
  fill(110, 20, 20);
  triangle(340, 340, 500, 220, 660, 340);

  // barn door
  fill(95, 40, 20);
  rect(470, 420, 60, 100);

  // windows
  fill(255, 240, 180);
  rect(410, 390, 35, 35);
  rect(555, 390, 35, 35);

  // loft window
  fill(255, 240, 180);
  ellipse(500, 300, 40, 40);
}

void drawFence() {
  stroke(230, 220, 180);
  strokeWeight(6);

  for (int x = 50; x < width; x += 55) {
    line(x, 470, x, 540);
  }

  line(20, 490, width - 20, 490);
  line(20, 520, width - 20, 520);

  strokeWeight(1);
}

void drawTree(float x, float y) {
  noStroke();
  fill(90, 55, 30);
  rect(x, y, 25, 90);

  fill(40, 130, 55);
  ellipse(x + 12, y - 10, 90, 90);
  ellipse(x - 15, y + 10, 65, 65);
  ellipse(x + 35, y + 10, 65, 65);
}

void updateMeteors() {
  for (int i = 0; i < meteorCount; i++) {
    drawMeteor(meteorX[i], meteorY[i], meteorSize[i]);

    meteorX[i] += meteorSpeed[i] * 2.2;
    meteorY[i] += meteorSpeed[i];

    if (meteorX[i] > width + 100 || meteorY[i] > height + 100) {
      resetMeteor(i);
    }
  }
}

void drawMeteor(float x, float y, float s) {
  noStroke();

  // tail
  fill(255, 180, 80, 120);
  ellipse(x - 20, y - 10, s * 2.5, s);

  fill(255, 130, 50, 90);
  ellipse(x - 40, y - 20, s * 3.5, s * 1.2);

  // meteor head
  fill(255, 200, 100);
  ellipse(x, y, s, s);

  fill(255, 120, 60);
  ellipse(x + 3, y + 2, s * 0.55, s * 0.55);
}

void resetMeteor(int i) {
  meteorX[i] = random(-400, width * 0.4);
  meteorY[i] = random(-350, -40);
  meteorSpeed[i] = random(4, 8);
  meteorSize[i] = random(12, 24);
}

void drawInstructions() {
  fill(255);
  textSize(18);
  textAlign(LEFT);
  
  if (scene == 0) {
    text("Scene: City", 20, 35);
  } else {
    text("Scene: Farm", 20, 35);
  }

  text("Press SPACE to switch scenes", 20, 65);
}

void keyPressed() {
  if (key == ' ') {
    if (scene == 0) {
      scene = 1;
    } else {
      scene = 0;
    }
  }
}
