Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5DBA7.819C9705"
Message-ID: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EE90C@pdsmsx404>
From: "Wu, Jieke" <jieke.wu@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] BT-alsa with HT820(MOTO)
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
Date: Fri, 28 Oct 2005 18:08:11 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5DBA7.819C9705
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi: all

       I have enabled the link with HT820 on my 2.6.9 kernel (PC), also
I can send the data with ACL to MOTO headset, below is something hcidump
catched. But still no any audio output can be listened on headset part.
Any one can deliver some hint? Thanks.

=20

=20

> ACL data: handle 47 flags 0x02 dlen 8

    L2CAP(d): cid 0x0041 len 4 [psm 25]

      AVDTP(s): Discover rsp: transaction 0

        ACP SEID 1 - Audio Sink

< ACL data: handle 47 flags 0x02 dlen 7

    L2CAP(d): cid 0x0051 len 3 [psm 25]

      AVDTP(s): Capabilities cmd: transaction 1

        ACP SEID 1

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 47 flags 0x02 dlen 16

    L2CAP(d): cid 0x0041 len 12 [psm 25]

      AVDTP(s): Capabilities rsp: transaction 1

        Media Transport

        Media Codec - SBC

          16kHz 32kHz 44.1kHz 48kHz=20

          Mono DualChannel Stereo JointStereo=20

          4 8 12 16 Blocks

          4 8 Subbands

          SNR Loudness=20

          Bitpool Range 2-250

< ACL data: handle 47 flags 0x02 dlen 18

    L2CAP(d): cid 0x0051 len 14 [psm 25]

      AVDTP(s): Set config cmd: transaction 2

        ACP SEID 1 - INT SEID 1

        Media Transport

        Media Codec - SBC

          44.1kHz=20

          Stereo=20

          16 Blocks

          8 Subbands

          SNR=20

          Bitpool Range 2-250

< ACL data: handle 47 flags 0x02 dlen 192

< ACL data: handle 47 flags 0x01 dlen 192

< ACL data: handle 47 flags 0x01 dlen 192

< ACL data: handle 47 flags 0x01 dlen 49

    L2CAP(d): cid 0x0052 len 621 [psm 25]

      AVDTP(m): ver 2 cc 0 pt 1 seqn 2 time 128 ssrc 1

> HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 47 flags 0x02 dlen 192

> HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 47 flags 0x01 dlen 192

< ACL data: handle 47 flags 0x01 dlen 192

< ACL data: handle 47 flags 0x01 dlen 49

    L2CAP(d): cid 0x0052 len 621 [psm 25]

      AVDTP(m): ver 2 cc 0 pt 1 seqn 3 time 256 ssrc 1

> HCI Event: Number of Completed Packets


------_=_NextPart_001_01C5DBA7.819C9705
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
 name=3D"place" downloadurl=3D"http://www.5iantlavalamp.com/"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
@font-face
	{font-family:"\@&#23435;&#20307;";
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
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>Hi: =
all<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I
have enabled the link with HT820 on my 2.6.9 kernel (PC), also I can =
send the
data with ACL to MOTO headset, below is something hcidump catched. But =
still no
any audio output can be listened on headset part. Any one can deliver =
some
hint? Thanks.<o:p></o:p></span></font></p>

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
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; ACL data: =
handle 47
flags 0x02 dlen 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0041 len 4 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(s): Discover rsp: transaction 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ACP SEID 1 - Audio Sink<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x02 dlen 7<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0051 len 3 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(s): Capabilities cmd: transaction 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ACP SEID 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; ACL data: =
handle 47
flags 0x02 dlen 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0041 len 12 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(s): Capabilities rsp: transaction 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Media Transport<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Media Codec - SBC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
16kHz 32kHz 44.1kHz 48kHz <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Mono DualChannel Stereo JointStereo <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4 8 12 16 Blocks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4 8 Subbands<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SNR Loudness <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">Bitpool</st1:PlaceName> <st1:PlaceType
 w:st=3D"on">Range</st1:PlaceType></st1:place> =
2-250<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x02 dlen 18<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0051 len 14 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(s): Set config cmd: transaction 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ACP
SEID 1 - INT SEID 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Media Transport<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Media Codec - SBC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
44.1kHz <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Stereo <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
16 Blocks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8 Subbands<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SNR <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">Bitpool</st1:PlaceName> <st1:PlaceType
 w:st=3D"on">Range</st1:PlaceType></st1:place> =
2-250<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x02 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 49<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0052 len 621 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(m): ver 2 cc 0 pt 1 seqn 2 time 128 ssrc =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x02 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&lt; ACL data: =
handle 47
flags 0x01 dlen 49<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0052 len 621 [psm 25]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans =
MS"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
AVDTP(m): ver 2 cc 0 pt 1 seqn 3 time 256 ssrc =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Comic Sans MS"><span =
lang=3DEN-US
style=3D'font-size:11.0pt;font-family:"Comic Sans MS"'>&gt; HCI Event: =
Number of
Completed Packets<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5DBA7.819C9705--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
