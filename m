Return-Path: <sre@kernel.org>
Date: Tue, 31 Jan 2017 15:31:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] serdev: Introduce new bus for serial attached
 devices
Message-ID: <20170131143143.tvf4w7itfwqmweq4@earth>
References: <20170125202343.30923-1-robh@kernel.org>
 <20170125202343.30923-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cnesufgnubno33i"
In-Reply-To: <20170125202343.30923-4-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--3cnesufgnubno33i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

On Wed, Jan 25, 2017 at 02:23:41PM -0600, Rob Herring wrote:
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> new file mode 100644
> index 000000000000..4f8f76d02ca8
> --- /dev/null
> +++ b/include/linux/serdev.h
>
> [...]
>
> +#ifdef CONFIG_SERIAL_DEV_BUS
>
> [method definitions]
>
> #else
>
> [method stubs]
>
> #endif
>
> [...]

This should also test for SERIAL_DEV_BUS=m, so use

#if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)

(This was found by the kbuild test robot)

-- Sebastian

--3cnesufgnubno33i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliQn8wACgkQ2O7X88g7
+pqQlg/8DSlRWrR4d3zPD34mACClm1NdayhnMs5tYAW/q+yvH3YA1joOE5g+9CbK
X5QIczoFN/UNlFtA4Lg+8Dikgd49k8bB5zTvkXWCwznJ9UtbKtXlTSg1G4unGsKU
qMRQ2a1JVOioHKT3JbHU/bVM7waFXI/5aX4SBrqRwngGorKH/J0LB2HPotLB40SN
BKSZ47Rk06UZME2N7QDU8MsnGnMZL1SY26Ozf3JRpI7SRlArc0TRSBAlBHElWY+P
URHWF9MAwZAWJ3GCalr9WKdNQe6qgQ9eA6oY4JF4SfGCAUMQs/K/MNJ2PpGLxlVa
7XmRij2RQDwIbPEWnKV/1qiw5XSvz1M5ohGMCQAMq/KPpZkqA8cE6vI3AnKuTXWy
tLwAVJh+mRnD4qiJMewCTAG7VF1v0ZjV4w92e7bYVtgxzAPPKBvjK3GDMPoFM2tJ
HRBlXE7B6y3LCoXNig9dIY20virJpeKhvr0U1OOI6cuhuLF0IyLO6OVtTC9kKooW
G+0q0dGlvCkLAFOjsdVKwuUgt3o+Uif33v7rKGWYDoJ6fjhFr0X51XwY9WnmOoNF
kf5BHCDKOmtEAzSXGzhxmjfXJ7EwGznfvzYOccZ4ANDA6CyXwD9AQPu+IdETz5pv
E0+taPA/18QUv8WoA5L6SkvCsK1tT41R7e8PR9ilIPG8tmcON2A=
=vD/b
-----END PGP SIGNATURE-----

--3cnesufgnubno33i--
