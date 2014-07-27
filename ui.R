
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

Boketeplayer <- a("Bokete Player", href="http://hoxom.shinyapps.io/BoketePlayer/") 
kTitle <- span(Boketeplayer, span("- playing automatically bokete"))

kIntervalSeconds <- 8
kPlayButton <- HTML('<button><i class="icon-play"></i> Play</button>')
kPauseButton <- HTML('<button><i class="icon-pause"></i> Pause</button>')

kStartButtonHTML <- a(href="#", class="slider-animate-button", "data-target-id"="index", "data-interval"=kIntervalSeconds * 1000, "data-loop"="TRUE", style="opacity: 1;", span(class="play", kPlayButton), span(class="pause", kPauseButton))

kSpeedDownButton <- HTML('<button id="speedDown"><i class="icon-arrow-down"></i> Speed Down</button>')
kSpeedUpButton <- HTML('<button id="speedUp"><i class="icon-arrow-up"></i> Speed Up</button>')

bokete <- a(href="http://bokete.jp/", "bokete.jp", target="_blank")
Boketeplayer7Sec <- a("7 Seconds", href="http://hoxom.shinyapps.io/BoketePlayer/?intervalsec=7") 
RProject <- a(href="http://www.r-project.org/", "R language", target="_blank")
Shiny <- a(href="http://shiny.rstudio.com/", "RStudio Shiny", target="_blank")
hoxo_m <- a(href="http://d.hatena.ne.jp/hoxo_m/", "hoxo_m", target="_blank")

kALittleAdjustmentJs <- '
<script type="text/javascript">
function getUrlVars() 
{ 
    var vars = [], hash; 
    var hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&"); 
    for(var i = 0; i < hashes.length; i++) { 
        hash = hashes[i].split("="); 
        vars.push(hash[0].toLowerCase()); 
        vars[hash[0].toLowerCase()] = hash[1]; 
    } 
    return vars; 
}
(function() {
  var intervalSec = getUrlVars()["intervalsec"];
  if(intervalSec !== undefined && Number(intervalSec) !== NaN) {
    if(intervalSec >= 1) {
      $("a.slider-animate-button").attr("data-interval", intervalSec * 1000)
    }
  }
  $("#intervalSec").text(intervalSec);
})();
$("h2").attr("style", "padding: 10px 0px 0px; font-size: 20px; line-height: 20px;");
function changeSpeed(newSpeed) {
  $("a.slider-animate-button").attr("data-interval", newSpeed);
  $("a.slider-animate-button").click();
  $("a.slider-animate-button").click();
  $("#intervalSec").text(newSpeed/1000);
}
$("#speedUp").click(function() {
  var speed = $("a.slider-animate-button").attr("data-interval");
  if(speed > 1000) {
    var newSpeed = Number(speed) - 500;
    changeSpeed(newSpeed);
  }
})
$("#speedDown").click(function() {
  var speed = $("a.slider-animate-button").attr("data-interval");
  var newSpeed = Number(speed) + 500;
  changeSpeed(newSpeed);
})
$("a.slider-animate-button").click();
</script>
'

kBatebuButton <- '
<a href="http://b.hatena.ne.jp/entry/hoxom.shinyapps.io/BoketePlayer/" class="hatena-bookmark-button" data-hatena-bookmark-title="Bokete Player - playing automatically bokete" data-hatena-bookmark-layout="standard-balloon" data-hatena-bookmark-lang="en" title="Add to Hatena Bookmark"><img src="http://b.st-hatena.com/images/entry-button/button-only@2x.png" alt="Add to Hatena Bookmark" width="20" height="20" style="border: none;" /></a><script type="text/javascript" src="http://b.st-hatena.com/js/bookmark_button.js" charset="utf-8" async="async"></script>
'

kTwitterButton <- '
<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://hoxom.shinyapps.io/BoketePlayer/" data-via="hoxo_m">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?"http":"https";if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document, "script", "twitter-wjs");</script>
'

kGoogleAnalyticsCode <- "
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-42564367-6', 'auto');
  ga('send', 'pageview');

</script>
"

shinyUI(fluidPage(

  titlePanel(kTitle, windowTitle="Bokete Player - playing automatically bokete"),

  sidebarLayout(position = "right",
    sidebarPanel(
      sliderInput("index", 
                  span("The image will change every", span(kIntervalSeconds, id="intervalSec"), "seconds."),
                  min = 1,
                  max = 10,
                  value = 1,
                  width = "auto"
#                   ,
#                   animate = animationOptions(interval = kIntervalSeconds * 1000,
#                                              loop = TRUE, 
#                                              kPlayButton, 
#                                              kPauseButton)
      ),
      kStartButtonHTML,
      HTML(kSpeedDownButton, kSpeedUpButton),
      helpText(""),
      helpText("This website is for playing automatically", bokete),
      helpText("All the site is implemented in the", RProject, "with the", Shiny),
      helpText("Created by", hoxo_m),
      HTML(kALittleAdjustmentJs),
      HTML(kBatebuButton, kTwitterButton)
    ),

    mainPanel(width = "5 offset1",
      htmlOutput("image")
    )
  ),
  
  HTML(kGoogleAnalyticsCode)
))
