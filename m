Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD234BD0EF;
	Wed, 16 Sep 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582526; cv=none; b=g5jSghTs4ZLJ+CtcjVF8090pKOYNWOTglwA3QD7mS8qk2NBQSrWbk4KuAoaLH46TI5jVIsfdQDQ7qh27y1Mq5nQMGYNJJM3oabEL2nkbmOSR+ubGIKzvassbbn7CcGzH1CvsqtPgAlmHq+BDNbwxU43sWKP8KPsrQhLKdsEptsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582526; c=relaxed/simple;
	bh=SC8FD7pbNy8s4h4Npy0h6viekTFgPMiB+9syXa5QoNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPCrxZZ0o8oQQ8WD5eoCd/DDquGH4aP4twYHluVdqT8oL+VREl2HPpYwlSkx6dQJsLKhf9Zm9fC8EkEkZ6cmpun979EFtvYB3FYydlwct3RPpGjEHyqekj+NX3y8eR58cGyqm7vFpgxATUERLLNRwoVZ43Fx2z90OgOqZNoU2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzWkTQug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzWkTQug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA191F00898;
	Wed, 16 Sep 2026 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789582510;
	bh=SC8FD7pbNy8s4h4Npy0h6viekTFgPMiB+9syXa5QoNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fzWkTQugYxSTSWiGZVpaBvvpTm1KiuubzIgLlbtogl+cuV12R4UTfdkwqElGA+GVg
	 /GBP+nRCTRbnRZdLQ8oyac3lRBcMACm+oQsSkulRX/ApKPwrKlYXc3qIN4P28SQu4/
	 zRIYQGZISiAPIv5zm7xJ4LjU6O6vXHTbDTCYxQ4Ig0M3We8jbR9851IaTadQmu4Klj
	 4H67XIHksusEDBpDuKzOP8nOF1siVoLQZoaRGqhQT3egG6t8YzpdcOI3s2X18qnGpm
	 hHNXaShVhg1E1ZlRa2ueHnuXyoWySgW3CaM4K64wLmUoE5laa9QNVmV0du/Gct9D1I
	 VGEjClcOZjYMQ==
Date: Wed, 16 Sep 2026 19:15:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
 <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
 <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
 <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tLuHTkbR9QT/mTSI"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
X-Cookie: Double!


--tLuHTkbR9QT/mTSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2026 at 02:12:28PM -0400, Luiz Augusto von Dentz wrote:

> I incorporate the merge back into my workflow:

> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=967788508ba263e22d856f971c9118dc1a73f6ff

> Hopefully this should stop showing conflicting/duplicate IDs at your end.

Thanks!

> Yep, you can add me as a contact person for both the bluetooth and
> bluetooth-next trees.

With your luiz.dentz@gmail.com address?

--tLuHTkbR9QT/mTSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqq3KgACgkQJNaLcl1U
h9Cg8Af/QPVk3idwMHi6oYby90/tjeGrwhxApm4Cnp7SCHOyO6d1XYEqeICBK+lm
9TVZYXshzHvxUip/Sp1FAJdpwgHIah3wzUK7ayDIu1roWDGfvgUfQYTiM4aYJakY
YM3/cjYbPwXz48DgMhTzlCsYUVWUiP32vZPo1rN2Zr9RjzFLEw803sZtUOqMtdrl
HoodE0GOXmRGlPx6RI86wWghh054YLkzTCW+UTG4P/qWmXAYSeFeyNVgUGI7V7cy
8kblJmVMNc+CZQd8lug2SmPn5nrNx29/APkJyvtfcMvDmNC4k1llxI23YAgYXlab
LkTn2D17okt4FzE6Ycz7lKwb+nIXyQ==
=Pl/w
-----END PGP SIGNATURE-----

--tLuHTkbR9QT/mTSI--
