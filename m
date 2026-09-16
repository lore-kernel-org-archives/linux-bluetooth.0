Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35454B1D1E;
	Wed, 16 Sep 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584088; cv=none; b=J0rgzkzWq7Vcw/x7FPUmChZjgPDVZrfJis6W6Dsc2LcrQJmGs23HzkYjwMd14YVrDt8wq4GRa1vXD3lBWFSdg1bsG4EwP+gssoeVtaw4LpU8FI0ut/xnI2Pb1/mlabY5U/SOPEg/+PpyUclkx6QacqchwWKWo9ArgFP0aM8rNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584088; c=relaxed/simple;
	bh=A9gTqPy2U+L2MFZYDapWdvYX2Leh6ZzFi5tjFFh2Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzgouvd+IuWGuTypU2nqeM+ATm+3D5Solni+a/ExXhxN/yx+Av/qZbJFjD5KW98BoBamZBg4DKWlZOsqb76hBCkehAeu4gyQW5cMvC0apXs1m3lRZr3nZBtKCudWZR+4GgBF1BZms5a9oKsgLLkgKHYduTT7XLL7LF628z0D6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuPgsrK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuPgsrK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B191F000FF;
	Wed, 16 Sep 2026 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584060;
	bh=xAFDzTHLADEZ47wTVVOj8v/d3xF7Uy72lZG5jxS51J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iuPgsrK/x2+h10PLQ3u2mtur+HvfyVIofs8/L9k8BaJwBYuFGQOfPBXIoQM06sxZR
	 wyHuVPjMXWiBRsZC3Imx/n73USvJhCo4nKv3L9C0v4w3vYvRGfTTPbQZs4AWEkrGWi
	 zHeXL2b+ZdXcMHX7y498b7037+XXnFackTbxf4KaisT2RkKy9xp7VafmeI9Y2MBTw9
	 5Ph3GN2XIKc7GX87c/lcyZE4l++EFBI5AVAfGwchqZUXAlgSC6Gndhltj+FC5c0VmK
	 bKr7zdTY9Sk/xuOqaXj2f+hO+RQMo42buosvO9gp1+ow4yEhIHo3wOcijLLWLgln4M
	 DP7QOpzSls66g==
Date: Wed, 16 Sep 2026 19:40:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <1f430395-ae36-48a5-8bf5-0ff90fbb1eb7@sirena.org.uk>
References: <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
 <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
 <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
 <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
 <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
 <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
 <CABBYNZ+Nj3x9K1AC0FtcSAG8OaM7tND8+E5UkDzvshVNrRMYRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drctHe+nEncUGQ+m"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+Nj3x9K1AC0FtcSAG8OaM7tND8+E5UkDzvshVNrRMYRw@mail.gmail.com>
X-Cookie: Double!


--drctHe+nEncUGQ+m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 02:34:18PM -0400, Luiz Augusto von Dentz wrote:
> On Wed, Sep 16, 2026 at 2:33=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > On Wed, Sep 16, 2026 at 02:30:30PM -0400, Luiz Augusto von Dentz wrote:

> > > Fixes tree is in:

> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it

> > The master branch?  There's also a for-upstream branch, though I see
> > it's very old.

> We only really use the master nowadays.

OK, that'll be there from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--drctHe+nEncUGQ+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqq4rcACgkQJNaLcl1U
h9AcjAf+IYzDQIaJVHHmC8WyKRsH7xvHyfziCOQLxuHYPzuQoZH60hT4A551z20D
2jex8BCzSq9x/q8In7s3b8ZtaN6xVWaesWn+1VGcmSvYP5x5Ao3iog6xpU6c30Ok
ClVbALDUPoIaRuanGjUjJJ5AQszkhWF9c4Ya/xwnZUvkNgoR2Uz+liN59Ku8qsYN
c0zfpP+qQs1xir10+IXa+pEWDsxoSVNL+4YkkAlQ9ixfOtkCoK8DWDp/fX+/zDPZ
fUrSVWatXlj25BSEu8mQc+0R/OCNxaXahc6PxvZwzWTCmjPLWbgn4wesqpocU41n
1NdBHCZ6ZSA8DsJm0P54MbbFkYl8Bw==
=ZiyC
-----END PGP SIGNATURE-----

--drctHe+nEncUGQ+m--
