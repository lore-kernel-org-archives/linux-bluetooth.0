Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stefan Gold <stefan.gold@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11838732.jJTDmzZU3l";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200503310022.16686.stefan.gold@web.de>
Subject: [Bluez-users] Poor audio quality Headset using snd-bt-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 31 Mar 2005 00:22:11 +0200

--nextPart11838732.jJTDmzZU3l
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've noticed that the audio quality of my headset using snd-bt-sco is very=
=20
bad. I know that the headset-profile is not intended to reach HIFI sound=20
quality, but in this case the quality is that worse, that I can't use it fo=
r=20
telephony.

I'm using a Logitech Bluetooth Desktop with the corresponding USB BT-Dongle=
=2E=20
My kernel is the latest 2.6.11.6, which also has been patched with=20
patch-2.6.11-mh2.

To use the BT-keyboard and the MX900 mouse the hidd server is running. I've=
=20
added the hidd option "--encrypt", so my keyboard is paired.

If I'm not using the HID-devices (KB & mouse) and do a 'hidd --killall', th=
en=20
the sound quality is like expected from a BT-headset. But that workaround i=
s=20
unfortunately not acceptable. ;-)

Can anybody tell, what the reason for this problem is and how to solve it?

Regards,
  Stefan

--nextPart11838732.jJTDmzZU3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCSyaYFdd7dooRJzsRArftAJ4y7Qcoa5QjkFmOgDTc4g3g6u7vrQCdGJcz
OaSfQH66IEbACH0bTIBx0dM=
=fI2r
-----END PGP SIGNATURE-----

--nextPart11838732.jJTDmzZU3l--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
