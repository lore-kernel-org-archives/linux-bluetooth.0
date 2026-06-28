Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35178316189;
	Sun, 28 Jun 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674291; cv=none; b=QQJlKJDuyLHrZC0402n5ZTvQGBz7ZAIu9RLEdWsgKqEhx/jTZYwfrFM0PDfo3pcwUwvwdZvoBT4tlef0OmLc0idmf2vHrt+QVe04KQpCN0BnEF/eu7+FdiCiT99GvET2Q98Wk1Zi1QZaRrqQNVm0rUY1TvCuFfjLuASF9OO85WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674291; c=relaxed/simple;
	bh=9F9T4Qc2f7NN+GD7OTc67Hyr4j82QNJZSo2NHYq/i0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j708kzt5GRUKADrAF6blcXrhtcnPnNYxh+5o07b/mlWs/JIcFXIJm1Arta8CBfdoHxOGxEKuPL5wxPaGzJ+fqR5QtjauUnmp1zqDtDJV/UO40ZrIZEIZXopEDsvzo0m3g2dvgEEgQnlLMv0+lw1NCqZmMjGXMl6VQkNtCTSqYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02211F000E9;
	Sun, 28 Jun 2026 19:18:07 +0000 (UTC)
Date: Sun, 28 Jun 2026 20:17:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Message-ID: <20260628-shakable-spooky-e75e410f20f5@spud>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
 <20260628095500.29810-2-hugo@whynothugo.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GIS6OSUvjj09OaDl"
Content-Disposition: inline
In-Reply-To: <20260628095500.29810-2-hugo@whynothugo.nl>

--GIS6OSUvjj09OaDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 11:55:00AM +0200, Hugo Osvaldo Barrera wrote:
> Document the compatible string for BCM43752.
>=20
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> ---
>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetoo=
th.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.ya=
ml
> index 95501e858e6f..04e8a968548d 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> @@ -29,6 +29,7 @@ properties:
>            - brcm,bcm43438-bt
>            - brcm,bcm4345c5
>            - brcm,bcm43540-bt
> +          - brcm,bcm43752-bt

This new compatible uses no match data. Why is a fallback compatible not
suitable?

Thanks,
Conor.

>            - brcm,bcm4335a0
>            - brcm,bcm4349-bt
>            - cypress,cyw4373a0-bt
> --=20
> 2.54.0
>=20
>=20

--GIS6OSUvjj09OaDl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakFzUAAKCRB4tDGHoIJi
0qxeAP9I/YzcS7X4Kb1SEdN2ok37jc0bsuqul4pWpjf4jI5h4gD8Dbohj3RpNhsD
IcWEyvxML+jBYY9GWwci6RbXntzyFAw=
=x9HD
-----END PGP SIGNATURE-----

--GIS6OSUvjj09OaDl--
