Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matthew Grant <grantma@anathoth.gen.nz>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lyNRiWRYBRotvrHI11W1"
Message-Id: <1100460997.6066.18.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] PROBLEM: Apple Powerbook and apple keyboard, start up sequence
 fails
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 15 Nov 2004 08:36:37 +1300


--=-lyNRiWRYBRotvrHI11W1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Matthew here again.

BT keyboard is connected on startup, but no keyboard output is
happening, and capslock light does not turn on when capslock key is
pressed.  This is not just the connection delay, as my mouse reconnects
successfully after boot.

This is on kernel 2.6.9 with the mh3 patch, bluez-libs and bluez-utils
2.11.  I have debug output enabled in the hidp module, and bluez-utils
and bluez-libs are compiled with debugging enabled. Debug output
follows.

As you can see a BT connection exists to the keyboard, key events are
actually coming in, but they are not getting through the kernel hid
layer.  I press the <return> key, and no output appears in a terminal
that has focus.  From the below, do you have any idea where I should
start looking and what to check?  Any debug in the kernel hid_core.c
that I could turn on?  Critical events and functions in the kernel I
could printk()?

I believe the Apple Open firmware on the powerbook negotiates a
connection with the keyboard on power up or boot, and leaves the
built-in CSR USB dongle in USB HID emulation mode.  The keyboard starts
working after I switch it on and off, and it renegotiates a connection.=20

Here is some hidd/hcitool output:

 root@sharon:/usr/src/kernel/kernel-source-2.6.9-mag#
# hidd --show
00:07:61:16:DF:61 Logitech Bluetooth Mouse [046d:b001] connected
00:0A:95:3B:0B:49 Apple Wireless Keyboard [05ac:0208] connected

root@sharon:/usr/src/kernel/kernel-source-2.6.9-mag#
# ps axc | grep hid
 8668 ?        Ss     0:00 hidd
 8920 ?        S<     0:00 khidpd_05ac0208
 9002 ?        S<     0:00 khidpd_046db001

root@sharon:/usr/src/kernel/kernel-source-2.6.9-mag#
# hcitool con
Connections:
        > ACL 00:07:61:16:DF:61 handle 49 state 1 lm MASTER AUTH ENCRYPT
        > ACL 00:0A:95:3B:0B:49 handle 46 state 1 lm MASTER AUTH ENCRYPT


dmesg output:

eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
hda: Set PIO timing for mode 0, reg: 0x08618a92
usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0
ret -110
usb 1-1: USB disconnect, address 2
drivers/usb/input/hid-core.c: can't resubmit intr,
0001:10:1a.0-1/input0, status -19
drivers/usb/input/hid-core.c: can't resubmit intr,
0001:10:1a.0-1/input1, status -19
usb 1-1: new full speed USB device using address 3
usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0
ret -110
usb 1-1: USB disconnect, address 3
usb 1-1: new full speed USB device using address 4
input: USB HID v1.11 Keyboard [05ac:1000] on usb-0001:10:1a.0-1
input: USB HID v1.11 Mouse [05ac:1000] on usb-0001:10:1a.0-1
Bluetooth: HIDP (Human Interface Emulation) ver 1.0-mh1
hidp_sock_create: sock eed7b360
usb 1-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0
ret -110
usb 1-1: USB disconnect, address 4
drivers/usb/input/hid-core.c: can't resubmit intr,
0001:10:1a.0-1/input1, status -19
usb 1-1: new full speed USB device using address 5
hidp_sock_ioctl: cmd 800448c8 arg 7ffff660
hidp_add_connection:
__hidp_get_session:
hidp_add_connection: ctrl mtu 48 intr mtu 48
hid_send_report: session ea0d84a0 hid d617a000 data ead6dc50 size 10
hidp_session: session ea0d84a0
hidp_process_transmit: session ea0d84a0
hidp_send_frame: sock eed7b620 data e71b9160 len 11
hidp_process_transmit: session ea0d84a0
hidp_recv_frame: session ea0d84a0 skb e71f6260 len 1
hidp_recv_frame: Unsupported protocol header 0x03
hidp_process_transmit: session ea0d84a0
hidp_sock_create: sock e071ba40
hidp_sock_ioctl: cmd 400448d2 arg 7ffff750
hidp_get_connlist:
hidp_get_connlist: in list_for_each loop
__hidp_copy_session:
__hidp_copy_session: dealing with session->hid: vendor 5ac product 208
version 110
__hidp_copy_session: session name: Apple Wireless Keyboard
hidp_get_connlist: number copied: 1
hidp_get_connlist: err: 0
hidp_sock_release: sock e071ba40 sk eeb23480
hidp_recv_frame: session ea0d84a0 skb ef1d58e0 len 10
hidp_process_transmit: session ea0d84a0
hidp_recv_frame: session ea0d84a0 skb ef1d5e20 len 10
hidp_process_transmit: session ea0d84a0

Thank you for all your help.  Its going to be good to get this sorted,
as I have to deal with this issue every time I switch my laptop on, and
switching the keyboard on and off will wear its switch out. =20

Next I will write some code to properly enable the keys on the Apple
keyboard (F13, F14, F15, F16, Clear, help, numeric =3D, sound keys, eject
key) =20

Cheers,

Matthew Grant


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-lyNRiWRYBRotvrHI11W1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBl7PFuk55Di7iAnARAigDAJ4sjgYvrrJLisnLOHWgvIGZhYRcDQCbBXyl
qr/0HFoAfpVtanby7aqTMY8=
=T/Q7
-----END PGP SIGNATURE-----

--=-lyNRiWRYBRotvrHI11W1--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
