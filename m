Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Filipe Veloza <fmvel@rnl.ist.utl.pt>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YjPFYTPK0PbBsjUWZUg7"
Message-Id: <1086372047.8985.14.camel@castle.budism.pt>
Mime-Version: 1.0
Subject: [Bluez-users] Linux-2.6, Zaapa USB Dongle - can't find near devices
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 04 Jun 2004 19:00:47 +0100


--=-YjPFYTPK0PbBsjUWZUg7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to use Bluetooth, I've start by acquiring a Zaapa USB Dongle
( I think it uses Zeevo Chipset ) here goes tech info :

Distribution : Fedora 1
Kernel : 2.6 with bluetooth built as modules
Bluez rpm's:
bluez-utils-2.4-1
bluez-pan-1.1-2
bluez-sdp-1.5-1
bluez-hcidump-1.5-3
bluez-libs-2.5-1
bluez-bluefw-1.0-1

Connecting the device dmesg returns :

Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb

hciconfig :

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

( I start to find strange that here returns null HW address )

The problem I had was after this but I now cannot replicate , so now
lets start here ...

Why can't I set the device up #hciconfig up hci0

Thanxs
--=20
Filipe Veloza <fmvel@rnl.ist.utl.pt>

PGP ( ID:0xB8ED711C SERVER:pgp.mit.edu )

--=-YjPFYTPK0PbBsjUWZUg7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAwLjPjygwsrjtcRwRAlzVAJ9gs/VYEA0hkXKCApQKHrd0NX9URQCgi92f
2G4fWS3e0XlVujgGp9zL+4Y=
=01MY
-----END PGP SIGNATURE-----

--=-YjPFYTPK0PbBsjUWZUg7--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
