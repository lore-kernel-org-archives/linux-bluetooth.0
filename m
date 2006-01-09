Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "pdjj14" <pdjj14@gmail.com>
To: <bluez-devel@lists.sourceforge.net>, <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAwZyW1fiQXke0+pFdteryAwEAAAAA@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01C61574.1A7F0740"
In-Reply-To: <20060109093125.79949.qmail@web37004.mail.mud.yahoo.com>
Subject: [Bluez-devel] a2play error...
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 9 Jan 2006 23:26:19 +0900

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C61574.1A7F0740
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

Hi~

 My environment is 'Redhat9(kernel 2.4.20-8) + bluez-utils,-libs-2.24 +
bluez-hcidump-1.18 + alsa-libs-1.0.10 + btsco-0.41 + mpg123-0.59r-4'.

 The module that I loaded is 'l2cap'.

 'rfcomm' and 'sco' didn't be loaded.

 'bluez' and 'hci_usb' already be loaded.

 When I type the command 'mpg123 --au - 01.mp3 | ./a2play -p
00:0d:e6:00:9a:2f' with option 'p(pthread)', I can listen the music.

 But, the music played just 3~5 seconds.

 If I type the command without option 'p', the music repeats 'play and
pause'. And, the music played just 3~5 seconds. This is same to use the
option 'p'.

 I want to listen the music to running time of the music.

 I am modifying the code 'a2play.c'.

 Is correct what I do?

 I want to know good methods.

 What do I do to solve my problem?

=20

 This is output, when I type the command 'mpg123 --au - 01.mp3 | =
./a2play -
p 00:0d:e6:00:9a:2f'

             [root@wooki btsco-0.41]# mpg123 --au - 01.mp3 | ./a2play -p
00:0d:e6:00:9a:2f

             subbands =3D 8 blocks =3D 16 bitpool =3D 32

             High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, =
2
and 3.

             Version 0.59r (1999/Jun/15). Written and copyrights by =
Michael
Hipp.

             Uses code from various people. See 'README' for more!

             THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT =
YOUR
OWN      RISK!

             Title  : 01 =C0=CC=BA=B0=BF=A1 =B4=EB=C3=B3=C7=CF=B4=C2 =
=BF=EC=B8=AE=C0=C7 =C0=DA=BC=BC  Artist: =C0=CC=BD=C2=C8=AF

             Album  : =B3=A1=C0=E5 Live Concert               Year  :

             Comment:                                 Genre : Other

             Playing MPEG stream from 01.mp3 ...

             Junk at the beginning 49443303

             MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo

             len=3D2048

             Header size=3D32

             Sample Rate:44100

             Channels:2

             Using address: 00:0d:e6:00:9a:2f

             Found A2DP Sink

             Found A2DP Sink at the destination

             Connected [imtu 672, omtu 895, flush_to 65535]

             Sent the Stream End Point Discovery Command

             Got a Stream End Point Discovery Response

             received 1 capabilities

             SEID =3D 1

             Requested Capabilities for SEID =3D 1

             Got capabilities response

             Sent set configurations command

             Set configurations command accepted

             Sent open stream command

             Got open stream confirm

             Connected [imtu 672, omtu 895, flush_to 65535]

             Sent stream start

             Got start stream confirm

             write failed: Connection reset by peer

             Sent 354 packets

             joining thread

             closing rtc

             closing stream

             closing control connection

=20

Thank you...

Have a nice day~

=20


------=_NextPart_000_0018_01C61574.1A7F0740
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dks_c_5601-1987">
<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>

<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Gulim;
	color:navy;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:99.25pt 3.0cm 3.0cm 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DKO link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>Hi~<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;My =
environment is
'Redhat9(kernel 2.4.20-8) + bluez-utils,-libs-2.24 + bluez-hcidump-1.18 =
+
alsa-libs-1.0.10 + btsco-0.41 + =
mpg123-0.59r-4'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;The =
module that I loaded
is 'l2cap'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;'rfcomm' =
and 'sco'
didn't be loaded.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;'bluez' =
and 'hci_usb'
already be loaded.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;When I =
type the command
'mpg123 --au - 01.mp3 | ./a2play -p <st1:time o:ls=3D"trans" Hour=3D"0" =
Minute=3D"0"
w:st=3D"on">00:0</st1:time>d:e6:<st1:time o:ls=3D"trans" Hour=3D"0" =
Minute=3D"9" w:st=3D"on">00:9</st1:time>a:2f'
with option 'p(pthread)', I can listen the =
music.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;But, the =
music played
just 3~5 seconds.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;If I =
type the command
without option 'p', the music repeats 'play and pause'. And, the music =
played
just 3~5 seconds. This is same to use the option =
'p'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;I want =
to listen the
music to running time of the music.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;I am =
modifying the code
'a2play.c'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;Is =
correct what I do?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;I want =
to know good
methods.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;What do =
I do to solve my
problem?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;This is =
output, when I
type the command 'mpg123 --au - 01.mp3 | ./a2play -p <st1:time =
o:ls=3D"trans"
Hour=3D"0" Minute=3D"0" w:st=3D"on">00:0</st1:time>d:e6:<st1:time =
o:ls=3D"trans"
Hour=3D"0" Minute=3D"9" =
w:st=3D"on">00:9</st1:time>a:2f'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [root@wooki
btsco-0.41]# mpg123 --au - 01.mp3 | ./a2play -p =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <st1:time
o:ls=3D"trans" Hour=3D"0" Minute=3D"0" =
w:st=3D"on">00:0</st1:time>d:e6:<st1:time
o:ls=3D"trans" Hour=3D"0" Minute=3D"9" =
w:st=3D"on">00:9</st1:time>a:2f<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; subbands =3D 8
blocks =3D 16 bitpool =3D 32<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; High
Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and =
3.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version
0.59r (1999/Jun/15). Written and copyrights by Michael =
Hipp.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Uses code
from various people. See 'README' for more!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; THIS
SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN =
&nbsp;&nbsp;&nbsp;&nbsp; RISK!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3D&#44404;&#47548;><span =
style=3D'font-size:10.0pt;font-family:Gulim'>Title&nbsp;
: 01 =C0=CC=BA=B0=BF=A1 =B4=EB=C3=B3=C7=CF=B4=C2 =BF=EC=B8=AE=C0=C7
=C0=DA=BC=BC&nbsp; Artist: <st1:PersonName =
w:st=3D"on">=C0=CC=BD=C2=C8=AF</st1:PersonName><o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Album&nbsp; : =B3=A1=C0=E5
Live =
Concert&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Year&nbsp; :<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Comment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Genre : Other<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Playing MPEG stream
from 01.mp3 ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Junk at the beginning
49443303<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPEG 1.0 layer III, 128
kbit/s, 44100 Hz joint-stereo<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3D&#44404;&#47548;><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:Gulim'>len=3D2048<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header
size=3D32<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sample
Rate:44100<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Channels:2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Using
address: <st1:time o:ls=3D"trans" Hour=3D"0" Minute=3D"0" =
w:st=3D"on">00:0</st1:time>d:e6:<st1:time
o:ls=3D"trans" Hour=3D"0" Minute=3D"9" =
w:st=3D"on">00:9</st1:time>a:2f<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Found A2DP
Sink<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Found A2DP
Sink at the destination<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connected
[imtu 672, omtu 895, flush_to 65535]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent the
Stream End Point Discovery Command<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Got a Stream
End Point Discovery Response<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; received 1
capabilities<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SEID =3D =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Requested
Capabilities for SEID =3D 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Got
capabilities response<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent set
configurations command<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set
configurations command accepted<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent open
stream command<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Got open
stream confirm<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connected
[imtu 672, omtu 895, flush_to 65535]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent stream
start<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Got start
stream confirm<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write
failed: Connection reset by peer<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent 354
packets<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; joining
thread<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; closing =
rtc<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; closing
stream<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; closing
control connection<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Gulim'>Thank =
you...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D&#44404;&#47548;><span
style=3D'font-size:10.0pt;font-family:Gulim'>Have a nice =
day~<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy =
face=3D&#44404;&#47548;><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Gulim;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0018_01C61574.1A7F0740--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
