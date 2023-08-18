module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  # handle for sorting funstion to switch between aort acs and des alpahbetical
  def sort_direction(column)
    params[:sort] == column && params[:direction] == "asc" ? "desc" : "asc"
  end  

end
