Return-Path: <cyrus@holtmann.org>
Date: Sat, 7 May 2011 01:14:12 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs
 settings
Message-Id: <20110507011412.ba0ad1e9.ospite@studenti.unina.it>
In-Reply-To: <1304644488.16101.28.camel@novo.hadess.net>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	<1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
	<1304644488.16101.28.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__7_May_2011_01_14_12_+0200_m1L=30Z7B48nU6BT"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Sat__7_May_2011_01_14_12_+0200_m1L=30Z7B48nU6BT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 06 May 2011 02:14:38 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> > +                       [AC_LANG_PROGRAM([[
> > +                               #include <sys/ioctl.h>
> > +                               #include <linux/hidraw.h>
> > +                               #if ! (defined(HIDIOCSFEATURE) &&
> > defined(HIDIOCGFEATURE))
> > +                               #error "HIDIOCSFEATURE and
> > HIDIOCGFEATURE are required (linux-libc-dev >=3D 2.6.3x)"
> > +                               #endif
> > +                               ]],=20
>=20
> The only part of the patch I have a problem with is this one.
>=20
> I'd rather the code had:
> #ifndef HIDIOCSFEATURE
> #define HIDIOCSFEATURE bleh
> #endif
>=20
> And gracefully handled the ioctl not being available on the running
> kernel (eg. "Not handling plugged in Sixaxis joypad because the kernel
> lacks HIDIOCSFEATURE support").
>

Thinking twice about that, maybe I haven't fully understood what you
mean.

Do you want that the plugin can be enabled and _compiled_ on _older_
kernels as well?

Because about compiling on _supported_ ones and then _running_ it on
_older_ ones, well, the ioctl return values are already checked and
they should just (gracefully?) fail on unsupported kernels. But I'll
double check this scenario.

If you want indeed it to be _compiled_ on older kernels and nonetheless
still work on supported ones, I think we just have to copy the iotcls
request defines from hidraw.h if they are not defined but I still don't
know if I like that.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__7_May_2011_01_14_12_+0200_m1L=30Z7B48nU6BT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3EgMQACgkQ5xr2akVTsAGiVACbB2x6eiQ9qOMSUW46rpu0XO2o
/O0AnijqRSImnpNHabur9gOgtLQAoQit
=OFRL
-----END PGP SIGNATURE-----

--Signature=_Sat__7_May_2011_01_14_12_+0200_m1L=30Z7B48nU6BT--
