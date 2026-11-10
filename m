Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337006;
	b=xBYFzjWtjlIowGn7A60RlSbwa4FEhnN5SDXlf4Zl/0ngN0WVCrB8QrRGE1R77x3Z6L9H
	 noZO5jWBFNMEecypXNnJ3nU6AkTDsO51AhsoQxkQ7Z4Xd5w7Ow2Xz9ITiiGhHDbevMT1E
	 yu+GTSRTzAYSWe06JK6E3kEpDoteBOHMVUqqPAUUdupUgmigaxuWxkJvCUtnri+bBekJP
	 MxFLw+k4UNzZklJOk9JSplpb9bk2EK8obtb3qaQb8TXcRT+Z8bevfydEkxM342RGSHbCN
	 X+yEOcN4pR+AnfXuexdRkwYJeZKesjscmDVUzITRnMDDPCUi6NnnjX32zPfmA3HCheA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337006;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u8imW74Qi5u4rYZaASt9BvkUnwV5h/SQzuQOySm1baM=;
	b=c0sbnADESdO6kOKFJBEcDs85cEGph5y78L3mvSgyGxcWAxnB89qTTOAAYK77GVtxcpjv
	 A5ExI7djvFmrTc/ckfk34IZhtNzq1lhymK+Ui95N5ft1LdBCI4XJBznh9Jkfy4odsxCxe
	 LfvqmwL+9R7bBcpV0a1r7vwXYivDKZIUTjdMFQ5Vn2ZTjUZWqjf2PJnwnQuooykdhjAnZ
	 jyQZo2Etute/1Hn/nf1YB3De0BRl16bLnOteElPLAqazZy1nASTHh9GWzhzoCT0nZ2Nx9
	 UwPNLGlA6AIaJ90InUNiCggWWcXJt5+90T/X8LMBPHkZ4pBSTLH8gCitWkuXK6b2QtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrjfhPuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67747606A330;
	Tue, 10 Nov 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrjfhPuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA591F0089F;
	Tue, 10 Nov 2026 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337006;
	bh=u8imW74Qi5u4rYZaASt9BvkUnwV5h/SQzuQOySm1baM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QrjfhPuyjrn758SshpFQS7FRi6KIfKbRgyl+CtMhrvVvZjUmlpcp6iWAN/kkbzjOA
	 fNFWbEyH6+KMFB//wyuZPXioASmVeGISz6wXCAfnqmeKgWv3NntFCBjVvNp7B/4jS7
	 OiI33lv7t0PXZtKvuhfgHDcw7h65oJjCiD9eS+SgFHLZIUGDIZ5xe1XA6WDiAALDvI
	 Pze3mQX2QzMQ1ohGkXp5QaJMOP+oFQOkZLTtr/nd9oIDyTv9WIPV4HAnkGedbmrW5P
	 oz626tq/cWbFeP6dzaJPS06hPO78cnQPDN5YjrRJCuSNDtuqimDwlsforrvFKYkLHQ
	 S/7QH8nQ8c3oA==
Date: Tue, 10 Nov 2026 18:56:40 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Mah=E9?= <frederic.mahe@cirad.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
Message-ID: <20261110-attire-jump-6178a8647787@spud>
References: <20261110074607.363918-1-frederic.mahe@cirad.fr>
 <20261110074607.363918-2-frederic.mahe@cirad.fr>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kBGoRM1PY2im1kOY"
Content-Disposition: inline
In-Reply-To: <20261110074607.363918-2-frederic.mahe@cirad.fr>

--kBGoRM1PY2im1kOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kBGoRM1PY2im1kOY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNo6AAKCRB4tDGHoIJi
0nnSAQCFIoM4GYZglD/WwQpxDX+5sCXjmakE+bkUW0bDG1pyfgEAliCFskf+23B2
YsTLdzd0nPu3HBNEcI+w+XJrYB3tOQU=
=fxea
-----END PGP SIGNATURE-----

--kBGoRM1PY2im1kOY--
