import Xmobar

-- Example user-defined plugin

data HelloWorld = HelloWorld
    deriving (Read, Show)

instance Exec HelloWorld where
    alias HelloWorld = "hw"
    run   HelloWorld = return "<fc=red>Hello World!!</fc>"

-- Configuration, using predefined monitors as well as our HelloWorld
-- plugin:

config :: Config
config = defaultConfig {
  font = "xft:IBM Plex Mono-12"
  , additionalFonts = []
  , borderColor = "black"
  , border = TopB
  , bgColor = "black"
  , fgColor = "grey"
  , alpha = 255
  , position = Top
  , textOffset = -1
  , iconOffset = -1
  , lowerOnStart = True
  , pickBroadest = False
  , persistent = False
  , hideOnStart = False
  , iconRoot = "."
  , allDesktops = True
  , overrideRedirect = True
  , commands = [ Run $ Weather "SBMT" ["-t","SP: <tempC>C",
                                        "-L","14","-H","28",
                                        "--normal","green",
                                        "--high","red",
                                        "--low","lightblue"] 36000
               , Run $ Com "uname" ["-s","-r"] "" 1000
               , Run $ Cpu ["-L","3","-H","50",
                             "--normal","green","--high","red"] 10
               , Run $ Memory ["-t","Mem: <usedratio>%"] 10
               --, Run $ CommandReader "uname -s -r" "uname"
               , Run $ Date "%a %b %_d %Y %H:%M:%S" "date" 10
              , Run HelloWorld
              ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "%cpu% | %memory% } %hw% \
               \ { <fc=#ee9a00>%date%</fc> | %uname% | %SBMT%"
}

main :: IO ()
main = xmobar config

