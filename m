Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 30 Apr 2007 15:02:36 +0800
Message-ID: <36BC62FC45C4E949B13C20DEFA8617D504F42BFB@zmy16exm62.ds.mot.com>
From: "GAO LIANG-TAO-W20048" <l.t.gao@motorola.com>
To: <bluez-devel@lists.sourceforge.net>
Cc: Singer Catherine-CSINGER1 <CSINGER1@motorola.com>,
        Jin Hong-Lei-W19971 <hong-lei.jin@motorola.com>,
        Saeed Faisal-EFS015 <faisal.saeed@motorola.com>
Subject: [Bluez-devel] Report a bug against "l2cap_conf_output()" in
	"net/bluetooth/l2cap.c"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0538687606=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0538687606==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C78AF5.8962EECE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C78AF5.8962EECE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

Hi,

=20

I want to report a bug against "l2cap_conf_output()" in BlueZ kernel
code "net/bluetooth/l2cap.c":

    if (pi->conf_mtu < pi->omtu) {

       l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);

       result =3D L2CAP_CONF_UNACCEPT;

    } else {

       pi->omtu =3D pi->conf_mtu;

    }

I think it's wrong to enlarge the outgoing MTU value (by calling
"pi->omtu =3D pi->conf_mtu") when device B gets the MTU in device A's
configuration request. In fact, Page 1006/1200 of Bluetooth SPEC v1.2 or
Page 1038/1230 of Bluetooth SPEC v2.0 EDR both require a minimum of the
"If the remote device sends a positive configuration response it shall
include the actual MTU to be used on this channel for traffic flowing
into the local device. This is the minimum of the MTU in the
configuration request and the outgoing MTU capability of the device
sending the configuration response." Here I consider the original
"pi->omtu" as the "outgoing MTU capability".

=20

I suggest to remove the "else" clause, and to apply l2cap_add_conf_opt()
to both cases:

    l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);

    if (pi->conf_mtu < pi->omtu) {

       result =3D L2CAP_CONF_UNACCEPT;

    }

=20

Regards,

Gao Liangtao

=20


------_=_NextPart_001_01C78AF5.8962EECE
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
	font-family:"Courier New";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:70.9pt 36.85pt 36.85pt 70.9pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier New"'>I want to report a =
bug
against &#8220;l2cap_conf_output()&#8221; in BlueZ kernel code =
&#8220;net/bluetooth/l2cap.c&#8221;:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-style:italic'>&nbsp;&nbsp;&nbsp; if
(pi-&gt;conf_mtu &lt; pi-&gt;omtu) {<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-style:italic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
l2cap_add_conf_opt(ptr,
L2CAP_CONF_MTU, 2, pi-&gt;omtu);<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-style:italic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result
=3D L2CAP_CONF_UNACCEPT;<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-style:italic'>&nbsp;&nbsp;&nbsp; }
else {<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><b><i><font size=3D2 color=3Dred face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:red;
font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></i></b><b><i><font
size=3D2 color=3Dred face=3D"Courier New"><span lang=3DFR =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:red;font-weight:bold;font-style:italic'>pi-&gt;omtu
=3D pi-&gt;conf_mtu;<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span =
lang=3DFR
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-style:italic'>&nbsp;&nbsp;&nbsp; </span></font></i><i><font
size=3D2 face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:
"Courier New";font-style:italic'>}<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier New"'>I think it&#8217;s =
wrong to
enlarge the outgoing MTU value (by calling &#8220;pi-&gt;omtu =3D =
pi-&gt;conf_mtu&#8221;)
when device B gets the MTU in device A&#8217;s configuration request. In =
fact, Page
1006/1200 of Bluetooth SPEC v1.2 or Page 1038/1230 of Bluetooth SPEC =
v2.0 EDR both
require a minimum of the &nbsp;&#8220;</span></font><font size=3D3
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:"Courier New"'>If
the remote device sends a positive configuration response it shall =
include the
actual MTU to be used on this channel for traffic flowing into the local
device. This is the minimum of the MTU in the configuration request and =
the
outgoing MTU capability of the device sending the configuration =
response.&#8221;
Here I consider the original &#8220;pi-&gt;omtu&#8221; as the =
&#8220;outgoing
MTU capability&#8221;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier New"'>I suggest to =
<b><font
color=3Dred><span style=3D'color:red;font-weight:bold'>remove the =
&#8220;else&#8221;
clause, and to apply l2cap_add_conf_opt() to both =
cases:</span></font></b><o:p></o:p></span></font></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy;
font-style:italic'>&nbsp;&nbsp;&nbsp; l2cap_add_conf_opt(ptr, =
L2CAP_CONF_MTU,
2, pi-&gt;omtu);<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy;
font-style:italic'>&nbsp;&nbsp;&nbsp; if (pi-&gt;conf_mtu &lt; =
pi-&gt;omtu) {<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy;
font-style:italic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D
L2CAP_CONF_UNACCEPT;<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy;
font-style:italic'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier New"'>Gao =
Liangtao<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C78AF5.8962EECE--


--===============0538687606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0538687606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0538687606==--
