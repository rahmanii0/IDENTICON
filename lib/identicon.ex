defmodule Identicon do

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def hash_input(input) do

    # hash = :crypto.hash(:md5,input)
    # :binary.bin_to_list(hash)

    # Using pipeOp
    hex = :crypto.hash(:md5,input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail] } = image 
    %Identicon.Image{image | color: {r, g, b }}
  end

  # The Elixir code in JavaScript
  # pick_color: function(image){
  #   image.color = {
  #     r: image.hex[0],
  #     g: image.hex[1],
  #     b: image.hex[2]
  #   };
  #   return image
  # }
 
  def mirror(row)do 
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def build_grid(%Identicon.Image{hex: hex}=image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror/1)
    |> List.flatten
    |> Enum.with_index

  end

   def read(name)do  
    File.read(name)
  end

  def next([head | tail]) do 
    IO.puts("#{inspect(head)} : #{inspect(tail)}")
    next(tail)
  end

  def next([]) do
    IO.puts("finished")
  end

  
  


  
end
  