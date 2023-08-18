class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @movies = Movie.all

      # handle sorting feature =======================================
      if params[:sort] == "title"
        direction = params[:direction] == "desc" ? "desc" : "asc"
        @movies = @movies.order(title: direction)
        # @movies = @movies.order(title: :asc) # sort only ascendingly 
      
      # rating sort
      elsif params[:sort] == "rating"
        direction = params[:direction] == "desc" ? "desc" : "asc"
        @movies = @movies.order(title: direction)

      # rating release date
      elsif params[:sort] == "release_date"
        direction = params[:direction] == "desc" ? "desc" : "asc"
        @movies = @movies.order(release_date: direction)
      end

      # handle filer feature =======================================
      # filter release year
      if params[:filter_year].present?
        # get year in int format
        year = params[:filter_year].to_i 
        @movies = @movies.where("strftime('%Y', release_date) = ?", year.to_s)

      # filter by rating
      elsif params[:filter_rating].present?
        @movies = @movies.where(rating: params[:filter_rating])

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
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end