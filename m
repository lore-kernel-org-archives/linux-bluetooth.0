Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Jochem <rainer@graphics.cs.uni-sb.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20030927113717.GA23865@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Subject: [Bluez-users] snd-bluez-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 27 Sep 2003 13:37:17 +0200


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I'm absolutely new to this whole bluetooth-stuff, so it might
be that I just did some stupid mistake, but well...

=20
This is what I have:
Kernel 2.4.22 (with all stuff in bluetooth enabled)
alsa 0.9.7 (driver & libs) both patched with the
 	   patches from J. Paisley (I had to manually
 	   adjust some of the files, because the patch
 	   is for 0.9.6, but this is no major problem I
 	   think - perhaps I'll do a patch for 0.9.7 later)
Anycom AHS-10 Headset
Anycom USB 100 Bluetooth-adapter
All the packages/libs... from the bluez Homepage installed

 The following modules are loaded:
 rfcomm                 31200   1  (autoclean)
 l2cap                  17280   2  (autoclean) [rfcomm]
 snd-bluez-sco           7904   0=20
 sco                     9408   0  (unused)
 bfusb                 425600   0  (unused)
 hci_usb                 8928   1=20
 bluez
=20
the bluetooth subsystem is started and the USB-stick is found.
=20
=20
=20
That's what I want:
Getting the alsa-driver working with my headset in order
to do VoIP.
=20
=20
=20
=2E..and the following doesn't work:
doing a "sdptool search HSET" finds the headset:
=20
 Inquiring ...
 Searching for HSET on xx:xx:xx:xx:xx:xx ...
 Service Name: Headset
 Service RecHandle: 0x20000
 Service Class ID List:
   "Headset" (0x1108)
   "Generic Audio" (0x1203)
 Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 6
 Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
=20
=20
=20
then I do:
root@marvin:# bluezsco  xx:xx:xx:xx:xx:xx 6
 Error: control open (hw:2): No such device
 Error: Can't find device. Bail
=20
=20
Humm.... and now I'm stuck. Any hints?
=20
=20
Are there perhaps other ways to get an audio
device I can use with other linux-apps?
(Although I prefer the idea of having an=20
alsa-device I can play with :)
=20
=20
 Cheers
=20
   Rainer
=20
=20
--=20
http://graphics.cs.uni-sb.de/~rainer/



--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/dXZtH/5+6U9F1qYRAnyYAKCabKk4WKpN5KPevbDlkI/NuvQZMQCdF9jb
4kZkcmECke1XMf0fP7rB7fw=
=z0qq
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
