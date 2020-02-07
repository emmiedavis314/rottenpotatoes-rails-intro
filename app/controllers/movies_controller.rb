class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    puts params[:sort]
    @all_ratings = ["G", "PG", "PG-13", "R"]
    if (params[:ratings])  
      @checked_rating = params[:ratings].keys
    else
      @checked_rating = @all_ratings
    end
    if (params[:sort] == 'movies')
      @movies = Movie.where(rating: @checked_rating).order(:title)
      @movie_sort = 'hilite'
    elsif (params[:sort] == 'date')
      @movies = Movie.where(rating: @checked_rating).order(:release_date)
      @date_sort = 'hilite'
    else
      #if (checked_rating.length() > 0)
      @movies = Movie.where(rating: @checked_rating)
      #else
      #  @movies = Movie.all
      #end
    end
    
  end

  def new
    # default: render 'new' template
  end
  

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
