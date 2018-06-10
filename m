Return-Path: <sre@kernel.org>
Date: Sun, 10 Jun 2018 02:29:44 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: remove unused bt-nokia-h4p.h header
Message-ID: <20180610002944.ivdgzojt2akquwwv@earth.universe>
References: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mog5phdl7t5ijen"
In-Reply-To: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--3mog5phdl7t5ijen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 07, 2018 at 07:50:38PM +0000, Corentin Labbe wrote:
> Nothing in tree use this header which seems a remains of a staging
> driver.
> This patch remove it.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Right, this is not used by drivers/bluetooth/hci_nokia.c, but a
leftover from the staging driver.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  include/linux/platform_data/bt-nokia-h4p.h | 38 ------------------------=
------
>  1 file changed, 38 deletions(-)
>  delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h
>=20
> diff --git a/include/linux/platform_data/bt-nokia-h4p.h b/include/linux/p=
latform_data/bt-nokia-h4p.h
> deleted file mode 100644
> index 30d169dfadf3..000000000000
> --- a/include/linux/platform_data/bt-nokia-h4p.h
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/*
> - * This file is part of Nokia H4P bluetooth driver
> - *
> - * Copyright (C) 2010 Nokia Corporation.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
> - */
> -
> -
> -/**
> - * struct hci_h4p_platform data - hci_h4p Platform data structure
> - */
> -struct hci_h4p_platform_data {
> -	int chip_type;
> -	int bt_sysclk;
> -	unsigned int bt_wakeup_gpio;
> -	unsigned int host_wakeup_gpio;
> -	unsigned int reset_gpio;
> -	int reset_gpio_shared;
> -	unsigned int uart_irq;
> -	phys_addr_t uart_base;
> -	const char *uart_iclk;
> -	const char *uart_fclk;
> -	void (*set_pm_limits)(struct device *dev, bool set);
> -};
> --=20
> 2.16.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--3mog5phdl7t5ijen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsccPUACgkQ2O7X88g7
+pognA//Uk9rcAkWZyykAdmm+Xd9JmHjPotXeRxM+Rb1Hum7p4CPqov5g2gAvSaX
11OKnCqUwbBPgQJcIg0fxWAZqEuYwH2re4mohb6UPNF+8TxaKe2XmafiuMxygons
2zJzyF65f7tF1E5qk9mNuJMg+O2VkA3Zt5S6VnaCBpdEAtij98cwg3aPieKdaLvn
eIb9P44AxowvQv/Q9E4YiRAgX71s37XAPK+7jn7l3FJEMRhL3B9t/V8Br+ig3BGl
sWtemkcPA8cak3wC9k4zTkn03LPE6SLgeooh5M3LUdv0jgFbiSit2nZ45JLYdOEL
SRK3zKuKsUQ69vWHi+gl2f0WRbfElvbUnz4sQWkQ8uP2YHe9nmGMJYexHw74MKF9
WSPJ60UrM4svPuF4NNPaR26ao3YnhXyrVQh9CUOHsF3Vqw8mmMdoQ/1QRZvMV7pQ
0Gx8P/tAbGeTNZEc5TBbDFAgmriXf96ZedP1hUnhOC8GVSG6cszcKPQEmvsZ1ryK
E4KkE9maTgooIn0NYddLHWBq5euf+ve0//lGbsFOwzinbWpnW5w+nrUCCV2EWjD5
ilVlc3v5gq+ZPYYwIX6zn7doOSrcbLBseu8oc/1BDzZwj2cIIYzlX5kkaLwbzUXY
QWQa839Pv4VHmkzH1SQpxHAmS9Ct3R9oGqx9eNzN1tmNgT66+Xo=
=dS1p
-----END PGP SIGNATURE-----

--3mog5phdl7t5ijen--
