Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 23:46:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: PATCH: RFC: Broadcom serdev driver
Message-ID: <20170708214623.fhzrzhcedo2hhov4@earth>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
 <372d1433-376c-8896-60a0-e24bbeede427@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="exnwrk3ddqfgwpew"
In-Reply-To: <372d1433-376c-8896-60a0-e24bbeede427@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--exnwrk3ddqfgwpew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 10:15:50AM +0100, Ian Molton wrote:
> On 08/07/17 08:58, Marcel Holtmann wrote:
> >> -----------------------------------------------------------------------
> >>
> >> 	This patch adds a driver for broadcom BT devices that are
> >> attached as serdev devices.
> >>
> >> A device tree entry such as the following is used with this driver:
> >>
> >>        bcm34340a1: bluetooth {
> >>                compatible =3D "brcm,b43430a1";
> >>                reset-gpios =3D <&gpio5 4 GPIO_ACTIVE_LOW>;
> >> 		bluetooth-wakeup-gpios =3D <&gpio3 27 GPIO_ACTIVE_HIGH>;
> >>
> >> 		init-speed =3D <115200>;
> >>                oper-speed =3D <400000>;
> >>        };
> >=20
> > I would prefer a separate patch for this that includes this also as sam=
ples in the Documentation/bindings directory.
>=20
> No problem - this i just an RFC, so I wasnt sure if you'd like the bindin=
g.
>=20
> >> obj-$(CONFIG_BT_HCIUART_NOKIA)	+=3D hci_nokia.o
> >> +obj-$(CONFIG_BT_HCIUART_BCMBT)	+=3D hci_bcm_serdev.o
> >=20
> > I was actually not wanting to have a separate driver. Like hci_ll.c thi=
s needs to be in hci_bcm.c.
>=20
> I appreciate that, but there are a couple of reasons why I didn't;
>=20
> * The original driver operates quite differently with regards to
> matching the platform data up with a uart - since it has no knowledge of
> the mapping from ttydev to serial device, it maintains a list that it
> matches against during upen - its quite a lot more complex as a result.
>=20
> Being a serdev driver, this one doe not need that code.
>=20
> * I have no way to test the ACPI or wakeup/irq features of the original
> driver, so I could not implement it and be sure it would work.
>=20
> My hope was that we could include this driver, and move a couple of
> common functions it shares with the older driver into btbcm.c
>=20
> Over time, people could add the functionality and we could remove the
> old driver - all without upsetting existing users of the old driver.

The broadcom driver should probably become serdev only at some
point, since it always requires platform support due to the GPIOs
The current solution is a big hack. But tackling that requires ACPI
support for serdev, so I guess that it must be done by somebody
else.

-- Sebastian

--exnwrk3ddqfgwpew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllhUqwACgkQ2O7X88g7
+prqHQ//QGLgw8Of9US8sJGNGfbrxGof0fjMJN7y1urTrSBJgWN8qOzGT/0ZGtum
nvEWODQ8G4zIV2vFqAYivmkxcFPlwVS6UvsS7qPD9Hc+JcxxdJZn20lsGxXenOMj
OvtEcfRA+7187xb4K0ptntEBHmWXhEVolsGO7BDNnedKcbd6Ch8ty+X4IvW0n8QL
2mJPzpoeX2tQPZ073GDILLb4q6wBdheE1umK492HR83oeHmZHbJ0vy5dRidoyRU+
tXWtsvT/IeZvbLGMLzeyCgW8glwUPDU44KqRMP/R5DipKDpKMVdPs8iEKZOl7Hug
YmYdOGP1BEv6EPp3gaHZ8c1oVZmPeu14fRs0OFDy02G/l4hgkSITDnjtquMFiyYc
f9XPt6LepFAlGQY1C18zaZrnYV6S+c20jL1/TvaL7lkJMZZO53HcfTurCiSFcXKN
8H8baUv59sDKNLCF4mQkzmhy3ajkdK7ILEf++P0iYMIOXjA3iNg/EHBzjTzqXOJE
Z6ZRHDN2p1pf/8ZlXCt5nNTCn2IJ7zczVrUQMUHus8SEIsOdSHwlKBGG3kVUb1Iy
XAj/EOwXBsvQl81pUeW3qH1uFxqhSt6qBt8S0XEMQVdtXJDH5Z82u0AEc2Gq69mA
CcPvGiv+6WLXih0e6h0ReeHhrePMNOFrfYic8uquOUL10p5vPJM=
=2nJx
-----END PGP SIGNATURE-----

--exnwrk3ddqfgwpew--
