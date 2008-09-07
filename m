Return-Path: <cyrus@holtmann.org>
Subject: Re: Bug#498056: Can not control input_service via dbus
From: Joachim Breitner <nomeata@debian.org>
To: Filippo Giunchedi <filippo@debian.org>
Cc: 498056@bugs.debian.org, smartphones-userland@linuxtogo.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20080907104334.GD30302@clamp.esaurito.net>
References: <20080906175056.21875.7529.reportbug@otto.ehbuehl.net>
	 <20080907074017.GB30302@clamp.esaurito.net>
	 <1220781012.3366.16.camel@otto.ehbuehl.net>
	 <20080907104334.GD30302@clamp.esaurito.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RPFcO5mVp/ZVugdqy9mi"
Date: Sun, 07 Sep 2008 15:20:43 +0200
Message-Id: <1220793643.3366.36.camel@otto.ehbuehl.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-RPFcO5mVp/ZVugdqy9mi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[CC=E2=80=99ing linux-bluetooth, maybe you can tell us what=E2=80=99s happe=
ning]

Hi,

Am Sonntag, den 07.09.2008, 12:43 +0200 schrieb Filippo Giunchedi:
> On Sun, Sep 07, 2008 at 11:50:12AM +0200, Joachim Breitner wrote:
> > > that explains the bug, unless I'm missing something of course :)
> >=20
> > it does indeed, but then I wonder why this functionality is present in
> > an openembedded based image for the FreeRunner that runs (supposedly)
> > bluez-utils 3.23-r2, which is older than what=E2=80=99s in Debian, and =
I can not
> > find any patches regarding this...
> >=20
> > And indeed, looking at:
> > http://shr.bearstech.com/sources/bluez-utils-3.23.tar.gz
> > The above code lines are filled with some functionality!
> >=20
> > So looking in the changelog, I see:
> > ver 3.32:
> > 	[..]
> >         Remove HAL support helpers.
> >         Remove inotify support.
> >         Remove service daemon activation handling.
> >         Remove uneeded D-Bus API extension.
> >=20
> > Interesting. Do you have any idea why this was removed? Is there some
> > replacement functionality?
>=20
> Judging from the code above my first guess (offhand) is because services =
migrated
> from external processes to plugins (loaded via g_module_load).
>=20
> Unfortunately I'm unaware of any replacement (though I have not checked t=
he new
> 4.x code)

I=E2=80=99m not sure. I think the dbus interface already is part of the new
plugin based stuff? Also, if I disable the plugin (DisablePlugins=3Dinput
in /etc/bluetooth/main.conf), the whole /org/bluez/service_input dbus
interface disappears.

The relevant diff in upstream=E2=80=99s CVS does unfortunately not tell us =
more
about why this was removed:
http://bluez.cvs.sourceforge.net/bluez/utils/hcid/dbus-service.c?r1=3D1.151=
&r2=3D1.152

So I CC=E2=80=99ed upstream: Would you please explain us why this dbus inte=
rface
was disabled, and what=E2=80=99s supposed to replace it?

Thanks everyone,
Joachim

--=20
Joachim "nomeata" Breitner
Debian Developer
  nomeata@debian.org | ICQ# 74513189 | GPG-Keyid: 4743206C
  JID: nomeata@joachim-breitner.de | http://people.debian.org/~nomeata

--=-RPFcO5mVp/ZVugdqy9mi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjD1ScACgkQ9ijrk0dDIGylTQCff5WQsh8zYrz0pMKBybXAtWTD
uNsAoMqkmgHQ9t+azVpTrRbxu64v/Rfr
=ElJ0
-----END PGP SIGNATURE-----

--=-RPFcO5mVp/ZVugdqy9mi--
