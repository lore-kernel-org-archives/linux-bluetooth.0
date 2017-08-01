Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Tue, 1 Aug 2017 10:51:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: robh+dt@kernel.org, rjui@broadcom.com, sbranden@broadcom.com,
	f.fainelli@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	stefan.wahren@i2se.com, linux-rpi-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm: Add serdev support
Message-ID: <20170801085132.onmq5wubrv2av2pu@earth>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ihkd3ex5jxqc5l4w"
In-Reply-To: <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--ihkd3ex5jxqc5l4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 01, 2017 at 10:38:24AM +0200, Loic Poulain wrote:
> [...]
> +	err = of_property_read_u32(serdev->dev.of_node, "max-speed", &speed);
> +	if (!err)
> +		bcmdev->hu.oper_speed = speed;
> [...]

I suggest to use device_property_read_u32() here and include
<linux/property.h> instead of <linux/of.h>. This way the
serdev support is not DT specific.

-- Sebastian

--ihkd3ex5jxqc5l4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmAQREACgkQ2O7X88g7
+pqmvA/+Mmg+SBdDagCAbNvYKJRHG9N2r8l1Aw6pEsGzdHIV8WXJcGm8YAHCAreA
IRnuRiTK9NuLafWyycoEAaja6G1cpNdUf0lpYYYDdWD4IU+NoMi9hIMew5l1rMGq
IwH9V1kwt7TjL/xGu8CQ89VJa6rTA+rPcJd+kQuPMjEuegXAJdaZ6a9VpqzZgFv4
9CUYhfkqXctKeF9Axjt7Fq0IZvatDGBM539mTO42D5Jlt9tPcaqvMZHr3ge6Z5YL
2WR7X1zCQzjYkPf+E5MKloap/oiyBzPe/DUS4/suw0kzdey6I38SaOEwScS1Pv8/
scsNM6hEVDcMcApr5qILN8ISTLdZmeFeHmxJTGWHOT2duT2+T7qdS9zfYkG8EpV5
rnuStJXDyG1QKqvk7YwP0iyWIQWQEshieg1Ta+QnP7TjLx6vhseuU2GmkxAVQnZV
MYHIMLMvA1GRr6Yh+st/KtloDj+lXniaETwAZL6gMTuZed9iuBlIpOzOkr6uqeyW
W71lrWRyEAUhIfdpAsCOyDeVQJxoj+WG+1uDKEexZqv3BLpVY+LF6jFGCQSM6xP4
V8RlNfwjJ8GVzw/565zJzRvCnG6RrzRSsRSGM3KO2nPSVLNV0DBSKEAvsxDpseUQ
5npwyMYw+AYtbgKctafD1LvHdm8AIajIo5o7oTpO5Yf2pXIuOSs=
=I8G6
-----END PGP SIGNATURE-----

--ihkd3ex5jxqc5l4w--
