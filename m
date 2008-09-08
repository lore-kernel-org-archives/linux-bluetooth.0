Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Sep 2008 21:33:19 +0100
From: martin f krafft <madduck@madduck.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080908203319.GA6349@lapse.rw.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
	<8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
	<20080905162654.GA17843@lapse.rw.madduck.net>
	<1220634042.6714.89.camel@californication>
MIME-Version: 1.0
In-Reply-To: <1220634042.6714.89.camel@californication>
Subject: Re: [Bluez-devel] "unable to install hw params" to bluetooth
	(SCO)	headset (was: btusb+sco failing to play sound through
	Jabra BT500v	headset)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0068818095=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0068818095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2008.09.05.1800 +0100]:
> actually I have none. It simply works for me. And I have tested it a
> lot. There are some rare conditions where the btusb driver is off on the
> 16-bit boundaries, but I am looking at a fix for it. However this will
> not disturb the audio service. You just don't here anything.

Where should we go from here? How can I help debug this?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
no cat has eight tails.
a cat has one tail more than no cat.
therefore, a cat has nine tails.
=20
spamtraps: madduck.bogus@madduck.net

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjFjA8ACgkQIgvIgzMMSnUPfQCeMipC56eKlQQuv4APF0x9e8bn
HLMAnRSvmYUtPTETdxTotaBfmAKKvfDc
=Vg5x
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--


--===============0068818095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0068818095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0068818095==--
