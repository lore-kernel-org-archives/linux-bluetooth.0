Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C843A6B8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125733; cv=none; b=CbgRCQNcYxBojYm3hrt8SXTJOCXE5CW7Jg27itEEsRg25oBTKgeG4E/cjkfxImEXisbWJFVr/bTmdSx9fItQ1txiCjbCoVaE3byKsXkTv+TBb5EzrXBU0Rf1NGa8xFsX/HaDsvjKhvmbknun2wzvWTi6wFvgUTiCGQIjnVIVqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125733; c=relaxed/simple;
	bh=Ig2OVt3TBv7ddvTUNvfJSFZLo8RWweuoGZlGh1vDWos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSAdUx+n+amerGdvdAxtybZkCUDExPhwpCM2tt1hVMal7/Kzd44RG2g3Ll1cbg0H3Iyq8TT/HMlEpleQFIbsee+WFzAXk8Y4q8t2wFaO+/Z+yM/UVaAx1qFdCWOt0MgpNdily3BkhRbIzjkpEFtmCHWzXwuV0FEaUZu5vJvyPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ESC7eG0/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ESC7eG0/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b64c8311so79883805e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781125729; x=1781730529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig2OVt3TBv7ddvTUNvfJSFZLo8RWweuoGZlGh1vDWos=;
        b=ESC7eG0/h0wcL/pgHYK9IZYeVLZLimwgp7TKxUs3J60QKyBa9EpnO6n4UAg8ikSDNS
         wdplRVodOBZewazj9JO1fDLlxZLmB1Zw5vpokf0+F2cnXy9oo49O9CDAtKmqgf0gmodF
         A3T08vktkSul+O38SljexB+Xitw1WxBfqKDnkSiBfMvXcS0HaUoHJ94EkFaBA8URJ+Qt
         7s5NkD82Afi1accP0FRP8b2Qx7Vs0G1d/jAzhrCQqysepDJfJvE159ifmGgGOiOq6dhh
         96vSZsK1sX16au7lJOs+Mh6kCkAniIJrxOdaAIM+jHJx+TD+1wLX5Pl6OmLyGByPVj8M
         9Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125729; x=1781730529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig2OVt3TBv7ddvTUNvfJSFZLo8RWweuoGZlGh1vDWos=;
        b=A1TtA5lNuGLPOcJA7rEy9CiCF7d8rCYcdQHgCiGbZXeyPtT4VoYkmjdqh/dcY83bsL
         ORIa+Hri3O4eNrNP1wKApfwFF6xJsai5leJ7aOjvrY+dRwqK7YqSeTYu8ExddfQeMzjC
         oL8sxFenOTdhe2Eog6eoGBfnsOLS9Q2WToC+7OlLhF/MkGNJfx/ZkjIN5+C77WWssrpD
         8jSHzphte9Vq0ukrOkURpZIqv4ELeqayDBJ3uAHmPAPniiGM0ILT4GXKyf2cUfY468Z5
         HhF5sip0N68dXPpt7yjQnYlZF3kKGxVPVbnbUI7aUHFH3vm3o+jqE9RXqHJTVHqjsw8A
         fLLw==
X-Forwarded-Encrypted: i=1; AFNElJ+g2nxJjDkxFGf56NN1MnXCdohpilFwTnKnizt3UjbWUx28pc1c9DMqFP/VGYlmxYE7pM32/GWsCW32fT8D45A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrH4U29zTnEMhvmu+uPTE/phg5c9ZQDgEP7/FqfG2zVv/1xB7d
	P5V833rTdB7t+rSAOUd3XgIUYumyGjxrYbmp2xNZ9GLjSCnVOI5XG4bT3ir9Dhm+mGw=
X-Gm-Gg: Acq92OFBT8qVXYjHqU4ZBdtfL8wduNHuSg3Ihejm8yU+F+yEzhi8KY90M5kycHLhaJz
	jODswKOzkGhCg71uf/cuapQ+K/DBtz6UgI8JfjJS/waavMPU12XScGEdfMBm7vhkSp/qRPfTCHG
	+YG7h8iHxc6nUw9c+qcsE9thY/7DLMYLJuM00TYvH09pCYAtGVaXuOcqZYr+HwSesSCWYk14tZW
	MypevTfv5bK1AuQ4z0Fvrg5LXNsd5RG7KHj7fu6yoN1bmAZ+OPwvqQW/CW8uK4TymdJRLOGx2z0
	TMIZ80G2bcxrDjRH0ptBbKFT4dKMjwFwWQ0UWrtD7+we9ZYhrY5BQk5Tkxu29qPSLSbJcA5Kk1l
	SabktGkojin0bOrma1LeYWSITmnvhFQCEbfDjCdH9/eaNlJA33XVJOGtokYyQzPOB8ZtJs4Ez4X
	3rkBZP1+BF4u/R6TPb4RC/KRmhbEE/8oxNN58KNO4=
X-Received: by 2002:a05:600d:640f:10b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-490c25e30a2mr298781385e9.16.1781125729131;
        Wed, 10 Jun 2026 14:08:49 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46028a6dce6sm67341274f8f.30.2026.06.10.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:08:47 -0700 (PDT)
Date: Wed, 10 Jun 2026 23:08:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
Message-ID: <ainSCcYroJUIAuwr@monoceros>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
 <aimXkX4FC4JVxt6q@monoceros>
 <CABBYNZKuOdtxa8ksEZM1FyjYJCQ22H6NzaX31t6LcZuvn0LMNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqdkuhrraxjetghb"
Content-Disposition: inline
In-Reply-To: <CABBYNZKuOdtxa8ksEZM1FyjYJCQ22H6NzaX31t6LcZuvn0LMNg@mail.gmail.com>


--xqdkuhrraxjetghb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
MIME-Version: 1.0

Hello,

On Wed, Jun 10, 2026 at 01:13:44PM -0400, Luiz Augusto von Dentz wrote:
> On Wed, Jun 10, 2026 at 12:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capab=
le Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > On Mon, May 04, 2026 at 06:09:40PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > Initializing a struct using list initializers is hard to read, compar=
ed
> > > to that using named initializers is more ideomatic. Convert the macro
> > > used to assign values in the driver's pci_device_id array accordingly.
> > >
> > > This change doesn't introduce any changes to the compiled array on an
> > > x86 and an arm64 build.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koen=
ig@baylibre.com>
> > > ---
> > > Hello,
> > >
> > > this is a preparing change for making struct pci_device_id::driver_da=
ta an
> > > anonymous union (similar to
> > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@bayl=
ibre.com/).
> > > This requires named initializers for .driver_data. But even without t=
hat
> > > this is a nice cleanup making the macro better readable.
> > >
> > > Gcc is happy with simplifying the assignment further using
> > > PCI_VDEVICE(BROADCOM, BCM ## id ## _DEVICE_ID), but this is a bit fis=
hy
> > > because PCI_VDEVICE also assigns .class and .class_mask (using list
> > > initializers), so I didn't convert that.
> >
> > In the meantime I learned that doing that would break W=3D1 builds, so =
it
> > was a good choice to not go that path.
> >
> > > Once all pci_device_id use
> > > named initializers, the two zeros can be dropped from PCI_VDEVICE and
> > > this entry simplified accordingly.
> >
> > Is this patch still on someone's radar? Ideally for application in time
> > for 7.2-rc1?
>=20
> It is no longer in patchwork so if you really want to get in please resen=
d.

Instead I unarchived the patch, so it appears in the patch list again. I
hope this is easier for everyone (it is for me).

Best regards
Uwe

--xqdkuhrraxjetghb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmop0loACgkQj4D7WH0S
/k5XeQgAoTcuZnjClD8CBiVzulCVvCVSkCfgQKHapo9L6hikgCrhNsvTOvHMFU6S
XDZ2dot5rGjM/KAYI0h8FHaXTdH36OKmbjykaiP+DIFuHS7VkpWcSc2EM7hAvZha
uGcJCF4xyc5CyNPElG/wDPHJdL2fJPJkKUjMeDiFSnU5qRg4spodg9e2dD03Hrap
0D0yH2F9jcYbHNC851gjYuJ3NvrJEHijOc8vg1Ylw8+9LsQDrt76yI2uffzB8/6n
/CFEgnnByMZObzRw6oaxYc9jXkjK+e7oiquz56xyx0c3SqFOlMrBPo3Zj2G9LIRM
UFLkgNRU51FxahnG5mJuKv98enwHMw==
=zDmy
-----END PGP SIGNATURE-----

--xqdkuhrraxjetghb--
