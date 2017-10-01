Return-Path: <sre@kernel.org>
Date: Sun, 1 Oct 2017 12:35:09 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
Message-ID: <20171001103509.4jqlt6kuqgxlm5m5@earth>
References: <20170907202551.26796-1-hdegoede@redhat.com>
 <20170907202551.26796-2-hdegoede@redhat.com>
 <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnaqu636ujkkwqei"
In-Reply-To: <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--wnaqu636ujkkwqei
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, Oct 01, 2017 at 11:27:45AM +0200, Hans de Goede wrote:
> This will happen automatically with this patch series,
> but with the current 4.14 bluetooth stack it will work in
> USB mode, and if we then merge this series post 4.14
> bluetooth will stop working without users doing a btattach
> command from userspace and we will have a regression on
> our hands.

Once the series from Fr=E9d=E9ric Danis lands, you can get
serial based broadcom bluetooth without btattach:

https://www.spinics.net/lists/linux-bluetooth/msg71856.html

-- Sebastian

--wnaqu636ujkkwqei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnQxNoACgkQ2O7X88g7
+prziQ/+OLboWw+8rr9D4/9yGJld6iuZNWE1rEZyQlOmInd0RKi4IeT8drQmAsqn
QdyiabecVWqfVv9MFcHtLs6x97Wb6VVv3YA7xGE8aW2RPh7FdIf72ZRaM7icTzY6
RgrVeUtYyZtlxcvHgnFis4N52vlWuxZpTK+M9eSkwGomYXz8DOxCeByp5QgEevs8
8GvY3bGPhqxTI/FiDdJhKz1rZilOkn9YAFnTld1rA3IosNOSC7F1Sbwx0h0PiHbG
LY6Km/RaX66gskj9wtEaEiIzgriSw7d61q7evVrluBcj5zFG4VZVil7Xw+zaDZ1h
K68qRKDpip2trAQr1nEsf5E7aBzTFvzJ8KW0IJV6eTtaM4j/t5GjIyrpd3P0tPLJ
2AIwsySgCZG2KMGYu9qxltDW6HPv7vgoWAx50ZdULOfMVqWmqyEvsx8V3YiIvrr0
F3Pl6IrxcKs0fMrVNcFNzXAGUDZV7mKJCorav0BTjWFrIYUb4uT2s+5eB1Qr2UM/
G4NRiD7pCpEGRVQrgy7ZOyscaZ6TG8Nqa4+wlOw2Uc5Y5EdBs6S9Fs1atXzgyL3t
kKO8/KqsIijQ9cgVsS1I5/j0Qz2rRI5S2osMWJb0KrWLF6JOdxMDes6tISKR4TuE
d0YgWuPzxR2KobFvi4sGK01j2jzYCXglSnl9G2fbAyVLSc8RHd8=
=xbsL
-----END PGP SIGNATURE-----

--wnaqu636ujkkwqei--
