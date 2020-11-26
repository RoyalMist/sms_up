defmodule SmsUp.Otp.PinGeneratorTest do
  use ExUnit.Case
  alias SmsUp.Otp.PinGenerator

  describe "generate_pin" do
    setup do
      [size | _] = 1..10 |> Enum.take_random(1)
      %{size: size}
    end

    test "should return a random string of 6 digits in case no size is provided" do
      assert {:ok, attempt_one} = PinGenerator.generate_pin()
      assert String.length(attempt_one) == 6
      assert {:ok, attempt_two} = PinGenerator.generate_pin()
      refute attempt_one == attempt_two
    end

    test "should return a random string of n digits in case size is provided", %{size: size} do
      assert {:ok, attempt_one} = PinGenerator.generate_pin(size)
      assert String.length(attempt_one) == size
      assert {:ok, attempt_two} = PinGenerator.generate_pin(size)
      refute attempt_one == attempt_two
    end

    test "should return a random string of 10 digits in case size of more than 10 is provided" do
      assert {:ok, attempt_one} = PinGenerator.generate_pin(100)
      assert String.length(attempt_one) == 10
      assert {:ok, attempt_two} = PinGenerator.generate_pin(100)
      refute attempt_one == attempt_two
    end

    test "should return an error in case size of 0 is provided" do
      assert {:error, "invalid size of 0, please use a positive integer"} =
               PinGenerator.generate_pin(0)
    end

    test "should return an error in case negative size of is provided" do
      assert {:error, "invalid size of -12, please use a positive integer"} =
               PinGenerator.generate_pin(-12)
    end

    test "should return an error in case any other type is provided for size" do
      assert {:error, "invalid size of hello, please use a positive integer"} =
               PinGenerator.generate_pin("hello")
    end
  end
end
