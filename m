Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71652FF17A
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933434; cv=none; b=Ay+44sVsYb77u0ODGrUWZAhFn5RuXNQNKjn68La5G2fboRUK55K/3VE/rm3E1IS0cyLlOv796JL/VJkWN7gUg4DUMBfyT65AiVgNPz8P2T8q/ZK8R58xhiaBF6ANmlRt753aqXTpnfWuDC+XkeycDGJzWiTthVCoOi0514MTe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933434; c=relaxed/simple;
	bh=kARumPxqfmMMWgp1NvnsY+8lw/OMkVWPKeLFtKSIlME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIilW2HGcbFcEuUhOfaG9zJ1etuUqh7hkPv31S8Boly560ON5dicYUsYbDA7q1WPPUuZSXlYBddW80po8NfDVzZzqye6mPZIuvSRG/bRttA/oyxWxL9MsvDPFYy51CeFzXyxoQ7aFzTPMdepcq5XwnPoV5zYgpFLKTkX65Leu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsm1gepW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsm1gepW"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60528734so27430477b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757933430; x=1758538230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3UAx19vK1YiNrAi97n0gU/rRiRg+M8i65mS2Lnx+jM=;
        b=dsm1gepW+64GUvS7kMWqaTSMnvOb4DE2XTTvWEeHN+RE/+11IMxt7/VT5nrAsrozPj
         LjW2VVhrxJupJV9qXK3qo8acFznWW8EUfnwnoI4vzGcKbj1UMmf+bhA1qOvMvaSEpSri
         JxWMtmdA/Sij1xAwa/AkWOoJWA5FL9LcqfNjqBUys25YDzn55KJIvJEGu+5RMQH+vPpr
         P8UCDM4suEIwAfOvYk3SwbegH35M/X9YI1gUIk0XqsFMHy+ZES0t8yI4pLpuClLxwNQX
         aI3en3/nuAnC9ZoXdtEoEmEg9DHc2ZK9SllMJGfkcANMbMEBs5t6ih8A2jNMaQ6iEEy7
         zv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933430; x=1758538230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3UAx19vK1YiNrAi97n0gU/rRiRg+M8i65mS2Lnx+jM=;
        b=CSlq5mbpLfvdWhJrTqLq7ZpbZS5fius5Bt3GEucBsYD86Hn4H1O4XtscwqqCdOeKvc
         bq1p6TMLkk00Ixx2Lu5m1VHRZVsLrVoxVPbLyrHG1L2RWe+3w0VGeQKSEXdHGn3V6PWU
         hxxSuUbOTn6Dm5l3nD1awwmxjwljj/JCq2y7pfQ6JpuBAf/pXDTzaClq+RhTk5/gGIQT
         fFN51CspckkyqIK0/YQhyQ6/6OIxVhqpDRCKfRbSRmZkDVu3rwdnBX6p3CV6CRpsf8ZA
         64fOZBDFj4hrHf4LrKrMbWW1DZsAajfdjPVM4Nx9W6NoI//6Auzyghg5vvQPDNu5V77v
         2FRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42pXz2kr/vxbj8LfNuaZsG8OnqVCscjAUjXl6FCRhaKLz76rSyt+yMc5c+PII8TMVCA+KAhVMe6pukcmIhdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCTZh4ua+Ju6nGxS7BdgCBtdw23MmTKYn+pTN32RML6rbOXZl
	GQN9d9qEYLeCiSnYLuDUk4lVIAcrbQK+dWHvjD+gbVhZ3wfIUEqJkAgG5EHyL6JuTAJC4D/ZTCH
	Ts9H5CHLhRnRCz3SoYxNbEQTTA0xGqtUZ7PuKvE+NAQ==
X-Gm-Gg: ASbGncvFSwrM8vglfkWUfk4Jb/cLjSYvTIEqA0dPPbYJ+CeFezYYi7XRC2ShlyDDRYa
	e9wJi+ZQNyrVDnsp54JYUHXGsUXws8KAsTiQEnUyyuIA4SeJtG+VPSVoixrMbU6i5MjapD7++rN
	68WVaoDw9RRs/BlG2CJp3oLBIklVYPcMSVtorw/XYGQITkzm7PD71XpmdeF+ZM8qOt6JSsqdX/e
	Bysp/+5zb93yG0dgMw=
X-Google-Smtp-Source: AGHT+IGDEYgOKM3gJ8Zzlityz/syLNE9FRvDAqAmupyu9aSeveyvR7FHQhtEilEP6qYlMPKL0ImuzwqqE0dGUhFDiNI=
X-Received: by 2002:a05:690c:3706:b0:722:7d35:e0c2 with SMTP id
 00721157ae682-730626d2dd2mr106799857b3.2.1757933429679; Mon, 15 Sep 2025
 03:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-3-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-3-507ba4c4b98e@jannau.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Sep 2025 12:49:53 +0200
X-Gm-Features: Ac12FXxZCAZGblY8VwFHa1GJ1rGV08p3Fv5KI-OAzvQkX2G4ZDMKiAukPP3wanY
Message-ID: <CAPDyKFr9dAvP7U3dZ_LFw8YxcvJ6n95OKKLYpntUarqdfUqjWQ@mail.gmail.com>
Subject: Re: [PATCH 03/37] pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 16:01, Janne Grunau <j@jannau.net> wrote:
>
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pmgr-pwrstate" anymore [1]. Use
> "apple,t8103-pmgr-pwrstate" as base compatible as it is the SoC the
> driver and bindings were written for.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/apple/pmgr-pwrstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
> index 9467235110f4654e00ab96c25e160e125ef0f3e5..82c33cf727a825d2536644d2fe09c0282acd1ef8 100644
> --- a/drivers/pmdomain/apple/pmgr-pwrstate.c
> +++ b/drivers/pmdomain/apple/pmgr-pwrstate.c
> @@ -306,6 +306,7 @@ static int apple_pmgr_ps_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id apple_pmgr_ps_of_match[] = {
> +       { .compatible = "apple,t8103-pmgr-pwrstate" },
>         { .compatible = "apple,pmgr-pwrstate" },
>         {}
>  };
>
> --
> 2.51.0
>
