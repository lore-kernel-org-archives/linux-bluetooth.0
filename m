Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6234F46D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717094; cv=none; b=KJlXVadulv11DBIiLpZeTDsqTlVCYk131L4KzSfTbp8XPOHRKyZ9vkBJKgRwzqYKj/RgcuCRUUoPm9euQ4RejRB25fszA/CYx7+Yh0ZMv/bRkZ/cG6irYi1xyh1Y42tMRAe0N0YNlt1SLbmkcRq6yNxp5telXgKC8EqIlH3vmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717094; c=relaxed/simple;
	bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx10JAJKcJ1abcFAcS1ImOn6tIXw6+8i4lRMBjw2/Ah6/J0BFdvtFL7JEGOfJYOUdBKDHhJ9P0ZhE46MJ5G8n6m5TJITWarJUuMV0UmC3qTxInQ2YpHC+1Lf9uTe4IXsesnuEDm5LpqRn5TPyaQABadV6e9v5Xr+OIc6dc4DXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=jnamGJXH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jnamGJXH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso10211655e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776717091; x=1777321891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
        b=jnamGJXHPA0SAWEBfg0siKGV5Ng7WOhyw+r3fxwxIz1Ikg2PiDiUTgFzBdoq/5zDUx
         6nA5EGH/ueeznt9Z4IkFNKaFunFr3zFV4bYQJN15yLHVI8OU8M/T3a8GOtmroPku0GSl
         cRW2SyDFbDwMc7zwPytjL04UwJohpXLzNrAf/XlIoJBwsIsObw1WdWR0dHle0e4txf+n
         xUb06a3vxXiJBsZC6U2nY5fYe+gmsOGfFk3bbHNIrbiQty6BbwLT6hVhA7NagAl7PO2+
         UZd/vVG8B3Xp4v3TtAuEVKJ3/fvn3nX26OUVyXzFyyDpalofacSPz0OPByfXXzYAPy7Y
         tgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717091; x=1777321891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
        b=ZY+kx4jP0SbA2kAy/waRiZsTD05MAQ+6QZpSIXFEjvDtgMQWT0OggXRrE/JTdLazCQ
         CeFkY1B7J0bo55MS+vuy73cCIZoVwVFERwMGY06qpkkpddQMZfnPBsSFvj2SOcXPHpxw
         R4LxLfNMlJqjGNNKIOBKU2tm+/RKg9wsZqT2X1zujLEHYtJ2i40qO033gOkgoq9XR9xP
         EJWS9UrFayEgfZAGnR5PmdfaDGExujHesSjjPDcl1iUH7I8DG+neFTKsKDpqV/LHhbjF
         5RdRbY9TDfu832lhNcWrIXjZtP+GQiKS+J1IUNVAqANK2lO8ARMT0ezPE2LHRaaqyklL
         tu3g==
X-Forwarded-Encrypted: i=1; AFNElJ9GGzIv+CfqrvdvuQIMD2M0tqWjApNEoJY+EnfmF1WwiAmZVquPuR3ole2/OQv9lqQRIhJb7dJjNhaYZFE1ibc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgCg95ZQzqaX+OCuM4UAyBFohX5rHuJn+XZ4tiS+NyKBjlX/F
	4cD8e39yRkKf/MnFONIqAZPfjhgizV+Cdgqc6kPcME2XoovszVDZ9KjW9MZQkyCBn54=
X-Gm-Gg: AeBDieu9i0dIA1jp/BujIESXRZdJBuf58DTg4fBxbn8eflxEqES0IIu7H/Zeu61Dwwt
	m/ab9QLelODHLYrOC2vwHRQWz2HoCR208QD87HC0iCX20QYlLCbhoKVpbVgGaRRTabzwXQ5w5Rg
	/+kpapba3btMsZu8cMQJ8QzQkh12yQEWPvuH94eaAKbH4AL73mgRydl6Ma/A0EyFL1u0AB1QLa2
	PQ4+cpm6N2y0RNCQSsDhhLnhhaJPSu53qflgcmhmOdwDD40Et/qX1ltuFB3BsYf60s21Bd3KZM8
	inO+/L7C7vWSavyycEfosehMBKKi0ZmrpndFS+LA2eP16THUWozcJyUwNPQiR+3wuoaX3eUuRHs
	b7bNkBt3gdYh3Uxk3ZI2qxYGT196Kuq4d3HwlzHzAxidrcRUWawmY8n9k6L9cWZAKNaFQdr7TDA
	/kRuTBW4PbQBwzPxNOK1Ue1xkfIN/D+xYdgVjdI5I=
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-4891ff176bamr64290705e9.1.1776717090675;
        Mon, 20 Apr 2026 13:31:30 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0745sm126204805e9.9.2026.04.20.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:31:29 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:31:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aeaMkfk_1t98e7SU@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u46iqxpjoedhizpi"
Content-Disposition: inline
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>


--u46iqxpjoedhizpi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

Hello,

On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) and
> this is used a lot through the kernel. For example it enables the usual
> practice to store pointers in sdio_driver_id's .driver_data member.
>=20
> This works fine, but involves casting and thus isn't type-safe.
> Additionally with the CHERI architecture extension there are machines
> with sizeof(void *) > sizeof(long) for with the traditional approach of
> storing a pointer in .driver_data doesn't work.
>=20
> By replacing the plain unsigned long .driver_data by an anonymous union,
> most of the casting can be dropped and it yields a working solution for
> CHERI.
>=20
> All users of struct sdio_driver_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.

sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
log and once in the short log. If you consider applying this patch
please adapt the commit message accordingly.

Many thanks to those who created sashiko.dev!

Best regards
Uwe

--u46iqxpjoedhizpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnmjQwACgkQj4D7WH0S
/k7lawf+IBy1b5wfuwWZiVYsobJ5/VQtS1uab/j//LDVdxK0lHUoqurrxgHf8aFa
2/h7V1KF+nbxyYPjLmWI8a37uIwuSKZ5vijoBeDnFRFwWdEokon2xNz+IK0hTkf4
Ill7bkiF7fk+epa8am5nZ9gUbmy1nlQbFZHlXizQA4YeFOlLyfOdPTsXw8p/P7Tq
RIGbTgcE13Qkiokn+iCwGUzLfb1sjBm+Nx3M/g1/C2r4tw+M1ypwCAizKjjvFyTz
8a7d4lCX5G140aKhxhTCdN3nE5iwtvZ4w9BT2RXRY03pv4w0FW5Xyc/PqymZ2Kp/
qcp9T3xPsnUPVlIgTg1SnhlhnrS5Qg==
=RSgT
-----END PGP SIGNATURE-----

--u46iqxpjoedhizpi--
