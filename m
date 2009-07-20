Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jul 2009 07:23:14 +0200
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: Re: How to replace DUN with bluez 4?
Message-ID: <20090720052314.GA10357@piper.oerlikon.madduck.net>
References: <20090718055411.GA21651@piper.oerlikon.madduck.net>
 <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
 <20090719175737.GA9278@piper.oerlikon.madduck.net>
 <2d5a2c100907191120g79980cebme985bbff2fbb6ef5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <2d5a2c100907191120g79980cebme985bbff2fbb6ef5@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2009.07.19.2020 =
+0200]:
> Have you tried this:
> https://help.ubuntu.com/community/BluetoothDialup#Configuring%20PPP

It's the wrong way around: I don't want to connect my computer via
the phone, I want to give my Palm access to the Net via my computer.

> > Is there any non-"wizard" and non-GUI support planned? I really
> > appreciated how dund just ran as a daemon.
>=20
> You can write a shell script wizard if you prefer, it is basically
> a DBus client to talk to bluetoothd. Linux desktop already have
> much better alternatives (NM and connman) to what dund does they
> just need some adaptations, so no we don't consider writing an
> alternative to dund on BlueZ.

Right, but they are Linux Desktop. dund worked on non-desktops.

It's scary to see this desktop trend. It's like Windows NT 4.0, and
the Windows-typical need to log in to be able to start a firewall or
fileserver.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
(a)bort, (r)etry, (p)retend this never happened
=20
spamtraps: madduck.bogus@madduck.net

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpj/0EACgkQIgvIgzMMSnWfywCgs+qxmjuuXVZ9wLSPOE5ppe/G
1+QAoNDU9tQVOwVKdP68UWl3Q4GzG0DL
=Y4z1
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
