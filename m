Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jun 2008 10:52:03 +0900
From: =?utf-8?B?67CV7LCs7Je0?= <chanyeol.park@samsung.com>
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Message-id: <000a01c8ca9c$94be0850$be3a18f0$%park@samsung.com>
MIME-version: 1.0
Subject: [Bluez-devel] FW:  BlueZ 3.32 HSP SCO Bug Report & Solution
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2006278362=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

여러 부분으로 구성된 MIME 형식의 메시지입니다.

--===============2006278362==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_BSiXL0mx796q0T+mQEMHWw)"
Content-language: ko

여러 부분으로 구성된 MIME 형식의 메시지입니다.

--Boundary_(ID_BSiXL0mx796q0T+mQEMHWw)
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable

Hello.

=20

>can you please check with the latest CVS.=20

>I like to know if that issue is still present or if we actually fixed =
in the meantime.

=20

Yes, the Latest CVS code(Rev 1.32) has still bug.

=20

In sco_connect(common/glib-helper.c), BT SCO socket "sk" is made,=20

but "sk" is not delivered to transport_connect function

=20

so I add =E2=80=9Cio_ctxt->fd=3Dsk (669 line)=E2=80=9D .

=20

If you let me know how to commit my code on CVS, I would do.

=20

=20

Regards

Chan-yeol Park (=EB=B0=95=EC=B0=AC=EC=97=B4)

Engineer

=20

Mobile S/W Platform Lab.=20

Telecommunication R&D Center

SAMSUNG ELECTRONICS CO., LTD.

=20

Tel : +82-31-279-5941=20

Mobile : +82-10-9978-5941

E-mail : chanyeol.park@samsung.com

=20

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Tuesday, June 10, 2008 9:38 AM
To: BlueZ development
Cc: '=EB=B0=95=EC=B0=AC=EC=97=B4'
Subject: Re: [Bluez-devel] BlueZ 3.32 HSP SCO Bug Report & Solution

=20

Hi,

=20

> Recently I found BlueZ 3.32 HSP SCO connection bug.

>=20

> Fortunately I fix the bug as follows.=20

>=20

>=20

> In the function "sco_connect (glib-helper.c)"

> Bluez 3.32 code doesn't handle socket variable "sk"

>=20

> So I add "socket file descriptor save routine"

>=20

> 636 : io_cxtf->fd=3Dsk;

>=20

>=20

> If you have any question about my idea, don't hesitate to tell me ^^

>=20

> If possible , could you let me know how to check out/check in my code =
?

=20

can you please check with the latest CVS. I like to know if that issue

is still present or if we actually fixed in the meantime.

=20

Regards

=20

Marcel

=20


--Boundary_(ID_BSiXL0mx796q0T+mQEMHWw)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=EA=B5=B4=EB=A6=BC;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"\@=EA=B5=B4=EB=A6=BC";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"=EB=A7=91=EC=9D=80 =EA=B3=A0=EB=94=95";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"=EA=B8=80=EC=9E=90=EB=A7=8C Char";
	margin:0cm;
	margin-bottom:.0001pt;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"Courier New";}
span.Char
	{mso-style-name:"=EA=B8=80=EC=9E=90=EB=A7=8C Char";
	mso-style-priority:99;
	mso-style-link:=EA=B8=80=EC=9E=90=EB=A7=8C;
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
 /* Page Definitions */
 @page Section1
	{size:612.0pt 792.0pt;
	margin:3.0cm 72.0pt 72.0pt 72.0pt;}
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

<body lang=3DKO link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><span lang=3DEN-US>Hello.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt;can you please check with =
the latest
CVS. <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt;I like to know if that =
issue is
still present or if we actually fixed in the =
meantime.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Yes, the Latest CVS code(Rev =
1.32) has
still bug.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>In =
sco_connect(common/glib-helper.c), BT
SCO socket &quot;sk&quot; is made, <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>but &quot;sk&quot; is not =
delivered to
transport_connect function<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>so I add =
=E2=80=9Cio_ctxt-&gt;fd=3Dsk (669 line)=E2=80=9D
.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>If you let me know how to =
commit my code
on CVS, I would do.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Regards<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Chan-yeol Park (</span><span
style=3D'font-family:=EA=B5=B4=EB=A6=BC'>=EB=B0=95=EC=B0=AC=EC=97=B4</spa=
n><span lang=3DEN-US>)<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Engineer<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Mobile S/W Platform Lab. =
<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Telecommunication R&amp;D =
Center<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>SAMSUNG ELECTRONICS CO., =
LTD.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Tel : +82-31-279-5941 =
<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Mobile : =
+82-10-9978-5941<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>E-mail : =
chanyeol.park@samsung.com<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>-----Original =
Message-----<br>
From: Marcel Holtmann [mailto:marcel@holtmann.org] <br>
Sent: Tuesday, June 10, 2008 9:38 AM<br>
To: BlueZ development<br>
Cc: '</span><span =
style=3D'font-family:=EA=B5=B4=EB=A6=BC'>=EB=B0=95=EC=B0=AC=EC=97=B4</spa=
n><span lang=3DEN-US>'<br>
Subject: Re: [Bluez-devel] BlueZ 3.32 HSP SCO Bug Report &amp; =
Solution<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Hi,<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; Recently I found BlueZ =
3.32 HSP SCO
connection bug.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; Fortunately I fix the =
bug as
follows. <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; In the function =
&quot;sco_connect
(glib-helper.c)&quot;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; Bluez 3.32 code doesn't =
handle
socket variable &quot;sk&quot;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; So I add &quot;socket =
file
descriptor save routine&quot;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; 636 : =
io_cxtf-&gt;fd=3Dsk;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; If you have any question =
about my
idea, don't hesitate to tell me ^^<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&gt; If possible , could you =
let me know
how to check out/check in my code ?<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>can you please check with the =
latest
CVS. I like to know if that issue<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>is still present or if we =
actually fixed
in the meantime.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Regards<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Marcel<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

--Boundary_(ID_BSiXL0mx796q0T+mQEMHWw)--


--===============2006278362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============2006278362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2006278362==--
