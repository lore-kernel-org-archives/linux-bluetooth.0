Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Martin List-Petersen <martin@list-petersen.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1099943857.29330.27.camel@pegasus>
References: <418FC205.7070102@tootai.net>
	 <1099943857.29330.27.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OeXYPWdogr8ajz0zYXqw"
Message-Id: <1099954588.6339.144.camel@loke>
Mime-Version: 1.0
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
Date: Mon, 08 Nov 2004 22:56:29 +0000


--=-OeXYPWdogr8ajz0zYXqw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-08 at 19:57, Marcel Holtmann wrote:
> Hi Daniel,
>=20
> > I have a question: for my mobile I use an HAMA Bluetooth headset. If I=20
> > buy a bluetooth PCMCIA card for my notebook, will I be able to use this=
=20
> > headset with this card? recognized as a second soundcard? as a normal=20
> > headset for my integrate soundcard? recognized by my software phone=20
> > clients? If I buy an USB bluetooth device, would it be the same? better=
?
>=20
> actually this is not an easy to answer question. First thing is that you
> should get a Bluetooth device with a CSR chip and at least HCI 16.x
> firmware on it. The second is that it must route the SCO traffic through
> the HCI and via a PCM. Then it should be possible.

How to identify version 16.x or higher ? hciconfig -a only gives a
hexadecimal value, that not really gives me get a clue on the firmware
version.

HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc

Kind regards,
Martin List-Petersen


--=-OeXYPWdogr8ajz0zYXqw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBj/mcp8B84hoWbO4RAhvcAJwOVq/ZkeOXvBjuSBLLJB0SAVSjFQCffZJZ
NryrwiSKaH7R55EAz+d148s=
=QNle
-----END PGP SIGNATURE-----

--=-OeXYPWdogr8ajz0zYXqw--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
