Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: 12 Dec 2006 04:05:44 -0000
Message-ID: <20061212040544.28695.qmail@webmail55.rediffmail.com>
MIME-Version: 1.0
From: "Nel" <nel14d@rediffmail.com>
To: bluez-devel@lists.sf.net
Subject: [Bluez-devel] No sound in bluetooth headset
Reply-To: Nel <nel14d@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0147113210=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 This is a multipart mime message


--===============0147113210==
Content-type: multipart/alternative;
	boundary="Next_1165896344---0-203.199.83.42-28691"

 This is a multipart mime message


--Next_1165896344---0-203.199.83.42-28691
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0AHello all,=0A    I am trying the new bluetooth-alsa plugin as mentione=
d https://help.ubuntu.com/community/BluetoothAudio.=0A=0A  All goes fine bu=
t while playing a file via "aplay" i get absolutely no sound output.The pre=
vious way of a btsco kernel module worked out of the box.=0Aany pointers ??=
?. ..=0A=0Aherez the output:=0A=0A  1. output of headsetd -n=0Aheadsetd[267=
]: Bluetooth headset daemon version 0.42=0Aheadsetd[267]: Configuration pha=
se ended: target bdaddr is 00:07:A4:5C:64:F0, timeout is 6000 ms=0Aheadsetd=
[267]: Changing state: Idle-->Paging=0Aheadsetd[267]: Changing state: Pagin=
g-->Connecting=0AHeadset connected=0Aheadsetd[267]: Changing state: Connect=
ing-->Ready=0Aheadsetd[267]: Changing state: Ready-->Opening=0Aheadsetd[267=
]: SCO channel opened handle=3D0x0031 mtu=3D64=0Aheadsetd[267]: Changing st=
ate: Opening-->Streaming=0Aheadsetd[267]: Appli closed socket=0Aheadsetd[26=
7]: Changing state: Streaming-->Closewaiting=0Aheadsetd[267]: Nobody uses S=
CO channel anymore, closing it.=0Aheadsetd[267]: Changing state: Closewaiti=
ng-->Connected=0Aheadsetd[267]: Changing state: Connected-->Ready=0Aheadset=
d[267]: Changing state: Ready-->Opening=0Aheadsetd[267]: SCO channel opened=
 handle=3D0x002d mtu=3D64=0Aheadsetd[267]: Changing state: Opening-->Stream=
ing=0Aheadsetd[267]: Appli closed socket=0Aheadsetd[267]: Changing state: S=
treaming-->Closewaiting=0Aheadsetd[267]: Nobody uses SCO channel anymore, c=
losing it.=0Aheadsetd[267]: Changing state: Closewaiting-->Connected=0A=0A=
=0A=0A=0A  2. output of hcidump-XV=0A=0AHCI sniffer - Bluetooth packet anal=
yzer ver 1.31=0Adevice: hci0 snap_len: 1028 filter: 0xffffffff=0A< HCI Comm=
and: Create Connection (0x01|0x0005) plen 13=0A    bdaddr 00:07:A4:5C:64:F0=
 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000=0A    Packet type: DM1 DM3 DM5 =
DH1 DH3 DH5=0A> HCI Event: Command Status (0x0f) plen 4=0A    Create Connec=
tion (0x01|0x0005) status 0x00 ncmd 1=0A> HCI Event: Link Key Request (0x17=
) plen 6=0A    bdaddr 00:07:A4:5C:64:F0=0A< HCI Command: Link Key Request R=
eply (0x01|0x000b) plen 22=0A    bdaddr 00:07:A4:5C:64:F0 key E714BA0E8E81C=
483415F5C4748E48386=0A> HCI Event: Command Complete (0x0e) plen 10=0A    Li=
nk Key Request Reply (0x01|0x000b) ncmd 1=0A    status 0x00 bdaddr 00:07:A4=
:5C:64:F0=0A> HCI Event: PIN Code Request (0x16) plen 6=0A    bdaddr 00:07:=
A4:5C:64:F0=0A< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23=
=0A    bdaddr 00:07:A4:5C:64:F0 len 4 pin '0000'=0A> HCI Event: Command Com=
plete (0x0e) plen 10=0A    PIN Code Request Reply (0x01|0x000d) ncmd 1=0A  =
  status 0x00 bdaddr 00:07:A4:5C:64:F0=0A> HCI Event: Link Key Notification=
 (0x18) plen 23=0A    bdaddr 00:07:A4:5C:64:F0 key AFB27ADC905E5234E28F51A6=
D5B9A4DE type 0=0A> HCI Event: Connect Complete (0x03) plen 11=0A    status=
 0x00 handle 42 bdaddr 00:07:A4:5C:64:F0 type ACL encrypt 0x01=0A< ACL data=
: handle 42 flags 0x02 dlen 12=0A    L2CAP(s): Connect req: psm 1 scid 0x00=
40=0A< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4=0A    h=
andle 42 policy 0x0f=0A    Link policy: RSWITCH HOLD SNIFF PARK=0A> HCI Eve=
nt: Number of Completed Packets (0x13) plen 5=0A    handle 42 packets 1=0A>=
 HCI Event: Command Complete (0x0e) plen 6=0A    Write Link Policy Settings=
 (0x02|0x000d) ncmd 1=0A    status 0x00 handle 42=0A> HCI Event: Page Scan =
Repetition Mode Change (0x20) plen 7=0A    bdaddr 00:07:A4:5C:64:F0 mode 1=
=0A> ACL data: handle 42 flags 0x02 dlen 16=0A    L2CAP(s): Connect rsp: dc=
id 0x0040 scid 0x0040 result 1 status 2=0A      Connection pending - Author=
ization pending=0A> ACL data: handle 42 flags 0x02 dlen 16=0A    L2CAP(s): =
Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0=0A      Connection s=
uccessful=0A< ACL data: handle 42 flags 0x02 dlen 12=0A    L2CAP(s): Config=
 req: dcid 0x0040 flags 0x00 clen 0=0A> HCI Event: Number of Completed Pack=
ets (0x13) plen 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0=
x02 dlen 14=0A    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 cle=
n 0=0A      Success=0A> ACL data: handle 42 flags 0x02 dlen 16=0A    L2CAP(=
s): Config req: dcid 0x0040 flags 0x00 clen 4=0A      MTU 48=0A< ACL data: =
handle 42 flags 0x02 dlen 14=0A    L2CAP(s): Config rsp: scid 0x0040 flags =
0x00 result 0 clen 0=0A      Success=0A< ACL data: handle 42 flags 0x02 dle=
n 24=0A    L2CAP(d): cid 0x0040 len 20 [psm 1]=0A        SDP SSA Req: tid 0=
x0 len 0xf=0A          pat uuid-16 0x1108 (Headset)=0A          max 65535=
=0A          aid(s) 0x0000 - 0xffff=0A          cont 00=0A> HCI Event: Numb=
er of Completed Packets (0x13) plen 5=0A    handle 42 packets 1=0A> HCI Eve=
nt: Number of Completed Packets (0x13) plen 5=0A    handle 42 packets 1=0A>=
 ACL data: handle 42 flags 0x02 dlen 17=0A> ACL data: handle 42 flags 0x01 =
dlen 17=0A> ACL data: handle 42 flags 0x01 dlen 17=0A> ACL data: handle 42 =
flags 0x01 dlen 1=0A    L2CAP(d): cid 0x0040 len 48 [psm 1]=0A        SDP S=
SA Rsp: tid 0x0 len 0x2b=0A          count 38=0A          cont 02 00 22=0A<=
 ACL data: handle 42 flags 0x02 dlen 26=0A    L2CAP(d): cid 0x0040 len 22 [=
psm 1]=0A        SDP SSA Req: tid 0x1 len 0x11=0A          pat uuid-16 0x11=
08 (Headset)=0A          max 65535=0A          aid(s) 0x0000 - 0xffff=0A   =
       cont 02 00 22=0A> HCI Event: Number of Completed Packets (0x13) plen=
 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 dlen 17=0A>=
 ACL data: handle 42 flags 0x01 dlen 17=0A> ACL data: handle 42 flags 0x01 =
dlen 12=0A    L2CAP(d): cid 0x0040 len 42 [psm 1]=0A        SDP SSA Rsp: ti=
d 0x1 len 0x25=0A          count 34=0A          record #0=0A              a=
id 0x0000 (SrvRecHndl)=0A                uint 0x10000=0A              aid 0=
x0001 (SrvClassIDList)=0A                < uuid-16 0x1108 (Headset) uuid-16=
 0x1203 (Audio) >=0A              aid 0x0004 (ProtocolDescList)=0A         =
       < < uuid-16 0x0100 (L2CAP) > <=0A                uuid-16 0x0003 (RFC=
OMM) uint 0x1 > >=0A              aid 0x0009 (BTProfileDescList)=0A        =
        < < uuid-16 0x1108 (Headset) uint 0x100 > >=0A              aid 0x0=
100 (SrvName)=0A                str "Headset"=0A              aid 0x0302 (u=
nknown)=0A                bool 0x1=0A          cont 00=0A< ACL data: handle=
 42 flags 0x02 dlen 12=0A    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040=
=0A< ACL data: handle 42 flags 0x02 dlen 12=0A    L2CAP(s): Connect req: ps=
m 3 scid 0x0041=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 42 packets 1=0A> HCI Event: Number of Completed Packets (0x13) p=
len 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 dlen 12=
=0A    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040=0A> ACL data: handle =
42 flags 0x02 dlen 16=0A    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 =
result 1 status 2=0A      Connection pending - Authorization pending=0A> AC=
L data: handle 42 flags 0x02 dlen 16=0A    L2CAP(s): Connect rsp: dcid 0x00=
41 scid 0x0041 result 0 status 0=0A      Connection successful=0A< ACL data=
: handle 42 flags 0x02 dlen 16=0A    L2CAP(s): Config req: dcid 0x0041 flag=
s 0x00 clen 4=0A      MTU 1013=0A> HCI Event: Number of Completed Packets (=
0x13) plen 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 d=
len 14=0A    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0=
=0A      Success=0A> ACL data: handle 42 flags 0x02 dlen 16=0A    L2CAP(s):=
 Config req: dcid 0x0041 flags 0x00 clen 4=0A      MTU 1013=0A< ACL data: h=
andle 42 flags 0x02 dlen 14=0A    L2CAP(s): Config rsp: scid 0x0041 flags 0=
x00 result 0 clen 0=0A      Success=0A< ACL data: handle 42 flags 0x02 dlen=
 8=0A    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A      RFCOMM(s): SABM: cr 1 d=
lci 0 pf 1 ilen 0 fcs 0x1c=0A> HCI Event: Number of Completed Packets (0x13=
) plen 5=0A    handle 42 packets 1=0A> HCI Event: Number of Completed Packe=
ts (0x13) plen 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x=
02 dlen 8=0A    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A      RFCOMM(s): UA: c=
r 1 dlci 0 pf 1 ilen 0 fcs 0xd7=0A< ACL data: handle 42 flags 0x02 dlen 18=
=0A    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A      RFCOMM(s): PN CMD: cr 1 =
dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8=0A      dlci 2 frame_type 0 credit_f=
low 15 pri 7 ack_timer 0=0A      frame_size 1008 max_retrans 0 credits 7=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A    handle 42 pack=
ets 1=0A> ACL data: handle 42 flags 0x02 dlen 17=0A> ACL data: handle 42 fl=
ags 0x01 dlen 1=0A    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A      RFCOMM(s)=
: PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8=0A      dlci 2 frame_=
type 0 credit_flow 14 pri 7 ack_timer 0=0A      frame_size 127 max_retrans =
0 credits 0=0A< ACL data: handle 42 flags 0x02 dlen 8=0A    L2CAP(d): cid 0=
x0041 len 4 [psm 3]=0A      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x=
59=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A    handle 42=
 packets 1=0A> ACL data: handle 42 flags 0x02 dlen 8=0A    L2CAP(d): cid 0x=
0041 len 4 [psm 3]=0A      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=
=0A< ACL data: handle 42 flags 0x02 dlen 12=0A    L2CAP(d): cid 0x0041 len =
8 [psm 3]=0A      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_=
len 2=0A      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0=0A< HC=
I Command: Add SCO Connection (0x01|0x0007) plen 4=0A    handle 42 ptype 0x=
00e0=0A    Packet type: HV1 HV2 HV3=0A> ACL data: handle 42 flags 0x02 dlen=
 12=0A    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A      RFCOMM(s): MSC CMD: cr=
 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A      dlci 2 fc 0 rtc 1 rtr 1 ic=
 0 dv 0 b1 0 b2 0 b3 0 len 0=0A< ACL data: handle 42 flags 0x02 dlen 12=0A =
   L2CAP(d): cid 0x0041 len 8 [psm 3]=0A      RFCOMM(s): MSC RSP: cr 1 dlci=
 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0=
 b1 0 b2 0 b3 0 len 0=0A> HCI Event: Number of Completed Packets (0x13) ple=
n 5=0A    handle 42 packets 1=0A> HCI Event: Command Status (0x0f) plen 4=
=0A    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1=0A> HCI Event: C=
onnect Complete (0x03) plen 11=0A    status 0x00 handle 45 bdaddr 00:07:A4:=
5C:64:F0 type SCO encrypt 0x01=0A> HCI Event: Number of Completed Packets (=
0x13) plen 5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 d=
len 12=0A    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A      RFCOMM(s): MSC RSP:=
 cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A      dlci 2 fc 0 rtc 1 rtr 1=
 ic 0 dv 1 b1 0 b2 0 b3 0 len 0=0A< ACL data: handle 42 flags 0x02 dlen 9=
=0A    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci=
 2 pf 1 ilen 0 fcs 0x86 credits 33=0A> SCO data: handle 45 dlen 48=0A    00=
00: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=0A  =
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................=
=0A    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ............=
....=0A> SCO data: handle 45 dlen 48=0A =0A  *---------------------------=
=0Asco packets now=0A=0A  *---------------------------=0A=0A =0A=0A  3. out=
put of aplay -D pcm.headset startup.wav=0ADEBUG: _snd_pcm_sco_open: Startin=
g pcm_sco plugin.=0ADEBUG: _snd_pcm_sco_open: Open mode is for Playback.=0A=
DEBUG: _snd_pcm_sco_open: opened as ioplug=3D0x24848, pcm=3D0x24988, ioplug=
->callback =3D 0x402f1a10=0APlaying WAVE '/startup.wav' : Signed 16 bit Lit=
tle Endian, Rate 44100 Hz, Stereo=0ADEBUG: sco_prepare: Preparing with io->=
period_size =3D 24, io->buffer_size =3D 4008=0ADEBUG: sco_pointer: returnin=
g bt_headset->hw_ptr=3D0=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=
=3D0=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D0=0ADEBUG: sco_wr=
ite: areas->step=3D16, areas->first=3D0, offset=3D0, size=3D24, io->nonbloc=
k=3D0=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D219822000=0A=
DEBUG: sco_write: returning 24=0ADEBUG: sco_pointer: returning bt_headset->=
hw_ptr=3D24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D24=0ADEBUG=
: sco_pointer: returning bt_headset->hw_ptr=3D24=0ADEBUG: sco_write: areas-=
>step=3D16, areas->first=3D0, offset=3D24, size=3D24, io->nonblock=3D0=0ADE=
BUG: sco_write: time: seconds=3D948068724 nseconds=3D264549000=0ADEBUG: sco=
_write: returning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D4=
8=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D48=0ADEBUG: sco_poin=
ter: returning bt_headset->hw_ptr=3D48=0ADEBUG: sco_write: areas->step=3D16=
, areas->first=3D0, offset=3D48, size=3D24, io->nonblock=3D0=0ADEBUG: sco_w=
rite: time: seconds=3D948068724 nseconds=3D301765000=0ADEBUG: sco_write: re=
turning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D72=0ADEBUG:=
 sco_pointer: returning bt_headset->hw_ptr=3D72=0ADEBUG: sco_pointer: retur=
ning bt_headset->hw_ptr=3D72=0ADEBUG: sco_write: areas->step=3D16, areas->f=
irst=3D0, offset=3D72, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time=
: seconds=3D948068724 nseconds=3D325625000=0ADEBUG: sco_write: returning 24=
=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D96=0ADEBUG: sco_point=
er: returning bt_headset->hw_ptr=3D96=0ADEBUG: sco_pointer: returning bt_he=
adset->hw_ptr=3D96=0ADEBUG: sco_write: areas->step=3D16, areas->first=3D0, =
offset=3D96, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time: seconds=
=3D948068724 nseconds=3D356110000=0ADEBUG: sco_write: returning 24=0ADEBUG:=
 sco_pointer: returning bt_headset->hw_ptr=3D120=0ADEBUG: sco_pointer: retu=
rning bt_headset->hw_ptr=3D120=0ADEBUG: sco_pointer: returning bt_headset->=
hw_ptr=3D120=0ADEBUG: sco_write: areas->step=3D16, areas->first=3D0, offset=
=3D120, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time: seconds=3D948=
068724 nseconds=3D385821000=0ADEBUG: sco_write: returning 24=0ADEBUG: sco_p=
ointer: returning bt_headset->hw_ptr=3D144=0ADEBUG: sco_pointer: returning =
bt_headset->hw_ptr=3D144=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=
=3D144=0ADEBUG: sco_write: areas->step=3D16, areas->first=3D0, offset=3D144=
, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time: seconds=3D948068724=
 nseconds=3D423014000=0ADEBUG: sco_write: returning 24=0ADEBUG: sco_pointer=
: returning bt_headset->hw_ptr=3D168=0ADEBUG: sco_pointer: returning bt_hea=
dset->hw_ptr=3D168=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D168=
=0ADEBUG: sco_write: areas->step=3D16, areas->first=3D0, offset=3D168, size=
=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time: seconds=3D948068724 nseco=
nds=3D448017000=0ADEBUG: sco_write: returning 24=0ADEBUG: sco_pointer: retu=
rning bt_headset->hw_ptr=3D192=0ADEBUG: sco_pointer: returning bt_headset->=
hw_ptr=3D192=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D192=0ADEB=
UG: sco_write: areas->step=3D16, areas->first=3D0, offset=3D192, size=3D24,=
 io->nonblock=3D0=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D=
475980000=0ADEBUG: sco_write: returning 24=0ADEBUG: sco_pointer: returning =
bt_headset->hw_ptr=3D216=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=
=3D216=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D216=0ADEBUG: sc=
o_write: areas->step=3D16, areas->first=3D0, offset=3D216, size=3D24, io->n=
onblock=3D0=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D515286=
000=0ADEBUG: sco_write: returning 24=0ADEBUG: sco_pointer: returning bt_hea=
dset->hw_ptr=3D240=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D240=
=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D240=0ADEBUG: sco_writ=
e: areas->step=3D16, areas->first=3D0, offset=3D240, size=3D24, io->nonbloc=
k=3D0=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D571482000=0A=
DEBUG: sco_write: returning 24=0ADEBUG: sco_pointer: returning bt_headset->=
hw_ptr=3D264=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D264=0ADEB=
UG: sco_pointer: returning bt_headset->hw_ptr=3D264=0ADEBUG: sco_write: are=
as->step=3D16, areas->first=3D0, offset=3D264, size=3D24, io->nonblock=3D0=
=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D604298000=0ADEBUG=
: sco_write: returning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_pt=
r=3D288=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D288=0ADEBUG: s=
co_pointer: returning bt_headset->hw_ptr=3D288=0ADEBUG: sco_write: areas->s=
tep=3D16, areas->first=3D0, offset=3D288, size=3D24, io->nonblock=3D0=0ADEB=
UG: sco_write: time: seconds=3D948068724 nseconds=3D630276000=0ADEBUG: sco_=
write: returning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D31=
2=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D312=0ADEBUG: sco_poi=
nter: returning bt_headset->hw_ptr=3D312=0ADEBUG: sco_write: areas->step=3D=
16, areas->first=3D0, offset=3D312, size=3D24, io->nonblock=3D0=0ADEBUG: sc=
o_write: time: seconds=3D948068724 nseconds=3D657855000=0ADEBUG: sco_write:=
 returning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D336=0ADE=
BUG: sco_pointer: returning bt_headset->hw_ptr=3D336=0ADEBUG: sco_pointer: =
returning bt_headset->hw_ptr=3D336=0ADEBUG: sco_write: areas->step=3D16, ar=
eas->first=3D0, offset=3D336, size=3D24, io->nonblock=3D0=0ADEBUG: sco_writ=
e: time: seconds=3D948068724 nseconds=3D686221000=0ADEBUG: sco_write: retur=
ning 24=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D360=0ADEBUG: s=
co_pointer: returning bt_headset->hw_ptr=3D360=0ADEBUG: sco_pointer: return=
ing bt_headset->hw_ptr=3D360=0ADEBUG: sco_write: areas->step=3D16, areas->f=
irst=3D0, offset=3D360, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: tim=
e: seconds=3D948068724 nseconds=3D734687000=0ADEBUG: sco_write: returning 2=
4=0ADEBUG: sco_pointer: returning bt_headset->hw_ptr=3D384=0ADEBUG: sco_poi=
nter: returning bt_headset->hw_ptr=3D384=0ADEBUG: sco_pointer: returning bt=
_headset->hw_ptr=3D384=0ADEBUG: sco_write: areas->step=3D16, areas->first=
=3D0, offset=3D384, size=3D24, io->nonblock=3D0=0ADEBUG: sco_write: time: s=
econds=3D948068724 nseconds=3D765250000=0ADEBUG: sco_write: returning 24=0A=
DEBUG: sco_pointer: returning bt_headset->hw_ptr=3D408=0ADEBUG: sco_pointer=
: returning bt_headset->hw_ptr=3D408=0AAborted by signal Interrupt...=0ADEB=
UG: sco_stop:=0ADEBUG: sco_close: closing ioplug=3D0x24848=0ADEBUG: sco_clo=
se: Closing Playback stream=0A=0A*--------------------------=0Aa series of =
such messages indicating data transfer=0A=0A=0A*--------------------------=
=0A=0A=0AWhat am i missing ???=0A=0Athanks in advance ,=0A=0A  Cheers,=0A  =
  Nel
--Next_1165896344---0-203.199.83.42-28691
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0AHello all,<BR>=0A&nbsp; &nbsp; I am trying the new blue=
tooth-alsa plugin as mentioned https://help.ubuntu.com/community/BluetoothA=
udio.<BR>=0A<BR>=0A&nbsp; All goes fine but while playing a file via &quot;=
aplay&quot; i get absolutely no sound output.The previous way of a btsco ke=
rnel module worked out of the box.<BR>=0Aany pointers ???. ..<BR>=0A<BR>=0A=
herez the output:<BR>=0A<BR>=0A&nbsp; 1. output of headsetd -n<BR>=0Aheadse=
td[267]: Bluetooth headset daemon version 0.42<BR>=0Aheadsetd[267]: Configu=
ration phase ended: target bdaddr is 00:07:A4:5C:64:F0, timeout is 6000 ms<=
BR>=0Aheadsetd[267]: Changing state: Idle--&gt;Paging<BR>=0Aheadsetd[267]: =
Changing state: Paging--&gt;Connecting<BR>=0AHeadset connected<BR>=0Aheadse=
td[267]: Changing state: Connecting--&gt;Ready<BR>=0Aheadsetd[267]: Changin=
g state: Ready--&gt;Opening<BR>=0Aheadsetd[267]: SCO channel opened handle=
=3D0x0031 mtu=3D64<BR>=0Aheadsetd[267]: Changing state: Opening--&gt;Stream=
ing<BR>=0Aheadsetd[267]: Appli closed socket<BR>=0Aheadsetd[267]: Changing =
state: Streaming--&gt;Closewaiting<BR>=0Aheadsetd[267]: Nobody uses SCO cha=
nnel anymore, closing it.<BR>=0Aheadsetd[267]: Changing state: Closewaiting=
--&gt;Connected<BR>=0Aheadsetd[267]: Changing state: Connected--&gt;Ready<B=
R>=0Aheadsetd[267]: Changing state: Ready--&gt;Opening<BR>=0Aheadsetd[267]:=
 SCO channel opened handle=3D0x002d mtu=3D64<BR>=0Aheadsetd[267]: Changing =
state: Opening--&gt;Streaming<BR>=0Aheadsetd[267]: Appli closed socket<BR>=
=0Aheadsetd[267]: Changing state: Streaming--&gt;Closewaiting<BR>=0Aheadset=
d[267]: Nobody uses SCO channel anymore, closing it.<BR>=0Aheadsetd[267]: C=
hanging state: Closewaiting--&gt;Connected<BR>=0A<BR>=0A<BR>=0A<BR>=0A<BR>=
=0A&nbsp; 2. output of hcidump-XV<BR>=0A<BR>=0AHCI sniffer - Bluetooth pack=
et analyzer ver 1.31<BR>=0Adevice: hci0 snap_len: 1028 filter: 0xffffffff<B=
R>=0A&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<BR>=0A&nbsp;=
 &nbsp; bdaddr 00:07:A4:5C:64:F0 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000=
<BR>=0A&nbsp; &nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<BR>=0A&gt; HCI Ev=
ent: Command Status (0x0f) plen 4<BR>=0A&nbsp; &nbsp; Create Connection (0x=
01|0x0005) status 0x00 ncmd 1<BR>=0A&gt; HCI Event: Link Key Request (0x17)=
 plen 6<BR>=0A&nbsp; &nbsp; bdaddr 00:07:A4:5C:64:F0<BR>=0A&lt; HCI Command=
: Link Key Request Reply (0x01|0x000b) plen 22<BR>=0A&nbsp; &nbsp; bdaddr 0=
0:07:A4:5C:64:F0 key E714BA0E8E81C483415F5C4748E48386<BR>=0A&gt; HCI Event:=
 Command Complete (0x0e) plen 10<BR>=0A&nbsp; &nbsp; Link Key Request Reply=
 (0x01|0x000b) ncmd 1<BR>=0A&nbsp; &nbsp; status 0x00 bdaddr 00:07:A4:5C:64=
:F0<BR>=0A&gt; HCI Event: PIN Code Request (0x16) plen 6<BR>=0A&nbsp; &nbsp=
; bdaddr 00:07:A4:5C:64:F0<BR>=0A&lt; HCI Command: PIN Code Request Reply (=
0x01|0x000d) plen 23<BR>=0A&nbsp; &nbsp; bdaddr 00:07:A4:5C:64:F0 len 4 pin=
 '0000'<BR>=0A&gt; HCI Event: Command Complete (0x0e) plen 10<BR>=0A&nbsp; =
&nbsp; PIN Code Request Reply (0x01|0x000d) ncmd 1<BR>=0A&nbsp; &nbsp; stat=
us 0x00 bdaddr 00:07:A4:5C:64:F0<BR>=0A&gt; HCI Event: Link Key Notificatio=
n (0x18) plen 23<BR>=0A&nbsp; &nbsp; bdaddr 00:07:A4:5C:64:F0 key AFB27ADC9=
05E5234E28F51A6D5B9A4DE type 0<BR>=0A&gt; HCI Event: Connect Complete (0x03=
) plen 11<BR>=0A&nbsp; &nbsp; status 0x00 handle 42 bdaddr 00:07:A4:5C:64:F=
0 type ACL encrypt 0x01<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 12<B=
R>=0A&nbsp; &nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<BR>=0A&lt; HCI =
Command: Write Link Policy Settings (0x02|0x000d) plen 4<BR>=0A&nbsp; &nbsp=
; handle 42 policy 0x0f<BR>=0A&nbsp; &nbsp; Link policy: RSWITCH HOLD SNIFF=
 PARK<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>=
=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; HCI Event: Command Complete=
 (0x0e) plen 6<BR>=0A&nbsp; &nbsp; Write Link Policy Settings (0x02|0x000d)=
 ncmd 1<BR>=0A&nbsp; &nbsp; status 0x00 handle 42<BR>=0A&gt; HCI Event: Pag=
e Scan Repetition Mode Change (0x20) plen 7<BR>=0A&nbsp; &nbsp; bdaddr 00:0=
7:A4:5C:64:F0 mode 1<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 16<BR>=
=0A&nbsp; &nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 st=
atus 2<BR>=0A&nbsp; &nbsp; &nbsp; Connection pending - Authorization pendin=
g<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 16<BR>=0A&nbsp; &nbsp; L2C=
AP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<BR>=0A&nbsp; =
&nbsp; &nbsp; Connection successful<BR>=0A&lt; ACL data: handle 42 flags 0x=
02 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00=
 clen 0<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>=
=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; ACL data: handle 42 flags 0=
x02 dlen 14<BR>=0A&nbsp; &nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0=
0 result 0 clen 0<BR>=0A&nbsp; &nbsp; &nbsp; Success<BR>=0A&gt; ACL data: h=
andle 42 flags 0x02 dlen 16<BR>=0A&nbsp; &nbsp; L2CAP(s): Config req: dcid =
0x0040 flags 0x00 clen 4<BR>=0A&nbsp; &nbsp; &nbsp; MTU 48<BR>=0A&lt; ACL d=
ata: handle 42 flags 0x02 dlen 14<BR>=0A&nbsp; &nbsp; L2CAP(s): Config rsp:=
 scid 0x0040 flags 0x00 result 0 clen 0<BR>=0A&nbsp; &nbsp; &nbsp; Success<=
BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 24<BR>=0A&nbsp; &nbsp; L2CAP=
(d): cid 0x0040 len 20 [psm 1]<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; SDP SSA Re=
q: tid 0x0 len 0xf<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pat uuid-16 0x1=
108 (Headset)<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max 65535<BR>=0A&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; aid(s) 0x0000 - 0xffff<BR>=0A&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; cont 00<BR>=0A&gt; HCI Event: Number of Completed Packe=
ts (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; HCI Eve=
nt: Number of Completed Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42=
 packets 1<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 17<BR>=0A&gt; ACL=
 data: handle 42 flags 0x01 dlen 17<BR>=0A&gt; ACL data: handle 42 flags 0x=
01 dlen 17<BR>=0A&gt; ACL data: handle 42 flags 0x01 dlen 1<BR>=0A&nbsp; &n=
bsp; L2CAP(d): cid 0x0040 len 48 [psm 1]<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; =
SDP SSA Rsp: tid 0x0 len 0x2b<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; coun=
t 38<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cont 02 00 22<BR>=0A&lt; ACL =
data: handle 42 flags 0x02 dlen 26<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0040=
 len 22 [psm 1]<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; SDP SSA Req: tid 0x1 len =
0x11<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pat uuid-16 0x1108 (Headset)<=
BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; max 65535<BR>=0A&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; aid(s) 0x0000 - 0xffff<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; cont 02 00 22<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13=
) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; ACL data: handl=
e 42 flags 0x02 dlen 17<BR>=0A&gt; ACL data: handle 42 flags 0x01 dlen 17<B=
R>=0A&gt; ACL data: handle 42 flags 0x01 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(=
d): cid 0x0040 len 42 [psm 1]<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; SDP SSA Rsp=
: tid 0x1 len 0x25<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; count 34<BR>=0A=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; record #0<BR>=0A&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; aid 0x0000 (SrvRecHndl)<BR>=0A&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint 0x10000<BR>=0A&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; aid 0x0001 (SrvClassIDList)<BR>=0A&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt; uuid-16 0x1108 (Headset) u=
uid-16 0x1203 (Audio) &gt;<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; aid 0x0004 (ProtocolDescList)<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<BR>=0A&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uuid-16 0x0003 (RFCOM=
M) uint 0x1 &gt; &gt;<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; aid 0x0009 (BTProfileDescList)<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &lt; &lt; uuid-16 0x1108 (Headset) uint 0x100 &gt; &gt;=
<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; aid 0x0100 (SrvName=
)<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; str &quot;H=
eadset&quot;<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; aid 0x0=
302 (unknown)<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 bool 0x1<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cont 00<BR>=0A&lt; ACL d=
ata: handle 42 flags 0x02 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(s): Disconn req=
: dcid 0x0040 scid 0x0040<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 12=
<BR>=0A&nbsp; &nbsp; L2CAP(s): Connect req: psm 3 scid 0x0041<BR>=0A&gt; HC=
I Event: Number of Completed Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; hand=
le 42 packets 1<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) pl=
en 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; ACL data: handle 42=
 flags 0x02 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 =
scid 0x0040<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 16<BR>=0A&nbsp; =
&nbsp; L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2<BR>=
=0A&nbsp; &nbsp; &nbsp; Connection pending - Authorization pending<BR>=0A&g=
t; ACL data: handle 42 flags 0x02 dlen 16<BR>=0A&nbsp; &nbsp; L2CAP(s): Con=
nect rsp: dcid 0x0041 scid 0x0041 result 0 status 0<BR>=0A&nbsp; &nbsp; &nb=
sp; Connection successful<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 16=
<BR>=0A&nbsp; &nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<BR=
>=0A&nbsp; &nbsp; &nbsp; MTU 1013<BR>=0A&gt; HCI Event: Number of Completed=
 Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; A=
CL data: handle 42 flags 0x02 dlen 14<BR>=0A&nbsp; &nbsp; L2CAP(s): Config =
rsp: scid 0x0041 flags 0x00 result 0 clen 0<BR>=0A&nbsp; &nbsp; &nbsp; Succ=
ess<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 16<BR>=0A&nbsp; &nbsp; L=
2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<BR>=0A&nbsp; &nbsp; &nbs=
p; MTU 1013<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 14<BR>=0A&nbsp; =
&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0<BR>=0A&=
nbsp; &nbsp; &nbsp; Success<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen =
8<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>=0A&nbsp; &nbsp=
; &nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<BR>=0A&gt; HCI E=
vent: Number of Completed Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle =
42 packets 1<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; ACL data: handle 42 fl=
ags 0x02 dlen 8<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>=
=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<BR>=
=0A&lt; ACL data: handle 42 flags 0x02 dlen 18<BR>=0A&nbsp; &nbsp; L2CAP(d)=
: cid 0x0041 len 14 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): PN CMD: c=
r 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<BR>=0A&nbsp; &nbsp; &nbsp; dlci =
2 frame_type 0 credit_flow 15 pri 7 ack_timer 0<BR>=0A&nbsp; &nbsp; &nbsp; =
frame_size 1008 max_retrans 0 credits 7<BR>=0A&gt; HCI Event: Number of Com=
pleted Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A=
&gt; ACL data: handle 42 flags 0x02 dlen 17<BR>=0A&gt; ACL data: handle 42 =
flags 0x01 dlen 1<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 len 14 [psm 3]<B=
R>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0=
xaa mcc_len 8<BR>=0A&nbsp; &nbsp; &nbsp; dlci 2 frame_type 0 credit_flow 14=
 pri 7 ack_timer 0<BR>=0A&nbsp; &nbsp; &nbsp; frame_size 127 max_retrans 0 =
credits 0<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 8<BR>=0A&nbsp; &nb=
sp; L2CAP(d): cid 0x0041 len 4 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s)=
: SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59<BR>=0A&gt; HCI Event: Number of Co=
mpleted Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=
=0A&gt; ACL data: handle 42 flags 0x02 dlen 8<BR>=0A&nbsp; &nbsp; L2CAP(d):=
 cid 0x0041 len 4 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): UA: cr 1 dl=
ci 2 pf 1 ilen 0 fcs 0x92<BR>=0A&lt; ACL data: handle 42 flags 0x02 dlen 12=
<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 len 8 [psm 3]<BR>=0A&nbsp; &nbsp;=
 &nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<BR>=
=0A&nbsp; &nbsp; &nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 le=
n 0<BR>=0A&lt; HCI Command: Add SCO Connection (0x01|0x0007) plen 4<BR>=0A&=
nbsp; &nbsp; handle 42 ptype 0x00e0<BR>=0A&nbsp; &nbsp; Packet type: HV1 HV=
2 HV3<BR>=0A&gt; ACL data: handle 42 flags 0x02 dlen 12<BR>=0A&nbsp; &nbsp;=
 L2CAP(d): cid 0x0041 len 8 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): M=
SC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<BR>=0A&nbsp; &nbsp; &nbs=
p; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0<BR>=0A&lt; ACL da=
ta: handle 42 flags 0x02 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 l=
en 8 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): MSC RSP: cr 1 dlci 0 pf =
0 ilen 4 fcs 0x70 mcc_len 2<BR>=0A&nbsp; &nbsp; &nbsp; dlci 2 fc 0 rtc 1 rt=
r 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0<BR>=0A&gt; HCI Event: Number of Complete=
d Packets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; =
HCI Event: Command Status (0x0f) plen 4<BR>=0A&nbsp; &nbsp; Add SCO Connect=
ion (0x01|0x0007) status 0x00 ncmd 1<BR>=0A&gt; HCI Event: Connect Complete=
 (0x03) plen 11<BR>=0A&nbsp; &nbsp; status 0x00 handle 45 bdaddr 00:07:A4:5=
C:64:F0 type SCO encrypt 0x01<BR>=0A&gt; HCI Event: Number of Completed Pac=
kets (0x13) plen 5<BR>=0A&nbsp; &nbsp; handle 42 packets 1<BR>=0A&gt; ACL d=
ata: handle 42 flags 0x02 dlen 12<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 =
len 8 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf=
 0 ilen 4 fcs 0xaa mcc_len 2<BR>=0A&nbsp; &nbsp; &nbsp; dlci 2 fc 0 rtc 1 r=
tr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<BR>=0A&lt; ACL data: handle 42 flags 0x=
02 dlen 9<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0041 len 5 [psm 3]<BR>=0A&nbs=
p; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 3=
3<BR>=0A&gt; SCO data: handle 45 dlen 48<BR>=0A&nbsp; &nbsp; 0000: 00 00 00=
 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<BR>=0A=
&nbsp; &nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&n=
bsp; ................<BR>=0A&nbsp; &nbsp; 0020: 00 00 00 00 00 00 00 00&nbs=
p; 00 00 00 00 00 00 00 00&nbsp; ................<BR>=0A&gt; SCO data: hand=
le 45 dlen 48<BR>=0A <BR>=0A&nbsp; *---------------------------<BR>=0Asco p=
ackets now<BR>=0A<BR>=0A&nbsp; *---------------------------<BR>=0A<BR>=0A <=
BR>=0A<BR>=0A&nbsp; 3. output of aplay -D pcm.headset startup.wav<BR>=0ADEB=
UG: _snd_pcm_sco_open: Starting pcm_sco plugin.<BR>=0ADEBUG: _snd_pcm_sco_o=
pen: Open mode is for Playback.<BR>=0ADEBUG: _snd_pcm_sco_open: opened as i=
oplug=3D0x24848, pcm=3D0x24988, ioplug-&gt;callback =3D 0x402f1a10<BR>=0APl=
aying WAVE '/startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ste=
reo<BR>=0ADEBUG: sco_prepare: Preparing with io-&gt;period_size =3D 24, io-=
&gt;buffer_size =3D 4008<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt=
;hw_ptr=3D0<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D0<B=
R>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D0<BR>=0ADEBUG: s=
co_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D0, size=3D24, =
io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D948068724 nseco=
nds=3D219822000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEBUG: sco_point=
er: returning bt_headset-&gt;hw_ptr=3D24<BR>=0ADEBUG: sco_pointer: returnin=
g bt_headset-&gt;hw_ptr=3D24<BR>=0ADEBUG: sco_pointer: returning bt_headset=
-&gt;hw_ptr=3D24<BR>=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;fir=
st=3D0, offset=3D24, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write:=
 time: seconds=3D948068724 nseconds=3D264549000<BR>=0ADEBUG: sco_write: ret=
urning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D48<BR=
>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D48<BR>=0ADEBUG: s=
co_pointer: returning bt_headset-&gt;hw_ptr=3D48<BR>=0ADEBUG: sco_write: ar=
eas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D48, size=3D24, io-&gt;nonb=
lock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D30176=
5000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returni=
ng bt_headset-&gt;hw_ptr=3D72<BR>=0ADEBUG: sco_pointer: returning bt_headse=
t-&gt;hw_ptr=3D72<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D72<BR>=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, off=
set=3D72, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seco=
nds=3D948068724 nseconds=3D325625000<BR>=0ADEBUG: sco_write: returning 24<B=
R>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D96<BR>=0ADEBUG: =
sco_pointer: returning bt_headset-&gt;hw_ptr=3D96<BR>=0ADEBUG: sco_pointer:=
 returning bt_headset-&gt;hw_ptr=3D96<BR>=0ADEBUG: sco_write: areas-&gt;ste=
p=3D16, areas-&gt;first=3D0, offset=3D96, size=3D24, io-&gt;nonblock=3D0<BR=
>=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D356110000<BR>=0A=
DEBUG: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_heads=
et-&gt;hw_ptr=3D120<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_p=
tr=3D120<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D120<BR=
>=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D12=
0, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D9=
48068724 nseconds=3D385821000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADE=
BUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D144<BR>=0ADEBUG: sco_po=
inter: returning bt_headset-&gt;hw_ptr=3D144<BR>=0ADEBUG: sco_pointer: retu=
rning bt_headset-&gt;hw_ptr=3D144<BR>=0ADEBUG: sco_write: areas-&gt;step=3D=
16, areas-&gt;first=3D0, offset=3D144, size=3D24, io-&gt;nonblock=3D0<BR>=
=0ADEBUG: sco_write: time: seconds=3D948068724 nseconds=3D423014000<BR>=0AD=
EBUG: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headse=
t-&gt;hw_ptr=3D168<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_pt=
r=3D168<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D168<BR>=
=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D168=
, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D94=
8068724 nseconds=3D448017000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEB=
UG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D192<BR>=0ADEBUG: sco_poi=
nter: returning bt_headset-&gt;hw_ptr=3D192<BR>=0ADEBUG: sco_pointer: retur=
ning bt_headset-&gt;hw_ptr=3D192<BR>=0ADEBUG: sco_write: areas-&gt;step=3D1=
6, areas-&gt;first=3D0, offset=3D192, size=3D24, io-&gt;nonblock=3D0<BR>=0A=
DEBUG: sco_write: time: seconds=3D948068724 nseconds=3D475980000<BR>=0ADEBU=
G: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&=
gt;hw_ptr=3D216<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D216<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D216<BR>=
=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D216=
, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D94=
8068724 nseconds=3D515286000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEB=
UG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D240<BR>=0ADEBUG: sco_poi=
nter: returning bt_headset-&gt;hw_ptr=3D240<BR>=0ADEBUG: sco_pointer: retur=
ning bt_headset-&gt;hw_ptr=3D240<BR>=0ADEBUG: sco_write: areas-&gt;step=3D1=
6, areas-&gt;first=3D0, offset=3D240, size=3D24, io-&gt;nonblock=3D0<BR>=0A=
DEBUG: sco_write: time: seconds=3D948068724 nseconds=3D571482000<BR>=0ADEBU=
G: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&=
gt;hw_ptr=3D264<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D264<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D264<BR>=
=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D264=
, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D94=
8068724 nseconds=3D604298000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEB=
UG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D288<BR>=0ADEBUG: sco_poi=
nter: returning bt_headset-&gt;hw_ptr=3D288<BR>=0ADEBUG: sco_pointer: retur=
ning bt_headset-&gt;hw_ptr=3D288<BR>=0ADEBUG: sco_write: areas-&gt;step=3D1=
6, areas-&gt;first=3D0, offset=3D288, size=3D24, io-&gt;nonblock=3D0<BR>=0A=
DEBUG: sco_write: time: seconds=3D948068724 nseconds=3D630276000<BR>=0ADEBU=
G: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&=
gt;hw_ptr=3D312<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D312<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D312<BR>=
=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D312=
, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D94=
8068724 nseconds=3D657855000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEB=
UG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D336<BR>=0ADEBUG: sco_poi=
nter: returning bt_headset-&gt;hw_ptr=3D336<BR>=0ADEBUG: sco_pointer: retur=
ning bt_headset-&gt;hw_ptr=3D336<BR>=0ADEBUG: sco_write: areas-&gt;step=3D1=
6, areas-&gt;first=3D0, offset=3D336, size=3D24, io-&gt;nonblock=3D0<BR>=0A=
DEBUG: sco_write: time: seconds=3D948068724 nseconds=3D686221000<BR>=0ADEBU=
G: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&=
gt;hw_ptr=3D360<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D360<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D360<BR>=
=0ADEBUG: sco_write: areas-&gt;step=3D16, areas-&gt;first=3D0, offset=3D360=
, size=3D24, io-&gt;nonblock=3D0<BR>=0ADEBUG: sco_write: time: seconds=3D94=
8068724 nseconds=3D734687000<BR>=0ADEBUG: sco_write: returning 24<BR>=0ADEB=
UG: sco_pointer: returning bt_headset-&gt;hw_ptr=3D384<BR>=0ADEBUG: sco_poi=
nter: returning bt_headset-&gt;hw_ptr=3D384<BR>=0ADEBUG: sco_pointer: retur=
ning bt_headset-&gt;hw_ptr=3D384<BR>=0ADEBUG: sco_write: areas-&gt;step=3D1=
6, areas-&gt;first=3D0, offset=3D384, size=3D24, io-&gt;nonblock=3D0<BR>=0A=
DEBUG: sco_write: time: seconds=3D948068724 nseconds=3D765250000<BR>=0ADEBU=
G: sco_write: returning 24<BR>=0ADEBUG: sco_pointer: returning bt_headset-&=
gt;hw_ptr=3D408<BR>=0ADEBUG: sco_pointer: returning bt_headset-&gt;hw_ptr=
=3D408<BR>=0AAborted by signal Interrupt...<BR>=0ADEBUG: sco_stop:<BR>=0ADE=
BUG: sco_close: closing ioplug=3D0x24848<BR>=0ADEBUG: sco_close: Closing Pl=
ayback stream<BR>=0A<BR>=0A*--------------------------<BR>=0Aa series of su=
ch messages indicating data transfer<BR>=0A<BR>=0A<BR>=0A*-----------------=
---------<BR>=0A<BR>=0A<BR>=0AWhat am i missing ???<BR>=0A<BR>=0Athanks in =
advance ,<BR>=0A<BR>=0A&nbsp; Cheers,<BR>=0A&nbsp; &nbsp; Nel=0A</P>=0A<br>=
<br>=0A<a href=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/ww=
w.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D=
"http://adworks.rediff.com/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/si=
gnature-home.htm/1963059423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D=
0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1165896344---0-203.199.83.42-28691--



--===============0147113210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0147113210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0147113210==--
