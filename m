Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1B399011;
	Tue, 15 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494393; cv=none; b=SVu/jn2ZjtGEikxqzfuLk3kg+cB24pDPvPw7naymp6q2JH0eduA+uJbjR2e3gbZnrSbKcN/ikDvt73R5U7lmNl6DQHFbVyXr+0pxmM5muxDrYkP1j5QoH+FqdTXuRKeM/9LUMjuvvprZFSMNXL8YwCqlGUmzGY50HYzfm7I9sMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494393; c=relaxed/simple;
	bh=vSrBcIop7u/WmBhSB2lDS4vwGGsoYSIo8rHmmdCC+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1Czgfr56xbiyb9X2UYiVg0CqjJOdNG8Zskn1VIIe3nna6uHthTNz/n3FzIhbpL7sMPmu485o3K6R4aDNyrgtupddaUat5P0dzxfdPVKVIPLlNikKYlOvFu0JvQGe6kb7bur9QJdUZDODI+RbalggivZBLa3k87WlXO5VpCqdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdvmloM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdvmloM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F311F000FF;
	Tue, 15 Sep 2026 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494391;
	bh=s4jG6k/X2BH1iZU3VfNhENHUHPFHxhUKxlDfcJQXC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BdvmloM+TSr4I59SH3XFR83pBz/6TNrEW1S107cXr0YQ7CAR1WmdWoOyoSzlQW5Jr
	 p9/AOs75xOTBAohJVI3SmxbPsvVt+ialBRGFneL0HVU1nDzPGK0/v8U8WN3Xz70cg7
	 ZPExFImbt8HjiJZu14oheaKPjOE0/zS1Q2h4Yd/EjWPL0CAL+b7UuDZSxPXyH8TNBh
	 /YbcoZPv4L8SZ87UzVehQWyYUYFcdIfV5aYUGLWY9dRi5V2mxt7B7enAn8kunmzn2N
	 xtGrZD9FD7mfKpcjHPKTS3Ni2GHPL1GqYhAAz9kfpeTq9MwDYcs4gzpoRNmH9wpvHV
	 SIf0dZPwk3+Og==
Date: Tue, 15 Sep 2026 18:46:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
 <20260908135708.552fcead@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYkZelQO/qeM9U4V"
Content-Disposition: inline
In-Reply-To: <20260908135708.552fcead@kernel.org>
X-Cookie: YOW!!  Up ahead!  It's a DONUT HUT!!


--bYkZelQO/qeM9U4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2026 at 01:57:08PM -0700, Jakub Kicinski wrote:

> You're missing a bunch of your own sign-off tags.

FWIW I do keep reporting signoff issues to them:

   https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
   https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
   https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@sirena.org.uk

--bYkZelQO/qeM9U4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqphHIACgkQJNaLcl1U
h9BhJAf+OA+F0Sk3kX+dto732cx3xrRk3OtRl/4a4hKKyQCHfnRBOlKb2a2oedIT
c3/IWewsGBndBy5veft8hBpfbS3Rq7zvZ2nERiczPu7neKzHIjqQOORXGhcJPNd5
Nk3GZfKMsiXzjkmD7PbZ9Yy516tmg32Lj39UVtz31ecr45ngNQzpZ/CdR3EyWBue
vYlfe2RDBHnhSQT5zfV5jpWA/4Sp5XilZq74sb1FDZjhd8ASlwUl1dhYmuWbE3qH
XpHhF6BKCkO0sON9UXFfHPGYM1y39iw99vQnWHMnxsjq490hwBSN5ol2T9ftMV3L
YwpHC+h8RLRuwsU/ianO1S9B3TdNBw==
=Fl4F
-----END PGP SIGNATURE-----

--bYkZelQO/qeM9U4V--
