Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Mon, 24 Jul 2017 12:23:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170724102357.cj73ujrukrqnl47s@earth>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
 <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
 <20170722211658.fdfcwoqshtrxqvwj@earth>
 <6FFF415F-F875-481B-A6D6-3DD7159C7DDD@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bueoxi5z23qnjqg"
In-Reply-To: <6FFF415F-F875-481B-A6D6-3DD7159C7DDD@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--6bueoxi5z23qnjqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 23, 2017 at 09:32:23AM +0200, Marcel Holtmann wrote:
> >>>> The Nokia devices require the setup of its Public Bluetooth Device
> >>>> Address and for that it is required to depend on vendor specific
> >>>> commands. For Broadcom based Nokia devices, that is part of btbcm
> >>>> module and can be selected via BT_BCM config option.
> >>>>=20
> >>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>=20
> >>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>=20
> >> btw. we need to also provide the set_bdaddr for TI chips.
> >=20
> > The TI based chip in Nokia N950 has a proper address configured, so
> > it works without set_bdaddr (it would still be nice of course). It
> > also seems to be missing for hci_ll, though. So the required command
> > is completly unknown?
>=20
> are these a TI address or a Nokia address? I doubt Nokia would
> have actually shipped any hardware using an IEEE assigned address
> to TI.

I can check this later.

> Where do we have the firmware files for the Nokia devices?

For N950 I extracted it out of the following rpm:

http://repo.merproject.org/obs/nemo:/devel:/hw:/ti:/omap3:/n950-n9/latest_a=
rmv7hl/src/ti-wl1273-bt-firmware-0.23-1.2.Nemo.Adaptation.N950.N9.src.rpm

> Don't they contain a command for setting the BD_ADDR.

I did not check, since the firmware file is not device
specific as far as I know.

> Also the original Nokia driver had code to re-write that command
> inline while loading the firmware.

The address injection happens in hardware specific code (stock driver
supports TI, Broadcom & CSR). In opposit to Broadcom and CSR the TI
specific one does not change the address:

https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/master/drivers=
/bluetooth/hci_h4p/fw-ti1273.c

-- Sebastian

--6bueoxi5z23qnjqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll1yroACgkQ2O7X88g7
+poTFxAAmNFjizaS1XVpzmWMaKT+4E/+jh8QGnteVyAP7DT3514srRDxctMWvqyF
QFqbfsXCV2CrfYAnRz6YBy7dIerQN+D4yVjsiWBx6UEeLnJubfO1E3uGKE9sOsg8
Igz6F1/ELLF/bOQyhVrZgxjLZGNaCVt5JQ0SQl7Fkgt+66EZ4UgawUZ9wBltdLWG
B5UZcPbz5jpwY1UWpgytHX+BlRiS48JBwBIoTqXvbLv05EVRI74AiXgisAT9lfS6
ShxtdIysZ00R2GLr6OF+ir2OVXyiL6ftKkk8vk8L9CvOOJ1+TPJwtmtJBbbfBZHd
sBjw5EksTdpclG15m3S0ubEuV0PjJsATWS8oGHGP4N0j6FWoz2je/WBjdl/pbmtO
BoI34kp4lxU6D1P63CjbujdTkSuR0IOSuqzLjlZXkDKqRKZ0pvifAp81JxExYwXh
etUyQXDWK4pqbEYyZ9d/bCQWPHnYWTl5DUs6DLtrszxbSxLrTz8urdUoq/9OLhNU
Gl8AzRLx1pSZHZD0VwUANiaovS1TgU/kpfuzECi5LFEN0pJWPD+mjwIexhiIlA6g
nV1tnziyp9aizuVsTX29wepy4CzUtGK4JNbvG/r1VnSWmyBccdtFSEOkCffrLTcB
EKN42wgaZ8XuQuJCC2cdKQAuzIbBamXgPu4I/AHfsvM23fKUEDk=
=eRo6
-----END PGP SIGNATURE-----

--6bueoxi5z23qnjqg--
