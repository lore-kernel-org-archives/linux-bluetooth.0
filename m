Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5DDF9.D423AD3A"
Message-ID: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EF36A@pdsmsx404>
From: "Wu, Jieke" <jieke.wu@intel.com>
To: <bmidgley@xmission.com>, <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Re: BT-alsa with HT820(MOTO)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 Oct 2005 17:02:30 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5DDF9.D423AD3A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Brad:

       Thanks for your advice! I go through the troubleshooting section
you mention blew. Only issue is that I use USB dongle on my PC.=20

       Does it impact my audio connection on ACL? By the way, I have
enabled the SCO link with this dongle and finished some record with

      Arecord,  although the voice quality is not good enough.=20

       And I am confused about Modules api below. could you explain it?
For I think a2play works at user space.=20

       Below is my steps , i hope it is useful.=20

       # ./mpg123 -au file.sun file.mp3               //decode mp3 to
Sun/NeXt audio data: 16bit, linear PCM.

       #./sbcenc file.sun > file.sbc                      //encode PCM
to sbc format

       #./a2play ADDR file.sbc                            //play with
Headset.

      =20

       BTW: I can use the pause/play on Headset......?

=20

=20

      =20

=20

=20

=20

>Jieke
>You may need a current kernel like 2.6.13. Module api changes have
>happened from time to time that give us trouble.
>It could also be your bluetooth adapter. read
>http://bluetooth-alsa.sf.net and go to the troubleshooting section.
That
>will show you how to check the adapter.
>        I have enabled the link with HT820 on my 2.6.9 kernel (PC),
also
> I can send the data with ACL to MOTO headset, below is something
hcidump
> catched. But still no any audio output can be listened on headset
part.
> Any one can deliver some hint? Thanks.
>=20
=20

=20


------_=_NextPart_001_01C5DDF9.D423AD3A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Comic Sans MS";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>Brad:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks
for your advice! I go through the troubleshooting section you mention =
blew. Only
issue is that I use USB dongle on my PC. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Does
it impact my audio connection on ACL? By the way, I have enabled the SCO =
link
with this dongle and finished some record =
with<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&nbsp; =
&nbsp;&nbsp;&nbsp; Arecord,
&nbsp;although the voice quality is not good enough. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And
I am confused about Modules api below. could you explain it? For I think =
a2play
works at user space. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Below
is my steps , i hope it is useful. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
./mpg123 &#8211;au file.sun =
file.mp3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; //decode
mp3 to Sun/NeXt audio data: 16bit, linear =
PCM.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #./sbcenc
file.sun &gt; file.sbc =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //encode
PCM to sbc format<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #./a2play
ADDR =
file.sbc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //play
with Headset.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BTW:
I can use the pause/play on =
Headset&#8230;&#8230;?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;Jieke<o:p></o:p></span></font></pre><pre><=
font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;You may need a current kernel like =
2.6.13. Module api changes have<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;happened from time to time that give us =
trouble.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;It could also be your bluetooth adapter. =
read<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;<a
href=3D"http://bluetooth-alsa.sf.net" =
target=3D"_top">http://bluetooth-alsa.sf.net</a> and go to the =
troubleshooting section. That<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;will show you how to check the =
adapter.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 I have enabled the link with HT820 on my 2.6.9 kernel (PC), =
also<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt; I can send the data with ACL to MOTO =
headset, below is something =
hcidump<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt; catched. But still no any audio output =
can be listened on headset =
part.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt; Any one can deliver some hint? =
Thanks.<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5DDF9.D423AD3A--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
