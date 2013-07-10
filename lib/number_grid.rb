require 'fileutils'

class Grid
  def initialize(height = 20, width = 20, filename = 'number_grid.txt')
    @height = height
    @width = width
    @filename = filename
  end

  def numberStringToArray(str)
    list = Array.new(str.split(" "))
    list.map! {|n| n = n.to_i}
  end

  def readGrid()
    grid = []  
    File.open(@filename, 'r') do |f|
      f.each_line do |line|
        grid.push numberStringToArray(line)
      end
    end
    grid
  end

  def getProduct(set)
    product = 1
    set.each {|int| product *= int}
    product
  end

  def greatestProductFromLine(line)
    product_list = []
    i = 0
    while i < line.length - 3 do
      set = line[i...(i + 4)]
      product_list.push getProduct(set)
      i += 1
    end
    product_list.max
  end

  def greatestHorizontalProduct(grid)
    i = 0
    product_list = []
    while i < @height do
      product_list.push greatestProductFromLine(grid[i])
      i += 1
    end
    product_list.max
  end

  def getVerticalLines(grid)
    x = 0
    verticalLines = []
    while x < grid[0].length do
      verticalList = []
      y = 0
      while y < @height do
        verticalList.push grid[y][x]
        y += 1
      end
      verticalLines.push verticalList
      x += 1
    end
    verticalLines
  end

  def greatestVerticalProduct(grid)
    product_list = []
    verticalLines = getVerticalLines(grid)
    verticalLines.each do |line|
      product_list.push greatestProductFromLine(line)
    end
    product_list.max
  end

  def greatestDiagonalProductLtoR(grid)
    product_list = []
    y = 0
    while y < (@height - 3) do
      x = 0
      while x < (grid[0].length - 3) do
        set = [grid[y][x], grid[y + 1][x + 1], grid[y + 2][x + 2], grid[y + 3][x + 3]]
        product_list.push(getProduct(set))
        x += 1
      end
      y += 1
    end
    product_list.max
  end

  def reverseGrid(grid)
    reversed_grid = []
    grid.each do |line|
      reversed_grid.push(line.reverse)
    end
    reversed_grid
  end

  def greatestDiagonalProductRtoL(grid)
    reversed_grid = reverseGrid(grid)
    greatestDiagonalProductLtoR(reversed_grid)
  end

  def solve()
    grid = readGrid()
    ans = [
      greatestHorizontalProduct(grid), 
      greatestVerticalProduct(grid), 
      greatestDiagonalProductLtoR(grid), 
      greatestDiagonalProductRtoL(grid)].max
  end
end