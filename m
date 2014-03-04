Return-Path: <cyrus@holtmann.org>
Message-ID: <1393955100.16179.0.camel@melech-server.localdomain>
Subject: Re: cannot connect Rock Candy Gesture Controller (wiimote) on Arch
 Linux
From: "Mark E. Lee" <mark@markelee.com>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 04 Mar 2014 12:45:00 -0500
In-Reply-To: <1393903271.6313.3.camel@melech-server.localdomain>
References: <1393903271.6313.3.camel@melech-server.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-zj58Kk3ltuDIf9gSuTZD"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-zj58Kk3ltuDIf9gSuTZD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-03-03 at 22:21 -0500, Mark E. Lee wrote:
> Salutations,
>=20
> I recently purchased an off-brand wiimote from Target (USA). It is the
> Rock Candy Gesture Controller (w/o motion plus). I have been unable to
> connect to it via bluetooth on Arch Linux 64-bit (bluez 5.15-1). This
> issue has been reported on GitHub
> <https://github.com/dvdhrm/xwiimote/issues/43#issuecomment-36577704>.
> I've reiterated my tests with the device below :
>=20
> --OUTPUT of $ hcitool inq --iac=3Dliac
> Inquiring ...
>=20
> 00:17:AB:39:1C:70 clock offset: 0x5574 class: 0x002504
>=20
> ---OUTPUT of # hcitool info 00:17:AB:39:1C:70---
> Inquiring ...
> Requesting information ...
> BD Address: 00:17:AB:39:1C:70
> OUI Company: Nintendo Co., Ltd. (00-17-AB)
> Device Name: Nintendo RVL-CNT-01
> LMP Version: 3.0 (0x5) LMP Subversion: 0xc
> Manufacturer: not assigned (771)
> Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
>=20
>=20
> ---OUTPUT of $ hcitool inq---
>=20
> Inquiring ...
>=20
> ---OUTPUT of $ hcitool scan---
>=20
> Scanning ...
>=20
> ---OUTPUT of $ sdptool browse 00:17:AB:39:1C:70---
> Browsing 00:17:AB:39:1C:70 ...
>=20
> Service Search failed: Connection timed out
>=20
> ---OUTPUT of $ bluetoothctl; connect 00:17:AB:39:1C:70---
>=20
> Device 00:17:AB:39:1C:70 not available
>=20
> ---OUTPUT of $ sdptool search 00:17:AB:39:1C:70---
>=20
> Unknown service 00:17:AB:39:1C:70
> ----
>=20
> Any help towards getting this device to work?
>=20

Salutations,

I don't have much experience in coding for the wiimote, I was wondering
if this is simply a wii_id issue in plugins/wiimote.c. How do I find the
wii_id of the remote?

Regards,
Mark

--=20
Mark E. Lee <mark@markelee.com>

--=-zj58Kk3ltuDIf9gSuTZD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EABEIAAYFAlMWER4ACgkQZ/Z80n6+J/ZyRgD/R1EoxlJ0vcGx/t0onPCVB+eG
ZTSo0dpBpHcaInYukpYA+gJv2YxYbegOegGRnY+1CszwxDhIqLQBErWszBy5tFVU
=aOrw
-----END PGP SIGNATURE-----

--=-zj58Kk3ltuDIf9gSuTZD--

