'23' =~ /a/                         #=> nil
/\A0x[[:xdigit:]]+\Z/i =~ '0XA55E'  #=> 0
/\D/ =~ '2 + 3'                     #=> 1
'33 + 41'.match /(\d+) [-+] (\d+)/  #=> #<MatchData "33 + 41" 1:"33" 2:"41">
/\./.match ""                       #=> nil
