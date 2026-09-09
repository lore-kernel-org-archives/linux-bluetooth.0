Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA445867DE
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986550; cv=pass; b=OWG3/IzmCXLfuqWlvl0cwSwF1d5HisBozKYgTXX/td8CU3ypZqJ6DTIl2iNReJygjgQJsdA6I2bfEB5JSq7JrmDJJSdWnOJy1iLvm25BcYYVxPUzJ/m71VqHSgJL9fMrTBkL71BoVldhx72ACHX/PQWPewVVh5Gfz+wqHm8Hs1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986550; c=relaxed/simple;
	bh=dfa7Q8dbxI96kvAtn8ple5MMEN1SKMhEfZltbZERr28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn4EbStJkK8dYTL+2t2xdEd1oskGxff3tOFuszsdYcxJRZiEl4AC6tasQ7AEYRg2NQtDBzhl5mWA4sKCuCSPlTuiOwghVb5mAJi0bgGF5RIW+KCyBbTPMOY2vDEivuSOfPp9C8iO27A9PsCgJLR8ULf27V41cD7zReKqogMb1ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=WOuS/jyr; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="WOuS/jyr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-86d43cdee51so81383657b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 13:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986529; cv=none;
        d=google.com; s=arc-20260327;
        b=shB87KZtAK8gBgK9qz16lay03lXF5X2xChKowGZsdbOO+PqmblozaraxF8ehrnjXB0
         nQ3OWDcpdxW+hRe20Hj3/i083P0vK3PiNJL+65pIT1yaJlHdr2uo2l8kHWF3DiSX5x5l
         hPVUeMX2UY39Ezt3rDHt91g4h+SvECxVvXElpVGyxe8xrJiL1BL/oHNPuu+X5fxUqjzp
         EyILbbReIfyNGLUDvMt0ohIp/dNijscDIq6lw0X/mhz1tBMn3dxjmEo11PtB+3/myf4O
         NhAXC51e1Uty4CNgvlFgQQfN92VwJZEeiZMxr70QvR/lkta+dqTYvSrPckYQISK6er2A
         OnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dfa7Q8dbxI96kvAtn8ple5MMEN1SKMhEfZltbZERr28=;
        fh=E1Z79MlpcxsOhsl5ZdiRRAvpoRvJ7yrNR+SNAwfUVxc=;
        b=TaRfD1/Yv/oD1CnJYxOOBqT1mJ2gkS+7uLp41Ba26/kgVdelzBv5ic9JMGE0FxFD/s
         +G/aXqbqL1zaDGPrNILo2233zZaw+RR5o4d3K6nHd+jIVqKkF8fXZNYXeCLYRkkn9rhv
         Sm1Qvqz8besbWMYU0usTZdcP7VtvnRFNAMuBze1VtpJrs5oq/u8ryboC8mp89zEoq7M4
         CoUut0fdepZL3w3OgZXamtAd4nOHj46F5eThZMXQ2cHSRoyk21L4h2EhSr9KKzbWodVW
         LliZuWECz7gK/90nOzkBuLftbMuJZHXlFN6bByDR8dvf0KWRH+yxfNZgmmROftmw9PzA
         F1TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1788986529; x=1789591329; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfa7Q8dbxI96kvAtn8ple5MMEN1SKMhEfZltbZERr28=;
        b=WOuS/jyrvbrNxupQuFu0ylEzjjHsT+mJKuCEtRAniyXjFI6tqRPlaiKadzGf5oGxNz
         hk5akwTqGbdEuo+hWz/g1WFhdvQIQrm0gIbIv/2xHOz7EgEryQqmoA/qc14i0brouTGQ
         hGuf/0vh54mZEAPZHq540omDkPhdpZtNlS/bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986529; x=1789591329;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dfa7Q8dbxI96kvAtn8ple5MMEN1SKMhEfZltbZERr28=;
        b=WGUNsC/pBrdIrkvDdX5FyN2qhUe0VSCTZ7SNNjJPrdn4ACy8nRf3ZDGYgMYwsF6lV5
         LsSujvg+oiE+voWErkeke4R4DHUxeGpx+RgL9gudJUNAfvGEvTAtud+WSZFHi8TlSjLJ
         lmpIORETlmplIKNQiwUb9mhSp7x8g6tXBL4HX2Z8x0s0cf6E6bWpdz94PtGSzhFoje8Q
         oqlaVSUIvhyLh/923XQ7YvTv//CgJ1tRHWzRZahKk4qq3UTiBR0fzCPTxyfAi2UH4mTu
         +CMyEFTxFNfQRicOHuF3qPZS6nmzbL5INCFA+/RnEM5Innbr7vAhswLjoVkezpZ5eH1a
         XVow==
X-Gm-Message-State: AFuF++m/5LFOYjUZTJo3o1Gfi+5hy34mhmm4b2P8RmuQVouNmeNQzT5R
	B2oHFoH8D5Vhdjdg9U9z9QRbrLB/erAy+G0RYlbKaHZYPM6CSGE3nWZFx0Zgtl+OUheCDsYc4ci
	q/shZM5+0j6IdhJokaXQy01U7I4aBgxnl5RovCv2UWBsIEGx05uepNssaFw==
X-Gm-Gg: AYBFou0oFHaCAG8wv0rrsGkQghIKq5blWpmLjE97ezINOZi2s8mZMopcq30CAEQXCgu
	enwB2GMP2cBDCKMHCTaItCmx5iokzlszN4gOtnu8QaiwkX9PB/ciWceV2WbhyM1K7WknXGHW16w
	K6W4DQZi8ao0s7o13zN0WV9K4xmc6sS3cfatbu4agbM4Y+bOqdk0s/6EMYChXqyT+xhqHbJAkaY
	m0c8BN4JS8axkI0fFyuLia7c69jXcEAwvgmk0fE6Gio8L2LJv76XChXBmmkC6w80lzUzjPT3wKE
	FSydUHW5vbqR6IHabF0/EBmMI5YXLcKlE+XP8Oazz4VK9CQuHcn48XGci42ENwHSixBaaS7xP5h
	KQ4mts1nVmIb+G+3/yFHGUhtjgiatE9C3TYYCHUhF5ntxHputw1gp42aQtg5gnhu6zMIfmwEcaw
	E77gacjaCsyRVp72Rk2CqWW6HASRtc+Dg=
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c3b with SMTP id
 00721157ae682-8735bb26fbdmr99000937b3.66.1788986529195; Wed, 09 Sep 2026
 13:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787327795.git.m.kurz@irregular.at> <CAO=2mx7zXHmahddsPMaDAZ=2zOdonYOE2nvJB__S6ORU_by3-A@mail.gmail.com>
 <CABBYNZLBvSo+gM5tjRL052tuhj+Ki+Zb7KucAWqs=2nszreoAA@mail.gmail.com> <CAO=2mx6PV0B5i289kEz24mqhvdm2rhUttPqVEJRHYxkYgK5m8g@mail.gmail.com>
In-Reply-To: <CAO=2mx6PV0B5i289kEz24mqhvdm2rhUttPqVEJRHYxkYgK5m8g@mail.gmail.com>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Wed, 9 Sep 2026 22:41:58 +0200
X-Gm-Features: AcwNN1Xzk893f5Ewl4Y0JtBsanRhM4mMA19F2tylf293_QzKOhHNHiXsrUmI0kI
Message-ID: <CAO=2mx5Kgo7EdiOX3asZez_faf9K6U7Apqn1tCvHnYDmEe7o_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair
 Message Stream
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz, hi Bastien,

A short update on the downstream support: the UPower implementation is
now available for review as a Draft MR:

https://gitlab.freedesktop.org/upower/upower/-/merge_requests/344

It consumes the proposed component Battery1 API, independently of whether
the component data comes from a built-in profile or an external battery
provider. It remains Draft while the BlueZ API is under review, and
retains support for ordinary single-battery reporting from unmodified
BlueZ.

I also retested the current branches today with real Pixel Buds Pro,
checking BlueZ and UPower readings alongside KDE Plasma's battery and
Bluetooth widgets. This covered a real case percentage, its transition
to Unknown, earbud charging-state changes, remote disconnect cleanup,
and reconnect at the same object paths without duplicate entries.

The MR includes integration tests and details of the compatibility
behavior and hardware validation. Hopefully this provides useful
downstream context for reviewing the generic component-battery API
while the placement of the Fast Pair implementation is still discussed.

Regards,
Matthias
