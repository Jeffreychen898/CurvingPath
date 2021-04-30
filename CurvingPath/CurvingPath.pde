final int ITERATIONS = 5;
final float MAX_EXTRUDE_AMOUNT = 0.2;
ArrayList<Path> paths;
void setup() {
  size(800, 600);
  paths = new ArrayList<Path>();
  paths.add(new Path(new PVector(200, 200), new PVector(600, 400)));
  noLoop();
}
void draw() {
  background(0);
  for(int i=0;i<ITERATIONS;i++) {
    ArrayList<Path> new_paths = new ArrayList<Path>();
    for(Path p : paths) {
      Path[] result = p.generatePath();
      new_paths.add(result[0]);
      new_paths.add(result[1]);
    }
    paths = new_paths;
  }
  for(Path p : paths) {
    p.render();
  }
}

class Path {
  PVector start;
  PVector end;
  Path(PVector begin, PVector stop) {
    start = begin.copy();
    end = stop.copy();
  }
  Path[] generatePath() {
    float max_extrude_amount = dist(start.x, start.y, end.x, end.y) * MAX_EXTRUDE_AMOUNT;
    float extrude = random(-max_extrude_amount, max_extrude_amount);
    PVector half = new PVector((end.x + start.x) / 2.f, (end.y + start.y) / 2.f);
    PVector middle = end.copy();
    middle.sub(start);
    middle.normalize();
    middle.rotate(PI / 2);
    middle.mult(extrude);
    middle.add(half);
    Path result[] = {
      new Path(start, middle),
      new Path(middle, end)
    };
    return result;
  }
  void render() {
    stroke(255);
    strokeWeight(4);
    line(start.x, start.y, end.x, end.y);
  }
}
