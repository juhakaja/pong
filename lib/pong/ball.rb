class Ball
  attr_reader :image, :rect, :px, :py

  include Rubygame
  include Sprites::Sprite
  include EventHandler::HasEventHandler

  def initialize px, py
    super()

    @px, @py = px, py
    make_image
    make_rect
  end

  def update
    rect.topleft = [px, py]
  end

  def move_left
    self.px -= 10
  end

  def move_right
    self.px += 10
  end

  def move_up
    self.py -= 10
  end

  def move_down
    self.py += 10
  end

  def px=(x)
    @px = x if x > 0 && x < 600
  end

  def py=(y)
    @py = y if y > 0 && y < 450
  end
  
  private

  def make_image
    @image = Surface.load "img/meanie.png"
  end

  def make_rect
    @rect = image.make_rect
  end
end
