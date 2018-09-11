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

String text1 = "";
int counter;
int seed = 1;
boolean done1;
boolean done2;
boolean done3;

int ran2 = 329832;
int ran3 = 48493;
int ran4 = 25;
int shift = 0;



void setup() {
  size(1000, 1000);
  background(0);
  textSize(32);
  rect(button1x, button1y, button1w, button1h);
  text("Parameter: "+ seed, button1x, button1y-8);
  rect(button2x, button2y, button2w, button2h);
  text("Encrypt", button2x, button2y-8);
  rect(button3x, button3y, button3w, button3h);
  text("Decrypt", button3x, button3y-8);
}

void draw() {
  if (mousePressed) {
    if (mouseX>button1x && mouseX <button1x+button1w && mouseY>button1y && mouseY <button1y+button1h) {
      if (!done1) {
        done1 = true;
        seed++;
        fill(0);
        rect(button1x, button1y-50, 300, 45);
        fill(255);
        text("Parameter: "+ seed, button1x, button1y-8);
      }
    }
    if (mouseX>button2x && mouseX <button2x+button2w && mouseY>button2y && mouseY <button2y+button2h) {
      if (!done2) {
        done2 = true;
        encrypt();
      }
    }
    if (mouseX>button3x && mouseX <button3x+button3w && mouseY>button3y && mouseY <button3y+button3h) {
      if (!done3) {
        done3 = true;
        decrypt();
      }
    }
  }
}

void mouseReleased() {
  done1 = false;
  done2 = false;
  done3 = false;
}

void keyPressed() {
  text1+=key;
  fill(0);
  rect(0, 10, 1000, 300);
  fill(255);
  text(text1, 10, 100);
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

/*
Thank you for downloading this :D
 DECRYPTION PUZZLE
 Code: bvbdzpvhpxzdrhvlahzszfgrn
 Parameter: Lowest number with 9 letters
 
 Comment the code you found in my showcase video! If you are first you will get a shout out in my next video:
 https://www.youtube.com/watch?v=aJq2PX29gng
 */
