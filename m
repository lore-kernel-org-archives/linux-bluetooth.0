Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336557;
	b=amUTBH/evJ3Q5I1jYFCmUgvT1xKGOgopl9/EcBAUG4kf0XK4hsgPrqWoQJepTPQGOzTp
	 zdWVHcnmGPxPWaMXhpfAWZcn8zHJXDzloLh9iL79ko5JNfy7edXTPTXNhv2Khaj5IunUn
	 6OSsM2wZE5MvNjUUv5imU/hgEqz+E9guKpDwf1euephF7q69w9zAK68cPbsbJFtn5Su4x
	 x8olpBMS3nibIyzLuCi6x9cXCJlxroTAUWXPNxniKm/3b20S5y9ivsniH7MDmCoOTdxhr
	 fcONVuD04trgmtsxq/phE7UkoFirjtevtd90u7k+A6cpTh0HvdlpaQ0CwvTJHiQxdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336557;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Thvo0vDOf3BmXU3jCJQT1W87hRo9M19a26RaHIJXVpQ=;
	b=zGCcHaO/rvTVWWQXlAjcM0qPkdvQ/BHS8imXGxR4zWUcexhu9F/l4PpvmDpPfWomqm5u
	 vrIQMkBZIet/xhqEm6YpJsLCo+sBmjUwg0dfcq4oHmVY4UnttrPcOA9qYqY4SrBP6ieNZ
	 J2mdEuM7jgR9wlrZudtw2uAq7NlFaiG7OBhxOD4ItIwrZMszaCJmugoNPJF6KMk/wq7VE
	 zrbHOHymIzEb1Z06za8tx/mKYEwAMWctvaH1Adw1hYaiFoW8w2E4Rf833O1mTaKpi9cPa
	 yQB2ht0yiK27yMynvjAr1M8wO8E+K2rDO+Vsja3PRwMvTj0tvufF4IOYbFx0+xkbetQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXgFNq7C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CB606A332;
	Tue, 10 Nov 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXgFNq7C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93111F008A1;
	Tue, 10 Nov 2026 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336556;
	bh=Thvo0vDOf3BmXU3jCJQT1W87hRo9M19a26RaHIJXVpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XXgFNq7CZK7JHtPobTdwZFldLyNZYWRSiz121cD3LYoCiPMzsvmmhUY/zDMKnEFeq
	 6GcHjgZs+nb7PgdBr4AWk/oV/eW5OwvLgIlwjZ7v5fulTvsLW1xzRUr3m5/RcZIX1J
	 lAqpz1F9iykdA8wIpLv7jFvqKUbFGzaXddhWHG71CF4IsKOnqcd7R9gNtPGPPYFKur
	 JXxWk+z5czGzMqtv2R6L8w6vfQNtSskI7P2j6c395l1wf7o7JLcERD240r3BKsrSOV
	 5iPvo/cyYLea29DwTiGaoyDPqKN+lGUL9fIt4VG/7Ga6R1yPJUXRNBriodPmCpqa/E
	 a+sMD8wo6tLLw==
Date: Tue, 10 Nov 2026 18:49:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: bluetooth: brcm: Allow a platform BD
 address
Message-ID: <20261110-quill-awoke-b7edb9bf7f59@spud>
References: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
 <20261110-brcm-bcmbt-mac-v1-1-c68003a06f64@kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EHOMJTG9vDBgawPq"
Content-Disposition: inline
In-Reply-To: <20261110-brcm-bcmbt-mac-v1-1-c68003a06f64@kernel.org>

--EHOMJTG9vDBgawPq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--EHOMJTG9vDBgawPq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNnKAAKCRB4tDGHoIJi
0iG+AQDL/iXQUNoQo0wnnIHg0jX3HqQW+OjZSaq0UY2SSWbhQAD+P2ZO9TWdy86O
rxeYf9kKwgI7THu7VBdQ9Z4VGRP7kgw=
=zuGs
-----END PGP SIGNATURE-----

--EHOMJTG9vDBgawPq--
