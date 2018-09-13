float button1x = 100;
float button1y = 400;
float button1w = 150;
float button1h = 80;
float button2x = 400;
float button2y = 400;
float button2w = 150;
float button2h = 80;
float button3x = 700;
float button3y = 400;
float button3w = 150;
float button3h = 80;
float button4x = 100;
float button4y = 600;
float button4w = 150;
float button4h = 80;

String text1 = "";
String text2 = "";
int counter;
int seed = 1;
int highestSeed = 1;
boolean done1;
boolean done2;
boolean done3;
boolean done4;

int ran2 = 329832;
int ran3 = 48493;
int ran4 = 25;
int shift = 0;
boolean crackMode = false;
boolean cracked = false;
boolean codeCracked = false;



void setup() {
  crackMode = false;
  size(1000, 1000);
  background(0);
  textSize(32);
  rect(button1x, button1y, button1w, button1h);
  text("Parameter: "+ seed, button1x, button1y-8);
  rect(button2x, button2y, button2w, button2h);
  text("Encrypt", button2x, button2y-8);
  rect(button3x, button3y, button3w, button3h);
  text("Decrypt", button3x, button3y-8);
  rect(button4x, button4y, button4w, button4h);
  text("Crack", button4x, button4y-8);
}

void draw() {
  if (mousePressed) {
    if (mouseX>button1x && mouseX <button1x+button1w && mouseY>button1y && mouseY <button1y+button1h) {
      if (!done1 && !crackMode) {
        done1 = true;
        seed++;
        fill(0);
        rect(button1x, button1y-50, 300, 45);
        fill(255);
        text("Parameter: "+ seed, button1x, button1y-8);
      }
      if (!done1 && crackMode) {
        done1 = true;
        seed++;
        fill(0);
        rect(button1x-60, button1y-47, 600, 45);
        fill(255);
        text("Look for keyword up to Parameter: "+ seed, button1x-50, button1y-8);
        highestSeed = seed;
      }
    }
    if (mouseX>button2x && mouseX <button2x+button2w && mouseY>button2y && mouseY <button2y+button2h) {
      if (!done2 && !crackMode) {
        done2 = true;
        encrypt();
      }
    }
    if (mouseX>button3x && mouseX <button3x+button3w && mouseY>button3y && mouseY <button3y+button3h) {
      if (!done3 && !crackMode) {
        done3 = true;
        decrypt();
      }
      if (!done3 && crackMode) {
        done3 = true;
        crack();
      }
    }
    if (mouseX>button4x && mouseX <button4x+button4w && mouseY>button4y && mouseY <button4y+button4h) {
      if (!done4 && !crackMode) {
        done4 = true;
        crackMode = true;
        fill(0);
        rect(button4x, button4y-40, button4w, button4h+80);
        rect(button2x, button2y-40, button4w, button4h+80);
        rect(button1x, button1y-50, 1000, 48);
        rect(0, 10, 1000, 300);
        fill (255);
        text("Look for keyword up to Parameter: "+ seed, button1x-50, button1y-8);
        text("Crack", button3x, button3y-8);
        text("Insert Keyword", 10, 100);
      }
    }
  }
}

void mouseReleased() {
  done1 = false;
  done2 = false;
  done3 = false;
  done4 = false;
}

void keyPressed() {
  if (!crackMode) {
    text1+=key;
    fill(0);
    rect(0, 10, 1000, 300);
    fill(255);
    text(text1, 10, 100);
  }
  if (crackMode) {
    text2+=key;
    fill(0);
    rect(0, 10, 1000, 300);
    fill(255);
    text(text2, 10, 100);
  }
}

void encrypt() {
  char[] message = text1.toCharArray();
  for (int i = 0; i < message.length; i++) {
    seed = abs(seed*ran2%ran3);
    shift = abs(seed%ran4+1);
    message[i] = char(message[i] + shift);
    if (int(message[i]) > 122) {
      message[i] = char(message[i]-26);
    }
  }
  fill(0);
  rect(0, 10, 1000, 300);
  fill(255);
  String messageString = new String(message);
  text("Encrypted message " + messageString, 10, 100);
  text1 = "";
  seed = 1;
  fill(0);
  rect(button1x, button1y-50, 300, 45);
  fill(255);
  text("Parameter: "+ seed, button1x, button1y-8);
}

void decrypt() {
  char[] message = text1.toCharArray();
  for (int i = 0; i < message.length; i++) {
    seed = abs(seed*ran2%ran3);
    shift = abs(seed%ran4+1);
    message[i] = char(message[i] - shift);
    if (int(message[i]) < 97) {
      message[i] = char(message[i]+26);
    }
  }
  fill(0);
  rect(0, 10, 1000, 300);
  fill(255);
  String messageString = new String(message);
  text("Decrypted message " + messageString, 10, 100);
  text1 = "";
  seed = 1;
  fill(0);
  rect(button1x, button1y-50, 300, 45);
  fill(255);
  text("Parameter: "+ seed, button1x, button1y-8);
}

void crack() {
  codeCracked = false;
  fill(0);
  rect(0, 10, 1000, 300);
  fill(255);
  char[] keyword = text2.toCharArray();
  for (int i = 0; i < highestSeed; i++) {
    char[] message = text1.toCharArray();
    seed = i+1;
    for (int j = 0; j < message.length; j++) {
      seed = abs(seed*ran2%ran3);
      shift = abs(seed%ran4+1);
      message[j] = char(message[j] - shift);
      if (int(message[j]) < 97) {
        message[j] = char(message[j]+26);
      }
    }
    for (int k = 0; k < message.length-(keyword.length-1); k++) {
      if (!codeCracked) {
        cracked = true;
        for (int l = 0; l < keyword.length; l++) {
          if (message[k+l] != keyword[l]) {
            cracked = false;
          }
        }
        if (cracked) {
          String messageString = new String(message);
          text("CODE CRACKED: " + messageString + " | Parameter: " + (i+1), 10, 100);
          codeCracked = true;
        }
      }
    }
  }
  if (!cracked) {
    text("Couldn't crack code", 10, 100);
    codeCracked = true;
  }
  text1 = "";
  text2 = "";
  seed = 1;
  fill(0);
  rect(button1x-60, button1y-50, 2000, 48);
  fill(255);
  text("Parameter: "+ seed, button1x, button1y-8);
  rect(button1x, button1y, button1w, button1h);
  text("Parameter: "+ seed, button1x, button1y-8);
  rect(button2x, button2y, button2w, button2h);
  text("Encrypt", button2x, button2y-8);
  rect(button3x, button3y, button3w, button3h);
  text("Decrypt", button3x, button3y-8);
  rect(button4x, button4y, button4w, button4h);
  text("Crack", button4x, button4y-8);
  crackMode = false;
  keyword = text2.toCharArray();
  codeCracked = false;
}

/*
Thank you for downloading this :D
 DECRYPTION PUZZLE
 Code: bvbdzpvhpxzdrhvlahzszfgrn
 Parameter: Lowest number with 9 letters
 
 Comment the code you found in my showcase video! If you are first you will get a shout out in my next video:
 https://www.youtube.com/watch?v=aJq2PX29gng
 */
