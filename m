Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Sep 2008 15:00:00 +0200
From: martin f krafft <madduck@madduck.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [Bluez-devel] "unable to install hw params" to bluetooth (SCO)
	headset
Message-ID: <20080923130000.GA848@piper.oerlikon.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net> <1219394015.7591.441.camel@violet.holtmann.net> <20080826163544.GA5068@lapse.rw.madduck.net> <8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org> <20080905162654.GA17843@lapse.rw.madduck.net> <1220634042.6714.89.camel@californication>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <1220634042.6714.89.camel@californication>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2008.09.05.1900 +0200]:
> actually I have none. It simply works for me. And I have tested it a
> lot. There are some rare conditions where the btusb driver is off on the
> 16-bit boundaries, but I am looking at a fix for it. However this will
> not disturb the audio service. You just don't here anything.

Ported original thread from SF list:
  http://article.gmane.org/gmane.linux.bluez.devel/16060

I can reproduce the exact same error with a BT250 hooked up via
a different bluetooth adapter to an amd64 machine this time (the
last one was i386), running 2.6.26.

Stuart Pook told me about bluez-utils 4.4 [0] - I am still using 3.36
[1], but the wiki page says that I need 3.16 or newer. Would
I have better luck with 4.4? Where does this stuff come in anyway?
I am running hcid in the background, but I know too little about
ALSA or Bluetooth to be able to see how the two interlink. The wiki
mentions a btaudiod, which 3.36 seems not to have. Is that needed?

0. http://article.gmane.org/gmane.linux.bluez.devel/16113
1. http://bugs.debian.org/499529

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"sometimes the urge to do bad is nearly overpowering"
                                                          -- ben horne
=20
spamtraps: madduck.bogus@madduck.net

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjY6E0ACgkQIgvIgzMMSnUozwCgxR+QX4+0zK/bkfBeOzOSEXct
U7AAn1IByJYJnuo5LOOcJngAAXP/jVY2
=hH5Q
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
