Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572937DEBB;
	Tue, 18 Aug 2026 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044682; cv=none; b=YIjte0aPaTs4yfvyDkiie1L5cEST6S6j255P56wVXs5+2rXkOQQ1UIM3NHFb1cpRTsyhn2NpIGuOzvpmURkXf+FUUuFudCtvUxHJ17m2NECXmIGBP33oAzkG8G4RA5sBz1TjliNfmc21b80sGYnkG6qSm/9IM6hz0oX90xF+n40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044682; c=relaxed/simple;
	bh=taY9E+aKyNL+EYeknd95TSMIK4rpw8RzGN9ApZyBzic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4dMGROh/AVR4ddd0b2Oq4t8B3aOvEVfcqg5M72pVDs1LOhm9OrzySvOoRuvDkbkvhJ5gF6DZ9edL9OLvo5B9uZi6w2HE+Pe+NdDp0SNMwaRFIrlqC1N1sF7G8Mzofnbw31Q8SloZSz7UVObtblI5xp5G/CYJ2f+QBRkjBfk99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLsArPTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLsArPTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007EE1F000E9;
	Tue, 18 Aug 2026 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044681;
	bh=qAXLSpgbdrDBTCRCtbvYzjxd1IdFbKne7Kfu6Ah3RC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLsArPTmcogYq+2KJST9IxGvFcEyGro/mm0I2RQ8g3+0zE76EL9Vm6h+abMzAvmuU
	 6akn00rEDXja9Kd5xtQkYIrtZIY/2pVGj2GHwSKPUKCSLOh9EZVwd8OmaSVgW7vjv2
	 x9dUKH9GqriXsqA2NnIvMma5z1z0MtvyuGX6GI9ZowY4Ld52atepzNabt9im1aV18y
	 bhKP10WIYMNmOyi5zKlaxgcu3ucAedfSc8fq2y/Lx1rZ69MFWFVod3S9Gy0XOPDD7e
	 2EHt2iTSKchGnN4gTszB/na7vDU+rTTdErx5ehmk/Y3/NUcSOqsAe7aAZ6bE7qz34S
	 W33YQXaeLRG6w==
Date: Tue, 18 Aug 2026 11:17:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linusw@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kaihsin <kaihsin.chung@synaptics.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: add BCM4384
Message-ID: <20260818-humble-shellfish-of-vigor-79a10d@quoll>
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
 <20260817092723.637956-2-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817092723.637956-2-kaihsin.chung@synaptics.com>

On Mon, Aug 17, 2026 at 05:27:22PM +0800, kaihsin wrote:
> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
> 
> Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>

Looks incomplete DCO, at least judging by email address.

> ---
>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>  1 file changed, 1 insertion(+)

Best regards,
Krzysztof

