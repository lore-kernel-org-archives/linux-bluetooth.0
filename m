Return-Path: <Peter.K.Martin@t-online.de>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>,
   "'Marcel Holtmann'" <marcel@holtmann.org>
Subject: Toshiba and BT (SuSE 9.2)
Date: Mon, 13 Dec 2004 20:00:28 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAmw8F2L2GLkSuK/qWO0/qzgEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0023_01C4E14E.68658980"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0023_01C4E14E.68658980
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
here I'm again, the story is still runing. Now I'm able to connect to =
the
BT-accesspoint with pand only a short time till timeout.
I tried hcitool cc <baddr>
At first I have to start dmabt
Linux-Notebook:~ # dmabt

then

Linux-Notebook:~ # hcitool scan

Scanning ...

        00:0B:CE:00:01:8F       Bluetooth-Modul

the next step was

Linux-Notebook:~ # hcitool cc 00:0B:CE:00:01:8F

Linux-Notebook:~ # hcitool con

Connections:

        < ACL 00:0B:CE:00:01:8F handle 41 state 1 lm SLAVE

Linux-Notebook:~ # ip link show

1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue

    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

2: eth0: <BROADCAST,MULTICAST,NOTRAILERS,UP> mtu 1500 qdisc pfifo_fast =
qlen
1000

    link/ether 00:08:0d:a9:18:53 brd ff:ff:ff:ff:ff:ff

3: sit0: <NOARP> mtu 1480 qdisc noqueue

    link/sit 0.0.0.0 brd 0.0.0.0

Linux-Notebook:~ #                =20

=20
With YaST pand was set as pand --search --master
and as networkdevice bnep0 was initialized, so I don't understand why it
doesn't apear within the listing of ip link show.
The setup of network accesses by YaST for DSL also doesn't give me the
opportunity to use bnep0 as connection for DSL. There is only as =
PPP-Modus
PPP via Ethernet, etc. available, but not PPP via Bluetooth as I =
expected.=20
=20
Please, what is to do in order to get this foolish bnep0 device availabe =
for
DSL? bnep0 only appears in the initialization-area for network devices.
=20
The everlasting reboot with Windows in order to get internet-access is =
very
boring and makes me not really happy!!!
=20
Regards
Peter
=20

------=_NextPart_000_0023_01C4E14E.68658980
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Nachricht</TITLE>

<META content=3D"MSHTML 6.00.2800.1479" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>Hi=20
Marcel,</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>here I'm again, =
the story=20
is still runing. Now I'm able to connect to the BT-accesspoint with pand =
only a=20
short time till timeout.</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>I tried hcitool =
cc=20
&lt;baddr&gt;</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>At first I have =
to start=20
dmabt</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
# dmabt</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
class=3D436333918-13122004><FONT =
face=3DArial>then</FONT></SPAN></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
# hcitool scan</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Scanning=20
...</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>00:0B:CE:00:01:8F<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Bluetooth-Modul</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
class=3D436333918-13122004><FONT face=3DArial>the next step=20
was</FONT></SPAN></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
# hcitool cc 00:0B:CE:00:01:8F</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
# hcitool con</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
lang=3DEN-US>Connections:</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>&lt;=20
ACL 00:0B:CE:00:01:8F handle 41 state 1 lm SLAVE</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
# ip link show</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US>1: =
lo:=20
&lt;LOOPBACK,UP&gt; mtu 16436 qdisc noqueue</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>link/loopback=20
00:00:00:00:00:00 brd 00:00:00:00:00:00</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US>2: =
eth0:=20
&lt;BROADCAST,MULTICAST,NOTRAILERS,UP&gt; mtu 1500 qdisc pfifo_fast qlen =

1000</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>link/ether =
00:08:0d:a9:18:53=20
brd ff:ff:ff:ff:ff:ff</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US>3: =
sit0:=20
&lt;NOARP&gt; mtu 1480 qdisc noqueue</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>link/sit 0.0.0.0 =
brd=20
0.0.0.0</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN =
lang=3DEN-US>Linux-Notebook:~=20
#<SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></P></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>With YaST pand =
was set as=20
pand --search --master</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>and as =
networkdevice bnep0=20
was initialized, so I don't understand why it doesn't apear within the =
listing=20
of ip link show.</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>The setup of=20
network&nbsp;accesses by YaST for DSL also doesn't give me the =
opportunity to=20
use bnep0 as connection for DSL. There is only as PPP-Modus PPP via =
Ethernet,=20
etc. available, but not PPP via Bluetooth as I expected. =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>Please, what is =
to do in=20
order to get this foolish bnep0 device availabe for DSL? bnep0 only =
appears in=20
the initialization-area for network devices.</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D436333918-13122004><FONT face=3DArial>The everlasting =
reboot with=20
Windows in order to get internet-access is very boring and makes me not =
really=20
happy!!!</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial>Regards</FONT></SPAN></DIV>
<DIV><SPAN class=3D436333918-13122004><FONT =
face=3DArial>Peter</FONT></SPAN></DIV>
<DIV><FONT face=3DArial color=3D#173c66=20
size=3D2><STRONG><EM></EM></STRONG></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0023_01C4E14E.68658980--
