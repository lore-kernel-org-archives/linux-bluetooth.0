Return-Path: <cyrus@holtmann.org>
From: "Pierre Savary" <pierre.savary@kerlink.fr>
To: "BlueZ-Dev" <bluez-devel@lists.sourceforge.net>,
	<bluez-users@lists.sourceforge.net>
Date: Tue, 13 May 2008 16:51:20 +0200
Message-ID: <000901c8b508$cfd24950$6f76dbf0$@savary@kerlink.fr>
MIME-Version: 1.0
Subject: [Bluez-devel] how to compile bluez-utils with shared libraries
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0809122835=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Il s'agit d'un message à parties multiples au format MIME.

--===============0809122835==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C8B519.935B1950"
Content-Language: fr

Il s'agit d'un message à parties multiples au format MIME.

------=_NextPart_000_000A_01C8B519.935B1950
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I try to compile bluez-utils with shared libraries but I obtain static
binaries. This is my command line :

>./configure --host=arm-linux --disable-alsa --disable-cups --disable-pcmcia
--disable-bluepin --disable-dfutool --disable-obex --disable-audio
--disable-hid2hci --disable-initscripts -with-bluez=$PWD/../fs/lib/usr
--mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var
--libexecdir=/lib --prefix=/usr

>make

 

Where is my mistake?

Thanks in advance,

 

Regards,

Pierre

 


------=_NextPart_000_000A_01C8B519.935B1950
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I try to compile bluez-utils =
with shared
libraries but I obtain static binaries. This is my command line =
:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>&gt;./configure =
--host=3Darm-linux
--disable-alsa --disable-cups --disable-pcmcia --disable-bluepin
--disable-dfutool --disable-obex --disable-audio --disable-hid2hci
--disable-initscripts &#8211;with-bluez=3D$PWD/../fs/lib/usr
--mandir=3D/usr/share/man --sysconfdir=3D/etc --localstatedir=3D/var
--libexecdir=3D/lib --prefix=3D/usr<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>&gt;make<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Where is my =
mistake?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Thanks in =
advance,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Pierre<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_000A_01C8B519.935B1950--



--===============0809122835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0809122835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0809122835==--
