Return-Path: <sre@kernel.org>
Date: Mon, 13 Feb 2017 23:00:21 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: hci_core: Buggy handling of HCI_SETUP flag in mgmt API
Message-ID: <20170213220021.kgec5y2voxc2ighi@earth>
References: <20170213070152.xub4xijmvnztpf43@earth>
 <0ED8F56A-0542-4462-AE99-AFEB56AFB205@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="smpuijrdk3iku4jw"
In-Reply-To: <0ED8F56A-0542-4462-AE99-AFEB56AFB205@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--smpuijrdk3iku4jw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 13, 2017 at 10:34:26AM +0100, Marcel Holtmann wrote:
> > While working on the nokia BT driver, I found a strange bug in
> > bluetooth core support. If the driver's setup routine fails,
> > a hci0 interface is created with status DOWN, which looks ok.
> > The management interface is not happy, though:
> >=20
> > n950# btmgmt info ; btmgmt config
> > Index list with 0 items
> > Unconfigured index list with 0 items
> >=20
> > It becomes even more interesting, if I do "hciconfig hci0 up"
> > (the setup routine only failed due to FW not yet being available
> > during early boot). At that point btmgmt still fails:
> >=20
> > n950# btmgmt info; btmgmt config
> > Index list with 0 items
> > Unconfigured index list with 0 items
> >=20
> > But the device is up and running from hciconfig's perspective
> > and hcitool can be used to scan for devices.
> >=20
> > I added a few debug prints to the management interface and the
> > problem is, that HCI_SETUP flag is never cleared, when initial
> > setup fails. This should be easily reproducible by adding this
> > to any BT driver's setup routine:
> >=20
> > static bool fail =3D true;
> > if (fail) {
> >    fail =3D false;
> >    return -ENOENT;
> > }
> >=20
> > I'm not sure about the correct solution to fix this. Initially I
> > thought the flag just needs to be cleared in the path used by
> > "hciconfig up". But this would mean, that such a device cannot be
> > enabled using the management API (since HCI_SETUP would be set
> > until its cleared by hciconfig).
>=20
> so the legacy (aka old and don=E2=80=99t use it anymore) ioctl that
> hciconfig triggers for bringing an interface up should in theory
> do the same as Set Power from mgmt. At least from a BR/EDR
> perspective since for LE it is a lot more complicated. However
> this also includes Secure Connections and OOB pairing where you
> need mgmt to function properly.

ioctl calls hci_dev_do_open() directly and the mgmt interface uses
hci_power_on(), which does a few extra things. As far as I can tell
the ioctl should also do the extra things from hci_power_on().
Basically the extra things are: clear HCI_SETUP flag & call
mgmt_index_added. Otherwise using the legacy API results in
inconsistent mgmt state.

> That all said, there might be some race condition here in case
> hdev->setup returns a negative error. Actually if hdev->setup
> fails the controller should be marked as non-functional. That
> would mean mark it as RAW only device. I think that is how we have
> treated this. Which means you can bring it up with hciconfig=E2=80=99s
> ioctl or use it as HCI User Channel, but the Bluetooth core stack
> will never touch it again.

For me it happens reliably if setup fails initially. Also as far as
I can tell this can potentially happen with all BT drivers loading a
FW in their setup routine.

I added a few more debug prints for further information. During
initial start hci_power_on() is called and fails when calling
hci_dev_do_open(). As a result mgmt_set_powered_failed() is called.
The HCI_SETUP flag is only removed after succesfully calling the
setup routine.

Now in the mgmt API the index lists (read_index_list,
read_unconf_index_list and read_ext_index_list) all
use the following loop, which ignores devices with
the HCI_SETUP flag set:

list_for_each_entry(d, &hci_dev_list, list) {
    if (hci_dev_test_flag(d, HCI_SETUP) ||
        hci_dev_test_flag(d, HCI_CONFIG) ||
        hci_dev_test_flag(d, HCI_USER_CHANNEL))
        continue;

    ...
}

I wonder if it would be ok to just list a device with HCI_SETUP
flag _and_ power status=3Dfailed as unpowered device in the management
interface? For using the device it would have to be powered on
first, which will result in running setup routine again. If it
fails again mgmt_set_powered_failed() will be called.

-- Sebastian

--smpuijrdk3iku4jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliiLHIACgkQ2O7X88g7
+pr2Qw//ZhUsARPznsUZDoUMgcOzo4PLuBumz3EOszTwG7KiOSuyt2Fx9QHRZEtn
/7wxqhYTEArsOcXOw8nscBJ566g93s1rlbSNZPTcgGHYLSq3k0c9ujcBtabEBwkA
u+laxb1km1Flc0JzfrUFCk3K6dZP5fspRtUDhpWb2D1B77UE7er7XKmUB9ge8lSJ
vV5QVBORrYB/zYA1AFHvsBrDAWz1qo6lkn91low+R+/bq8wmQFyiF/uaAqxOQETA
MmsBaZn4wmfSAhpkHJ110R9qvrY+G2pgtGDmW0Fd1XoqO/IYh0mo+1CnTM/hPLJT
m/L4+m/YaVIDhKDfKBHD+eryz97vCs36cUHLjGRte8HXfCMnE0JSmTSyfNOWjYk2
AKNO25p1WNbsDuPO2qdfukaz6AbPi0n/AVC6bcP79l58wLCoqlKKUWq4ZwVzye+Y
r2fmV9NSYCRfIZuU10p6ZJ4I8fnfEkeKc0vqUJuAd+2p8ksTcnpu+61ROwCu/pbU
Fja+1TO3bN4zikTqcmFBf8/h4Hd3CeGUVSVs3Q1P1B7dLD8XU0cKbj5RDrVjzS2b
7FTQWlTg6/6s6stdaAkoEBKjUgEwsQYPxIkESnIRzOHDJcSRjRt+Kj7WQtEz8Xlx
YBpfOs2OY1wI8Tu1KNy9cJ/Uii7KF7P0GQvzaqWt7w74OY2+l4A=
=aGhg
-----END PGP SIGNATURE-----

--smpuijrdk3iku4jw--
