Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Dave Henriksen" <dhenriksen@optibrand.com>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <000101c66eca$e7019e90$a101a8c0@davesvaio>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0002_01C66E98.9C672E90"
Subject: [Bluez-devel] Dund connection problems
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 3 May 2006 10:01:56 -0600

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C66E98.9C672E90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

=20

I was wondering is anyone might have an idea what would be causing =
devices
to be unable to connect to a Bluetooth hub I have built using BlueZ on a
small single board computer.   Generally, it works extremely well, but =
on
occasion this Bluetooth hub does the following when a client tries to
connect to it.   My kernel is 2.6.14.6-mh2, with bluez-libs-2.25 and the
latest bluez utils .

=20

=20

=20

tail -30 /var/log/messages

=20

May  3 09:47:56 OBBTHub hcid[4114]: link_key_notify =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:48:53 OBBTHub hcid[4114]: link_key_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:49:57 OBBTHub hcid[4114]: pin_code_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:49:57 OBBTHub hcid[4114]: link_key_notify =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:50:54 OBBTHub hcid[4114]: link_key_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:51:58 OBBTHub hcid[4114]: pin_code_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:51:58 OBBTHub hcid[4114]: link_key_notify =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:52:55 OBBTHub hcid[4114]: link_key_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:54:00 OBBTHub hcid[4114]: pin_code_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:54:01 OBBTHub hcid[4114]: link_key_notify =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:54:58 OBBTHub hcid[4114]: link_key_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:56:02 OBBTHub hcid[4114]: pin_code_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:56:03 OBBTHub hcid[4114]: link_key_notify =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:57:00 OBBTHub hcid[4114]: link_key_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

May  3 09:58:05 OBBTHub hcid[4114]: pin_code_request =
(sba=3D00:02:72:C1:F1:07,
dba=3D00:0A:3A:55:05:D5)

=20

When I run hcidump on the hub that I have built, I get .   Please note =
the
"Connection refused - no resources available" that is about half way =
through
the file.

=20

=20

=20

HCI sniffer - Bluetooth packet analyzer ver 1.29

device: hci0 snap_len: 1028 filter: 0xffffffff

> HCI Event: Connect Request (0x04) plen 10

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: PIN Code Request (0x16) plen 6

< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23

> HCI Event: Command Complete (0x0e) plen 10

> HCI Event: Link Key Notification (0x18) plen 23

> HCI Event: Connect Complete (0x03) plen 11

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

> HCI Event: Command Complete (0x0e) plen 6

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

> HCI Event: Command Status (0x0f) plen 4

> ACL data: handle 7 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 7 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

> HCI Event: Max Slots Change (0x1b) plen 3

> HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 7 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

> HCI Event: Disconn Complete (0x05) plen 4

> HCI Event: Connect Request (0x04) plen 10

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Link Key Request (0x17) plen 6

< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22

> HCI Event: Command Complete (0x0e) plen 10

> HCI Event: Connect Complete (0x03) plen 11

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

> HCI Event: Command Complete (0x0e) plen 6

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

> HCI Event: Command Status (0x0f) plen 4

> ACL data: handle 6 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 6 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

> HCI Event: Max Slots Change (0x1b) plen 3

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 6 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 6 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0

      Connection refused - no resources available

> HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 6 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

> HCI Event: Disconn Complete (0x05) plen 4

> HCI Event: Connect Request (0x04) plen 10

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: PIN Code Request (0x16) plen 6

< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23

> HCI Event: Command Complete (0x0e) plen 10

> HCI Event: Link Key Notification (0x18) plen 23

> HCI Event: Connect Complete (0x03) plen 11

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

> HCI Event: Command Complete (0x0e) plen 6

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

> ACL data: handle 7 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 7 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Max Slots Change (0x1b) plen 3

> HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 7 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

> HCI Event: Disconn Complete (0x05) plen 4

> HCI Event: Connect Request (0x04) plen 10

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Link Key Request (0x17) plen 6

< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22

> HCI Event: Command Complete (0x0e) plen 10

> HCI Event: Connect Complete (0x03) plen 11

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

> HCI Event: Command Complete (0x0e) plen 6

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

> HCI Event: Command Status (0x0f) plen 4

> ACL data: handle 6 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 6 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

> HCI Event: Max Slots Change (0x1b) plen 3

> HCI Event: Number of Completed Packets (0x13) plen 5

=20

Any ideas ?

=20

Thanks,

=20

Dave

=20

=20


------=_NextPart_000_0002_01C66E98.9C672E90
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
	{font-family:Arial;
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>All,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I was wondering is anyone might have an idea what =
would be
causing devices to be unable to connect to a Bluetooth hub I have built =
using BlueZ
on a small single board computer.&nbsp;&nbsp; Generally, it works =
extremely
well, but on occasion this Bluetooth hub does the following when a =
client tries
to connect to it.&nbsp;&nbsp; My kernel is 2.6.14.6-mh2, with =
bluez-libs-2.25
and the latest bluez utils &#8230;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>tail -30 /var/log/messages</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:47:56</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_notify (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:48:53</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:49:57</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
pin_code_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:49:57</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_notify (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:50:54</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:51:58</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
pin_code_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:51:58</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_notify (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:52:55</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:54:00</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
pin_code_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:54:01</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_notify (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:54:58</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:56:02</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
pin_code_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:56:03</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_notify (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:57:00</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
link_key_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>May&nbsp; 3 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>09:58:05</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> OBBTHub =
hcid[4114]:
pin_code_request (sba=3D00:02:72:C1:F1:07, =
dba=3D00:0A:3A:55:05:D5)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I run hcidump on the hub that I have built, I =
get &#8230;&nbsp;&nbsp;
Please note the &#8220;</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Connection refused =
- no
resources available&#8221; that is about half way through the =
file.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>HCI sniffer - =
Bluetooth
packet analyzer ver 1.29</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>device: hci0 =
snap_len: 1028
filter: 0xffffffff</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Request (0x04) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Accept
Connection Request (0x01|0x0009) plen 7</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: PIN =
Code
Request (0x16) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
PIN Code
Request Reply (0x01|0x000d) plen 23</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Link Key
Notification (0x18) plen 23</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Complete (0x03) plen 11</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Write Link
Policy Settings (0x02|0x000d) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Change
Connection Packet Type (0x01|0x000f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ACL data: =
handle 7
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect req: psm 1 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 7
flags 0x02 dlen 16</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: Max =
Slots
Change (0x1b) plen 3</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 7
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Disconn req: dcid 0x0040 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Disconn
Complete (0x05) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Request (0x04) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Accept
Connection Request (0x01|0x0009) plen 7</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Link Key
Request (0x17) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Link Key
Request Reply (0x01|0x000b) plen 22</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Complete (0x03) plen 11</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Write Link
Policy Settings (0x02|0x000d) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Change
Connection Packet Type (0x01|0x000f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ACL data: =
handle 6
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect req: psm 1 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 6
flags 0x02 dlen 16</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: Max =
Slots
Change (0x1b) plen 3</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ACL data: =
handle 6
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect req: psm 1 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 6
flags 0x02 dlen 16</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection refused - no resources available</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 6
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Disconn req: dcid 0x0040 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Disconn
Complete (0x05) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Request (0x04) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Accept
Connection Request (0x01|0x0009) plen 7</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: PIN =
Code
Request (0x16) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
PIN Code
Request Reply (0x01|0x000d) plen 23</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Link Key
Notification (0x18) plen 23</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Complete (0x03) plen 11</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Write Link
Policy Settings (0x02|0x000d) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Change
Connection Packet Type (0x01|0x000f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ACL data: =
handle 7
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect req: psm 1 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 7
flags 0x02 dlen 16</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: Max =
Slots
Change (0x1b) plen 3</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 7
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Disconn req: dcid 0x0040 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Disconn
Complete (0x05) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Request (0x04) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Accept
Connection Request (0x01|0x0009) plen 7</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Link Key
Request (0x17) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Link Key
Request Reply (0x01|0x000b) plen 22</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 10</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Connect
Complete (0x03) plen 11</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Write Link
Policy Settings (0x02|0x000d) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Complete (0x0e) plen 6</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; HCI Command: =
Change
Connection Packet Type (0x01|0x000f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Command
Status (0x0f) plen 4</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ACL data: =
handle 6
flags 0x02 dlen 12</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect req: psm 1 scid 0x0040</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; ACL data: =
handle 6
flags 0x02 dlen 16</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
L2CAP(s):
Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: Max =
Slots
Change (0x1b) plen 3</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI Event: =
Number of
Completed Packets (0x13) plen 5</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Any ideas =
?</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Thanks,</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Dave</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0002_01C66E98.9C672E90--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
