Return-Path: <pomac@vapor.com>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095842833.5762.27.camel@pegasus>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SUZlsYQbkGtN/x4v9r1M"
Message-Id: <1095877600.3211.15.camel@big>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 20:26:40 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-SUZlsYQbkGtN/x4v9r1M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 10:47, Marcel Holtmann wrote:
> Hi Ian,
>=20
> > Since some kernel version i can't exactly remember which, i have been
> > unable to use usb, i have tested with with 2.6.8 -> 2.6.9-rc2-bk7 and i
> > also applied your patches for 2.6.8.
> >=20
> > I have 2 usb dongles, one old that did work once, and one new that seem=
s
> > to be working like the older but it doesn't work with linux.
> >=20
> > Both are based on the CSR chipset, here is the new ones entry from the
> > hw support list:
> > MSI MS-6967 CSR 1.1 hci_usb working Dave Beckett
> >=20
> > Som logs from insertions:
> > usb 1-3.4: new full speed USB device using address 12
> > ehci_hcd 0000:00:02.2: qh f7e54780 (#0) state 1
> > hci_usb_intr_rx_submit: hci0 intr rx submit failed urb d968cd74 err -28
> >=20
> > usb 1-4.4: new full speed USB device using address 13
> > ehci_hcd 0000:00:02.2: qh f7e54900 (#0) state 1
> > hci_usb_intr_rx_submit: hci1 intr rx submit failed urb d315eef4 err -28
> >=20
> > both of these are connected to usb 2.0 hubs (this machine does usb 2.0)
>=20
> this looks like an USB problem to me. Try to connect it to USB 1.1 ports
> and see if this works.

The problem is, this computer doesn't have a usb 1.1 port.
But it should basically fallback, and afair it worked with a cable
direct to the computer, i haven't tested that since... because i need
the hubs.

But if it indeed is a usb 1.1  vs 2.0 problem then it has to be
something broken in the kernel... Anyone else using this with usb 2.0?

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-SUZlsYQbkGtN/x4v9r1M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUcPg7F3Euyc51N8RAu4dAJ9XQpnqkIbM0MESri4Gbo06n7HzBgCglM6+
Z0SBjyltc+6qus+v2WNBq5Y=
=Ob7Y
-----END PGP SIGNATURE-----

--=-SUZlsYQbkGtN/x4v9r1M--
