Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Jul 2009 19:57:37 +0200
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: Re: How to replace DUN with bluez 4?
Message-ID: <20090719175737.GA9278@piper.oerlikon.madduck.net>
References: <20090718055411.GA21651@piper.oerlikon.madduck.net>
 <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
In-Reply-To: <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2009.07.19.1936 =
+0200]:
> You can make use of Serial interface by calling
> Serial.Connect(''dun"), this will return you a bonded port to use,
> it is up to you to use pppd or whatever you prefer to connect,
> note that the port will not be stored permanently.

So you are saying that it should not be too hard to write a little
programme that got the port and which fires off pppd on connect?

> There are some plans to integrate it with NetworkManager and
> connman, but there are some parts missing like possible
> integrating it properly with the wizard and store permanently.

Is there any non-"wizard" and non-GUI support planned? I really
appreciated how dund just ran as a daemon.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the only thing that sustains one through life is the consciousness of
 the immense inferiority of everybody else, and this is a feeling that
 I have always cultivated."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpjXo0ACgkQIgvIgzMMSnVpLACeJKVKNvqznXcDzsDwNKLrCoHi
5HwAn23QSEQySnQzc419zT+JMJbRYOXA
=dILg
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
