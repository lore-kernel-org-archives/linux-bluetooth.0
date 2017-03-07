Return-Path: <sre@kernel.org>
Date: Tue, 7 Mar 2017 22:18:38 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] serdev: add serdev_device_set_rts
Message-ID: <20170307211838.f267lj4nhs5j644i@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-10-sre@kernel.org>
 <CAL_Jsq+N3GU2Dry2uMaF+zxE6+d2aGmfZui-J2MGOWAUJNoH5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zufhu4rewuqpo2bb"
In-Reply-To: <CAL_Jsq+N3GU2Dry2uMaF+zxE6+d2aGmfZui-J2MGOWAUJNoH5w@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--zufhu4rewuqpo2bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Mar 07, 2017 at 10:07:56AM -0600, Rob Herring wrote:
> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Add function to enable/disable RTS line.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
>=20
> > +static void ttyport_set_rts(struct serdev_controller *ctrl, bool enabl=
e)
> > +{
> > +       struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> > +       struct tty_struct *tty =3D serport->tty;
> > +       int status =3D tty->driver->ops->tiocmget(tty);
> > +       unsigned int set =3D 0;
> > +       unsigned int clear =3D 0;
> > +
> > +       if (enable) {
> > +               set |=3D (TIOCM_OUT2 | TIOCM_RTS);
> > +               clear =3D ~set;
> > +               set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> > +                      TIOCM_OUT2 | TIOCM_LOOP;
> > +               clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> > +                        TIOCM_OUT2 | TIOCM_LOOP;
> > +               status =3D tty->driver->ops->tiocmset(tty, set, clear);
> > +       } else {
> > +               set &=3D ~(TIOCM_OUT2 | TIOCM_RTS);
> > +               clear =3D ~set;
> > +               set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> > +                      TIOCM_OUT2 | TIOCM_LOOP;
> > +               clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> > +                        TIOCM_OUT2 | TIOCM_LOOP;
> > +               status =3D tty->driver->ops->tiocmset(tty, set, clear);
>=20
> The logic here can be greatly simplified. Here's a patch to the
> original version that I came up with, but haven't tested:

ah I totally forgot to clean that mess. I took that over from the
bluetooth code, since that got the nokia bluetooth chips working.
I will do this in the next revision.

-- Sebastian

--zufhu4rewuqpo2bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli/I64ACgkQ2O7X88g7
+poh0A/+Nmk5DUclOvGo+O6e1qUV8xl3uJynUtebxCK+bgejx/n2iMVCX4hl5IxH
l2qWnYsjis8jFBgSRfvS3zx48gQchZKRgWFXxxCZeRPLE14KLEcksSjWws3f8Ndd
d7MfsWieHSaSRPoIt+OHSoj3SD/xg3LwtihRQtMXFuHVQmPbREVUtXV74kp0A7Zd
j8PhnG2xCn8Ih1MF8dEwKS7fL8ZBmG1G6MIe/7+aUIgeeyO7AgzWA1xLfzbJGLnQ
aAdb5rmc+ZPU6kZ+Q7SjFuMrU8WSzhlqQpqh7l4tAugRc6w3cSrRbOUoNMcuDF2l
ImVDAPNJXzlOsubTnMydBCQJhcNV8U8T1Dr4h+vzfpE3GMciPHhKI9Tu+v5ugOFJ
kGo7bdGYkTO1UKqOk+SylgW9XuKxQ/HTAQpEIVdnO/i4/U0lnB+wHIF61GxXVgL5
oeco6VhYIS2D8bhojzSUuCWsdMjgHZgDsFoy/MEvu/ZmJN+E8yaZYk7VFD1gqgly
RBZpb58y5JZH0PJGWVBTlVcqFSgNjGKjwDfY485Bzkf/yRoMrX74CMvwBQkmHUge
kFokQNL5NHxxXjoVsIMdpz146Z/QuB4hf9X9kNpNY+KvEX+GXiK1qLtdzMZSM5DD
Jl+Nl3u10ME7IA9UoUX0K3rMgD/CVoT/ZnDBghF2v4Y7OgT4JBE=
=NkqT
-----END PGP SIGNATURE-----

--zufhu4rewuqpo2bb--
