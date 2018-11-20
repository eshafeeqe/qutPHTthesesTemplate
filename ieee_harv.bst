% BibTeX bibliographic style 'ieee_harv'
%
% Based on IEEE bibliography and general alpha style
%
% References appear as per the IEEE style, but are sorted on
% author list
%
%
% ammended from:
% BibTeX standard bibliography style `kluwer' (one of the harvard family)
 % version 0.99a for BibTeX versions 0.99a or later, LaTeX version 2.09.
 % Copyright (C) 1991, all rights reserved.
 % Copying of this file is authorized only if either
 % (1) you make absolutely no changes to your copy, including name, or
 % (2) if you do make changes, you name it something other than
 % btxbst.doc, plain.bst, unsrt.bst, alpha.bst, abbrv.bst, agsm.bst,
       % dcu.bst or kluwer.bst.
 % This restriction helps ensure that all standard styles are identical.
 % The file harvard.tex has the documentation for this style.

% ACKNOWLEDGEMENT:
%   This document is a modified version of alpha.bst to which it owes much of
%   its functionality.
%   Further amendments from 'mpikluwer' and 'ieeetr'

% AUTHOR
%   Peter Williams, Key Centre for Design Quality, Sydney University
%   e-mail: peterw@archsci.arch.su.oz.au

% ieeetr History
%    9/30/85  (HWT) Original version, by Howard Trickey.
%    1/29/88  (OP&HWT) Updated for BibTeX version 0.99a, Oren Patashnik;
%     THIS `ieeetr' VERSION DOES NOT WORK WITH BIBTEX 0.98i.
%
% Modifications:
%   Michael Mason. QUT

ENTRY
 { address
   author
   booktitle
   chapter
   edition
   editor
   howpublished
   institution
   journal
   key
   month
   note
   number
   organization
   pages
   publisher
   school
   series
   title
   type
   URL
   volume
   year
 }
 { field.used etal.allowed etal.required }
 { extra.label sort.label list.year }

INTEGERS { output.state before.all mid.sentence after.quote after.sentence
   after.quoted.block after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
 #1 'mid.sentence :=
 #2 'after.quote :=
 #3 'after.sentence :=
 #4 'after.quoted.block :=
 #5 'after.block :=
}

STRINGS { s t f }

FUNCTION {output.nonnull}
{ 's :=
 output.state mid.sentence =
   { ", " * write$ }
   { output.state after.quote =
 { " " * write$ }
 { output.state after.block =
     { add.period$ write$
       newline$
       "\newblock " write$
     }
     { output.state before.all =
   'write$
   { output.state after.quoted.block =
       { write$
         newline$
         "\newblock " write$
       }
       { add.period$ " " * write$ }
     if$
   }
       if$
     }
   if$
 }
     if$
     mid.sentence 'output.state :=
   }
 if$
 s
}

FUNCTION {output}
{ duplicate$ empty$
   'pop$
   'output.nonnull
 if$
}

FUNCTION {output.check}
{ 't :=
 duplicate$ empty$
   { pop$ "empty " t * " in " * cite$ * warning$ }
   'output.nonnull
 if$
}

FUNCTION {blank.sep}
{ after.quote 'output.state :=
}

FUNCTION {item.check}
{ 't :=
 empty$
   { "empty " t * " in " * cite$ * warning$ }
   { skip$ }
 if$
}

FUNCTION {fin.entry}
{ output.state after.quoted.block =
   'skip$
   'add.period$
 if$
 write$
 newline$
}

FUNCTION {new.block}
{ output.state before.all =
   'skip$
   { output.state after.quote =
 { after.quoted.block 'output.state := }
 { after.block 'output.state := }
     if$
   }
 if$
}

FUNCTION {new.sentence}
{ output.state after.block =
   'skip$
   { output.state before.all =
 'skip$
 { after.sentence 'output.state := }
     if$
   }
 if$
}

FUNCTION {not}
{   { #0 }
   { #1 }
 if$
}

FUNCTION {and}
{   'skip$
   { pop$ #0 }
 if$
}

FUNCTION {or}
{   { pop$ #1 }
   'skip$
 if$
}

FUNCTION {new.block.checka}
{ empty$
   'skip$
   'new.block
 if$
}

FUNCTION {new.block.checkb}
{ empty$
 swap$ empty$
 and
   'skip$
   'new.block
 if$
}

FUNCTION {new.sentence.checka}
{ empty$
   'skip$
   'new.sentence
 if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
   { pop$ "" }
   'skip$
 if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
   { pop$ "" }
   { "{\em " swap$ * "}" * }
 if$
}

FUNCTION {embolden}
{ duplicate$ empty$
   { pop$ "" }
   { "{\bf " swap$ * "}" * }
 if$
}

FUNCTION {quote}
{ duplicate$ empty$
   { pop$ "" }
   { "`" swap$ * "'" * }
 if$
}

FUNCTION {write.url}
{ URL empty$
   { skip$ }
   { "\newline\harvardurl{" URL * "}" * write$ newline$ }
 if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
 #1 'nameptr :=
 s num.names$ 'numnames :=
 numnames 'namesleft :=
   { namesleft #0 > }
   { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
     nameptr #1 >
 { namesleft #1 >
     { ", " * t * }
     { numnames #2 >
   { "," * }
   'skip$
       if$
       t "others" =
   { " {\em et~al.}" * }
   { " and " * t * }
       if$
     }
   if$
 }
 't
     if$
     nameptr #1 + 'nameptr :=
     namesleft #1 - 'namesleft :=
   }
 while$
}

FUNCTION {format.authors}
{ author empty$
   { "" }
   { author format.names }
 if$
}

FUNCTION {format.editors}
{ editor empty$
   { "" }
   { editor format.names
     editor num.names$ #1 >
 { ", eds." * }
 { ", ed." * }
     if$
   }
 if$
}

FUNCTION {format.editors.reverse}
{ editor empty$
   { "" }
   { editor format.names
     editor num.names$ #1 >
 { " (eds)" * }
 { " (ed.)" * }
     if$
   }
 if$
}

FUNCTION {format.date}
{ year empty$
   { month empty$
 { "" }
 { "there's a month but no year in " cite$ * warning$
   month
 }
     if$
   }
   { month empty$
 'year
 { month " " * year * }
     if$
   }
 if$
}

FUNCTION {format.title}
{ title empty$
   { "" }
   { "``" title "t" change.case$ * ",''" * }
 if$
}

FUNCTION {format.title.p}
{ title empty$
   { "" }
   { "``" title "t" change.case$ * ".''" * }
 if$
}

FUNCTION {n.dashify}
{ 't :=
 ""
   { t empty$ not }
   { t #1 #1 substring$ "-" =
 { t #1 #2 substring$ "--" = not
     { "--" *
       t #2 global.max$ substring$ 't :=
     }
     {   { t #1 #1 substring$ "-" = }
   { "-" *
     t #2 global.max$ substring$ 't :=
   }
       while$
     }
   if$
 }
 { t #1 #1 substring$ *
   t #2 global.max$ substring$ 't :=
 }
     if$
   }
 while$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
   { "~" }
   { " " }
 if$
 swap$ * *
}

FUNCTION {either.or.check}
{ empty$
   'pop$
   { "can't use both " swap$ * " fields in " * cite$ * warning$ }
 if$
}

FUNCTION {format.bvolume}
{ volume empty$
   { "" }
   { "vol.~" volume *
     series empty$
 'skip$
 { " of " * series emphasize * }
     if$
     "volume and number" number either.or.check
   }
 if$
}

FUNCTION {format.number.series}
{ volume empty$
   { number empty$
 { series field.or.null }
 { output.state mid.sentence =
     { "no.~" }
     { "No.~" }
   if$
   number *
   series empty$
     { "there's a number but no series in " cite$ * warning$ }
     { " in " * series * }
   if$
 }
     if$
   }
   { "" }
 if$
}

FUNCTION {format.edition}
{ edition empty$
   { "" }
   { edition "l" change.case$ "~ed." * }
 if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
 #0 'multiresult :=
   { multiresult not
     t empty$ not
     and
   }
   { t #1 #1 substring$
     duplicate$ "-" =
     swap$ duplicate$ "," =
     swap$ "+" =
     or or
 { #1 'multiresult := }
 { t #2 global.max$ substring$ 't := }
     if$
   }
 while$
 multiresult
}

FUNCTION {format.pages}
{ pages empty$
   { "" }
   { pages multi.page.check
 { "pp.~" pages n.dashify * }
 { "p.~" pages * }
     if$
   }
 if$
}

FUNCTION {format.volume}
{ volume empty$
   { "" }
   { "vol.~" volume * }
 if$
}

FUNCTION {format.number}
{ number empty$
   { "" }
   { "no.~" number * }
 if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
   'format.pages
   { type empty$
 { "ch.~" chapter * }
 { type "l" change.case$ chapter tie.or.space.connect }
     if$
     pages empty$
 'skip$
 { ", " * format.pages * }
     if$
   }
 if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
   { "" }
   { "in " booktitle emphasize *
     editor empty$
 'skip$
 { " (" * format.editors * ")" * }
     if$
   }
 if$
}

FUNCTION {format.thesis.type}
{ type empty$
   'skip$
   { pop$
     output.state after.block =
 { type "t" change.case$ }
 { type "l" change.case$ }
     if$
   }
 if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
 month empty$ year empty$ note empty$
 and and and and and
 key empty$ not and
   { "all relevant fields are empty in " cite$ * warning$ }
   'skip$
 if$
}

FUNCTION {format.tr.number}
{ type empty$
   { "Tech. Rep." }
   'type
 if$
 number empty$
   { "l" change.case$ }
   { number tie.or.space.connect }
 if$
}

FUNCTION {format.addr.pub}
{ publisher empty$
   { "" }
   { address empty$
 { "" }
 { address ": " * }
     if$
     publisher *
   }
 if$
}

FUNCTION {format.paddress}
{ address empty$
   { "" }
   { "(" address * ")" * }
 if$
}

FUNCTION {format.article.crossref}
{ key empty$
   { journal empty$
 { "need key or journal for " cite$ * " to crossref " * crossref *
   warning$
   ""
 }
 { "in {\em " journal * "\/}" * }
     if$
   }
   { "in " key * }
 if$
 " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
 editor num.names$ duplicate$
 #2 >
   { pop$ " {\em et~al.}" * }
   { #2 <
 'skip$
 { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
     { " {\em et~al.}" * }
     { " and " * editor #2 "{vv~}{ll}" format.name$ * }
   if$
 }
     if$
   }
 if$
}

FUNCTION {format.book.crossref}
{ volume empty$
   { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
     "In "
   }
   { "Vol.~" volume *
     " of " *
   }
 if$
 editor empty$
 editor field.or.null author field.or.null =
 or
   { key empty$
 { series empty$
     { "need editor, key, or series for " cite$ * " to crossref " *
       crossref * warning$
       "" *
     }
     { "{\em " * series * "\/}" * }
   if$
 }
 { key * }
     if$
   }
   { format.crossref.editor * }
 if$
 " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
 editor field.or.null author field.or.null =
 or
   { key empty$
 { booktitle empty$
     { "need editor, key, or booktitle for " cite$ * " to crossref " *
       crossref * warning$
       ""
     }
     { "in {\em " booktitle * "\/}" * }
   if$
 }
 { "in " key * }
     if$
   }
   { "in " format.crossref.editor * }
 if$
 " \cite{" * crossref * "}" *
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
 'len :=
 s #1 len substring$ =
   { s len #1 + global.max$ substring$ }
   's
 if$
}

INTEGERS { ind tsslen }

STRINGS { tss ret rss istr }

FUNCTION {replace.substring}{
 'rss :=
 'tss :=
 'istr :=
 "" 'ret :=
 tss text.length$ 'tsslen :=
 #1 'ind :=
   { istr ind tsslen substring$ "" = not }
   { istr ind tsslen substring$ tss =
       { ret rss * 'ret :=
         ind tsslen + 'ind :=
       }
       { ret istr ind #1 substring$ * 'ret :=
         ind #1 + 'ind :=
       }
     if$
   }
 while$
 ret
}

FUNCTION {format.lab.names.abbr}
{ 's :=
 s num.names$ 'numnames :=
 numnames #1 >
   { numnames #2 >
 { s #1 "{vv~}{ll}" format.name$ " et~al." * }
 { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
           { s #1 "{vv~}{ll}" format.name$ " et~al." * }
     { s #1 "{vv~}{ll}" format.name$ " and " *
             s #2 "{vv~}{ll}" format.name$ *
           }
         if$
       }
     if$
   }
   { s #1 "{vv~}{ll}" format.name$ }
 if$
}

FUNCTION {format.lab.names.full}
{ 's :=
 #1 'nameptr :=
 s num.names$ 'numnames :=
 numnames 'namesleft :=
   { namesleft #0 > }
   { s nameptr "{vv~}{ll}" format.name$ 't :=
     nameptr #1 >
 { namesleft #1 >
     { ", " * t * }
     { t "others" =
   { " et~al." * }
   { " and " * t * }
       if$
     }
   if$
 }
 't
     if$
     nameptr #1 + 'nameptr :=
     namesleft #1 - 'namesleft :=
   }
 while$
}

INTEGERS { author.field editor.field organization.field title.field key.field }

FUNCTION {init.field.constants}
{ #0 'author.field :=
 #1 'editor.field :=
 #2 'organization.field :=
 #3 'title.field :=
 #4 'key.field :=
}

FUNCTION {make.list.label}
{ author.field field.used =
   { format.authors }
   { editor.field field.used =
       { format.editors }
       { organization.field field.used =
           { "The " #4 organization chop.word #3 text.prefix$ }
           { title.field field.used =
               { format.btitle }
               { key.field field.used =
                   { key #3 text.prefix$ }
                   { "Internal error :001 on " cite$ * " label" * warning$ }
                 if$
               }
             if$
           }
         if$
       }
     if$
   }
 if$
}

FUNCTION {make.full.label}
{ author.field field.used =
   { author format.lab.names.full }
   { editor.field field.used =
       { editor format.lab.names.full }
       { organization.field field.used =
           { "The " #4 organization chop.word #3 text.prefix$ }
           { title.field field.used =
               { format.btitle }
               { key.field field.used =
                   { key #3 text.prefix$ }
                   { "Internal error :001 on " cite$ * " label" * warning$ }
                 if$
               }
             if$
           }
         if$
       }
     if$
   }
 if$
}

FUNCTION {make.abbr.label}
{ etal.allowed
   { author.field field.used =
       { author format.lab.names.abbr }
       { editor.field field.used =
           { editor format.lab.names.abbr }
           { organization.field field.used =
               { "The " #4 organization chop.word #3 text.prefix$ }
               { title.field field.used =
                   { format.btitle }
                   { key.field field.used =
                       { key #3 text.prefix$ }
                       {"Internal error :001 on " cite$ * " label" * warning$ }
                     if$
                   }
                 if$
               }
             if$
           }
         if$
       }
     if$
   }
   { make.full.label }
 if$
}

FUNCTION {output.bibitem}
{ newline$
 etal.allowed        %%%XXX change
 etal.required
 and
   {
     "\harvarditem[" write$
     make.abbr.label write$
     "]{" write$
   }
   {
     "\harvarditem{" write$
   }
 if$
 make.full.label write$
 "}{" write$
 list.year write$
 "}{" write$
 cite$ write$
 "}" write$
 newline$
 ""
 before.all 'output.state :=
}


FUNCTION {list.label.output}
{ make.list.label write$
}

FUNCTION {article}
{ output.bibitem
 format.authors "author" output.check
 format.title "title" output.check
 blank.sep
 crossref missing$
   { journal emphasize "journal" output.check
     format.volume output
     month empty$
 { format.number output }
 'skip$
     if$
     format.pages output
     format.date "year" output.check
   }
   { format.article.crossref output.nonnull
     format.pages output
   }
 if$
 new.block
 note output
 fin.entry
}

FUNCTION {book}
{ output.bibitem
 author empty$
   { format.editors "author and editor" output.check }
   { format.authors output.nonnull
     crossref missing$
 { "author and editor" editor either.or.check }
 'skip$
     if$
   }
 if$
 format.btitle "title" output.check
 crossref missing$
   { format.bvolume output
     new.block
     format.number.series output
     format.addr.pub "publisher" output.check
   }
   { new.block
     format.book.crossref output.nonnull
   }
 if$
 format.edition output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {booklet}
{ output.bibitem
 format.authors output
 title empty$
   { "empty title in " cite$ * warning$
     howpublished new.sentence.checka
   }
   { howpublished empty$ not
     address empty$ month empty$ year empty$ and and
     or
 { format.title.p output.nonnull }
 { format.title output.nonnull }
     if$
     blank.sep
   }
 if$
 howpublished output
 address output
 format.date output
 new.block
 note output
 fin.entry
}

FUNCTION {inbook}
{ output.bibitem
 author empty$
   { format.editors "author and editor" output.check }
   { format.authors output.nonnull
     crossref missing$
 { "author and editor" editor either.or.check }
 'skip$
     if$
   }
 if$
 format.btitle "title" output.check
 crossref missing$
   { format.bvolume output
     format.chapter.pages "chapter and pages" output.check
     new.block
     format.number.series output
     format.addr.pub "publisher" output.check
   }
   { format.chapter.pages "chapter and pages" output.check
     new.block
     format.book.crossref output.nonnull
   }
 if$
 format.edition output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {incollection}
{ output.bibitem
 format.authors "author" output.check
 format.title "title" output.check
 blank.sep
 crossref missing$
   { format.in.ed.booktitle "booktitle" output.check
     format.bvolume output
     format.number.series output
     format.chapter.pages output
     format.addr.pub "publisher" output.check
     format.edition output
     format.date "year" output.check
   }
   { format.incoll.inproc.crossref output.nonnull
     format.chapter.pages output
   }
 if$
 new.block
 note output
 fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
 format.authors "author" output.check
 format.title "title" output.check
 blank.sep
 crossref missing$
   { format.in.ed.booktitle "booktitle" output.check
     format.bvolume output
     format.number.series output
     format.paddress output
     format.pages output
     organization output
     publisher output
     format.date "year" output.check
   }
   { format.incoll.inproc.crossref output.nonnull
     format.pages output
   }
 if$
 new.block
 note output
 fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
 author empty$
   { organization empty$
 'skip$
 { organization output.nonnull
   address output
 }
     if$
   }
   { format.authors output.nonnull }
 if$
 format.btitle "title" output.check
 author empty$
   { organization empty$
 { address new.block.checka
   address output
 }
 'skip$
     if$
   }
   { organization address new.block.checkb
     organization output
     address output
   }
 if$
 format.edition output
 format.date output
 new.block
 note output
 fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
 format.authors "author" output.check
 format.title "title" output.check
 blank.sep
 "Master's thesis" format.thesis.type output.nonnull
 school "school" output.check
 address output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {misc}
{ output.bibitem
 format.authors output
 title empty$
   { howpublished new.sentence.checka }
   { howpublished empty$ not
     month empty$ year empty$ and
     or
 { format.title.p output.nonnull }
 { format.title output.nonnull }
     if$
     blank.sep
   }
 if$
 howpublished output
 format.date output
 new.block
 note output
 fin.entry
 empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
 format.authors "author" output.check
 format.btitle "title" output.check
 new.block
 "PhD thesis" format.thesis.type output.nonnull
 school "school" output.check
 address output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
 editor empty$
   { organization output }
   { format.editors output.nonnull }
 if$
 format.btitle "title" output.check
 format.bvolume output
 format.number.series output
 format.paddress output
 editor empty$
   'skip$
   { organization output }
 if$
 publisher output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {techreport}
{ output.bibitem
 format.authors "author" output.check
 format.title "title" output.check
 blank.sep
 format.tr.number output.nonnull
 institution "institution" output.check
 address output
 format.date "year" output.check
 new.block
 note output
 fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
 format.authors "author" output.check
 format.title.p "title" output.check
 blank.sep
 note "note" output.check
 format.date output
 fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr."}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sept."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications ACM"}

MACRO {ibmjrd} {"IBM J. Research and Development"}

MACRO {ibmsj} {"IBM Systems~J."}

MACRO {ieeese} {"IEEE Trans. Software Engineering"}

MACRO {ieeetc} {"IEEE Trans. Computers"}

MACRO {ieeetcad}
 {"IEEE Trans. Computer-Aided Design"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"J.~ACM"}

MACRO {jcss} {"J.~Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM J. Computing"}

MACRO {tocs} {"ACM Trans. Computer Systems"}

MACRO {tods} {"ACM Trans. Database Systems"}

MACRO {tog} {"ACM Trans. Graphics"}

MACRO {toms} {"ACM Trans. Mathematical Software"}

MACRO {toois} {"ACM Trans. Office Information Systems"}

MACRO {toplas} {"ACM Trans. Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

EXECUTE {init.field.constants}

FUNCTION {sortify}
{ purify$
 "l" change.case$
}

FUNCTION {sortify.names}
{ " and " " " replace.substring
 " et~al." " zzz" replace.substring
 sortify
}

FUNCTION {author.key.label}
{ author empty$
   { key empty$
 { title.field 'field.used := }
 { key.field 'field.used := }
     if$
   }
   { author.field 'field.used := }
 if$
}

FUNCTION {author.editor.key.label}
{ author empty$
   { editor empty$
 { key empty$
     { title.field 'field.used := }
     { key.field 'field.used := }
   if$
   }
 { editor.field 'field.used := }
     if$
   }
   { author.field 'field.used := }
 if$
}

FUNCTION {author.key.organization.label}
{ author empty$
   { key empty$
 { organization empty$
     { title.field 'field.used := }
     { organization.field 'field.used := }
   if$
 }
 { key.field 'field.used := }
     if$
   }
   { author.field 'field.used := }
 if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
   { key empty$
 { organization empty$
     { title.field 'field.used := }
     { organization.field 'field.used := }
   if$
 }
 { key.field 'field.used := }
     if$
   }
   { editor.field 'field.used := }
 if$
}

FUNCTION {sort.format.title}
{ 't :=
 "A " #2
   "An " #3
     "The " #4 t chop.word
   chop.word
 chop.word
 sortify
 #1 global.max$ substring$
}

FUNCTION {calc.label}
{ make.full.label
 title.field field.used =
   { sort.format.title }
   { sortify.names }
 if$
 year field.or.null purify$ #-1 #4 substring$ sortify
 *
 'sort.label :=
}

FUNCTION {preliminaries} %%%XXX change
{ type$ "book" =
 type$ "inbook" =
 or
   'author.editor.key.label
   { type$ "proceedings" =
 'editor.key.organization.label
 { type$ "manual" =
     'author.key.organization.label
     'author.key.label
   if$
 }
     if$
   }
 if$
 author.field field.used = %%%XXX change
   {
     author num.names$ #2 >
       { #1 }
       { #0 }
     if$
     'etal.required :=
   }
   {
     editor.field field.used =
       {
         editor num.names$ #2 >
           { #1 }
           { #0 }
         if$
       }
       { #0 }
     if$
     'etal.required :=
   }
 if$
 #1 'etal.allowed :=
}

FUNCTION {first.presort}
{ calc.label
 sort.label
 title.field field.used =
   { skip$ }
   { "    "
     *
     make.full.label sortify.names
     *
     "    "
     *
     title field.or.null
     sort.format.title
     *
   }
 if$
 #1 entry.max$ substring$
 'sort.key$ :=
}

ITERATE {preliminaries}

ITERATE {first.presort}

SORT

STRINGS { last.sort.label next.extra last.full.label }

INTEGERS { last.extra.num last.etal.allowed }

FUNCTION {initialize.confusion}
{ #0 int.to.chr$ 'last.sort.label :=
 #0 int.to.chr$ 'last.full.label :=
 #1 'last.etal.allowed :=
}

FUNCTION {confusion.pass}
{ last.sort.label sort.label =
   { last.etal.allowed
       { last.full.label make.full.label sortify.names =
           { skip$ }
           { #0 'etal.allowed :=
             #0 'last.etal.allowed :=
           }
         if$
       }
       { #0 'etal.allowed := }
     if$
   }
   { sort.label 'last.sort.label :=
     make.full.label sortify.names 'last.full.label :=
     #1 'last.etal.allowed :=
   }
 if$
}

EXECUTE {initialize.confusion}

ITERATE {confusion.pass}

EXECUTE {initialize.confusion}

REVERSE {confusion.pass}

FUNCTION {initialize.last.extra.num}
{ #0 int.to.chr$ 'last.sort.label :=
 "" 'next.extra :=
 #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.sort.label sort.label =
   { last.extra.num #1 + 'last.extra.num :=
     last.extra.num int.to.chr$ 'extra.label :=
   }
   { "a" chr.to.int$ 'last.extra.num :=
     "" 'extra.label :=
     sort.label 'last.sort.label :=
   }
 if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
   { "a" 'extra.label := }
   'skip$
 if$
 year empty$
   { "n.d." extra.label * 'list.year := }
   { year extra.label * 'list.year := }
 if$
 extra.label 'next.extra :=
}

ITERATE {first.presort}

SORT

EXECUTE {initialize.last.extra.num}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {second.presort}
{ make.full.label
 title.field field.used =
   { sort.format.title }
   { sortify.names }
 if$
 "    "
 *
 list.year field.or.null sortify
 *
 "    "
 *
 title.field field.used =
   { skip$ }
   { title field.or.null
     sort.format.title
     *
   }
 if$
 #1 entry.max$ substring$
 'sort.key$ :=
}

ITERATE {second.presort}

SORT

FUNCTION {begin.bib}
{ preamble$ empty$
   'skip$
   { "\harvardpreambledefs{%" write$ newline$
     preamble$ write$ "}" write$ newline$
     "\harvardpreambletext{%" write$ newline$
     preamble$ write$ "}" write$ newline$ }
 if$
 "\begin{thebibliography}{xx}" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
 "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}