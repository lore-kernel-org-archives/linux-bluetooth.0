Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D636DA1D;
	Mon, 29 Jun 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734700; cv=none; b=lOZ1NjPLBskuxOup1eQNbYd3Pu8XfM96cp9Cdts8wMcFbewW/UO61OClHybMazxe9OJuhUycb75cArC6H3Ow9HEgft+Bk3rULUEN/5ppmQe1Eoj/mLaz6H1y+Gt/AZHT6jFYRBvg81MdenqbFoEHdQCMIrcC54MhOuMJT++BzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734700; c=relaxed/simple;
	bh=p4aiUHMFEbYpaocs+B9+YwXK87paMRi1Mwkowd0T94g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2qhQuF+fm2u+g2Po1+ynFoKdNTO6Mw4Ruu0eT2s2ui7R9BhfiK+jlJkPMOIvAWBqVbCO4c28kRfWPp8tX0h3GANlEBXOox39x2F6ZhtayfPgBHGZvzxP42bcT91KTp0SW2mWuDD74kE3m4A9CJwloErdGs5XUbMALjE64caxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU/q1jKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU/q1jKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31551F000E9;
	Mon, 29 Jun 2026 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782734699;
	bh=3rItGf60sn2cdil399PCb/Dl+MIjDcm9TfhvcQMWjFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fU/q1jKNNXh/AN5D4RAJiCqMc/syh8dfRrsgWXeY1Y3/Ev1hsUzqAHcKgnqWnc3q9
	 hbMAJGOoHelH+slvrKxsL6dcp1/k+2SRTBPmVPG2SqmN2K1jolVOi7QBCm6Tdl7c+n
	 o0jCSEAnigeljMbB4jK0ab5JBrUpC6AvU3Qcj1q4DvSqSP1W5/wcOForMbuX88niYm
	 ZaJ1PHBYwiXPeLjDkMFfaaSqlF55TSYoRp1nFfm/T4q8Xf+tNlQ2IWWe5cmS+2S6oP
	 8qVgyugSdsr9klhtoKSy+8mg6Pvo5Pa8KxxXmRqCb8A4uyM8M5Vs9LDAX9ZglDVZN1
	 IriQp8K+j//Zg==
Date: Mon, 29 Jun 2026 13:04:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Message-ID: <20260629-handwork-retract-224b150e5969@spud>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
 <20260628095500.29810-2-hugo@whynothugo.nl>
 <20260628-shakable-spooky-e75e410f20f5@spud>
 <91619a5a-602d-4650-99d0-326971f5e5e6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8OV1pfsmx2Rdbg8"
Content-Disposition: inline
In-Reply-To: <91619a5a-602d-4650-99d0-326971f5e5e6@app.fastmail.com>

--K8OV1pfsmx2Rdbg8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 01:32:18PM +0200, Hugo Osvaldo Barrera wrote:
>=20
>=20
> On Sun, 28 Jun 2026, at 21:17, Conor Dooley wrote:
> > On Sun, Jun 28, 2026 at 11:55:00AM +0200, Hugo Osvaldo Barrera wrote:
> >> Document the compatible string for BCM43752.
> >>=20
> >> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> >> ---
> >>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,blue=
tooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth=
=2Eyaml
> >> index 95501e858e6f..04e8a968548d 100644
> >> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.y=
aml
> >> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.y=
aml
> >> @@ -29,6 +29,7 @@ properties:
> >>            - brcm,bcm43438-bt
> >>            - brcm,bcm4345c5
> >>            - brcm,bcm43540-bt
> >> +          - brcm,bcm43752-bt
> >
> > This new compatible uses no match data. Why is a fallback compatible not
> > suitable?
> >
>=20
> I wasn't aware that this was the preferred approach.
>=20
> I used `compatible =3D "brcm,bcm43752-bt", "brcm,bcm43430a0-bt";`
> in my DT and Bluetooth works equally well. Both of these patches
> can be ignored, thanks for the review.

You still need to add a binding patch to document the new compatible,
just it will permit the fallback.

> There are multiple compatible with no match data, and I was
> mostly following that approach. Are they there mostly for
> legacy reasons and adding more with no match data is discouraged?

Correct.

Cheers,
Conor.

--K8OV1pfsmx2Rdbg8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakJfZwAKCRB4tDGHoIJi
0lUhAP4+XCclWEulY4qjxhUNOTo4lFZxjW85r3vn+wxbHhPBdgEAuBAVFVS6LlmY
kRP62Hbfg1tI1hAW6IgIKun+Z6BSEws=
=yaQO
-----END PGP SIGNATURE-----

--K8OV1pfsmx2Rdbg8--
