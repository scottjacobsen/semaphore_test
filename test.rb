#!/usr/bin/env ruby

require "tmpdir"
require "fileutils"

include FileUtils

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

      if File.exist?(first_file_name)
        puts "first exists"
      end
      if File.exist?(second_file_name)
        puts "second exists"
      end
      if File.exist?(third_file_name)
        puts "third exists"
      end
    end
  end
end

test
exit(1)
