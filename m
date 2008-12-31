Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Dec 2008 10:43:54 +0100
From: Steffen Pankratz <kratz00@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: hci_usb problem after rmmod/modprobe
Message-ID: <20081231104354.1bf8f381@hermes>
In-Reply-To: <1230668540.30789.1.camel@californication>
References: <20081230211526.5136a798@hermes>
	<1230668540.30789.1.camel@californication>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ge.uEbMcmhk/zrNT+qspKjy";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/Ge.uEbMcmhk/zrNT+qspKjy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2008 21:22:20 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Steffen,
>=20
> > everything is fine until I unload and reload hci_usb:
> >=20
> > hciconfig hci0 up
> > Can't init device hci0: Input/output error (5)
> >=20
> > from dmesg:
> > hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f406cf54 err -2
> >=20
> > I tried 'modprobe hci_usb reset=3D1' which did not solve the problem.
> >=20
> > To get it working again I have to do:
> >=20
> > rmmod hci_usb bluetooth uhci_hcd
> > modprobe uhci_hcd
> > modprobe hci_usb
> >=20
> > Not sure what information could be helpful:
> >=20
> > Linux hermes 2.6.28 #2 PREEMPT Tue Dec 30 16:30:47 CET 2008 i686 i686
> > i386 GNU/Linux
>=20
> if you are using 2.6.28 kernel, then just use the btusb driver instead
> of hci_usb. The hci_usb will be removed with 2.6.29 anyway.
>=20
> Regards
>=20
> Marcel
>=20

Hi Marcel,

thanks for your suggestion.
I am now using the btusb driver but the problem remains,
except the kernel message has changed:

btusb_submit_intr_urb: hci0 urb f61e37c0 submission failed (2)

Regards
-Steffen

--=20
Hermes powered by LFS SVN-20070420 (Linux 2.6.28)

Best regards, Steffen Pankratz.

--Sig_/Ge.uEbMcmhk/zrNT+qspKjy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklbPtoACgkQqmIF0LCII9tb3gCgs/cOlz1dGxG4qiorQvCXbnns
X3IAoM3+jvyayY7cRSmmvGFEkqpAOEKT
=ftaX
-----END PGP SIGNATURE-----

--Sig_/Ge.uEbMcmhk/zrNT+qspKjy--
