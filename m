Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Cristiano De Michele <cristiano.demichele@phys.uniroma1.it>
To: bluez-devel@lists.sourceforge.net
Cc: cristiano.demichele@phys.uniroma1.it, demichel@na.infn.it
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2zOql4COp0+8eFwcevnl"
Message-Id: <1114427866.8333.4.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] motorola HS820 headset doesn't work
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
Date: Mon, 25 Apr 2005 13:17:46 +0200


--=-2zOql4COp0+8eFwcevnl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
if I do

> modprobe snd_bt_sco
> esdctl stop
> hciconfig hci0 voice 0x0060
> btsco <address_of_my_headset>
> aplay -B 1000000 -D plughw:Headset <some wav file>

I can't hear anything else than a bip in my headset,
that is properly paired (I checked with 'hcitool con')
'dmesg' gives me what follows:=20

Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: no IPv6 routers present
snd-bt-sco revision 1.6 $
snd-bt-sco: snd-bt-scod thread starting
usb 1-1: new full speed USB device using ohci_hcd and
address 3
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
usb 1-1: USB disconnect, address 3
usb 1-1: new full speed USB device using ohci_hcd and
address 4
snd-bt-sco: playback_open
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
snd-bt-sco: prepare ok bps: 16000 size: 16000 count: 4000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: Disposing of previous socket count 3
snd-bt-sco: file_count is 1 (expected 3)
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 256
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 256
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 256
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 16000 count: 4000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 16000 count: 4000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 16000 count: 4000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL

moreover these are possibly useful infos:

> hciconfig -a
hci0: Type: USB
BD Address: 00:11:F6:01:5A:78 ACL MTU: 120:20 SCO MTU:
64:0
UP RUNNING PSCAN ISCAN=20
RX bytes:583 acl:12 sco:0 events:45 errors:0
TX bytes:610 acl:12 sco:0 commands:21 errors:0
Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
Link policy: RSWITCH HOLD SNIFF PARK=20
Link mode: SLAVE ACCEPT=20
Name: 'piro-0'
Class: 0x7e0100
Service Classes: Networking, Rendering, Capturing
Device Class: Computer, Uncategorized
HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP
Subver: 0x757
Manufacturer: Silicon Wave (11)

> hciconfig hci0 revision
hci0: Type: USB
BD Address: 00:11:F6:01:5A:78 ACL MTU: 120:20 SCO MTU:
64:0
Unsupported manufacturer

> hcitool info 00:07:A4:2D:9E:48
Requesting information ...
BD Address: 00:07:A4:2D:9E:48
Device Name: Motorola HS820
LMP Version: 1.2 (0x2) LMP Subversion: 0x525
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xff 0xff 0x0b 0x00 0x08 0x08 0x00 0x00
<3-slot packets> <5-slot packets> <encryption> <slot
offset>=20
<timing accuracy> <role switch> <hold mode> <sniff mode>=20
<park state> <RSSI> <channel quality> <SCO link> <HV2
packets>=20
<HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>=20
<transparent SCO> <AFH cap. slave> <AFH cap. master>

> btsco -v
btsco v0.4a
Device is 1:0

btsco bluetooth audio handler

> uname -a
Linux piro 2.6.12-rc1 #1 Mon Apr 25 11:15:24 CEST 2005
i686 GNU/Linux

and this is the output of hcidump -X:

HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 01 00 02 00 08                                 ......
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0072 len 14 [psm 0]
      0000: 0b ef 15 41 54 2b 56 47  53 3d 31 35 0d 9a        ...AT
+VGS=3D15..
< ACL data: handle 1 flags 0x02 dlen 17
    L2CAP(d): cid 0x0072 len 13 [psm 0]
      0000: 0b ef 13 41 54 2b 56 47  4d 3d 31 0d 9a           ...AT
+VGM=3D1..
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 01 00 e0 00                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 00 01 48 9e 2d a4 07  00 00 01                 ...H.-.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 01 00 03                                          ...
> SCO data: handle 256 dlen 48
    0000: ff ff fe ff 06 00 1b 00  29 00 31 00 43 00 4a
00  ........).1.C.J.
    0010: 4b 00 52 00 57 00 54 00  56 00 4f 00 4f 00 58 00
K.R.W.T.V.O.O.X.
    0020: 51 00 53 00 51 00 54 00  63 00 5d 00 5a 00 56 00
Q.S.Q.T.c.].Z.V.
> SCO data: handle 256 dlen 48
    0000: 51 00 5b 00 59 00 5a 00  5b 00 52 00 00 00 59 00
Q.[.Y.Z.[.R...Y.
    0010: 5b 00 4f 00 4c 00 57 00  5d 00 54 00 5c 00 58 00
[.O.L.W.].T.\.X.
    0020: 53 00 60 00 5a 00 5d 00  5a 00 50 00 5b 00 63 00
S.`.Z.].Z.P.[.c.
> SCO data: handle 256 dlen 48
    0000: 5d 00 52 00 56 00 5e 00  62 00 55 00 4a 00 4f
00  ].R.V.^.b.U.J.O.
    0010: 51 00 5a 00 58 00 56 00  53 00 00 00 00 00 00 00
Q.Z.X.V.S.......
    0020: 4e 00 60 00 54 00 52 00  5d 00 51 00 59 00 5b 00
N.`.T.R.].Q.Y.[.
> SCO data: handle 256 dlen 48
    0000: 56 00 5d 00 61 00 64 00  5c 00 4d 00 4d 00 5c 00
V.].a.d.\.M.M.\.
    0010: 5b 00 55 00 4f 00 50 00  66 00 57 00 53 00 5a 00
[.U.O.P.f.W.S.Z.
    0020: 4a 00 55 00 55 00 4d 00  52 00 49 00 49 00 4c 00
J.U.U.M.R.I.I.L.
> SCO data: handle 256 dlen 48
    0000: 45 00 40 00 45 00 45 00  3e 00 3e 00 38 00 33 00
E.@.E.E.>.>.8.3.
    0010: 3b 00 3c 00 34 00 2f 00  2d 00 33 00 38 00 31
00  ;.<.4./.-.3.8.1.
    0020: 30 00 38 00 3d 00 3b 00  38 00 38 00 34 00 37 00
0.8.=3D.;.8.8.4.7.
> SCO data: handle 256 dlen 48
    0000: 39 00 39 00 3a 00 39 00  37 00 37 00 3d 00 30 00
9.9.:.9.7.7.=3D.0.
    0010: 32 00 3d 00 2f 00 37 00  3f 00 3f 00 44 00 3d 00
2.=3D./.7.?.?.D.=3D.
    0020: 40 00 40 00 40 00 44 00  43 00 43 00 3f 00 44 00
@.@.@.D.C.C.?.D.
> SCO data: handle 256 dlen 48
    0000: 49 00 4c 00 4b 00 3e 00  3f 00 44 00 4e 00 4e 00
I.L.K.>.?.D.N.N.
    0010: 46 00 4c 00 44 00 43 00  4b 00 40 00 4a 00 4c 00
F.L.D.C.K.@.J.L.
    0020: 46 00 54 00 4b 00 4a 00  52 00 4e 00 54 00 4d 00
F.T.K.J.R.N.T.M.
> SCO data: handle 256 dlen 48
    0000: 55 00 61 00 52 00 54 00  5c 00 5c 00 59 00 60 00
U.a.R.T.\.\.Y.`.
    0010: 5d 00 52 00 5e 00 57 00  4e 00 56 00 53 00 53
00  ].R.^.W.N.V.S.S.
    0020: 4e 00 4e 00 58 00 51 00  54 00 58 00 52 00 58 00
N.N.X.Q.T.X.R.X.
> SCO data: handle 256 dlen 48
    0000: 54 00 51 00 57 00 54 00  55 00 53 00 5e 00 65 00
T.Q.W.T.U.S.^.e.
    0010: 57 00 56 00 55 00 51 00  57 00 67 00 60 00 59 00
W.V.U.Q.W.g.`.Y.
    0020: 5c 00 49 00 4e 00 53 00  48 00 4d 00 49 00 46 00
\.I.N.S.H.M.I.F.
> SCO data: handle 256 dlen 48
    0000: 45 00 41 00 43 00 3e 00  3d 00 40 00 39 00 3e 00
E.A.C.>.=3D.@.9.>.
    0010: 3a 00 35 00 3b 00 33 00  31 00 32 00 2d 00 37
00  :.5.;.3.1.2.-.7.
    0020: 38 00 36 00 3b 00 36 00  38 00 38 00 34 00 39 00
8.6.;.6.8.8.4.9.
> SCO data: handle 256 dlen 48
    0000: 40 00 3a 00 31 00 37 00  39 00 36 00 38 00 35 00
@.:.1.7.9.6.8.5.
    0010: 3c 00 36 00 36 00 40 00  39 00 3d 00 42 00 3c 00
<.6.6.@.9.=3D.B.<.
    0020: 3e 00 40 00 3f 00 40 00  3d 00 42 00 45 00 41 00
>.@.?.@.=3D.B.E.A.
> SCO data: handle 256 dlen 48
    0000: 4f 00 4c 00 45 00 4f 00  47 00 42 00 4b 00 47 00
O.L.E.O.G.B.K.G.
    0010: 42 00 44 00 40 00 49 00  4e 00 42 00 4c 00 4f 00
B.D.@.I.N.B.L.O.
    0020: 45 00 4d 00 45 00 48 00  56 00 4c 00 53 00 55 00
E.M.E.H.V.L.S.U.
> SCO data: handle 256 dlen 48
    0000: 52 00 5b 00 56 00 4d 00  51 00 5f 00 55 00 52 00
R.[.V.M.Q._.U.R.
    0010: 64 00 55 00 4f 00 59 00  57 00 54 00 4f 00 50 00
d.U.O.Y.W.T.O.P.
    0020: 52 00 54 00 50 00 4d 00  57 00 5a 00 55 00 59 00
R.T.P.M.W.Z.U.Y.
> SCO data: handle 256 dlen 48
    0000: 54 00 54 00 57 00 51 00  54 00 53 00 52 00 62 00
T.T.W.Q.T.S.R.b.
    0010: 58 00 4e 00 5d 00 5a 00  59 00 61 00 5a 00 59 00
X.N.].Z.Y.a.Z.Y.
    0020: 53 00 4b 00 5c 00 5e 00  52 00 55 00 4f 00 4e 00
S.K.\.^.R.U.O.N.
> SCO data: handle 256 dlen 48
    0000: 59 00 4b 00 50 00 58 00  4f 00 57 00 51 00 54 00
Y.K.P.X.O.W.Q.T.
    0010: 5c 00 52 00 56 00 56 00  5a 00 64 00 58 00 51 00
\.R.V.V.Z.d.X.Q.
    0020: 5c 00 5e 00 54 00 59 00  5d 00 50 00 50 00 5a 00
\.^.T.Y.].P.P.Z.
> SCO data: handle 256 dlen 48
    0000: 61 00 59 00 54 00 57 00  52 00 59 00 51 00 4f 00
a.Y.T.W.R.Y.Q.O.
    0010: 60 00 53 00 54 00 59 00  56 00 5d 00 58 00 55 00
`.S.T.Y.V.].X.U.
    0020: 54 00 53 00 55 00 5b 00  57 00 50 00 5a 00 5b 00
T.S.U.[.W.P.Z.[.
> SCO data: handle 256 dlen 48
    0000: 59 00 62 00 58 00 4b 00  51 00 57 00 5f 00 58 00
Y.b.X.K.Q.W._.X.
    0010: 50 00 55 00 50 00 57 00  57 00 53 00 5d 00 59 00
P.U.P.W.W.S.].Y.
    0020: 58 00 56 00 56 00 54 00  53 00 58 00 52 00 53 00
X.V.V.T.S.X.R.S.
> SCO data: handle 256 dlen 48
    0000: 58 00 57 00 58 00 59 00  59 00 58 00 5d 00 5e 00
X.W.X.Y.Y.X.].^.
    0010: 61 00 61 00 56 00 56 00  5d 00 59 00 56 00 52 00
a.a.V.V.].Y.V.R.
    0020: 50 00 55 00 4c 00 53 00  5d 00 52 00 59 00 55 00
P.U.L.S.].R.Y.U.
> SCO data: handle 256 dlen 48
    0000: 58 00 5e 00 51 00 54 00  52 00 55 00 5d 00 5d 00
X.^.Q.T.R.U.].].
    0010: 5c 00 53 00 57 00 5b 00  5c 00 5a 00 54 00 58 00
\.S.W.[.\.Z.T.X.
    0020: 58 00 55 00 58 00 5e 00  65 00 5b 00 54 00 5a 00
X.U.X.^.e.[.T.Z.
> SCO data: handle 256 dlen 48
    0000: 54 00 55 00 5d 00 54 00  57 00 5a 00 54 00 53 00
T.U.].T.W.Z.T.S.
    0010: 4e 00 53 00 57 00 53 00  52 00 4c 00 57 00 5e 00
N.S.W.S.R.L.W.^.
    0020: 53 00 5d 00 62 00 5a 00  5a 00 4f 00 4d 00 5e 00
S.].b.Z.Z.O.M.^.
> SCO data: handle 256 dlen 48
    0000: 61 00 58 00 56 00 54 00  4e 00 5b 00 5d 00 50 00
a.X.V.T.N.[.].P.
    0010: 59 00 5a 00 51 00 59 00  53 00 53 00 60 00 5c 00
Y.Z.Q.Y.S.S.`.\.
    0020: 58 00 54 00 51 00 51 00  52 00 55 00 54 00 59 00
X.T.Q.Q.R.U.T.Y.
> SCO data: handle 256 dlen 48
    0000: 5b 00 59 00 58 00 51 00  53 00 51 00 54 00 5b 00
[.Y.X.Q.S.Q.T.[.
    0010: 51 00 55 00 56 00 55 00  55 00 52 00 5e 00 5a 00
Q.U.V.U.U.R.^.Z.
    0020: 53 00 58 00 50 00 54 00  56 00 55 00 57 00 53 00
S.X.P.T.V.U.W.S.
> SCO data: handle 256 dlen 48
    0000: 57 00 5f 00 5a 00 51 00  59 00 61 00 5b 00 5b 00
W._.Z.Q.Y.a.[.[.
    0010: 5f 00 57 00 55 00 58 00  57 00 58 00 5c 00 59 00
_.W.U.X.W.X.\.Y.
    0020: 52 00 53 00 5a 00 59 00  58 00 56 00 54 00 59 00
R.S.Z.Y.X.V.T.Y.
> SCO data: handle 256 dlen 48
    0000: 53 00 52 00 54 00 4f 00  56 00 55 00 53 00 5f 00
S.R.T.O.V.U.S._.
    0010: 5b 00 4c 00 58 00 5d 00  56 00 62 00 59 00 4a 00
[.L.X.].V.b.Y.J.
    0020: 53 00 5a 00 5a 00 53 00  4e 00 4f 00 53 00 60 00
S.Z.Z.S.N.O.S.`.
> SCO data: handle 256 dlen 48
    0000: 54 00 51 00 58 00 4f 00  56 00 57 00 52 00 59 00
T.Q.X.O.V.W.R.Y.
    0010: 53 00 53 00 5a 00 58 00  56 00 54 00 53 00 52 00
S.S.Z.X.V.T.S.R.
    0020: 52 00 56 00 5f 00 61 00  55 00 54 00 54 00 53 00
R.V._.a.U.T.T.S.
> SCO data: handle 256 dlen 48
    0000: 5d 00 56 00 56 00 5c 00  50 00 55 00 5c 00 54
00  ].V.V.\.P.U.\.T.
    0010: 5b 00 60 00 57 00 58 00  55 00 56 00 58 00 56 00
[.`.W.X.U.V.X.V.
    0020: 57 00 56 00 5b 00 56 00  53 00 58 00 5a 00 60 00
W.V.[.V.S.X.Z.`.
> SCO data: handle 256 dlen 48
    0000: 5a 00 5b 00 5c 00 4c 00  4f 00 57 00 59 00 53 00
Z.[.\.L.O.W.Y.S.
    0010: 4d 00 4f 00 51 00 5d 00  5b 00 53 00 56 00 55 00
M.O.Q.].[.S.V.U.
    0020: 57 00 5a 00 59 00 5a 00  5a 00 55 00 52 00 5b 00
W.Z.Y.Z.Z.U.R.[.
> SCO data: handle 256 dlen 48
    0000: 57 00 52 00 53 00 51 00  57 00 5b 00 59 00 61 00
W.R.S.Q.W.[.Y.a.
    0010: 5e 00 5b 00 5c 00 52 00  5a 00 5b 00 4d 00 50 00
^.[.\.R.Z.[.M.P.
    0020: 53 00 59 00 5e 00 55 00  57 00 59 00 54 00 5e 00
S.Y.^.U.W.Y.T.^.
> SCO data: handle 256 dlen 48
    0000: 61 00 56 00 5a 00 5a 00  58 00 5f 00 5b 00 57 00
a.V.Z.Z.X._.[.W.
    0010: 57 00 5a 00 55 00 57 00  62 00 55 00 58 00 60 00
W.Z.U.W.b.U.X.`.
    0020: 57 00 5d 00 5b 00 5b 00  63 00 5b 00 56 00 58 00
W.].[.[.c.[.V.X.
> SCO data: handle 256 dlen 48
    0000: 59 00 5a 00 5b 00 5c 00  52 00 54 00 5c 00 5d 00
Y.Z.[.\.R.T.\.].
    0010: 60 00 54 00 58 00 61 00  59 00 5d 00 5c 00 55 00
`.T.X.a.Y.].\.U.
    0020: 60 00 62 00 59 00 5e 00  59 00 53 00 58 00 4d 00
`.b.Y.^.Y.S.X.M.
> SCO data: handle 256 dlen 48
    0000: 5d 00 63 00 4b 00 59 00  55 00 50 00 5c 00 49
00  ].c.K.Y.U.P.\.I.
    0010: 4b 00 50 00 48 00 50 00  47 00 45 00 47 00 47 00
K.P.H.P.G.E.G.G.
    0020: 47 00 3e 00 40 00 40 00  39 00 35 00 37 00 3b 00
G.>.@.@.9.5.7.;.
> SCO data: handle 256 dlen 48
    0000: 3b 00 3d 00 39 00 38 00  3c 00 36 00 38 00 37
00  ;.=3D.9.8.<.6.8.7.
    0010: 30 00 32 00 37 00 3a 00  33 00 31 00 3a 00 38 00
0.2.7.:.3.1.:.8.
    0020: 3b 00 3d 00 38 00 3a 00  3d 00 3d 00 3e 00 41
00  ;.=3D.8.:.=3D.=3D.>.A.
> SCO data: handle 256 dlen 48
    0000: 40 00 38 00 3d 00 44 00  3b 00 40 00 4c 00 49 00
@.8.=3D.D.;.@.L.I.
    0010: 47 00 42 00 3d 00 43 00  48 00 4b 00 4a 00 45 00
G.B.=3D.C.H.K.J.E.
    0020: 43 00 4a 00 4c 00 49 00  4b 00 49 00 48 00 4a 00
C.J.L.I.K.I.H.J.
> SCO data: handle 256 dlen 48
    0000: 46 00 4b 00 4c 00 4b 00  53 00 51 00 4d 00 4c 00
F.K.L.K.S.Q.M.L.
    0010: 4b 00 53 00 5b 00 5a 00  5d 00 5f 00 5e 00 5a 00
K.S.[.Z.]._.^.Z.
    0020: 53 00 56 00 5a 00 53 00  4e 00 51 00 4f 00 4a 00
S.V.Z.S.N.Q.O.J.
> SCO data: handle 256 dlen 48
    0000: 52 00 53 00 56 00 59 00  4e 00 56 00 57 00 4f 00
R.S.V.Y.N.V.W.O.
    0010: 57 00 56 00 5b 00 5c 00  63 00 7f 00 7c 00 95 00
W.V.[.\.c...|...
    0020: ec 00 7f 01 ad 02 b4 04  42 08 8b 0d 9b 13 7d
1a  ........B.....}.
> SCO data: handle 256 dlen 48
    0000: 11 22 00 2a 32 32 61 38  8a 3c 5e 41 91 44 44
47  .".*22a8.<^A.DDG
    0010: 6d 4a 99 4b 4c 4d 0d 4f  a4 4f 65 50 ad 50 8d 51
mJ.KLM.O.OeP.P.Q
    0020: c1 51 4d 51 71 51 9f 51  e2 51 40 52 88 52 38
52  .QMQqQ.Q.Q@R.R8R
> SCO data: handle 256 dlen 48
    0000: 9a 51 9e 51 7d 51 71 51  87 51 12 51 a5 50 80
50  .Q.Q}QqQ.Q.Q.P.P
    0010: 43 50 11 50 02 50 f0 4f  aa 4f eb 4e ee 4e ea 4e
CP.P.P.O.O.N.N.N
    0020: 1c 4e 9b 4e 47 4e 76 4d  9d 4d fe 4c e6 4c b2
4c  .N.NGNvM.M.L.L.L
> SCO data: handle 256 dlen 48
    0000: 63 4c 57 4c ee 4b df 4b  97 4b 7b 4b 50 4b dd 4a
cLWL.K.K.K{KPK.J
    0010: 40 4a 44 4a 52 4a 8b 49  4e 49 7b 49 4f 49 b3 48
@JDJRJ.INI{IOI.H
    0020: 79 48 47 48 b6 47 25 48  db 47 37 47 44 47 d3 46  yHGH.G%
H.G7GDG.F
> SCO data: handle 256 dlen 48
    0000: 8b 46 63 46 ec 45 c4 45  d5 44 01 45 b2 44 af
43  .FcF.E.E.D.E.D.C
    0010: 9b 44 b1 43 c4 43 ba 43  16 43 18 43 18 42 cf
42  .D.C.C.C.C.C.B.B
    0020: 8c 41 b4 41 e0 41 56 40  ab 41 20 40 36 40 a4 40  .A.A.AV@.A
@6@.@
> SCO data: handle 256 dlen 48
    0000: b0 3e 8a 3f 55 3f 2a 3e  50 3e 97 3e 5d 3d b9
3c  .>.?U?*>P>.>]=3D.<
    0010: 70 3d e2 3c d7 3b bd 3b  44 3c 64 3b 76 3a 06 3b
p=3D.<.;.;D<d;v:.;
    0020: f3 3a ea 39 89 39 28 3a  af 39 33 39 cf 39 e5
38  .:.9.9(:.939.9.8
> SCO data: handle 256 dlen 48
    0000: e5 38 37 39 ae 37 66 37  aa 37 9b 37 ca 36 3b
36  .879.7f7.7.7.6;6
    0010: 08 37 66 36 7d 35 b4 35  f3 35 2f 35 6a 34 05
35  .7f6}5.5.5/5j4.5
    0020: d3 34 ed 33 37 34 6a 34  52 33 c6 32 b3 32 ea
32  .4.374j4R3.2.2.2
> SCO data: handle 256 dlen 48
    0000: da 32 ad 31 aa 31 00 32  c5 31 f6 30 5e 30 33
30  .2.1.1.2.1.0^030
    0010: 47 30 8f 30 7c 2f 70 2f  09 30 58 2f be 2e 59 2e
G0.0|/p/.0X/..Y.
    0020: 8a 2e c8 2e 0b 2e 6a 2d  58 2d 91 2d 90 2d a9
2c  ......j-X-.-.-.,
> SCO data: handle 256 dlen 48
    0000: 44 2c 0c 2c 26 2c 74 2c  6d 2b 24 2b 1e 2b 55 2b  D,.,&,t,m
+$+.+U+
    0010: 3e 2b 39 2a 30 2a ad 29  d4 29 45 2a 63 29 10 29
>+9*0*.).)E*c).)
    0020: b7 28 b7 28 23 29 9c 28  b8 28 fa 28 04 28 b8
27  .(.(#).(.(.(.(.'
> SCO data: handle 256 dlen 48
    0000: 67 27 d3 26 be 26 cf 26  22 27 69 26 fd 25 d5 25
g'.&.&.&"'i&.%.%
    0010: 3c 25 2b 25 31 25 8d 25  f9 24 9d 24 32 25 ea 24  <%+%
1%.%.$.$2%.$
    0020: 60 24 06 24 b6 23 53 23  08 23 b9 22 b6 22 25 23  `
$.$.#S#.#."."%#
> SCO data: handle 256 dlen 48
    0000: c0 22 3f 22 17 22 bc 21  ff 21 36 22 96 21 4c 21  ."?".".!.!
6".!L!
    0010: 10 21 b3 20 f1 20 25 21  a9 20 45 20 14 20 d2 1f  .!. . %!.
E . ..
    0020: 2d 20 2f 20 8c 1f 7c 1f  b5 1f c7 1f 47 1f f5 1e
- / ..|.....G...
> SCO data: handle 256 dlen 48
    0000: cf 1e 60 1e 4a 1e 6d 1e  a6 1e 2a 1e d2 1d ba
1d  ..`.J.m...*.....
    0010: 46 1d 29 1d d2 1c 97 1c  6b 1c 7d 1c d3 1c 53 1c
F.).....k.}...S.
    0020: 2d 1c 89 1c 73 1c 01 1c  c6 1b 90 1b 3d 1b 55 1b
-...s.......=3D.U.
> SCO data: handle 256 dlen 48
    0000: 98 1b 62 1b 2c 1b 9f 1b  38 1b 41 1a 48 1a 3e
1a  ..b.,...8.A.H.>.
    0010: 0d 1a 61 1a 96 1a 39 1a  03 1a e4 19 97 19 76
19  ..a...9.......v.
    0020: 36 19 0e 19 36 19 6b 19  1c 19 c9 18 b7 18 61 18
6...6.k.......a.
> SCO data: handle 256 dlen 48
    0000: 3b 18 ff 17 c8 17 e8 17  1c 18 e7 17 8b 17 7f
17  ;...............
    0010: 34 17 0b 17 e1 16 a1 16  bb 16 f2 16 d4 16 77 16
4.............w.
    0020: 6b 16 2d 16 fa 15 db 15  97 15 87 15 a0 15 d7 15
k.-.............
> SCO data: handle 256 dlen 48
    0000: 81 15 4d 15 3a 15 ec 14  da 14 99 14 94 14 d4
14  ..M.:...........
    0010: c6 14 79 14 57 14 31 14  f8 13 19 14 78 14 ac
14  ..y.W.1.....x...
    0020: 26 14 f2 13 fb 13 5d 13  68 13 98 13 72 13 7e 13
&.....].h...r.~.
> SCO data: handle 256 dlen 48
    0000: 5b 13 4b 13 31 13 06 13  af 12 61 12 e0 12 fe 12
[.K.1.....a.....
    0010: ad 12 c2 12 95 12 78 12  5d 12 ef 11 b8 11 1f
12  ......x.].......
    0020: 29 12 a0 11 04 12 07 12  72 11 c6 11 b8 11 9a
11  ).......r.......
> SCO data: handle 256 dlen 48
    0000: a8 11 74 11 72 11 48 11  2d 11 11 11 e6 10 ce
10  ..t.r.H.-.......
    0010: a0 10 84 10 5a 10 37 10  11 10 f1 0f f0 0f d1
0f  ....Z.7.........
    0020: 9f 0f b0 0f d8 0f 0a 10  ee 0f 89 0f 6b 0f ba
0f  ............k...
> SCO data: handle 256 dlen 48
    0000: af 0f 33 0f 62 0f 27 0f  cb 0e 17 0f f1 0e f0
0e  ..3.b.'.........
    0010: e9 0e c6 0e e3 0e 0f 0f  32 0f 18 0f 01 0f bb
0e  ........2.......
    0020: 78 0e 44 0e 10 0e 1f 0e  3e 0e 46 0e 3d 0e 3d 0e
x.D.....>.F.=3D.=3D.
> SCO data: handle 256 dlen 48
    0000: 14 0e c3 0d ad 0d c1 0d  a9 0d 98 0d a5 0d d0
0d  ................
    0010: ea 0d b5 0d b3 0d 9c 0d  79 0d 6f 0d 45 0d 35
0d  ........y.o.E.5.
    0020: 11 0d f7 0c dc 0c bb 0c  cc 0c f1 0c e0 0c b7
0c  ................
> SCO data: handle 256 dlen 48
    0000: d3 0c fb 0c ed 0c 85 0c  24 0c 2a 0c 3d 0c 2e
0c  ........$.*.=3D...
    0010: 24 0c 1b 0c 26 0c 3b 0c  f5 0b f2 0b f8 0b 95 0b
$...&.;.........
    0020: 96 0b a9 0b bb 0b f9 0b  b8 0b 7b 0b 86 0b 44
0b  ..........{...D.
> SCO data: handle 256 dlen 48
    0000: 3b 0b 42 0b ee 0a 04 0b  15 0b f8 0a 04 0b 06
0b  ;.B.............
    0010: 44 0b 46 0b 28 0b 19 0b  ca 0a d2 0a d2 0a 83 0a
D.F.(...........
    0020: 78 0a 8a 0a 9d 0a d6 0a  d7 0a bf 0a a4 0a 3c 0a
x.............<.
> SCO data: handle 256 dlen 48
    0000: 22 0a 4a 0a 4c 0a 7d 0a  66 0a 4a 0a 7b 0a 67 0a
".J.L.}.f.J.{.g.
    0010: 65 0a 60 0a 25 0a 1e 0a  14 0a c5 09 b8 09 d0 09
e.`.%...........
    0020: bf 09 28 0a 5d 0a 20 0a  1f 0a 2e 0a 2b 0a d6
09  ..(.]. .....+...
> SCO data: handle 256 dlen 48
    0000: 8d 09 8c 09 a5 09 bb 09  a1 09 7b 09 6b 09 80
09  ..........{.k...
    0010: 4c 09 0e 09 1a 09 3d 09  3a 09 4d 09 ba 09 b8 09
L.....=3D.:.M.....
    0020: 8b 09 82 09 5c 09 3c 09  16 09 09 09 0b 09 fc
08  ....\.<.........
> SCO data: handle 256 dlen 48
    0000: e3 08 f6 08 cf 08 b0 08  dd 08 bf 08 c2 08 b9
08  ................
    0010: a1 08 9f 08 80 08 79 08  5d 08 3e 08 13 08 26
08  ......y.].>...&.
    0020: 3b 08 08 08 5c 08 62 08  06 08 22 08 23 08 01
08  ;...\.b...".#...
> SCO data: handle 256 dlen 48
    0000: 10 08 1f 08 14 08 22 08  23 08 ef 07 f9 07 0e
08  ......".#.......
    0010: cc 07 93 07 81 07 71 07  76 07 8e 07 8f 07 82
07  ......q.v.......
    0020: 5f 07 52 07 68 07 5a 07  56 07 53 07 43 07 3f 07
_.R.h.Z.V.S.C.?.
> SCO data: handle 256 dlen 48
    0000: 3a 07 60 07 77 07 66 07  53 07 2f 07 3d 07 34
07  :.`.w.f.S./.=3D.4.
    0010: 0d 07 2a 07 37 07 46 07  60 07 5a 07 62 07 44
07  ..*.7.F.`.Z.b.D.
    0020: fb 06 f7 06 16 07 f0 06  d8 06 ec 06 ec 06 05
07  ................
> SCO data: handle 256 dlen 48
    0000: 31 07 17 07 df 06 e9 06  18 07 0a 07 d4 06 07 07
1...............
    0010: 4c 07 23 07 ff 06 ee 06  e4 06 f3 06 02 07 f2 06
L.#.............
    0020: d6 06 bd 06 a1 06 91 06  84 06 a5 06 cc 06 c7
06  ................
> SCO data: handle 256 dlen 48
    0000: ac 06 ab 06 f7 06 df 06  95 06 b3 06 af 06 74
06  ..............t.
    0010: 77 06 94 06 7a 06 7f 06  a8 06 9f 06 8d 06 a5 06
w...z...........
    0020: 98 06 70 06 8f 06 9f 06  98 06 88 06 90 06 b5
06  ..p.............
> SCO data: handle 256 dlen 48
    0000: 9c 06 9c 06 81 06 5d 06  77 06 48 06 30 06 58
06  ......].w.H.0.X.
    0010: 81 06 94 06 98 06 8f 06  64 06 56 06 3b 06 2f
06  ........d.V.;./.
    0020: 59 06 3c 06 18 06 42 06  2c 06 07 06 27 06 3d 06
Y.<...B.,...'.=3D.
> SCO data: handle 256 dlen 48
    0000: 38 06 1b 06 17 06 2b 06  31 06 21 06 ed 05 f0 05
8.....+.1.!.....
    0010: 26 06 1c 06 ed 05 fa 05  10 06 01 06 e1 05 c1 05
&...............
    0020: bd 05 ba 05 c2 05 e2 05  da 05 f5 05 15 06 d9
05  ................
> SCO data: handle 256 dlen 48
    0000: da 05 ed 05 dd 05 f8 05  d8 05 d3 05 d4 05 8f
05  ................
    0010: 7a 05 68 05 70 05 79 05  7b 05 c1 05 b5 05 97 05
z.h.p.y.{.......
    0020: 8b 05 4c 05 54 05 67 05  5a 05 6e 05 7f 05 7e
05  ..L.T.g.Z.n...~.
> SCO data: handle 256 dlen 48
    0000: 80 05 7b 05 64 05 45 05  33 05 22 05 20 05 28
05  ..{.d.E.3.". .(.
    0010: 30 05 4c 05 24 05 0f 05  3f 05 32 05 1f 05 08 05
0.L.$...?.2.....
    0020: f5 04 f3 04 dc 04 eb 04  eb 04 e1 04 e1 04 d3
04  ................
> SCO data: handle 256 dlen 48
    0000: cd 04 c0 04 ba 04 c3 04  dc 04 09 05 e8 04 c2
04  ................
    0010: fd 04 ea 04 b1 04 a0 04  85 04 94 04 9a 04 a3
04  ................
    0020: aa 04 95 04 92 04 73 04  75 04 67 04 46 04 65
04  ......s.u.g.F.e.
> SCO data: handle 256 dlen 48
    0000: 62 04 60 04 6f 04 7d 04  70 04 4e 04 56 04 44 04
b.`.o.}.p.N.V.D.
    0010: 39 04 4e 04 3e 04 3a 04  42 04 29 04 25 04 3d 04
9.N.>.:.B.).%.=3D.
    0020: 35 04 16 04 07 04 02 04  e6 03 df 03 fd 03 0b 04
5...............
> SCO data: handle 256 dlen 48
    0000: 04 04 e7 03 e4 03 e4 03  dd 03 e8 03 ba 03 b4
03  ................
    0010: d9 03 d2 03 f2 03 00 04  fd 03 f7 03 cb 03 af
03  ................
    0020: 9d 03 a0 03 8b 03 74 03  86 03 8d 03 8b 03 7d
03  ......t.......}.
> SCO data: handle 256 dlen 48
    0000: 87 03 9e 03 bb 03 cc 03  bb 03 cf 03 c7 03 9a
03  ................
    0010: 8f 03 99 03 96 03 8e 03  ae 03 cb 03 f6 03 f9
03  ................
    0020: c0 03 b6 03 ba 03 ba 03  ad 03 9d 03 b6 03 ba
03  ................
> SCO data: handle 256 dlen 48
    0000: 9d 03 97 03 8b 03 7e 03  8b 03 7b 03 66 03 6f
03  ......~...{.f.o.
    0010: 58 03 55 03 63 03 4c 03  5b 03 62 03 6c 03 8a 03
X.U.c.L.[.b.l...
    0020: 83 03 a6 03 90 03 74 03  91 03 7c 03 80 03 7d
03  ......t...|...}.
> SCO data: handle 256 dlen 48
    0000: 7d 03 82 03 4e 03 42 03  56 03 51 03 56 03 68
03  }...N.B.V.Q.V.h.
    0010: 69 03 66 03 59 03 4c 03  40 03 21 03 1d 03 1a 03
i.f.Y.L.@.!.....
    0020: 19 03 19 03 07 03 28 03  2e 03 0d 03 29 03 4d
03  ......(.....).M.
> SCO data: handle 256 dlen 48
    0000: 49 03 50 03 5f 03 46 03  2d 03 47 03 43 03 2f 03
I.P._.F.-.G.C./.
    0010: 57 03 4b 03 3d 03 86 03  88 03 78 03 86 03 5b 03
W.K.=3D.....x...[.
    0020: 3c 03 47 03 47 03 2f 03  37 03 34 03 32 03 5c 03
<.G.G./.7.4.2.\.
> SCO data: handle 256 dlen 48
    0000: 5b 03 4b 03 48 03 49 03  35 03 03 03 f7 02 0e 03
[.K.H.I.5.......
    0010: 27 03 38 03 37 03 25 03  1e 03 17 03 04 03 15 03
'.8.7.%.........
    0020: 46 03 4c 03 33 03 2b 03  21 03 22 03 36 03 18 03
F.L.3.+.!.".6...
> SCO data: handle 256 dlen 48
    0000: 04 03 2c 03 2e 03 3a 03  52 03 36 03 1f 03 10
03  ..,...:.R.6.....
    0010: 1f 03 30 03 2f 03 31 03  2d 03 49 03 3e 03 31
03  ..0./.1.-.I.>.1.
    0020: 47 03 36 03 24 03 1c 03  1d 03 2e 03 3a 03 21 03
G.6.$.......:.!.
> SCO data: handle 256 dlen 48
    0000: 0e 03 2b 03 0e 03 f1 02  f4 02 1e 03 57 03 40
03  ..+.........W.@.
    0010: 76 03 6d 03 29 03 64 03  45 03 2e 03 49 03 37 03
v.m.).d.E...I.7.
    0020: 32 03 1e 03 43 03 44 03  32 03 2e 03 ec 02 08 03
2...C.D.2.......
> SCO data: handle 256 dlen 48
    0000: 1b 03 f9 02 0b 03 06 03  0d 03 13 03 04 03 fb
02  ................
    0010: 06 03 17 03 02 03 f8 02  05 03 0a 03 02 03 02
03  ................
    0020: 18 03 18 03 06 03 f9 02  ea 02 ef 02 06 03 0b
03  ................
> SCO data: handle 256 dlen 48
    0000: 25 03 4c 03 30 03 f1 02  f2 02 0f 03 ed 02 10 03
%.L.0...........
    0010: 1d 03 fa 02 33 03 0c 03  f4 02 fa 02 e2 02 15
03  ....3...........
    0020: 23 03 35 03 51 03 3d 03  3f 03 1f 03 fe 02 0d 03
#.5.Q.=3D.?.......
> SCO data: handle 256 dlen 48
    0000: ff 02 e2 02 ee 02 f6 02  e1 02 c0 02 c5 02 d4
02  ................
    0010: c6 02 cc 02 c1 02 cf 02  e5 02 c7 02 d7 02 db
02  ................
    0020: bf 02 c7 02 d2 02 ef 02  00 03 e2 02 d4 02 f7
02  ................
> SCO data: handle 256 dlen 48
    0000: f9 02 d1 02 e5 02 02 03  f9 02 de 02 bb 02 c6
02  ................
    0010: d5 02 ee 02 03 03 f7 02  f8 02 db 02 d2 02 da
02  ................
    0020: b8 02 c0 02 bd 02 b0 02  e7 02 fa 02 e0 02 e3
02  ................
> SCO data: handle 256 dlen 48
    0000: ef 02 e8 02 d8 02 dd 02  eb 02 f7 02 df 02 c4
02  ................
    0010: d4 02 bd 02 a8 02 bd 02  be 02 de 02 02 03 f2
02  ................
    0020: f8 02 06 03 ef 02 dd 02  bd 02 a6 02 c4 02 c9
02  ................
> SCO data: handle 256 dlen 48
    0000: ba 02 c7 02 c9 02 b5 02  b8 02 d2 02 d6 02 d6
02  ................
    0010: db 02 b4 02 9e 02 a8 02  ac 02 b0 02 bb 02 d3
02  ................
    0020: f6 02 f0 02 b1 02 ad 02  d9 02 ba 02 ab 02 bd
02  ................
> SCO data: handle 256 dlen 48
    0000: c6 02 d1 02 e4 02 f4 02  cc 02 db 02 e9 02 c3
02  ................
    0010: cd 02 b6 02 b2 02 c9 02  a7 02 a7 02 c8 02 bc
02  ................
    0020: ab 02 c9 02 f4 02 f7 02  e6 02 ff 02 02 03 cb
02  ................
> SCO data: handle 256 dlen 48
    0000: d4 02 cf 02 b7 02 c6 02  ac 02 bb 02 b9 02 9c
02  ................
    0010: c0 02 b0 02 bf 02 c7 02  9c 02 c9 02 a2 02 5b
02  ..............[.
    0020: 85 02 8b 02 9c 02 d5 02  c7 02 c8 02 dc 02 df
02  ................
> SCO data: handle 256 dlen 48
    0000: eb 02 dd 02 ca 02 b7 02  b5 02 b4 02 a7 02 ab
02  ................
    0010: a7 02 ae 02 c6 02 c0 02  b8 02 c0 02 9d 02 7b
02  ..............{.
    0020: 92 02 a3 02 ad 02 8c 02  89 02 c1 02 cc 02 e6
02  ................
> SCO data: handle 256 dlen 48
    0000: f4 02 cc 02 b9 02 b1 02  9d 02 97 02 a5 02 88
02  ................
    0010: 73 02 7d 02 65 02 64 02  77 02 86 02 af 02 cb 02
s.}.e.d.w.......
    0020: a2 02 90 02 b4 02 87 02  79 02 aa 02 9e 02 b0
02  ........y.......
> SCO data: handle 256 dlen 48
    0000: be 02 b8 02 c5 02 b7 02  b4 02 c0 02 bd 02 9b
02  ................
    0010: 75 02 6c 02 77 02 6e 02  45 02 42 02 51 02 72 02
u.l.w.n.E.B.Q.r.
    0020: 96 02 7f 02 6d 02 7c 02  73 02 5e 02 77 02 8d
02  ....m.|.s.^.w...
> SCO data: handle 256 dlen 48
    0000: 92 02 95 02 8c 02 96 02  a0 02 96 02 9e 02 a2
02  ................
    0010: 8d 02 ab 02 a9 02 82 02  9b 02 8e 02 73 02 70
02  ............s.p.
    0020: 6f 02 85 02 8c 02 93 02  98 02 9b 02 7f 02 4e 02
o.............N.
> SCO data: handle 256 dlen 48
    0000: 5e 02 76 02 69 02 3d 02  3d 02 6f 02 81 02 81 02
^.v.i.=3D.=3D.o.....
    0010: 70 02 70 02 82 02 79 02  5b 02 4b 02 64 02 60 02
p.p...y.[.K.d.`.
    0020: 38 02 37 02 49 02 4e 02  40 02 26 02 27 02 28 02
8.7.I.N.@.&.'.(.
> SCO data: handle 256 dlen 48
    0000: 1b 02 24 02 3c 02 4f 02  3c 02 2b 02 32 02 14
02  ..$.<.O.<.+.2...
    0010: 11 02 1b 02 1e 02 58 02  77 02 73 02 79 02 51
02  ......X.w.s.y.Q.
    0020: 41 02 33 02 04 02 44 02  5b 02 40 02 63 02 46 02
A.3...D.[.@.c.F.
> SCO data: handle 256 dlen 48
    0000: 65 02 84 02 45 02 42 02  53 02 5d 02 50 02 3f 02
e...E.B.S.].P.?.
    0010: 2e 02 1e 02 3f 02 35 02  25 02 3f 02 4b 02 44
02  ....?.5.%.?.K.D.
    0020: 31 02 3c 02 27 02 fc 01  0a 02 29 02 52 02 5c 02
1.<.'.....).R.\.
> SCO data: handle 256 dlen 48
    0000: 42 02 31 02 22 02 2b 02  31 02 48 02 60 02 53 02
B.1.".+.1.H.`.S.
    0010: 45 02 0f 02 ff 01 13 02  ff 01 0b 02 30 02 5e 02
E...........0.^.
    0020: 56 02 41 02 2e 02 04 02  23 02 25 02 1f 02 2c 02
V.A.....#.%...,.
> SCO data: handle 256 dlen 48
    0000: 1f 02 1c 02 0b 02 26 02  2a 02 21 02 3b 02 23
02  ......&.*.!.;.#.
    0010: 24 02 34 02 1d 02 14 02  11 02 fd 01 db 01 ee 01
$.4.............
    0020: 19 02 18 02 1d 02 22 02  0c 02 04 02 03 02 e8
01  ......".........
> SCO data: handle 256 dlen 48
    0000: e4 01 f2 01 fa 01 03 02  0c 02 15 02 11 02 02
02  ................
    0010: f9 01 f1 01 0a 02 0a 02  c4 01 e8 01 fb 01 bc
01  ................
    0020: f6 01 fe 01 ef 01 0c 02  e6 01 ed 01 de 01 d7
01  ................
> SCO data: handle 256 dlen 48
    0000: fb 01 ed 01 03 02 0b 02  e4 01 da 01 ea 01 ff
01  ................
    0010: f3 01 e5 01 df 01 de 01  ea 01 bd 01 c2 01 06
02  ................
    0020: e9 01 e9 01 f4 01 d5 01  fc 01 03 02 e2 01 e4
01  ................
> SCO data: handle 256 dlen 48
    0000: e5 01 ca 01 bc 01 e4 01  f2 01 e4 01 e0 01 d9
01  ................
    0010: d4 01 ce 01 c9 01 cd 01  ed 01 fc 01 d9 01 bb
01  ................
    0020: b0 01 ab 01 a5 01 9c 01  a2 01 b0 01 b1 01 92
01  ................
> SCO data: handle 256 dlen 48
    0000: 8b 01 a3 01 89 01 6f 01  79 01 89 01 c3 01 d1
01  ......o.y.......
    0010: 9a 01 9c 01 a5 01 9c 01  a9 01 b2 01 be 01 d2
01  ................
    0020: c3 01 a5 01 af 01 99 01  6a 01 7e 01 94 01 88
01  ........j.~.....
> SCO data: handle 256 dlen 48
    0000: 7b 01 86 01 8c 01 71 01  5d 01 5d 01 5b 01 60 01
{.....q.].].[.`.
    0010: 63 01 65 01 5c 01 47 01  44 01 49 01 66 01 77 01
c.e.\.G.D.I.f.w.
    0020: 6e 01 7e 01 79 01 6e 01  87 01 78 01 5c 01 6a 01
n.~.y.n...x.\.j.
> SCO data: handle 256 dlen 48
    0000: 5f 01 69 01 82 01 71 01  82 01 6d 01 3b 01 3d 01
_.i...q...m.;.=3D.
    0010: 2f 01 3f 01 42 01 30 01  4a 01 46 01 3e 01 2d
01  /.?.B.0.J.F.>.-.
    0020: 14 01 2a 01 37 01 33 01  2c 01 2a 01 2f 01 18
01  ..*.7.3.,.*./...
> SCO data: handle 256 dlen 48
    0000: f5 00 ea 00 f1 00 fa 00  f5 00 f3 00 ff 00 11
01  ................
    0010: 22 01 0c 01 fc 00 0e 01  f9 00 f2 00 02 01 f7 00
"...............
    0020: f2 00 ec 00 ed 00 12 01  21 01 0d 01 12 01 03
01  ........!.......
> SCO data: handle 256 dlen 48
    0000: fb 00 0e 01 08 01 0c 01  08 01 00 01 11 01 1a
01  ................
    0010: 21 01 1a 01 03 01 f8 00  f0 00 dc 00 e6 00 f0
00  !...............
    0020: de 00 e2 00 e0 00 d5 00  da 00 cc 00 b9 00 cc
00  ................
> SCO data: handle 256 dlen 48
    0000: da 00 d3 00 e4 00 d8 00  c4 00 e1 00 e0 00 c7
00  ................
    0010: d7 00 da 00 ee 00 18 01  05 01 0b 01 15 01 ec
00  ................
    0020: e9 00 da 00 e1 00 fb 00  e1 00 e7 00 ea 00 d3
00  ................
> SCO data: handle 256 dlen 48
    0000: da 00 d1 00 b6 00 bc 00  ca 00 cc 00 da 00 d8
00  ................
    0010: cb 00 c4 00 b7 00 ab 00  b8 00 c4 00 c2 00 cf
00  ................
    0020: ca 00 b6 00 b8 00 a8 00  96 00 95 00 89 00 89
00  ................
> SCO data: handle 256 dlen 48
    0000: a5 00 a8 00 a0 00 a6 00  a3 00 a4 00 a0 00 95
00  ................
    0010: ab 00 b8 00 af 00 b6 00  ab 00 8f 00 7a 00 7b
00  ............z.{.
    0020: 8f 00 97 00 96 00 95 00  9b 00 9d 00 88 00 6c
00  ..............l.
> SCO data: handle 256 dlen 48
    0000: 63 00 6a 00 70 00 72 00  6d 00 71 00 6c 00 63 00
c.j.p.r.m.q.l.c.
    0010: 6b 00 67 00 67 00 70 00  69 00 6e 00 71 00 6c 00
k.g.g.p.i.n.q.l.
    0020: 71 00 6d 00 79 00 8b 00  91 00 a8 00 b2 00 ae 00
q.m.y...........
> SCO data: handle 256 dlen 48
    0000: 9e 00 89 00 86 00 8b 00  96 00 91 00 8c 00 9d
00  ................
    0010: 98 00 82 00 7a 00 81 00  7b 00 72 00 79 00 75
00  ....z...{.r.y.u.
    0020: 81 00 90 00 8a 00 90 00  90 00 82 00 84 00 89
00  ................
> SCO data: handle 256 dlen 48
    0000: 9b 00 ad 00 a1 00 99 00  8d 00 7f 00 7f 00 7b
00  ..............{.
    0010: 73 00 73 00 79 00 71 00  70 00 6c 00 62 00 6f 00
s.s.y.q.p.l.b.o.
    0020: 72 00 63 00 65 00 63 00  5b 00 64 00 68 00 5d 00
r.c.e.c.[.d.h.].
> SCO data: handle 256 dlen 48
    0000: 60 00 80 00 99 00 9a 00  91 00 88 00 86 00 7c 00
`.............|.
    0010: 78 00 8e 00 90 00 8b 00  95 00 92 00 8e 00 89 00
x...............
    0020: 80 00 82 00 77 00 6a 00  65 00 64 00 6d 00 73
00  ....w.j.e.d.m.s.
> SCO data: handle 256 dlen 48
    0000: 67 00 5f 00 5f 00 63 00  68 00 5c 00 59 00 66 00
g._._.c.h.\.Y.f.
    0010: 64 00 66 00 6b 00 69 00  76 00 78 00 6d 00 66 00
d.f.k.i.v.x.m.f.
    0020: 65 00 5f 00 5d 00 65 00  64 00 78 00 93 00 8e 00
e._.].e.d.x.....
> SCO data: handle 256 dlen 48
    0000: b4 00 cb 00 a3 00 b3 00  af 00 94 00 a9 00 9c
00  ................
    0010: ab 00 c8 00 c6 00 d2 00  ca 00 cd 00 cb 00 b3
00  ................
    0020: ae 00 b6 00 c1 00 b1 00  a4 00 a8 00 a8 00 aa
00  ................
> SCO data: handle 256 dlen 48
    0000: 9d 00 98 00 a7 00 9c 00  7f 00 77 00 6d 00 78
00  ..........w.m.x.
    0010: 95 00 90 00 a1 00 ba 00  a9 00 a1 00 93 00 79
00  ..............y.
    0020: 7d 00 8d 00 89 00 89 00  97 00 a5 00 af 00 9d
00  }...............
> SCO data: handle 256 dlen 48
    0000: 8f 00 85 00 72 00 72 00  6b 00 58 00 46 00 4b
00  ....r.r.k.X.F.K.
    0010: 5d 00 5c 00 67 00 6e 00  62 00 5e 00 5b 00 53
00  ].\.g.n.b.^.[.S.
    0020: 59 00 5d 00 57 00 65 00  66 00 55 00 5c 00 61 00
Y.].W.e.f.U.\.a.
> SCO data: handle 256 dlen 48
    0000: 63 00 63 00 52 00 4d 00  65 00 87 00 94 00 92 00
c.c.R.M.e.......
    0010: a2 00 b2 00 a7 00 90 00  76 00 6c 00 60 00 52
00  ........v.l.`.R.
    0020: 4b 00 4b 00 63 00 79 00  94 00 b3 00 ba 00 b4 00
K.K.c.y.........
> SCO data: handle 256 dlen 48
    0000: 95 00 82 00 8c 00 86 00  7f 00 7c 00 7b 00 87
00  ..........|.{...
    0010: 92 00 9e 00 9b 00 7c 00  6c 00 79 00 7f 00 7c
00  ......|.l.y...|.
    0020: 7b 00 71 00 66 00 5d 00  56 00 49 00 3f 00 4f 00
{.q.f.].V.I.?.O.
> SCO data: handle 256 dlen 48
    0000: 51 00 52 00 58 00 51 00  6d 00 88 00 73 00 6a 00
Q.R.X.Q.m...s.j.
    0010: 67 00 6c 00 6f 00 56 00  57 00 66 00 5e 00 65 00
g.l.o.V.W.f.^.e.
    0020: 64 00 6a 00 8f 00 91 00  7f 00 7e 00 7f 00 81 00
d.j.......~.....
> SCO data: handle 256 dlen 48
    0000: 89 00 82 00 7e 00 9a 00  9b 00 85 00 88 00 64
00  ....~.........d.
    0010: 59 00 75 00 72 00 6e 00  66 00 6f 00 83 00 7e 00
Y.u.r.n.f.o...~.
    0020: 65 00 48 00 40 00 37 00  33 00 3f 00 3a 00 41 00
e.H.@.7.3.?.:.A.
> SCO data: handle 256 dlen 48
    0000: 4d 00 4b 00 60 00 7b 00  7f 00 69 00 5e 00 68 00
M.K.`.{...i.^.h.
    0010: 75 00 7b 00 63 00 64 00  82 00 7a 00 62 00 5c 00
u.{.c.d...z.b.\.
    0020: 60 00 5a 00 61 00 5f 00  5b 00 74 00 7a 00 6b 00
`.Z.a._.[.t.z.k.
> SCO data: handle 256 dlen 48
    0000: 6c 00 4b 00 38 00 4e 00  49 00 4a 00 60 00 5f 00
l.K.8.N.I.J.`._.
    0010: 6a 00 70 00 64 00 71 00  76 00 6f 00 5b 00 39 00
j.p.d.q.v.o.[.9.
    0020: 35 00 36 00 37 00 3c 00  37 00 50 00 71 00 73 00
5.6.7.<.7.P.q.s.
> SCO data: handle 256 dlen 48
    0000: 66 00 62 00 4e 00 41 00  4f 00 62 00 89 00 90 00
f.b.N.A.O.b.....
    0010: 93 00 a9 00 7d 00 6e 00  77 00 5c 00 70 00 72
00  ....}.n.w.\.p.r.
    0020: 7b 00 8b 00 6d 00 67 00  56 00 53 00 76 00 6c 00
{...m.g.V.S.v.l.
> SCO data: handle 256 dlen 48
    0000: 51 00 41 00 48 00 64 00  5e 00 42 00 40 00 5d 00
Q.A.H.d.^.B.@.].
    0010: 6b 00 5a 00 51 00 4f 00  41 00 41 00 45 00 46 00
k.Z.Q.O.A.A.E.F.
    0020: 49 00 44 00 47 00 50 00  4c 00 43 00 4b 00 4b 00
I.D.G.P.L.C.K.K.
> SCO data: handle 256 dlen 48
    0000: 34 00 32 00 40 00 3f 00  37 00 31 00 39 00 59 00
4.2.@.?.7.1.9.Y.
    0010: 71 00 68 00 47 00 3b 00  56 00 54 00 39 00 33 00
q.h.G.;.V.T.9.3.
    0020: 55 00 7e 00 6e 00 52 00  6f 00 8b 00 7b 00 57 00
U.~.n.R.o...{.W.
> SCO data: handle 256 dlen 48
    0000: 4f 00 74 00 6f 00 4e 00  66 00 8c 00 8f 00 7b 00
O.t.o.N.f.....{.
    0010: 85 00 83 00 60 00 62 00  65 00 5f 00 47 00 4a
00  ....`.b.e._.G.J.
    0020: 7a 00 81 00 66 00 52 00  46 00 43 00 3a 00 49 00
z...f.R.F.C.:.I.
> SCO data: handle 256 dlen 48
    0000: 5d 00 53 00 66 00 70 00  47 00 42 00 5d 00 52
00  ].S.f.p.G.B.].R.
    0010: 3b 00 4c 00 68 00 68 00  5a 00 4f 00 5f 00 5f
00  ;.L.h.h.Z.O._._.
    0020: 40 00 48 00 5f 00 59 00  4a 00 33 00 40 00 3e 00
@.H._.Y.J.3.@.>.
> SCO data: handle 256 dlen 48
    0000: 0d 00 24 00 48 00 66 00  6d 00 3f 00 55 00 5d
00  ..$.H.f.m.?.U.].
    0010: 34 00 39 00 3f 00 37 00  3e 00 54 00 56 00 5a 00
4.9.?.7.>.T.V.Z.
    0020: 5f 00 4a 00 3b 00 2d 00  28 00 37 00 41 00 39 00
_.J.;.-.(.7.A.9.
> SCO data: handle 256 dlen 48
    0000: 3b 00 46 00 42 00 47 00  45 00 29 00 24 00 36
00  ;.F.B.G.E.).$.6.
    0010: 3e 00 39 00 23 00 3d 00  9f 00 a7 00 40 00 39 00
>.9.#.=3D.....@.9.
    0020: a0 00 bf 00 7a 00 4b 00  5f 00 76 00 6d 00 67
00  ....z.K._.v.m.g.
> SCO data: handle 256 dlen 48
    0000: 8d 00 93 00 5a 00 59 00  90 00 97 00 8b 00 99
00  ....Z.Y.........
    0010: a0 00 97 00 93 00 7e 00  59 00 66 00 7d 00 79
00  ......~.Y.f.}.y.
    0020: 7e 00 58 00 4c 00 79 00  5a 00 5a 00 8a 00 87 00
~.X.L.y.Z.Z.....
> SCO data: handle 256 dlen 48
    0000: 94 00 7f 00 7b 00 81 00  3a 00 45 00 66 00 4a
00  ....{...:.E.f.J.
    0010: 3e 00 4c 00 6c 00 65 00  3d 00 4a 00 6a 00 49 00
>.L.l.e.=3D.J.j.I.
    0020: 36 00 4e 00 53 00 48 00  33 00 38 00 43 00 41 00
6.N.S.H.3.8.C.A.
> SCO data: handle 256 dlen 48
    0000: 4f 00 49 00 47 00 4a 00  3b 00 31 00 2c 00 2c 00
O.I.G.J.;.1.,.,.
    0010: 41 00 47 00 33 00 2e 00  27 00 27 00 31 00 2d 00
A.G.3...'.'.1.-.
    0020: 39 00 38 00 2c 00 43 00  47 00 34 00 2f 00 34 00
9.8.,.C.G.4./.4.
> SCO data: handle 256 dlen 48
    0000: 52 00 50 00 47 00 81 00  8d 00 5c 00 59 00 53 00
R.P.G.....\.Y.S.
    0010: 39 00 32 00 4b 00 9d 00  c6 00 89 00 7a 00 a4 00
9.2.K.......z...
    0020: 8b 00 61 00 56 00 60 00  87 00 77 00 53 00 69
00  ..a.V.`...w.S.i.
> SCO data: handle 256 dlen 48
    0000: 94 00 9f 00 7c 00 6b 00  58 00 38 00 61 00 7e
00  ....|.k.X.8.a.~.
    0010: 75 00 84 00 9a 00 99 00  85 00 73 00 57 00 3e 00
u.........s.W.>.
    0020: 46 00 69 00 79 00 56 00  50 00 74 00 81 00 5a 00
F.i.y.V.P.t...Z.
> SCO data: handle 256 dlen 48
    0000: 29 00 3a 00 5c 00 48 00  13 00 1c 00 4b 00 45
00  ).:.\.H.....K.E.
    0010: 2c 00 35 00 6b 00 7e 00  42 00 32 00 42 00 53
00  ,.5.k.~.B.2.B.S.
    0020: 73 00 92 00 ba 00 82 00  3c 00 5d 00 68 00 53 00
s.......<.].h.S.
> SCO data: handle 256 dlen 48
    0000: 55 00 7a 00 8e 00 7a 00  63 00 4c 00 4d 00 46 00
U.z...z.c.L.M.F.
    0010: 53 00 4b 00 15 00 2e 00  67 00 6c 00 35 00 15 00
S.K.....g.l.5...
    0020: 46 00 68 00 51 00 3d 00  5f 00 6f 00 61 00 67 00
F.h.Q.=3D._.o.a.g.
> SCO data: handle 256 dlen 48
    0000: 4e 00 45 00 6b 00 8a 00  81 00 3e 00 23 00 5b 00
N.E.k.....>.#.[.
    0010: 71 00 51 00 53 00 6a 00  69 00 4e 00 30 00 2d 00
q.Q.S.j.i.N.0.-.
    0020: 24 00 0c 00 22 00 38 00  2e 00 3a 00 44 00 42 00
$...".8...:.D.B.
> SCO data: handle 256 dlen 48
    0000: 36 00 21 00 28 00 38 00  30 00 22 00 24 00 3c 00
6.!.(.8.0.".$.<.
    0010: 4a 00 35 00 19 00 1b 00  32 00 43 00 31 00 1e 00
J.5.....2.C.1...
    0020: 28 00 39 00 4a 00 47 00  3b 00 3f 00 2f 00 39 00
(.9.J.G.;.?./.9.
> SCO data: handle 256 dlen 48
    0000: 69 00 63 00 25 00 03 00  28 00 4e 00 32 00 18 00
i.c.%...(.N.2...
    0010: 48 00 9f 00 86 00 2b 00  3f 00 7f 00 86 00 37 00
H.....+.?.....7.
    0020: 08 00 69 00 a0 00 8c 00  82 00 6f 00 a3 00 ba
00  ..i.......o.....
> SCO data: handle 256 dlen 48
    0000: 72 00 61 00 5c 00 6d 00  86 00 6b 00 83 00 8a 00
r.a.\.m...k.....
    0010: 61 00 75 00 9a 00 7e 00  34 00 1a 00 3c 00 81 00
a.u...~.4...<...
    0020: 8c 00 37 00 52 00 a8 00  83 00 21 00 f1 ff 41
00  ..7.R.....!...A.
> SCO data: handle 256 dlen 48
    0000: 88 00 58 00 44 00 6e 00  89 00 79 00 5b 00 6a
00  ..X.D.n...y.[.j.
    0010: 7a 00 54 00 45 00 55 00  57 00 4a 00 52 00 58 00
z.T.E.U.W.J.R.X.
    0020: 46 00 58 00 4c 00 44 00  56 00 30 00 21 00 21 00
F.X.L.D.V.0.!.!.
> SCO data: handle 256 dlen 48
    0000: 42 00 80 00 6c 00 48 00  56 00 79 00 6d 00 19 00
B...l.H.V.y.m...
    0010: 06 00 3e 00 50 00 51 00  47 00 61 00 89 00 5a
00  ..>.P.Q.G.a...Z.
    0020: 4c 00 4b 00 31 00 5d 00  74 00 80 00 83 00 4a 00
L.K.1.].t.....J.
> SCO data: handle 256 dlen 48
    0000: 47 00 3d 00 21 00 3e 00  42 00 4e 00 5a 00 40 00
G.=3D.!.>.B.N.Z.@.
    0010: 4b 00 44 00 45 00 66 00  44 00 2d 00 44 00 48 00
K.D.E.f.D.-.D.H.
    0020: 46 00 20 00 f8 ff 0f 00  2c 00 39 00 47 00 4b 00
F. .....,.9.G.K.
> SCO data: handle 256 dlen 48
    0000: 45 00 3b 00 3a 00 2e 00  16 00 19 00 32 00 3f 00
E.;.:.......2.?.
    0010: 36 00 24 00 17 00 16 00  24 00 2e 00 35 00 39 00
6.$.....$...5.9.
    0020: 29 00 34 00 3d 00 1a 00  1b 00 2d 00 2a 00 36
00  ).4.=3D.....-.*.6.
> SCO data: handle 256 dlen 48
    0000: 3e 00 4b 00 4e 00 3d 00  24 00 06 00 23 00 4d 00
>.K.N.=3D.$...#.M.
    0010: 47 00 52 00 5f 00 6d 00  73 00 34 00 18 00 2a 00
G.R._.m.s.4...*.
    0020: 29 00 36 00 30 00 2c 00  4d 00 44 00 22 00 46
00  ).6.0.,.M.D.".F.
> SCO data: handle 256 dlen 48
    0000: 64 00 34 00 38 00 4d 00  5d 00 7e 00 5f 00 4e 00
d.4.8.M.].~._.N.
    0010: 53 00 31 00 2c 00 48 00  4a 00 3e 00 46 00 32 00
S.1.,.H.J.>.F.2.
    0020: 25 00 34 00 2d 00 30 00  31 00 2b 00 3b 00 33 00
%.4.-.0.1.+.;.3.
> SCO data: handle 256 dlen 48
    0000: 21 00 22 00 1b 00 1c 00  28 00 26 00 2f 00 3b
00  !.".....(.&./.;.
    0010: 4a 00 72 00 64 00 1d 00  07 00 1d 00 22 00 18 00
J.r.d......."...
    0020: 3b 00 65 00 5b 00 40 00  36 00 40 00 4e 00 3e
00  ;.e.[.@.6.@.N.>.
> SCO data: handle 256 dlen 48
    0000: 19 00 21 00 2c 00 27 00  32 00 2d 00 33 00 45
00  ..!.,.'.2.-.3.E.
    0010: 3c 00 34 00 2c 00 1e 00  22 00 16 00 17 00 37 00
<.4.,...".....7.
    0020: 36 00 31 00 2e 00 2c 00  31 00 24 00 2a 00 27 00
6.1...,.1.$.*.'.
> SCO data: handle 256 dlen 48
    0000: 15 00 27 00 33 00 31 00  2e 00 1f 00 35 00 69
00  ..'.3.1.....5.i.
    0010: 6f 00 4f 00 27 00 22 00  3d 00 1f 00 f9 ff 14 00
o.O.'.".=3D.......
    0020: 51 00 76 00 71 00 6c 00  50 00 29 00 2b 00 37 00
Q.v.q.l.P.).+.7.
> SCO data: handle 256 dlen 48
    0000: 49 00 58 00 57 00 67 00  6a 00 54 00 3d 00 1b 00
I.X.W.g.j.T.=3D...
    0010: 10 00 26 00 40 00 56 00  50 00 55 00 61 00 40
00  ..&.@.V.P.U.a.@.
    0020: 35 00 47 00 38 00 26 00  2c 00 2f 00 32 00 2c 00
5.G.8.&.,./.2.,.
> SCO data: handle 256 dlen 48
    0000: 16 00 3c 00 75 00 4e 00  18 00 44 00 72 00 54
00  ..<.u.N...D.r.T.
    0010: 20 00 07 00 44 00 72 00  59 00 51 00 27 00 14
00   ...D.r.Y.Q.'...
    0020: 48 00 60 00 4c 00 40 00  64 00 79 00 45 00 1e 00
H.`.L.@.d.y.E...
> SCO data: handle 256 dlen 48
    0000: 27 00 19 00 36 00 77 00  57 00 38 00 50 00 64 00
'...6.w.W.8.P.d.
    0010: 75 00 3b 00 f8 ff 2c 00  40 00 19 00 1a 00 18 00
u.;...,.@.......
    0020: 4e 00 67 00 3c 00 45 00  38 00 34 00 3d 00 19 00
N.g.<.E.8.4.=3D...
> SCO data: handle 256 dlen 48
    0000: 1d 00 37 00 3f 00 46 00  3b 00 3d 00 48 00 33
00  ..7.?.F.;.=3D.H.3.
    0010: 21 00 2c 00 29 00 20 00  2b 00 2e 00 1e 00 0c
00  !.,.). .+.......
    0020: 15 00 36 00 3c 00 31 00  24 00 2b 00 3c 00 25
00  ..6.<.1.$.+.<.%.
> SCO data: handle 256 dlen 48
    0000: 06 00 06 00 35 00 6b 00  43 00 17 00 35 00 3b
00  ....5.k.C...5.;.
    0010: 2b 00 15 00 28 00 7b 00  98 00 80 00 55 00 13 00
+...(.{.....U...
    0020: 00 00 17 00 28 00 3a 00  35 00 32 00 5f 00 71
00  ....(.:.5.2._.q.
> SCO data: handle 256 dlen 48
    0000: 55 00 24 00 26 00 5b 00  49 00 0e 00 f1 ff 20 00
U.$.&.[.I..... .
    0010: 59 00 3d 00 22 00 3e 00  71 00 85 00 5f 00 1f 00
Y.=3D.".>.q..._...
    0020: fc ff 0b 00 2c 00 36 00  30 00 49 00 4c 00 3b
00  ....,.6.0.I.L.;.
> SCO data: handle 256 dlen 48
    0000: 3a 00 26 00 25 00 2f 00  2f 00 2a 00 15 00 15
00  :.&.%././.*.....
    0010: 36 00 45 00 26 00 1c 00  33 00 52 00 4f 00 fc ff
6.E.&...3.R.O...
    0020: e4 ff 20 00 46 00 5b 00  4d 00 3a 00 57 00 43
00  .. .F.[.M.:.W.C.
> SCO data: handle 256 dlen 48
    0000: 1b 00 0d 00 fc ff 1c 00  40 00 32 00 2e 00 31
00  ........@.2...1.
    0010: 31 00 2c 00 14 00 04 00  06 00 14 00 27 00 27 00
1.,.........'.'.
    0020: 13 00 09 00 22 00 3a 00  33 00 1f 00 21 00 2d
00  ....".:.3...!.-.
> SCO data: handle 256 dlen 48
    0000: 1d 00 02 00 fa ff 18 00  43 00 4d 00 52 00 4c
00  ........C.M.R.L.
    0010: 36 00 36 00 21 00 12 00  27 00 29 00 28 00 25 00
6.6.!...'.).(.%.
    0020: 1a 00 12 00 28 00 41 00  43 00 5c 00 50 00 1d
00  ....(.A.C.\.P...
> SCO data: handle 256 dlen 48
    0000: 22 00 05 00 d4 ff ee ff  1d 00 5a 00 6f 00 40 00
".........Z.o.@.
    0010: 3b 00 56 00 39 00 fc ff  0d 00 5d 00 76 00 5a
00  ;.V.9.....].v.Z.
    0020: 41 00 32 00 1c 00 0a 00  15 00 31 00 3c 00 57 00
A.2.......1.<.W.
> SCO data: handle 256 dlen 48
    0000: 75 00 53 00 0a 00 e1 ff  01 00 2d 00 37 00 51 00
u.S.......-.7.Q.
    0010: 59 00 48 00 4a 00 45 00  23 00 07 00 23 00 5a 00
Y.H.J.E.#...#.Z.
    0020: 56 00 18 00 1e 00 50 00  3b 00 1b 00 18 00 35 00
V.....P.;.....5.
> SCO data: handle 256 dlen 48
    0000: 4b 00 3c 00 3d 00 26 00  03 00 05 00 17 00 32 00
K.<.=3D.&.......2.
    0010: 37 00 2f 00 36 00 23 00  0b 00 15 00 18 00 18 00
7./.6.#.........
    0020: 26 00 2e 00 26 00 17 00  12 00 1a 00 1e 00 10 00
&...&...........
> SCO data: handle 256 dlen 48
    0000: 09 00 1e 00 2a 00 22 00  1f 00 2b 00 1f 00 0f
00  ....*."...+.....
    0010: 1c 00 2b 00 28 00 1d 00  1c 00 24 00 25 00 28
00  ..+.(.....$.%.(.
    0020: 35 00 37 00 24 00 13 00  13 00 20 00 16 00 1a 00
5.7.$..... .....
> SCO data: handle 256 dlen 48
    0000: 2e 00 24 00 29 00 33 00  28 00 18 00 11 00 1f
00  ..$.).3.(.......
    0010: 1e 00 09 00 10 00 32 00  39 00 2d 00 33 00 3a
00  ......2.9.-.3.:.
    0020: 33 00 20 00 11 00 0c 00  1f 00 45 00 62 00 6a 00
3. .......E.b.j.
> SCO data: handle 256 dlen 48
    0000: 61 00 5a 00 44 00 20 00  1e 00 31 00 31 00 26 00
a.Z.D. ...1.1.&.
    0010: 0f 00 1f 00 3a 00 31 00  42 00 55 00 4d 00 3f
00  ....:.1.B.U.M.?.
    0020: 27 00 23 00 18 00 fa ff  01 00 2f 00 4e 00 56 00
'.#......./.N.V.
> SCO data: handle 256 dlen 48
    0000: 67 00 65 00 55 00 3f 00  fe ff 08 00 47 00 4c 00
g.e.U.?.....G.L.
    0010: 4a 00 2c 00 1f 00 38 00  1a 00 0b 00 25 00 38 00
J.,...8.....%.8.
    0020: 3d 00 2f 00 23 00 18 00  05 00 fe ff 1b 00 4a 00
=3D./.#.........J.
> SCO data: handle 256 dlen 48
    0000: 68 00 6e 00 67 00 58 00  22 00 f0 ff 04 00 24 00
h.n.g.X.".....$.
    0010: 38 00 52 00 59 00 41 00  2b 00 1f 00 0a 00 11 00
8.R.Y.A.+.......
    0020: 1f 00 1d 00 25 00 20 00  10 00 18 00 26 00 1e
00  ....%. .....&...
> SCO data: handle 256 dlen 48
    0000: 2d 00 41 00 2b 00 24 00  1a 00 0c 00 19 00 26 00
-.A.+.$.......&.
    0010: 36 00 3f 00 3c 00 36 00  36 00 27 00 fd ff fa ff
6.?.<.6.6.'.....
    0020: 12 00 28 00 3d 00 2c 00  1b 00 24 00 2b 00 2a
00  ..(.=3D.,...$.+.*.
> SCO data: handle 256 dlen 48
    0000: 2e 00 27 00 1a 00 29 00  27 00 1d 00 1d 00 1a
00  ..'...).'.......
    0010: 3b 00 54 00 5c 00 64 00  26 00 0b 00 35 00 21
00  ;.T.\.d.&...5.!.
    0020: 27 00 53 00 52 00 59 00  36 00 fe ff 24 00 38 00
'.S.R.Y.6...$.8.
> SCO data: handle 256 dlen 48
    0000: 16 00 3a 00 4a 00 51 00  6f 00 32 00 23 00 43
00  ..:.J.Q.o.2.#.C.
    0010: 2b 00 32 00 38 00 26 00  2e 00 3a 00 33 00 2c 00
+.2.8.&...:.3.,.
    0020: 2c 00 38 00 52 00 43 00  2c 00 24 00 0c 00 0b
00  ,.8.R.C.,.$.....
> SCO data: handle 256 dlen 48
    0000: 22 00 2f 00 33 00 2d 00  2c 00 3b 00 2e 00 13 00
"./.3.-.,.;.....
    0010: 2b 00 29 00 1e 00 22 00  09 00 17 00 22 00 1a 00
+.)..."....."...
    0020: 2f 00 2c 00 31 00 3c 00  1e 00 0e 00 11 00 0b
00  /.,.1.<.........
> SCO data: handle 256 dlen 48
    0000: 17 00 30 00 55 00 70 00  5b 00 47 00 39 00 14
00  ..0.U.p.[.G.9...
    0010: 0e 00 14 00 27 00 4d 00  4c 00 37 00 2f 00 33
00  ....'.M.L.7./.3.
    0020: 33 00 2b 00 21 00 1c 00  24 00 1e 00 21 00 34 00
3.+.!...$...!.4.
> SCO data: handle 256 dlen 48
    0000: 23 00 1e 00 3d 00 35 00  2b 00 26 00 16 00 2f 00
#...=3D.5.+.&.../.
    0010: 1f 00 0a 00 2a 00 36 00  43 00 44 00 2f 00 2a
00  ....*.6.C.D./.*.
    0020: 2a 00 24 00 15 00 06 00  04 00 0e 00 1c 00 3a 00
*.$...........:.
> SCO data: handle 256 dlen 48
    0000: 4b 00 3b 00 48 00 52 00  49 00 44 00 2c 00 30 00
K.;.H.R.I.D.,.0.
    0010: 3d 00 3b 00 3d 00 38 00  28 00 2e 00 48 00 3c 00
=3D.;.=3D.8.(...H.<.
    0020: 36 00 43 00 3c 00 25 00  05 00 fc ff 0f 00 23 00
6.C.<.%.......#.
> SCO data: handle 256 dlen 48
    0000: 1b 00 1a 00 42 00 4d 00  34 00 33 00 33 00 37
00  ....B.M.4.3.3.7.
    0010: 46 00 33 00 32 00 4b 00  4c 00 52 00 40 00 2b 00
F.3.2.K.L.R.@.+.
    0020: 23 00 20 00 35 00 2c 00  21 00 1e 00 07 00 14 00
#. .5.,.!.......
> SCO data: handle 256 dlen 48
    0000: 23 00 23 00 2e 00 34 00  33 00 2f 00 21 00 11 00
#.#...4.3./.!...
    0010: 10 00 18 00 1d 00 33 00  44 00 42 00 2f 00 21
00  ......3.D.B./.!.
    0020: 29 00 23 00 12 00 15 00  2c 00 3c 00 32 00 20
00  ).#.....,.<.2. .
> SCO data: handle 256 dlen 48
    0000: 17 00 16 00 1a 00 28 00  1a 00 07 00 3c 00 68
00  ......(.....<.h.
    0010: 36 00 10 00 2f 00 45 00  56 00 60 00 78 00 81 00
6.../.E.V.`.x...
    0020: 3d 00 21 00 25 00 10 00  05 00 20 00 5e 00 5d 00
=3D.!.%..... .^.].
> SCO data: handle 256 dlen 48
    0000: 49 00 5e 00 51 00 33 00  14 00 10 00 24 00 18 00
I.^.Q.3.....$...
    0010: 42 00 68 00 3c 00 45 00  52 00 3a 00 37 00 44 00
B.h.<.E.R.:.7.D.
    0020: 62 00 63 00 49 00 3f 00  31 00 1d 00 2f 00 48 00
b.c.I.?.1.../.H.
> SCO data: handle 256 dlen 48
    0000: 41 00 28 00 18 00 24 00  28 00 33 00 35 00 26 00
A.(...$.(.3.5.&.
    0010: 43 00 47 00 2f 00 31 00  19 00 0a 00 12 00 16 00
C.G./.1.........
    0020: 33 00 43 00 2c 00 27 00  26 00 1b 00 22 00 20 00
3.C.,.'.&...". .
> SCO data: handle 256 dlen 48
    0000: 19 00 16 00 2c 00 64 00  47 00 06 00 2b 00 51
00  ....,.d.G...+.Q.
    0010: 2d 00 08 00 16 00 30 00  1d 00 29 00 59 00 3f 00
-.....0...).Y.?.
    0020: 1b 00 40 00 46 00 26 00  2c 00 2c 00 10 00 f9
ff  ..@.F.&.,.,.....
> SCO data: handle 256 dlen 48
    0000: 0d 00 52 00 65 00 42 00  47 00 5d 00 39 00 26
00  ..R.e.B.G.].9.&.
    0010: 55 00 52 00 1f 00 2c 00  68 00 52 00 1d 00 36 00
U.R...,.h.R...6.
    0020: 39 00 0f 00 06 00 12 00  2f 00 43 00 1e 00 15 00
9......./.C.....
> SCO data: handle 256 dlen 48
    0000: 36 00 46 00 3d 00 12 00  14 00 22 00 06 00 19 00
6.F.=3D.....".....
    0010: 28 00 23 00 46 00 4c 00  29 00 18 00 1f 00 2f 00
(.#.F.L.)...../.
    0020: 27 00 1c 00 25 00 1a 00  15 00 22 00 16 00 13 00
'...%.....".....
> SCO data: handle 256 dlen 48
    0000: 0b 00 fa ff 26 00 37 00  10 00 1c 00 31 00 23
00  ....&.7.....1.#.
    0010: fd ff 1e 00 64 00 26 00  fb ff 16 00 ff ff 30
00  ....d.&.......0.
    0020: 6f 00 5e 00 3d 00 23 00  40 00 49 00 29 00 17 00
o.^.=3D.#.@.I.)...
> SCO data: handle 256 dlen 48
    0000: 1d 00 66 00 6e 00 2c 00  28 00 2a 00 2c 00 28
00  ..f.n.,.(.*.,.(.
    0010: 1f 00 15 00 fe ff 40 00  70 00 3c 00 2b 00 3f
00  ......@.p.<.+.?.
    0020: 47 00 25 00 f8 ff 02 00  32 00 51 00 2f 00 1a 00
G.%.....2.Q./...
> SCO data: handle 256 dlen 48
    0000: 4f 00 5a 00 2d 00 18 00  1d 00 1d 00 15 00 20 00
O.Z.-......... .
    0010: 16 00 02 00 2f 00 6c 00  61 00 0d 00 ec ff 17
00  ..../.l.a.......
    0020: 17 00 06 00 15 00 26 00  44 00 51 00 4c 00 68
00  ......&.D.Q.L.h.
> SCO data: handle 256 dlen 48
    0000: 4e 00 0b 00 06 00 fd ff  05 00 1e 00 2e 00 4e 00
N.............N.
    0010: 29 00 11 00 1f 00 1b 00  2a 00 12 00 18 00 2e
00  ).......*.......
    0020: 22 00 3d 00 3e 00 23 00  1e 00 34 00 39 00 14 00
".=3D.>.#...4.9...
> SCO data: handle 256 dlen 48
    0000: 14 00 2c 00 21 00 10 00  19 00 2f 00 24 00 03
00  ..,.!...../.$...
    0010: 1f 00 45 00 10 00 e3 ff  05 00 23 00 1d 00 1b
00  ..E.......#.....
    0020: 33 00 37 00 32 00 33 00  0b 00 10 00 2d 00 18 00
3.7.2.3.....-...
> SCO data: handle 256 dlen 48
    0000: 18 00 1d 00 1b 00 26 00  17 00 05 00 16 00 27
00  ......&.......'.
    0010: 29 00 1f 00 16 00 26 00  1a 00 ff ff 06 00 04
00  ).....&.........
    0020: 05 00 0d 00 10 00 23 00  24 00 20 00 1c 00 0d
00  ......#.$. .....
> SCO data: handle 256 dlen 48
    0000: 1e 00 27 00 1a 00 18 00  1c 00 1b 00 10 00 1d
00  ..'.............
    0010: 2d 00 26 00 28 00 23 00  19 00 03 00 f3 ff 16 00
-.&.(.#.........
    0020: 2b 00 2e 00 38 00 1f 00  26 00 38 00 1b 00 fd ff
+...8...&.8.....
> SCO data: handle 256 dlen 48
    0000: f5 ff 0c 00 13 00 fb ff  18 00 59 00 66 00 4e
00  ..........Y.f.N.
    0010: 2e 00 1c 00 29 00 2e 00  1b 00 17 00 35 00 41
00  ....).......5.A.
    0020: 1f 00 45 00 6d 00 3f 00  39 00 31 00 fb ff e6
ff  ..E.m.?.9.1.....
> SCO data: handle 256 dlen 48
    0000: f7 ff 2b 00 41 00 3a 00  50 00 43 00 1f 00 20
00  ..+.A.:.P.C... .
    0010: 23 00 17 00 07 00 0d 00  22 00 0f 00 f9 ff 28 00
#.......".....(.
    0020: 5c 00 5d 00 46 00 23 00  2b 00 4d 00 42 00 14 00
\.].F.#.+.M.B...
> SCO data: handle 256 dlen 48
    0000: 03 00 2a 00 39 00 2c 00  2d 00 3a 00 35 00 21
00  ..*.9.,.-.:.5.!.
    0010: 1e 00 16 00 1d 00 32 00  27 00 07 00 0a 00 2b
00  ......2.'.....+.
    0020: 21 00 07 00 0a 00 1e 00  36 00 2f 00 13 00 fd
ff  !.......6./.....
> SCO data: handle 256 dlen 48
    0000: f9 ff 25 00 59 00 49 00  29 00 19 00 1b 00 47
00  ..%.Y.I.).....G.
    0010: 4a 00 25 00 24 00 1d 00  11 00 1c 00 29 00 25 00
J.%.$.......).%.
    0020: 21 00 31 00 1e 00 08 00  1e 00 29 00 1f 00 fd
ff  !.1.......).....
> SCO data: handle 256 dlen 48
    0000: 02 00 41 00 3a 00 14 00  31 00 48 00 5b 00 43
00  ..A.:...1.H.[.C.
    0010: f7 ff 08 00 2d 00 3c 00  62 00 5b 00 2b 00 0b
00  ....-.<.b.[.+...
    0020: 2b 00 42 00 26 00 2d 00  16 00 eb ff 08 00 38 00
+.B.&.-.......8.
> SCO data: handle 256 dlen 48
    0000: 33 00 10 00 2f 00 5a 00  35 00 12 00 13 00 1d 00
3.../.Z.5.......
    0010: 3c 00 3c 00 07 00 08 00  30 00 2f 00 18 00 0a 00
<.<.....0./.....
    0020: 1d 00 36 00 2c 00 19 00  0e 00 14 00 1d 00 17
00  ..6.,...........
> SCO data: handle 256 dlen 48
    0000: 0b 00 00 00 11 00 2a 00  2f 00 29 00 0a 00 fb
ff  ......*./.).....
    0010: 29 00 59 00 51 00 11 00  f4 ff 30 00 38 00 00
00  ).Y.Q.....0.8...
    0020: f4 ff 0c 00 60 00 80 00  fe ff d3 ff 38 00 5b
00  ....`.......8.[.
> SCO data: handle 256 dlen 48
    0000: 23 00 f2 ff 2a 00 66 00  6c 00 58 00 24 00 21 00
#...*.f.l.X.$.!.
    0010: 24 00 25 00 31 00 3b 00  54 00 42 00 42 00 44 00
$.%.1.;.T.B.B.D.
    0020: 2c 00 12 00 1a 00 42 00  1f 00 fb ff e7 ff fd
ff  ,.....B.........
> SCO data: handle 256 dlen 48
    0000: 72 00 65 00 fc ff 27 00  7d 00 84 00 16 00 a8 ff
r.e...'.}.......
    0010: 0b 00 63 00 2a 00 17 00  26 00 51 00 85 00 5e
00  ..c.*...&.Q...^.
    0020: 2f 00 29 00 0f 00 1f 00  2f 00 39 00 54 00 26
00  /.)...../.9.T.&.
> SCO data: handle 256 dlen 48
    0000: 2c 00 55 00 42 00 38 00  2e 00 44 00 51 00 1b
00  ,.U.B.8...D.Q...
    0010: d9 ff dd ff 3f 00 65 00  09 00 fc ff 6a 00 a1
00  ....?.e.....j...
    0020: 72 00 f0 ff d7 ff 4a 00  5e 00 39 00 1a 00 29 00
r.....J.^.9...).
> SCO data: handle 256 dlen 48
    0000: 5d 00 50 00 51 00 3a 00  16 00 3e 00 67 00 67
00  ].P.Q.:...>.g.g.
    0010: 2d 00 03 00 0e 00 16 00  3d 00 36 00 f7 ff 15 00
-.......=3D.6.....
    0020: 46 00 47 00 15 00 f9 ff  54 00 6a 00 17 00 fa ff
F.G.....T.j.....
> SCO data: handle 256 dlen 48
    0000: 34 00 81 00 6f 00 22 00  00 00 1b 00 56 00 3b 00
4...o.".....V.;.
    0010: fa ff 12 00 3e 00 5b 00  34 00 fe ff 2f 00 36
00  ....>.[.4.../.6.
    0020: 29 00 55 00 3d 00 19 00  23 00 3d 00 5a 00 35
00  ).U.=3D...#.=3D.Z.5.
> SCO data: handle 256 dlen 48
    0000: f8 ff 00 00 23 00 44 00  40 00 12 00 0d 00 2f
00  ....#.D.@...../.
    0010: 36 00 1f 00 17 00 3f 00  55 00 2a 00 04 00 12 00
6.....?.U.*.....
    0020: 22 00 13 00 0c 00 18 00  29 00 32 00 1b 00 ff ff
".......).2.....
> SCO data: handle 256 dlen 48
    0000: 06 00 15 00 14 00 0d 00  21 00 2e 00 1f 00 1e
00  ........!.......
    0010: 19 00 1a 00 1c 00 03 00  0a 00 22 00 1f 00 0f
00  ..........".....
    0020: 0a 00 22 00 26 00 12 00  14 00 27 00 35 00 27
00  ..".&.....'.5.'.
> SCO data: handle 256 dlen 48
    0000: 08 00 f9 ff 04 00 1f 00  22 00 18 00 25 00 30
00  ........"...%.0.
    0010: 18 00 ff ff 04 00 14 00  16 00 1c 00 34 00 28
00  ............4.(.
    0020: 07 00 18 00 26 00 27 00  30 00 05 00 f2 ff 36
00  ....&.'.0.....6.
> SCO data: handle 256 dlen 48
    0000: 52 00 31 00 07 00 0c 00  30 00 16 00 19 00 47 00
R.1.....0.....G.
    0010: 45 00 2d 00 1b 00 19 00  1e 00 26 00 34 00 2b 00
E.-.......&.4.+.
    0020: 21 00 1f 00 0e 00 0a 00  0c 00 10 00 21 00 2b
00  !...........!.+.
> SCO data: handle 256 dlen 48
    0000: 33 00 2c 00 1f 00 22 00  18 00 17 00 17 00 04 00
3.,...".........
    0010: fc ff 1b 00 66 00 6e 00  3f 00 3b 00 3c 00 4a
00  ....f.n.?.;.<.J.
    0020: 43 00 25 00 27 00 1e 00  2f 00 39 00 17 00 29 00
C.%.'.../.9...).
> SCO data: handle 256 dlen 48
    0000: 6d 00 6b 00 35 00 37 00  2e 00 2c 00 2d 00 2b 00
m.k.5.7...,.-.+.
    0010: 3c 00 28 00 3d 00 48 00  39 00 34 00 16 00 3d 00
<.(.=3D.H.9.4...=3D.
    0020: 43 00 10 00 08 00 0d 00  42 00 5c 00 36 00 26 00
C.......B.\.6.&.
> SCO data: handle 256 dlen 48
    0000: 1e 00 44 00 60 00 25 00  12 00 27 00 2e 00 27
00  ..D.`.%...'...'.
    0010: fc ff f8 ff 22 00 3a 00  3a 00 36 00 40 00 3e
00  ....".:.:.6.@.>.
    0020: 23 00 10 00 0b 00 14 00  24 00 23 00 27 00 1c 00
#.......$.#.'...
> SCO data: handle 256 dlen 48
    0000: 0c 00 1e 00 1d 00 15 00  08 00 fd ff 20 00 34
00  ............ .4.
    0010: 26 00 1b 00 13 00 2e 00  46 00 1a 00 f2 ff 10 00
&.......F.......
    0020: 2d 00 17 00 f2 ff f0 ff  2c 00 63 00 64 00 49 00
-.......,.c.d.I.
> SCO data: handle 256 dlen 48
    0000: 43 00 4f 00 2a 00 00 00  fc ff fe ff 0e 00 1b 00
C.O.*...........
    0010: 25 00 30 00 29 00 3a 00  3c 00 1d 00 2b 00 27 00
%.0.).:.<...+.'.
    0020: 15 00 32 00 2e 00 18 00  12 00 19 00 47 00 4f
00  ..2.........G.O.
> SCO data: handle 256 dlen 48
    0000: 36 00 26 00 19 00 16 00  ff ff e9 ff 08 00 32 00
6.&...........2.
    0010: 30 00 1c 00 20 00 37 00  49 00 2c 00 00 00 f4 ff
0... .7.I.,.....
    0020: 05 00 2b 00 26 00 11 00  28 00 3b 00 2e 00 21
00  ..+.&...(.;...!.
> SCO data: handle 256 dlen 48
    0000: 21 00 1e 00 10 00 0c 00  0f 00 06 00 12 00 26
00  !.............&.
    0010: 2b 00 30 00 1e 00 1e 00  25 00 0f 00 ff ff f4 ff
+.0.....%.......
    0020: fc ff 1a 00 26 00 2b 00  34 00 3f 00 3f 00 21
00  ....&.+.4.?.?.!.
> SCO data: handle 256 dlen 48
    0000: 0f 00 06 00 f8 ff 0f 00  13 00 0c 00 29 00 39
00  ............).9.
    0010: 37 00 1e 00 01 00 02 00  fc ff ff ff 0e 00 0b 00
7...............
    0020: 0e 00 1b 00 34 00 54 00  4a 00 32 00 40 00 2f
00  ....4.T.J.2.@./.
> SCO data: handle 256 dlen 48
    0000: 04 00 08 00 09 00 08 00  2c 00 58 00 56 00 2c
00  ........,.X.V.,.
    0010: 3b 00 4f 00 29 00 01 00  eb ff 17 00 2d 00 05
00  ;.O.).......-...
    0020: 1e 00 3a 00 39 00 3b 00  1f 00 07 00 05 00 15
00  ..:.9.;.........
> SCO data: handle 256 dlen 48
    0000: 3d 00 38 00 18 00 2f 00  40 00 31 00 2f 00 24 00
=3D.8.../.@.1./.$.
    0010: 31 00 33 00 0f 00 13 00  0e 00 fb ff 1c 00 34 00
1.3...........4.
    0020: 2f 00 18 00 12 00 35 00  31 00 fa ff f8 ff 1d
00  /.....5.1.......
> SCO data: handle 256 dlen 48
    0000: 2f 00 2d 00 30 00 3e 00  27 00 23 00 1c 00 ed
ff  /.-.0.>.'.#.....
    0010: 14 00 2e 00 17 00 1a 00  10 00 1a 00 27 00 21
00  ............'.!.
    0020: 1e 00 1e 00 20 00 12 00  03 00 16 00 22 00 02
00  .... ......."...
> SCO data: handle 256 dlen 48
    0000: 0b 00 2e 00 2c 00 1a 00  06 00 18 00 26 00 17
00  ....,.......&...
    0010: 15 00 0b 00 27 00 3a 00  24 00 36 00 26 00 17
00  ....'.:.$.6.&...
    0020: 2d 00 0b 00 0b 00 26 00  25 00 2f 00 08 00 12 00
-.....&.%./.....
> SCO data: handle 256 dlen 48
    0000: 54 00 40 00 1c 00 24 00  34 00 2b 00 1d 00 30 00
T.@...$.4.+...0.
    0010: 2e 00 15 00 1a 00 3a 00  41 00 31 00 25 00 35
00  ......:.A.1.%.5.
    0020: 39 00 1f 00 23 00 0a 00  02 00 2b 00 31 00 21 00
9...#.....+.1.!.
> SCO data: handle 256 dlen 48
    0000: 13 00 25 00 38 00 1c 00  01 00 01 00 0a 00 07
00  ..%.8...........
    0010: fa ff 05 00 20 00 25 00  34 00 35 00 25 00 30
00  .... .%.4.5.%.0.
    0020: 2b 00 18 00 05 00 f2 ff  05 00 14 00 12 00 27 00
+.............'.
> SCO data: handle 256 dlen 48
    0000: 2d 00 29 00 32 00 1e 00  08 00 fd ff f9 ff 14 00
-.).2...........
    0010: 1c 00 25 00 37 00 31 00  39 00 25 00 04 00 12
00  ..%.7.1.9.%.....
    0020: 10 00 0c 00 0c 00 05 00  21 00 30 00 30 00 42
00  ........!.0.0.B.
> SCO data: handle 256 dlen 48
    0000: 39 00 1f 00 10 00 0d 00  1e 00 1b 00 19 00 2e 00
9...............
    0010: 41 00 66 00 78 00 51 00  32 00 02 00 cc ff d7 ff
A.f.x.Q.2.......
    0020: fc ff 19 00 21 00 1e 00  2b 00 3a 00 3e 00 30
00  ....!...+.:.>.0.
> SCO data: handle 256 dlen 48
    0000: 20 00 19 00 2c 00 3b 00  2e 00 23 00 27 00 3a
00   ...,.;...#.'.:.
    0010: 3c 00 30 00 2b 00 1c 00  15 00 0a 00 11 00 1e 00
<.0.+...........
    0020: 1b 00 24 00 2d 00 30 00  2a 00 16 00 0e 00 14
00  ..$.-.0.*.......
> SCO data: handle 256 dlen 48
    0000: 12 00 17 00 19 00 17 00  2b 00 29 00 28 00 36
00  ........+.).(.6.
    0010: 32 00 30 00 28 00 26 00  39 00 36 00 23 00 25 00
2.0.(.&.9.6.#.%.
    0020: 1d 00 14 00 2e 00 2e 00  28 00 3b 00 42 00 2f
00  ........(.;.B./.
> SCO data: handle 256 dlen 48
    0000: 14 00 21 00 36 00 33 00  26 00 28 00 37 00 36
00  ..!.6.3.&.(.7.6.
    0010: 39 00 40 00 22 00 fe ff  0a 00 1b 00 12 00 1d 00
9.@."...........
    0020: 3a 00 5c 00 7c 00 96 00  82 00 47 00 42 00 26
00  :.\.|.....G.B.&.
> SCO data: handle 256 dlen 48
    0000: fc ff 11 00 18 00 3c 00  3d 00 2f 00 6d 00 72
00  ......<.=3D./.m.r.
    0010: 4b 00 31 00 25 00 1d 00  fb ff 13 00 22 00 2f 00
K.1.%......."./.
    0020: 9a 00 ac 00 68 00 6f 00  67 00 43 00 2d 00 0d
00  ....h.o.g.C.-...
> SCO data: handle 256 dlen 48
    0000: 1d 00 2d 00 21 00 45 00  59 00 52 00 50 00 36
00  ..-.!.E.Y.R.P.6.
    0010: 2e 00 3d 00 53 00 42 00  31 00 6c 00 6d 00 4f
00  ..=3D.S.B.1.l.m.O.
    0020: 66 00 54 00 51 00 4d 00  09 00 04 00 26 00 25 00
f.T.Q.M.....&.%.
> SCO data: handle 256 dlen 48
    0000: 2b 00 30 00 4d 00 55 00  34 00 34 00 16 00 04 00
+.0.M.U.4.4.....
    0010: 1d 00 18 00 2b 00 35 00  26 00 3c 00 3c 00 37
00  ....+.5.&.<.<.7.
    0020: 44 00 32 00 29 00 2f 00  2d 00 35 00 2f 00 2b 00
D.2.)./.-.5./.+.
> SCO data: handle 256 dlen 48
    0000: 24 00 22 00 34 00 1a 00  08 00 19 00 08 00 04 00
$.".4...........
    0010: 11 00 01 00 0c 00 2a 00  37 00 3a 00 28 00 25
00  ......*.7.:.(.%.
    0020: 2d 00 15 00 13 00 1f 00  13 00 11 00 15 00 27 00
-.............'.
> SCO data: handle 256 dlen 48
    0000: 1c 00 05 00 3f 00 4d 00  40 00 59 00 25 00 30
00  ....?.M.@.Y.%.0.
    0010: 71 00 37 00 21 00 39 00  25 00 3b 00 27 00 0b 00
q.7.!.9.%.;.'...
    0020: 2a 00 1f 00 1d 00 0c 00  12 00 51 00 3a 00 2f 00
*.........Q.:./.
> SCO data: handle 256 dlen 48
    0000: 30 00 17 00 37 00 1c 00  03 00 29 00 0a 00 0d 00
0...7.....).....
    0010: 42 00 39 00 31 00 39 00  43 00 4d 00 3e 00 2c 00
B.9.1.9.C.M.>.,.
    0020: 15 00 13 00 25 00 12 00  09 00 0a 00 0e 00 2e
00  ....%...........
> SCO data: handle 256 dlen 48
    0000: 1f 00 11 00 2b 00 17 00  06 00 0d 00 ff ff 11
00  ....+...........
    0010: 24 00 21 00 2a 00 26 00  3a 00 3c 00 16 00 1e 00
$.!.*.&.:.<.....
    0020: 08 00 0d 00 42 00 29 00  2f 00 47 00 3c 00 57
00  ....B.)./.G.<.W.
> SCO data: handle 256 dlen 48
    0000: 42 00 17 00 27 00 1e 00  06 00 fe ff 00 00 12 00
B...'...........
    0010: 1c 00 26 00 23 00 1e 00  2c 00 15 00 0b 00 1c
00  ..&.#...,.......
    0020: 12 00 28 00 34 00 23 00  46 00 51 00 35 00 31
00  ..(.4.#.F.Q.5.1.
> SCO data: handle 256 dlen 48
    0000: 11 00 03 00 10 00 14 00  29 00 1c 00 1c 00 37
00  ........).....7.
    0010: 32 00 39 00 1a 00 07 00  18 00 04 00 09 00 1b 00
2.9.............
    0020: 0b 00 13 00 22 00 25 00  46 00 42 00 24 00 26
00  ....".%.F.B.$.&.
> SCO data: handle 256 dlen 48
    0000: 1a 00 1a 00 09 00 0a 00  37 00 1c 00 13 00 35
00  ........7.....5.
    0010: 2b 00 29 00 1b 00 0f 00  2d 00 27 00 10 00 18 00
+.).....-.'.....
    0020: 16 00 23 00 35 00 1e 00  15 00 2f 00 2f 00 0e
00  ..#.5....././...
> SCO data: handle 256 dlen 48
    0000: fe ff 0e 00 07 00 fc ff  03 00 0f 00 35 00 44
00  ............5.D.
    0010: 46 00 60 00 4f 00 2f 00  1a 00 06 00 18 00 21 00
F.`.O./.......!.
    0020: 1d 00 1c 00 0d 00 18 00  1e 00 0e 00 15 00 0f
00  ................
> SCO data: handle 256 dlen 48
    0000: 04 00 0b 00 09 00 2f 00  46 00 32 00 42 00 40
00  ....../.F.2.B.@.
    0010: 35 00 29 00 ff ff 12 00  19 00 f9 ff 00 00 0c 00
5.).............
    0020: 34 00 42 00 2a 00 3b 00  36 00 26 00 27 00 10 00
4.B.*.;.6.&.'...
> SCO data: handle 256 dlen 48
    0000: 06 00 0c 00 ff ff 0f 00  25 00 1d 00 23 00 1a
00  ........%...#...
    0010: 0f 00 0c 00 00 00 05 00  03 00 13 00 1f 00 11
00  ................
    0020: 22 00 34 00 24 00 16 00  11 00 12 00 14 00 12 00
".4.$...........
> SCO data: handle 256 dlen 48
    0000: 15 00 1c 00 2b 00 34 00  34 00 38 00 27 00 21
00  ....+.4.4.8.'.!.
    0010: 2e 00 18 00 13 00 1f 00  08 00 09 00 1a 00 0d
00  ................
    0020: 17 00 10 00 fd ff 0b 00  0c 00 1f 00 2d 00 23
00  ............-.#.
> SCO data: handle 256 dlen 48
    0000: 34 00 2b 00 1e 00 28 00  21 00 13 00 09 00 10 00
4.+...(.!.......
    0010: 17 00 12 00 1d 00 2f 00  44 00 51 00 45 00 32
00  ....../.D.Q.E.2.
    0020: 1c 00 25 00 48 00 34 00  0a 00 1e 00 3f 00 33
00  ..%.H.4.....?.3.
> SCO data: handle 256 dlen 48
    0000: 1f 00 23 00 4b 00 4e 00  1e 00 10 00 08 00 07
00  ..#.K.N.........
    0010: 1a 00 0e 00 05 00 10 00  1b 00 2a 00 39 00 2e
00  ..........*.9...
    0020: 2b 00 34 00 25 00 15 00  18 00 2d 00 3c 00 49 00
+.4.%.....-.<.I.
> SCO data: handle 256 dlen 48
    0000: 3b 00 22 00 1b 00 18 00  36 00 22 00 10 00 1e
00  ;.".....6.".....
    0010: 0d 00 37 00 3a 00 23 00  3e 00 2b 00 25 00 26
00  ..7.:.#.>.+.%.&.
    0020: 19 00 2a 00 29 00 1e 00  0d 00 02 00 14 00 1d
00  ..*.)...........
> SCO data: handle 256 dlen 48
    0000: 28 00 26 00 17 00 3e 00  51 00 12 00 f3 ff 10 00
(.&...>.Q.......
    0010: 35 00 4f 00 3d 00 1e 00  28 00 40 00 3e 00 28 00
5.O.=3D...(.@.>.(.
    0020: 22 00 1a 00 13 00 1d 00  32 00 2b 00 08 00 09 00
".......2.+.....
> SCO data: handle 256 dlen 48
    0000: 25 00 34 00 11 00 fc ff  19 00 18 00 21 00 17 00
%.4.........!...
    0010: 0f 00 48 00 5b 00 49 00  35 00 35 00 4f 00 33
00  ..H.[.I.5.5.O.3.
    0020: 07 00 f5 ff f2 ff 07 00  08 00 05 00 0c 00 12
00  ................
> SCO data: handle 256 dlen 48
    0000: 35 00 35 00 18 00 11 00  0d 00 2c 00 41 00 4b 00
5.5.......,.A.K.
    0010: 44 00 15 00 27 00 5e 00  51 00 13 00 fb ff 1a 00
D...'.^.Q.......
    0020: 29 00 0a 00 ea ff 10 00  28 00 09 00 0e 00 12
00  ).......(.......
> SCO data: handle 256 dlen 48
    0000: 1e 00 4a 00 36 00 1f 00  17 00 03 00 21 00 18
00  ..J.6.......!...
    0010: 09 00 16 00 0c 00 2e 00  2a 00 15 00 22 00 10
00  ........*..."...
    0020: 1b 00 1f 00 15 00 11 00  00 00 16 00 25 00 21
00  ............%.!.
> SCO data: handle 256 dlen 48
    0000: 18 00 27 00 57 00 2e 00  0c 00 31 00 31 00 46
00  ..'.W.....1.1.F.
    0010: 2b 00 ef ff 27 00 33 00  29 00 42 00 04 00 e7 ff
+...'.3.).B.....
    0020: f6 ff 05 00 2f 00 0f 00  ff ff 33 00 57 00 64
00  ..../.....3.W.d.
> SCO data: handle 256 dlen 48
    0000: 46 00 2d 00 30 00 2c 00  22 00 1f 00 19 00 16 00
F.-.0.,.".......
    0010: 26 00 13 00 25 00 3e 00  2b 00 3c 00 f7 ff c8 ff
&...%.>.+.<.....
    0020: f9 ff 0a 00 2c 00 fc ff  d8 ff 22 00 2a 00 40
00  ....,.....".*.@.
> SCO data: handle 256 dlen 48
    0000: 57 00 24 00 00 00 04 00  31 00 2a 00 05 00 14 00
W.$.....1.*.....
    0010: 38 00 6d 00 72 00 4b 00  4b 00 46 00 3c 00 27 00
8.m.r.K.K.F.<.'.
    0020: f4 ff 1d 00 3f 00 1c 00  24 00 20 00 33 00 37
00  ....?...$. .3.7.
> SCO data: handle 256 dlen 48
    0000: 13 00 0d 00 e5 ff 00 00  2e 00 25 00 34 00 17
00  ..........%.4...
    0010: 19 00 33 00 20 00 2a 00  08 00 de ff f8 ff 10
00  ..3. .*.........
    0020: 2a 00 1d 00 0d 00 39 00  47 00 27 00 f2 ff fe ff
*.....9.G.'.....
> SCO data: handle 256 dlen 48
    0000: 1d 00 0d 00 17 00 0c 00  1d 00 41 00 27 00 44
00  ..........A.'.D.
    0010: 44 00 34 00 37 00 06 00  18 00 f1 ff d3 ff 1b 00
D.4.7...........
    0020: 16 00 46 00 38 00 fe ff  52 00 4d 00 41 00 2c
00  ..F.8...R.M.A.,.
> SCO data: handle 256 dlen 48
    0000: ea ff 05 00 09 00 18 00  1a 00 01 00 21 00 27
00  ............!.'.
    0010: 2f 00 2c 00 21 00 29 00  1f 00 27 00 11 00 11
00  /.,.!.)...'.....
    0020: 32 00 21 00 34 00 2c 00  00 00 0f 00 18 00 1a 00
2.!.4.,.........
> SCO data: handle 256 dlen 48
    0000: 04 00 e7 ff 03 00 28 00  41 00 25 00 0e 00 23
00  ......(.A.%...#.
    0010: 1b 00 34 00 26 00 f5 ff  0a 00 11 00 1f 00 23
00  ..4.&.........#.
    0020: fc ff 0b 00 22 00 1f 00  1c 00 12 00 10 00 0d
00  ...."...........
> SCO data: handle 256 dlen 48
    0000: 10 00 16 00 11 00 19 00  23 00 17 00 10 00 0f
00  ........#.......
    0010: 0e 00 17 00 0c 00 f1 ff  e8 ff 06 00 3c 00 5a
00  ............<.Z.
    0020: 46 00 24 00 22 00 29 00  3b 00 2c 00 f6 ff 07 00
F.$.".).;.,.....
> SCO data: handle 256 dlen 48
    0000: 21 00 28 00 34 00 0a 00  0d 00 2d 00 0f 00 0f
00  !.(.4.....-.....
    0010: 19 00 04 00 1c 00 19 00  0b 00 1c 00 0d 00 15
00  ................
    0020: 26 00 0e 00 10 00 16 00  13 00 23 00 11 00 03 00
&.........#.....
> SCO data: handle 256 dlen 48
    0000: 1c 00 3a 00 4c 00 25 00  0a 00 16 00 13 00 33
00  ..:.L.%.......3.
    0010: 20 00 e2 ff f2 ff 02 00  21 00 2f 00 da ff f4
ff   .......!./.....
    0020: 53 00 46 00 48 00 05 00  da ff 29 00 10 00 34 00
S.F.H.....)...4.
> SCO data: handle 256 dlen 48
    0000: 57 00 0d 00 60 00 85 00  2d 00 11 00 fa ff 24 00
W...`...-.....$.
    0010: 5f 00 2d 00 05 00 23 00  3e 00 4f 00 2e 00 ff ff
_.-...#.>.O.....
    0020: 29 00 3b 00 33 00 3f 00  07 00 fe ff 24 00 22
00  ).;.3.?.....$.".
> SCO data: handle 256 dlen 48
    0000: 2d 00 fc ff e5 ff 29 00  26 00 1a 00 1d 00 0b 00
-.....).&.......
    0010: 27 00 30 00 1c 00 19 00  17 00 25 00 2e 00 11 00
'.0.......%.....
    0020: f2 ff fc ff 31 00 40 00  05 00 f1 ff 33 00 5e
00  ....1.@.....3.^.
> SCO data: handle 256 dlen 48
    0000: 3e 00 0e 00 e6 ff 19 00  54 00 1c 00 2e 00 24 00
>.......T.....$.
    0010: ff ff 4c 00 38 00 17 00  24 00 f2 ff 0c 00 38
00  ..L.8...$.....8.
    0020: 10 00 10 00 24 00 20 00  3b 00 37 00 26 00 2e
00  ....$. .;.7.&...
> SCO data: handle 256 dlen 48
    0000: 3c 00 31 00 01 00 f8 ff  fc ff 31 00 38 00 c6 ff
<.1.......1.8...
    0010: ee ff 5e 00 5f 00 34 00  ff ff fd ff 3c 00 56
00  ..^._.4.....<.V.
    0020: 17 00 19 00 26 00 1c 00  73 00 50 00 fa ff 15
00  ....&...s.P.....
> SCO data: handle 256 dlen 48
    0000: 09 00 35 00 53 00 1d 00  30 00 29 00 34 00 4d
00  ..5.S...0.).4.M.
    0010: 12 00 19 00 1e 00 21 00  28 00 ef ff ed ff 04
00  ......!.(.......
    0020: 3f 00 3a 00 fe ff 58 00  82 00 60 00 35 00 f5
ff  ?.:...X...`.5...
> SCO data: handle 256 dlen 48
    0000: 0e 00 25 00 25 00 25 00  14 00 16 00 23 00 3e
00  ..%.%.%.....#.>.
    0010: 29 00 f3 ff f2 ff 00 00  0f 00 07 00 fe ff 21
00  ).............!.
    0020: 2f 00 29 00 32 00 26 00  1f 00 29 00 17 00 f8
ff  /.).2.&...).....
> SCO data: handle 256 dlen 48
    0000: f0 ff 04 00 47 00 65 00  00 00 e0 ff 5d 00 8a
00  ....G.e.....]...
    0010: 3d 00 f1 ff d4 ff f6 ff  2e 00 32 00 19 00 1b 00
=3D.........2.....
    0020: 0c 00 2b 00 83 00 4a 00  02 00 33 00 36 00 35
00  ..+...J...3.6.5.
> SCO data: handle 256 dlen 48
    0000: 1f 00 06 00 52 00 6b 00  49 00 27 00 ff ff 33
00  ....R.k.I.'...3.
    0010: 64 00 10 00 e0 ff d2 ff  f0 ff 93 00 53 00 e7 ff
d...........S...
    0020: 62 00 77 00 53 00 18 00  b8 ff dd ff 18 00 39 00
b.w.S.........9.
> SCO data: handle 256 dlen 48
    0000: 6d 00 42 00 19 00 69 00  90 00 79 00 3b 00 fb ff
m.B...i...y.;...
    0010: 12 00 39 00 18 00 e3 ff  18 00 5f 00 7d 00 68
00  ..9......._.}.h.
    0020: 13 00 08 00 4e 00 62 00  fc ff cb ff f2 ff 49
00  ....N.b.......I.
> SCO data: handle 256 dlen 48
    0000: b2 00 2a 00 e2 ff 61 00  6a 00 54 00 0d 00 b3
ff  ..*...a.j.T.....
    0010: e1 ff 3a 00 38 00 44 00  4e 00 2f 00 a4 00 9b
00  ..:.8.D.N./.....
    0020: 0b 00 32 00 13 00 28 00  a6 00 18 00 f2 ff 37
00  ..2...(.......7.
> SCO data: handle 256 dlen 48
    0000: fe ff 73 00 7c 00 16 00  4b 00 43 00 3e 00 21
00  ..s.|...K.C.>.!.
    0010: c8 ff 0e 00 9a 00 6a 00  ce ff e2 ff 40 00 6d
00  ......j.....@.m.
    0020: 56 00 e8 ff e1 ff 34 00  4c 00 21 00 31 00 79 00
V.....4.L.!.1.y.
> SCO data: handle 256 dlen 48
    0000: 94 00 bf 00 44 00 c1 ff  18 00 ed ff 07 00 69
00  ....D.........i.
    0010: 0c 00 37 00 33 00 fb ff  7f 00 38 00 09 00 81
00  ..7.3.....8.....
    0020: 42 00 31 00 ff ff b7 ff  4a 00 8b 00 68 00 47 00
B.1.....J...h.G.
> SCO data: handle 256 dlen 48
    0000: 5a 00 89 00 43 00 32 00  fe ff 03 00 79 00 03 00
Z...C.2.....y...
    0010: e4 ff 61 00 65 00 a2 00  74 00 c2 ff f2 ff 14
00  ..a.e...t.......
    0020: e8 ff 43 00 23 00 f4 ff  3e 00 18 00 52 00 83
00  ..C.#...>...R...
> SCO data: handle 256 dlen 48
    0000: 26 00 6f 00 8d 00 57 00  38 00 c0 ff ee ff 5b 00
&.o...W.8.....[.
    0010: 41 00 40 00 44 00 7c 00  80 00 0f 00 ef ff e7 ff
A.@.D.|.........
    0020: 1c 00 6a 00 07 00 0b 00  82 00 6e 00 9a 00 52
00  ..j.......n...R.
> SCO data: handle 256 dlen 48
    0000: a6 ff 26 00 40 00 4c 00  a3 00 e9 ff 00 00 6e
00  ..&.@.L.......n.
    0010: 4c 00 82 00 ea ff cd ff  ae 00 6a 00 02 00 f5 ff
L.........j.....
    0020: ec ff 9b 00 84 00 ef ff  2f 00 49 00 58 00 2a
00  ......../.I.X.*.
> SCO data: handle 256 dlen 48
    0000: cd ff dc ff dc ff 2f 00  62 00 3a 00 85 00 b5
00  ....../.b.:.....
    0010: be 00 b6 00 30 00 00 00  39 00 34 00 77 00 55
00  ....0...9.4.w.U.
    0020: e1 ff 4a 00 85 00 86 00  63 00 ce ff 2a 00 86
00  ..J.....c...*...
> SCO data: handle 256 dlen 48
    0000: 4b 00 04 00 b8 ff 59 00  ad 00 34 00 28 00 2d 00
K.....Y...4.(.-.
    0010: 52 00 6e 00 04 00 eb ff  22 00 0b 00 4e 00 7e 00
R.n....."...N.~.
    0020: 32 00 7c 00 a4 00 66 00  3a 00 db ff e6 ff 1b 00
2.|...f.:.......
> SCO data: handle 256 dlen 48
    0000: 45 00 55 00 09 00 31 00  63 00 69 00 80 00 e8 ff
E.U...1.c.i.....
    0010: d6 ff 7d 00 60 00 43 00  18 00 f7 ff a3 00 7d
00  ..}.`.C.......}.
    0020: 1b 00 4c 00 33 00 4a 00  21 00 ef ff 1e 00 24
00  ..L.3.J.!.....$.
> SCO data: handle 256 dlen 48
    0000: 24 00 12 00 29 00 6f 00  a8 00 99 00 58 00 1e 00
$...).o.....X...
    0010: f4 ff 28 00 42 00 48 00  29 00 d8 ff 3f 00 98
00  ..(.B.H.)...?...
    0020: 9b 00 74 00 e5 ff 2f 00  a3 00 3a 00 03 00 fa
ff  ..t.../...:.....
> SCO data: handle 256 dlen 48
    0000: 44 00 b4 00 3b 00 03 00  52 00 4d 00 4a 00 f4 ff
D...;...R.M.J...
    0010: f1 ff 4b 00 2b 00 0e 00  e1 ff 45 00 ba 00 57
00  ..K.+.....E...W.
    0020: 52 00 4e 00 10 00 35 00  17 00 3c 00 87 00 ff ff
R.N...5...<.....
> SCO data: handle 256 dlen 48
    0000: 06 00 77 00 7b 00 93 00  20 00 0a 00 78 00 50
00  ..w.{... ...x.P.
    0010: 37 00 35 00 3a 00 81 00  62 00 d6 ff 0f 00 9b 00
7.5.:...b.......
    0020: 63 00 20 00 dc ff e9 ff  56 00 0c 00 df ff 33 00
c. .....V.....3.
> SCO data: handle 256 dlen 48
    0000: 69 00 8a 00 56 00 2b 00  36 00 35 00 4b 00 1c 00
i...V.+.6.5.K...
    0010: 16 00 3b 00 24 00 64 00  68 00 38 00 3d 00 f4
ff  ..;.$.d.h.8.=3D...
    0020: 15 00 69 00 3b 00 3c 00  5b 00 3c 00 25 00 f9
ff  ..i.;.<.[.<.%...
> SCO data: handle 256 dlen 48
    0000: e2 ff 2b 00 50 00 34 00  09 00 f5 ff 33 00 3f
00  ..+.P.4.....3.?.
    0010: 08 00 09 00 2a 00 55 00  57 00 23 00 12 00 1d
00  ....*.U.W.#.....
    0020: 42 00 57 00 2d 00 29 00  1c 00 28 00 64 00 20 00
B.W.-.)...(.d. .
> SCO data: handle 256 dlen 48
    0000: 12 00 43 00 0e 00 14 00  19 00 09 00 43 00 3a
00  ..C.........C.:.
    0010: 2d 00 2d 00 f0 ff 07 00  37 00 44 00 55 00 2d 00
-.-.....7.D.U.-.
    0020: 18 00 23 00 1b 00 1a 00  11 00 45 00 5d 00 3f
00  ..#.......E.].?.
> SCO data: handle 256 dlen 48
    0000: 52 00 1a 00 0b 00 45 00  13 00 03 00 02 00 f4 ff
R.....E.........
    0010: 36 00 2d 00 18 00 30 00  16 00 29 00 3f 00 32 00
6.-...0...).?.2.
    0020: 42 00 41 00 3e 00 1a 00  ed ff ff ff 0c 00 28 00
B.A.>.........(.
> SCO data: handle 256 dlen 48
    0000: 36 00 1e 00 1c 00 12 00  0b 00 0b 00 04 00 0c 00
6...............
    0010: 2d 00 1f 00 06 00 2f 00  23 00 20 00 3a 00 11 00
-...../.#. .:...
    0020: 15 00 18 00 19 00 2c 00  11 00 21 00 21 00 0e
00  ......,...!.!...
> SCO data: handle 256 dlen 48
    0000: 25 00 27 00 2d 00 28 00  15 00 1b 00 0b 00 fa ff
%.'.-.(.........
    0010: 0c 00 1e 00 23 00 1a 00  1a 00 19 00 04 00 0b
00  ....#...........
    0020: 09 00 02 00 18 00 0f 00  13 00 28 00 1b 00 19
00  ..........(.....
> SCO data: handle 256 dlen 48
    0000: 13 00 08 00 15 00 19 00  25 00 31 00 1a 00 16
00  ........%.1.....
    0010: 1a 00 0a 00 08 00 18 00  25 00 20 00 0d 00 08
00  ........%. .....
    0020: 05 00 04 00 07 00 2b 00  53 00 31 00 1e 00 30
00  ......+.S.1...0.
> SCO data: handle 256 dlen 48
    0000: 1c 00 18 00 2e 00 16 00  fa ff 17 00 19 00 27
00  ..............'.
    0010: 35 00 14 00 30 00 24 00  0d 00 2f 00 1b 00 2c 00
5...0.$.../...,.
    0020: 2b 00 ff ff 1b 00 0b 00  08 00 28 00 16 00 3c 00
+.........(...<.
> SCO data: handle 256 dlen 48
    0000: 37 00 15 00 27 00 0a 00  fb ff 0d 00 2a 00 38 00
7...'.......*.8.
    0010: 20 00 28 00 31 00 1d 00  1b 00 0e 00 f8 ff 17
00   .(.1...........
    0020: 22 00 1f 00 2e 00 15 00  29 00 2c 00 fb ff 10 00
".......).,.....
> SCO data: handle 256 dlen 48
    0000: 10 00 0a 00 2b 00 14 00  1f 00 49 00 1b 00 ff
ff  ....+.....I.....
    0010: 0d 00 07 00 01 00 f7 ff  07 00 12 00 10 00 1e
00  ................
    0020: 24 00 2e 00 30 00 26 00  2b 00 29 00 16 00 0c 00
$...0.&.+.).....
> SCO data: handle 256 dlen 48
    0000: 03 00 0d 00 24 00 16 00  1b 00 13 00 06 00 19
00  ....$...........
    0010: f7 ff f0 ff 0f 00 0e 00  26 00 24 00 13 00 23
00  ........&.$...#.
    0020: 28 00 2d 00 17 00 18 00  30 00 08 00 11 00 1c 00
(.-.....0.......
> SCO data: handle 256 dlen 48
    0000: 09 00 37 00 23 00 3a 00  60 00 26 00 43 00 37
00  ..7.#.:.`.&.C.7.
    0010: 15 00 3b 00 0e 00 0d 00  3a 00 0f 00 0b 00 37
00  ..;.....:.....7.
    0020: 3f 00 49 00 28 00 e5 ff  e3 ff 05 00 32 00 52
00  ?.I.(.......2.R.
> SCO data: handle 256 dlen 48
    0000: 39 00 14 00 1f 00 57 00  4d 00 13 00 05 00 fb ff
9.....W.M.......
    0010: 13 00 19 00 ff ff 16 00  18 00 37 00 74 00 59
00  ..........7.t.Y.
    0020: 27 00 11 00 02 00 e7 ff  f6 ff 10 00 15 00 2d 00
'.............-.
> SCO data: handle 256 dlen 48
    0000: 20 00 23 00 36 00 36 00  34 00 0b 00 04 00 0d
00   .#.6.6.4.......
    0010: 13 00 32 00 25 00 13 00  1a 00 1b 00 22 00 1b
00  ..2.%......."...
    0020: f6 ff fb ff 14 00 0e 00  11 00 17 00 16 00 27
00  ..............'.
> SCO data: handle 256 dlen 48
    0000: 3c 00 41 00 29 00 0f 00  18 00 16 00 fd ff ff ff
<.A.)...........
    0010: 09 00 17 00 23 00 15 00  1c 00 25 00 20 00 17
00  ....#.....%. ...
    0020: fe ff 08 00 1a 00 22 00  2e 00 19 00 30 00 4f
00  ......".....0.O.
> SCO data: handle 256 dlen 48
    0000: 4a 00 55 00 19 00 ea ff  00 00 fb ff 05 00 04 00
J.U.............
    0010: 00 00 2f 00 55 00 65 00  47 00 3e 00 46 00 31
00  ../.U.e.G.>.F.1.
    0020: 42 00 0e 00 e6 ff 2e 00  47 00 4c 00 47 00 38 00
B.......G.L.G.8.
> SCO data: handle 256 dlen 48
    0000: 32 00 1b 00 00 00 da ff  f6 ff 23 00 29 00 25 00
2.........#.).%.
    0010: 0c 00 37 00 61 00 4a 00  3e 00 1a 00 0c 00 22
00  ..7.a.J.>.....".
    0020: 0f 00 09 00 00 00 fc ff  25 00 48 00 42 00 1a
00  ........%.H.B...
> SCO data: handle 256 dlen 48
    0000: 1f 00 25 00 15 00 15 00  fa ff 03 00 26 00 45
00  ..%.........&.E.
    0010: 42 00 21 00 2b 00 2d 00  26 00 f4 ff e5 ff 12 00
B.!.+.-.&.......
    0020: 07 00 23 00 17 00 0d 00  67 00 4f 00 29 00 37
00  ..#.....g.O.).7.
> SCO data: handle 256 dlen 48
    0000: 16 00 30 00 05 00 dc ff  1c 00 1f 00 30 00 3e
00  ..0.........0.>.
    0010: 6d 00 6b 00 0f 00 29 00  0e 00 08 00 14 00 e0 ff
m.k...).........
    0020: 27 00 35 00 34 00 67 00  41 00 30 00 3a 00 0d 00
'.5.4.g.A.0.:...
> SCO data: handle 256 dlen 48
    0000: f6 ff 0f 00 11 00 1a 00  20 00 13 00 44 00 52
00  ........ ...D.R.
    0010: 2b 00 30 00 39 00 39 00  23 00 f8 ff ff ff 12 00
+.0.9.9.#.......
    0020: 0b 00 02 00 0c 00 20 00  1a 00 1a 00 13 00 f8
ff  ...... .........
> SCO data: handle 256 dlen 48
    0000: 04 00 04 00 05 00 1a 00  17 00 3b 00 58 00 38
00  ..........;.X.8.
    0010: 1f 00 15 00 07 00 06 00  18 00 0c 00 f9 ff 18
00  ................
    0020: 34 00 3c 00 2d 00 11 00  25 00 1a 00 fd ff 0c 00
4.<.-...%.......
> SCO data: handle 256 dlen 48
    0000: 02 00 10 00 16 00 00 00  18 00 1d 00 20 00 24
00  ............ .$.
    0010: 15 00 05 00 fe ff 12 00  05 00 0a 00 2b 00 22
00  ............+.".
    0020: 37 00 3c 00 19 00 12 00  0b 00 03 00 06 00 fd ff
7.<.............
> SCO data: handle 256 dlen 48
    0000: f4 ff 1c 00 47 00 3e 00  35 00 2a 00 32 00 4d
00  ....G.>.5.*.2.M.
    0010: 22 00 02 00 07 00 0a 00  2d 00 20 00 16 00 38 00
".......-. ...8.
    0020: 31 00 41 00 40 00 13 00  0f 00 0a 00 fe ff 05 00
1.A.@...........
> SCO data: handle 256 dlen 48
    0000: 07 00 15 00 1f 00 24 00  1c 00 0b 00 14 00 16
00  ......$.........
    0010: 12 00 fe ff f4 ff 16 00  26 00 2e 00 2a 00 29
00  ........&...*.).
    0020: 37 00 1e 00 35 00 27 00  ff ff 28 00 1d 00 2a 00
7...5.'...(...*.
> SCO data: handle 256 dlen 48
    0000: 32 00 fa ff 2c 00 2d 00  14 00 1b 00 f6 ff 13 00
2...,.-.........
    0010: 14 00 00 00 1d 00 14 00  2d 00 59 00 3a 00 17
00  ........-.Y.:...
    0020: 2b 00 1c 00 0c 00 0b 00  ec ff fc ff 0b 00 15 00
+...............
> SCO data: handle 256 dlen 48
    0000: 39 00 3f 00 41 00 31 00  17 00 27 00 20 00 0d 00
9.?.A.1...'. ...
    0010: 27 00 29 00 1e 00 27 00  15 00 12 00 20 00 08 00
'.)...'..... ...
    0020: 00 00 09 00 04 00 06 00  03 00 06 00 1d 00 21
00  ..............!.
> SCO data: handle 256 dlen 48
    0000: 31 00 20 00 12 00 43 00  1b 00 f9 ff 02 00 f6 ff
1. ...C.........
    0010: 0b 00 f5 ff 13 00 41 00  30 00 34 00 13 00 18
00  ......A.0.4.....
    0020: 28 00 15 00 25 00 24 00  2c 00 20 00 1a 00 29 00
(...%.$.,. ...).
> SCO data: handle 256 dlen 48
    0000: 19 00 19 00 08 00 ee ff  03 00 1a 00 11 00 0d
00  ................
    0010: 1b 00 2a 00 35 00 2c 00  20 00 0d 00 0f 00 1a
00  ..*.5.,. .......
    0020: fd ff 0b 00 18 00 0a 00  27 00 30 00 23 00 18
00  ........'.0.#...
> SCO data: handle 256 dlen 48
    0000: 1b 00 24 00 16 00 02 00  f4 ff 10 00 24 00 24
00  ..$.........$.$.
    0010: 22 00 21 00 4a 00 4b 00  3e 00 2c 00 0e 00 44 00
".!.J.K.>.,...D.
    0020: 43 00 1f 00 21 00 13 00  35 00 38 00 10 00 23 00
C...!...5.8...#.
> SCO data: handle 256 dlen 48
    0000: 1c 00 01 00 0d 00 06 00  06 00 1d 00 1b 00 36
00  ..............6.
    0010: 47 00 2a 00 2e 00 35 00  2a 00 17 00 fe ff 17 00
G.*...5.*.......
    0020: 3e 00 3a 00 20 00 1d 00  2f 00 3c 00 29 00 06 00
>.:. .../.<.)...
> SCO data: handle 256 dlen 48
    0000: 0e 00 17 00 19 00 25 00  11 00 19 00 25 00 1e
00  ......%.....%...
    0010: 1e 00 06 00 10 00 19 00  0b 00 15 00 0c 00 1d
00  ................
    0020: 22 00 14 00 40 00 2d 00  21 00 42 00 38 00 3e 00
"...@.-.!.B.8.>.
> SCO data: handle 256 dlen 48
    0000: 0f 00 fa ff 2c 00 2c 00  1d 00 0f 00 2d 00 35
00  ....,.,.....-.5.
    0010: 1d 00 20 00 0f 00 1f 00  09 00 f6 ff 12 00 00
00  .. .............
    0020: 35 00 5f 00 49 00 52 00  45 00 53 00 4b 00 19 00
5._.I.R.E.S.K...
> SCO data: handle 256 dlen 48
    0000: 16 00 16 00 1c 00 18 00  12 00 43 00 36 00 0b
00  ..........C.6...
    0010: 2b 00 2e 00 21 00 1d 00  3a 00 5d 00 32 00 18 00
+...!...:.].2...
    0020: 24 00 31 00 25 00 01 00  08 00 22 00 2e 00 11 00
$.1.%.....".....
> SCO data: handle 256 dlen 48
    0000: 13 00 19 00 19 00 3e 00  1c 00 10 00 30 00 25
00  ......>.....0.%.
    0010: 21 00 1d 00 13 00 0d 00  07 00 0b 00 0b 00 12
00  !...............
    0020: 1f 00 0e 00 24 00 41 00  05 00 ea ff ff ff 25
00  ....$.A.......%.
> SCO data: handle 256 dlen 48
    0000: 3a 00 18 00 20 00 2f 00  34 00 26 00 f5 ff 15
00  :... ./.4.&.....
    0010: 47 00 22 00 f2 ff 1d 00  23 00 28 00 5f 00 1b 00
G.".....#.(._...
    0020: 31 00 45 00 fc ff 18 00  14 00 28 00 2d 00 08 00
1.E.......(.-...
> SCO data: handle 256 dlen 48
    0000: 2f 00 2b 00 1b 00 23 00  1d 00 32 00 49 00 13
00  /.+...#...2.I...
    0010: 0d 00 5c 00 53 00 33 00  22 00 12 00 20 00 21
00  ..\.S.3."... .!.
    0020: 13 00 ff ff 21 00 35 00  0d 00 00 00 1b 00 26
00  ....!.5.......&.
> SCO data: handle 256 dlen 48
    0000: 17 00 2c 00 29 00 29 00  31 00 10 00 1d 00 1a
00  ..,.).).1.......
    0010: fb ff 00 00 10 00 22 00  1c 00 07 00 0f 00 20
00  ......"....... .
    0020: 14 00 1d 00 0a 00 0a 00  55 00 48 00 2e 00 25
00  ........U.H...%.
> SCO data: handle 256 dlen 48
    0000: 1b 00 43 00 1b 00 f5 ff  0e 00 17 00 2a 00 15
00  ..C.........*...
    0010: 04 00 17 00 14 00 17 00  1d 00 18 00 14 00 1f
00  ................
    0020: 25 00 1b 00 0e 00 0d 00  23 00 1a 00 15 00 12 00
%.......#.......
> SCO data: handle 256 dlen 48
    0000: 02 00 21 00 26 00 19 00  0d 00 ff ff 1f 00 25
00  ..!.&.........%.
    0010: 1e 00 12 00 08 00 16 00  0b 00 05 00 21 00 40
00  ............!.@.
    0020: 2f 00 2c 00 1b 00 fa ff  3c 00 3f 00 2e 00 2a
00  /.,.....<.?...*.
> SCO data: handle 256 dlen 48
    0000: 18 00 31 00 0e 00 23 00  1e 00 01 00 2a 00 18
00  ..1...#.....*...
    0010: 2b 00 24 00 0f 00 0f 00  1c 00 2e 00 e6 ff 03 00
+.$.............
    0020: 19 00 16 00 52 00 31 00  30 00 22 00 16 00 1d
00  ....R.1.0.".....
> SCO data: handle 256 dlen 48
    0000: 02 00 1e 00 18 00 35 00  41 00 1c 00 32 00 40
00  ......5.A...2.@.
    0010: 4a 00 42 00 3b 00 23 00  1f 00 2b 00 16 00 0a 00
J.B.;.#...+.....
    0020: f0 ff 13 00 20 00 0b 00  0a 00 01 00 29 00 25
00  .... .......).%.
> SCO data: handle 256 dlen 48
    0000: 15 00 27 00 29 00 30 00  30 00 30 00 1e 00 1a
00  ..'.).0.0.0.....
    0010: 24 00 1e 00 03 00 fb ff  16 00 0f 00 16 00 03 00
$...............
    0020: 06 00 26 00 04 00 3f 00  4b 00 09 00 2f 00 36
00  ..&...?.K.../.6.
> SCO data: handle 256 dlen 48
    0000: 15 00 ff ff 11 00 21 00  23 00 1f 00 fd ff 22
00  ......!.#.....".
    0010: 20 00 12 00 2d 00 36 00  35 00 10 00 41 00 4c
00   ...-.6.5...A.L.
    0020: 28 00 49 00 2e 00 22 00  24 00 1a 00 0f 00 fc ff
(.I...".$.......
> SCO data: handle 256 dlen 48
    0000: 13 00 ff ff 00 00 11 00  0c 00 5f 00 68 00 0f
00  .........._.h...
    0010: 25 00 4d 00 35 00 15 00  1c 00 20 00 06 00 44 00
%.M.5..... ...D.
    0020: 33 00 03 00 30 00 17 00  25 00 32 00 1b 00 30 00
3...0...%.2...0.
> SCO data: handle 256 dlen 48
    0000: 51 00 4b 00 1b 00 36 00  29 00 16 00 30 00 2d 00
Q.K...6.)...0.-.
    0010: 1f 00 f9 ff 39 00 34 00  e8 ff 04 00 01 00 1b
00  ....9.4.........
    0020: 1d 00 04 00 33 00 3b 00  2d 00 44 00 49 00 2c
00  ....3.;.-.D.I.,.
> SCO data: handle 256 dlen 48
    0000: 16 00 26 00 31 00 00 00  15 00 3b 00 0c 00 25
00  ..&.1.....;...%.
    0010: 1e 00 fc ff 10 00 0d 00  32 00 37 00 10 00 20
00  ........2.7... .
    0020: 3b 00 2d 00 07 00 fa ff  06 00 09 00 fd ff 07
00  ;.-.............
> SCO data: handle 256 dlen 48
    0000: 0c 00 12 00 28 00 20 00  17 00 15 00 1b 00 26
00  ....(. .......&.
    0010: 25 00 27 00 1d 00 17 00  17 00 f9 ff fc ff 0d 00
%.'.............
    0020: ef ff 09 00 32 00 0e 00  19 00 2e 00 1e 00 27
00  ....2.........'.
> SCO data: handle 256 dlen 48
    0000: 16 00 15 00 36 00 2e 00  29 00 2a 00 2a 00 29
00  ....6...).*.*.).
    0010: 0f 00 07 00 04 00 0d 00  22 00 14 00 0e 00 14
00  ........".......
    0020: 0f 00 15 00 12 00 0f 00  1f 00 18 00 13 00 1b
00  ................
> SCO data: handle 256 dlen 48
    0000: 0d 00 0f 00 0a 00 03 00  07 00 fa ff 13 00 24
00  ..............$.
    0010: 15 00 2f 00 27 00 18 00  4d 00 47 00 1d 00 23
00  ../.'...M.G...#.
    0020: 1f 00 1e 00 15 00 ff ff  08 00 0f 00 15 00 01
00  ................
> SCO data: handle 256 dlen 48
    0000: f9 ff 19 00 23 00 2e 00  27 00 1b 00 2c 00 31
00  ....#...'...,.1.
    0010: 21 00 17 00 27 00 1e 00  15 00 25 00 12 00 09
00  !...'.....%.....
    0020: 09 00 fe ff 09 00 09 00  0f 00 26 00 2b 00 24
00  ..........&.+.$.
> SCO data: handle 256 dlen 48
    0000: 2e 00 39 00 28 00 16 00  1a 00 1b 00 05 00 04
00  ..9.(...........
    0010: 22 00 13 00 fd ff fc ff  08 00 1c 00 10 00 23 00
".............#.
    0020: 3a 00 35 00 31 00 2f 00  3e 00 1d 00 19 00 33
00  :.5.1./.>.....3.
> SCO data: handle 256 dlen 48
    0000: 06 00 ea ff fe ff 06 00  0a 00 1b 00 15 00 38
00  ..............8.
    0010: 43 00 21 00 5f 00 50 00  1f 00 57 00 70 00 4a 00
C.!._.P...W.p.J.
    0020: 18 00 26 00 3f 00 31 00  0d 00 09 00 23 00 0e
00  ..&.?.1.....#...
> SCO data: handle 256 dlen 48
    0000: 03 00 0b 00 2c 00 36 00  39 00 40 00 1e 00 3c
00  ....,.6.9.@...<.
    0010: 4f 00 30 00 1c 00 1c 00  2c 00 0b 00 f8 ff 0f 00
O.0.....,.......
    0020: 1b 00 11 00 0e 00 26 00  24 00 17 00 16 00 20
00  ......&.$..... .
> SCO data: handle 256 dlen 48
    0000: 2a 00 1f 00 2a 00 37 00  23 00 20 00 24 00 06 00
*...*.7.#. .$...
    0010: f5 ff 01 00 14 00 1f 00  21 00 2c 00 2b 00 1f
00  ........!.,.+...
    0020: 10 00 12 00 12 00 ff ff  11 00 28 00 20 00 00
00  ..........(. ...
> SCO data: handle 256 dlen 48
    0000: 1e 00 53 00 17 00 0f 00  2c 00 4e 00 72 00 37
00  ..S.....,.N.r.7.
    0010: 3d 00 3a 00 18 00 4c 00  3f 00 29 00 46 00 55 00
=3D.:...L.?.).F.U.
    0020: 46 00 2b 00 1b 00 1b 00  1a 00 03 00 17 00 2e 00
F.+.............
> SCO data: handle 256 dlen 48
    0000: 25 00 2d 00 30 00 2b 00  10 00 12 00 29 00 0f 00
%.-.0.+.....)...
    0010: 11 00 21 00 32 00 40 00  18 00 25 00 38 00 26
00  ..!.2.@...%.8.&.
    0020: 3b 00 28 00 1a 00 26 00  2f 00 46 00 30 00 19
00  ;.(...&./.F.0...
> SCO data: handle 256 dlen 48
    0000: 32 00 28 00 f9 ff 11 00  13 00 02 00 13 00 09 00
2.(.............
    0010: 39 00 24 00 0a 00 48 00  41 00 41 00 28 00 3a 00
9.$...H.A.A.(.:.
    0020: 62 00 10 00 13 00 1f 00  ff ff 29 00 18 00 0f 00
b.........).....
> SCO data: handle 256 dlen 48
    0000: 36 00 23 00 37 00 3e 00  0c 00 19 00 2b 00 21 00
6.#.7.>.....+.!.
    0010: 2e 00 3b 00 30 00 1d 00  13 00 17 00 17 00 fc
ff  ..;.0...........
    0020: 05 00 0d 00 19 00 35 00  1b 00 38 00 48 00 21
00  ......5...8.H.!.
> SCO data: handle 256 dlen 48
    0000: 3a 00 37 00 2c 00 3b 00  28 00 06 00 ff ff 11
00  :.7.,.;.(.......
    0010: 07 00 f7 ff 0e 00 16 00  19 00 29 00 18 00 1f
00  ..........).....
    0020: 29 00 0e 00 23 00 2d 00  21 00 21 00 1a 00 10
00  )...#.-.!.!.....
> SCO data: handle 256 dlen 48
    0000: fe ff 03 00 0a 00 0b 00  19 00 26 00 27 00 22
00  ..........&.'.".
    0010: 15 00 0d 00 1e 00 09 00  f8 ff 13 00 13 00 10
00  ................
    0020: 11 00 1a 00 15 00 0b 00  1e 00 16 00 23 00 32
00  ............#.2.
> SCO data: handle 256 dlen 48
    0000: 25 00 29 00 20 00 1a 00  1c 00 19 00 09 00 12 00
%.). ...........
    0010: 1a 00 fc ff 0b 00 18 00  16 00 0f 00 f8 ff 0f
00  ................
    0020: 28 00 28 00 20 00 34 00  4f 00 1e 00 18 00 37 00
(.(. .4.O.....7.
> SCO data: handle 256 dlen 48
    0000: 25 00 1b 00 00 00 09 00  27 00 22 00 31 00 2f 00
%.......'.".1./.
    0010: 2c 00 24 00 1d 00 2e 00  1a 00 2e 00 2e 00 09
00  ,.$.............
    0020: 16 00 1b 00 0f 00 fc ff  04 00 0f 00 0d 00 09
00  ................
> SCO data: handle 256 dlen 48
    0000: 0b 00 31 00 2b 00 15 00  1f 00 2d 00 2e 00 1d
00  ..1.+.....-.....
    0010: 32 00 2e 00 24 00 29 00  0b 00 04 00 1b 00 24 00
2...$.).......$.
    0020: 1f 00 2f 00 1e 00 1c 00  2b 00 04 00 15 00 26
00  ../.....+.....&.
> SCO data: handle 256 dlen 48
    0000: 1e 00 29 00 2d 00 43 00  22 00 0a 00 19 00 19
00  ..).-.C.".......
    0010: 04 00 f7 ff 1a 00 34 00  25 00 17 00 3e 00 43
00  ......4.%...>.C.
    0020: 1a 00 32 00 42 00 44 00  5a 00 53 00 39 00 23
00  ..2.B.D.Z.S.9.#.
> SCO data: handle 256 dlen 48
    0000: 1e 00 0e 00 09 00 23 00  32 00 3a 00 2a 00 0d
00  ......#.2.:.*...
    0010: 2a 00 2a 00 e7 ff f0 ff  21 00 25 00 22 00 31 00
*.*.....!.%.".1.
    0020: 3e 00 19 00 0a 00 26 00  24 00 32 00 37 00 2f 00
>.....&.$.2.7./.
> SCO data: handle 256 dlen 48
    0000: 42 00 28 00 1f 00 2e 00  11 00 0c 00 21 00 22 00
B.(.........!.".
    0010: 22 00 26 00 25 00 1b 00  0c 00 1c 00 24 00 0c 00
".&.%.......$...
    0020: 0f 00 0f 00 14 00 17 00  04 00 2f 00 36 00 07
00  ........../.6...
> SCO data: handle 256 dlen 48
    0000: 25 00 4c 00 44 00 35 00  55 00 52 00 0a 00 23 00
%.L.D.5.U.R...#.
    0010: 4b 00 38 00 2b 00 13 00  2c 00 40 00 1b 00 19 00
K.8.+...,.@.....
    0020: 20 00 05 00 0e 00 1e 00  1c 00 1f 00 20 00 53
00   ........... .S.
> SCO data: handle 256 dlen 48
    0000: 55 00 2b 00 3f 00 2c 00  0e 00 1a 00 3f 00 55 00
U.+.?.,.....?.U.
    0010: 28 00 1f 00 4d 00 26 00  e4 ff 08 00 22 00 27 00
(...M.&.....".'.
    0020: 3b 00 41 00 5c 00 34 00  13 00 23 00 10 00 1a
00  ;.A.\.4...#.....
> SCO data: handle 256 dlen 48
    0000: 0f 00 06 00 20 00 1d 00  22 00 1d 00 09 00 10
00  .... ...".......
    0010: 22 00 27 00 22 00 29 00  34 00 18 00 ff ff 10 00
".'.".).4.......
    0020: 0a 00 02 00 0d 00 1b 00  29 00 15 00 16 00 1d
00  ........).......
> SCO data: handle 256 dlen 48
    0000: 0c 00 17 00 17 00 1c 00  34 00 2f 00 3b 00 3a
00  ........4./.;.:.
    0010: 18 00 0e 00 06 00 fb ff  09 00 1e 00 23 00 1e
00  ............#...
    0020: 22 00 1d 00 18 00 11 00  08 00 20 00 27 00 18 00
"......... .'...
> SCO data: handle 256 dlen 48
    0000: 2d 00 46 00 1e 00 fa ff  27 00 27 00 1e 00 33 00
-.F.....'.'...3.
    0010: 1e 00 2d 00 3d 00 2c 00  3c 00 3a 00 1d 00 26
00  ..-.=3D.,.<.:...&.
    0020: 2a 00 1f 00 32 00 29 00  05 00 03 00 14 00 0e 00
*...2.).........
> SCO data: handle 256 dlen 48
    0000: 05 00 20 00 2d 00 1f 00  1e 00 22 00 1e 00 1e
00  .. .-.....".....
    0010: 0e 00 fd ff 18 00 11 00  fd ff 25 00 33 00 2d
00  ..........%.3.-.
    0020: 38 00 28 00 24 00 37 00  2e 00 2e 00 33 00 21 00
8.(.$.7.....3.!.
> SCO data: handle 256 dlen 48
    0000: 30 00 3e 00 19 00 fc ff  0a 00 13 00 0b 00 38 00
0.>...........8.
    0010: 63 00 1c 00 ff ff 3f 00  24 00 1e 00 3c 00 33 00
c.....?.$...<.3.
    0020: 5f 00 52 00 15 00 2e 00  44 00 14 00 1c 00 48 00
_.R.....D.....H.
> SCO data: handle 256 dlen 48
    0000: 23 00 34 00 58 00 35 00  2e 00 28 00 28 00 2b 00
#.4.X.5...(.(.+.
    0010: 30 00 45 00 3f 00 36 00  23 00 27 00 24 00 f8 ff
0.E.?.6.#.'.$...
    0020: 03 00 1d 00 0c 00 0e 00  29 00 29 00 2b 00 36
00  ........).).+.6.
> SCO data: handle 256 dlen 48
    0000: 1e 00 19 00 29 00 28 00  21 00 1d 00 16 00 0a
00  ....).(.!.......
    0010: 14 00 13 00 06 00 31 00  50 00 40 00 46 00 47
00  ......1.P.@.F.G.
    0020: 41 00 36 00 1f 00 2e 00  22 00 0c 00 26 00 1a 00
A.6....."...&...
> SCO data: handle 256 dlen 48
    0000: 01 00 03 00 15 00 13 00  09 00 20 00 2d 00 28
00  .......... .-.(.
    0010: 28 00 38 00 2d 00 1b 00  1e 00 14 00 24 00 17 00
(.8.-.......$...
    0020: 12 00 2e 00 1b 00 05 00  02 00 19 00 1b 00 10
00  ................
> SCO data: handle 256 dlen 48
    0000: 2c 00 20 00 16 00 25 00  26 00 24 00 1e 00 2d
00  ,. ...%.&.$...-.
    0010: 30 00 0e 00 13 00 22 00  0c 00 01 00 14 00 34 00
0.....".......4.
    0020: 35 00 26 00 49 00 44 00  2c 00 35 00 1e 00 27 00
5.&.I.D.,.5...'.
> SCO data: handle 256 dlen 48
    0000: 27 00 12 00 18 00 14 00  17 00 14 00 1c 00 1f 00
'...............
    0010: 1b 00 38 00 30 00 1c 00  2e 00 41 00 30 00 21
00  ..8.0.....A.0.!.
    0020: 33 00 20 00 05 00 09 00  0d 00 13 00 0c 00 13 00
3. .............
> SCO data: handle 256 dlen 48
    0000: 23 00 1a 00 0d 00 22 00  2a 00 15 00 28 00 2e 00
#.....".*...(...
    0010: 1b 00 29 00 2c 00 1a 00  1d 00 36 00 24 00 2a
00  ..).,.....6.$.*.
    0020: 36 00 11 00 34 00 32 00  1f 00 36 00 2f 00 25 00
6...4.2...6./.%.
> SCO data: handle 256 dlen 48
    0000: 10 00 4c 00 56 00 15 00  2c 00 22 00 08 00 09
00  ..L.V...,.".....
    0010: 1d 00 22 00 25 00 37 00  40 00 49 00 30 00 4c
00  ..".%.7.@.I.0.L.
    0020: 4d 00 21 00 33 00 1d 00  16 00 16 00 12 00 25 00
M.!.3.........%.
> SCO data: handle 256 dlen 48
    0000: 15 00 13 00 1b 00 29 00  39 00 24 00 26 00 48
00  ......).9.$.&.H.
    0010: 28 00 ff ff 21 00 1f 00  0e 00 1e 00 11 00 01 00
(...!...........
    0020: fb ff 10 00 25 00 1c 00  1b 00 27 00 2c 00 28
00  ....%.....'.,.(.
> SCO data: handle 256 dlen 48
    0000: 2a 00 34 00 29 00 1c 00  22 00 0e 00 0d 00 1a 00
*.4.)...".......
    0010: 04 00 10 00 23 00 1d 00  21 00 27 00 1e 00 1a
00  ....#...!.'.....
    0020: 26 00 1e 00 0e 00 13 00  16 00 ff ff 0c 00 2d 00
&.............-.
> SCO data: handle 256 dlen 48
    0000: 13 00 15 00 1b 00 fe ff  0e 00 17 00 1f 00 3c
00  ..............<.
    0010: 34 00 34 00 3f 00 38 00  29 00 27 00 22 00 13 00
4.4.?.8.).'."...
    0020: 1d 00 1d 00 0b 00 1e 00  1f 00 04 00 0b 00 17
00  ................
> SCO data: handle 256 dlen 48
    0000: 1e 00 2b 00 1b 00 14 00  24 00 13 00 01 00 07
00  ..+.....$.......
    0010: 10 00 24 00 2d 00 25 00  21 00 1b 00 22 00 17
00  ..$.-.%.!..."...
    0020: 17 00 26 00 1b 00 20 00  1f 00 1e 00 28 00 0d
00  ..&... .....(...
> SCO data: handle 256 dlen 48
    0000: 0e 00 21 00 09 00 09 00  1d 00 10 00 1c 00 37
00  ..!...........7.
    0010: 2a 00 2c 00 35 00 2f 00  23 00 1c 00 1e 00 09 00
*.,.5./.#.......
    0020: 1d 00 2c 00 17 00 44 00  4a 00 23 00 31 00 1e
00  ..,...D.J.#.1...
> SCO data: handle 256 dlen 48
    0000: 07 00 26 00 29 00 22 00  31 00 33 00 2c 00 37
00  ..&.).".1.3.,.7.
    0010: 2b 00 1c 00 38 00 2c 00  16 00 23 00 0e 00 f5 ff
+...8.,...#.....
    0020: 14 00 37 00 20 00 32 00  5d 00 3c 00 35 00 42
00  ..7. .2.].<.5.B.
> SCO data: handle 256 dlen 48
    0000: 2d 00 1e 00 21 00 28 00  2d 00 44 00 31 00 1b 00
-...!.(.-.D.1...
    0010: 2e 00 15 00 1a 00 32 00  14 00 12 00 22 00 16
00  ......2....."...
    0020: 0b 00 17 00 17 00 19 00  23 00 1a 00 1e 00 22
00  ........#.....".
> SCO data: handle 256 dlen 48
    0000: 11 00 15 00 26 00 1e 00  1f 00 3e 00 44 00 24
00  ....&.....>.D.$.
    0010: 1d 00 20 00 06 00 0a 00  17 00 15 00 2f 00 2f
00  .. ........././.
    0020: 13 00 1a 00 20 00 13 00  16 00 19 00 18 00 2b
00  .... .........+.
> SCO data: handle 256 dlen 48
    0000: 2c 00 27 00 2c 00 27 00  37 00 48 00 27 00 2a
00  ,.'.,.'.7.H.'.*.
    0010: 49 00 23 00 15 00 24 00  10 00 09 00 1f 00 28 00
I.#...$.......(.
    0020: 15 00 23 00 2f 00 08 00  0b 00 20 00 0f 00 14
00  ..#./..... .....
> SCO data: handle 256 dlen 48
    0000: 1c 00 17 00 25 00 1c 00  1d 00 2a 00 1f 00 27
00  ....%.....*...'.
    0010: 2b 00 23 00 22 00 1f 00  24 00 15 00 0f 00 1e 00
+.#."...$.......
    0020: 09 00 03 00 0f 00 09 00  1b 00 1c 00 12 00 24
00  ..............$.
> SCO data: handle 256 dlen 48
    0000: 28 00 25 00 28 00 29 00  16 00 06 00 25 00 26 00
(.%.(.).....%.&.
    0010: 06 00 13 00 13 00 37 00  6a 00 25 00 01 00 19
00  ......7.j.%.....
    0020: 12 00 30 00 22 00 02 00  22 00 51 00 54 00 3e
00  ..0."...".Q.T.>.
> SCO data: handle 256 dlen 48
    0000: 4f 00 54 00 3a 00 28 00  0c 00 0a 00 36 00 46 00
O.T.:.(.....6.F.
    0010: 26 00 2a 00 34 00 27 00  3b 00 2e 00 16 00 22 00
&.*.4.'.;.....".
    0020: 15 00 fd ff fb ff 03 00  0e 00 1d 00 24 00 1b
00  ............$...
> SCO data: handle 256 dlen 48
    0000: 24 00 2b 00 30 00 37 00  17 00 0d 00 26 00 15 00
$.+.0.7.....&...
    0010: 05 00 16 00 21 00 1b 00  15 00 07 00 02 00 13
00  ....!...........
    0020: 14 00 0e 00 10 00 1a 00  2a 00 34 00 3f 00 2a
00  ........*.4.?.*.
> SCO data: handle 256 dlen 48
    0000: 25 00 34 00 15 00 1a 00  1c 00 fa ff 1d 00 38 00
%.4...........8.
    0010: 2b 00 42 00 2e 00 2b 00  4a 00 28 00 17 00 0f 00
+.B...+.J.(.....
    0020: 1c 00 20 00 fa ff 16 00  1b 00 11 00 34 00 36
00  .. .........4.6.
> SCO data: handle 256 dlen 48
    0000: 3c 00 3d 00 2d 00 2d 00  30 00 24 00 1e 00 30 00
<.=3D.-.-.0.$...0.
    0010: 2a 00 28 00 2e 00 16 00  13 00 0d 00 f4 ff f1 ff
*.(.............
    0020: 00 00 0d 00 19 00 25 00  16 00 22 00 44 00 38
00  ......%...".D.8.
> SCO data: handle 256 dlen 48
    0000: 33 00 2f 00 35 00 5a 00  55 00 3c 00 1e 00 23 00
3./.5.Z.U.<...#.
    0010: 3a 00 25 00 23 00 1d 00  19 00 39 00 1d 00 04
00  :.%.#.....9.....
    0020: 19 00 22 00 21 00 19 00  16 00 0e 00 13 00 17
00  ..".!...........
> SCO data: handle 256 dlen 48
    0000: 0d 00 12 00 12 00 0f 00  1b 00 1f 00 2b 00 3e
00  ............+.>.
    0010: 39 00 25 00 2a 00 37 00  2e 00 2a 00 2b 00 20 00
9.%.*.7...*.+. .
    0020: 1a 00 1c 00 13 00 10 00  0e 00 11 00 18 00 11
00  ................
> SCO data: handle 256 dlen 48
    0000: 14 00 19 00 2a 00 2d 00  13 00 18 00 1c 00 20
00  ....*.-....... .
    0010: 2f 00 2d 00 35 00 24 00  1d 00 35 00 31 00 2d
00  /.-.5.$...5.1.-.
    0020: 2c 00 1b 00 21 00 2e 00  25 00 29 00 3a 00 40
00  ,...!...%.).:.@.
> SCO data: handle 256 dlen 48
    0000: 34 00 2c 00 50 00 3c 00  15 00 16 00 fb ff 0d 00
4.,.P.<.........
    0010: 16 00 0b 00 35 00 34 00  3a 00 4c 00 38 00 42
00  ....5.4.:.L.8.B.
    0020: 40 00 33 00 2e 00 17 00  1c 00 18 00 10 00 2c 00
@.3...........,.
> SCO data: handle 256 dlen 48
    0000: 31 00 68 00 72 00 35 00  64 00 39 00 ef ff 17 00
1.h.r.5.d.9.....
    0010: 27 00 37 00 29 00 2c 00  5e 00 57 00 3b 00 2f 00
'.7.).,.^.W.;./.
    0020: 2d 00 37 00 30 00 0f 00  10 00 12 00 13 00 2a 00
-.7.0.........*.
> SCO data: handle 256 dlen 48
    0000: 23 00 41 00 6a 00 59 00  4b 00 31 00 16 00 2f 00
#.A.j.Y.K.1.../.
    0010: 2d 00 11 00 21 00 30 00  2e 00 1e 00 21 00 35 00
-...!.0.....!.5.
    0020: 1b 00 1e 00 20 00 0f 00  29 00 27 00 1c 00 23
00  .... ...).'...#.
> SCO data: handle 256 dlen 48
    0000: 1f 00 15 00 08 00 1b 00  1d 00 12 00 20 00 16
00  ............ ...
    0010: 1b 00 1b 00 16 00 33 00  31 00 2c 00 26 00 10
00  ......3.1.,.&...
    0020: 25 00 26 00 0c 00 08 00  0e 00 32 00 45 00 2d 00
%.&.......2.E.-.
> SCO data: handle 256 dlen 48
    0000: 36 00 38 00 2e 00 42 00  19 00 00 00 27 00 2b 00
6.8...B.....'.+.
    0010: 3a 00 4c 00 44 00 47 00  38 00 23 00 28 00 19
00  :.L.D.G.8.#.(...
    0020: 09 00 1b 00 09 00 05 00  15 00 0b 00 27 00 2b
00  ............'.+.
> SCO data: handle 256 dlen 48
    0000: 2b 00 34 00 17 00 1e 00  1b 00 18 00 22 00 0a 00
+.4........."...
    0010: 0e 00 25 00 52 00 73 00  4a 00 36 00 3c 00 41
00  ..%.R.s.J.6.<.A.
    0020: 46 00 10 00 0a 00 36 00  1e 00 1b 00 1d 00 1b 00
F.....6.........
> SCO data: handle 256 dlen 48
    0000: 4c 00 54 00 3d 00 18 00  ee ff 03 00 10 00 0e 00
L.T.=3D...........
    0010: 1f 00 24 00 2e 00 33 00  36 00 43 00 46 00 47
00  ..$...3.6.C.F.G.
    0020: 36 00 31 00 41 00 1e 00  0e 00 28 00 1c 00 13 00
6.1.A.....(.....
> SCO data: handle 256 dlen 48
    0000: 22 00 19 00 23 00 33 00  28 00 1e 00 10 00 1a 00
"...#.3.(.......
    0010: 21 00 09 00 0e 00 0a 00  0f 00 18 00 01 00 12
00  !...............
    0020: 2f 00 35 00 5d 00 5b 00  20 00 16 00 07 00 07
00  /.5.].[. .......
> SCO data: handle 256 dlen 48
    0000: 0b 00 e6 ff 08 00 1f 00  3d 00 66 00 3f 00 41
00  ........=3D.f.?.A.
    0010: 33 00 17 00 33 00 14 00  00 00 1b 00 0f 00 20 00
3...3......... .
    0020: 28 00 14 00 31 00 52 00  60 00 5c 00 3b 00 23 00
(...1.R.`.\.;.#.
> SCO data: handle 256 dlen 48
    0000: 13 00 0a 00 08 00 0c 00  29 00 34 00 2b 00 29
00  ........).4.+.).
    0010: 24 00 22 00 24 00 19 00  0c 00 18 00 19 00 04 00
$.".$...........
    0020: 09 00 0a 00 17 00 28 00  13 00 1a 00 2f 00 28
00  ......(...../.(.
> SCO data: handle 256 dlen 48
    0000: 31 00 2d 00 09 00 09 00  08 00 fd ff 17 00 17 00
1.-.............
    0010: 18 00 1f 00 21 00 35 00  28 00 26 00 27 00 10
00  ....!.5.(.&.'...
    0020: 23 00 21 00 01 00 fb ff  05 00 1f 00 2b 00 2c 00
#.!.........+.,.
> SCO data: handle 256 dlen 48
    0000: 42 00 5b 00 55 00 38 00  16 00 fe ff 09 00 1b 00
B.[.U.8.........
    0010: 1b 00 10 00 fc ff 0d 00  23 00 28 00 34 00 32
00  ........#.(.4.2.
    0020: 3f 00 34 00 1a 00 27 00  1e 00 0d 00 0b 00 01
00  ?.4...'.........
> SCO data: handle 256 dlen 48
    0000: 0c 00 44 00 66 00 4d 00  3b 00 33 00 20 00 27
00  ..D.f.M.;.3. .'.
    0010: 16 00 0c 00 23 00 1a 00  1b 00 1e 00 1d 00 31
00  ....#.........1.
    0020: 2d 00 3a 00 38 00 15 00  12 00 0d 00 14 00 18 00
-.:.8...........
> SCO data: handle 256 dlen 48
    0000: fe ff 0a 00 10 00 1a 00  37 00 2f 00 24 00 0e
00  ........7./.$...
    0010: 14 00 20 00 0c 00 26 00  20 00 0a 00 12 00 fb
ff  .. ...&. .......
    0020: 13 00 2b 00 27 00 40 00  3a 00 39 00 30 00 14
00  ..+.'.@.:.9.0...
> SCO data: handle 256 dlen 48
    0000: 20 00 07 00 fb ff 18 00  16 00 35 00 2a 00 14
00   .........5.*...
    0010: 38 00 2b 00 22 00 15 00  0f 00 33 00 32 00 2b 00
8.+.".....3.2.+.
    0020: 0d 00 06 00 35 00 3c 00  3f 00 37 00 2b 00 40
00  ....5.<.?.7.+.@.
> SCO data: handle 256 dlen 48
    0000: 32 00 1a 00 10 00 0b 00  16 00 21 00 31 00 29 00
2.........!.1.).
    0010: 0d 00 14 00 21 00 21 00  23 00 20 00 10 00 14
00  ....!.!.#. .....
    0020: 14 00 0c 00 08 00 fd ff  1a 00 33 00 39 00 44
00  ..........3.9.D.
> SCO data: handle 256 dlen 48
    0000: 33 00 3d 00 35 00 12 00  10 00 fc ff 02 00 1b 00
3.=3D.5...........
    0010: 15 00 22 00 26 00 29 00  38 00 1a 00 1e 00 2d
00  ..".&.).8.....-.
    0020: 1f 00 20 00 0b 00 17 00  23 00 1b 00 4b 00 53
00  .. .....#...K.S.
> SCO data: handle 256 dlen 48
    0000: 4c 00 59 00 42 00 37 00  3c 00 34 00 24 00 36 00
L.Y.B.7.<.4.$.6.
    0010: 2e 00 13 00 29 00 27 00  26 00 32 00 22 00 26
00  ....).'.&.2.".&.
    0020: 2a 00 28 00 2d 00 1b 00  17 00 1f 00 0d 00 09 00
*.(.-...........
> SCO data: handle 256 dlen 48
    0000: 05 00 15 00 65 00 71 00  57 00 50 00 3b 00 60
00  ....e.q.W.P.;.`.
    0010: 69 00 3c 00 2b 00 16 00  2a 00 3a 00 20 00 13 00
i.<.+...*.:. ...
    0020: 08 00 19 00 2f 00 4c 00  67 00 3f 00 2d 00 41
00  ..../.L.g.?.-.A.
> SCO data: handle 256 dlen 48
    0000: 30 00 11 00 0b 00 1b 00  3a 00 3d 00 27 00 2a 00
0.......:.=3D.'.*.
    0010: 1a 00 1f 00 34 00 24 00  24 00 19 00 11 00 17
00  ....4.$.$.......
    0020: 1c 00 22 00 12 00 1b 00  1f 00 18 00 2f 00 27
00  .."........./.'.
> SCO data: handle 256 dlen 48
    0000: 12 00 15 00 05 00 05 00  1f 00 29 00 31 00 2c
00  ..........).1.,.
    0010: 23 00 36 00 31 00 16 00  12 00 1e 00 2c 00 24 00
#.6.1.......,.$.
    0020: 05 00 fb ff 0e 00 20 00  22 00 26 00 36 00 32
00  ...... .".&.6.2.
> SCO data: handle 256 dlen 48
    0000: 2b 00 38 00 3d 00 2a 00  1e 00 14 00 09 00 11 00
+.8.=3D.*.........
    0010: 15 00 13 00 17 00 20 00  28 00 34 00 38 00 25
00  ...... .(.4.8.%.
    0020: 27 00 2d 00 22 00 15 00  06 00 09 00 18 00 2f 00
'.-."........./.
> SCO data: handle 256 dlen 48
    0000: 31 00 2c 00 39 00 3b 00  4c 00 33 00 18 00 40 00
1.,.9.;.L.3...@.
    0010: 42 00 37 00 22 00 09 00  1b 00 0c 00 22 00 39 00
B.7.".......".9.
    0020: 22 00 3c 00 2c 00 15 00  2a 00 21 00 26 00 2d 00
".<.,...*.!.&.-.
> SCO data: handle 256 dlen 48
    0000: 22 00 2b 00 33 00 39 00  36 00 37 00 42 00 31 00
".+.3.9.6.7.B.1.
    0010: 22 00 1d 00 27 00 2d 00  07 00 f1 ff f5 ff 14 00
"...'.-.........
    0020: 46 00 50 00 5a 00 64 00  6c 00 63 00 31 00 1d 00
F.P.Z.d.l.c.1...
> SCO data: handle 256 dlen 48
    0000: 14 00 0f 00 1d 00 0d 00  0f 00 29 00 2c 00 3e
00  ..........).,.>.
    0010: 4a 00 39 00 42 00 39 00  20 00 2f 00 1e 00 07 00
J.9.B.9. ./.....
    0020: 14 00 09 00 1b 00 42 00  41 00 3d 00 30 00 25
00  ......B.A.=3D.0.%.
> SCO data: handle 256 dlen 48
    0000: 2c 00 30 00 30 00 21 00  15 00 24 00 1d 00 1d
00  ,.0.0.!...$.....
    0010: 25 00 08 00 1a 00 28 00  1a 00 36 00 24 00 1b 00
%.....(...6.$...
    0020: 22 00 17 00 2f 00 27 00  1b 00 1d 00 14 00 32 00
".../.'.......2.
> SCO data: handle 256 dlen 48
    0000: 38 00 2f 00 33 00 18 00  13 00 15 00 15 00 29 00
8./.3.........).
    0010: 23 00 17 00 16 00 0e 00  2f 00 45 00 2b 00 24 00
#......./.E.+.$.
    0020: 2c 00 46 00 46 00 19 00  1a 00 21 00 29 00 27
00  ,.F.F.....!.).'.
> SCO data: handle 256 dlen 48
    0000: 03 00 09 00 23 00 3d 00  49 00 2d 00 1e 00 1e
00  ....#.=3D.I.-.....
    0010: 28 00 2d 00 1f 00 18 00  0f 00 05 00 0b 00 1e 00
(.-.............
    0020: 24 00 23 00 20 00 22 00  39 00 43 00 2f 00 18 00
$.#. .".9.C./...
> SCO data: handle 256 dlen 48
    0000: 15 00 22 00 1a 00 fd ff  ef ff 05 00 26 00 42
00  ..".........&.B.
    0010: 42 00 2e 00 34 00 2d 00  35 00 39 00 0e 00 14 00
B...4.-.5.9.....
    0020: 23 00 1f 00 23 00 1a 00  20 00 27 00 2e 00 3c 00
#...#... .'...<.
> SCO data: handle 256 dlen 48
    0000: 3b 00 3e 00 3e 00 2c 00  1f 00 13 00 0c 00 0b
00  ;.>.>.,.........
    0010: 00 00 01 00 18 00 2c 00  29 00 1f 00 13 00 19
00  ......,.).......
    0020: 30 00 24 00 18 00 2b 00  19 00 0b 00 0f 00 10 00
0.$...+.........
> SCO data: handle 256 dlen 48
    0000: 27 00 2b 00 1d 00 26 00  31 00 3b 00 2c 00 0f 00
'.+...&.1.;.,...
    0010: 16 00 22 00 2f 00 33 00  29 00 27 00 1f 00 17
00  .."./.3.).'.....
    0020: 21 00 2c 00 24 00 1b 00  28 00 36 00 3f 00 1f
00  !.,.$...(.6.?...
> SCO data: handle 256 dlen 48
    0000: fb ff 0e 00 14 00 16 00  2d 00 22 00 20 00 3c
00  ........-.". .<.
    0010: 5f 00 75 00 41 00 18 00  2f 00 54 00 60 00 30 00
_.u.A.../.T.`.0.
    0020: 2b 00 25 00 17 00 53 00  53 00 38 00 23 00 2e 00
+.%...S.S.8.#...
> SCO data: handle 256 dlen 48
    0000: 6b 00 4d 00 27 00 09 00  f4 ff 1b 00 24 00 26 00
k.M.'.......$.&.
    0010: 2c 00 35 00 4f 00 4e 00  51 00 5a 00 40 00 31
00  ,.5.O.N.Q.Z.@.1.
    0020: 43 00 35 00 21 00 26 00  1e 00 1c 00 23 00 2c 00
C.5.!.&.....#.,.
> SCO data: handle 256 dlen 48
    0000: 2e 00 2c 00 15 00 0d 00  1a 00 04 00 00 00 02
00  ..,.............
    0010: 08 00 13 00 07 00 23 00  28 00 29 00 33 00 27
00  ......#.(.).3.'.
    0020: 4e 00 4f 00 2e 00 2e 00  28 00 34 00 30 00 23 00
N.O.....(.4.0.#.
> SCO data: handle 256 dlen 48
    0000: 15 00 0b 00 33 00 3a 00  2a 00 2b 00 15 00 15
00  ....3.:.*.+.....
    0010: 21 00 19 00 22 00 2d 00  21 00 16 00 15 00 1f
00  !...".-.!.......
    0020: 24 00 2e 00 31 00 23 00  32 00 28 00 08 00 12 00
$...1.#.2.(.....
> SCO data: handle 256 dlen 48
    0000: 15 00 23 00 2d 00 19 00  16 00 12 00 17 00 23
00  ..#.-.........#.
    0010: 14 00 02 00 13 00 29 00  31 00 39 00 25 00 1a
00  ......).1.9.%...
    0020: 2c 00 1a 00 1d 00 23 00  23 00 41 00 3a 00 3d
00  ,.....#.#.A.:.=3D.
> SCO data: handle 256 dlen 48
    0000: 48 00 29 00 07 00 05 00  2b 00 47 00 34 00 0d 00
H.).....+.G.4...
    0010: 16 00 16 00 00 00 18 00  1f 00 31 00 30 00 25
00  ..........1.0.%.
    0020: 3d 00 2e 00 3a 00 38 00  23 00 28 00 11 00 23 00
=3D...:.8.#.(...#.
> SCO data: handle 256 dlen 48
    0000: 32 00 2b 00 3d 00 34 00  28 00 26 00 1d 00 21 00
2.+.=3D.4.(.&...!.
    0010: 25 00 21 00 20 00 16 00  10 00 16 00 20 00 2e 00
%.!. ....... ...
    0020: 39 00 35 00 19 00 15 00  1f 00 22 00 35 00 2d 00
9.5.......".5.-.
> SCO data: handle 256 dlen 48
    0000: 29 00 22 00 0e 00 11 00  2c 00 50 00 50 00 45
00  ).".....,.P.P.E.
    0010: 44 00 22 00 2a 00 41 00  38 00 3f 00 3e 00 25 00
D.".*.A.8.?.>.%.
    0020: 1b 00 1d 00 0c 00 15 00  30 00 28 00 23 00 17
00  ........0.(.#...
> SCO data: handle 256 dlen 48
    0000: 16 00 2d 00 31 00 29 00  13 00 fd ff 0e 00 15
00  ..-.1.).........
    0010: 1f 00 45 00 41 00 3f 00  51 00 36 00 32 00 39
00  ..E.A.?.Q.6.2.9.
    0020: 3c 00 4e 00 3a 00 28 00  21 00 0f 00 19 00 24 00
<.N.:.(.!.....$.
> SCO data: handle 256 dlen 48
    0000: 25 00 22 00 19 00 16 00  0b 00 16 00 28 00 19 00
%.".........(...
    0010: 08 00 04 00 14 00 25 00  28 00 21 00 1c 00 26
00  ......%.(.!...&.
    0020: 2a 00 20 00 1a 00 24 00  3d 00 48 00 3a 00 28 00
*. ...$.=3D.H.:.(.
> SCO data: handle 256 dlen 48
    0000: 22 00 19 00 13 00 10 00  11 00 0b 00 00 00 06 00
"...............
    0010: 13 00 24 00 26 00 16 00  18 00 0f 00 18 00 37
00  ..$.&.........7.
    0020: 31 00 1f 00 1c 00 2e 00  34 00 2f 00 2e 00 30 00
1.......4./...0.
> SCO data: handle 256 dlen 48
    0000: 49 00 4f 00 3f 00 26 00  0d 00 2a 00 49 00 30 00
I.O.?.&...*.I.0.
    0010: 09 00 f6 ff 04 00 1d 00  2c 00 36 00 2b 00 14
00  ........,.6.+...
    0020: 17 00 15 00 25 00 44 00  3f 00 37 00 33 00 3a
00  ....%.D.?.7.3.:.
> SCO data: handle 256 dlen 48
    0000: 34 00 2d 00 2e 00 2d 00  43 00 2f 00 15 00 23 00
4.-...-.C./...#.
    0010: 24 00 24 00 25 00 24 00  1c 00 0d 00 13 00 18 00
$.$.%.$.........
    0020: 24 00 30 00 21 00 18 00  15 00 0d 00 0b 00 07 00
$.0.!...........
> SCO data: handle 256 dlen 48
    0000: 05 00 04 00 03 00 02 00  01 00 01 00 ff ff ff
ff  ................
    0010: ff ff ff ff fe ff fe ff  fe ff fe ff fd ff fd
ff  ................
    0020: fd ff fd ff fd ff fd ff  fd ff fd ff fe ff fe
ff  ................
> SCO data: handle 256 dlen 48
    0000: fc ff fe ff 10 00 0f 00  04 00 08 00 08 00 17
00  ................
    0010: 21 00 17 00 1b 00 23 00  2b 00 2f 00 25 00 20
00  !.....#.+./.%. .
    0020: 13 00 03 00 02 00 05 00  08 00 04 00 0c 00 23
00  ..............#.
> SCO data: handle 256 dlen 48
    0000: 32 00 36 00 28 00 24 00  22 00 15 00 20 00 1a 00
2.6.(.$."... ...
    0010: 0f 00 10 00 10 00 24 00  36 00 40 00 31 00 1a
00  ......$.6.@.1...
    0020: 2f 00 3c 00 33 00 25 00  05 00 fb ff 05 00 fa
ff  /.<.3.%.........
> SCO data: handle 256 dlen 48
    0000: 00 00 16 00 1f 00 2e 00  3c 00 3f 00 3f 00 30
00  ........<.?.?.0.
    0010: 0f 00 02 00 15 00 1a 00  0d 00 0b 00 20 00 44
00  ............ .D.
    0020: 49 00 4b 00 4f 00 41 00  49 00 43 00 2d 00 31 00
I.K.O.A.I.C.-.1.
> SCO data: handle 256 dlen 48
    0000: 14 00 fc ff f7 ff ee ff  0c 00 2d 00 3d 00 4b
00  ..........-.=3D.K.
    0010: 45 00 3e 00 34 00 29 00  24 00 19 00 0a 00 0d 00
E.>.4.).$.......
    0020: 0e 00 07 00 17 00 2a 00  38 00 43 00 4c 00 40
00  ......*.8.C.L.@.
> SCO data: handle 256 dlen 48
    0000: 29 00 2c 00 11 00 00 00  02 00 f5 ff 0b 00 13
00  ).,.............
    0010: 28 00 50 00 4c 00 3e 00  36 00 3f 00 46 00 2e 00
(.P.L.>.6.?.F...
    0020: 21 00 1e 00 08 00 02 00  0e 00 12 00 27 00 38
00  !...........'.8.
> SCO data: handle 256 dlen 48
    0000: 3b 00 55 00 57 00 3e 00  2b 00 12 00 10 00 0b
00  ;.U.W.>.+.......
    0010: fb ff 08 00 10 00 1a 00  30 00 26 00 34 00 38
00  ........0.&.4.8.
    0020: 18 00 1d 00 21 00 22 00  0c 00 f2 ff 05 00 12
00  ....!.".........
> SCO data: handle 256 dlen 48
    0000: 26 00 39 00 38 00 4d 00  57 00 4e 00 43 00 22 00
&.9.8.M.W.N.C.".
    0010: 1d 00 21 00 16 00 19 00  0e 00 06 00 19 00 35
00  ..!...........5.
    0020: 49 00 49 00 3e 00 2b 00  17 00 21 00 22 00 0a 00
I.I.>.+...!."...
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 00 01 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> SCO data: handle 256 dlen 48
    0000: ec ff e6 ff 0c 00 26 00  35 00 61 00 6e 00 6a
00  ......&.5.a.n.j.
    0010: 7b 00 67 00 36 00 29 00  2f 00 21 00 20 00 1c 00
{.g.6.)./.!. ...
    0020: 13 00 36 00 4f 00 58 00  62 00 51 00 2c 00 08
00  ..6.O.X.b.Q.,...
> SCO data: handle 256 dlen 48
    0000: 05 00 03 00 0a 00 0d 00  02 00 26 00 43 00 4a
00  ..........&.C.J.
    0010: 4b 00 3e 00 40 00 34 00  25 00 24 00 1f 00 1f 00
K.>.@.4.%.$.....
    0020: 27 00 18 00 0e 00 1e 00  23 00 39 00 4b 00 4e 00
'.......#.9.K.N.
> SCO data: handle 256 dlen 48
    0000: 49 00 27 00 18 00 04 00  10 00 2c 00 0b 00 1b 00
I.'.......,.....
    0010: 3c 00 49 00 67 00 5f 00  64 00 60 00 44 00 48 00
<.I.g._.d.`.D.H.
    0020: 30 00 28 00 31 00 12 00  18 00 1d 00 20 00 41 00
0.(.1....... .A.
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 0]
      0000: 09 ff 15 02 41 54 2b 56  47 53 3d 31 35 0d 5c     ....AT
+VGS=3D15.\
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0072 len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
> SCO data: handle 256 dlen 48
    0000: 35 00 2e 00 40 00 32 00  26 00 0f 00 f6 ff fb ff
5...@.2.&.......
    0010: fd ff 18 00 2f 00 28 00  31 00 39 00 48 00 4a
00  ..../.(.1.9.H.J.
    0020: 31 00 2e 00 23 00 0d 00  08 00 11 00 1a 00 1c 00
1...#...........
> SCO data: handle 256 dlen 48
    0000: 1d 00 2a 00 45 00 49 00  43 00 32 00 21 00 31
00  ..*.E.I.C.2.!.1.
    0010: 1a 00 f6 ff 06 00 15 00  32 00 44 00 47 00 5b
00  ........2.D.G.[.
    0020: 56 00 6e 00 7d 00 60 00  67 00 3b 00 f9 ff f1 ff
V.n.}.`.g.;.....
> SCO data: handle 256 dlen 48
    0000: f8 ff 1e 00 29 00 29 00  3e 00 42 00 55 00 4c
00  ....).).>.B.U.L.
    0010: 30 00 28 00 00 00 00 00  00 00 00 00 00 00 00 00
0.(.............
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 00 01 16                                       ....
> SCO data: handle 256 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
00  ................
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 01 00 05                  =20
 =20
--=20
Cristiano De Michele, Ph.D.          E-mail: cristiano.demichele@phys.uniro=
ma1.it
Department of Physics                Tel.  : +390649913435
University of Rome  "La Sapienza"    Fax   : +39064463158
Piazzale Aldo Moro 2
I-00185 Roma - Italy   =20
------
"Shoot for the moon. Even if you miss, you'll land among the stars."

--=-2zOql4COp0+8eFwcevnl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCbNHacBhvg6IwkBkRAtDFAJ45rTh4FR4YnPvCGfNg90mw6IrybwCgt9/n
yqWkoC+v9u93609eMKoUdjc=
=b86W
-----END PGP SIGNATURE-----

--=-2zOql4COp0+8eFwcevnl--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
