Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Date: Wed, 17 Jun 2009 18:07:44 +0530
Subject: HSP Ring command
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068E39C1D@CHEXMB-01.global.atheros.com>
Content-Type: multipart/alternative;
	boundary="_000_44EE5C37ADC36343B0625A05DD408C485068E39C1DCHEXMB01globa_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_44EE5C37ADC36343B0625A05DD408C485068E39C1DCHEXMB01globa_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
I am running HSP profile test cases with PTS tool.
I am using Ubuntu 9.04 with Bluez 4.32.

For all HSP test cases, PTS is expecting RING command from IUT.
>From our analysis, headset_send(hs, "\r\nRING\r\n"); " in audio/headset.c i=
s not getting initiated.
I am thinking, RING command is suppose to send by dbus as we register the c=
all backs. But dbus is not triggering the RING command.
Is this expected behavior in BlueZ?
What version of BlueZ and dbus do we need to use for better performance?

Please clarify.

Thanks,
Jothi


--_000_44EE5C37ADC36343B0625A05DD408C485068E39C1DCHEXMB01globa_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi Marcel,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am running HSP profile test cases with PTS tool.<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am using Ubuntu 9.04 with Bluez 4.32.<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>For all HSP test cases, PTS is expecting RING command fr=
om IUT.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>From our analysis, headset_send(hs, <font color=3Dmaroon=
><span
style=3D'color:maroon'>&quot;\r\nRING\r\n&quot;</span></font>); &#8220; in =
audio/headset.c
is not getting initiated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am thinking, RING command is suppose to send by dbus a=
s we
register the call backs. But dbus is not triggering the RING command. <o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Is this expected behavior in BlueZ? &nbsp;<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>What version of BlueZ and dbus do we need to use for bet=
ter
performance?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Please clarify.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Jothi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_44EE5C37ADC36343B0625A05DD408C485068E39C1DCHEXMB01globa_--
