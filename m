Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616733DBD4E;
	Thu, 27 Aug 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848730; cv=none; b=d/b/BDKJHSgoxkQAhm4llEwkVIa0lZTZcl4txrRSVCCmUU/7tz1LlCtnD0lnVvl8KCXoL/VG2A5bDu//gKJASA/+y/RqL7VP9OcC26JZEc3Dga8ZDIhX09/aBLRc2DTAixqN0QGN2RU91QQAj6iV+eT+wVzvDBd9eaD0Zwwr8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848730; c=relaxed/simple;
	bh=CWMEii4KNwRSA9F3M/52qde0t+mUYY56PthDjHLLm1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVaIRqNLxjcD5o3U44CuOKIYTHf4OBiOJuCZkfNSHzGKVt4bB6n6uLXFj7xAZYzNNjc97/5YVZUYfjnkz5mtqJfyxIUkjrsKNEMZrbGRLGpvau1B78lThxO/zbfvqPboZGJPw3seJ8/ELcV9vJaCPNWv48qZn8Qc67wJf7RnKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAE0JYh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAE0JYh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C903B1F000E9;
	Thu, 27 Aug 2026 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787848728;
	bh=0eRy1U6uAzwXpuiA3Gi1i5gbXJsW7piZ80NEeLngrgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OAE0JYh9YtDZcRLeqEpRhsyWL/1nVegiSJYgkQ8ynY2+thU1fPncMa8nUDx5bG5/7
	 UXpxuoo/z1iIACkW4MQGeSafznlZsO5kyvplk++1ntGdpG9jU8PJ64ZOaVns8Vjj9j
	 wGMeKppjRpe9FYClZG1obtVk8SMR/xuiqxz3oscpxgARWfbzyDf89YlHLKr9t/istq
	 LI1SO5RE7WXI+KZc/D/IKzOfj+jrJ4+6Pd4150skUdb5LWG1zpIYUeIdzEFz4kxADP
	 b3ddUaC4H8iZAsxbLXnzHEAKir+FFI+WNk99SXwBcbToGaxgmuiIzbRp98VO48jK6I
	 jJM8mtzxEUEjQ==
Date: Thu, 27 Aug 2026 17:38:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Bluetooth: dt-bindings: net: bluetooth: add
 BCM4384
Message-ID: <20260827-uncolored-onlooker-d62c44a3323b@spud>
References: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
 <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hs61HPrq2vr7zu4g"
Content-Disposition: inline
In-Reply-To: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>

--Hs61HPrq2vr7zu4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 07:02:41PM +0800, Andy Chang wrote:
> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.

Please explain why a fallback compatible is not suitable here, or
alternatively if it is, use one.

pw-bot: changes-requested

Thanks,
Conor.

>=20
> Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
> ---
>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetoo=
th.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.ya=
ml
> index 95501e858e6f..612d21123aaa 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> @@ -31,6 +31,7 @@ properties:
>            - brcm,bcm43540-bt
>            - brcm,bcm4335a0
>            - brcm,bcm4349-bt
> +          - brcm,bcm4384-bt
>            - cypress,cyw4373a0-bt
>            - infineon,cyw55572-bt
> =20
> --=20
> 2.25.1
>=20

--Hs61HPrq2vr7zu4g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapBoFAAKCRB4tDGHoIJi
0grOAP9aDla7+9QfThtcR5GTr5jApqex+m9o1Igz0LrJeZAhQgD8CdpasLtJ0w6k
Ob9uJhX6oDYb8QJs65qJHzDEuHPbpg8=
=06ZQ
-----END PGP SIGNATURE-----

--Hs61HPrq2vr7zu4g--
