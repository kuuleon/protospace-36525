class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  before_action :move_to_index, only: [:edit, :update]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save #メッセージの保存に成功した場合、
      redirect_to root_path(@prototype) #保存されたときはルートパスに戻る
      #新たにインスタンス変数を生成します。これによって保存後の情報に更新されます。
    else
      render :new#データが保存されなかったときは新規投稿ページへ戻る(newアクションのnew.html.erbを表示する)
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit    
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path(@prototype)
    else
       render :edit
    end
  end

  def destroy 
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  
  
  def move_to_index
    prototype = Prototype.find(params[:id])
    if prototype.user_id != current_user.id
      redirect_to action: :index
    end
  end

end
