Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CD3FD960;
	Tue, 15 Sep 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500271; cv=none; b=MjppFihFez6M4921/oSlEeeDs8MJPX8zlxHHZXhEnwgwC43If0A5PB1vxZ/2eb5kViy7c1XwcljjTDVsBgE9WT+uMUJZOIcUXYRHOLrjDZq6aAMRuK4oprAvpCgFEGSwID8SX+L7U+VA3nfK3SgIO2a8r9laQlYyBYms7a9YWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500271; c=relaxed/simple;
	bh=vA5X6QFhQLgK/k1tr/yADaCMbikKjqyPLUWFl0Bcz7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBUaukB0bR8o0YnnDW5tv623Kj1L2c2DN/Ajs3DCKvSJUF5EWYTlMOlZmU4Goz6PuzaEAA91Bc2fo2Qp2m88Ur+OPJmB/Z+PGaxsIxJpGmzXVm6jwcH93E2PLQehM+qa1tCa/Yi7VpQUPwz7YmgZ2JJF9OgLE833td5YDd7YqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4fak//P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4fak//P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9AB1F000FF;
	Tue, 15 Sep 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789500270;
	bh=F7cmfLKL0CgX0D1V29ZE9MUAec1F/SH3IadiBa65c/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4fak//PepBq7toazb4/tThvdUUHQNVWK2aNHBH3Btd/1TV1J6oXquMH51YmrJfvB
	 dQdEwqJl8m1v71RoOL2Q9FYznmKQyfVFveZDXSm3N0fzysqikrktr1/zyFCCU2s8ij
	 HlXRxcantjbzhGSLeI6jz1o1G7miNFU4Xw1d7qQZJb3M7Sue5v+GQHfXaIbHeQxJ1j
	 OGaZ5EJvmfiJMti3Ssoumd1SrLRSAqYw6SW64v5jTDM8aiEH/CeJHp2FbDrSesINna
	 Ojv3V+3PgKxe7xU24M14EY5Ezk1e9Owh2gWuHSQEGoyVYTaOHpH2ub5OadIbxOhuBz
	 EMf75glOc+EFQ==
Date: Tue, 15 Sep 2026 20:24:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
 <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sDfw3k32+BNPtIBe"
Content-Disposition: inline
In-Reply-To: <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
X-Cookie: Void where prohibited by law.


--sDfw3k32+BNPtIBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Sep 15, 2026 at 2:26=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Given the issues caused by the unusual workflow for the tree I do send a
> > lot of reports of issues in bluetooth.

> Are you referring to the unusual workflow where fixes are merged to
> bluetooth-next first, then to bluetooth (which changes its ID), and
> finally merge to net? Changing the order to have Bluetooth first and
> then bluetooth-next would require reworking the CI so it could
> determine that it is a fix and then use Bluetooth as a base just to
> avoid ID changes.

Yes, the routine cherry picking is certainly part of it - it's not so
much the fact that things get moved between branches as the fact that
when you have the same commit is in multiple branches and then build on
top of one or both of them this creates extra conflicts, often harder to
understand, when the branches are merged.  The more normal thing would
be to apply once to the right place, or the standard fallback from that
would be to drop the commit from branch A at the time it is moved to
branch B.

You do seem to end up removing the cherry picked commits from their
original branches at some point as part of your workflow (since there
are hardly any duplicate bluetooth commits in mainline) so they do wind
up being moves AFAICT but the duplicates get left sitting there for
quite a while.

--sDfw3k32+BNPtIBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqpm2gACgkQJNaLcl1U
h9BbMAf5AcOdeS3iqZECyoRqIfzwPUGBVKOnztUfB5hUWaigNi2ex4GUcwjq75Bq
WzLXw9SzSH84XakmF3YAdPACyzBpG3YmbY5XqRJHuyblhQri+Y2LSMbrW1+Sh1yI
6M3UPCZFSgybIG8oSS3HfA39sPPcPuQ3W0GL6+kyCgkI6TrA6Qn75i7iiMPNrfT2
EC7DB9jbIY5x+DWCP7XCeATFoFyD1b19uEiwyNm+ADEG0Gzy/DfZ0lyRRkXRRlhk
5alEOcVdO/rgaNd5qsgFCCjuVINibOmfvnmxia1jDyyN1vUyOU/dePMC5D6AL593
W37qc2iAH6w7a6mO6Tc9upJ9GDxMIA==
=t2x4
-----END PGP SIGNATURE-----

--sDfw3k32+BNPtIBe--
