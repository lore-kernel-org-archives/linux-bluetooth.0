Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80511121135o5ee92e8bn9cdf5317f25d6e6d@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rfcomm simultaneous connection
In-Reply-To: <1131811109.29461.24.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_261_8606604.1131824110945"
References: <45bf5ff80511120733m222f37b0u580167f357e3b282@mail.gmail.com>
	 <1131811109.29461.24.camel@blade>
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
Date: Sat, 12 Nov 2005 19:35:10 +0000

------=_Part_261_8606604.1131824110945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Marcel
 The output is the follow
  t01:/# /usr/local/sbin/hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
bdaddr 00:13:FD:BB:22:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
bdaddr 00:14:60:01:23:45 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x0c ncmd 1
Error: Command Disallowed
> HCI Event: Connect Complete (0x03) plen 11
status 0x00 handle 42 bdaddr 00:13:FD:BB:22:3F type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
handle 42 policy 0x01
Link policy: RSWITCH
> HCI Event: Command Complete (0x0e) plen 6
Write Link Policy Settings (0x02|0x000d) ncmd 1
status 0x00 handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
handle 42 slots 5
> ACL data: handle 42 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x007e scid 0x0040 result 1 status 2
Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x007e scid 0x0040 result 0 status 0
Connection successful
< ACL data: handle 42 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x007e flags 0x00 clen 4
MTU 1024
> ACL data: handle 42 flags 0x02 dlen 12
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x007e flags 0x00 result 0 clen 0
Success
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 17
> ACL data: handle 42 flags 0x01 dlen 1
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
Success
MTU 672
< ACL data: handle 42 flags 0x02 dlen 8
L2CAP(d): cid 0x007e len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
L2CAP(d): cid 0x0040 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 42 flags 0x02 dlen 18
L2CAP(d): cid 0x007e len 14 [psm 3]
RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
frame_size 667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
L2CAP(d): cid 0x0040 len 14 [psm 3]
RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
frame_size 667 max_retrans 0 credits 3
< ACL data: handle 42 flags 0x02 dlen 8
L2CAP(d): cid 0x007e len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 42 packets 1
 Thank you
Regards
 Artur

 On 11/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Artur,
>
> no cross-posting. I mentioned that many times now.
>
> > Can someone please confirm me that i have the correct understanding of
> > the following:
> >
> >
> > Im trying to send a file over obex to device 1 a bt phone. He receives
> > the prompt to accept the file and i dont answer.
> > If i try to send another file to device 2 anoter btphone, bluez says
> > no resources, but if i accept the file in device 1 and start to
> > download it i can then prompt the device 2 to accept the file and
> > transmit to both at the same time. Resuming when rfcomm is trying to
> > connect to a device he haves to wait until that device gives a time
> > out or accepts the connection before trying to connect to another
> > device.
> >
> > Is this true? Can i control the timeout of the connection on the bluez
> > side?
> >
> > Is there a way to establish several connections to many devices
> > without depending between them?
>
> use "hcidump -X -V" to show what's going on.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_261_8606604.1131824110945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello Marcel</div>
<div>&nbsp;</div>
<div>The output is the follow</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>t01:/# /usr/local/sbin/hcidump -X -V<br>HCI sniffer - Bluetooth packet=
 analyzer ver 1.27<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt=
; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp=
; bdaddr 00:13:FD:BB:22:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Eve=
nt: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0=
x01|0x0005) status 0x00 ncmd 1<br>&lt; HCI Command: Create Connection (0x01=
|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:14:60:01:23:45 ptype 0xcc1=
8 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Eve=
nt: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0=
x01|0x0005) status 0x0c ncmd 1<br>&nbsp;&nbsp;&nbsp; Error: Command Disallo=
wed<br>&gt; HCI Event: Connect Complete (0x03) plen 11
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:13:FD:BB:22:3F type =
ACL encrypt 0x00<br>&lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&n=
bsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0040<br>&lt; HCI Command: Wr=
ite Link Policy Settings (0x02|0x000d) plen 4
<br>&nbsp;&nbsp;&nbsp; handle 42 policy 0x01<br>&nbsp;&nbsp;&nbsp; Link pol=
icy: RSWITCH<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp;&nb=
sp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>&nbsp;&nbsp;&n=
bsp; status 0x00 handle 42<br>&gt; HCI Event: Number of Completed Packets (=
0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; HCI Event: Max Slots Cha=
nge (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp; handle 42 slots 5<br>&gt; ACL data:=
 handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: =
dcid 0x007e scid 0x0040 result 1 status 2
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - Authorization pendi=
ng<br>&gt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2C=
AP(s): Connect rsp: dcid 0x007e scid 0x0040 result 0 status 0<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 42 flag=
s 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x007e flags 0x00 clen 4<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024<br>&gt; ACL data: handle 42 flag=
s 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flag=
s 0x00 clen 0<br>&lt; ACL data: handle 42 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x007e flags 0x00 result =
0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&gt; HCI Event: Numbe=
r of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packet=
s 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; ACL data: handle 42 flag=
s 0x02 dlen 17<br>&gt; ACL data: handle 42 flags 0x01 dlen 1<br>&nbsp;&nbsp=
;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 6=
72
<br>&lt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(=
d): cid 0x007e len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): S=
ABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<br>&gt; HCI Event: Number of Complete=
d Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1
<br>&gt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(=
d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): U=
A: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>&lt; ACL data: handle 42 flags 0x02 =
dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x007e len 14 [psm 3]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen=
 10 fcs 0x70 mcc_len 8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 frame_type=
 0 credit_flow 15 pri 7 ack_timer 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame=
_size 667 max_retrans 0 credits 7<br>&gt; HCI Event: Number of Completed Pa=
ckets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; ACL data: handle 42 flag=
s 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 14 [psm 3]<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10=
 fcs 0xaa mcc_len 8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 frame_type 0 =
credit_flow 14 pri 7 ack_timer 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 667 max_retrans 0 credits 3<b=
r>&lt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d)=
: cid 0x007e len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SAB=
M: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32<br>&gt; HCI Event: Number of Completed=
 Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&nbsp;</div>
<div>Thank you</div>
<div>Regards</div>
<div>&nbsp;</div>
<div>Artur<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 11/12/05, <b class=3D"gmail_sendername"=
>Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holt=
mann.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Artur,<br><br>no cross-postin=
g. I mentioned that many times now.<br><br>&gt; Can someone please confirm =
me that i have the correct understanding of
<br>&gt; the following:<br>&gt;<br>&gt;<br>&gt; Im trying to send a file ov=
er obex to device 1 a bt phone. He receives<br>&gt; the prompt to accept th=
e file and i dont answer.<br>&gt; If i try to send another file to device 2=
 anoter btphone, bluez says
<br>&gt; no resources, but&nbsp;&nbsp;if i accept the file in device 1 and =
start to<br>&gt; download it i can then prompt the device 2 to accept the f=
ile and<br>&gt; transmit to both at the same time. Resuming when rfcomm is =
trying to
<br>&gt; connect to a device he haves to wait until that device gives a tim=
e<br>&gt; out or accepts the connection before trying to connect to another=
<br>&gt; device.<br>&gt;<br>&gt; Is this true? Can i control the timeout of=
 the connection on the bluez
<br>&gt; side?<br>&gt;<br>&gt; Is there a way to establish several connecti=
ons to many devices<br>&gt; without depending between them?<br><br>use &quo=
t;hcidump -X -V&quot; to show what's going on.<br><br>Regards<br><br>Marcel
<br><br><br><br><br>-------------------------------------------------------=
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server. Download<br>it for free - -and be entered to =
win a 42&quot; plasma tv or your very own
<br>Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http://sourcefor=
ge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br>___________=
____________________________________<br>Bluez-devel mailing list<br><a href=
=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_261_8606604.1131824110945--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
