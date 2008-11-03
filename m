Return-Path: <cyrus@holtmann.org>
Message-ID: <490F6861.5060704@dell.com>
Date: Mon, 03 Nov 2008 15:08:49 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Isa=EDas_Mart=EDnez_Yelmo?= <isaiasmy@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Dell 365 Bluetooth
References: <200811031947.40187.isaiasmy@gmail.com> 	<490F4B17.9070703@dell.com> <200811032158.21654.isaiasmy@gmail.com>
In-Reply-To: <200811032158.21654.isaiasmy@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03864092A8B1C1878ACCCCA2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03864092A8B1C1878ACCCCA2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Isaias:

Isa=EDas Mart=EDnez Yelmo wrote:
> El Monday 03 November 2008 20:03:51 Mario Limonciello escribi=F3:
>  =20
>
> Hello,
>
> I'm not very sure on how to enable the option that you mention, sorry. =
I've=20
> include in /etc/modprobe.d/options the next line:
>
> options btusb=3D1
>
> but I don't know if this is right. The dmesg command shows these lines =
related=20
> with hid2hci:
>
> [   12.458741] usb 1-1.2: usbfs: process 2746 (hid2hci) did not claim=20
> interface 0 before use
> [   24.365796] usb 1-1.2: usbfs: process 5909 (hid2hci) did not claim=20
> interface 0 before use
>
> Perhaps, it could be relevant.
>
> Let me know, if I have to enable the option in other way.
>
> Regards,
>
> Isaias
>
>  =20
Sorry, I mistyped before.  The modprobe options should be:

options btusb reset=3D1

See if that does your device any good.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig03864092A8B1C1878ACCCCA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkPaGEACgkQ2CrZjkA73YuZ3wCfSwiVbOIbEt0lwQ/9aW4osvzh
NDQAoJ9y7pSNmBAqg0prD1MDle89oejw
=kXWw
-----END PGP SIGNATURE-----

--------------enig03864092A8B1C1878ACCCCA2--
