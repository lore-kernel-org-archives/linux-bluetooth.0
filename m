Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ian Kumlien <pomac@vapor.com>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-17Jy47FSf+Ljphe9bD2c"
Message-Id: <1095807044.3211.9.camel@big>
Mime-Version: 1.0
Subject: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 00:50:44 +0200


--=-17Jy47FSf+Ljphe9bD2c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

Since some kernel version i can't exactly remember which, i have been
unable to use usb, i have tested with with 2.6.8 -> 2.6.9-rc2-bk7 and i
also applied your patches for 2.6.8.

I have 2 usb dongles, one old that did work once, and one new that seems
to be working like the older but it doesn't work with linux.

Both are based on the CSR chipset, here is the new ones entry from the
hw support list:
MSI MS-6967 CSR 1.1 hci_usb working Dave Beckett

Som logs from insertions:
usb 1-3.4: new full speed USB device using address 12
ehci_hcd 0000:00:02.2: qh f7e54780 (#0) state 1
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb d968cd74 err -28

usb 1-4.4: new full speed USB device using address 13
ehci_hcd 0000:00:02.2: qh f7e54900 (#0) state 1
hci_usb_intr_rx_submit: hci1 intr rx submit failed urb d315eef4 err -28

both of these are connected to usb 2.0 hubs (this machine does usb 2.0)

Output from hciconfig:
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

hci1:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

=46rom a strace:
socket(PF_BLUETOOTH, SOCK_RAW, 1)       =3D 3
ioctl(3, 0x800448d3, 0x804eae0)         =3D 0
ioctl(3, 0x400448c9, 0)                 =3D -1 EIO (Input/output error)
fstat64(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 2), ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0xb7fe8000
write(1, "Can\'t init device hci0. Input/ou"..., 46Can't init device
hci0. Input/output error(5)
) =3D 46

Basically, it just stopped working and i dunno why, any clues? at all?

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-17Jy47FSf+Ljphe9bD2c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBULBD7F3Euyc51N8RAp/VAKC1H+P9WWgojyl2KSU98SYrXX4ddQCeMkCj
+bZedJL5z+OB0srRHDZ1kVE=
=XStn
-----END PGP SIGNATURE-----

--=-17Jy47FSf+Ljphe9bD2c--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
