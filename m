Return-Path: <cyrus@holtmann.org>
Message-ID: <1387130038.12172.93.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] linux-firmware: Update Intel Bluetooth devices firmware
 patch files
From: Ben Hutchings <ben@decadent.org.uk>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: dwmw2@infradead.org, don.try@intel.com,
	linux-bluetooth@vger.kernel.org
Date: Sun, 15 Dec 2013 17:53:58 +0000
In-Reply-To: <20131113172123.5702c78d@han1-desk-dev>
References: <20131113172123.5702c78d@han1-desk-dev>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cQ43TGC1bbplVmhUEg+8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-cQ43TGC1bbplVmhUEg+8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-11-13 at 17:21 -0800, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>=20
> This patch updates firmware patch files for following Intel Bluetooth dev=
ices:
> - Intel Wireless Bluetooth 7260
> - Intel Wireless Bluetooth 3160
>=20
> This patch fixes
> - sometimes device doesn't response to HCI_reset after multiple reboot
> - issue with HCI stress testing
> - issue with some multi profile cases
>=20
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  WHENCE                                  |   4 ++--
>  intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 16761 -> 18145 bytes
>  intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 16516 -> 17917 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
[...]

Applied, thanks.  Sorry for the delay.

Ben.

--=20
Ben Hutchings
Q.  Which is the greater problem in the world today, ignorance or apathy?
A.  I don't know and I couldn't care less.

--=-cQ43TGC1bbplVmhUEg+8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUq3stue/yOyVhhEJAQqqKRAAgKgGWy66EPQW6ig6KADUKH9VAnLwVSZ1
3TDQr/votYYB+5HUJldF+EVbXxWJB5stJUS4cWdpI0RDYaZ7mxtnhQKzQgu0RN63
FKuVlHHEV1vMXpHaSxgTQoaPKRrHdpvKV0d/pXmYm+Z25I3Yv+uEdjlcKEPCghhn
CpkOlcvY0xlVxBRAvBFB6aTQpp6l5pAE9cgsZulHfHVRvIGE3AHDGlI7xcLjV1Jb
kaI1MsRbnNijCGeW56B6HKKQuAMJa0csSHQISeZYLxatcVqv7O7wRYPkgt9iM98B
IrdcWFSSmf+BJKnA+n8npUzAp0yYbYtn2StKW3qG6fPSDv2l5ef/Oj7I/XXdLjPu
eYDViCLoEwTB3WRP/3+hWDeHY+x2DY6utORjTB2OLSu/x6nbpUktRubPvkP5XXIB
t+FQyta6i3B7WPrE7MTJyaN6DQrsVTVMg1r1mbCDh7vjLdMvLUQhGuZGkNOi3VR/
WDuHwao7htkejyRQwqCUEqUVwUglpjz+dGxNtJ+8hmtGKEC4XgU/ZxfryYY4lDSG
nB6VwErIST2XUqTaXhUGEJMAAOvmt44TJZBDDg13wCRuwT99yt/SF3h4wc1+ztVu
Yjk/upyjzooPNLw4JHh3PZoJ0GqIZ/UJGJnGwtDzOuSmThMpQMOsX6ywgJ0dLC7u
8Nyg5EN76XE=
=kd11
-----END PGP SIGNATURE-----

--=-cQ43TGC1bbplVmhUEg+8--
