Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
Message-ID: <20041007132054.GA18310@cirrus.madduck.net>
References: <41651D72.7040806@corscience.de> <1097147273.7325.26.camel@pegasus> <20041007114224.GA9849@cirrus.madduck.net> <416536BA.3080901@corscience.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <416536BA.3080901@corscience.de>
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
Date: Thu, 7 Oct 2004 15:20:54 +0200


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Thomas Leidenfrost <leidenfrost@corscience.de> [2004.10.07.1429=
 +0200]:
> the linux-distribution I am using is a specific from mycable.

looks like they screwed up. :)

run

  depmod -a

then try modprobe again.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"information superhighway"
 is just an anagram for
"i'm on a huge wispy rhino fart".

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBZUK2IgvIgzMMSnURArbFAKDRLlDlVcM7tsuC0soHJAVkmeKZfQCfVynr
P/ewocJo8Tq0qRaoa9+iPmY=
=6lLf
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
