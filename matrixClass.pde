//Ryan Mendes CS 3451 Spring 2015
//Last saved 1/21 at 6:38

//Example Sketch with Matrix class

void setup() {
  //setup code tests
  
  //build identity matrix
  Matrix I = new Matrix();
  I.m[0][0] = 1; I.m[1][1] = 1; I.m[2][2] = 1; I.m[3][3] = 1;
  
  //Matrix A
  Matrix A = new Matrix();
  for(int i=0; i< 4; i++){
    for(int j=0; j< 4; j++){
      A.m[i][j] = i*4+j;
    }
  }
  
  //Matrix B
  Matrix B = new Matrix();
  for(int i=0; i< 4; i++){
    for(int j=0; j< 4; j++){
      B.m[i][j] = i*3+j*5;
    }
  }
  
  //test print matrix
  println("I:");
  println(I.print());
  println("A:");
  println(A.print());
  println("B:");
  println(B.print());
  
  //TEST 1 matrix multiply
  //  Identity*Identity = Identity
  if(!I.equals(I.mult(I))){    println("Failed Test 1");   }else{println("Succeeded Test 1");}
    
  //TEST 2 matrix multiply
  Matrix C = new Matrix();
  double[] valsC = {42,72,102,132,114,224,334,444,186,376,566,756,258,528,798,1068};
  C.fill(0, valsC);
  //A*B=C
  if(!C.equals(A.mult(B))){    println("Failed Test 2");   }else{println("Succeeded Test 2");}
  //ADDED
//  println("Here's what C is:\n" + C.print());
//  println("Here's what A * B is:\n" + A.mult(B).print());
  
  //TEST 3 translate
  Matrix D = new Matrix();
  double[] valsD = {1,0,0,5,0,1,0,7,0,0,1,9,0,0,0,1};
  D.fill(0, valsD);
  if(!D.equals(Translate(5,7,9))){    println("Failed Test 3");   }else{println("Succeeded Test 3");}
  
  //TEST 4 scale
  Matrix E = new Matrix();
  double[] valsE = {5,0,0,0,0,7,0,0,0,0,9,0,0,0,0,1};
  E.fill(0, valsE);
  if(!E.equals(Scale(5,7,9))){    println("Failed Test 4");   }else{println("Succeeded Test 4");}
  
  //TEST 5 rotate x
  Matrix F = new Matrix();
  double[] valsF = {1,0,0,0,0,0,-1,0,0,1,0,0,0,0,0,1};
  F.fill(0, valsF);
  if(!F.equals(Rotate('x',90))){    println("Failed Test 5");   }else{println("Succeeded Test 5");}
  //println(Rotate('z',180).print());
  //ADDED
//  println("Z");
//  println(F.print());
//  println("Rotate");
//  println(Rotate('x',90).print());
  
  //TEST 6 rotate y
  Matrix G = new Matrix();
  double[] valsG = {0,0,-1,0,0,1,0,0,1,0,0,0,0,0,0,1};
  G.fill(0, valsG);
  if(!G.equals(Rotate('y',-90))){    println("Failed Test 6");   }else{println("Succeeded Test 6");}
  
  //TEST 7 rotate z
  Matrix H = new Matrix();
  double[] valsH = {-1,0,0,0,0,-1,0,0,0,0,1,0,0,0,0,1};
  H.fill(0, valsH);
  if(!H.equals(Rotate('z',180))){    println("Failed Test 7");   }else{println("Succeeded Test 7");}
  
  
}

void draw() {
  //Not used in this program
}

//Input: is the scaling factor in each dimension
//Output: is the 4x4 scaling matrix
Matrix Scale(double sx, double sy, double sz){
  Matrix X = new Matrix();
  //your code here
  //Personal note: scaling factors go on the diagonal
  X.m[0][0] = sx;
  X.m[1][1] = sy;
  X.m[2][2] = sz;
  X.m[3][3] = 1;
  return X;
}

//Input: "axis" is a character 'x', 'y', or 'z' denoting the axis about which to rotate
//Input: "theta" is the angle in degrees to rotate
//Output: is the 4x4 rotation matrix
Matrix Rotate(char axis, double theta){
  Matrix X = new Matrix();
//  float floatTheta = radians((float)theta);
  theta = (PI * theta)/180.0;
  float floatTheta = (float)theta;
//  println("floatTheta: " + floatTheta);
//  println("Cosine of Theta: " + cos(floatTheta));
//  println("Sine of Theta: " + cos(floatTheta));
  //Put 1's on the diagonal. Some of these will be overwritten of course.
  for(int i = 0; i < 4; i++) {
    X.m[i][i] = 1.0;
  }
  //The box is [C, -S, S, C] for X and Z, but is different for y.
  //For the axis being rotated about, it is a vector with 1 in the corresponding component and zeroes elsewhere.
  if(axis == 'x'){
    //your code here
    X.m[1][1] = (double)cos(floatTheta);
    X.m[1][2] = (double)sin(floatTheta) * -1.0;
    X.m[2][1] = (double)sin(floatTheta);
    X.m[2][2] = (double)cos(floatTheta);
  }else if(axis == 'y'){
    //your code here
    X.m[0][0] = (double)cos(floatTheta);
    X.m[2][0] = (double)sin(floatTheta) * -1.0;
    X.m[0][2] = (double)sin(floatTheta);
    X.m[2][2] = (double)cos(floatTheta);
  }else if(axis == 'z'){
    //your code here
    X.m[0][0] = (double)cos(floatTheta);
    X.m[0][1] = (double)sin(floatTheta) * -1.0;
    X.m[1][0] = (double)sin(floatTheta);
    X.m[1][1] = (double)cos(floatTheta);
  }else{
    println("invalid axis!");
  }
  
  return X;
}

//Input: is the distance to translate in each dimension
//Output: is the 4x4 translation matrix
Matrix Translate(double x, double y, double z){
  Matrix X = new Matrix();
  //your code here
  //Personal note: translation factors are in the final column, with 1's on the diagonals
  X.m[0][3] = x;
  X.m[1][3] = y;
  X.m[2][3] = z;
  //Put 1's on the diagonal.
  for(int i = 0; i < 4; i++) {
    X.m[i][i] = 1;
  }
  return X;
}
