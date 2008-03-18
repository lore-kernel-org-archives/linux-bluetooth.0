Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Mar 2008 10:37:35 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-devel <bluez-devel@lists.sourceforge.net>,
	Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <594525.27109.qm@web8415.mail.in.yahoo.com>
Subject: [Bluez-users] sync initiated from NOKIA moble
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0022297996=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============0022297996==
Content-Type: multipart/alternative; boundary="0-471422504-1205816855=:27109"

--0-471422504-1205816855=:27109
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi all=0AI have synced my NOKIA from my system using msynctool successfully=
.=0AHow can  I sync from my mobile now?=0AI tried =0A$msynctool --sync my-n=
okia-group --wait=0ASynchronizing group "my-nokia-group"=0A=0AThis waits in=
definately=0AAnd when I sync from my mobile and do =0A[root@localhost Pramo=
d]# /usr/local/sbin/hcidump -X=0AHCI sniffer - Bluetooth packet analyzer ve=
r 1.40=0Adevice: hci0 snap_len: 1028 filter: 0xffffffff=0A> HCI Event: Conn=
ect Request (0x04) plen 10=0A  0000: 00 14 6f 8d 18 00 0c 02  50 01        =
            ..o.....P.=0A< HCI Command: Accept Connection Request (0x01|0x0=
009) plen 7=0A  0000: 00 14 6f 8d 18 00 01                              ..o=
....=0A> HCI Event: Command Status (0x0f) plen 4=0A  0000: 00 01 09 04     =
                                  ....=0A> HCI Event: Connect Complete (0x0=
3) plen 11=0A  0000: 00 01 00 00 14 6f 8d 18  00 01 00                 ....=
.o.....=0A< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4=0A=
  0000: 01 00 0f 00                                       ....=0A> HCI Even=
t: Max Slots Change (0x1b) plen 3=0A  0000: 01 00 05                       =
                   ...=0A> HCI Event: Command Complete (0x0e) plen 6=0A  00=
00: 01 0d 08 00 01 00                                 ......=0A< HCI Comman=
d: Change Connection Packet Type (0x01|0x000f) plen 4=0A  0000: 01 00 18 cc=
                                       ....=0A> ACL data: handle 1 flags 0x=
02 dlen 12=0A    L2CAP(s): Connect req: psm 1 scid 0x0040=0A< ACL data: han=
dle 1 flags 0x02 dlen 16=0A    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00=
40 result 0 status 0=0A      Connection successful=0A> HCI Event: Command S=
tatus (0x0f) plen 4=0A  0000: 00 01 0f 04                                  =
     ....=0A< HCI Command: Remote Name Request (0x01|0x0019) plen 10=0A  00=
00: 00 14 6f 8d 18 00 02 00  00 00                    ..o.......=0A> HCI Ev=
ent: Connection Packet Type Changed (0x1d) plen 5=0A  0000: 00 01 00 18 cc =
                                   .....=0A> HCI Event: Number of Completed=
 Packets (0x13) plen 5=0A  0000: 01 01 00 01 00                            =
        ......=0A> HCI Event: Command Status (0x0f) plen 4=0A  0000: 00 01 =
19 04                                       ....=0A> HCI Event: Connection =
Packet Type Changed (0x1d) plen 5=0A  0000: 00 01 00 18 cc                 =
                   .....=0A> ACL data: handle 1 flags 0x02 dlen 10=0A    L2=
CAP(s): Info req: type 2=0A< ACL data: handle 1 flags 0x02 dlen 12=0A    L2=
CAP(s): Info rsp: type 2 result 1=0A      Not supported=0A> HCI Event: Numb=
er of Completed Packets (0x13) plen 5=0A  0000: 01 01 00 01 00             =
                       .....=0A> ACL data: handle 1 flags 0x02 dlen 12=0A  =
  L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0=0A< ACL data: handle =
1 flags 0x02 dlen 14=0A    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 res=
ult 0 clen 0=0A      Success=0A< ACL data: handle 1 flags 0x02 dlen 12=0A  =
  L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0=0A> HCI Event: Remote=
 Name Req Complete (0x07) plen 255=0A  0000: 00 00 14 6f 8d 18 00 4b  61 6e=
 64 79 00 00 00 00  ...o...Kandy.....=0A  0010: 00 00 00 00 00 00 00 00  00=
 00 00 00 00 00 00 00  ................=0A  0020: 00 00 00 00 00 00 00 00  =
00 00 00 00 00 00 00 00  ................=0A  0030: 00 00 00 00 00 00 00 00=
  00 00 00 00 00 00 00 00  ................=0A  0040: 00 00 00 00 00 00 00 =
00  00 00 00 00 00 00 00 00  ................=0A  0050: 00 00 00 00 00 00 0=
0 00  00 00 00 00 00 00 00 00  .................=0A  0060: 00 00 00 00 00 0=
0 00 00  00 00 00 00 00 00 00 00  ................=0A  0070: 00 00 00 00 00=
 00 00 00  00 00 00 00 00 00 00 00  ................=0A  0080: 00 00 00 00 =
00 00 00 00  00 00 00 00 00 00 00 00  .................=0A  0090: 00 00 00 =
00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00a0: 00 00 0=
0 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00b0: 00 00=
 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00c0: 00 =
00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00d0: 0=
0 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00e0:=
 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  00f=
0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............=0A> HC=
I Event: Number of Completed Packets (0x13) plen 5=0A  0000: 01 01 00 01 00=
                                    .....=0A> HCI Event: Number of Complete=
d Packets (0x13) plen 5=0A  0000: 01 01 00 01 00                           =
         ......=0A> ACL data: handle 1 flags 0x02 dlen 18=0A    L2CAP(s): C=
onfig rsp: scid 0x0040 flags 0x00 result 0 clen 4=0A      Success=0A      M=
TU 672=0A> ACL data: handle 1 flags 0x02 dlen 31=0A    L2CAP(d): cid 0x0040=
 len 27 [psm 1]=0A        SDP SS Req: tid 0x1 len 0x16=0A          pat uuid=
-128 00000001-0000-1000-8000-0002ee000002=0A          max 65535=0A         =
 cont 00=0A< ACL data: handle 1 flags 0x02 dlen 14=0A    L2CAP(d): cid 0x00=
40 len 10 [psm 1]=0A        SDP SS Rsp: tid 0x1 len 0x5=0A          count 0=
=0A          cont 00=0A> HCI Event: Number of Completed Packets (0x13) plen=
 5=0A  0000: 01 01 00 01 00                                    .....=0A> AC=
L data: handle 1 flags 0x02 dlen 12=0A    L2CAP(s): Disconn req: dcid 0x004=
0 scid 0x0040=0A< ACL data: handle 1 flags 0x02 dlen 12=0A    L2CAP(s): Dis=
conn rsp: dcid 0x0040 scid 0x0040=0A> HCI Event: Number of Completed Packet=
s (0x13) plen 5=0A  0000: 01 01 00 01 00                                   =
 .....=0A< HCI Command: Disconnect (0x01|0x0006) plen 3=0A  0000: 01 00 13 =
                                         ...=0A> HCI Event: Command Status =
(0x0f) plen 4=0A  0000: 00 01 06 04                                       .=
...=0A> HCI Event: Disconn Complete (0x05) plen 4=0A  0000: 00 01 00 16    =
                                   ....=0A=0ASorry for the long post...=0AC=
an anyone help in this  please???=0AIs there any other way to do this???=0A=
 =0AThanks and Best regards=0A=0APramod=0A=0A=0A=0A=0A=0A      Why delete m=
essages? Unlimited storage is just a click away. Go to http://help.yahoo.co=
m/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-471422504-1205816855=:27109
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi all<br>I have synced my NOKIA from my system using msync=
tool successfully.<br>How can&nbsp; <span style=3D"font-style: italic;">I s=
ync from my mobile now?<br><span style=3D"font-style: italic;">I tried <br>=
$msynctool --sync my-nokia-group --wait<br></span></span>=0ASynchronizing g=
roup "my-nokia-group"<br><br><span style=3D"font-style: italic;"><span styl=
e=3D"font-style: italic;">This waits indefinately<br>And when I sync from m=
y mobile and do <br>[root@localhost Pramod]# /usr/local/sbin/hcidump -X<br>=
HCI sniffer - Bluetooth packet analyzer ver 1.40<br>device: hci0 snap_len: =
1028 filter: 0xffffffff<br>&gt; HCI Event: Connect Request (0x04) plen 10<b=
r>&nbsp; 0000: 00 14 6f 8d 18 00 0c 02&nbsp; 50 01&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ..o.....P.<br>&lt; HCI Command: Accept Connection Request (0=
x01|0x0009) plen 7<br>&nbsp; 0000: 00 14 6f 8d 18 00 01&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ..o....<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000=
: 00 01 09=0A 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: Connect Complete (0x03) plen 11=
<br>&nbsp; 0000: 00 01 00 00 14 6f 8d 18&nbsp; 00 01 00&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; .....o.....<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d)=
 plen 4<br>&nbsp; 0000: 01 00 0f 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: Max Slots Ch=
ange (0x1b) plen 3<br>&nbsp; 0000: 01 00=0A 05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>=
&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp; 0000: 01 0d 08 00 =
01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&lt; HCI Command:=
 Change Connection Packet Type (0x01|0x000f) plen 4<br>&nbsp; 0000: 01 00 1=
8 cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ....<br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&=
nbsp; L2CAP(s): Connect req: psm 1=0A scid 0x0040<br>&lt; ACL data: handle =
1 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x00=
40 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connecti=
on successful<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 000=
0: 00 01 0f 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ....<br>&lt; HCI Command: Remote Name Request (0x01|0x001=
9) plen 10<br>&nbsp; 0000: 00 14 6f 8d 18 00 02 00&nbsp; 00 00&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ..o.......<br>&gt; HCI Event: Connection Packet =
Type Changed (0x1d) plen 5<br>&nbsp; 0000: 00 01 00 18=0A cc&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&gt; HCI Event: Numb=
er of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 01 00 01 00&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&gt; HCI Ev=
ent: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 19 04&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&g=
t; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp; 0000: =
00 01 00 18=0A cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; .....<br>&gt; ACL data: handle 1 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp=
; L2CAP(s): Info req: type 2<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<=
br>&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 result 1<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Not supported<br>&gt; HCI Event: Number of Completed Packe=
ts (0x13) plen 5<br>&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&gt; ACL data: handle 1 flags 0x0=
2 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0=
0 clen 0<br>&lt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp=
;=0A L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 1 flags 0x02 dlen=
 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen=
 0<br>&gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp; 00=
00: 00 00 14 6f 8d 18 00 4b&nbsp; 61 6e 64 79 00 00 00 00&nbsp; ...o...Kand=
y.....<br>&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 0=
0&nbsp; ................<br>&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 0=
0 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0030: 00 00 00 00 00 0=
0 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0040=
: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; .............=
...<br>&nbsp; 0050: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&n=
bsp; .................<br>&nbsp; 0060: 00 00 00 00 00 00 00 00&nbsp; 00 00 =
00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0070: 00 00 00 00 00
 00=0A 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp;=
 0080: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ........=
.........<br>&nbsp; 0090: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 0=
0 00&nbsp; ................<br>&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 0=
0 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00b0: 00 00 00 00 0=
0 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0=
0c0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ..........=
......<br>&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 0=
0&nbsp; ................<br>&nbsp; 00e0: 00 00 00 00 00 00 00 00&nbsp; 00 0=
0 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00f0: 00 00 00 00 00 0=
0 00 00&nbsp; 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp; ...............<=
br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000=
: 01 01 00 01=0A 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .....<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>=
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ......<br>&gt; ACL data: handle 1 flags 0x02 dlen 18<br>&nbsp;=
&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MTU 672<br>&gt; ACL data: handle 1 flags 0x02 dlen 31<br>&nbsp;&nbsp;&nbsp;=
 L2CAP(d): cid 0x0040 len 27 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SDP SS Req: tid 0x1 len=0A 0x16<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; pat uuid-128 00000001-0000-1000-8000-0002ee000002<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: =
handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x=
1 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 0=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; =
HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 01 =
00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<=
br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s=
): Disconn req: dcid 0x0040=0A scid 0x0040<br>&lt; ACL data: handle 1 flags=
 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid=
 0x0040<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nb=
sp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; .....<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nb=
sp; 0000: 01 00 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&gt; HCI Event: Command Stat=
us (0x0f) plen 4<br>&nbsp; 0000: 00 01 06=0A 04&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: =
Disconn Complete (0x05) plen 4<br>&nbsp; 0000: 00 01 00 16&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br><br><=
/span></span>Sorry for the long post...<br>Can anyone help in this&nbsp; pl=
ease???<br>Is there any other way to do this???<br><div>&nbsp;</div>Thanks =
and Best regards<br><br><div>Pramod<div><br></div></div></div><br>=0A=0A=0A=
      <!--5--><hr size=3D1></hr> Get the freedom to save as many mails as y=
ou wish. <a href=3D"http://in.rd.yahoo.com/tagline_mail_5/*http://help.yaho=
o.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here to know ho=
w.</a></body></html>
--0-471422504-1205816855=:27109--


--===============0022297996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0022297996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0022297996==--
