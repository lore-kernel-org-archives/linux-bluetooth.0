Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414696;
	b=JdKWVRh2DrU/nF+tkcu64ryzD7XLafnTpp9UybkkDKvcqHSuWTTNUcnXu89S6YVQLpW+
	 50vD8OaSaGDWRF40gwJe5tcs5BaVVE+Z3vUNpSe3vfpMO/sKOSD1vUUnxv4s1WTENuDab
	 GKsJXFp6cuUKs5zFaSUWO40TsdMQIP0D/MZUZxgBWFmja1liHHl2d59PSVB7H+v3ZcReE
	 zo2M13aNVwMD7yVSodzigOUBy0GC3bz+dVVnaQXGpJUkRVXlAconwdtIwId9qPlEoVITI
	 GpKmP0S1/Nyx6/mrQbvD6+dnifV0YfinynOQMiWrH1EqwPae8eVXFklbEk0SrRNWSKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414696;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wPo6XzhRTx3j5aIDGsDw0wc3PGsWDGR9H56Krm0IMPQ=;
	b=ZIVRxvuaRPMTBKnSVJGfW4l6T53axoeJSf19x5HOBlaBZcB8fXRsI1bkPeTqQs+3T8LB
	 026QqH5bFnkz/hiH0CqQr+XsX62HN8pFcYtoNKxOoOpXfBQPrTwPbdotsbx7CE96p7PR9
	 DGu11JOLLbfBouzAHPLyD3UzAyixnvW9L8Hjl1VbJWBy0awvesZ8mvTXNFWaBDLsL+t3e
	 G9HsaWBvvt1zZnvfIZZv7AP7tRu200Q009RJ4QJdrb5+ZEajRhuFHprEmggwKb6BQI2t0
	 4PXoBXCLK/M7HU7p8qtqPxVPrB1Hs7mRcb7/UMynpcA4cMzNhXyXet5YSz16L5b9pVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZe2Wat5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DB606A332;
	Wed, 11 Nov 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZe2Wat5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE801F00A05;
	Wed, 11 Nov 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414696;
	bh=wPo6XzhRTx3j5aIDGsDw0wc3PGsWDGR9H56Krm0IMPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JZe2Wat5q3aPIbmoHdO4tpoPCfvK4dKbzi/i8sep1PyLkkoGGeHNHSj+2N+W0nzVT
	 TDl5H5z4slZ+pMdOJCpM/Asy52zCApiw+zr4X5F16ID3eRM2WU0UTqfeUHeQT81LZU
	 NSUaXTJ7lctEIbGjwwLrE8BLvIrE0d2EXYdChU1hBX9LKM6ZiWBBkAEjwsczBGVbVH
	 htyrr1RjRiIkopgDgnjZOQauWon4GjGpy6LVGCA47m+Hu4bZHzKCtPhfkXYWhsF0h1
	 1QmnP3DhgbFgnjW8lIwga8WkARbYnWKaJg2BJV8WgolDm7cd0biyIgAh68Bdx5eLNw
	 9tJkyRebw7gfw==
Message-ID: <01fedef8-9c96-44ac-89d7-a7efdb1cc879@kernel.org>
Date: Wed, 11 Nov 2026 17:31:33 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm4377: keep ASPM off only while
 the firmware boots
To: Andre Eikmeyer <dev@deq.rocks>, marcel@holtmann.org, luiz.dentz@gmail.com
Cc: j@jannau.net, neal@gompa.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261111120248.21062-1-dev@deq.rocks>
 <20261111120248.21062-4-dev@deq.rocks>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20261111120248.21062-4-dev@deq.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/26 13:02, Andre Eikmeyer wrote:
> The BCM4377 needs ASPM disabled because of a hardware erratum, and the
> driver disables it on the whole link for as long as the device is bound.
> On the MacBookAir9,1 this keeps the link to the Wi-Fi and Bluetooth chip
> in L0, and the package does not go deeper than PC3.
>
> Disable ASPM only in this function's Link Control register before the
> function level reset and the firmware boot, and restore the saved value
> once the firmware runs. A non-ARI Multi-Function Device enables only the
> ASPM states enabled in all of its functions, so the link stays in L0
> until then.
>
> Tested on a MacBookAir9,1: with ASPM L1 enabled by the PCI core the link
> returns to L1 after probe and after the re-probe that follows ACPI S3,
> Bluetooth and Wi-Fi keep working, and the package reaches PC8 instead of
> PC3 at idle.
>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---

That quirk only applies to pre-M1 machines so you probably know better 
what's required:

Acked-by: Sven Peter <sven@kernel.org>



Sven
