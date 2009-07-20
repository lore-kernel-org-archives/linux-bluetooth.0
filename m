Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jul 2009 13:33:08 +0200
From: martin f krafft <madduck@madduck.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: Re: How to replace DUN with bluez 4?
Message-ID: <20090720113308.GA4997@lapse.rw.madduck.net>
References: <20090718055411.GA21651@piper.oerlikon.madduck.net>
 <2d5a2c100907191036o7c48c405r32f0292a9168cb92@mail.gmail.com>
 <20090719175737.GA9278@piper.oerlikon.madduck.net>
 <2d5a2c100907191120g79980cebme985bbff2fbb6ef5@mail.gmail.com>
 <20090720052314.GA10357@piper.oerlikon.madduck.net>
 <2d5a2c100907200419x59963511u41db2b35a2285dcf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
In-Reply-To: <2d5a2c100907200419x59963511u41db2b35a2285dcf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2009.07.20.1319 =
+0200]:
> On Mon, Jul 20, 2009 at 2:23 AM, martin f krafft<madduck@madduck.net> wro=
te:
> > It's the wrong way around: I don't want to connect my computer via
> > the phone, I want to give my Palm access to the Net via my computer.
>=20
> Oh sorry, we don't have a solution for this yet... Usually people use
> pan profile when they need such thing.

I don't think this works with the palm, which needs a serial link
and then can speak network over it. It does not have a TCP/IP stack
connected to bluetooth.

> Before replying please check that both NetworkManager and connman
> can be used without any ui, in fact they are daemons normally
> started during the boot.

Yes, I am aware of that. However, both come with a footprint
I generally associate with desktop systems, e.g. dbus, policykit, or
their designs, which have clearly been made with a GUI in mind.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the association on this web site and in peter chappell
 publications, articles and books, made between remedy and diseases
 is used for clarity, but is not the functional reality and does not
 imply these resonances treat any disease. they merely vitalise and
 inform the self healing system."
                                                   -- peter chappell
=20
spamtraps: madduck.bogus@madduck.net

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpkVfQACgkQIgvIgzMMSnVh5gCbB9GmTQe2C6SUGkkLTq/Cfi/w
qQAAn0PGcT9eivEtUg4UiPQq5UlbFnp2
=6fYK
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
