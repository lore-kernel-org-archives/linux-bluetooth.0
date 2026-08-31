Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC322514770;
	Mon, 31 Aug 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188561; cv=none; b=COC5THfjlk3roUogIMVrIAXLL6JqBkORJxxzkPU2hvHO0jieLy9NbKpfMHY4aNRA92c/ceQRaQNNjviKa0l+/x1c/vHjZwcj8QGFA/tv0uH9vdqljnjSrRuVF49n4KZDZ7BGajoGPnAWkygJPXDrN/Cjsu2YQlZDH1o9x9kDHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188561; c=relaxed/simple;
	bh=C+pCREtFQwkT20iqaLyc0Hd0RC9syYGE2DcfobTAwNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTXeyi0+BJ0F1b73yCYo9TF9f8qfxXGEabqLyVZ81RG1od6bJLeN/xdawytMRNk1rKjKWNT9nMSL29YO8bnti3A/gSkQc2Z3RAStmZ1iJ2kpG4puzyuBlzAfHeZt/By9dFVDPudg3hb7GIN6OxkOuYfOenOmrKjZwfjI9j3NKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaUqloqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaUqloqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF31F000E9;
	Mon, 31 Aug 2026 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188559;
	bh=C+pCREtFQwkT20iqaLyc0Hd0RC9syYGE2DcfobTAwNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EaUqloqyuxlnfCqUSsbqAKqeud1q7C80WWI7C0AJMCTQpUQMkACHqRaMznwDc3A5U
	 aHvX7v1NfltZMKUMZLgu/MNnhqOZPG4Uj+hf5hwge3wgnejSxrK0+TqwImRLr4fq9D
	 a0v5xDhkAoPwEhANqCtNVNEHFi2MYfZ0NDf9LZzVczP9hGodi+X+Tf3LjxABkIn3h2
	 NPgE7ONlnn6C7Re95i6fMQd1HwIyQga8UPP1hQkTSWfOToBwRofMfcY1JtO2Cnxb5I
	 ZKmVJpuGrEbkfr3/HSW7Ojhr/iOJlcVRn3EJvc4iPS3vn9j3vGODl5uwz4I64QU/X4
	 67EvLVs/dKY6A==
Date: Mon, 31 Aug 2026 16:02:35 +0100
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
Message-ID: <20260831-cosmic-crawling-cf0532d4d3c0@spud>
References: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
 <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
 <20260827-uncolored-onlooker-d62c44a3323b@spud>
 <CAF8VQdEA7=LRpHaVOVZxRi73kRf=0pK_etJOJ5oeULtgw4k5Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Be5C8Jw/A1Wehthf"
Content-Disposition: inline
In-Reply-To: <CAF8VQdEA7=LRpHaVOVZxRi73kRf=0pK_etJOJ5oeULtgw4k5Bg@mail.gmail.com>

--Be5C8Jw/A1Wehthf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 05:34:23PM +0800, Andy Chang wrote:
> On Fri, Aug 28, 2026 at 12:38=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Aug 27, 2026 at 07:02:41PM +0800, Andy Chang wrote:
> > > Add the brcm,bcm4384-bt compatible string to support the
> > > Synaptics BCM4384 Bluetooth controller.
> >
> > Please explain why a fallback compatible is not suitable here, or
> > alternatively if it is, use one.
> >
> > pw-bot: changes-requested
> >
> > Thanks,
> > Conor.
> Hi Conor,
> A fallback compatible is not suitable here because the BCM4384
> controller requires a dedicated firmware patch file (.hcd) matching
> its specific hardware ID and revision.
> Falling back to an existing compatible would cause the driver to
> request the wrong firmware binary and fail the controller
> initialization.
> Therefore, it requires a distinct compatible string.

Cool, please put this info in the commit message.

Thanks,
Conor.

--Be5C8Jw/A1Wehthf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWXiwAKCRB4tDGHoIJi
0p4iAQCVA3m20ajQj2k9zBtN097mymUdLDsp1JMWDndTMrhANAD/Tytgo8aekMkc
GfSxtdR9XDIIfvNCOseqR7jiWCDqEwg=
=zh7V
-----END PGP SIGNATURE-----

--Be5C8Jw/A1Wehthf--
