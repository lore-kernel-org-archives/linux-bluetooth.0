Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2008 17:43:30 +0530
Message-ID: <2E7899FA2A83AB4480078DA88C8F10FB0BC252B2@HYD-MDP-MBX01.wipro.com>
From: <murthy.voleti@wipro.com>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez porting
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5813372295978891406=="
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============5813372295978891406==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91D75.6CA7CA1A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91D75.6CA7CA1A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am working on a study to port Linux Bluez library onto Symbian OS.
Kindly give me details about

=20

=3D=3D>     is it feasible to port Bluez on Symbian OS

=3D=3D>     What are all the depended libraries Bluez inturn depends on? =


=3D=3D>     Kindly provide list of all libraries.

=3D=3D>     Whether the dependent libraries are already ported on =
Symbian
os?

=3D=3D>     Looks like there are sys/signals.h problems while porting.

=3D=3D>     Any other useful information.

=20

Regards

Voleti=20


------_=_NextPart_001_01C91D75.6CA7CA1A
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1946498377;
	mso-list-type:hybrid;
	mso-list-template-ids:-1166536184 -1571256348 67698691 67698693 =
67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0E8;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am working on a study to port Linux Bluez library =
onto
Symbian OS. &nbsp;Kindly give me details =
about<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>is it
feasible to port Bluez on Symbian OS<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>What are all
the depended libraries Bluez inturn depends on? =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Kindly
provide list of all libraries.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Whether the
dependent libraries are already ported on Symbian =
os?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Looks like
there are sys/signals.h problems while =
porting.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'><span
style=3D'mso-list:Ignore'>&egrave;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Any other
useful information.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Voleti <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C91D75.6CA7CA1A--


--===============5813372295978891406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============5813372295978891406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============5813372295978891406==--
