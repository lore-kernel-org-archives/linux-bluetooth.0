Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4D7DA.0CBBFF36"
Message-ID: <A1F0D47583A2D711919F00600819B3A48BA128@goofy.vitronics.com>
From: "Cruz, Maria" <maria.cruz@VITRONICS.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] bluetooth sniff mode
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
Date: Wed, 1 Dec 2004 14:14:58 -0500

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4D7DA.0CBBFF36
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marcel wrote:

Hi Maria, ... I don"t know of a command that can read the current power
safe mode, but you can monitor the HCI mode changed event. Regards
Marcel=20

=20

Thanks Marcel,

Here is the output from my command:

# hcitool cmd 0x02 0x0003 0x01 0x00 0x00 0x05 0x00 0x01 0x06 0x00 0x10
0x00

< HCI Command: ogf 0x02, ocf 0x0003, plen 10

  01 00 00 05 00 01 06 00 10 00

> HCI Event: 0x0f plen 4

  00 01 03 08

I looked in the "BLUETOOTH SPECIFICATION Version 1.1" for the HCI Event
of 0x0f.  I am not confident in reading the specification.  But I think
this event 0x0f =3D Command Status.  And the Event Parameters:  (0) "00" =
=3D
Command currently in pending.=20

=20

Not sure if this indicates a success (or just pending not sure yet of
success).  Additionally, I am using bluez-libs&bluez-utils2.10.  Should
I reference the "BLUETOOTH SPECIFICATION Version 2.0 + EDR" instead?  I
found version 2.0 at "Bluetooth.org" web site.  AND the version 2.0 spec
is slightly different.  For example the error codes listed in 2.0 are
different. =20

=20

Sometimes with the hci cmd for sniff mode I get:

# hcitool cmd 0x02 0x0003 0x01 0x01 0x00 0x00 0x05 0x00

0x01 0x06 0x00 0x10 0x00

< HCI Command: ogf 0x02, ocf 0x0003, plen 11

  01 01 00 00 05 00 01 06 00 10 00

> HCI Event: 0x0f plen 4

  02 01 03 08

=20

Here the HCI Event indicates "Status" of 0x02. =20

Version 1.1 =3D 0x02 No Connection.

Version 2.0 =3D 0x02 Unknown Connection Identifier

=20

Maybe it is only semantics... either way I do not understand what either
really mean.  For the sniff mode I have setup a bnep connection.  I can
ping "host", I have static IPs setup.  And=20

hcitool con

Connections:

        < ACL 00:02:72:41:2E:1D handle 1 state 1 lm MASTER

=20

Should this indicate "SLAVE"?  Somes times hcitool con will show SLAVE
instead.  Your advice on what spec to use and how to decipher hictool
output is appreciated.

maria

=20

=20

=20

=20

=20


------_=_NextPart_001_01C4D7DA.0CBBFF36
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
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Marcel wrote:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Hi Maria, &#8230; I don&quot;t know of a =
command that
can read the current power safe mode, but you can monitor the HCI mode =
changed
event. Regards Marcel <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Thanks Marcel,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Here is the output from my =
command:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'># hcitool cmd 0x02 0x0003 0x01 0x00 0x00 0x05 0x00 0x01 0x06 =
0x00 0x10
0x00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&lt; HCI Command: ogf 0x02, ocf 0x0003, plen =
10<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; 01 00 00 05 00 01 06 00 10 =
00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; HCI Event: 0x0f plen 4<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; 00 01 03 08<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>I looked in the &#8220;BLUETOOTH =
SPECIFICATION Version
1.1&#8221; for the HCI Event of 0x0f.&nbsp; I am not confident in =
reading the
specification.&nbsp; But I think this event 0x0f =3D Command =
Status.&nbsp; And
the Event Parameters:&nbsp; (0) &#8220;00&#8221; =3D Command currently =
in
pending. <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Not sure if this indicates a success (or just =
pending
not sure yet of success).&nbsp; Additionally, I am using
bluez-libs&amp;bluez-utils2.10.&nbsp; Should I reference the =
&#8220;BLUETOOTH
SPECIFICATION Version 2.0 + EDR&#8221; instead?&nbsp; I found version =
2.0 at &#8220;Bluetooth.org&#8221;
web site.&nbsp; AND the version 2.0 spec is slightly different.&nbsp; =
For
example the error codes listed in 2.0 are different.&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Sometimes with the hci cmd for sniff mode I =
get:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'># hcitool cmd 0x02 0x0003 0x01 0x01 0x00 0x00 0x05 =
0x00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>0x01 0x06 0x00 0x10 0x00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&lt; HCI Command: ogf 0x02, ocf 0x0003, plen =
11<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; 01 01 00 00 05 00 01 06 00 10 =
00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; HCI Event: 0x0f plen 4<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; 02 01 03 08<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Here the HCI Event indicates =
&#8220;Status&#8221; of
0x02.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Version 1.1 =3D 0x02 No =
Connection.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Version 2.0 =3D 0x02 Unknown Connection =
Identifier<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Maybe it is only semantics&#8230; either way =
I do not
understand what either really mean.&nbsp; For the sniff mode I have =
setup a
bnep connection.&nbsp; I can ping &#8220;host&#8221;, I have static IPs =
setup.&nbsp;
And <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>hcitool con<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Connections:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL =
00:02:72:41:2E:1D
handle 1 state 1 lm MASTER<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>Should this indicate =
&#8220;SLAVE&#8221;?&nbsp; Somes
times hcitool con will show SLAVE instead.&nbsp; Your advice on what =
spec to
use and how to decipher hictool output is =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'>maria<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:5.0pt;margin-right:0in;margin-bottom:
5.0pt;margin-left:0in;text-autospace:none'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4D7DA.0CBBFF36--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
