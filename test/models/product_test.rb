require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product attributes should be valid" do
    @product = Product.new
    assert @product.invalid?
    assert @product.errors[:title].any?
    assert @product.errors[:description].any?
    assert @product.errors[:image_url].any?
    assert @product.errors[:price].any?
  end
  test "product price must be positive" do
  @product = Product.new(title: "My title", description: "description",
                          image_url: "a.jpg")
  @product.price = -1
  assert @product.invalid?
  assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]
  @product.price = 0
  assert @product.invalid?
  assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]
  @product.price = 1
  assert @product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'title', description: 'description', image_url: image_url, price:1)
  end
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |image_url|
    assert new_product(image_url).valid?,
    "#{image_url} must be valid"
    end
    end
  test 'product is not valid without a unique title' do
    product = Product.new( title: products(:ruby).title,
                          description: 'description',
                          image_url: 'fred.gif',
                          price: 1)
    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end
end
