Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1099744491.6919.39.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fyCSjJ6zj9iOUWzK6Cpx"
Message-Id: <1099771915.4563.9.camel@localhost>
Mime-Version: 1.0
Date: Sun, 07 Nov 2004 09:11:55 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-fyCSjJ6zj9iOUWzK6Cpx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcell,

On Sun, 2004-11-07 at 01:34, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Finally figured out what is wrong.  There is definitely a Powerpc
> > problem with the BT HIDPGETCONNLIST ioctl on the powerpc arch.
> >=20
> > The HID ioctl HIDPGETCONNLIST is not returning any HID device entries
> > from the kernel on the Powerpc architecture, even when a blue-tooth
> > keyboard and mouse are working.
> >=20
> > In Debian's boot scripts hidd --killall  is used to nicely close the
> > connections so that the devices will reconnect cleanly on next boot.=20
> > This is not working for me as the above ioctl is not returning a list i=
f
> > addresses to be acted on.
> >=20
> > Work around for me will be to explicitly kill each device address befor=
e
> > stopping hidd, as hidd --kill <device address> works.  Does this mean
> > that the devices are registering in the hidp module, but there is a
> > problem in passing the list back out of the kernel?
>=20
> does "hidd --show" works?

Definitely does not work.  The above kernel ioctl appears to be busted
(or the add HID device stuff is as it is not updating the in kernel HID
device list).  Read the source code for hidd, comparing against strace
output for "hidd --show".  hidd is running as the BT dongle is in HCi
mode, and I am typing this.



> > Do you have access to a powerpc machine to test this on?  Could you giv=
e
> > me any instructions on getting the hidp.ko module to produce the debug
> > that would be useful?
> >=20
> > It would be good to get this one solved, as I would like to look at
> > shallower bugs which I can knock off myself. First look at the hidp cod=
e
> > with this one freaked me out a bit.
>=20
> I don't have access to a PowerPC machine. What Apple is this?
>=20

2004 Powerbook 15" Al, 1.33GHz G4, 768 MB RAM, built-in Apple bluetooth,
ATI Radeon video.

Also occurs on my 450MHz g3 PowerMac, with Logitech BT dongle...

I could probably give you access and work with you over say IRC or gaim
in testing this (I have cable with a static IP!), as this is a generic
powerpc problem, and I can remove sensitive stuff off my G3.

> Regards
>=20
> Marcel
>=20

Regards,

Matthew Grant

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-fyCSjJ6zj9iOUWzK6Cpx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBjTAKuk55Di7iAnARAvlKAJoCc2mjoMspoDhBu5yPr7h341ltDACdFoKL
nluwMF4H9NX0ySG6D7ps17c=
=ot1I
-----END PGP SIGNATURE-----

--=-fyCSjJ6zj9iOUWzK6Cpx--
