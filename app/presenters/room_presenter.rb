class RoomPresenter < SimpleDelegator
  # A linha abaixo foi substituida pelo metodo __setobj__ da classe SimpleDelegator
  # delegate :user, :created_at, :description, :location, :title, :to_param, to: :@room
  
  def self.model_name
    Room.model_name
  end

  def initialize room, context, show_form=true
    @room = room
    @context = context
    @show_form = show_form
    __setobj__(room)
  end

  def can_review?
    @context.user_signed_in?
  end
 
  def show_form?
    @show_form
  end

  def review
    @review ||= @room.reviews.find_or_initialize_by(user_id: @context.current_user.id)
  end

  def review_route
    [@room, review]
  end

  def route
    @room
  end

  def review_points
    Review::POINTS
  end

  def stars
    @room.reviews.stars
  end

  def total_reviews
    @room.reviews.size
  end

  # Faz com que o partial 'room' seja renderizada quando chamamos o 'render'
  # com o objeto da classe room presenter
  def to_partial_path
    'room'
  end
end
