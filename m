Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97782F531F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439257; cv=none; b=gJuJy+sDm2tPcXLkEH+moepdu82VAFhNKIDMeoCP2OP4DzE+lcNps83r5kNuXORcfMj1w6IZjdHoR7TYrPRUJrzwZQpw4ZTrehCfL4zdUMZc4ZSzwXpNRhqHIKV4jU3kNb4DL92hKudbesL/hO64iTcxOsd2NOG5wA5eT0VZoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439257; c=relaxed/simple;
	bh=UOoSda2KXw2xMfuqaVlhT9j2kBPLbAb/Pa4SrFzsC3E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbjocAJGkd/R9Q9U6cWdgz3Si4D+Wj6pDqyOMNnZ0L48xgC+PDEsPOThncFmHg+w8N+iEc5yq2uoJzJX1YkivywB7T/xGUgyutX+RhkBm5GaWHkNWbNb+CXDMaTbp2DOG2b1b4wvKxwCWZAnGLqOVMnukKSFKswtgfkpa2OyFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kcAcggHl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kcAcggHl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso7945315e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776439253; x=1777044053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWzgM503kqHsPy3l6DAr0Xr76IG6M0KIu/WvL/k800o=;
        b=kcAcggHl0zU8CdKwfS7a1Pi8wY1/3BD0beBc4dMPhr3qzb9iqpxpsOkBJRDSDCXQ0S
         Ad3B3lqjiWoBmuxlLE7HtzUxqAbPE2byA6HpIeEi/uwjjWrtvs2PdURmtpiVhttceAQ0
         kl5CSXnfWJFDF5wwmOftcd7UPHmdU+xMAALzKJLS/cO7Ix21uz0KC8IIIKYTHKQXIaNY
         fqRwVWH1TZ1zGLwsD+vYoR7nFGMeef++A6kC/AhWcxgdV1ttTm3fsegWqa9kEfGlzMtQ
         yG2wRBkGZafA5MHwvRtbOO4QayoBwowM8ZJrnIs4Wa5szmD5p0UB5YwikcP6o6Y1Sr+C
         wEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439253; x=1777044053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWzgM503kqHsPy3l6DAr0Xr76IG6M0KIu/WvL/k800o=;
        b=FJtGconESkDOD66DMpNDOe71faF5eb+rkrJdo7bahFY6JgCt0z7rb78cK+6eVGX4zP
         2P1Qo5bd21wgMhy+mNBIyOBqvRT/L4Y2rI5uRtsisjUvalSZmZmhf08hRHML/nUWJqrm
         MugFBIBhZVjtyF08TjiOcILWrIhHHYNF399KOCpjvr9HTXmyFq7TxR2sl2ipXvmYMIJ0
         fhRJwc9dIW8onu9CiG+u2PPNRtqAD+I9fvXj2Twy7V37UZ9l9pHhQqJ3yuQxI8BKKij+
         oC/6XQb4v343Ysex+4PS8n56DFCgTph12277HpFQBzUIUhgzGZNukx4ZMoZoOIQsgZbO
         ueMw==
X-Gm-Message-State: AOJu0Yzhs4HM0DgefCkoEN089RxtB5AAD4Fy4vC1IyEvEyLd8p+KZM/K
	R7Klg9BWP8tL9AHd3B7ywa6y5FscYM3rGwhXcLnuMYRZqS+0PLcCdo1GOWpgtVhfR0Jv4jEYtFB
	giIWw
X-Gm-Gg: AeBDievzCmB2wIOwpQnHApo4UZLAYn5ju+3KGjH0i/698uWOrXttvoYnDCLVr1esaFw
	CFNN0A3oLZkyV8DsASJq08mCE606tyuSDLtkJLayR8TW8d8VyOwWn/nbY6Hlsg8ACjV69MaDK/q
	Ytl4/Pff+1l+8KO+Zl4w2GeQXQflOO8yeWOf2whuWrc/4rDlqDEApnP6HdsPJdIXZr2OXgFXdiw
	Wk00cszjlE1I8uf6AIoYNTmSG4uxsVxo+2nM5G013+yRJIWM6qBCtTVtquFHQye8xy/KZ7mpbNJ
	2KaFQuGcHRXie2AC7g1mmPqGCs19tM5Cjuyl11FseIOnvYvIP4eJuLvy4tyaYhdsWTGvwie1Cuf
	5ORjvhx7X7ruGddvbd2oO0Be1xivpP75uTiVJ+ZXgZ1NZ3OPWTUKRDIhYiUUfiOMq+IpZNoKxZ0
	DfsGmc5KoapnNAXojR7xmDOmOXv4Eu9mgmy9rVWAEE0FR7Nakfbo6Cb91TzK3Ir45AFS9LqgNlD
	8NzIthS7YalELF7C7a+QeL7
X-Received: by 2002:a05:600c:a413:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488fb73d229mr36248815e9.1.1776439253000;
        Fri, 17 Apr 2026 08:20:53 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7b2716sm20263265e9.30.2026.04.17.08.20.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:20:52 -0700 (PDT)
Date: Fri, 17 Apr 2026 17:20:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: sdio: About pointers in sdio_device_id::driver_data
Message-ID: <aeJNDwFrs8R8BDQr@monoceros>
References: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <69e23f9e.050a0220.17c124.ff26@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tc7ulee6dpin6cmk"
Content-Disposition: inline
In-Reply-To: <69e23f9e.050a0220.17c124.ff26@mx.google.com>


--tc7ulee6dpin6cmk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: sdio: About pointers in sdio_device_id::driver_data
MIME-Version: 1.0

Hello,

some feedback for this mail:

On Fri, Apr 17, 2026 at 07:11:42AM -0700, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.

I hope it's ok to ignore this request here :-)

> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.

It would be great to point out the URL and commit hash of this current
HEAD to simplify acting on that and also be able to understand the
details of the mail in a few weeks when the repository probably got a
few more commits.

Having said that, the patch series fits on top of
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git's
HEAD currently at bc39a094730c ("Bluetooth: hci_sync: fix stack buffer
overflow in hci_le_big_create_sync"). But I guess "the repository" is
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
that indeed contains a conflicting commit.

Assuming that the series being applicable to the bluetooth HEAD isn't
the only test done here, a great way to make the bot reply more useful
would be to honor

	base-commit: 028ef9c96e96197026887c0f092424679298aae8

=66rom the cover letter and then provide more test results (after pointing
out that the wrong base was chosen).

> ----- Output -----
>=20
> error: patch failed: drivers/bluetooth/btmtksdio.c:64
> error: drivers/bluetooth/btmtksdio.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>=20
> Please resolve the issue and submit the patches again.

Given that the bluetooth parts are not ready for application now without
the first patch in the series, I won't do that now.

Best regards
Uwe

--tc7ulee6dpin6cmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmniT9AACgkQj4D7WH0S
/k6tngf+IxaVIcVmVfTZvfmLgXWYRfRyT/i4uBKBhKMduxnyOHGZS9KLdPv8Iv45
xaL8tfKVpvot7dvNoia5/V/17ika646rDGUQYIyyoUT+sMVNRmWgd7eXJObrMMTD
vxvW4Uj53NSMlFh7vfEHJ58a+JpEZxAp4W7QcGFa5kxn/dHCoiInlWphel+ZlUxw
kulNQ0KjluDs0uVJdo+h3yiM/BSdaNWVVomEK2AMveafP5YIrnS38NdCm9//TCIg
M6ROmWuLxlOp4uHYpg6j2BmmY1N1lQvNbnzs11pBRwXx6eVieX8rbtH5loRzF4io
GeDsWeuuBFggJ+9rm+P+Sx1/X3wujw==
=mfCq
-----END PGP SIGNATURE-----

--tc7ulee6dpin6cmk--
