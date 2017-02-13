Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Feb 2017 08:01:52 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: hci_core: Buggy handling of HCI_SETUP flag in mgmt API
Message-ID: <20170213070152.xub4xijmvnztpf43@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5akxdyfm7fqfu5d"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--n5akxdyfm7fqfu5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While working on the nokia BT driver, I found a strange bug in
bluetooth core support. If the driver's setup routine fails,
a hci0 interface is created with status DOWN, which looks ok.
The management interface is not happy, though:

n950# btmgmt info ; btmgmt config
Index list with 0 items
Unconfigured index list with 0 items

It becomes even more interesting, if I do "hciconfig hci0 up"
(the setup routine only failed due to FW not yet being available
during early boot). At that point btmgmt still fails:

n950# btmgmt info; btmgmt config
Index list with 0 items
Unconfigured index list with 0 items

But the device is up and running from hciconfig's perspective
and hcitool can be used to scan for devices.

I added a few debug prints to the management interface and the
problem is, that HCI_SETUP flag is never cleared, when initial
setup fails. This should be easily reproducible by adding this
to any BT driver's setup routine:

static bool fail = true;
if (fail) {
    fail = false;
    return -ENOENT;
}

I'm not sure about the correct solution to fix this. Initially I
thought the flag just needs to be cleared in the path used by
"hciconfig up". But this would mean, that such a device cannot be
enabled using the management API (since HCI_SETUP would be set
until its cleared by hciconfig).

-- Sebastian

--n5akxdyfm7fqfu5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlihWd4ACgkQ2O7X88g7
+polAw//ddenpwYJwKUTEdZcjpEuyoLMuz9UoMNNlX7Hx22FUr1K4v7xrF0DfS1z
IjrX1m7hMVGIb6MCg/YiC1yseEsH7avTeqjJPjVtNf7a4+y7ohDI6C9dkNFmahEh
sCMdG2t7MtDlBADAdMNHudGJWZJjkOKtd6c2gbtt91DUsGJEJ74aUdHpoZR8u4um
FesfI8aoFsjqR9/iNxSozAH67dJ1p5EO2ctjzSxGGu04+OgAOywUp12rF940PoUD
RhMHC832fzSJYkJ7NOZzSStLo4jpeDhD9E7x5eqest2AUEciox4CgJ1K0NpP2wYe
8SR3xX7pHIVB4Zit3lkwLm70nENa/uVo2P/Q/dL8aoQWA9gBnPyD6E3GnHOFkDkX
aNhLSPjsYJbPWM9Abi+x1FwVRxJeVCB+SaSYChrKE9n0NVwCT90tcTq9rrgAlRTY
H0+iBkD/nxCfpr39J44rFWwAZose6NG4RmHz1X7x8T/5o+B5T4/n466gw/2fMApN
vWlUhARk8g39zBjMx7Vwf6cLl2qGQAGDWob/ne8wUt4zIcl9G9MB4SOUHz8vtyqO
n3d5FMqvpjrOE414DcdKKaFHN6dE2qlf5qld1vtu8pU/aeNcsBUis090LRXjy9YT
VxEn3QexTYQj9bFMere+zcRqeeIVixlx9duQi/zpMMzr0wB5beI=
=kVgn
-----END PGP SIGNATURE-----

--n5akxdyfm7fqfu5d--
