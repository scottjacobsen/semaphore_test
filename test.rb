#!/usr/bin/env ruby

require "tmpdir"
require "fileutils"

include FileUtils

def assert_file filename
  raise "Missing file #{filename}" unless File.exist? filename
end

def test
  Dir.mktmpdir do |first_dir|
    first_file_name = File.join(first_dir, "first.txt")
    File.open(first_file_name, "w") do |first_file|
      first_file.write("first!")
    end

    Dir.mktmpdir do |second_dir|
      second_file_name = File.join(second_dir, "second.txt")
      File.open(second_file_name, "w") do |second_file|
        second_file.write("second!")
      end

      third_file_name = File.join(first_dir, "third.txt")
      cp first_file_name, third_file_name
      cp "./fixture.txt", second_dir

      assert_file first_file_name
      assert_file second_file_name
      assert_file third_file_name
      assert_file File.join(second_dir, "fixture.txt")
      puts "passed"
    end
  end
end

test
