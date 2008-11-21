Return-Path: <cyrus@holtmann.org>
From: "Li, Zhigang" <zhigang.li@intel.com>
To: "vinicius.gomes@openbossa.org" <vinicius.gomes@openbossa.org>
Date: Fri, 21 Nov 2008 16:10:22 +0800
Message-ID: <B94C62E7C2870743865418621F040C1301E82411@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Cc: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] What's the maximum size of file by FTP transfer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4797363908942157603=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============4797363908942157603==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_B94C62E7C2870743865418621F040C1301E82411pdsmsx502ccrcor_"

--_000_B94C62E7C2870743865418621F040C1301E82411pdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

HI Vinicius,
I have one problem for bigger file transfer.
I can't transfer 9MB .mp3 file but 1MB file is ok by FTP.
I know it's difficult to transfer a bigger file which more than 10MB by Blu=
etooth.
I used latest release version in bluez.org.
It even can't open the file, it's not file self problem.
fd =3D open(filename, O_RDONLY);
What's the limitation in ftp client side? I saw the size should be 2GB.
Do you have same problem? Or any idea/
Thanks



--_000_B94C62E7C2870743865418621F040C1301E82411pdsmsx502ccrcor_
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
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
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

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple style=3D'text-justify-trim:pu=
nctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>HI Vinicius,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>I have one problem for bigger file transfer.<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>I can&#8217;t transfer 9MB .mp3 file but 1MB file =
is
ok by FTP.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>I know it&#8217;s difficult to transfer a bigger f=
ile
which more than 10MB by Bluetooth.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>I used latest release version in bluez.org.<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>It even can&#8217;t open the file, it&#8217;s not =
file
self problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>fd =3D open(filename, O_RDONLY);<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>What&#8217;s the limitation in ftp client side? I =
saw
the size should be 2GB.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>Do you have same problem? Or any idea/<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_B94C62E7C2870743865418621F040C1301E82411pdsmsx502ccrcor_--


--===============4797363908942157603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============4797363908942157603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============4797363908942157603==--
