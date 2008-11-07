Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Nov 2008 17:37:37 +0100
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb+sco: unable to install hw params (set_params:979)
Message-ID: <20081107163737.GA19970@piper.oerlikon.madduck.net>
References: <20081107162741.GA8182@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
In-Reply-To: <20081107162741.GA8182@piper.oerlikon.madduck.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--61jdw2sOBCFtR2d/
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2008.11.07.1727 +0100]:
>   $ strace -f -o /tmp/arecord.strace arecord -f S16_LE -D bt250 >/tmp/tes=
t.wav
>   Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono

strace attached, with -tt.

FWIW, I let dbus-monitor run alongside and there was not a single
event between running the above and seeing the error.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
=2E   `___
(o-    (o-    (o-    (o-   (o-    (o-    (o-           /\/| | |
//\    //\    //\    //\   //\    //\    //\      `  /\/\/l-+-|
v_/_   v_/_   v_/_   v_/_  v_/_   v_/_   v_/_    .`  /\/\/|_|_|
=20
spamtraps: madduck.bogus@madduck.net

--EVF5PPMfhYS0aIcm
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="arecord.strace.bz2"
Content-Transfer-Encoding: base64

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

--EVF5PPMfhYS0aIcm--

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkUbtAACgkQIgvIgzMMSnUljQCg6lahZokFaaLbNMGMFsy8GQif
5joAnRFwFu3+5qxuhhliasZIa2YBP1WE
=pg8G
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
