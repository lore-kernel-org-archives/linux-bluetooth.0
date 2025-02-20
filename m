Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18CD1E0B66;
	Thu, 20 Feb 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071301; cv=none; b=gnEeBt5telSgC8rTA/hfJ/ytpFkfOuP0j0Jl19ZU2Ex8bqlWAMisGMuNoACDUQJX/MLBTVdFyFDA3pjuNxovs4SsBC0FQOcxeunOo4v5xZdotf34vU/h46PuZX1F6ElQyQL5V57VixFrE1Ysb+SqzXMSEpYs0YUgDodTs4z6dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071301; c=relaxed/simple;
	bh=zlAXRsJeJIm22gl5gl92JVR7nBolZAa4T8bMv6g+yE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvuawHdtmGODIbG+Kbt5cVph4btx8FRZKFGHKSJzi5NTgg5dmPTYW1TjKqYpVlxBjNEO3O1Y4snFTmRCPMUXzOSqWRit0Vg3R1JtuvpkyDuVDl6+nhwjIakhHdv/xzfl/REACsBg4Sup2Vy89cqwlpN1BktO/v4qL8XnKs0tLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/213mEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/213mEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E869C4CED1;
	Thu, 20 Feb 2025 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740071301;
	bh=zlAXRsJeJIm22gl5gl92JVR7nBolZAa4T8bMv6g+yE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/213mEPCMdWwJbimZg3N/GiPzMA6A5uG7RTBiKkmfI5lseq78POsQdNmEwqhmHkr
	 fgjfqJtips7gSJp1OxBYUPljXrtpEw9ntElkrOf37zRvI8B7/1kiFNFLtXcyZx2CCW
	 fTwI3sf+9lLv+rrGsOj40w2c2paMDZfCXnCgMdn4WXJhNvOKtauVz1/E11X0l27JKS
	 DHbtfauSLsQLRdqk21t7MKO/halXwSf2dz5PWHXVkFM/75giHmiWSD3N9A3J4YAHe4
	 WsEm4KjkZHvaVVSo+JCGLVRjgtul/IOkunYchzceAwwULy/sjg1MXCLNIB9t/+fpMo
	 RqsA3Zcb+Hu3w==
Date: Thu, 20 Feb 2025 17:08:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
	johan.korsnes@remarkable.no, kristian.krohn@remarkable.no,
	Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Message-ID: <20250220-oversweet-dominoes-1661eca0c96c@spud>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
 <AS4PR04MB96921164DAA8A63B2C0841AAE7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <0e5f23a9-b1d7-4d8c-bb05-83f7a15a7285@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZONTg+LTYUZHcXVT"
Content-Disposition: inline
In-Reply-To: <0e5f23a9-b1d7-4d8c-bb05-83f7a15a7285@molgen.mpg.de>


--ZONTg+LTYUZHcXVT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:11:41PM +0100, Paul Menzel wrote:
> Dear Neeraj,
>=20
>=20
> Thank you for your prompt reply.
>=20
> Am 20.02.25 um 12:59 schrieb Neeraj Sanjay Kale:
>=20
> > > Am 20.02.25 um 12:41 schrieb Neeraj Sanjay Kale:
> > > > Allow user to set custom BD address for NXP chipsets.
> > > >=20
> > > > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > ---
> > > > v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> > > > v3: Drop local-bd-address: true (Krzysztof)
> > > > ---
> > > >    .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 =
+++++-
> > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git
> > > a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > > b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > > > index 0a2d7baf5db3..a84c1c21b024 100644
> > > > --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-b=
t.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-b=
t.yaml
> > > > @@ -17,6 +17,9 @@ description:
> > > >    maintainers:
> > > >      - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > > >=20
> > > > +allOf:
> > > > +  - $ref: bluetooth-controller.yaml#
> > > > +
> > > >    properties:
> > > >      compatible:
> > > >        enum:
> > > > @@ -43,7 +46,7 @@ properties:
> > > >    required:
> > > >      - compatible
> > > >=20
> > > > -additionalProperties: false
> > > > +unevaluatedProperties: false
> > >=20
> > > How is this diff related to the change mentioned in the commit messag=
e?
> >=20
> > This is based on review comment from Krzysztof in V1 DT patch.
> > allOf ref will import all properties defined in bluetooth-controller.ya=
ml, including local-bd-address:
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/net/bluetooth/bluetooth-controller.yaml#L18
>=20
> Thank you. I=E2=80=99d include this in the commit message, but my comment=
 was about
> the replacement of `additionalProperties` by `unevaluatedProperties`.

The change is needed to permit the property defined in
bluetooth-controller.yaml to be used.

--ZONTg+LTYUZHcXVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7dhfwAKCRB4tDGHoIJi
0qowAQDJqiC9gO011LY1RwVtMuwshi6ln8BiwMUgXiIZWRVH0wD+Mq9pmPDdKqn4
BOQOd7lVprKNQNq5Hn83ESn4eWMmzAk=
=FRXl
-----END PGP SIGNATURE-----

--ZONTg+LTYUZHcXVT--
