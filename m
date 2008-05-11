Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 11 May 2008 08:51:19 +0800
Message-ID: <094BCE01AFBE9646AF220B0B3F367AAB030C0117@pdsmsx413.ccr.corp.intel.com>
From: "Zhao, Halley" <halley.zhao@intel.com>
To: <bluez-devel@lists.sf.net>
Cc: bluez-users@lists.sf.net
Subject: [Bluez-devel] I can't use 3.31 release,
	but 3.19 release works on the same platform
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1572504505=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1572504505==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B301.20F97ADA"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B301.20F97ADA
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

=A1=A1=A1=A1Hi All:

=A1=A1=A1=A1My Bluetooth earphone is Motorola HT820.=20

=A1=A1=A1=A1

=A1=A1=A1=A11. When I try to use bluez-utils 3.31 on my desktop =
(Ubuntu7.10), there are some issues: (but there is no such issue when I =
use 3.19 version on this same platform). Should I update some other =
package besides bluez-utils and bluez-libs?

=A1=A1=A1=A1"

=A1=A1=A1=A1halley@azhao2ubtg2:~$ aplay =
/home/halley/media/audio/Track27.wav=20

=A1=A1=A1=A1ALSA lib pcm_bluetooth.c:1501:(audioservice_recv) Error =
receiving data from audio service: Success(0)

=A1=A1=A1=A1ALSA lib pcm_bluetooth.c:1517:(audioservice_expect) Bogus =
message BT_GETCAPABILITIES_REQ received while BT_GETCAPABILITIES_RSP was =
expected

=A1=A1=A1=A1aplay: main:545: audio open error: Invalid argument

=A1=A1=A1=A1"

=A1=A1=A1=A1

=A1=A1=A1=A12. When I use bluez-utils 3.19 version, application calls =
snd_pcm_hw_params() sometimes will got return value "1". (The function =
description says it will be 0 for success and negative number for =
failure). The positive value makes me puzzled.

=A1=A1=A1=A1

=A1=A1=A1=A1    /* Apply parameters */

=A1=A1=A1=A1 err =3D snd_pcm_hw_params(m_pAlsaPCMHandle, hwparams);

=A1=A1=A1=A1 if (err < 0)=20

=A1=A1=A1=A1    {

=A1=A1=A1=A1        HXLOGL1 ( HXLOG_ADEV, "snd_pcm_hw_params: %s",=20

=A1=A1=A1=A1                  snd_strerror(err));

=A1=A1=A1=A1        m_wLastError =3D RA_AOE_NOTENABLED;

=A1=A1=A1=A1 }

=A1=A1=A1=A1

=A1=A1=A1=A1    /* read buffer & period sizes */

=A1=A1=A1=A1    snd_pcm_uframes_t buffer_size =3D 0;

=A1=A1=A1=A1    snd_pcm_uframes_t period_size =3D 0;

=A1=A1=A1=A1

=A1=A1=A1=A1    if (err =3D=3D 0)

=A1=A1=A1=A1    {

=20

3. Ubuntu hardy has included bluez-utils 3.26 version; but I found there =
are many XRun errors when I use helix engine.

=20

=20

ZHAO, Halley (Aihua)

Email: halley.zhao@intel.com <mailto:aihua.zhao@intel.com>=20

Tel: +86(21)61166476

iNet: 8821-6476

SSG/OTC/UMD

=20


------_=_NextPart_001_01C8B301.20F97ADA
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:=BA=DA=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=BA=DA=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:10.0pt;
	font-size:10.5pt;
	font-family:"Times New Roman";}
h1
	{margin-top:17.0pt;
	margin-right:0cm;
	margin-bottom:16.5pt;
	margin-left:53.75pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:-21.6pt;
	line-height:240%;
	page-break-after:avoid;
	mso-list:l1 level1 lfo10;
	font-size:22.0pt;
	font-family:"Times New Roman";}
h2
	{margin-top:13.0pt;
	margin-right:0cm;
	margin-bottom:13.0pt;
	margin-left:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:10.0pt;
	line-height:173%;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:Arial;}
h3
	{margin-top:13.0pt;
	margin-right:0cm;
	margin-bottom:13.0pt;
	margin-left:68.15pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:-36.0pt;
	line-height:173%;
	page-break-after:avoid;
	mso-list:l1 level3 lfo10;
	font-size:16.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.StyleHeading1Left1ch, li.StyleHeading1Left1ch, =
div.StyleHeading1Left1ch
	{margin-top:17.0pt;
	margin-right:0cm;
	margin-bottom:16.5pt;
	margin-left:53.75pt;
	text-indent:-21.6pt;
	line-height:240%;
	page-break-after:avoid;
	mso-list:l2 level1 lfo11;
	font-size:22.0pt;
	font-family:"Times New Roman";
	font-weight:bold;}
p.List7, li.List7, div.List7
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
p.List8, li.List8, div.List8
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:21.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:-21.0pt;
	mso-list:l0 level1 lfo8;
	font-size:10.5pt;
	font-family:"Times New Roman";}
p.StyleHeading2Firstline2ch, li.StyleHeading2Firstline2ch, =
div.StyleHeading2Firstline2ch
	{margin-top:13.0pt;
	margin-right:0cm;
	margin-bottom:13.0pt;
	margin-left:60.95pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:-28.8pt;
	line-height:173%;
	page-break-after:avoid;
	mso-list:l1 level2 lfo10;
	font-size:16.0pt;
	font-family:Arial;
	font-weight:bold;}
p.StyleFirstline074cm, li.StyleFirstline074cm, div.StyleFirstline074cm
	{margin-top:5.0pt;
	margin-right:0cm;
	margin-bottom:2.5pt;
	margin-left:0cm;
	mso-para-margin-top:1.0gd;
	mso-para-margin-right:0cm;
	mso-para-margin-bottom:.5gd;
	mso-para-margin-left:0cm;
	text-indent:21.0pt;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"Times New Roman";}
span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1249470;
	mso-list-type:hybrid;
	mso-list-template-ids:484456656 -1587220538 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:"List 8";
	mso-level-text:\F0FC;
	mso-level-tab-stop:21.0pt;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:105731748;
	mso-list-template-ids:-580499146;}
@list l1:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:53.75pt;
	mso-level-number-position:left;
	margin-left:53.75pt;
	text-indent:-21.6pt;}
@list l1:level2
	{mso-level-style-link:"Style Heading 2 + First line\:  2 ch";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:60.95pt;
	mso-level-number-position:left;
	margin-left:60.95pt;
	text-indent:-28.8pt;}
@list l1:level3
	{mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:68.15pt;
	mso-level-number-position:left;
	margin-left:68.15pt;
	text-indent:-36.0pt;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:75.35pt;
	mso-level-number-position:left;
	margin-left:75.35pt;
	text-indent:-43.2pt;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:82.55pt;
	mso-level-number-position:left;
	margin-left:82.55pt;
	text-indent:-50.4pt;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:89.75pt;
	mso-level-number-position:left;
	margin-left:89.75pt;
	text-indent:-57.6pt;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:96.95pt;
	mso-level-number-position:left;
	margin-left:96.95pt;
	text-indent:-64.8pt;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:104.15pt;
	mso-level-number-position:left;
	margin-left:104.15pt;
	text-indent:-72.0pt;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:111.35pt;
	mso-level-number-position:left;
	margin-left:111.35pt;
	text-indent:-79.2pt;}
@list l2
	{mso-list-id:1739015857;
	mso-list-template-ids:-1907050734;}
@list l2:level1
	{mso-level-style-link:"Style Heading 1 + Left\:  1 ch";
	mso-level-text:%1;
	mso-level-tab-stop:21.25pt;
	mso-level-number-position:left;
	margin-left:21.25pt;
	text-indent:-21.25pt;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:49.6pt;
	mso-level-number-position:left;
	margin-left:49.6pt;
	text-indent:-1.0cm;}
@list l2:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:70.9pt;
	mso-level-number-position:left;
	margin-left:70.9pt;
	text-indent:-1.0cm;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:99.2pt;
	mso-level-number-position:left;
	margin-left:99.2pt;
	text-indent:-35.4pt;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:127.55pt;
	mso-level-number-position:left;
	margin-left:127.55pt;
	text-indent:-42.5pt;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:163.0pt;
	mso-level-number-position:left;
	margin-left:163.0pt;
	text-indent:-2.0cm;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:191.35pt;
	mso-level-number-position:left;
	margin-left:191.35pt;
	text-indent:-63.8pt;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:219.7pt;
	mso-level-number-position:left;
	margin-left:219.7pt;
	text-indent:-70.9pt;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:255.1pt;
	mso-level-number-position:left;
	margin-left:255.1pt;
	text-indent:-85.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>Hi =
All:<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>My Bluetooth =
earphone is Motorola
HT820. <o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>1. When I try to use =
bluez-utils 3.31
on my desktop (Ubuntu7.10), there are some issues: (but there is no such =
issue
when I use 3.19 version on this same platform). Should I update some =
other
package besides bluez-utils and bluez-libs?<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&quot;<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>halley@azhao2ubtg2:~$=
 aplay
/home/halley/media/audio/Track27.wav <o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>ALSA lib
pcm_bluetooth.c:1501:(audioservice_recv) Error receiving data from audio
service: Success(0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>ALSA lib
pcm_bluetooth.c:1517:(audioservice_expect) Bogus message =
BT_GETCAPABILITIES_REQ
received while BT_GETCAPABILITIES_RSP was =
expected<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>aplay: main:545: =
audio open error:
Invalid argument<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&quot;<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>2. When I use =
bluez-utils 3.19 version,
application calls snd_pcm_hw_params() sometimes will got return value
&quot;1&quot;. (The function description says it will be 0 for success =
and
negative number for failure). The positive value makes me =
puzzled.<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
/* Apply parameters
*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'> err =3D
snd_pcm_hw_params(m_pAlsaPCMHandle, =
hwparams);<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'> if (err &lt; 0) =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
HXLOGL1 ( HXLOG_ADEV, &quot;snd_pcm_hw_params: %s&quot;, =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
snd_strerror(err));<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
m_wLastError =3D RA_AOE_NOTENABLED;<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'> =
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
/* read buffer &amp;
period sizes */<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
snd_pcm_uframes_t
buffer_size =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
snd_pcm_uframes_t
period_size =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
if (err =3D=3D 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-indent:0cm;
text-autospace:none'><font size=3D2 face=3D=CB=CE=CC=E5><span =
style=3D'font-size:10.0pt;
font-family:=CB=CE=CC=E5'>=A1=A1=A1=A1</span></font><font size=3D2 =
face=3D=CB=CE=CC=E5><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:18.0pt'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'text-indent:18.0pt'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>3. Ubuntu hardy =
has
included bluez-utils 3.26 version; but I found there are many XRun =
errors when
I use helix engine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:18.0pt'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'text-indent:18.0pt'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<div>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
text-indent:20.1pt'><b><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
ZHAO,
Halley (Aihua)</span></font></b><span =
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
text-indent:20.0pt'><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>Email: =
halley.zhao<a
href=3D"mailto:aihua.zhao@intel.com" =
title=3D"mailto:hui.xue@intel.com">@intel.com</a></span></font><font
color=3Dblue><span lang=3DEN-US =
style=3D'color:blue'><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
text-indent:16.0pt'><font size=3D1 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:8.0pt;font-family:Arial;color:blue'>Tel: =
+86(21)61166476</span></font><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
text-indent:16.0pt'><font size=3D1 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:8.0pt;font-family:Arial;color:blue'>iNet: =
8821-6476</span></font><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
text-indent:20.0pt'><font size=3D2 color=3D"#3366ff" face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:#3366FF'>SSG/OTC/UMD</s=
pan></font><span
lang=3DEN-US><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal style=3D'text-indent:21.0pt'><font size=3D2
face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8B301.20F97ADA--


--===============1572504505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1572504505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1572504505==--
