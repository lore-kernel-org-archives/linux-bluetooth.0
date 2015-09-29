Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Sep 2015 16:39:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <20150929153908.GZ30445@sirena.org.uk>
References: <1443531945-31344-1-git-send-email-loic.poulain@intel.com>
 <1443531945-31344-2-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f7CucRmdyxBKZyr2"
In-Reply-To: <1443531945-31344-2-git-send-email-loic.poulain@intel.com>
Subject: Re: [PATCH v3 2/2] regmap: Add iBT register access over HCI support
List-ID: <linux-bluetooth.vger.kernel.org>


--f7CucRmdyxBKZyr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 03:05:45PM +0200, Loic Poulain wrote:

> Add support for Intel Bluetooth silicon register access over HCI.
> Intel BT/FM combo chip allows to read/write some registers (e.g. FM
> registers) via its HCI interface.

If this is specific to some devices it should go into the driver for
those devices rather than added as generic code in the subsystem.

--f7CucRmdyxBKZyr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWCrCbAAoJECTWi3JdVIfQtjAH/jv8KwQL0iu832JBL3+tynRt
oKPgitTX9Mf0dxH9XajVHS96RjJaTlLkhZjhYeacZhsXBOOOts4OsLQBfU6w/jVn
shPNnbzLTtOhmiuGTGUxjkF0zY1KTqvREDRu+8pRAI2dP17bBqcEqB7uO0u1mX7f
Mcflmx5Q5FPfweyGnETWqNL+ncYN66RjEawbBM4n2RyXRWlFeGKNNEEJ+0KI1RnT
px5TKjQMYTF2bZiWKtu2gc0JVRZ5/iZNDm1o9PXrRjNTRiyfEpsYfpI9Hrxa5YLp
ksziUlWfnUK3ZNzYCAC0ZvKDXBWQBYCMdRSP+XB9AHpQUxz4MCbFYweGzW1Fmak=
=BfCO
-----END PGP SIGNATURE-----

--f7CucRmdyxBKZyr2--
