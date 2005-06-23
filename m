Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C577F1.FCB018F0"
Message-Id: <20050623104846.8137A1EA7F3@mrelay1.st2.lyceu.net>
Subject: [Bluez-users] Can"t connect RFCOMM socket: resource temporarily unavailable
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
Date: Thu, 23 Jun 2005 12:49:25 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C577F1.FCB018F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everybody

=20

I=92m running Fedora Core 4 (Linux Kernel 2.4.11) and have a =
Conceptronic
CBT100U USB Dongle.

=20

I have this device UP, and I can other devices (a Windows XP PC).

=20

I have modified the file /etc/bluetooth/rfcomm.conf including (as read =
in
some tutorials):

            Rfcomm0{

                        Bind yes;

                        Device <win xp mac>;

                        Channel 1;

                        Comment =93TDK-BT=94;

            }

=20

I have also created a file: /etc/Bluetooth/my-pin:

            #! /bin/bash

            Echo =93PIN:1111=94

=20

In /etc/Bluetooth/hcid.conf I have changed the line corresponding to =
=93pin
helper=94 to:

            Pin_helper/etc/Bluetooth/my-pin

=20

=20

If I start gnome =93file sharing=94 utility, I can send files from my =
Linux box
to the Win XP one (no Pin message is shown).

=20

If I state: =93rfcomm connect /dev/rfcomm0 <mac> 1=94, I can see in my =
Win XP Pc
a message to set the PIN, I put 1111, and press enter. When a time is
elapsed, the message =93Can"t connect RFCOMM socket: resource =
temporarily
unavailable=94 appears

=20

Some idea of what is going wrong??

=20

Thanks in advance

=20

Regards

=20

=20

Esther L=F3pez Casariego


------=_NextPart_000_0010_01C577F1.FCB018F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:Arial;}
h1
	{margin-top:9.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:39.6pt;
	text-align:justify;
	text-indent:-21.6pt;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:Arial;}
h2
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:46.8pt;
	text-align:justify;
	text-indent:-28.8pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	font-style:italic;}
h3
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:54.0pt;
	text-indent:-36.0pt;
	page-break-after:avoid;
	font-size:13.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EstiloCorreo17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:21.0cm 841.95pt;
	margin:70.9pt 3.0cm 70.9pt 3.0cm;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>Hi
everybody</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>I&#8217;m running Fedora Core 4 (Linux Kernel 2.4.11) and have a =
Conceptronic
CBT100U USB Dongle.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>I have this device UP, and I can other devices (a Windows XP =
PC).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>I have modified the file /etc/bluetooth/rfcomm.conf including =
(as read
in some tutorials):</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Rfcomm0{</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 Bind yes;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 Device &lt;win xp mac&gt;;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 Channel 1;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 Comment &#8220;TDK-BT&#8221;;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>I have also created a file: =
/etc/Bluetooth/my-pin:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #! /bin/bash</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Echo =
&#8220;PIN:1111&#8221;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>In /etc/Bluetooth/hcid.conf I have changed the line =
corresponding to &#8220;pin
helper&#8221; to:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Pin_helper/etc/Bluetooth/my-pin</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>If I start gnome &#8220;file sharing&#8221; utility, I can send =
files
from my Linux box to the Win XP one (no Pin message is =
shown).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>If I state: &#8220;rfcomm connect /dev/rfcomm0 &lt;mac&gt; =
1&#8221;, I
can see in my Win XP Pc a message to set the PIN, I put 1111, and press =
enter.
When a time is elapsed, the message &#8220;Can&quot;t connect RFCOMM =
socket:
resource temporarily unavailable&#8221; appears</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>Some idea of what is going wrong??</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>Thanks in advance</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>Regards</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-weight:bold'>Esther L=F3pez =
Casariego</span></font></b></p>

</div>

</body>

</html>

------=_NextPart_000_0010_01C577F1.FCB018F0--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
