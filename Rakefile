# encoding: utf-8
require 'rake/clean'
require 'nokogiri'
CLOBBER.include('out')
directory 'out'

HIGHLIGHTED_FIGURES = FileList['figures/*.rb'].map{|f| f.sub(/rb$/, 'html')}

rule(/figures\/.+\.html/ => '.rb') do |t|
  sh "pygmentize -f html -O encoding=utf-8 -o #{t.name} #{t.source}"
  File.open(t.name,'w') do |f|
    f.print File.read(t.name).sub(/^<div.+pre>/, '<pre class=syntax><code>').
                              sub(/<\/pre><\/div>/,'</code></pre>')
  end
end

source_lambda = ->(t){ t.sub(/out\//, '') }

rule(/out\/.+.html$/ => [source_lambda] + HIGHLIGHTED_FIGURES) do |t|
  nok = Nokogiri::HTML(File.read t.source)
  has_figures = false
  nok.css('figure').each do |figure|
    id = figure.attributes['id'].value
    if file = t.prerequisites.grep(/#{id}.html$/).first    
    # Warn if the figure has no dd or file?
      figure.at('dt').before "<dd>#{File.read file}</dd>"
      has_figures = true
    end
  end
  nok.at('title').after("<link href=pygments.css rel=stylesheet>") if has_figures
  nok.write_html_to(File.new(t.name, 'w'), encoding: 'UTF-8')
end

rule(/out\/.+css/ => [source_lambda] << 'out') do |t|
  cp t.source, t.name
end

task :default => FileList['*.css', '*.html'].map{|f| "out/#{f}" } << 'out'
