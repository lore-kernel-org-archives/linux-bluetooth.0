Return-Path: <cyrus@holtmann.org>
Subject: headset target seems to be playing but no sound
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-hhA0UgwBqORdT+PBJsOK"
Date: Thu, 31 Dec 2009 00:14:53 -0500
Message-ID: <1262236493.9675.1446.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-hhA0UgwBqORdT+PBJsOK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am using bluez 4.51.  After much fiddling, I seem to have my audio
headset doing something -- something other than reporting errors anyway.

I can do:

$ aplay /mnt/mp3/bad_mouth.wav -Dplug:bluetoothraw
Playing WAVE '/mnt/mp3/bad_mouth.wav' : Signed 16 bit Little Endian, Rate 4=
4100 Hz, Stereo

to the device defined as:

pcm.bluetoothraw {
   type bluetooth
   device 00:1A:45:1B:19:89
}

and aplay appears to be doing something and

$ hcidump -t -X -V

reports lots of:

2009-12-31 00:08:57.233899 > SCO data: handle 1 flags 0x00 dlen 48
    0000: fd ff e6 ff af ff 4e ff  41 ff 5a ff 20 ff 53 ff  ......N.A.Z. .S=
.
    0010: a0 ff 6b ff 89 ff bc ff  5d ff 85 ff 3c ff d9 fe  ..k.....]...<..=
.
    0020: 2b ff 28 ff 58 ff 53 ff  1b ff 3c ff 29 ff 49 ff  +.(.X.S...<.).I=
.
2009-12-31 00:08:57.233901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 9b ff b1 ff a2 ff 71 ff  b5 ff 9f ff 52 ff fa fe  ......q.....R..=
.
    0010: 8e fe 4e ff 98 ff ed ff  13 00 88 ff 91 ff f3 fe  ..N............=
.
    0020: 2f ff c2 ff 6d ff 95 ff  62 ff d2 fe ec fe 61 ff  /...m...b.....a=
.
2009-12-31 00:08:57.233903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 5e ff 2b ff 26 ff 01 ff  a5 ff 9c ff 5a ff 2f ff  ^.+.&.......Z./=
.
    0010: 8b fe 1b ff c7 ff fa ff  f0 ff 53 ff e1 fe 28 ff  ..........S...(=
.
    0020: b7 ff be ff 41 ff 55 ff  16 ff 3f ff de ff fa fe  ....A.U...?....=
.
2009-12-31 00:08:57.233905 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 0f ff a1 ff 66 ff f6 ff  06 00 c8 ff 75 ff 16 ff  ....f.......u..=
.
    0010: f4 fe f0 fe e5 fe d3 fe  eb fe 5d ff e5 ff e9 ff  ..........]....=
.
    0020: 84 ff 7b ff c7 ff de ff  ae ff 85 ff a1 ff 58 ff  ..{...........X=
.
2009-12-31 00:08:57.243898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: f0 fe 3c fe a6 fe 49 ff  3d ff c0 ff 93 ff 73 ff  ..<...I.=3D....=
.s.
    0010: 41 ff 85 ff c5 ff 67 ff  63 ff 2c ff 1a ff 23 ff  A.....g.c.,...#=
.
    0020: 51 ff af ff 28 ff d5 fe  50 ff 83 ff e8 ff e4 ff  Q...(...P......=
.
2009-12-31 00:08:57.243901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 01 ff 15 ff d0 fe ba fe  95 ff a2 ff b7 ff ed ff  ...............=
.
    0010: 7e ff a9 ff a1 ff e5 fe  3b ff 70 ff 63 ff 7f ff  ~.......;.p.c..=
.
    0020: 3c ff 2b ff be fe ee fe  58 ff 7c ff 40 ff fb fe  <.+.....X.|.@..=
.
2009-12-31 00:08:57.243903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 39 ff 34 ff b6 ff c1 ff  7d ff a0 ff 6a ff 79 ff  9.4.....}...j.y=
.
    0010: 37 ff 0c ff 4d ff 15 ff  43 ff 66 ff 3e ff 71 ff  7...M...C.f.>.q=
.
    0020: 8e ff 8c ff 06 ff d4 fe  0e ff 2e ff 8a ff 24 ff  ..............$=
.
2009-12-31 00:08:57.253914 > SCO data: handle 1 flags 0x00 dlen 48
    0000: da fe 57 ff b3 ff bf ff  7f ff 49 ff 41 ff ee fe  ..W.......I.A..=
.
    0010: 08 ff 91 ff a2 ff 9d ff  48 ff da fe 52 ff 55 ff  ........H...R.U=
.
    0020: 87 ff 98 ff 25 ff 1d ff  35 ff b9 ff 83 ff b1 ff  ....%...5......=
.
2009-12-31 00:08:57.253918 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 7d ff 37 ff 5e ff 40 ff  3b ff 08 ff 01 ff dc fe  }.7.^.@.;......=
.
    0010: 15 ff 1c ff 8b ff 8b ff  40 ff 90 ff 3a ff c6 ff  ........@...:..=
.
    0020: 71 ff 4a ff 88 ff 3c ff  bc ff 3e ff e4 fe fe fe  q.J...<...>....=
.
2009-12-31 00:08:57.253920 > SCO data: handle 1 flags 0x00 dlen 48
    0000: f9 fe 2c ff a2 ff bb ff  89 ff 65 ff 21 ff 62 ff  ..,.......e.!.b=
.
    0010: b9 ff b4 ff 48 ff f4 fe  42 ff 86 ff ad ff 53 ff  ....H...B.....S=
.
    0020: 20 ff 00 ff dd fe 71 ff  79 ff 59 ff a6 ff 8f ff   .....q.y.Y....=
.
2009-12-31 00:08:57.263898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 57 ff c2 ff a8 ff d9 fe  eb fe 5a ff 89 ff 71 ff  W.........Z...q=
.
    0010: 1f ff 1e ff 27 ff 3f ff  3e ff 63 ff 71 ff 26 ff  ....'.?.>.c.q.&=
.
    0020: fd fe 03 ff 63 ff 9b ff  b6 ff 91 ff 75 ff 79 ff  ....c.......u.y=
.
2009-12-31 00:08:57.263901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 29 ff 51 ff ee fe c9 fe  12 ff 85 ff a6 ff 45 ff  ).Q...........E=
.
    0010: 38 ff 52 ff d7 ff f7 ff  96 ff e9 fe 99 fe d5 fe  8.R............=
.
    0020: 5e ff 9c ff 4d ff 1e ff  c5 fe 2f ff b8 ff cf ff  ^...M...../....=
.
2009-12-31 00:08:57.263903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: f1 ff b2 ff aa ff 82 ff  8a ff 5f ff 47 ff 50 ff  .........._.G.P=
.
    0010: 4a ff ad ff 58 ff 1a ff  43 ff 78 ff 44 ff ef fe  J...X...C.x.D..=
.
    0020: 02 ff 05 ff 42 ff 61 ff  bb ff d8 ff cd ff 01 00  ....B.a........=
.
2009-12-31 00:08:57.263905 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 28 ff e5 fe f4 fe f1 fe  ad ff 33 ff f6 fe ed fe  (.........3....=
.
    0010: 7b fe 45 ff be ff 9c ff  ac ff 2b ff 34 ff 7a ff  {.E.......+.4.z=
.
    0020: 3e ff af ff d3 ff 00 ff  6f ff 69 ff 26 ff 9d ff  >.......o.i.&..=
.
2009-12-31 00:08:57.273899 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 7d ff 8e ff 52 ff 36 ff  2a ff fe fe 63 ff d2 ff  }...R.6.*...c..=
.
    0010: eb ff 92 ff 7a ff 36 ff  22 ff 68 ff d6 ff e0 ff  ....z.6.".h....=
.
    0020: 66 ff b8 fe 68 fe f0 fe  3a ff 69 ff 85 ff a5 ff  f...h...:.i....=
.
2009-12-31 00:08:57.273901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 72 ff 2d ff ae ff d2 ff  74 ff 24 ff 29 ff 05 ff  r.-.....t.$.)..=
.
    0010: e2 fe e1 fe 2f ff f5 fe  cd fe 73 ff 85 ff cc ff  ..../.....s....=
.
    0020: 8c ff 68 ff 8a ff 9f ff  28 00 80 ff 37 ff 29 ff  ..h.....(...7.)=
.
2009-12-31 00:08:57.273903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 12 ff 70 ff 46 ff 20 ff  47 ff 75 ff 8f ff ab ff  ..p.F. .G.u....=
.
    0010: 4f ff 59 ff 80 ff d1 fe  d2 fe 84 ff dd ff 77 ff  O.Y...........w=
.
    0020: a7 fe 7c fe 27 ff 7f ff  6c ff 55 ff 1d ff 3a ff  ..|.'...l.U...:=
.
2009-12-31 00:08:57.283898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 6a ff 8e ff d6 ff 9c ff  89 ff ac ff 80 ff ab ff  j..............=
.
    0010: 3c ff e9 fe e1 fe 22 ff  cd ff 7c ff 1e ff 9d fe  <....."...|....=
.
    0020: 09 ff eb ff d6 ff 97 ff  1b ff 38 ff 61 ff cb ff  ..........8.a..=
.
2009-12-31 00:08:57.283901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: f4 ff 70 ff 87 ff 9d ff  29 00 1f 00 8e ff 4b ff  ..p.....).....K=
.
    0010: f6 fe 0b ff ea fe c1 fe  e1 fe 1a ff 06 ff fb fe  ...............=
.
    0020: 3e ff 5f ff a8 ff c4 ff  a5 ff 8a ff 4c ff 1b ff  >._.........L..=
.
2009-12-31 00:08:57.283903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 02 ff 14 ff 03 ff 5d ff  9b ff 1d ff 29 ff 53 ff  ......].....).S=
.
    0010: 95 ff c5 ff af ff 3d ff  e6 fe 4a ff 7a ff 7a ff  ......=3D...J.z=
.z.
    0020: de ff cb ff 4f ff 4a ff  cc ff fd ff d7 ff 60 ff  ....O.J.......`=
.
2009-12-31 00:08:57.293896 > SCO data: handle 1 flags 0x00 dlen 48
    0000: ab ff bf ff 0f ff 09 ff  d9 fe fc fe 22 ff 0b ff  ............"..=
.
    0010: 24 ff b5 fe 44 ff a6 ff  8d ff b7 ff 69 ff 21 ff  $...D.......i.!=
.
    0020: f1 fe e0 fe 3d ff 78 ff  55 ff fb fe b0 fe 41 ff  ....=3D.x.U....=
.A.
2009-12-31 00:08:57.293898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: c2 ff 95 ff 55 ff 78 ff  22 00 07 00 f3 ff 7f ff  ....U.x."......=
.
    0010: fb fe 1e ff 27 ff 84 ff  13 ff 17 ff 50 ff 75 ff  ....'.......P.u=
.
    0020: fb ff cc ff 82 ff 70 ff  60 ff d3 ff bf ff 29 ff  ......p.`.....)=
.
2009-12-31 00:08:57.293900 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 4b ff fe fe 03 ff 18 ff  c7 fe 64 ff 9e ff 6b ff  K.........d...k=
.
    0010: 50 ff 3e ff 71 ff 38 ff  52 ff 8d ff 3f ff d0 ff  P.>.q.8.R...?..=
.
    0020: 00 00 be ff a3 ff 51 ff  8c ff 22 ff 14 ff 3f ff  ......Q..."...?=
.
2009-12-31 00:08:57.293902 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 1d ff 5e ff 15 ff fe fe  45 ff 28 ff fa fe fe fe  ..^.....E.(....=
.
    0010: b5 ff 85 00 ea ff 2d ff  0c ff 75 ff d4 ff a4 ff  ......-...u....=
.
    0020: b9 ff 3a ff 65 ff 96 ff  e0 fe ea fe fc fe 8b ff  ..:.e..........=
.
2009-12-31 00:08:57.303898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 95 ff 38 ff 69 ff 85 ff  a8 ff 76 ff 55 ff f8 fe  ..8.i.....v.U..=
.
    0010: 24 ff 90 ff e4 fe fb fe  77 ff 5d ff 60 ff 66 ff  $.......w.].`.f=
.
    0020: 42 ff 4a ff 51 ff 13 ff  f4 fe 44 ff a5 ff ea ff  B.J.Q.....D....=
.
2009-12-31 00:08:57.303901 > SCO data: handle 1 flags 0x00 dlen 48
    0000: c9 ff 28 ff e7 fe 21 ff  dc fe b7 fe 0e ff 76 ff  ..(...!.......v=
.
    0010: ab ff a5 ff 6f ff 8a ff  a3 ff f1 ff be ff 6c ff  ....o.........l=
.
    0020: 76 ff 4a ff a9 ff 5f ff  2c ff 38 ff a2 fe eb fe  v.J..._.,.8....=
.
2009-12-31 00:08:57.303903 > SCO data: handle 1 flags 0x00 dlen 48
    0000: ed ff 88 ff 58 ff bd ff  ba ff 86 ff f4 fd fd fe  ....X..........=
.
    0010: 71 00 f4 fe 4e fe f9 ff  a4 00 9a fd b4 ff 61 00  q...N.........a=
.
    0020: 20 fe a9 00 75 ff 92 fe  3f fe af fe f7 00 30 ff   ...u...?.....0=
.
2009-12-31 00:08:57.313896 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 15 ff c2 ff 59 ff 6a fe  5a ff 4a 00 30 ff 68 ff  ....Y.j.Z.J.0.h=
.
    0010: 30 ff 17 ff 20 00 73 00  4a ff 8d ff 2e ff 72 fe  0... .s.J.....r=
.
    0020: 9a ff a5 fe 0a ff 31 ff  af fe d0 00 c1 ff cf fe  ......1........=
.
2009-12-31 00:08:57.313898 > SCO data: handle 1 flags 0x00 dlen 48
    0000: 9d ff 2d ff 60 ff f1 ff  d8 ff aa fe 13 ff 87 ff  ..-.`..........=
.
    0010: 2e ff 51 ff fb fe 15 00  94 ff 6f ff 4c 00 c8 fe  ..Q.......o.L..=
.
    0020: 75 fe 95 ff 55 ff 76 ff  65 ff fe fe d7 fe f4 fe  u...U.v.e......=
.

like traffic and bluetoothd reports:

Dec 31 00:06:04 pc bluetoothd[16063]: Accepted new client connection on uni=
x socket (fd=3D23)
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_REQUEST <- BT_GET_CAPAB=
ILITIES
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_RESPONSE -> BT_GET_CAPA=
BILITIES
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_REQUEST <- BT_OPEN
Dec 31 00:06:04 pc bluetoothd[16063]: open sco - object=3DANY source=3DANY =
destination=3D00:1A:45:1B:19:89 lock=3Dwrite
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_RESPONSE -> BT_OPEN
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_REQUEST <- BT_SET_CONFI=
GURATION
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_RESPONSE -> BT_SET_CONF=
IGURATION
Dec 31 00:06:04 pc bluetoothd[16063]: Audio API: BT_REQUEST <- BT_START_STR=
EAM
Dec 31 00:06:04 pc bluetoothd[16063]: State changed /org/bluez/16062/hci0/d=
ev_00_1A_45_1B_19_89: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROG=
RESS
Dec 31 00:06:05 pc bluetoothd[16063]: SCO socket opened for headset /org/bl=
uez/16062/hci0/dev_00_1A_45_1B_19_89
Dec 31 00:06:05 pc bluetoothd[16063]: SCO fd=3D24
Dec 31 00:06:05 pc bluetoothd[16063]: Audio API: BT_RESPONSE -> BT_START_ST=
REAM
Dec 31 00:06:05 pc bluetoothd[16063]: Audio API: BT_INDICATION -> BT_NEW_ST=
REAM
Dec 31 00:06:05 pc bluetoothd[16063]: State changed /org/bluez/16062/hci0/d=
ev_00_1A_45_1B_19_89: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYI=
NG

And the headset beeps when I interrupt the aplay.

I just don't actually get any audio in the headset.

I have tested the headset with a phone and it works perfectly.  The
headset details are:

# hcitool info 00:1A:45:1B:19:89
Requesting information ...
	BD Address:  00:1A:45:1B:19:89
	Device Name: Jabra BT125
	LMP Version: 2.0 (0x3) LMP Subversion: 0x978
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch>=20
		<hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>=20
		<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>=20
		<paging scheme> <transparent SCO> <AFH cap. slave>=20
		<AFH cap. master>=20

and the dongle details are:

# hciconfig -a
hci0:	Type: USB
	BD Address: 00:0D:18:01:3B:9B ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING PSCAN ISCAN=20
	RX bytes:7769227 acl:146 sco:152180 events:231 errors:0
	TX bytes:3729 acl:132 sco:0 commands:102 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'pc-0'
	Class: 0x0a0104
	Service Classes: Networking, Capturing
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0x4000 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)

Any ideas?

b.


--=-hhA0UgwBqORdT+PBJsOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAks8M0gACgkQl3EQlGLyuXAMBgCg+Xm4fnOQMrAzgD5rlcv8+GNT
XawAnip18khhcVG+nMjGy1KxrjNpnl6E
=ZsYh
-----END PGP SIGNATURE-----

--=-hhA0UgwBqORdT+PBJsOK--

