 Shoes.app do
    stack do
      para "Among these films, which do you prefer?"
      flow { radio("a").checked?; para "The Taste of Tea by Katsuhito Ishii" }
      flow { radio "a"; para "Kin-Dza-Dza by Georgi Danelia" }
      flow { radio; para "Children of Heaven by Majid Majidi" }
      radio.checked?
    end
  end
