Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Sep 2015 15:57:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@intel.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <20150929145747.GQ30445@sirena.org.uk>
References: <1443107584-31026-1-git-send-email-loic.poulain@intel.com>
 <21E96BB5-A2FB-4C87-BDE5-56DBFC660FDB@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wR9Y6Ks0OCEmDFVd"
In-Reply-To: <21E96BB5-A2FB-4C87-BDE5-56DBFC660FDB@holtmann.org>
Subject: Re: [PATCH] regmap: Add HCI support
List-ID: <linux-bluetooth.vger.kernel.org>


--wR9Y6Ks0OCEmDFVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2015 at 09:34:03PM +0200, Marcel Holtmann wrote:

Please fix your mail client to word wrap within paragraphs, it makes
your mails much easier to read.  I've reformatted your text for
legibility.

> > +/*
> > + * Register map access API - HCI support

> I do not think we can consider this generic HCI since at the moment I
> do not have enough information on what other manufactures are actually
> doing with their FM radio support. So lets call this regmap-ibt.c
> since we are actually using iBT as designation for Intel Bluetooth
> silicon.

If this is specific to a particular device it should just be kept within
the driver for that device.  If there are many devices implementing a
similar protocol then putting it in regmap to be shared makes sense.

--wR9Y6Ks0OCEmDFVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWCqbqAAoJECTWi3JdVIfQLecH+wSwYBF/q7D1PEMLr0Tp9Fwb
hdJy2EV705hEDYuamerCYXVZD10BWMupxkfqW9g61XvK2L+qhhE5zS+EOU/6uG9l
tyy4b/MqalgRs4AxOevBzx/OeNbsQ/hDV7afW+cbwT+/j+266+ExDD2lzmwpRxfz
Lgqq4vxGLGDoEtdR6GRV9Ww0sMDTANrmNNrytHyLGOspE9+gkAhRkNJDFCFuJVN4
wxQtjjVCPXYnHti2S8g6bxUBkQEZr0iHzMZqS1G+97fSCpDGsMvEzgXjsjofHeFx
zHNef+jiKJ1vDLhJvo5iiylMM3WVtiNkzKD2inVsLGwMIMWe3FedJCaDUWCx6WM=
=Tpwa
-----END PGP SIGNATURE-----

--wR9Y6Ks0OCEmDFVd--
