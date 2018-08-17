class Audiorecorder < Formula
  desc "Tool for calibration and recording of analog audio sources"
  homepage "https://github.com/amiaopensource/audiorecorder"
  url "https://github.com/amiaopensource/audiorecorder/archive/0.1.09.tar.gz"
  sha256 "d244888d5b569a84e541d86a4e8141bd0dec59435a1b815643a2ae15bc87c722"
  head "https://github.com/amiaopensource/audiorecorder.git"
  
  option "with-audiorecorder2"

  depends_on "sdl"
  depends_on "ffmpeg" => ["with-sdl2", "with-freetype"]
  depends_on "mpv"
  depends_on "sox"
  depends_on "dialog"
  depends_on "bwfmetaedit"

  def install
    bin.install "audiorecorder"
    man1.install "audiorecorder.1"
    
    if build.with?("audiorecorder2")
      if RUBY_PLATFORM.include?('linux')
        bin.install "Linux/audiorecorder2"
      end
    end
  end

  def post_install
    puts "Checking for dependency Pashua. If Pashua is not found will attempt to install"
    if File.exist? File.expand_path "/Applications/Pashua.app"
      puts "Pashua was found"
    elsif `brew cask ls --versions pashua 2>&1 | head -n1`.include? "Warning: pashua is not installed"
      puts "installing Pashua"
      system `echo 'brew install Caskroom/cask/pashua > /dev/null'`
    else
      puts "Pashua was found"
    end
  end
end
