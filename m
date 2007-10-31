Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 31 Oct 2007 10:02:18 +0100
MIME-Version: 1.0
Message-ID: <56C8D22F4B7F104DBE581411F10682E9268D56@beyondsoft.dyndns.org>
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
From: "Matthias Becker" <matthias.becker@beyondsoft.de>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multi-frequency scanning & possible contract work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1415765313=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1415765313==
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81B9C.BD62638A"
content-class: urn:content-classes:message

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81B9C.BD62638A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

A scan takes about 10 seconds. Only the name resolution takes that long.
Names can be resolved in parallel using many adapters.

=20

Von: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] Im Auftrag von Paul
Huber
Gesendet: Dienstag, 30. Oktober 2007 21:06
An: bluez-devel@lists.sourceforge.net
Betreff: [Bluez-devel] multi-frequency scanning & possible contract work

=20

I need to use a directional antenna focused on an area about 6 meters x
6 meters that can scan for Bluetooth mobile phones as they pass through
the area, and identify them very quickly.  It's for a new startup
business that's focusing on a retail application running on an embedded
Linux box.=20

The problem with the usual usb Bluetooth dongle and a normal scan is
that in a busy area with hundreds of Bluetooth phones nearby, the scan
can take a very long time, like several minutes, and will pick up lots
of phones of people all over the store.  We just want to detect them
when they come in through the entrance.  So, we're going to use a
directional antenna that focuses just on a 6 meter x 6 meter space in
front of the entrance so it doesn't pick up phones outside that area.=20

However there's still a problem that a traditional Bluetooth scan takes
15+ seconds to pickup devices, and that's too long.  The shopper may
pass through the detection area in only a couple seconds.  So we need to
be able to do the scans very quickly.=20

I don't know that much about the underlying technology, but I understand
that a typical Bluetooth scan consists of scanning across several
frequencies and hopping from frequency to frequency to find phones on
each frequency.  Therefore, my question is this: instead of having 1
bluetooth dongle that's hopping across several frequencies, can we hook
up multiple bluetooth dongles to the same antenna, and have each one
locked onto just one frequency to make the process go faster?  In other
words, can we balance the 15 second scanning process across 5 Bluetooth
dongles so we can do the same scan in only 3 seconds?=20

If not, does anybody else have any suggestions for how to accomplish the
end goal of being able to very rapidly detect phones as they pass
through an area?

We do have a little bit of funding, so if something like the
multi-dongle approach method i mentioned works, and it requires some
special coding or mods to bluez, we could compensate a developer for
helping out with this.=20

Thanks


------_=_NextPart_001_01C81B9C.BD62638A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>A scan takes about 10 seconds. Only the name resolution =
takes
that long. Names can be resolved in parallel using many =
adapters.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0cm 0cm 0cm'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>Von:</span><=
/b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] <b>Im Auftrag von =
</b>Paul
Huber<br>
<b>Gesendet:</b> Dienstag, 30. Oktober 2007 21:06<br>
<b>An:</b> bluez-devel@lists.sourceforge.net<br>
<b>Betreff:</b> [Bluez-devel] multi-frequency scanning &amp; possible =
contract
work<o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>I need to use a =
directional
antenna focused on an area about 6 meters x 6 meters that can scan for
Bluetooth mobile phones as they pass through the area, and identify them =
very
quickly.&nbsp; It's for a new startup business that's focusing on a =
retail application
running on an embedded Linux box. <br>
<br>
The problem with the usual usb Bluetooth dongle and a normal scan is =
that in a
busy area with hundreds of Bluetooth phones nearby, the scan can take a =
very
long time, like several minutes, and will pick up lots of phones of =
people all
over the store.&nbsp; We just want to detect them when they come in =
through the
entrance.&nbsp; So, we're going to use a directional antenna that =
focuses just
on a 6 meter x 6 meter space in front of the entrance so it doesn't pick =
up
phones outside that area. <br>
<br>
However there's still a problem that a traditional Bluetooth scan takes =
15+
seconds to pickup devices, and that's too long.&nbsp; The shopper may =
pass
through the detection area in only a couple seconds.&nbsp; So we need to =
be
able to do the scans very quickly. <br>
<br>
I don't know that much about the underlying technology, but I understand =
that a
typical Bluetooth scan consists of scanning across several frequencies =
and
hopping from frequency to frequency to find phones on each =
frequency.&nbsp;
Therefore, my question is this: instead of having 1 bluetooth dongle =
that's
hopping across several frequencies, can we hook up multiple bluetooth =
dongles
to the same antenna, and have each one locked onto just one frequency to =
make
the process go faster?&nbsp; In other words, can we balance the 15 =
second scanning
process across 5 Bluetooth dongles so we can do the same scan in only 3
seconds? <br>
<br>
If not, does anybody else have any suggestions for how to accomplish the =
end
goal of being able to very rapidly detect phones as they pass through an =
area?<br>
<br>
We do have a little bit of funding, so if something like the =
multi-dongle
approach method i mentioned works, and it requires some special coding =
or mods
to bluez, we could compensate a developer for helping out with this. =
<br>
<br>
Thanks<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C81B9C.BD62638A--


--===============1415765313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1415765313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1415765313==--
