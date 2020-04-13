format = (->
  '%a %B %e %Y' + '\n' +'%H:%M'
)()

command: "date +\"#{format}\";pmset -g batt | grep -o '[0-9]*%'"

refreshFrequency: 10000

render: (output) -> """
  <div id='terminal'>#{output}</div>
"""

update: (output) ->
    data = output.split('\n')
    hashes = data[2].replace("%", '')/10
    dots = 10 - hashes

    html = '<div class="wrapper"><div class="watch"><div class="bash">user@watch: ~ $ now</div><div class="time">[TIME]<span class="timeData"> '
    html += data[1]
    html += '</span></div><div class="date">[DATE]<span class="dateData"> '
    html += data[0]
    html += '</span></div><div class="batt"><span>[BATT]</span><span class="battData"> '
    html += '['
    for i in [0...hashes]
      html += '#'
    for i in [0...dots]
      html += '.'   
    html += ']'
    html += data[2]
    html += '</span></div><div class="bash">user@watch: ~ $</div></div></div>'

    $(terminal).html(html)
  

style: (->
  return """
    font-size: 15px
    color: white
    line-height: 25px
    padding: 0
    margin: 0
    width: 100%
    height: 100%

    #terminal
      width: 100%
      height: 100%

    .wrapper
      font-family: Menlo
      width: 100%
      height: 100%
      //background-color: #212121
      position: relative

    .watch
      position: absolute
      top: 50%
      left: 50%
      transform: translate(-50%, -50%)

    .bash
      font-weight: bold

    .timeData
      color: #81C784

    .dateData
      color: #EA80FC

    .battData
      color: #EF5350;

  """
)()
