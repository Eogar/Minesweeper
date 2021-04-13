import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 40;
public boolean endGame = false;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); 

void setup ()
{
  background(0);
  size(400, 450);
  textAlign(CENTER, CENTER);

  Interactive.make( this );

  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y < NUM_ROWS; y++)
    for (int i = 0; i < NUM_COLS; i++)
      buttons[y][i] = new MSButton(y, i);

  setMines();
}
public void setMines()
{
  while (bombs.size() < NUM_MINES)
  {
    int a = (int)(Math.random()* NUM_ROWS);
    int b = (int)(Math.random()* NUM_COLS);
    if (!bombs.contains(buttons[a][b]))
      bombs.add(buttons[a][b]);
  }
}

public void draw ()
{
  if (isWon())
  {
    endGame = true;
    displayWinningMessage();
  }
}
public boolean isWon()
{
  for ( int r = 0; r < NUM_ROWS; r++) {
    for ( int c = 0; c < NUM_COLS; c++) {
      if (bombs.contains(buttons[r][c]) && buttons[r][c].marked == false)
       {
         return false;
       }
    }
  }
     return true;

}
public void displayLosingMessage()
{
  for ( int r = 0; r < NUM_ROWS; r++) {
    for ( int c = 0; c < NUM_COLS; c++) {
      if (bombs.contains(buttons[r][c])) {
        buttons[r][c].clicked = true;
        buttons[r][c].setLabel("!");
      }
    }
  }
   fill(255);
   text("TRY AGAIN", 200, 425);
}
    public void displayWinningMessage()
    {
      fill(255);
      text("YOU WIN", 200, 425);
      //your code here
    }

public class MSButton
    {
      private int c, d;
      private float x, y, width, height;
      private boolean clicked, marked;
      private String label;
public MSButton ( int row, int col)
      {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = row;
        c = col; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
      }
public boolean isMarked()
      {
        return marked;
      }
public boolean isClicked()
      {
        return clicked;
      }
public void mousePressed () 
      {
        if(endGame == false){
          clicked = true;
          if (mouseButton == RIGHT) {
            marked = !marked;
            if (marked == false)
              clicked = false;
          } else if (bombs.contains(this))
          {
            endGame = true;
            displayLosingMessage();
          }
          else if (countBombs(c, d) > 0)
            setLabel(""+countBombs(c, d));
          else
          {
            if (isValid(c, d-1) && buttons[c][d-1].isClicked()== false) {
              buttons[c][d-1].mousePressed();
            }
            if (isValid(c-1, d-1) && buttons[c-1][d-1].isClicked()== false) {
              buttons[c-1][d-1].mousePressed();
            }
            if (isValid(c-1, d) && buttons[c-1][d].isClicked()== false) {
              buttons[c-1][d].mousePressed();
            }
            if (isValid(c-1, d+1) && buttons[c-1][d+1].isClicked()== false) {
              buttons[c-1][d+1].mousePressed();
            }
            if (isValid(c, d+1) && buttons[c][d+1].isClicked()== false) {
              buttons[c][d+1].mousePressed();
            }
            if (isValid(c+1, d+1) && buttons[c+1][d+1].isClicked()== false) {
              buttons[c+1][d+1].mousePressed();
            }
            if (isValid(c+1, d) && buttons[c+1][d].isClicked() == false) {
              buttons[c+1][d].mousePressed();
            }
            if (isValid(c+1, d-1) && buttons[c+1][d-1].isClicked() == false) {
              buttons[c+1][d-1].mousePressed();
            }
          }
        }
      }
public void draw () 
      {    
        if (marked)
          fill(0);
        else if ( clicked && bombs.contains(this) ) 
          fill(255, 0, 0);
        else if (clicked)
          fill( 200 );
        else 
        fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label, x+width/2, y+height/2);
      }
public void setLabel(String newLabel)
      {
        label = newLabel;
      }
public boolean isValid(int r, int c)
      {
        if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
          return true;
        return false;
      }
public int countBombs(int row, int col)
      {
        int numBombs = 0;
        for (int r = row-1; r<=row+1; r++)
          for (int c = col-1; c<=col+1; c++)
            if (isValid(r, c) && bombs.contains(buttons[r][c]))
              numBombs++;
        if (bombs.contains(buttons[row][col]))
          numBombs--;
        return numBombs;
      }
    }
