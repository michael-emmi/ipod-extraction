This is a little script to pull music from your iPod, against the will of
Apple, who has apparently tried to obscure the way your music is stored. This
script is used as follows:

    Usage: extract-music-from-ipod.rb [options]
        --album PATTERN
        --artist PATTERN
        --volume DIR
        --dest DIR
        
Without specifying a `--dest DIR` this script will simply list the songs
matching `--album PATTERN` and `--artist PATTERN`. When `--dest DIR` is
provided then the matching songs are copied to `DIR`. In case your iPod cannot
be located in any of the standard place, e.g., `/Volumes/my-ipod` on OSX, then
you'll want to specify the `--volume DIR` where your mp3s live.
