Return-Path: <cyrus@holtmann.org>
Message-ID: <1386951737.23365.19.camel@pc.interlinx.bc.ca>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 13 Dec 2013 11:22:17 -0500
In-Reply-To: <CAJdJm_POfMm8mtbRAWdG9W3F2PwT8kNYkiHYToVZeVz+D1F+TQ@mail.gmail.com>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	 <1386949351.6234.0.camel@nuvo>
	 <1386949827.23365.9.camel@pc.interlinx.bc.ca> <1691350.CipnhsEWy0@uw000953>
	 <CAJdJm_POfMm8mtbRAWdG9W3F2PwT8kNYkiHYToVZeVz+D1F+TQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SM/rBj5KkKjoiSaDklR9"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-SM/rBj5KkKjoiSaDklR9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-12-13 at 14:17 -0200, Anderson Lizardo wrote:
> Hi,
>=20
> On Fri, Dec 13, 2013 at 1:56 PM, Szymon Janc <szymon.janc@tieto.com> wrot=
e:
> >> [bluetooth]# connect 7C:1E:52:6E:59:D2
> >> Attempting to connect to 7C:1E:52:6E:59:D2
> >> Failed to connect: org.bluez.Error.NotReady
> >>
> >> I have this same problem with my previously paired headset also.  Not
> >> connected and won't connect.
> >
> > Is your adapter powered?:)
>=20
> I agree it looks like it's missing "power on" command on bluetoothctl
> here

Hrm.

[bluetooth]# power on
[CHG] Controller 00:02:72:1E:E0:12 Class: 0x0c0104
Changing power on succeeded
[CHG] Controller 00:02:72:1E:E0:12 Powered: yes
[CHG] Device 7C:1E:52:6E:59:D2 Connected: yes

And now the mouse works.  I wonder what happened in the first place to
make it stop running.  Certainly the unplugging/plugging in of the
dongle might have been enough to need it powering on so it's not clear
that it just spontaneously lost power or anything like that.

> (assuming there is no UI applet running that should take care of
> powering it up automatically.)

Which is an interesting point.  What is the UI applet for all of this
supposed to be now in F20?

b.


--=-SM/rBj5KkKjoiSaDklR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSqzQ5AAoJENrB0DQWy8igPqYH/2MWD+8DsLnCgJD1KEA1VTPY
RwmhgqsPX9E7PqjErMy4RE1rwNnovlPZXvC9zl/DUnodDV5zS6zep2L/FYUJeBqd
b5WWtZ8B3Nv0bAwXIJu2fCGRn0UeKQcp6OwZcMYihrLj7lplGzo/+JNgHRWK4SU2
imyeWQeygah5ddCKXaSo89W4QAK4cG3T/MiUm5vCa0sW6gVvn9gulnn6PurxVKyj
dt4kUs2rKohTvDPp5NOY1JSXhGEICM8JlJvqF8baVsoQa9KIi5B6TcDvmRdB1dpE
v2vPgiiOV8QyW+FNfVpl1aLp2ASsHCQV6U+A5y1HpyeOKRDfDHKSzGnQJjF3XUc=
=tQxV
-----END PGP SIGNATURE-----

--=-SM/rBj5KkKjoiSaDklR9--

