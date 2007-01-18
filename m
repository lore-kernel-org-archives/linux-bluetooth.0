Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 18 Jan 2007 17:55:34 +0100
Message-ID: <C3135341D7897C468EE77A5BB32124038AAE0C@arion.intra.local>
From: "Richard Marston" <Richard.Marston@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] hidd events
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0965672431=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0965672431==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C73B21.7923F488"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73B21.7923F488
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

=20

Hello

=20

I'm trying to capture hidd remote control events from a Sony Ericsson
K800i.

=20

I have enabled CONFIG_BT_HIDP in the kernel and compiled hidd from the
bluez utils directory.

=20

I can pair with the phone and read "struct input_event" events from
/dev/input/event0. The events can only be read immediately after a key
press so I'm sure they are valid events.

=20

Unfortunately although "time" in each event changes, "type", "code" and
"value" are all always zero. It makes no difference whether I wiggle the
joystick or press the buttons.

=20

Can anyone give me any advice please?

=20

Regards,

Richard Marston | Software Engineer | TomTom | richardmarston@tomtom.com

=20



This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.

------_=_NextPart_001_01C73B21.7923F488
Content-Type: text/HTML;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman";}
a:link, span.MsoHyperlink
=09{color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:Arial;
=09color:windowtext;}
p.section1, li.section1, div.section1
=09{mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman";}
@page Section1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
=09{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Hello<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I&#8217;m trying to capture hidd remote control events=
 from
a Sony Ericsson K800i.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I have enabled CONFIG_BT_HIDP in the kernel and compil=
ed
hidd from the bluez utils directory.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I can pair with the phone and read &#8220;struct input=
_event&#8221;
events from /dev/input/event0. The events can only be read immediately af=
ter a
key press so I&#8217;m sure they are valid events.<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Unfortunately although &#8220;time&#8221; in each even=
t
changes, &#8220;type&#8221;, &#8220;code&#8221; and &#8220;value&#8221; a=
re all
always zero. It makes no difference whether I wiggle the joystick or pres=
s the
buttons.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Can anyone give me any advice please?<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3Dsection1><font size=3D1 color=3Dnavy face=3DArial><span style=3D=
'font-size:
7.5pt;font-family:Arial;color:navy'>Richard Marston</span></font><font si=
ze=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</s=
pan></font><font
size=3D1 color=3Dgray face=3DArial><span style=3D'font-size:7.5pt;font-fa=
mily:Arial;
color:gray'>|&nbsp;Software Engineer | TomTom&nbsp;|</span></font><font s=
ize=3D1
face=3DArial><span style=3D'font-size:7.5pt;font-family:Arial'>&nbsp;<a
href=3D"mailto:richardmarston@tomtom.com">richardmarston@tomtom.com</a></=
span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>


<DIV><P><HR>
This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.
</P></DIV>
</body>

</html>

------_=_NextPart_001_01C73B21.7923F488--


--===============0965672431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0965672431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0965672431==--
