Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jan 2008 09:16:30 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <50280.76110.qm@web8413.mail.in.yahoo.com>
Subject: [Bluez-users] trouble in handsfree profile
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0026135782=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0026135782==
Content-Type: multipart/alternative; boundary="0-205952945-1201059990=:76110"

--0-205952945-1201059990=:76110
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi list=0A=0Ai am trying to implement handsfree profile on my system.=0A=0A=
i have downloaded a application which works to make my linux system a heads=
et.=0A=0Ai am using a Bt dongle and trying to connect my nokia 6600 to my s=
ystem. =0A=0Ai am able to pair them, and establish a ACL connection between=
 them.=0A=0Abut i cant establish a sco connection. The RING code is being r=
eceived on the system.=0A=0Abut not being heard. Some commands are being ex=
changed. =0A=0AMy doubt is what is the socket or interface from where the a=
udio data can be received?=0A=0AIs it a socket ID got from SCO connection?=
=0A=0AI am really in trouble with this?=0A=0Ai am sending the log of hcidum=
p command        =0A=0A=0A=0A[root@localhost dev]# /usr/local/sbin/hcidump =
-V -a=0A=0AHCI sniffer - Bluetooth packet analyzer ver 1.40=0A=0Adevice: hc=
i0 snap_len: 1028 filter: 0xffffffff=0A=0A< HCI Command: Read Voice Setting=
 (0x03|0x0025) plen 0=0A=0A> HCI Event: Command Complete (0x0e) plen 6=0A=
=0A    Read Voice Setting (0x03|0x0025) ncmd 1=0A=0A    status 0x00 voice s=
etting 0x0060=0A=0A< HCI Command: Create Connection (0x01|0x0005) plen 13=
=0A=0A    bdaddr 00:0E:6D:E0:E5:13 ptype 0xcc18 rswitch 0x01 clkoffset 0x00=
00=0A=0A    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=0A=0A> HCI Event: Command =
Status (0x0f) plen 4=0A=0A    Create Connection (0x01|0x0005) status 0x00 n=
cmd 1=0A=0A> HCI Event: Connect Complete (0x03) plen 11=0A=0A    status 0x0=
0 handle 6 bdaddr 00:0E:6D:E0:E5:13 type ACL encrypt 0x00=0A=0A< ACL data: =
handle 6 flags 0x02 dlen 12=0A=0A    L2CAP(s): Connect req: psm 3 scid 0x00=
40=0A=0A< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4=0A=
=0A    handle 6 policy 0x0f=0A=0A    Link policy: RSWITCH HOLD SNIFF PARK=
=0A=0A> HCI Event: Command Complete (0x0e) plen 6=0A=0A    Write Link Polic=
y Settings (0x02|0x000d) ncmd 1=0A=0A    status 0x00 handle 6=0A=0A< HCI Co=
mmand: Remote Name Request (0x01|0x0019) plen 10=0A=0A    bdaddr 00:0E:6D:E=
0:E5:13 mode 2 clkoffset 0x0000=0A=0A> HCI Event: Max Slots Change (0x1b) p=
len 3=0A=0A    handle 6 slots 5=0A=0A> HCI Event: Command Status (0x0f) ple=
n 4=0A=0A    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1=0A=0A> HC=
I Event: Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 packet=
s 1=0A=0A> HCI Event: QoS Setup Complete (0x0d) plen 21=0A=0A    status 0x0=
0 handle 6 flags 0=0A=0A    Service type: 0=0A=0A    Token rate: 44800=0A=
=0A    Peak bandwith: 0=0A=0A    Latency: 0=0A=0A    Delay variation: 0=0A=
=0A> HCI Event: Remote Name Req Complete (0x07) plen 255=0A=0A    status 0x=
00 bdaddr 00:0E:6D:E0:E5:13 name 'Nokia 6600pamu'=0A=0A> ACL data: handle 6=
 flags 0x02 dlen 16=0A=0A    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0040=
 result 1 status 2=0A=0A      Connection pending - Authorization pending=0A=
=0A> ACL data: handle 6 flags 0x02 dlen 16=0A=0A    L2CAP(s): Connect rsp: =
dcid 0x006b scid 0x0040 result 0 status 0=0A=0A      Connection successful=
=0A=0A< ACL data: handle 6 flags 0x02 dlen 16=0A=0A    L2CAP(s): Config req=
: dcid 0x006b flags 0x00 clen 4=0A=0A      MTU 1013=0A=0A> ACL data: handle=
 6 flags 0x02 dlen 12=0A=0A    L2CAP(s): Config req: dcid 0x0040 flags 0x00=
 clen 0=0A=0A< ACL data: handle 6 flags 0x02 dlen 14=0A=0A    L2CAP(s): Con=
fig rsp: scid 0x006b flags 0x00 result 0 clen 0=0A=0A      Success=0A=0A> H=
CI Event: Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 packe=
ts 2=0A=0A> ACL data: handle 6 flags 0x02 dlen 18=0A=0A    L2CAP(s): Config=
 rsp: scid 0x0040 flags 0x00 result 0 clen 4=0A=0A      Success=0A=0A      =
MTU 672=0A=0A< ACL data: handle 6 flags 0x02 dlen 8=0A=0A    L2CAP(d): cid =
0x006b len 4 [psm 3]=0A=0A      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fc=
s 0x1c=0A=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A=0A   =
 handle 6 packets 1=0A=0A> ACL data: handle 6 flags 0x02 dlen 8=0A=0A    L2=
CAP(d): cid 0x0040 len 4 [psm 3]=0A=0A      RFCOMM(s): UA: cr 1 dlci 0 pf 1=
 ilen 0 fcs 0xd7=0A=0A< ACL data: handle 6 flags 0x02 dlen 18=0A=0A    L2CA=
P(d): cid 0x006b len 14 [psm 3]=0A=0A      RFCOMM(s): PN CMD: cr 1 dlci 0 p=
f 0 ilen 10 fcs 0x70 mcc_len 8=0A=0A      dlci 6 frame_type 0 credit_flow 1=
5 pri 7 ack_timer 0=0A=0A      frame_size 667 max_retrans 0 credits 7=0A=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 pa=
ckets 1=0A=0A> ACL data: handle 6 flags 0x02 dlen 18=0A=0A    L2CAP(d): cid=
 0x0040 len 14 [psm 3]=0A=0A      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen =
10 fcs 0xaa mcc_len 8=0A=0A      dlci 6 frame_type 0 credit_flow 14 pri 7 a=
ck_timer 0=0A=0A      frame_size 667 max_retrans 0 credits 3=0A=0A< ACL dat=
a: handle 6 flags 0x02 dlen 8=0A=0A    L2CAP(d): cid 0x006b len 4 [psm 3]=
=0A=0A      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3=0A=0A> HCI Ev=
ent: Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 packets 1=
=0A=0A> HCI Event: Link Key Request (0x17) plen 6=0A=0A    bdaddr 00:0E:6D:=
E0:E5:13=0A=0A< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22=
=0A=0A    bdaddr 00:0E:6D:E0:E5:13 key 82A6A81362F6E7AC6372C07291B8CFA4=0A=
=0A> HCI Event: Command Complete (0x0e) plen 10=0A=0A    Link Key Request R=
eply (0x01|0x000b) ncmd 1=0A=0A    status 0x00 bdaddr 00:0E:6D:E0:E5:13=0A=
=0A< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22=0A=0A    bda=
ddr 00:0E:6D:E0:E5:13 key 82A6A81362F6E7AC6372C07291B8CFA4=0A=0A> HCI Event=
: Command Complete (0x0e) plen 10=0A=0A    Link Key Request Reply (0x01|0x0=
00b) ncmd 1=0A=0A    status 0x00 bdaddr 00:0E:6D:E0:E5:13=0A=0A> HCI Event:=
 Encrypt Change (0x08) plen 4=0A=0A    status 0x00 handle 6 encrypt 0x01=0A=
=0A> ACL data: handle 6 flags 0x02 dlen 8=0A=0A    L2CAP(d): cid 0x0040 len=
 4 [psm 3]=0A=0A      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18=0A=0A=
< ACL data: handle 6 flags 0x02 dlen 12=0A=0A    L2CAP(d): cid 0x006b len 8=
 [psm 3]=0A=0A      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mc=
c_len 2=0A=0A      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7=
=0A=0A< HCI Command: Add SCO Connection (0x01|0x0007) plen 4=0A=0A    handl=
e 6 ptype 0x00e0=0A=0A    Packet type: HV1 HV2 HV3=0A=0A> ACL data: handle =
6 flags 0x02 dlen 12=0A=0A    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=0A     =
 RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=0A      =
dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7=0A=0A< ACL data: han=
dle 6 flags 0x02 dlen 12=0A=0A    L2CAP(d): cid 0x006b len 8 [psm 3]=0A=0A =
     RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=0A  =
    dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7=0A=0A> HCI Event=
: Command Status (0x0f) plen 4=0A=0A    Add SCO Connection (0x01|0x0007) st=
atus 0x00 ncmd 1=0A=0A> HCI Event: Number of Completed Packets (0x13) plen =
5=0A=0A    handle 6 packets 2=0A=0A> ACL data: handle 6 flags 0x02 dlen 12=
=0A=0A    L2CAP(d): cid 0x0040 len 8 [psm 3]=0A=0A      RFCOMM(s): MSC RSP:=
 cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=0A      dlci 6 fc 0 rtc 1 rt=
r 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7=0A=0A< ACL data: handle 6 flags 0x02 dle=
n 9=0A=0A    L2CAP(d): cid 0x006b len 5 [psm 3]=0A=0A      RFCOMM(d): UIH: =
cr 1 dlci 6 pf 1 ilen 0 fcs 0x93 credits 33=0A=0A> HCI Event: Connect Compl=
ete (0x03) plen 11=0A=0A    status 0x00 handle 1 bdaddr 00:0E:6D:E0:E5:13 t=
ype SCO encrypt 0x01=0A=0A> HCI Event: Max Slots Change (0x1b) plen 3=0A=0A=
    handle 6 slots 1=0A=0A< ACL data: handle 6 flags 0x02 dlen 19=0A=0A    =
L2CAP(d): cid 0x006b len 15 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 1 dlci 6 =
pf 0 ilen 11 fcs 0x8f=0A=0A      A T + B R S F =3D 3 1 .=0A=0A> HCI Event: =
Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 packets 2=0A=0A=
> ACL data: handle 6 flags 0x02 dlen 9=0A=0A    L2CAP(d): cid 0x0040 len 5 =
[psm 3]=0A=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49 credits=
 5=0A=0A> ACL data: handle 6 flags 0x02 dlen 27=0A=0A    L2CAP(d): cid 0x00=
40 len 23 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 19 fcs 0=
x55=0A=0A      . . + B R S F :   4 7 . . . . O K . .=0A=0A< ACL data: handl=
e 6 flags 0x02 dlen 18=0A=0A    L2CAP(d): cid 0x006b len 14 [psm 3]=0A=0A  =
    RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 10 fcs 0x8f=0A=0A      A T + C I =
N D =3D ? .=0A=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
=0A    handle 6 packets 1=0A=0A> ACL data: handle 6 flags 0x02 dlen 26=0A=
=0A> ACL data: handle 6 flags 0x01 dlen 26=0A=0A> ACL data: handle 6 flags =
0x01 dlen 26=0A=0A> ACL data: handle 6 flags 0x01 dlen 21=0A=0A    L2CAP(d)=
: cid 0x0040 len 95 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ile=
n 90 fcs 0x49 credits 1=0A=0A      . . + C I N D :   ( " c a l l " , ( 0 ,=
=0A=0A      1 ) ) , ( " s e r v i c e " , ( 0 , 1 )=0A=0A      ) , ( " c a =
l l _ s e t u p " , ( 0 - 3=0A=0A      ) ) , ( " c a l l s e t u p " , ( 0 =
- 3=0A=0A      ) ) . . . . O K . .=0A=0A< ACL data: handle 6 flags 0x02 dle=
n 17=0A=0A    L2CAP(d): cid 0x006b len 13 [psm 3]=0A=0A      RFCOMM(d): UIH=
: cr 1 dlci 6 pf 0 ilen 9 fcs 0x8f=0A=0A      A T + C I N D ? .=0A=0A> HCI =
Event: Number of Completed Packets (0x13) plen 5=0A=0A    handle 6 packets =
1=0A=0A> ACL data: handle 6 flags 0x02 dlen 26=0A=0A> ACL data: handle 6 fl=
ags 0x01 dlen 7=0A=0A    L2CAP(d): cid 0x0040 len 29 [psm 3]=0A=0A      RFC=
OMM(d): UIH: cr 0 dlci 6 pf 1 ilen 24 fcs 0x49 credits 1=0A=0A      . . + C=
 I N D :   0 , 1 , 0 , 0 . . . .=0A=0A      O K . .=0A=0A< ACL data: handle=
 6 flags 0x02 dlen 24=0A=0A    L2CAP(d): cid 0x006b len 20 [psm 3]=0A=0A   =
   RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 16 fcs 0x8f=0A=0A      A T + C M E=
 R =3D 3 , 0 , 0 , 1 .=0A=0A> HCI Event: Number of Completed Packets (0x13)=
 plen 5=0A=0A    handle 6 packets 1=0A=0A> ACL data: handle 6 flags 0x02 dl=
en 15=0A=0A    L2CAP(d): cid 0x0040 len 11 [psm 3]=0A=0A      RFCOMM(d): UI=
H: cr 0 dlci 6 pf 1 ilen 6 fcs 0x49 credits 1=0A=0A      . . O K . .=0A=0A<=
 ACL data: handle 6 flags 0x02 dlen 24=0A=0A    L2CAP(d): cid 0x006b len 20=
 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 16 fcs 0x8f=0A=0A=
      A T + C M E R =3D 3 , 0 , 0 , 1 .=0A=0A> HCI Event: Number of Complet=
ed Packets (0x13) plen 5=0A=0A    handle 6 packets 1=0A=0A> ACL data: handl=
e 6 flags 0x02 dlen 15=0A=0A    L2CAP(d): cid 0x0040 len 11 [psm 3]=0A=0A  =
    RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 6 fcs 0x49 credits 1=0A=0A      .=
 . O K . .=0A=0A< ACL data: handle 6 flags 0x02 dlen 18=0A=0A    L2CAP(d): =
cid 0x006b len 14 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen =
10 fcs 0x8f=0A=0A      A T + C L I P =3D 1 .=0A=0A> HCI Event: Number of Co=
mpleted Packets (0x13) plen 5=0A=0A    handle 6 packets 1=0A=0A> ACL data: =
handle 6 flags 0x02 dlen 15=0A=0A    L2CAP(d): cid 0x0040 len 11 [psm 3]=0A=
=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 6 fcs 0x49 credits 1=0A=0A  =
    . . O K . .=0A=0A< ACL data: handle 6 flags 0x02 dlen 18=0A=0A    L2CAP=
(d): cid 0x006b len 14 [psm 3]=0A=0A      RFCOMM(d): UIH: cr 1 dlci 6 pf 0 =
ilen 10 fcs 0x8f=0A=0A      A T + C H L D =3D ? .=0A=0A> HCI Event: Number =
of Completed Packets (0x13) plen 5=0A=0A    handle 6 packets 1=0A=0A> ACL d=
ata: handle 6 flags 0x02 dlen 26=0A=0A> ACL data: handle 6 flags 0x01 dlen =
17=0A=0A    L2CAP(d): cid 0x0040 len 39 [psm 3]=0A=0A      RFCOMM(d): UIH: =
cr 0 dlci 6 pf 1 ilen 34 fcs 0x49 credits 1=0A=0A      . . + C H L D :   ( =
0 , 1 , 1 x , 2 , 2=0A=0A      x , 3 , 4 ) . . . . O K . .=0A=0A=0A=0A*****=
******this is till i receive a ring on my mobile***********=0A=0AAfter rece=
iving a ring  i see something like this....=0A=0A=0A=0A> ACL data: handle 6=
 flags 0x02 dlen 26=0A=0A> ACL data: handle 6 flags 0x01 dlen 26=0A=0A> ACL=
 data: handle 6 flags 0x01 dlen 22=0A=0A    L2CAP(d): cid 0x0040 len 70 [ps=
m 3]=0A=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 66 fcs 0x55=0A=0A    =
  . . + C I E V :   3 , 1 . . . . + C I E=0A=0A      V :   4 , 1 . . . . R =
I N G . . . . + C=0A=0A      L I P :   " + 9 1 9 9 1 6 1 7 5 2 6 7 "=0A=0A =
     , 1 4 5 . .=0A=0A> ACL data: handle 6 flags 0x02 dlen 26=0A=0A> ACL da=
ta: handle 6 flags 0x01 dlen 20=0A=0A    L2CAP(d): cid 0x0040 len 42 [psm 3=
]=0A=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 38 fcs 0x55=0A=0A      .=
 . R I N G . . . . + C L I P :   " + 9=0A=0A      1 9 9 1 6 1 7 5 2 6 7 " ,=
 1 4 5 . .=0A=0A> ACL data: handle 6 flags 0x02 dlen 26=0A=0A> ACL data: ha=
ndle 6 flags 0x01 dlen 20=0A=0A    L2CAP(d): cid 0x0040 len 42 [psm 3]=0A=
=0A      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 38 fcs 0x55=0A=0A      . . R=
 I N G . . . . + C L I P :   " + 9=0A=0A      1 9 9 1 6 1 7 5 2 6 7 " , 1 4=
 5 . .=0A=0A> ACL data: handle 6 flags 0x02 dlen 26=0A=0A> ACL data: handle=
 6 flags 0x01 dlen 24=0A=0A    L2CAP(d): cid 0x0040 len 46 [psm 3]=0A=0A   =
   RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 42 fcs 0x55=0A=0A      . . + C I E=
 V :   1 , 0 . . . . + C I E=0A=0A      V :   3 , 0 . . . . + C I E V :   4=
 , 0=0A=0A=0A=0A=0A=0ABut when i receive the call no voice is heard...=0A=
=0Aplease help me..=0A=0Athanks in advance...=0A=0Athank you=0A=0APramod=0A=
=0A=0A=0A=0A=0A=0A=0A=0A=0A      Save all your chat conversations. Find the=
m online at http://in.messenger.yahoo.com/webmessengerpromo.php
--0-205952945-1201059990=:76110
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>hi list<br>=0Ai am trying to implement handsfree profi=
le on my system.<br>=0Ai have downloaded a application which works to make =
my linux system a headset.<br>=0Ai am using a Bt dongle and trying to conne=
ct my nokia 6600 to my system. <br>=0Ai am able to pair them, and establish=
 a ACL connection between them.<br>=0Abut i cant establish a sco connection=
.. The RING code is being received on the system.<br>=0Abut not being heard.=
 Some commands are being exchanged. <br>=0AMy doubt is what is the socket o=
r interface from where the audio data can be received?<br>=0AIs it a socket=
 ID got from SCO connection?<br>=0AI am really in trouble with this?<br>=0A=
i am sending the log of hcidump command&nbsp;&nbsp;  &nbsp;&nbsp;  <br>=0A<=
br>=0A[root@localhost dev]# /usr/local/sbin/hcidump -V -a<br>=0AHCI sniffer=
 - Bluetooth packet analyzer ver 1.40<br>=0Adevice: hci0 snap_len: 1028 fil=
ter: 0xffffffff<br>=0A&lt; HCI Command: Read Voice Setting (0x03|0x0025) pl=
en 0<br>=0A&gt; HCI Event: Command Complete (0x0e) plen 6<br>=0A&nbsp;&nbsp=
;&nbsp; Read Voice Setting (0x03|0x0025) ncmd 1<br>=0A&nbsp;&nbsp;&nbsp; st=
atus 0x00 voice setting 0x0060<br>=0A&lt; HCI Command: Create Connection (0=
x01|0x0005) plen 13<br>=0A&nbsp;&nbsp;&nbsp; bdaddr 00:0E:6D:E0:E5:13 ptype=
 0xcc18 rswitch 0x01 clkoffset 0x0000<br>=0A&nbsp;&nbsp;&nbsp; Packet type:=
 DM1 DM3 DM5 DH1 DH3 DH5<br>=0A&gt; HCI Event: Command Status (0x0f) plen 4=
<br>=0A&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd =
1<br>=0A&gt; HCI Event: Connect Complete (0x03) plen 11<br>=0A&nbsp;&nbsp;&=
nbsp; status 0x00 handle 6 bdaddr 00:0E:6D:E0:E5:13 type ACL encrypt 0x00<b=
r>=0A&lt; ACL data: handle 6 flags 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; L2=
CAP(s): Connect req: psm 3 scid 0x0040<br>=0A&lt; HCI Command: Write Link P=
olicy Settings (0x02|0x000d) plen 4<br>=0A&nbsp;&nbsp;&nbsp; handle 6 polic=
y 0x0f<br>=0A&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>=0A=
&gt; HCI Event: Command Complete (0x0e) plen 6<br>=0A&nbsp;&nbsp;&nbsp; Wri=
te Link Policy Settings (0x02|0x000d) ncmd 1<br>=0A&nbsp;&nbsp;&nbsp; statu=
s 0x00 handle 6<br>=0A&lt; HCI Command: Remote Name Request (0x01|0x0019) p=
len 10<br>=0A&nbsp;&nbsp;&nbsp; bdaddr 00:0E:6D:E0:E5:13 mode 2 clkoffset 0=
x0000<br>=0A&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>=0A&nbsp;&nbs=
p;&nbsp; handle 6 slots 5<br>=0A&gt; HCI Event: Command Status (0x0f) plen =
4<br>=0A&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 nc=
md 1<br>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>=0A=
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>=0A&gt; HCI Event: QoS Setup Compl=
ete (0x0d) plen 21<br>=0A&nbsp;&nbsp;&nbsp; status 0x00 handle 6 flags 0<br=
>=0A&nbsp;&nbsp;&nbsp; Service type: 0<br>=0A&nbsp;&nbsp;&nbsp; Token rate:=
 44800<br>=0A&nbsp;&nbsp;&nbsp; Peak bandwith: 0<br>=0A&nbsp;&nbsp;&nbsp; L=
atency: 0<br>=0A&nbsp;&nbsp;&nbsp; Delay variation: 0<br>=0A&gt; HCI Event:=
 Remote Name Req Complete (0x07) plen 255<br>=0A&nbsp;&nbsp;&nbsp; status 0=
x00 bdaddr 00:0E:6D:E0:E5:13 name 'Nokia 6600pamu'<br>=0A&gt; ACL data: han=
dle 6 flags 0x02 dlen 16<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dc=
id 0x006b scid 0x0040 result 1 status 2<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Connection pending - Authorization pending<br>=0A&gt; ACL data: handle 6 =
flags 0x02 dlen 16<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0=
06b scid 0x0040 result 0 status 0<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Conn=
ection successful<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 16<br>=0A&n=
bsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x006b flags 0x00 clen 4<br>=0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1013<br>=0A&gt; ACL data: handle 6 flags=
 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 fl=
ags 0x00 clen 0<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 14<br>=0A&nbs=
p;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x006b flags 0x00 result 0 clen 0=
<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>=0A&gt; HCI Event: Number =
of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packet=
s 2<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 18<br>=0A&nbsp;&nbsp;&nbs=
p; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>=0A&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU =
672<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 8<br>=0A&nbsp;&nbsp;&nbsp=
; L2CAP(d): cid 0x006b len 4 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
FCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<br>=0A&gt; HCI Event: Numb=
er of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 pac=
kets 1<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 8<br>=0A&nbsp;&nbsp;&n=
bsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>=0A&lt; ACL data: hand=
le 6 flags 0x02 dlen 18<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len 1=
4 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci=
 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlc=
i 6 frame_type 0 credit_flow 15 pri 7 ack_timer 0<br>=0A&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; frame_size 667 max_retrans 0 credits 7<br>=0A&gt; HCI Event: Nu=
mber of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 p=
ackets 1<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 18<br>=0A&nbsp;&nbsp=
;&nbsp; L2CAP(d): cid 0x0040 len 14 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<br>=0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 6 frame_type 0 credit_flow 14 pri 7 ack=
_timer 0<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 667 max_retrans 0 =
credits 3<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 8<br>=0A&nbsp;&nbsp=
;&nbsp; L2CAP(d): cid 0x006b len 4 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3<br>=0A&gt; HCI Event=
: Number of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle=
 6 packets 1<br>=0A&gt; HCI Event: Link Key Request (0x17) plen 6<br>=0A&nb=
sp;&nbsp;&nbsp; bdaddr 00:0E:6D:E0:E5:13<br>=0A&lt; HCI Command: Link Key R=
equest Reply (0x01|0x000b) plen 22<br>=0A&nbsp;&nbsp;&nbsp; bdaddr 00:0E:6D=
:E0:E5:13 key 82A6A81362F6E7AC6372C07291B8CFA4<br>=0A&gt; HCI Event: Comman=
d Complete (0x0e) plen 10<br>=0A&nbsp;&nbsp;&nbsp; Link Key Request Reply (=
0x01|0x000b) ncmd 1<br>=0A&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0E:6D:E0=
:E5:13<br>=0A&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22=
<br>=0A&nbsp;&nbsp;&nbsp; bdaddr 00:0E:6D:E0:E5:13 key 82A6A81362F6E7AC6372=
C07291B8CFA4<br>=0A&gt; HCI Event: Command Complete (0x0e) plen 10<br>=0A&n=
bsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1<br>=0A&nbsp;&n=
bsp;&nbsp; status 0x00 bdaddr 00:0E:6D:E0:E5:13<br>=0A&gt; HCI Event: Encry=
pt Change (0x08) plen 4<br>=0A&nbsp;&nbsp;&nbsp; status 0x00 handle 6 encry=
pt 0x01<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 8<br>=0A&nbsp;&nbsp;&=
nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18<br>=0A&lt; ACL data: han=
dle 6 flags 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len =
8 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlc=
i 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlc=
i 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7<br>=0A&lt; HCI Command:=
 Add SCO Connection (0x01|0x0007) plen 4<br>=0A&nbsp;&nbsp;&nbsp; handle 6 =
ptype 0x00e0<br>=0A&nbsp;&nbsp;&nbsp; Packet type: HV1 HV2 HV3<br>=0A&gt; A=
CL data: handle 6 flags 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid=
 0x0040 len 8 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC C=
MD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<br>=0A&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7<br>=0A&lt; =
ACL data: handle 6 flags 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): ci=
d 0x006b len 8 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC =
RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>=0A&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7<br>=0A&gt;=
 HCI Event: Command Status (0x0f) plen 4<br>=0A&nbsp;&nbsp;&nbsp; Add SCO C=
onnection (0x01|0x0007) status 0x00 ncmd 1<br>=0A&gt; HCI Event: Number of =
Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 2=
<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 12<br>=0A&nbsp;&nbsp;&nbsp; =
L2CAP(d): cid 0x0040 len 8 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFC=
OMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<br>=0A&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len =
7<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 9<br>=0A&nbsp;&nbsp;&nbsp; =
L2CAP(d): cid 0x006b len 5 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFC=
OMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93 credits 33<br>=0A&gt; HCI Eve=
nt: Connect Complete (0x03) plen 11<br>=0A&nbsp;&nbsp;&nbsp; status 0x00 ha=
ndle 1 bdaddr 00:0E:6D:E0:E5:13 type SCO encrypt 0x01<br>=0A&gt; HCI Event:=
 Max Slots Change (0x1b) plen 3<br>=0A&nbsp;&nbsp;&nbsp; handle 6 slots 1<b=
r>=0A&lt; ACL data: handle 6 flags 0x02 dlen 19<br>=0A&nbsp;&nbsp;&nbsp; L2=
CAP(d): cid 0x006b len 15 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCO=
MM(d): UIH: cr 1 dlci 6 pf 0 ilen 11 fcs 0x8f<br>=0A&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; A T + B R S F =3D 3 1 .<br>=0A&gt; HCI Event: Number of Completed P=
ackets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 2<br>=0A&gt;=
 ACL data: handle 6 flags 0x02 dlen 9<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): ci=
d 0x0040 len 5 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH:=
 cr 0 dlci 6 pf 1 ilen 0 fcs 0x49 credits 5<br>=0A&gt; ACL data: handle 6 f=
lags 0x02 dlen 27<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 23 [psm=
 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 0 i=
len 19 fcs 0x55<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . + B R S F :&nbsp;&=
nbsp; 4 7 . . . . O K . .<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 18<=
br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len 14 [psm 3]<br>=0A&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 10 fcs 0x8f<br=
>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A T + C I N D =3D ? .<br>=0A&gt; HCI Eve=
nt: Number of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; hand=
le 6 packets 1<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 26<br>=0A&gt; =
ACL data: handle 6 flags 0x01 dlen 26<br>=0A&gt; ACL data: handle 6 flags 0=
x01 dlen 26<br>=0A&gt; ACL data: handle 6 flags 0x01 dlen 21<br>=0A&nbsp;&n=
bsp;&nbsp; L2CAP(d): cid 0x0040 len 95 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 90 fcs 0x49 credits 1<br>=0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . + C I N D :&nbsp;&nbsp; ( " c a l l " , =
( 0 ,<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 ) ) , ( " s e r v i c e " , ( =
0 , 1 )<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) , ( " c a l l _ s e t u p " =
, ( 0 - 3<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) ) , ( " c a l l s e t u p =
" , ( 0 - 3<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) ) . . . . O K . .<br>=0A=
&lt; ACL data: handle 6 flags 0x02 dlen 17<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d=
): cid 0x006b len 13 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d)=
: UIH: cr 1 dlci 6 pf 0 ilen 9 fcs 0x8f<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; A T + C I N D ? .<br>=0A&gt; HCI Event: Number of Completed Packets (0x13=
) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>=0A&gt; ACL data: h=
andle 6 flags 0x02 dlen 26<br>=0A&gt; ACL data: handle 6 flags 0x01 dlen 7<=
br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 [psm 3]<br>=0A&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 24 fcs 0x49 cr=
edits 1<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . + C I N D :&nbsp;&nbsp; 0 =
, 1 , 0 , 0 . . . .<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; O K . .<br>=0A&lt;=
 ACL data: handle 6 flags 0x02 dlen 24<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): c=
id 0x006b len 20 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UI=
H: cr 1 dlci 6 pf 0 ilen 16 fcs 0x8f<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
 T + C M E R =3D 3 , 0 , 0 , 1 .<br>=0A&gt; HCI Event: Number of Completed =
Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>=0A&gt=
; ACL data: handle 6 flags 0x02 dlen 15<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): =
cid 0x0040 len 11 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): U=
IH: cr 0 dlci 6 pf 1 ilen 6 fcs 0x49 credits 1<br>=0A&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; . . O K . .<br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 24<br>=
=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len 20 [psm 3]<br>=0A&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 16 fcs 0x8f<br>=
=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A T + C M E R =3D 3 , 0 , 0 , 1 .<br>=0A&=
gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>=0A&nbsp;&nbsp;=
&nbsp; handle 6 packets 1<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 15<=
br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [psm 3]<br>=0A&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 6 fcs 0x49 cre=
dits 1<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . O K . .<br>=0A&lt; ACL data=
: handle 6 flags 0x02 dlen 18<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b=
 len 14 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 d=
lci 6 pf 0 ilen 10 fcs 0x8f<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A T + C L =
I P =3D 1 .<br>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5=
<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>=0A&gt; ACL data: handle 6 =
flags 0x02 dlen 15<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [ps=
m 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 1 =
ilen 6 fcs 0x49 credits 1<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . O K . .<=
br>=0A&lt; ACL data: handle 6 flags 0x02 dlen 18<br>=0A&nbsp;&nbsp;&nbsp; L=
2CAP(d): cid 0x006b len 14 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFC=
OMM(d): UIH: cr 1 dlci 6 pf 0 ilen 10 fcs 0x8f<br>=0A&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; A T + C H L D =3D ? .<br>=0A&gt; HCI Event: Number of Completed Pa=
ckets (0x13) plen 5<br>=0A&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>=0A&gt; =
ACL data: handle 6 flags 0x02 dlen 26<br>=0A&gt; ACL data: handle 6 flags 0=
x01 dlen 17<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 39 [psm 3]<br=
>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 34=
 fcs 0x49 credits 1<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . + C H L D :&nb=
sp;&nbsp; ( 0 , 1 , 1 x , 2 , 2<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x , 3 =
, 4 ) . . . . O K . .<br>=0A<br>=0A***********this is till i receive a ring=
 on my mobile***********<br>=0AAfter receiving a ring&nbsp; i see something=
 like this....<br>=0A<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 26<br>=
=0A&gt; ACL data: handle 6 flags 0x01 dlen 26<br>=0A&gt; ACL data: handle 6=
 flags 0x01 dlen 22<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 70 [p=
sm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 0=
 ilen 66 fcs 0x55<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . + C I E V :&nbsp=
;&nbsp; 3 , 1 . . . . + C I E<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V :&nbsp=
;&nbsp; 4 , 1 . . . . R I N G . . . . + C<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; L I P :&nbsp;&nbsp; " + 9 1 9 9 1 6 1 7 5 2 6 7 "<br>=0A&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; , 1 4 5 . .<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 2=
6<br>=0A&gt; ACL data: handle 6 flags 0x01 dlen 20<br>=0A&nbsp;&nbsp;&nbsp;=
 L2CAP(d): cid 0x0040 len 42 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
FCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 38 fcs 0x55<br>=0A&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; . . R I N G . . . . + C L I P :&nbsp;&nbsp; " + 9<br>=0A&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1 9 9 1 6 1 7 5 2 6 7 " , 1 4 5 . .<br>=0A&gt; ACL d=
ata: handle 6 flags 0x02 dlen 26<br>=0A&gt; ACL data: handle 6 flags 0x01 d=
len 20<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 42 [psm 3]<br>=0A&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 38 fcs =
0x55<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . . R I N G . . . . + C L I P :&n=
bsp;&nbsp; " + 9<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 9 9 1 6 1 7 5 2 6 7=
 " , 1 4 5 . .<br>=0A&gt; ACL data: handle 6 flags 0x02 dlen 26<br>=0A&gt; =
ACL data: handle 6 flags 0x01 dlen 24<br>=0A&nbsp;&nbsp;&nbsp; L2CAP(d): ci=
d 0x0040 len 46 [psm 3]<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH=
: cr 0 dlci 6 pf 0 ilen 42 fcs 0x55<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . =
.. + C I E V :&nbsp;&nbsp; 1 , 0 . . . . + C I E<br>=0A&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; V :&nbsp;&nbsp; 3 , 0 . . . . + C I E V :&nbsp;&nbsp; 4 , 0<br>=
=0A<br>=0A<br>=0ABut when i receive the call no voice is heard...<br>=0Aple=
ase help me..<br>=0Athanks in advance...<br>=0Athank you<br>=0APramod<br>=
=0A<br>=0A<br>=0A</div></div><br>=0A=0A=0A      <!--1--><hr size=3D1></hr> =
Download prohibited? No problem. <a href=3D"http://in.rd.yahoo.com/tagline_=
webmessenger_1/*http://in.messenger.yahoo.com/webmessengerpromo.php">CHAT</=
a> from any browser, without download.</body></html>
--0-205952945-1201059990=:76110--



--===============0026135782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0026135782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0026135782==--
