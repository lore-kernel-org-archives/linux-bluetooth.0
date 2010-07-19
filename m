Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bluetooth: retry reset for devices that fail
Date: Mon, 19 Jul 2010 14:52:41 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201007151423.23245.oneukum@suse.de> <1279296636.6282.77.camel@localhost.localdomain>
In-Reply-To: <1279296636.6282.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007191452.41978.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag, 16. Juli 2010, 18:10:36 schrieb Marcel Holtmann:
> Hi Oliver,
>=20
> > Some devices fail to reset properly at the first attempt to reset
> > them under unknown circumstances. Failures can be identified by
> > an invalid btaddr. Retry in those cases.
>=20
> I am not sure about this. Can you provide some examples when this is
> suppose to be happening. The empty BD_ADDR might not be a good indicator
> for this.

It happens with traces like this:

ece2d0c0 1582934618 S Ii:2:003:1 -115:1 16 <
ecd717c0 1582934818 S Bi:2:003:2 -115 1028 <
f44c0340 1582934828 S Bi:2:003:2 -115 1028 <
f44c02c0 1582934851 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 030c00
f44c02c0 1582935005 C Co:2:003:0 0 3 >
ece2d0c0 1582938187 C Ii:2:003:1 0:1 6 =3D 0e040103 0c00
ece2d0c0 1582938194 S Ii:2:003:1 -115:1 16 <
ece2d740 1582938207 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 031000
ece2d740 1582938376 C Co:2:003:0 0 3 >
ece2d0c0 1582940160 C Ii:2:003:1 0:1 14 =3D 0e0c0103 1000ffff 8ffe9bff 7987
ece2d0c0 1582940163 S Ii:2:003:1 -115:1 16 <
ecd71a40 1582940171 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 011000
ecd71a40 1582940286 C Co:2:003:0 0 3 >
ece2d0c0 1582941179 C Ii:2:003:1 0:1 14 =3D 0e0c0101 100005e1 01050f00 0342
ece2d0c0 1582941186 S Ii:2:003:1 -115:1 16 <
ece2d1c0 1582941201 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 051000
ece2d1c0 1582941421 C Co:2:003:0 0 3 >

Even a second reset doesn't always help. If it works, ou get traces like th=
is:

f37f35c0 3365799877 S Ii:2:003:1 -115:1 16 <
ecd76ac0 3365800125 S Bi:2:003:2 -115 1028 <
ecd76c40 3365800135 S Bi:2:003:2 -115 1028 <

hci_init_req():

ecd76d40 3365800155 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 030c00
ecd76d40 3365800280 C Co:2:003:0 0 3 >

HCI_OP_RESET

f37f35c0 3365804088 C Ii:2:003:1 0:1 6 =3D 0e040103 0c00
f37f35c0 3365804097 S Ii:2:003:1 -115:1 16 <


ecd76d40 3365804119 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 031000
ecd76d40 3365804276 C Co:2:003:0 0 3 >

HCI_OP_READ_LOCAL_FEATURES

f37f35c0 3365805026 C Ii:2:003:1 0:1 14 =3D 0e0c0103 1000ffff 8ffe9bff 7987
f37f35c0 3365805030 S Ii:2:003:1 -115:1 16 <


ecd76240 3365805037 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 011000
ecd76240 3365805150 C Co:2:003:0 0 3 >

HCI_OP_READ_LOCAL_VERSION

f37f35c0 3365806027 C Ii:2:003:1 0:1 14 =3D 0e0c0101 100005e1 01050f00 0342
f37f35c0 3365806030 S Ii:2:003:1 -115:1 16 <


f45703c0 3365806037 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 051000
f45703c0 3365806152 C Co:2:003:0 0 3 >

HCI_OP_READ_BUFFER_SIZE - no answer

=2D-----------------------------------------------------------------------


ecf40ec0 3395924102 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 030c00
ecf40ec0 3395924297 C Co:2:003:0 0 3 >

Again HCI_OP_RESET <presumably from second command>

f37f35c0 3395925197 C Ii:2:003:1 0:1 13 =3D 0e0b0105 1000fd03 40080001 00

Here's the answer to HCI_OP_READ_BUFFER_SIZE

f37f35c0 3395925204 S Ii:2:003:1 -115:1 16 <

f37f35c0 3395928199 C Ii:2:003:1 0:1 6 =3D 0e040103 0c00

Answer to the reset

f37f35c0 3395928205 S Ii:2:003:1 -115:1 16 <


f37f35c0 3395928277 C Ii:2:003:1 -2:1 0
ecd76c40 3395928447 C Bi:2:003:2 -2 0
ecd76ac0 3395928555 C Bi:2:003:2 -2 0
f45709c0 3395928572 S Co:2:002:0 s 23 08 9032 0001 0000 0
ecd76ac0 3395928601 S Ii:2:003:1 -115:1 16 <
f45709c0 3395928742 C Co:2:002:0 0 0
ecd76c40 3395928750 S Bi:2:003:2 -115 1028 <
f37f35c0 3395928752 S Bi:2:003:2 -115 1028 <

=46rom now on hci_init_req() that works is running:

ecd66440 3395928764 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 030c00
ecd66440 3395929102 C Co:2:003:0 0 3 >

Here's the reset
HCI_OP_RESET

ecd76ac0 3395932203 C Ii:2:003:1 0:1 6 =3D 0e040103 0c00
ecd76ac0 3395932209 S Ii:2:003:1 -115:1 16 <

f4578240 3395932223 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 031000
f4578240 3395932406 C Co:2:003:0 0 3 >

HCI_OP_READ_LOCAL_FEATURES

ecd76ac0 3395933198 C Ii:2:003:1 0:1 14 =3D 0e0c0103 1000ffff 8ffe9bff 7987
ecd76ac0 3395933204 S Ii:2:003:1 -115:1 16 <

ecd66640 3395933215 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 011000
ecd66640 3395933477 C Co:2:003:0 0 3 >

HCI_OP_READ_LOCAL_VERSION

ecd76ac0 3395934203 C Ii:2:003:1 0:1 14 =3D 0e0c0101 100005e1 01050f00 0342
ecd76ac0 3395934208 S Ii:2:003:1 -115:1 16 <

f4578340 3395934219 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 051000
f4578340 3395934439 C Co:2:003:0 0 3 >

HCI_OP_READ_BUFFER_SIZE

ecd76ac0 3395936200 C Ii:2:003:1 0:1 13 =3D 0e0b0105 1000fd03 40080001 00
ecd76ac0 3395936206 S Ii:2:003:1 -115:1 16 <
ecf6d7c0 3395936222 S Co:2:003:0 s 20 00 0000 0000 0003 3 =3D 091000
ecf6d7c0 3395936452 C Co:2:003:0 0 3 >

HCI_OP_READ_BD_ADDR

ecd76ac0 3395937198 C Ii:2:003:1 0:1 12 =3D 0e0a0109 10004031 63132700

requested bdaddr

	Regards
		Oliver
