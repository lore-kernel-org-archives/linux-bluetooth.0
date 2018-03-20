Return-Path: <sre@kernel.org>
Date: Tue, 20 Mar 2018 18:28:27 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	robh@kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Message-ID: <20180320172827.ohla5v4a23v3u3qq@earth.universe>
References: <20180320083704.11705-1-marcel@holtmann.org>
 <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56z2bbbch5angq5m"
In-Reply-To: <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--56z2bbbch5angq5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 20, 2018 at 04:50:37PM +0100, Marcel Holtmann wrote:
> Hi,
>=20
> > The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
> > few extra events and thus can also use the h4_recv_buf helper. Instead
> > of open coding the same funtionality add the extra events to the packet
> > description table and use h4_recv_buf.
> >=20
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> > drivers/bluetooth/Kconfig  |   1 +
> > drivers/bluetooth/hci_ll.c | 214 +++++++++++++++-----------------------=
-------
> > 2 files changed, 70 insertions(+), 145 deletions(-)
>=20
> is anybody able to test this change for me and verify that it doesn=E2=80=
=99t break things.

The diffstat looks nice :) I can give it a test on Motorola Droid 4
later this week. If you want feedback a bit earlier, maybe Tony
can give it a try (added to cc).

-- Sebastian

--56z2bbbch5angq5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqxRLQACgkQ2O7X88g7
+przsg//RDkFGFLzzTaTOlUPUppAyi4tB2WnAIR5lBajQw5od1XhCNRTmerm00w8
b7bwvs0PiWZ6A8uQzvw/+9UKAobncTFT4MOtgIe10PxA9ySh/D7q3rJNmlv+LoWv
VqW3RBREKaTpLGIb+bjo50To5plxCsge4UAJCDIkJN202P6jd7oveYLUTqrEcqHP
Ij/Rpzcdhp5nWhaDJpX7IwGlzAnYFd5REEe+RiGEwljKxHndYk+AD3mJjOpu0Mkc
pcbENsv40FaInHE1jTTITuYaTYNE5DYj9q7TYnusvUGuZpVMaBt08Yc4W/Si3LqV
+inb76XE3dJQegeTVFMbwKFGLrLRNmkf2FvS9EtweFgIHWTxMAFA0Q5VLPetHw3v
ANmv8BswsQoJRcqXuDOzENMYXxr6gDHRGjl4pDHwJo2y0AWLgcCrm1xOn+UDod1l
BuoigeF2pgnPF4aVqaRqZuQBVhLYg0okC2kJJBrPjFViuGddH3h8xQUhiqwFSVCY
9ZJ7u9PyrvAZTwWzVVEIHCh2ORjJYgecYUaq7D5v+FdbkLeMmzTUHEuMCk7El4PN
QKBq8/xYzfTulpfQ7+w/n2/y1KUKj78YLKiWzA++toXLHB7rODBC03Yrf/fpTOgr
YMt6F/5UFcIuNaYrwQ+GN18XAVQYtT2sldGmAHGCKBRoGJOibWM=
=+xvJ
-----END PGP SIGNATURE-----

--56z2bbbch5angq5m--
