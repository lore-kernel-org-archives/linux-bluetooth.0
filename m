Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AA3ACEE0;
	Wed, 16 Sep 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583606; cv=none; b=DrvRrSCecUWn8vpgbv4mzr9TD4zRjAwPxjXEXA5ghtF6g6FtEz4ZPK1Ls08NYFGBtUfGk/OSeRgMUsGsNd5f2bcJDgWf5u+EQ2ugTvIqZyaSc2nOyAvTCqmKIzhDiV1f2xdx2TD9W5MHrDT8oTVRwzykxauWDAN1ABd1dNa8DF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583606; c=relaxed/simple;
	bh=XT0jJrySMVbRwELXjvHsH7ZPSgl2osg69Jo5LaW1E2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPA/5Xae4OJhUjb3thkbGUFS7blWTFNF6PQX5mRowoPhO0DPk5R9BpMKRtm1SMSDsSGNuEr8PQaaXszteg86jwIcE8MWD0uWRPgIsA2Ce10B9ABklfHK7txg650g/LGpZ1epsNIypEI7n4L2X6m+NS2JCYIMMLYMqq56vwTLssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD0DFfKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD0DFfKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACFB1F0089C;
	Wed, 16 Sep 2026 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583589;
	bh=n8hj9CA+wXBbNJr2YXNJ6pr/sjRbRY5kxxZHC+d9bVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CD0DFfKkVhBFGuJtZF7BMM2gAYGN01q3wnBUSGPiyrHFoAXIGEJ2QZOoGLPdcW5JS
	 eHEEApN18b8oPk3aZa8kV5MHxvm42O6m8gN5OqeFOURvcyCMZATGiOi0Z14l2E3zkz
	 UAsZ2WYdtAyU4HFA/NE9WBg8wdcqqFhx4vp7MZRBjHdz1TWi4ow+QBt6E5Vs8EhZcK
	 iJQm/KzJO8LfgKVrAPgsiNZKGmTb26jS1+kydJkS1fSKYH0IrgONTV68OVbyAhuyPd
	 DrA0nxRUjHzSue7PuimiUdz7P4WS+feTpWnRipXRFOITXXJDtAv1K9FtZ/UWOPVxfu
	 Yx9P9XR+j5I7Q==
Date: Wed, 16 Sep 2026 19:33:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
References: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
 <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
 <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk>
 <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
 <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gDlfHHBCP0tD3N+L"
Content-Disposition: inline
In-Reply-To: <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
X-Cookie: Double!


--gDlfHHBCP0tD3N+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2026 at 02:30:30PM -0400, Luiz Augusto von Dentz wrote:

> Fixes tree is in:

> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git

The master branch?  There's also a for-upstream branch, though I see
it's very old.

--gDlfHHBCP0tD3N+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqq4N8ACgkQJNaLcl1U
h9CNHwf7BIfAgpei9j/FbS8KX5Zbbnx9cR8VbeymsludvOKoToUFBQba1neG1tvr
fzr7r/Uox0a7KEFgKtggy1F2Db/CvjEgd1zpcKciG87/GfHdN96Q4f5QdUzx92Mr
fJViNvQ5vcxeDSBLYE4zK3XNPf6MAqHIDAtcJzS83q883EHRloectEE8esw9HOOd
sYM3w3B2lZqc1T+YY+ghefslGhNdz3FQVmU+i0gwVgA8xfvKGvYIdNVJwrugZ+5l
GK/Wrt7/O6wLZOXtCyIGAtJMwl/bGcQNdFPibrvIARiaWjNwUIUP6DGEtmHVCl2D
QLV3oNVi1QXdwUwTRF7CIsx1YK+Kyw==
=JayT
-----END PGP SIGNATURE-----

--gDlfHHBCP0tD3N+L--
