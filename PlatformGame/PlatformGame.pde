float sx=25;
float sy=25*18;

float jumpVelocity = -12; //the initial velocity of the jump
float gravity = 0.9; //the force of gravity pulling the sprite down
float verticalVelocity = 1; //the current vertical velocity of the sprite
boolean isJumping = false; //flag to indicate if the sprite is currently jumping

int topOffset = 0;
int cellWidth = 40;
int cellHeight = 60;

int frame = 0;
int maxFrames = 8;
int startGridX=0;
// jk JK;

PImage left[] = new PImage[maxFrames];
PImage right[] = new PImage[maxFrames];
PImage up[] = new PImage[maxFrames];
PImage down[] = new PImage[maxFrames];
//PImage im = new PImage();
//float bgX=0,bgY=0;
Map map;
midpoint Midpoint;
//JK = new jk();
Coins foods;
Animals animals;
//Jump jump;
import processing.sound.*;
SoundFile file;


final int STATUS_BEFORE = 0;
// Game state: in game
final int STATUS_PLAYING = 1;
// Game Status: Victory
final int STATUS_WIN = 2;
// Game State: Failed
final int STATUS_LOSE = 3;
// current state of the game
int gameStatus = STATUS_BEFORE;

 //final float ystart =450; //the initial Y position ( which also represent the Y of the ground )
// float playerYPosition = ystart; //give the player the Y of the ground on start
//boolean m = false; 

void setup(){
     //size(1024, 626);
size(626, 626);
   map = new Map();
 Midpoint = new midpoint(); 
 map.draw();
 Midpoint.setup();
 //Midpoint.draw();
 
    PImage rightSprite = loadImage("hero_walk_right.png");
  PImage leftSprite = loadImage("hero_walk_left.png");
  PImage downSprite = loadImage("hero_walk_down.png");
  PImage upSprite = loadImage("hero_walk_up.png");
  
  for(int i = 0; i< maxFrames; i++) {
    right[i] = rightSprite.get(cellWidth*i,topOffset,cellWidth,cellHeight);
    left[i] = leftSprite.get(cellWidth*i,topOffset,cellWidth,cellHeight);
    up[i] = upSprite.get(cellWidth*i,topOffset,cellWidth,cellHeight);
    down[i] = downSprite.get(cellWidth*i,topOffset,cellWidth,cellHeight);
   
}
 file = new SoundFile(this, "gamemusic.mp3");
  file.play();
 //JK = new jk();
frameRate(50);


 foods = new Coins();
  foods.init(626, 626 - 75, 100);
  
  foods.restart(10);
    animals = new Animals();
  animals.init(626, 626 - 75);
} 



boolean isUp = false;
boolean isDown = false;
boolean isLeft = false;
boolean isRight = false;

 

//PVector position = new PVector(25,25*18);
PVector pv = new PVector(sx,sy);
PVector pvr = new PVector(25,0);
PVector pvl = new PVector(-25,0);
PVector pvu = new PVector(0,-25);
PVector pvd = new PVector(0,25);
PVector pvvc = pv;

PImage sprite[] = up;
//int bgCount=0;


void draw(){
 
 if (gameStatus == STATUS_BEFORE) {
    beforeStart();
    return;
  }
  // game win
  if (gameStatus == STATUS_WIN) {
    afterWin();
    return;
  }
  // Game Failed
  if (gameStatus == STATUS_LOSE) {
    afterLose();
    return;
  }
 //Midpoint.setup();
Midpoint.draw();
map.draw();
image(sprite[frame],pv.x,pv.y,cellWidth*3,cellHeight*3);
 //frame++; 
int moveX = 0;

 if(keyPressed){
   

   if(keyCode == UP){ 
        //if(!isUp) 
        if (!isJumping) {
      isJumping = true;
      verticalVelocity = jumpVelocity;
        {
        isUp = true; isDown = false; isRight = false; isLeft = false; 
         
       }
          //map.draw();
          frame = 0;
         maxFrames = 8;
          
    
 }}
        
      else if(keyCode == DOWN) {
        //if(!isDown)
        {
        isRight = false;
        isLeft = false;
        isUp = false;
        isDown = true;
          
          frame = 0;
          maxFrames = 8;
        }
        sprite = down;
pvvc.add(pvd);      }
      else if(keyCode == LEFT) {
       // if(!isLeft)
       {
        isRight = false;
        isLeft = true;
        isUp = false;
          isDown = false;
          frame = 0;
          maxFrames = 8;
          
        }
        sprite = left;

 

pvvc.add(pvl);   
}
      else if(keyCode == RIGHT) 
       {
        // frame++;
         println(frame);
        //if(position.x<=size*9)bgX-=50;
        if(pv.x>=size*18 && pv.x<=size*21) {
          if(startGridX % 15 ==0 ) Midpoint.setup();
          //pv.set(size*0,pv.y);
          pv.sub(pvr);
          startGridX++;
        
        }
       // }  
  //if(abs(bgX)>width){
 // bgX=0;
  
// bgCount++;
// if(bgCount==10) { //eeeeeee
 //}
//}
        //if(!isRight)
        {
        isRight = true;
        isLeft = false;
        isUp = false;
        isDown = false;
          
        //  frame = 0;
         // maxFrames = 8;
        }
        sprite = right;
         pvvc.add(pvr);
        moveX= 10;
       // if(pv.x>size*16)
    // Midpoint.draw();
     //pv.x= 50;
 if (pv.x>=size*25)
 {
// Midpoint.stable();
 pv.x = 25;}
              
      }
//Midpoint.draw();     
map.draw(); 
//Midpoint.setup();

 
 frame++; 
    if (frame >= maxFrames)
    {
      
      frame = 0;
    }
    
  //  image(sprite[frame],pv.x,pv.y,cellWidth*3,cellHeight*3);
    
    
    
  }  
 float manTopLeftX = pv.x + 35 + 5;
  float manTopLeftY = pv.y + 30 + 5;
  float manBottomRightX = manTopLeftX + 50 - 10;
  float manBottomRightY = manTopLeftY + 75 - 10;
  
  boolean reachGoal = foods.move(moveX * -1, manTopLeftX, manTopLeftY, manBottomRightX, manBottomRightY);
  println(minute()+ ":" + second() + " reachGoal:" + reachGoal);
  
   boolean crashed = animals.move(manTopLeftX, manTopLeftY, manBottomRightX, manBottomRightY);
 // println(minute()+ ":" + second() + " crashed:" + crashed);
 // reach target score
 
 if (isJumping) {
   
    //apply gravity
    verticalVelocity += gravity;
    pv.y += verticalVelocity;
    
    //check if the sprite has landed
    if (pv.y >= sy) {
      pv.y = sy;
      verticalVelocity = 0;
      isJumping = false;
    }}
    if (reachGoal) {
   gameStatus = STATUS_WIN;
   return;
 }
 // Collision
 if (crashed) {
   gameStatus = STATUS_LOSE;
 }
}

void keyReleased() {
 //Midpoint.stable();
  isUp = false;
  isDown = false;
  isLeft = false;
  isRight = false;
   // Hit the keyboard S/s before the game starts
  if (gameStatus == STATUS_BEFORE && (key == 'S' || key == 's')) {
    this.restartGame();
  }
  
  // After the game is won, hit the keyboard R/r
  if (gameStatus == STATUS_WIN && (key == 'R' || key == 'r')) {
    this.restartGame();
  }
  
  // After the game fails, hit the keyboard R/r
  if (gameStatus == STATUS_LOSE && (key == 'R' || key == 'r')) {
    this.restartGame();
  }
}

void restartGame() {
  // Character coordinates and frame number
PVector pv = new PVector(sx,sy);
  frame = 0;
  // Gold coins, 10 points to win
  foods.restart(10);
  // animal
  animals.restart();
  // game state
  gameStatus = STATUS_PLAYING;
}
//before the game
void beforeStart() {
  pushMatrix();
  background(0);  //black
  translate(width/2, height/2 - 50);
  fill(255);  //white
  textAlign(CENTER);  //center alignment
  textSize(45);
   text("Platform Game", 0, -30);
  
  text("Press 'S' to start game.", 0, 50);
  text("Author:Ricky&Nischal", 0, 150);
  popMatrix();
}
// after winning the game
void afterWin() {
  pushMatrix();
  background(0);  //black
  translate(width/2, height/2 - 50);
  textAlign(CENTER);  //center alignment
  textSize(45);
  fill(0, 0, 255);
  text("You win, score:" + foods.getScore() + "/" + foods.getGoal(), 0, -50);
  fill(255);  //white
  text("Press 'R' to restart.", 0, 100);
  popMatrix();
}

// after losing the game
void afterLose() {
  pushMatrix();
  background(0);  //black
  translate(width/2, height/2 - 50);
  textAlign(CENTER);  //center alignment
  textSize(45);
  fill(255, 0, 0);
  text("Game Over, score:" + foods.getScore() + "/" + foods.getGoal(), 0, -50);
  fill(255);  //white
  text("Press 'R' to restart.", 0, 100);
  popMatrix();
}
