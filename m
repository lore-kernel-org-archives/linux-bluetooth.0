Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604836;
	b=HwXNjeYC2OwHRlyDz98mOMeyLdyOhnuKEGye7TLFWKkvpEe8FQnEk8672OyQCSSr1AST
	 GANBvKS6q0FjiGeJJPGCv4oeehEzH8DyuQxuwz4znOosW8GH+zDwCfZ3fGlv0SldBgXZs
	 rylYuYfUs0CNP1Z/Saf2155sD9HF1J9gSyjswDk3hNFXf2FuPVFKUtOz6BvcLbojc8LA0
	 GlGecMIGBafYKsE/0e2xAZtgFsKKYmieAbjSl9Lvox08j0WNLaAK4FA6zTO/anUiZo8yE
	 dL5WeDr2gs7RmLy48JTk4eSiyQpgjwQ/0kdRAF7W0OFlOZp9+UZqMzPR7PxyMRG/rHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604836;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=bdyeu1KAZftG3Ei0a1/Us7sttFz84nwrVKS2qIKX05A=;
	b=xtbte8ZiS3F0ulRw3ONdfyDaQROHuCiG6+Hp4uiYXiPm45UKJNQ0Z0O0k7KVYU9XcFGa
	 aLNmulL2erOdYD8xpPvwu8jOyl1mUxH0rmyaP825PBqLCM8MOjJ6694kvYS8Rk2hj+1fB
	 Xgzo7zmHtBfdtogsfoBpEbMP6qebyZbZ6RMmnc8WI5ek1l7TZi+bAdZKR4v0LI/+Yj79B
	 XRvySD55G/D+ryi0Xijh7gu5hNjtpmMkjvAx/691ec7PgMsovq6Pj0yAFPZeqUwpG3t5N
	 hzCymNlctkyOYA9+iFr6sx7+35JZHsEAW1XHKPXA/o99lgU6pfRooH/d9QbVETq6UUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.194
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC6606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFC6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78AB63E97E;
	Wed, 25 Nov 2026 11:07:14 +0000 (UTC)
Message-ID: <252c7fc4b8ccecb92d9dc3e2cd22528dbd3cf726.camel@hadess.net>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
From: Bastien Nocera <hadess@hadess.net>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 12:07:14 +0100
In-Reply-To: <20261125104619.3325760-1-zijun.hu@oss.qualcomm.com>
References: <80cec33b165dc54b1ed6ced34a6016a65ce7d6ad.camel@hadess.net>
	 <20261125104619.3325760-1-zijun.hu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGPktDdhKzemux27Q7jwA6KWbMzKvifJsfkf0y9Oi307S2Ei6AzlBIrt6gt4xIuZjM/ZSvbh5ykZEsX7km/wJEq7T3T8wAD8SMBjW2IQo7uk+dEC7wKK2/G58nxhd4MxGaCoWt3g3btb+8kQ2LUQkQFTGoDTgUGsBSoEVYWvILakIvZUm9fGiCXEHrm0cNn2zrkVk/UQBmtAinHRxhlPtI2mfhKvfXvs5dYaDIJvI1ZBn3+foyGHo5E2b6YoBo+JhX+JV0UUEermOg8S0LIcRFOvH+1q1zzp4thvyq5D4g8I977uv4SD7XG2oQ8YxdQus6QlqcKs648USVH1xLq7SWlVMNwAE4vz6xZGAnx57xEzdCoJDGprexLsaa64UMrtgNEOLeAeq4gKsxU3GoD8MyY0zn+QIHHUQnMT1KpaslutTFA90pJ7aLt2z7pB/rVFZn6wpvdPRvFLhHKgfCYWfW9ulm/xUv7GRrinWKnEH3hQMGdflLaCAC/FQlvuZwXmKwDDbFvxyOq8nKFjTp9+7lVeyZXLEOL2lAuWq7hwxR9ilnBbzy7i4AvRISvkeLhwJN8S/UDtxkl3TchdnQIUE1CuA8JvgXzpHyoKUMMs79SD5DEwP3IB7YYzKpQ5koEsnMUtjdWkvPiJ6GopTJum0m1cBAefpmRwLvmLG7qZ2asOg

On Wed, 2026-11-25 at 02:46 -0800, Zijun Hu wrote:
> On Wed, 2026-11-25 at 10:04 +0100, Bastien Nocera wrote:
> > Is there anything actually stopping running User Mode Linux on
> > aarch64
> > systems?
>=20
> No, nothing stops it as far as I know. There is no such requirement
> on
> my side, so I did not look into it.

OK, then you'll want to fix the docs you modified.

> +    | x86: bzImage or User Mode Linux binary
> +    | arm64: Image

Cheers
