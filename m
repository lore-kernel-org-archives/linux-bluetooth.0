Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32445481CE;
	Fri,  4 Oct 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055493; cv=none; b=Q7IKuWsEza0dV4Gkw17LTcU3/9eLU8RZB7j0OQQ9R/lPymNrTojHSdJEqomwidFH4yDV6e5O3DVT6KN4MuXcWvYhkgBzsjE/TKQ95PSraG+EZw3t6phgFn828lPYynQibIEVC1ZHwdtEfYvZU8jc2IPAV5eEANAUek51vTC2AKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055493; c=relaxed/simple;
	bh=SNsQXTK1hQBmBp0m1IgGUkJYgXLqNVqg4Qz9jYygkQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXlKpe0CI0vE0jJRImCftp7iOBFhPDpfnHdHR6MSPdXskTR+xcCjO2nWu1ofYqud6UeP+FmwRmwHHfvsyRBNQxHUCjEZKPq0tklvW2+6OUx+E+Ka/klNWUH5dmR7+lKroOSZutbVkQwPhduiRZvkODczk+C6LS34Wxu/vSh7txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/OrqZHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/OrqZHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0793AC4CEC6;
	Fri,  4 Oct 2024 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728055492;
	bh=SNsQXTK1hQBmBp0m1IgGUkJYgXLqNVqg4Qz9jYygkQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/OrqZHEDMFpctn1qkqSvyPzCQvfO4XSkzCvulE5hgFM/wB30envTH5zyizRS4/8t
	 3JqOsZW7xH5yqAmB+7QlSE9W0E3QUCnzFFrVseAH8vVOyTcmzKHmhWYBs7FaHzRqgu
	 SntHsEny4fYa4TqvI/IOdeTPJ2MlsBAsr92eVK+leKPK6dS+Beeax2ove5fEmccent
	 rhYCxtB2bvEMRFI2AG+pi0NU9NcI1yb0/H1GtGCFhH7S+p0jomjFNvoiYhwBWKReec
	 QiBHI7v/3zMnHQogMPxH9BSOHB7KAGezjOT77qK6F3ZDCvd7OJjSrIIsfbYEJj1xeH
	 GZNxK8OgDhb5w==
Date: Fri, 4 Oct 2024 16:24:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Message-ID: <20241004-coke-stimuli-4b8aa1be0782@spud>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+hmX0S2hU71VqjfY"
Content-Disposition: inline
In-Reply-To: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>


--+hmX0S2hU71VqjfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 01:35:56PM +0200, Catalin Popescu wrote:
> Add support for chip power supply and chip reset/powerdown.
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+hmX0S2hU71VqjfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAIvwAKCRB4tDGHoIJi
0sJhAP4gCQ2nSaAYtCDEei6OcSuCBWS4sDcYFkR6cUUNX11iBAEAiVncy3j6EGC1
yDScHH0bKV1DODnMY2v6Zp7zvLwnswY=
=871w
-----END PGP SIGNATURE-----

--+hmX0S2hU71VqjfY--
