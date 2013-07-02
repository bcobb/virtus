require 'spec_helper'

describe Virtus::AttributeSet do

  class NamedValue
    include Virtus::ValueObject

    attribute :name, String
  end

  class NamedEntity
    include Virtus

    attribute :name, String
  end

  describe 'sharing AttributeSets between classes' do

    it "allows an Entity to build off a Value's attributes" do
      aged = Class.new do
        include Virtus
        include NamedValue.attribute_set

        attribute :age, Integer
      end

      entity = aged.new(:name => 'Sam', :age => 100)

      entity.name.should == 'Sam'
      entity.age.should == 100
    end

    it "allows one Entity to build off another Entity's attributes" do
      aged = Class.new do
        include Virtus
        include NamedEntity.attribute_set

        attribute :age, Integer
      end

      entity = aged.new(:name => 'Sam', :age => 100)

      entity.name.should == 'Sam'
      entity.age.should == 100
    end

    it "allows one Value to build off an Entity's attributes" do
      aged = Class.new do
        include Virtus::ValueObject
        include NamedEntity.attribute_set

        attribute :age, Integer
      end

      value = aged.new(:name => 'Sam', :age => 100)

      value.name.should == 'Sam'
      value.age.should == 100
    end

    it "allows one Value to build off another Value's attributes" do
      aged = Class.new do
        include Virtus::ValueObject
        include NamedValue.attribute_set

        attribute :age, Integer
      end

      value = aged.new(:name => 'Sam', :age => 100)

      value.name.should == 'Sam'
      value.age.should == 100
    end

  end

end
