Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 6 Oct 2006 10:22:14 +0200
MIME-Version: 1.0
Message-Id: <20061006081935.B9EFA215616@mrelay1.st2.lyceu.net>
Subject: Re: [Bluez-users] PAND Network
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0692813157=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0692813157==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C6E931.4C1A2910"

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C6E931.4C1A2910
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Hi Marcel,
 
 >  >  > I'm trying to configure a PAN network and I have a problem in this
 >  >  > specific scenario:
 >  >  > 
 >  >  >             -I have one BT device  (BT1) connected to a linux PC,
 >  >  > which is configured as master
 >  >  > 
 >  >  >             -I have two BT devices more connected to another Linux
PC,
 >  >  > in different USB ports ( BT2, BT3).
 >  >  > 
 >  >  > When I create a pan connection between BT2 and master (BT1)
everything
 >  >  > works ok, but when I try to create a second connection to the same
 >  >  > master from the BT device BT3, I get this error
 >  >  > 
 >  >  >             "File exists (17)"
 >  >  > 
 >  >  > I have tried to configure first BT3 and second BT2 and I have got
the
 >  >  > same error with BT2, which means that only the first pan connection
is
 >  >  > configured without problems. 
 >  >  > 
 >  >  > Is it possible to create two simultaneous PAN connections from two
BT
 >  >  > devices connected to the same PC? Have anyone of you ever done it?
 >  >  
 >  >  >>>>>> yes, but you must sure to use "pand -i hciX" to use the
correct   
 >  >  >>>>>> adapter for the BNEP connection.
 >  > 
 >  > 
 >  > 
 >  > 
 >  > Thank you very much for your answer. I'm configuring the PAN
connection
 >  > using the "pand" function as you say "pand -i hciX" , but I still get
the
 >  > same error. In some message posted in this forum (30-09-2002) I have
read
 >  > this:
 >  > 
 >  > 
 >  > "You cannot have more than one BNEP/PAN
 >  >  connection to the _same_ bd address. In other words this
 >  >           bd:ad:dr:1 --> bd:ad:dr:2 <-- bd:ad:dr:3
 >  >  is not allowed _if_ bd:ad:dr:1 and bd:ad:dr:3 are on the same machine
"
 >  > 
 >  > 
 >  > This is exactly my case, I have the 2 slaves in the same machine, and
they
 >  > both try to connect to the same master device. As this message is
quite old,
 >  > I don't know if this is real nowadays. I'm using Fedora Core 4 in both
PC's.
 
 >  this is still valid, but your case is different, because you are using
 >  two adapters. However you must make sure that they are used. So make
 >  sure for one connection you use hci0 and for the other hci1. And you
 >  might wanna have "hcidump -i hciX -X -V" running to see the actual error
 >  message.

 

 

 I have made sure that each connection is associated with the correct hci
interface with hcidump. I have made this test:

 

 

1-       I have configured hci0 to connect to the master:

 

[root@localhost bt_config]# pand  -r PANU --autozap -i hci0 -c
00:07:80:80:4B:04 -n 

pand[6043]: Bluetooth PAN daemon version 2.15

pand[6043]: Connecting to 00:07:80:80:4B:04

pand[6043]: bnep0 connected

 

            So the connection from hci0  has been created without problem.

 

 

2-       I have configured hci1 to connect from the same PC to the master:

 

[root@localhost bt_config]# pand  -r PANU --autozap -i hci1 -c
00:07:80:80:4B:04 -n

pand[6071]: Bluetooth PAN daemon version 2.15

pand[6071]: Connecting to 00:07:80:80:4B:04

pand[6071]: Connect to 00:07:80:80:4B:04 failed. File exists(17)

 

 

And in the hcidump of hci1 I get this:

 

[root@localhost bt_config]# hcidump -i hci1 -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.18

device: hci1 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 00:07:80:80:4B:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr 00:07:80:80:4B:04 role 0x01

    Role: Slave

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 41 bdaddr 00:07:80:80:4B:04 type ACL encrypt 0x00

< ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 15 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

    handle 41 policy 0x0f

    Link policy: RSWITCH HOLD SNIFF PARK

> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7

  0000: 04 4b 80 80 07 00 01                              .K.....

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> HCI Event: Max Slots Change (0x1b) plen 3

  0000: 29 00 05                                          )..

> HCI Event: Command Complete (0x0e) plen 6

    Write Link Policy Settings (0x02|0x000d) ncmd 1

    status 0x00 handle 41

> ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

< ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1691

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

> ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1691

< ACL data: handle 41 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

< ACL data: handle 41 flags 0x02 dlen 11

    L2CAP(d): cid 0x0040 len 7 [psm 15]

      BNEP: Control(0x01|0)

        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 8

    L2CAP(d): cid 0x0040 len 4 [psm 15]

      BNEP: Control(0x01|0)

        Setup Rsp(0x02) res 0x0000

< ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3

    handle 41 reason 0x13

    Reason: Remote User Teminated Connection

> HCI Event: Command Status (0x0f) plen 4

    Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 41 reason 0x16

    Reason: Connection Terminated by Local Host

 

      

After this I have tried to connect hci1 to another master device diferent
from the master device used for hci0 connection and the connection is
created correctly, so the problem seems to be when the two devices in the
same PC try to connect to the same master. Would it be necessary to add some
other argument in the "pand" command in this situation?

 

 

Thank you and best regards,

 

 

Monica Delgado

Radio Software Architect

 

Email:  <mailto:monica.delgado@erzia.com> monica.delgado@erzia.com

Tel:   +34 942 29 13 45

Fax : +34 942 29 13 47 

 

ERZIA Technologies S.L.

Eduardo Benot 5

Spain-39003 Santander

 <http://www.erzia.com/> www.erzia.com

------------------------------------------

The information contained in this e-mail and any attachments is confidential
to ERZIA Technologies S.L. and must not be passed to any third party without
permission. This communication is for information only and shall not create
or change any contractual relationship. ERZIA Technologies S.L. is
registered in Spain C.I.F. ESB39540927

 

 


------=_NextPart_000_0003_01C6E931.4C1A2910
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"metricconverter"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EstiloCorreo17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1148519868;
	mso-list-type:hybrid;
	mso-list-template-ids:1768059212 -654509916 201981977 201981979 =
201981967 201981977 201981979 201981967 201981977 201981979;}
@list l0:level1
	{mso-level-text:%1-;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1><pre><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&nbsp;<span lang=3DEN-GB>Hi =
Marcel,<o:p></o:p></span></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt;&nbsp; &gt;&nbsp; &gt; I&#8217;m trying =
to configure a PAN network and I have a problem in =
this<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; specific =
scenario:<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -I have one BT device&nbsp; (BT1) connected to a linux =
PC,<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; which is =
configured as master<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -I have two BT devices more connected to another Linux =
PC,<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; in different USB =
ports ( BT2, BT3).<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; &gt; When I =
create a pan connection between BT2 and master (BT1) =
everything<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; works ok, but =
when I try to create a second connection to the =
same<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; master from the =
BT device BT3, I get this error<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &#8220;File exists =
(17)&#8221;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; &gt; I have tried =
to configure first BT3 and second BT2 and I have got =
the<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; same error with =
BT2, which means that only the first pan connection =
is<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; configured =
without problems. <o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; &gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; &gt; Is it =
possible to create two simultaneous PAN connections from two =
BT<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; &gt; devices connected =
to the same PC? Have anyone of you ever done =
it?<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; =
&gt;&gt;&gt;&gt;&gt;&gt; yes, but you must sure to use &quot;pand -i =
hciX&quot; to use the correct&nbsp;&nbsp; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt;&nbsp; =
&gt;&gt;&gt;&gt;&gt;&gt; adapter for the BNEP =
connection.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; Thank you very much for =
your answer. I'm configuring the PAN =
connection<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; using the &quot;pand&quot; =
function as you say &quot;pand -i hciX&quot; , but I still get =
the<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; same error. In some message =
posted in this forum (30-09-2002) I have =
read<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; =
this:<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; &quot;You cannot have =
more than one BNEP/PAN<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; connection to the =
_same_ bd address. In other words =
this<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; =
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bd:ad:dr:1 --&gt; bd:ad:dr:2 &lt;-- =
bd:ad:dr:3<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt;&nbsp; is not allowed _if_ =
bd:ad:dr:1 and bd:ad:dr:3 are on the same machine =
&quot;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;&gt; This is exactly my =
case, I have the 2 slaves in the same machine, and =
they<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; both try to connect to the =
same master device. As this message is quite =
old,<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;&gt; I don't know if this is real =
nowadays. I'm using Fedora Core <st1:metricconverter
ProductID=3D"4 in" w:st=3D"on">4 in</st1:metricconverter> both =
PC's.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> <o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'>&nbsp;&gt; &nbsp;this is still valid, but =
your case is different, because you are =
using<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;two adapters. However you must =
make sure that they are used. So =
make<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;sure for one connection you use =
hci0 and for the other hci1. And =
you<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; &nbsp;might wanna have &quot;hcidump -i =
hciX -X -V&quot; running to see the actual =
error<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt'> &gt; =
&nbsp;message.<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;I have made sure that each connection is =
associated
with the correct hci interface with hcidump. I have made this =
test:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1-<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>I
have configured hci0 to connect to the =
master:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>[root@localhost
bt_config]# pand&nbsp; -r PANU --autozap -i hci0 -c 00:07:80:80:4B:04 -n =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6043]:
Bluetooth PAN daemon version 2.15<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6043]:
Connecting to 00:07:80:80:4B:04<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6043]: bnep0
connected<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; So
the connection from hci0 &nbsp;has been created without =
problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:70.8pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2-<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>I
have configured hci1 to connect from the same PC to the =
master:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>[root@localhost
bt_config]# pand&nbsp; -r PANU --autozap -i hci1 -c 00:07:80:80:4B:04 =
-n<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6071]:
Bluetooth PAN daemon version 2.15<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6071]:
Connecting to 00:07:80:80:4B:04<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pand[6071]:
Connect to 00:07:80:80:4B:04 failed. </span></font><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>File
exists(17)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>And in the =
hcidump of
hci1 I get this:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>[root@localhost
bt_config]# hcidump -i hci1 -X -V<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>HCI =
sniffer -
Bluetooth packet analyzer ver 1.18<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>device: hci1
snap_len: 1028 filter: 0xffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
HCI Command:
Create Connection (0x01|0x0005) plen 13<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
bdaddr 00:07:80:80:4B:04 ptype 0xcc18 rswitch 0x01 clkoffset =
0x0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Packet type: DM1 DM3 DM5 DH1 DH3 DH5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Create Connection (0x01|0x0005) status 0x00 ncmd =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Role Change (0x12) plen 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
status 0x00 bdaddr 00:07:80:80:4B:04 role =
0x01<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Role: Slave<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Connect Complete (0x03) plen 11<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
status 0x00 handle 41 bdaddr 00:07:80:80:4B:04 type ACL encrypt =
0x00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
ACL data:
handle 41 flags 0x02 dlen 12<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Connect req: psm 15 scid 0x0040<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
HCI Command:
Write Link Policy Settings (0x02|0x000d) plen =
4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
</span></font><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>handle 41 policy =
0x0f<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Link policy: <st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">RSWITCH</st1:PlaceName>
 <st1:PlaceName w:st=3D"on">HOLD</st1:PlaceName> <st1:PlaceName =
w:st=3D"on">SNIFF</st1:PlaceName>
 <st1:PlaceType =
w:st=3D"on">PARK</st1:PlaceType></st1:place><o:p></o:p></span></font></p>=


<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DFR style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; HCI =
Event: Page
Scan Repetition Mode Change (0x20) plen 7<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DFR style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; =
</span></font><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New"'>0000: 04 4b 80 80 07 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.K.....<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Max Slots Change (0x1b) plen 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; =
0000: 29
00
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
)..<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Command Complete (0x0e) plen 6<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Write Link Policy Settings (0x02|0x000d) ncmd =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
status 0x00 handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
ACL data:
handle 41 flags 0x02 dlen 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
ACL data:
handle 41 flags 0x02 dlen 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen =
4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MTU 1691<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
ACL data:
handle 41 flags 0x02 dlen 14<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Success<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
ACL data:
handle 41 flags 0x02 dlen 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen =
4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MTU 1691<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
ACL data:
handle 41 flags 0x02 dlen 14<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Success<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
ACL data:
handle 41 flags 0x02 dlen 11<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 7 [psm 15]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
BNEP: Control(0x01|0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Setup Req(0x01) size 0x02 dst 0x1116(NAP) src =
0x1115(PANU)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
ACL data:
handle 41 flags 0x02 dlen 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 4 [psm 15]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
BNEP: Control(0x01|0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Setup Rsp(0x02) res 0x0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
ACL data:
handle 41 flags 0x02 dlen 12<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Disconn req: dcid 0x0040 scid =
0x0040<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
ACL data:
handle 41 flags 0x02 dlen 12<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Disconn rsp: dcid 0x0040 scid =
0x0040<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&lt; =
HCI Command:
Disconnect (0x01|0x0006) plen 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
handle 41 reason 0x13<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Reason: Remote User Teminated Connection<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Disconnect (0x01|0x0006) status 0x00 ncmd 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; =
HCI Event:
Disconn Complete (0x05) plen 4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
status 0x00 handle 41 reason 0x16<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;
Reason: Connection Terminated by Local Host<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:18.0pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp; =
&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>After this I have tried to connect hci1 to =
another master
device diferent from the master device used for hci0 connection and the
connection is created correctly, so the problem seems to be when the two =
devices
in the same PC try to connect to the same master. Would it be necessary =
to add
some other argument in the &#8220;pand&#8221; command in this =
situation?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thank you and best =
regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Monica =
Delgado<o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Radio Software =
Architect<o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'>Email: =
</span></font><a
href=3D"mailto:monica.delgado@erzia.com"><font size=3D2 =
face=3DArial><span lang=3DFR
style=3D'font-size:10.0pt;font-family:Arial'>monica.delgado@erzia.com</sp=
an></font></a><font
size=3D2 face=3DArial><span lang=3DFR =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'>Tel:&nbsp;&nbsp; =
+34 942 29
13 45<o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'>Fax&nbsp;: +34 =
942 29 13 47 <o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DFR =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>ERZIA =
Technologies S.L.<o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Eduardo Benot =
5<o:p></o:p></span></font></p>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>Spain&#8211;39003 =
<st1:place
w:st=3D"on"><st1:City =
w:st=3D"on">Santander</st1:City></st1:place><o:p></o:p></span></font></p>=


<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><a href=3D"http://www.erzia.com/"><font =
size=3D2
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>www.erzia.com</span></font><=
/a></span></font><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>----------------------------=
--------------<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
Arial'>The information contained in this e-mail and any attachments is
confidential to ERZIA Technologies S.L. and must not be passed to any =
third
party without permission. This communication is for information only and =
shall
not create or change any contractual relationship. ERZIA Technologies =
S.L. is
registered in Spain C.I.F. ESB39540927<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp;</span></font><span =
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01C6E931.4C1A2910--



--===============0692813157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0692813157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0692813157==--
