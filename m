Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 1 Aug 2006 12:40:19 -0700
Message-ID: <DDBA30BC801ABE439B575D8A7AA341360295E34C@SJEXCH03.ds.jdsu.net>
From: "Atif Ikram" <Atif.Ikram@jdsu.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] BlueZ 3.2/libdbus 0.91 cross compile issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1106033875=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1106033875==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B5A2.526895BA"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6B5A2.526895BA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

=20

I am trying to cross compile BlueZ 3.2 for ARM. The configure script
said it needed libdbus version > 0.35.  So I downloaded libdbus 0.91,
however, I cannot configure the libdbus script to generate Makefiles for
ARM processor running Linux.  Can someone please help and tell me how to
cross compile libdbus 0.91on ARM ??  My compiler name is arm-linux-gcc.
I am using following command for libdbus:

=20

./configure -host=3Darm-linux -prefix=3D/mypath

=20

Atif


------_=_NextPart_001_01C6B5A2.526895BA
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
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
font-family:Arial'>Hello all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to cross compile BlueZ 3.2 for ARM. The
configure script said it needed libdbus version &gt; 0.35.&nbsp; So I
downloaded libdbus 0.91, however, I cannot configure the libdbus script =
to
generate Makefiles for ARM processor running Linux.&nbsp; Can someone =
please
help and tell me how to cross compile libdbus 0.91on ARM ??&nbsp; My =
compiler
name is arm-linux-gcc.&nbsp; I am using following command for =
libdbus:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>./configure &#8211;host=3Darm-linux =
&#8211;prefix=3D/mypath<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Atif<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6B5A2.526895BA--


--===============1106033875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1106033875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1106033875==--
