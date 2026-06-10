Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484131283E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110750; cv=none; b=Ce5dBw5gXV2ma9vEdYxJQ60/Lypevrv15qdXF87+RJfetY/a1r0j4oYX04jieATiwLZTJpBZfhiufPO/jOhCVbLmdg8gOAKQrLp7iMm0LgIKZ8zidwBRpL3opdhoU2VUFNlCtzEKrRJdk8DZxK9sYANnqWUsKgvaJcfg4DzvFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110750; c=relaxed/simple;
	bh=bVyyrVts4pyEF2ndHUxmpv1aAAxrSJxcFaTJx8fYUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rChwbA9uFSjfndc+TJWK50eIGv4xx3t10vVAW9XFuz1yvf1cBgPRUjxzfawZPoEXDgASm/TPM5O4YcTX59JtnElEioqKdTWUbXM8r5C2KDOXryq6MWrUj6VVyPYBcjWkeOdL9/izfNqTuJ5FQv8zpbV4EJOMUNQmEnAZFq0GAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YZKaXClf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YZKaXClf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso80528865e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781110748; x=1781715548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVyyrVts4pyEF2ndHUxmpv1aAAxrSJxcFaTJx8fYUog=;
        b=YZKaXClfQihD8Z1mRckE+BYiSitXIc0NCA/zNuMdCwQc9DSRvSfrMLV3/Zo4tXExls
         RA6pwHd09BOBjrcHqB9cz66rtcKnpVTBU/9G3Ht3IU57ymsbsLKvPSlmYEZN5Q6P90+y
         qtvO5Q8ib99yj/YB6Sa9/vavmtU98Nbl27TgZmAVizToD+Vl4vIgsVg+A6lo39UP5fG3
         HbltKK8geYf8tGv+2ogAiNukXyAX2BwOOqRtGk/foH6pQRcSvNfPdGNBUivm03rvZ5Hj
         6A9YahbMO5GSAK2vEY4j+4R2s2XRYSuG0D0i1ymZoLIFKEY3cE3ZKrzrEqHl6oUe8tz2
         xouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110748; x=1781715548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVyyrVts4pyEF2ndHUxmpv1aAAxrSJxcFaTJx8fYUog=;
        b=ZbTvVGLnHa2OIaPXuGdjfgn+4Pe+R5zOgI6Az9EU2lPl6pIIzdKBic/5PPAM4NUf0K
         Ffm7kCOaojZc0KIcgXI8agCGoe4t8AW2f74AGceO+bX54ES2itlWsmkFdKVV+jeIpgQ6
         X53zjtpwgBe+DRVGtkQkkde/Cys3Hf41RbydMaSO5+H52EXMnB2fqoYYm1ju8V3bib8o
         76PZ7tHhohoRdUIyKsr9v5/gSgHShCFEh4I3ls2aVPALWpEGkq4nMtdIqsf9/Uqle4n2
         sdZQc2irs/McZQGJGV6sPlokg+EaCnGm5/JOiilmvA7RdyS0euWz5dG4+LfxXuYKQLJD
         qUWg==
X-Forwarded-Encrypted: i=1; AFNElJ8jFCO+dVxhupFyGqig085kOJFFB25HjM4q5jdjKj/BczDUtsFXY75nQc1eUX3Lpc4oKMVEUZXAGal7l33UQuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmgyuuQGPW7UD16EFTzbFr6QM93j7LBpM5Vrdk6Qd6nMG/LQz
	3Df5r18f7bmLcD3FNNuNjcWpR9ShZKXOkveRiWL7e9jBU3qvRHpKw0jinyfYi8Uex8k=
X-Gm-Gg: Acq92OHK3v3EG3ilu+3Ud47lIyq/N/aXccZlxjznhCW14JuXIqPZrh+XcAK6I7QModX
	yMIbIq7tCIbDPQEv1ov2yhVgtoELjAvBGOVSnAyzW0IU1pSMgcbLfe6V8s8PNVbZlHoxwVhEEqf
	41O02XOaKg3GYKPZKPqkQNXQk76HiC1qVq59lx1E9OomsqghDMX+UFppw0Z+6yOHjjQCvztvkd1
	KU9zsz5bTIXSDmUwIc4IN8sZsVYRzpI9l/yvKgf1gBhEgUBrdpulBe/kan2yiCm20iL4i/BPwjN
	+MjjrDixMTGYy0Qag2DlQ0U0UdkdsRMdzr5rKdedvw0sthiLqg9q0HrLdZeIp/xkwqKuwHEZwfI
	N9MJOnO8o+3/g0FZlcwTxtvTvIu1QTn3GS1S2u4gyqEGozK14Dha4zd4W6dJTjokZddCyod5iJ5
	jM07d5CkVG7HrAziLbW6EIBVO3cJy5QIZ1Vxf7lQH6vQQpgLg6DCuIUTfcy56Ol2m+PATWRuHIU
	Lo2WA9hwbZSeUwF9jD1tcT81g==
X-Received: by 2002:a05:600c:674f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490c25ed266mr430620245e9.13.1781110747684;
        Wed, 10 Jun 2026 09:59:07 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f344762sm78016031f8f.23.2026.06.10.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:59:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:59:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
Message-ID: <aimXkX4FC4JVxt6q@monoceros>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3msjhzytjrmzyqmh"
Content-Disposition: inline
In-Reply-To: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>


--3msjhzytjrmzyqmh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
MIME-Version: 1.0

On Mon, May 04, 2026 at 06:09:40PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Initializing a struct using list initializers is hard to read, compared
> to that using named initializers is more ideomatic. Convert the macro
> used to assign values in the driver's pci_device_id array accordingly.
>=20
> This change doesn't introduce any changes to the compiled array on an
> x86 and an arm64 build.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
> Hello,
>=20
> this is a preparing change for making struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
=2Ecom/).
> This requires named initializers for .driver_data. But even without that
> this is a nice cleanup making the macro better readable.
>=20
> Gcc is happy with simplifying the assignment further using
> PCI_VDEVICE(BROADCOM, BCM ## id ## _DEVICE_ID), but this is a bit fishy
> because PCI_VDEVICE also assigns .class and .class_mask (using list
> initializers), so I didn't convert that.

In the meantime I learned that doing that would break W=3D1 builds, so it
was a good choice to not go that path.

> Once all pci_device_id use
> named initializers, the two zeros can be dropped from PCI_VDEVICE and
> this entry simplified accordingly.

Is this patch still on someone's radar? Ideally for application in time
for 7.2-rc1?

Best regards
Uwe

--3msjhzytjrmzyqmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopl9QACgkQj4D7WH0S
/k4iqggAj3aeMF621GTGpJEHIqnNARfBAqngiHflYRiIhmKykwRxpBFaMIbsMmcs
qaS9NHLpxehcieZKUsjtuHpxJ6kc8//qqgRhfwcBdzpgoWz+eFyjxaIXavQ1z87b
k8YJJ6J5VNFnXKiZT4pBl1W7c3eWF+kCoq8UYyNHvI/cE1CCAd7qR5gprTFiZHkS
xH+/9H//w9KQEGL8tDXY2q2s0QSwThwPnABCbIl2gzwsnU/MhM73oQW+DhH1WaRy
rfclH5p/FfkqtITu8CqaDd2hAxtn3KVvBCbQRNHYk6nGHQnxWMnl9fOCSVMu+3HT
mPViuT/eGfETuUtngl9g2o6whmonPw==
=hiX3
-----END PGP SIGNATURE-----

--3msjhzytjrmzyqmh--
