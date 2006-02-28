Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Sylvano Carrasco" <carrasco@caronadesigns.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000101c63c8b$96f42060$1c02a8c0@mackenzie>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0002_01C63C61.AE1E1860"
Subject: [Bluez-users] SDPD not starting on ARM Linux
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
Date: Tue, 28 Feb 2006 12:22:44 -0500

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C63C61.AE1E1860
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to port Bluez to my ARM-based Linux platform.  I have had
success enabling BlueZ in my Kernel and I cross-compiled the libs and =
utils
(v2.25).  Everything seems to work except for SDPD.  I can run utilities
like hciconfig and hcitools and I can detect other devices and I can =
even
set up RFCOMM connections using "rfcomm listen" and "rfcomm connect".
However SDPD won't run on my system.  I execute it and I don't see it.  =
It
is almost like it is crashing.  I don't see it when I run "ps".  I can =
see
hcid running.  I do have SDPS in my Bluetooth startup script.

=20

Has anyone else had problems on an ARM based system.  I searched the web =
but
haven't found anyone having similar problems.

=20

On my Debian Linux PC (x86), SDPD runs fine.

=20

Sylvano Carrasco

=20


------=_NextPart_000_0002_01C63C61.AE1E1860
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to port Bluez to my ARM-based Linux
platform.&nbsp; I have had success enabling BlueZ in my Kernel and I
cross-compiled the libs and utils (v2.25).&nbsp; Everything seems to =
work
except for SDPD.&nbsp; I can run utilities like hciconfig and hcitools =
and I
can detect other devices and I can even set up RFCOMM connections using =
&#8220;rfcomm
listen&#8221; and &#8220;rfcomm connect&#8221;.&nbsp; However SDPD =
won&#8217;t
run on my system.&nbsp; I execute it and I don&#8217;t see it.&nbsp; It =
is
almost like it is crashing.&nbsp; I don&#8217;t see it when I run =
&#8220;ps&#8221;.&nbsp;
I can see hcid running.&nbsp; I do have SDPS in my Bluetooth startup =
script.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Has anyone else had problems on an ARM based =
system.&nbsp; I
searched the web but haven&#8217;t found anyone having similar =
problems.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>On my Debian Linux PC (x86), SDPD runs =
fine.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sylvano Carrasco</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0002_01C63C61.AE1E1860--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
