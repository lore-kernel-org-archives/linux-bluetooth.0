Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing with headset
Message-ID: <20040922075030.GC8233@cirrus.madduck.net>
References: <20040921190606.GA11925@cirrus.madduck.net> <200409220107.46086.pavouk@pavouk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <200409220107.46086.pavouk@pavouk.org>
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
Date: Wed, 22 Sep 2004 09:50:30 +0200


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pavel Ruzicka <pavouk@pavouk.org> [2004.09.22.0107 +0200]:
> You must hold headset button for about 7 seconds, when blue LED on
> Jabra goes permanently ON. Now is headset in pairing mode, and you
> will see it in hcitool scan. Jabra BT250 is visible only in
> pairing mode. Probably due to security reasons.

Oh, okay; now I got it working.

> This headset can be paired only with one device.

That's really annoying.

> Do you have some other experience?

No, but I will let you know.

> Other problem is, that I don't know if there are some working bluez sound=
=20
> driver. I doesn't test it.

It is being worked on.

http://sourceforge.net/projects/bluetooth-alsa
http://www.gargan.org/linux/snd-bt-sco/

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"twenty-four hour room-service must be one of the
 premiere achievements of modern civilization."
                                          -- special agent dale cooper

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBUS7GIgvIgzMMSnURAkqJAJ98lMVR/mtsaX3naaiMiJUGNWfiewCdHC1b
ofYOcMyHdn1XUnqZlzRSXKc=
=5aYZ
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
