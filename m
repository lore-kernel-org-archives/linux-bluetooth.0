Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5CFCE.629DC9E1"
Message-ID: <4CA6E08AA4616B4FB0BAC7A889A3E9F00439A327@pdsmsx404>
From: "Wu, Jieke" <jieke.wu@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] pand question about NAP
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
Date: Thu, 13 Oct 2005 16:16:15 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5CFCE.629DC9E1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, all

       After following the HowTo
http://bluez.sourceforge.net/contrib/HOWTO-PAN

I have set up a PAN with NAP mode, which supports several BT terminals.
Such as BT host: 10.0.0.1, BT client: 10.0.0.2, 10.0.0.3, 10.0.0.4.....

Also on my Linux Host, I use a bridge (8021Ethernet Bridge) to connect
my BT host Ethernet interface and my LAN interface (eth0). They can work
well among my subnet. But it can not go out to access LAN. I found I can
not ping any machine in my LAN when I add eth0 to bridge, even with my
eth0 interface(that's strange, I don't think bridge will impact my LAN).
But before this operation, I am sure it is connected.=20

=20

[root@federa root]# brctl show

bridge name     bridge id               STP enabled     interfaces

pan0            8000.000bace8633e       no           eth0

bnep0

bnep1

=20

[root@federa root]# ping -I eth0 192.168.1.101

PING 192.168.1.101 (192.168.1.101) from 172.16.217.59 eth0: 56(84) bytes
of data.

>From 172.16.217.59 icmp_seq=3D1 Destination Host Unreachable

>From 172.16.217.59 icmp_seq=3D2 Destination Host Unreachable

>From 172.16.217.59 icmp_seq=3D3 Destination Host Unreachable

=20

=20

Any hints?? Thanks

=20

BTW: pand version 2.21, lib version 2.21, kernel 2.6.9.


------_=_NextPart_001_01C5CFCE.629DC9E1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>Hi, =
all<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; After
following the HowTo <a =
href=3D"http://bluez.sourceforge.net/contrib/HOWTO-PAN">http://bluez.sour=
ceforge.net/contrib/HOWTO-PAN</a><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2 =
face=3D"Comic Sans MS"><span
lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>I =
have set up a
PAN with NAP mode, which supports several BT terminals. Such as BT host:
10.0.0.1, BT client: 10.0.0.2, 10.0.0.3, =
10.0.0.4&#8230;..<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2 =
face=3D"Comic Sans MS"><span
lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>Also =
on my
Linux Host, I use a bridge (<st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">8021Ethernet</st1:PlaceName>
 <st1:PlaceType w:st=3D"on">Bridge</st1:PlaceType></st1:place>) to =
connect my BT
host Ethernet interface and my LAN interface (eth0). They can work well =
among
my subnet. But it can not go out to access LAN. I found I can not ping =
any machine
in my LAN when I add eth0 to bridge, even with my eth0 =
interface(that&#8217;s
strange, I don&#8217;t think bridge will impact my LAN). But before this
operation, I am sure it is connected. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>[root@federa root]# brctl =
show<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
STP enabled&nbsp;&nbsp;&nbsp;&nbsp; =
interfaces<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>pan0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
8000.000bace8633e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
eth0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:252.0pt;text-indent:21.0pt'><font size=3D2
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:10.5pt'>bnep0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:252.0pt;text-indent:21.0pt'><font size=3D2
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:10.5pt'>bnep1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>[root@federa root]# ping -I eth0 =
192.168.1.101<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><font size=3D2 face=3D"Times =
New Roman"><span
 lang=3DEN-US =
style=3D'font-size:10.5pt'>PING</span></font></st1:place><span
lang=3DEN-US> 192.168.1.101 (192.168.1.101) from 172.16.217.59 eth0: =
56(84) bytes
of data.<o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>From 172.16.217.59 icmp_seq=3D1 Destination =
Host
Unreachable<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>From 172.16.217.59 icmp_seq=3D2 Destination =
Host
Unreachable<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>From 172.16.217.59 icmp_seq=3D3 Destination =
Host
Unreachable<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2 =
face=3D"Comic Sans MS"><span
lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>Any =
hints?? Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2 =
face=3D"Comic Sans MS"><span
lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2 =
face=3D"Comic Sans MS"><span
lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>BTW: =
pand
version 2.21, lib version 2.21, kernel =
2.6.9.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5CFCE.629DC9E1--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
