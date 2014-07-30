     \version "2.4.2"
\header {
       title = "Traumerei"
       composer = "By Robert Schumann,"
       arranger = "simplified by F. Brandeis."
       meter = "Andante espressivo."
     }

     global = {
        \time 4/4
        \key f \major
     }

     upper = \relative c' {
       \clef treble

       \partial 4*1
       c4(
       \repeat volta 2 { f2~ f8 e f a)
       c( f) f2( e8 d)
       c( f g, a bes d f, g)
       a c g2 c,4(
       f2~ f8 e f a)
       c( a') a4.( g8 f e
       f a d, f e4. ees8
       d g, e'4 c4.) c,8 }
       f2~( f8) e f a
       c ees ees2 d8( c
       bes d g, a bes g r a g4. d8 <bes d>4) r8 f'
       bes2( c8)( a bes d)
       f( bes bes2) a8 g
       f( a d, e f d) r e(
       d a) r a a4 g8\fermata c,(
       f2~ f8 e f a)
       c( f) f2( e8 d)
       c( f g, a bes d f, g
       a c g2) c,4
       f2~( f8 e f a)
       c a' a4.\fermata g8( f d
       c f) g,( a bes d) g,( a
       bes d) d,( e f4) \bar ".|."
     }

     lower = \relative c {
       \clef bass

       \partial 4*1
       r4
       \repeat volta 2 { f( a c a)
       f( d'2 c8 bes)
       a4( bes8 a) g4( a8 g)
       f( a c d c bes g) a
       f4( a c a)
       f'( cis e a,)
       d( f8 aes, g c e a,
       b4 a8 b c d bes g) }
       a4( c f, c')
       a( g fis a)
       g4.( c8 d4) bes8( c
       bes d g, a~ a g4 a8)
       bes4( d e d)
       bes( g cis e)
       d( f8 g a4) f8( g)
       f4( d8 e f bes, e)\fermata r
       f,4( a c a)
       f( d'2 c8 bes)
       a4( bes8 a g4 a8 g)
       f( a c d c bes g a)
       f4( a c a)
       f( b8 d e4 g,)
       a bes8( a g4) bes8( a
       g4) bes8( e, <f a>4) \bar ".|."
     }

     dynamics = {
       \partial 4*1
       s4\p
       \repeat volta 2 { s1
       s
       s4 s8\> s\! s4 s8\< s\!
       s4 s2\> s8\! s
       s2 s4\< s\!
       s4 s\sfz s2
       s4.\> s8\! s2
       s1^\markup { \italic rit. } }
       s4 s\< s s8 s\!
       s1
       s
       s
       s
       s2..\< s8\!
       s4 s8\< s\! s2
       s2..^\markup { \italic rit. } s8\p
       s2^\markup { \italic a tempo. } s8 s\< s s\!
       s1
       s
       s
       s2 s4.\< s8\!
       s4 s4.\sfz s8\> s s\!
       s1^\markup { ritardando. }
       s\pp
     }

     tempomod = {
       \partial 4*1
       s4
       \repeat volta 2 { s1 s s s s s s
       s8 \tempo 4=58 s \tempo 4=56 s \tempo 4=54 s \tempo 4=52 s \tempo 4=50 s \tempo 4=48 s \tempo 4=46 s \tempo 4=60 }
       s1 s s s s s s
       s8 \tempo 4=57 s \tempo 4=54 s \tempo 4=51 s \tempo 4=48 s \tempo 4=45 s \tempo 4=20 s \tempo 4=40 s \tempo 4=60
       s1 s s s s
       s2 \tempo 4=35 s8 \tempo 4=60 s4.
       s8 \tempo 4=59 s \tempo 4=58 s \tempo 4=57 s \tempo 4=56 s \tempo 4=55 s \tempo 4=54 s \tempo 4=53 s \tempo 4=52
       s8 \tempo 4=51 s \tempo 4=50 s \tempo 4=49 s \tempo 4=48 s \tempo 4=47 s \tempo 4=46 s4
     }


     \score {
       \context PianoStaff <<
         \context Staff=upper \global \upper
         \context Dynamics=dynamics \dynamics
         \context Staff=lower <<
           \global
           \lower
         >>
       >>
       \layout {
         \context {
           \type "Engraver_group_engraver"
           \name Dynamics
           \alias Voice % So that \cresc works, for example.
           \consists "Output_property_engraver"

           minimumVerticalExtent = #'(-1 . 1)

           \consists "Script_engraver"
           \consists "Dynamic_engraver"
           \consists "Text_engraver"

           \override TextScript #'font-size = #2
           \override TextScript #'font-shape = #'italic
           \override DynamicText #'extra-offset = #'(0 . 2.5)
           \override Hairpin #'extra-offset = #'(0 . 2.5)

           \consists "Skip_event_swallow_translator"

           \consists "Axis_group_engraver"
         }
         \context {
           \PianoStaff
           \accepts Dynamics
           \override VerticalAlignment #'forced-distance = #7
         }
       }
     }

     \score {
       \unfoldrepeats {
       \context PianoStaff <<
          \context Staff=upper \global \upper
         \context Dynamics=dynamics \dynamics
         \context Staff=lower <<
           {\global \lower }
           \tempomod
         >>
       >> }
       \midi { \tempo 4=60
         \context {
           \type "Performer_group_performer"
           \name Dynamics
           \consists "Span_dynamic_performer"
           \consists "Dynamic_performer"
         }
         \context {
           \PianoStaff
           \accepts Dynamics
         }
       }
     }
