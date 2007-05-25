Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 25 May 2007 14:48:03 +0200
Message-ID: <39D0ED4A56B05A409DB3C01F8DCEFB54E3A387@CORPAPPL021.corp.saab.se>
From: "Bengtsson Mikael" <mikael.bengtsson@saabgroup.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] How to emulate DTE and DCE with Free2Move BT HCI?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0529062130=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0529062130==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C79ECA.EF39E4C1"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79ECA.EF39E4C1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello!

I would like to emulate DTE and DCE serial handshaking with Free2Move:s
BT.

Free2Move offers the "Wireless UART" configuration or the HCI
configuration.
In the "Wireless UART" configuration no external software is required.
HCI, obviously, requires a BlueZ stack on a host.

I have tested Free2Move:s BT in the configuration "Wireless UART" in the
following manner:
Evaluation kit nr 1 (EVA1) has an Wireless UART that is configured as
DTE.
Evaluation kit nr 2 (EVA2) has an Wireless UART that is configured as
DCE.
When pressing a key connected to IO-pin 6 (DCD on EVA1) the
corresponding IO-pin 6 on EVA2 is activated.
When pressing a key connected to IO-pin 5 (DTR on EVA2) the
corresponding IO-pin5  on EVA1 is activated.

So the emulation of DTE and DCE over Bluetooth works with "Wireless
UART" configuration.

Now, I would like EVA1 to connect to a HCI BT.=20

The problem is, that in the HCI configuration it is not possible to
configure DCE for the BT.

I have tried the following:
I used a PC with a simple USB BT dongle.
I connected to EVA1 with the command "rfcomm /dev/rfcomm0 connect
<address of EVA1>"
I used hcidump and when I pressed on IO-pin 6 on EVA1 hcidump displayed
the following:

HCI sniffer - Bluetooth packet analyzer ver 1.34
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 0]
      0000: 01 ef 09 e3 05 0b 45 aa                           ......E.
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 03 ef 09 e1 05 0b 45 70                           ......Ep
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 0]
      0000: 01 ef 09 e3 05 0b c5 aa                           ........
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 03 ef 09 e1 05 0b c5 70                           .......p
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1

Obviously, the USB BT dongle discovered that something came in. The
question is, how do I deal with this in a C-program?
I have tried to connect to EVA1 with a socket with RF_COMM and L2CAPwith
a C-program, but the program is not able to see any incoming data. I
suspect I can dissect hcidump and/or rfcomm to see how these programs
work.

Then there is the other question, how shall I figure what the HCI BT
shall send to EVA1, the other way around? It seems impossible without
knowing the protocol or data format.

Is there anyone that knows anything about this?

Regards:
-Mikael
=20

=20


------_=_NextPart_001_01C79ECA.EF39E4C1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>How to emulate DTE and DCE with Free2Move BT HCI?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Hello!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I would like to =
emulate DTE and DCE serial handshaking with Free2Move:s =
BT.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Free2Move offers the =
&quot;Wireless UART&quot; configuration or the HCI =
configuration.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">In the =
&quot;Wireless UART&quot; configuration no external software is =
required. HCI, obviously, requires a BlueZ stack on a =
host.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I have tested =
Free2Move:s BT in the configuration &quot;Wireless UART&quot; in the =
following manner:</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Evaluation kit nr 1 =
(EVA1) has an Wireless UART that is configured as DTE.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Evaluation kit nr 2 =
(EVA2) has an Wireless UART that is configured as DCE.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">When pressing a key =
connected to IO-pin 6 (DCD on EVA1) the corresponding IO-pin 6 on EVA2 =
is activated.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">When pressing a key =
connected to IO-pin 5 (DTR on EVA2) the corresponding IO-pin5&nbsp; on =
EVA1 is activated.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">So the emulation of =
DTE and DCE over Bluetooth works with &quot;Wireless UART&quot; =
configuration.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Now, I would like =
EVA1 to connect to a HCI BT. </FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">The problem is, that =
in the HCI configuration it is not possible to configure DCE for the =
BT.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I have tried the =
following:</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I used a PC with a =
simple USB BT dongle.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I connected to EVA1 =
with the command &quot;rfcomm /dev/rfcomm0 connect &lt;address of =
EVA1&gt;&quot;</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I used hcidump and =
when I pressed on IO-pin 6 on EVA1 hcidump displayed the =
following:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">HCI sniffer =
- Bluetooth packet analyzer ver 1.34</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL =
data: handle 6 flags 0x02 dlen 12</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 8 [psm 0]</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 01 ef 09 e3 05 0b 45 =
aa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ......E.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL =
data: handle 6 flags 0x02 dlen 12</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 0]</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 03 ef 09 e1 05 0b 45 =
70&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ......Ep</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI =
Event: Number of Completed Packets (0x13) plen 5</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; handle 6 packets 1</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL =
data: handle 6 flags 0x02 dlen 12</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 8 [psm 0]</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 01 ef 09 e3 05 0b c5 =
aa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ........</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL =
data: handle 6 flags 0x02 dlen 12</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 0]</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 03 ef 09 e1 05 0b c5 =
70&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; .......p</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI =
Event: Number of Completed Packets (0x13) plen 5</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp; handle 6 packets 1</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Obviously, the USB BT =
dongle discovered that something came in. The question is, how do I deal =
with this in a C-program?</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I have tried to =
connect to EVA1 with a socket with RF_COMM and L2CAPwith a C-program, =
but the program is not able to see any incoming data. I suspect I can =
dissect hcidump and/or rfcomm to see how these programs =
work.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Then there is the =
other question, how shall I figure what the HCI BT shall send to EVA1, =
the other way around? It seems impossible without knowing the protocol =
or data format.</FONT></SPAN></P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Is there anyone that =
knows anything about this?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 =
FACE=3D"Arial">Regards:</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 =
FACE=3D"Arial">-Mikael</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C79ECA.EF39E4C1--


--===============0529062130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0529062130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0529062130==--
