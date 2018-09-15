Return-Path: <pavel@ucw.cz>
Date: Sat, 15 Sep 2018 20:14:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bluez from git: does not compile, bluetoothd crashes
Message-ID: <20180915181419.GA28293@amd>
References: <20180914164258.GA8745@amd>
 <CABBYNZ+k+250iZUJNVOBHgZfpK8Qho9i3YNeYbvvR7pDp2Ab1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <CABBYNZ+k+250iZUJNVOBHgZfpK8Qho9i3YNeYbvvR7pDp2Ab1Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> > I have version e4cf43fc62b4e4dbabc72d4e44e095d7a9087992.
> >
> > It did not compile, so I did this:
> >
> > gcc --version
> > gcc (Debian 4.9.2-10+deb8u1) 4.9.2
>=20
> What is the compilation error?

Does it compile for you? For me it says:

  CC       monitor/broadcom.o
    CCLD     monitor/btmon
    monitor/control.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/packet.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/lmp.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/ll.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/l2cap.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/sdp.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/avctp.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/avdtp.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/a2dp.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/rfcomm.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/bnep.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/intel.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    monitor/broadcom.o: In function `print_bitfield':
    /data/pavel/denx/bt/bluez/monitor/display.h:75: multiple
    definition of `print_bitfield'
    monitor/display.o:/data/pavel/denx/bt/bluez/monitor/display.h:75:
    first defined here
    collect2: error: ld returned 1 exit status
    Makefile:4375: recipe for target 'monitor/btmon' failed
   =20


> > diff --git a/monitor/display.h b/monitor/display.h
> > index 12d13f8..ca85dcc 100644
> > --- a/monitor/display.h
> > +++ b/monitor/display.h
> > @@ -70,6 +70,7 @@ struct bitfield_data {
> >         const char *str;
> >  };
> >
> > +#ifdef WANT_BITFIELD
> >  inline uint64_t print_bitfield(int indent, uint64_t val,
> >                                 const struct bitfield_data *table)
> >  {
> > @@ -85,6 +86,7 @@ inline uint64_t print_bitfield(int indent, uint64_t v=
al,
> >
> >         return mask;
> >  }
> > +#endif
> >
> >  int num_columns(void);
> >
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index aca0761..21fc1dc 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -26,6 +26,7 @@
> >  #include <config.h>
> >  #endif
> >
> > +#define WANT_BITFIELD
> >  #include <stdio.h>
> >  #include <errno.h>
> >  #include <ctype.h>
> >
> > Possibly not nicest fix but it got me version that compiled.
> >
> > I was trying to play with btle, but bluetoothd crashed. That can't be
> > good.
> >
> > pavel@amd:~/denx/bt/bluez$ sudo src/bluetoothd
> > *** Error in `src/bluetoothd': free(): invalid size: 0x08162908 ***
>=20
> Try running with valgrind perhaps we are not handling the timeout properl=
y.

Not sure what is going on. It happened on a first try, but it did not
happen after that, so I don't know how to reproduce it :-(.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAludS/sACgkQMOfwapXb+vJisACeKc9EDRKa1x/wjHY+pFzz5hpp
CKwAnj3tRj2wqKgKgQjD9Hf/XDFztnMT
=ZiJu
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
