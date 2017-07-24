Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Mon, 24 Jul 2017 20:48:10 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170724184810.pqpvsgz63tmsjot5@earth>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
 <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
 <20170722211658.fdfcwoqshtrxqvwj@earth>
 <6FFF415F-F875-481B-A6D6-3DD7159C7DDD@holtmann.org>
 <20170724102357.cj73ujrukrqnl47s@earth>
 <C99B9ECC-75CD-4945-BF49-496B66C19493@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26nyvlbyhijdx7d4"
In-Reply-To: <C99B9ECC-75CD-4945-BF49-496B66C19493@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--26nyvlbyhijdx7d4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 24, 2017 at 07:09:08PM +0200, Marcel Holtmann wrote:
> >>>>>> The Nokia devices require the setup of its Public Bluetooth Device
> >>>>>> Address and for that it is required to depend on vendor specific
> >>>>>> commands. For Broadcom based Nokia devices, that is part of btbcm
> >>>>>> module and can be selected via BT_BCM config option.
> >>>>>>=20
> >>>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>>>=20
> >>>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>>>=20
> >>>> btw. we need to also provide the set_bdaddr for TI chips.
> >>>=20
> >>> The TI based chip in Nokia N950 has a proper address configured, so
> >>> it works without set_bdaddr (it would still be nice of course). It
> >>> also seems to be missing for hci_ll, though. So the required command
> >>> is completly unknown?
> >>=20
> >> are these a TI address or a Nokia address? I doubt Nokia would
> >> have actually shipped any hardware using an IEEE assigned address
> >> to TI.
> >=20
> > I can check this later.
> >=20
> >> Where do we have the firmware files for the Nokia devices?
> >=20
> > For N950 I extracted it out of the following rpm:
> >=20
> > http://repo.merproject.org/obs/nemo:/devel:/hw:/ti:/omap3:/n950-n9/late=
st_armv7hl/src/ti-wl1273-bt-firmware-0.23-1.2.Nemo.Adaptation.N950.N9.src.r=
pm
> >=20
> >> Don't they contain a command for setting the BD_ADDR.
> >=20
> > I did not check, since the firmware file is not device
> > specific as far as I know.
>=20
> doen't matter since the old Nokia written driver hacked it from a
> sysfs file and the address came from the secure flash area.

The sysfs "just" puts the address into platform_data for their h4p
driver. It does not take care of applying it to the hardware. That
is the job of their h4p driver. Here is the code for the sysfs file:

https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/master/arch/ar=
m/mach-omap2/board-omap-bt.c

> >> Also the original Nokia driver had code to re-write that command
> >> inline while loading the firmware.
> >=20
> > The address injection happens in hardware specific code (stock driver
> > supports TI, Broadcom & CSR). In opposit to Broadcom and CSR the TI
> > specific one does not change the address:
> >=20
> > https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/master/dri=
vers/bluetooth/hci_h4p/fw-ti1273.c
>=20
> As far as I know they rewrite the Write BD_ADDR command of each
> vendor at the time before they send to the hardware.

You can clearly see that they modify the address in the hardware
specific firmware files for Broadcom and CSR:

https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/master/drivers=
/bluetooth/hci_h4p/fw-bcm.c
https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/master/drivers=
/bluetooth/hci_h4p/fw-csr.c

But there is no such code for TI (except for a comment):

/* Check if this is bd_address packet */

I think they just forgot to implement it and since the
comment has no XXX/TODO/FIXME prefix nobody noticed it.

-- Sebastian

--26nyvlbyhijdx7d4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2QOgACgkQ2O7X88g7
+prweBAAj5VXVNDgkiJ90bs15hywY7RIhMvdD1VAd1MYvFE2t98nS5jBkPp143WZ
ghufvC/OHyecOTX9TTQLqq9DQCIK4IgSMH47nu0W/ZQ7oTvsat2ZLoBPAssQioXA
cZ/3i1JOnpHnlTyKMVFQEMFdsslpZ7OMA/j1pd26uehwIpF2bvSRWjuqLF4o3IPJ
hYuAmvVk1kHthkiQnekaOEAE979KQ6mdvBNCSDLuwals9mtIgNQnEJ7gbS3xyuQi
nY3R4i+QvaOU5AuBsp4oTMwsQcP582vw/bV6VwziwLYq9TQ79Qr/52gYZovV7ZuN
T+O+phUFm567pag09J6nDbu18JhvY+qo+blVC9/eN8wlRKbyTERJDj2V5q9G0336
bvmgQsKGlBFkpNAEaHqNcUf4cwJdsTAuvLHtdOXh6yYrtjS9mo0h2GvbDrBy+BcU
EQAJBtg3HfNiYwK3EDhiesnR03wv6X6p05kKIT7AiFTm82xImNXcgZWjjpY5fJly
nrkXZiEf8Nf7X/jptaOmIfiaU9/uBx2FfYnNRa7HEVblB7PCQWmvkUBcJ9ztXeoK
CowPqn0Y1IrVJI1O3R6ID8YKWM5MsyfnTcvECRiPgpHNxuojIPJsLXusOHKoXJ8N
dIc83jZoqojmjgDl9/hmCnVy1sES2/YODZINnlmDO/OMutgGP0M=
=KaXW
-----END PGP SIGNATURE-----

--26nyvlbyhijdx7d4--
