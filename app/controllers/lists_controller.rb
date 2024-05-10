class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]
  # '/bookmarks'
  def index
    @lists = List.all
    # render 'index.html.erb'
  end

  # '/lists/1'
  def show
    @bookmark = Bookmark.new
  end

  # '/lists/new'
  def new
    # this instance variable is JUST for the form
    @list = List.new
  end

  # we cant access from a URL. The form is sending the data here (/lists)
  # THIS DOES NOT HAVE A VIEW
  def create
    # we need to create our instance with our STRONG params
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      # show the form with the lists that didnt save (not a brand new one)
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    # we are whitelisting the attributes a user can give us
    params.require(:list).permit(:name)
  end
end
