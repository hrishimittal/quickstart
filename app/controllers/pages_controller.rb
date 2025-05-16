class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]
  before_action :require_admin, except: %i[ show ]

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: 'Page was successfully deleted.'
  end

  private

  def set_page
    @page = Page.find_by!(slug: params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :slug)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end
end
