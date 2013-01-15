require_relative 'ball'

class Game
  attr_reader :screen, :background, :clock, :queue, :sprites, :ball

  include Rubygame
  include EventHandler::HasEventHandler

  def initialize
    make_screen
    make_clock
    make_queue
    make_background
    make_hooks
    make_ball 200, 430

    Sprites::UpdateGroup.extend_object sprites
  end

  def run
    catch :quit do
      loop do
        step
      end
    end
  end

  private

  def make_screen
    @screen = Screen.new [640, 480], 0, [HWSURFACE, DOUBLEBUF]
    screen.title = "Pong"
  end

  def make_clock
    @clock = Clock.new
    clock.target_framerate = 60
  end

  def make_queue
    @queue = EventQueue.new
    queue.enable_new_style_events
  end

  def make_background
    @background = Surface.load "img/background.jpg"
    background.blit screen, [0, 0]
  end

  def make_hooks
    hooks = { escape: :quit,
              q: :quit }

    make_magic_hooks hooks
  end

  def make_ball px, py
    @ball = Ball.new px, py

    make_magic_hooks_for ball, left: :move_left,
                               right: :move_right,
                               up: :move_up,
                               down: :move_down 
  end

  def quit
    puts "Quit."
    throw :quit
  end

  def update
    queue.each do |event|
      handle event
    end
  end

  def draw
    screen.flip
  end

  def step
    clock.tick

    ball.undraw screen, background
    ball.update
    ball.draw screen

    draw
    update
  end
end
