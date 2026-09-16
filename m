Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771654C9DE5;
	Wed, 16 Sep 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583282; cv=none; b=b5XETIPTgH1Iq1UjCwLr2TFG7LtQld6P2buMeoWrxmxPXPRpUE3KlvbygbiZ8CHf3ujBEFooG5dfXfByzzW3YlEzjey9rh4n9TnuTLNCZS82RUtr1dmkZztHjium6InBz0F8o5CjHPSmnqoERGrB5vXLaAsFSW8RGhH6af8baDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583282; c=relaxed/simple;
	bh=lr2PzXDynq0vaOYZ8RThKP/H9vg9zSk+rb7zkalDn1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KurpqPxT5vvT/fc7WIw1epNMlURmywsT9TwxE8xPpwhnoUapjdI38q5bnB/gfPqsIEM48qD9CdoczMgeam/aRms5D7f7LnzdZ4xQopDGxgKaoNpaDL/8Hq+dTzcVR6Z/vLK4wfnn+5d1CFcLp2Zkgz68LNE3m+Ksj6buAJAYYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8T+wb7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8T+wb7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5891E1F000FF;
	Wed, 16 Sep 2026 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583266;
	bh=/DpcGeZXpz5tcv4wS+TfLtzQCtmcLCofNZW/+Xu3TL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g8T+wb7NUW7AF9wT91j+m2hDUGt7wlsIVY6hWZZSbqoBiNi/d3meJeVq2EFEzZChb
	 GKYuJuH1BXynTRsBvhyKiH7b5Hlf5pof1mfJGOnC9ABF6SF8K9gTJ/COQox4fSJcog
	 YUOVhZPiLsOt6X/eduuzomWEUjh9jcKTPmHKDPWQYFQxGQOGbRUxg8rqijNstVj8Tt
	 PmS4Roj8zYiFofsCB5gswPJ7ffVWiMXfAl6ZAomSDxMdSOv6yFM+y2LC4OhWPuqjj3
	 kMti7kQPbJgc6s3g+KtMyNTrj9gZk79k02DBJijdDj6IEzRojW0G2KA9oYJ7FPv2rg
	 JWp+nUU7VL9Yg==
Date: Wed, 16 Sep 2026 19:27:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
References: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
 <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
 <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
 <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RJk19QKMHjZRguZq"
Content-Disposition: inline
In-Reply-To: <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
X-Cookie: Double!


--RJk19QKMHjZRguZq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 02:17:35PM -0400, Luiz Augusto von Dentz wrote:
> On Wed, Sep 16, 2026 at 2:15=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > > Yep, you can add me as a contact person for both the bluetooth and
> > > bluetooth-next trees.

> > With your luiz.dentz@gmail.com address?

> Yes.

Great, you're added for the bluetooth tree now.  I note that I only have
one tree for bluetooth in -next:

   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next=
=2Egit
master

so your fixes tree is not covered, I can easily add that if you tell me
where it is?  It'd be good to have it in pending-fixes.

--RJk19QKMHjZRguZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqq35wACgkQJNaLcl1U
h9Ay2Qf/U2SDtErY2CG3V1qm4bEVp/LyTiNRaG/Ej6So5ilgRdoafkKeoYew7WU8
NDynRWxCarJnGvjgvOrkLkOnHSuokJRggMEBmC/5kfSJpoYFQZiO9z9P3Y0DHRji
IWIETT9cPycvTse9XcVrvk6yX1g0s/6cScvX+XxMEMnYpX2NN5/1WV7B9zaAY/GA
74Tc4sq2/Vc1kZDdtC61O7oXPzOTrm1GZ8dx9/Ul8vfVjfGzloam4KCh4hIRc+4J
CRP/gHKtHiuQ3ggnL7ReOPNUXEz7y2xABaColmrAsTTYKy/2mwApY8ox2J9HL4bC
9KrdgJlLmLV4uThIcrGL6pC0uId1Kw==
=T/39
-----END PGP SIGNATURE-----

--RJk19QKMHjZRguZq--
