#!/usr/bin/env ruby

require 'mp3info'
require 'optparse'

module Extraction
  
  def self.find_ipod
    abort "Unable to find an iPod; specify --volume DIR to locate your mp3s."
  end
  
  def self.songs(album, artist, volume)
    songs = []
    volume ||= find_ipod
    
    puts "Searching for mp3 files..."

    Dir.glob("#{volume}/**/*.mp3").select do |f| 
      Mp3Info.open(f) do |mp3|
        if mp3.tag.artist =~ artist && mp3.tag.album =~ album then
          puts "found: #{mp3.tag.artist} / #{mp3.tag.album} / #{mp3.tag.title}"
          songs << f
        end
      end
    end
    return songs
  end
  
  def self.extract(songs, dest_dir)
    unless dest_dir
      puts "Skipping extraction; specify --dest DIR to copy selected files."
      return
    end
    
    puts "Extracting mp3 files..."

    FileUtils.mkdir_p dest_dir
    songs.each do |f|
      Mp3Info.open(f) do |mp3|
        puts "extracting #{File.basename(f)} / #{mp3.tag.title}"
        FileUtils.cp f, "#{dest_dir}/#{File.basename(f)}"
      end
    end    
  end

  def self.cmdline(args)
    album = artist = /.*/
    volume_dir = dest_dir = nil
    OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename $0} [options]"
      opts.on("--album PATTERN") do |pat|
        album = /#{pat}/
      end
      opts.on("--artist PATTERN") do |pat|
        artist = /#{pat}/
      end
      opts.on("--volume DIR") do |dir|
        volume_dir = dir
      end
      opts.on("--dest DIR") do |dir|
        dest_dir = dir
      end
    end.parse!(args)    

    extract( songs(album, artist, volume_dir), dest_dir )
  end
end

Extraction.cmdline(ARGV) if __FILE__ == $0