Return-Path: <cyrus@holtmann.org>
Subject: Error: Connection Rejected due to Limited Resources
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tH10u6QgcGJijc5DhBeA"
Date: Wed, 30 Dec 2009 16:45:26 -0500
Message-ID: <1262209526.9675.475.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-tH10u6QgcGJijc5DhBeA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

I am trying to play some audio to a headset with bluez 4.51 and getting
the following from hcidump -t -X -V:

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2009-12-30 08:54:19.708880 < HCI Command: Setup Synchronous Connection (0x0=
1|0x0028) plen 17
    handle 12 voice setting 0x0060
2009-12-30 08:54:19.711125 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2009-12-30 08:54:20.478112 > HCI Event: Synchronous Connect Complete (0x2c)=
 plen 17
    status 0x0d handle 0 bdaddr 00:1A:45:1B:19:89 type SCO
    Error: Connection Rejected due to Limited Resources

The command I am trying to play with is:

$ aplay /mnt/mp3/bad_mouth.wav -Dplug:bluetoothraw
Playing WAVE '/mnt/mp3/bad_mouth.wav' : Signed 16 bit Little Endian, Rate 4=
4100 Hz, Stereo
aplay: pcm_write:1528: write error: Transport endpoint is not connected

Where bluetoothraw is defined as:

pcm.bluetoothraw {
   type bluetooth
   device 00:1A:45:1B:19:89
}

bluetoothd had to say at the time:

Dec 30 08:54:19 pc bluetoothd[7373]: Accepted new client connection on unix=
 socket (fd=3D22)
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_REQUEST <- BT_GET_CAPABI=
LITIES
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_RESPONSE -> BT_GET_CAPAB=
ILITIES
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_REQUEST <- BT_OPEN
Dec 30 08:54:19 pc bluetoothd[7373]: open sco - object=3DANY source=3DANY d=
estination=3D00:1A:45:1B:19:89 lock=3Dwrite
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_RESPONSE -> BT_OPEN
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_REQUEST <- BT_SET_CONFIG=
URATION
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_RESPONSE -> BT_SET_CONFI=
GURATION
Dec 30 08:54:19 pc bluetoothd[7373]: Audio API: BT_REQUEST <- BT_START_STRE=
AM
Dec 30 08:54:19 pc bluetoothd[7373]: State changed /org/bluez/7365/hci0/dev=
_00_1A_45_1B_19_89: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRE=
SS
Dec 30 08:54:20 pc bluetoothd[7373]: Audio API: BT_RESPONSE -> BT_START_STR=
EAM
Dec 30 08:54:20 pc bluetoothd[7373]: Audio API: BT_INDICATION -> BT_NEW_STR=
EAM
Dec 30 08:54:20 pc bluetoothd[7373]: State changed /org/bluez/7365/hci0/dev=
_00_1A_45_1B_19_89: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECT=
ED
Dec 30 08:54:20 pc bluetoothd[7373]: Unix client disconnected (fd=3D22)
Dec 30 08:54:20 pc bluetoothd[7373]: client_free(0x14c5960)

Some info:

$ hciconfig -a
hci0:	Type: USB
	BD Address: 00:0D:18:01:3B:9B ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING PSCAN ISCAN=20
	RX bytes:3470820 acl:370 sco:67685 events:543 errors:0
	TX bytes:9185 acl:338 sco:0 commands:201 errors:0
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

$ hcitool info 00:1A:45:1B:19:89
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

Any ideas what's going on/wrong?

Thanx,
b.



--=-tH10u6QgcGJijc5DhBeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAks7yfMACgkQl3EQlGLyuXAPCQCgskc5lV7dg6jRw+zpr1r8ciJK
6Q8AoP4QFW2irycJk1s1SXZhXPxzr/cG
=0OK7
-----END PGP SIGNATURE-----

--=-tH10u6QgcGJijc5DhBeA--

