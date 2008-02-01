Return-Path: <cyrus@holtmann.org>
From: Daniel Rindt <daniel@rindt.name>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 01 Feb 2008 21:09:22 +0100
Message-Id: <1201896562.4525.12.camel@deesan>
Mime-Version: 1.0
Subject: [Bluez-users] Questions about using Mobile Phone as Bluetooth-Modem
Reply-To: daniel@rindt.name,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1234314366=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1234314366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1seqi0+KMox5ksjy/45n"


--=-1seqi0+KMox5ksjy/45n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Listmembers,

i had created a file with the following content:
/etc/bluetooth/rfcomm.conf:
rfcomm0 {
#       # Automatically bind the device at startup
        bind yes;
#
#       # Bluetooth address of the device
        device 00:1D:F6:05:B3:98;
#
#       # RFCOMM channel for the connection
        channel 3;
#
#       # Description of the connection
        comment "Samsung SGH-U700";
}

Iam using Fedora 8 and Gnome Desktop the Device is already paired via
the Gnome Bluetooth Pin Helper Stuff. The Configuration file create for
me on boot a device with the following permissions and ownership:
crw------- 1 drindt root 216, 0  1. Feb 19:57 /dev/rfcomm0

As frontend iam using gnome-ppp for dialin. but the problem is that i
must use gnome-ppp as root to get an internet connection. if iam
starting gnome-ppp as user drindt then i get the message after klicking
connect that the device is busy. Iam confused about because /dev/rfcomm0
has IMHO correct permissions and ownership for using as regular user.

Another Thing is iam using a EDR capable Hama nano Bluetooth Dongle
lsusb told me that it is:
Bus 006 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
Dongle (HCI mode)
but when iam using the FTP Service for instance iam using
nautilus-sendto the filetransfer for a file with 3MB like an mp3 clip
needs more than some minutes. the phone is also capable of EDR and can
talk with up to 3Mb/s and its only some centimeters from the dongle
away.

here are the versions from my bluetooth stuff:
bluez-libs-3.20-1.fc8
bluez-utils-3.20-4.fc8
bluez-gnome-0.14-8.fc8
bluez-utils-alsa-3.20-4.fc8
bluez-utils-cups-3.20-4.fc8
Linux 2.6.23.14-107.fc8 #1 SMP Mon Jan 14 21:37:30 EST 2008 i686 i686
i386 GNU/Linux

Thanks for all suggestions.
-Daniel

--=-1seqi0+KMox5ksjy/45n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHo3xqPYlk/AovIHoRAsqxAJ9l669DYh8ekjlEjORpXdswulyKmACg2VDx
UrK6feUTxK6y4P6BVHXAGXw=
=6ZMw
-----END PGP SIGNATURE-----

--=-1seqi0+KMox5ksjy/45n--



--===============1234314366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1234314366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1234314366==--
