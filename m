Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 15:48:22 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Out of tree plugins
Message-Id: <20111116154822.5c18a3a18800474536b70551@studenti.unina.it>
In-Reply-To: <CAMOw1v4YrqrpVYiiEE5cUj0Zx7p=KRopskMA2pYLJMFa7fTusA@mail.gmail.com>
References: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
	<CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
	<CAOazyz1MXi1v3O7RC-dTLhrLgPJ1Zk4+iKNu0ZMHQyFah1OFJg@mail.gmail.com>
	<CAMOw1v4YrqrpVYiiEE5cUj0Zx7p=KRopskMA2pYLJMFa7fTusA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__16_Nov_2011_15_48_22_+0100_ml8h4zb85yABllij"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Wed__16_Nov_2011_15_48_22_+0100_ml8h4zb85yABllij
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Nov 2011 21:42:21 -0200
Lucas De Marchi <lucas.demarchi@profusion.mobi> wrote:

> On Fri, Nov 11, 2011 at 8:25 PM, Alon Bar-Lev <alon.barlev@gmail.com> wro=
te:
> > Hello,
> >
> > On Fri, Nov 11, 2011 at 11:59 PM, Lucas De Marchi
> > <lucas.demarchi@profusion.mobi> wrote:
> >> Hi Alon
> >>
> >> On Fri, Nov 11, 2011 at 7:08 PM, Alon Bar-Lev <alon.barlev@gmail.com> =
wrote:
> >>> Hello,
> >>>
> >>> Reading the tread about Sixaxis [1], and actually want to use this de=
vice...
> >>>
> >>> I could not figure out the end conclusion... as discussion was
> >>> terminated in the middle.
> >>>

Alon, you can look at here to see what direction the discussion was
taking:

http://thread.gmane.org/gmane.linux.bluez.kernel/16540

a proper review of this proposal by BlueZ developer is still needed.

[...]=20
> The goal here is not to be able to build out of tree, but just as
> module or builtin.
>

I can see Luca's argument here, AFAICS in BlueZ modularity of plugins is
meant for object size reasons and for linking dependencies (think to
udev for the sixaxis/plystation-peripheral plugin); plugins are
still bound to the symbols provided by a matching bluetoothd, BlueZ
devs do not want to keep a =E2=80=9Csuper stable=E2=80=9D public API for ou=
t-of-tree
plugins, having the possibility of out-of-tree plugins is considered
just a side effect of modularity here with no promises at all.

Sorry if I skipped other parts of the discussion, not enough time.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__16_Nov_2011_15_48_22_+0100_ml8h4zb85yABllij
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7DzTYACgkQ5xr2akVTsAG6GQCgpD8W8i7arMlPs2y/FlvzU8X+
U54An1I9Iu3hwR/mdc16OzC8vPVtL9nr
=iwga
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Nov_2011_15_48_22_+0100_ml8h4zb85yABllij--
