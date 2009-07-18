Return-Path: <cyrus@holtmann.org>
Date: Sat, 18 Jul 2009 07:54:11 +0200
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: How to replace DUN with bluez 4?
Message-ID: <20090718055411.GA21651@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I've searched the web, but short of
http://wiki.bluez.org/HOWTO/SerialConnections (the wiki is broken
currently btw), I could not find any information how one is supposed
to provide a dial-up means (for a Palm Tungsten) via bluetooth with
bluez 4. The wiki page shows me how to use the dbus services, but
not how to link that with pppd or integrate it properly with
a system.

I can use dund from bluez-compat successfully still, but I know it's
deprecated. How am I expected to do serial-over-bluetooth in the
future?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i believe that the moment is near when by a procedure
 of active paranoiac thought, it will be possible
 to systematise confusion and contribute to
 the total discrediting of the world of reality."
                                                      -- salvador dali
=20
spamtraps: madduck.bogus@madduck.net

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkphY38ACgkQIgvIgzMMSnWKQACgxiEzU8ji81MkNrIPcJLnI5py
dWgAoJEt3xHnVXqj+MLRZsyjbBnSH/Ir
=dZXd
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
