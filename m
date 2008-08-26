Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Aug 2008 21:34:51 +0100
From: martin f krafft <madduck@madduck.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080826203451.GA13267@lapse.rw.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
	<8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
Subject: Re: [Bluez-devel] btusb+sco failing to play sound through
	Jabra	BT500v headset (was: SCO flowcontrol patch v4.4 on
	2.6.25/6	causes) hardlocks when connecting to BT device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0443665732=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0443665732==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2008.08.26.1819 +0100]:
> don't use headsetd. Use the audio stuff that comes with
> bluez-utils.

The dbus API documented at /usr/share/doc/bluez-utils/audio-api.txt?
How would I make existing applications speak to that?

Sorry, but dpkg -L bluez-utils (3.36-1) doesn't list anything else
audio-related. Is the version outdated?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
a farmer is a man outstanding in his field.
=20
spamtraps: madduck.bogus@madduck.net

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki0aOgACgkQIgvIgzMMSnWIEQCgzsv1Brf3+l4Tx7tOogrxPPKm
YFkAoINRfr+lMGYcAXVrv0gCBrFPSEzu
=4UN8
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============0443665732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0443665732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0443665732==--
