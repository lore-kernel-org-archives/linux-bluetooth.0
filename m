Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Trejkaz Xaoza <trejkaz@trypticon.org>
Reply-To: trejkaz@xaoza.net
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart366447450.Uk9vzUoVMC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200411012222.49520.trejkaz@trypticon.org>
Subject: [Bluez-users] Device class resetting itself after device is removed
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
Date: Mon, 1 Nov 2004 22:22:49 +1100

--nextPart366447450.Uk9vzUoVMC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


I've been noticing some issues which seemed to start happening after I left=
 my=20
machine alone for a while.  Eventually I thought I would try to nail the=20
problem down and exclude some parties like kdebluetooth from the picture. =
=20
What's left is quite reproducible.  It turns out that these periods of=20
leaving the machine alone coincided with the times I removed the dongle to=
=20
use it at work. :-)

System in healthy state:

raven root # hciconfig hci0 class
hci0:   Type: USB
        BD Address: 00:0B:0D:40:14:0D ACL MTU: 120:20  SCO MTU: 64:0
        Class: 0xff0104
        Service Classes: Positioning, Networking, Rendering, Capturing, Obj=
ect=20
Transfer, Audio, Telephony, Information
        Device Class: Computer, Desktop workstation

System after removing dongle:

raven root # hciconfig hci0 class
Can't get device info: No such device

System after replacing dongle:

raven root # hciconfig hci0 class
hci0:   Type: USB
        BD Address: 00:0B:0D:40:14:0D ACL MTU: 120:20  SCO MTU: 64:0
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,

Now, the class has reset to 0x000000, but that's not the value I have in=20
hcid.conf.

It also destroys my hostname value and probably everything else important a=
t=20
the same time, which would certainly explain why I suddenly can't connect o=
t=20
the computer from any devices when it happens.

Any ideas on how I can stop this resetting?

TX

=2D-=20
             Email: Trejkaz Xaoza <trejkaz@xaoza.net>
          Web site: http://xaoza.net/
         Jabber ID: trejkaz@jabber.xaoza.net
   GPG Fingerprint: 9EEB 97D7 8F7B 7977 F39F  A62C B8C7 BC8B 037E EA73

--nextPart366447450.Uk9vzUoVMC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBhhyJuMe8iwN+6nMRAtUgAJ95G7JPRQVapH6UduwYHJtpcbsQ9ACbBDgu
3RKKQfe7cFW2lctwgG5RIhk=
=GyBA
-----END PGP SIGNATURE-----

--nextPart366447450.Uk9vzUoVMC--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
