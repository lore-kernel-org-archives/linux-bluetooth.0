Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993D457E47;
	Tue, 15 Sep 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512893; cv=none; b=UBFxPCcmNBKV5uWdLS5aEE+Zlz5PJyzhvqoJ3rB77pS42BL+ROroizIhGdhG5qmzU3ScgVLBSSt7sKdEUeyfqyNPj11RDKYeNMoh7y+StVnUeSrxgZF3vQ0sKRQJYBux7tunulqUroAi+WWCek2nSW2FvnydDMg7EuBRaBjZPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512893; c=relaxed/simple;
	bh=sTKIyEOuI7a6+JT8x9pGnRFmytyYd7oHP2DvC/z48WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsE33f8YpMunB/bEzl4+BYZUWkDc8F0rBh10YyNRf+xMbkS8ISl+ML3LD7I+JzWJvwc5upzBuw87A+8Q09qDv3YAiy7lmkN6RRrTpAKj3JztoeKNu58bBsIYflTgHdXi+7b8JkAMtMEqS4+ISH7ewXwfvf0n9LueWu4IB37z4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehIeqD3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehIeqD3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A9F1F000FF;
	Tue, 15 Sep 2026 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789512892;
	bh=wZ7jyYz4cf7dJrpAQtSCKqzLWmYVq9M5SWkOAft6ND4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ehIeqD3sbGDXh2otiyRGE+WwqM1IDxvQ8Y2RCIvF2/0EngBtMxmJIR2Eyjbq3zsdY
	 sRwIe6oYQCp7yL+cjO6wa1ni63ZVdRZUNNvX6Iufcx6fYgDv55F/wAINne6CHAjVTa
	 UustT8JBYR+nNXNmONXdNC8PU9clMdwB94AMLNKOYYBbaPB1p4I8kuHG3kv/8RB9KF
	 Rwqo+xyOfXLrZzVPYpBO89TO5ifN79zWtlyvn+/R1LvonyYNuOyRPJHN1r8aAJbduz
	 nZsIb3PGiJj6kyt+yO+nFFko4mg0NDDm7NVmlBbfqz5xp9bUooO+Zji1kpTZrlLCWE
	 RmGIkbWwrJr1w==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 4393B1011727; Tue, 15 Sep 2026 23:54:49 +0100 (BST)
Date: Tue, 15 Sep 2026 23:54:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <aqnMueXiCztLUn-w@sirena.org.uk>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
 <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
 <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WdyblAnYvhvORoTh"
Content-Disposition: inline
In-Reply-To: <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
X-Cookie: Orders subject to approval.


--WdyblAnYvhvORoTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 03:36:50PM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Sep 15, 2026 at 3:24=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrote:

> > Yes, the routine cherry picking is certainly part of it - it's not so
> > much the fact that things get moved between branches as the fact that
> > when you have the same commit is in multiple branches and then build on
> > top of one or both of them this creates extra conflicts, often harder to
> > understand, when the branches are merged.  The more normal thing would
> > be to apply once to the right place, or the standard fallback from that
> > would be to drop the commit from branch A at the time it is moved to
> > branch B.

> If I merge to bluetooth, then bluetooth-next won't contain the fixes
> meant for stable/rc, so I will need to merge them back to
> bluetooth-next immediately it order for our CI to stay current with
> the fixes.

Or have your CI merge the branches and run on that (that's a fairly
widely deployed approach).

> > You do seem to end up removing the cherry picked commits from their
> > original branches at some point as part of your workflow (since there
> > are hardly any duplicate bluetooth commits in mainline) so they do wind
> > up being moves AFAICT but the duplicates get left sitting there for
> > quite a while.

> Yep, once before sending the pull request for net-next, bluetooth-next
> is rebased on top of net-next which brings all the fixes already
> merged back to bluetooth-next. Git is absolutely fine with that, I
> don't think I ever run into a conflict doing this. Git detects the
> fixes already present in net-next as duplicates and eliminates them,
> so it really surprises me when you say you are finding conflicts, not
> just duplicates.

The issue is not your rebase working, the issue is that until you get
round to doing that rebase anyone that merges both bluetooth and the net
trees (ot Linus' tree for that matter, often the conflicts are with his
tree) sees the duplicated commits and that routinely generates
conflicts.  This obviously comes up an awful lot with -next, I am not
rebasing the trees but rather merging them, but do I gather from some
conversations that other people are seeing this as part of their
workflows.

Anyway, to return to my prior question: should you be a contact for the
bluetooth tree?

--WdyblAnYvhvORoTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqpzLMACgkQJNaLcl1U
h9DbOgf/VLj5E3S8H/Irnn6oxArruRBuijp2VDhtUMpTH3RXwRjzxgPk0f+zt6zh
oxevTuZw4S/Au3wE8u7VEStmhl+cz52ZSCZ1NIJlVGYwazsoolJE5dQCY5d9p8d0
8m9cOTA+2PpjLTMQ2ewRV6fvwBovoaMVwiNN9WVknRsyKSJkMdl072fFYVSJLyJJ
1aYckqXCx48r+x+nrwir+aeNyJeCvO4ADOze63YcbFkLWJQj9muQmNzAi37MmUF5
zOSK19r87j1Gw4fJlcFzm3bJ8ZzrmuA+KEwpIvV3qCyueuoSERKEWQFatyBRtsiF
VuUuGQjstInHtMYo0QIMPPYHeRlsCA==
=Bty8
-----END PGP SIGNATURE-----

--WdyblAnYvhvORoTh--
