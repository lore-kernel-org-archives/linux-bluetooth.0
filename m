Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3618FDBE
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852753; cv=pass; b=dypzk6AiVekAtOuF+tm7sH5Ydw1r6Ims3MJjgFkFwVOtlF+q6k1ZDTI9W3Wpi4piiTjF2iJvI9zRtP/ras2z+r3rbFhXPJZUPEbCmDkBYof5ZzEZzzJlycgcgTWlJAgrQnbZDqSKgZkSc1R/aC783D6LpzHH5pQwlaa3SfnekSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852753; c=relaxed/simple;
	bh=gg6EEWL1wsmVRXBl55TcEhNDiGUYMpBTtL91XSq64PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax+esYlJuNVsFSVIQEj9c/J/3Q4NOvezETjQN/4BPOFLXYSEo5OyuKVK+MSPkWC0vDd1VGBjkAUaWcqz9qvomWdn+mWr0Jywf++0H3j7SZG4wcxNC3lXY0/9123iqyrgfcd3Wbzg/MYTKXzEU0b4lPQHi6aQxfKG3l4N1d6EXHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBvHQ5tP; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBvHQ5tP"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e614b3dbcso4254186e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 05:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771852749; cv=none;
        d=google.com; s=arc-20240605;
        b=WzNR+SCZPnMifLMTykjnyRqu3bqo04Jm8RHuQcgXpivS8TihFFei5KSHvLQCfFNZ7O
         //hye9DIa71chln906C5cs8Kqo8EpNNhTh+JWX+S8B+DsYH0hXMuhYrX9Ar06E3MgbFW
         VGBEQituDNc19V5o2I40jImW5GrJUEp679dbVyd76Fq0VTdsH1HJ/UAXSj6K48/NX8pk
         Myck0IJY1n1IqbLejcdXZnH0PNcWLMQPzYngjTN4bjVNIllMdVJPBgOiFJTCHgqEILXZ
         OdAJgFe/xx8YDiVHF2D0p9mGW4T1Ff+qScH37e85uaAWfHLFElxuCii99cReKGvOvYvT
         NXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        fh=bOPPpIIxt/DyfIoYhG8SkA32oD5oKO4p3znYAkZrV6c=;
        b=jRiXb3VQh6SHQ7Qh2Jx3y4g+6yrAtzzngGyw0Gx+5ZJGiEQtsyrGqrceqXy9+RG1K0
         uEkzhZtUc4hiIlSZtPESILnab4OB2btGLD5YOm5ZqzuIlLjERMiO0ovYtdVGt1qnuO6P
         id1ufhtsgrLZlPBloMhRkli3kLrVI/oC/btkbO5twXEr67gXlZSe9yyFzUBneLEbp6Fc
         zLs2IvSMimiSo2T/pFCljjw4Tli4P/YfK1Vx2LgIbtOKK3sP4JiljfertUAYIn8vmDpd
         OW2u45ZGxeALbYTmgVSAHS7+Jb8KmMFXzF4xua7ccm7dj0LlfJZSwgbFUkJDmRFgII19
         TYLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771852749; x=1772457549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        b=DBvHQ5tPBiwhVgVW2qHFSvG4oHzeJuhKr4h49FS8Pkf5ncLtO5lBl4D7AHimZ/nPZl
         wk3xUCGXFjJBtsfFmS9pu6VV1wbthkMgZX3xKOZFhiVbk6dpRqBhXJ7mR9weeGK3MMnd
         yImUv5e1UVpQ4qAW5cUDDmCPstFCqqoqedjknaMcewSGVDmhRBPgcUfddfoiH4bPjmcj
         TozJ6nDyWLUZjY6rlBw7OORqV7ttQQTXglz6/B1t7adLZ106C+FF4XJO87L1mKmMxDIc
         ylD4cxJcWOBQiVsq24tbavKDmIqn8UKH5fbgMIrSZsBoohgqPmGMDqa+FYz6wJHGqVkk
         9o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852749; x=1772457549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        b=K6MhNW4hjfTXCssjyP2G/rrxeh0SPjexM9meUrRbkrlSyQ1yqA0l2jQGJwBhmmaFHg
         eZZwCuVIFajyIi+BTMFpr8ELbhrcRfpGwxcXHQkESYIEL0ZnsffltX68vWYY+EfWIYSX
         RzojNMpicd6RubMzOW0kXIgYsIxrB+JLAi8f6ekMjOdg2NiZtZKAphCmM91IPfXHfvwD
         lDvTTkjCNXsfprpgL9csRo1HMFZndK7LMQ4M8bBAA51FBcosnMdL6wCV1/e38Oy87Rbv
         9miHj7euxRE4geK9LJyNKmdQow2NmUyUMuDd8e/9PrAmDuxm2K66owJMN5AuYwc8A206
         gmeg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6UKaHVzyhdmeY/+hwB2qyrksEVPe1od6NMbActJ6LvNO82k9xCS3Csvl3nAk6hHEfsF469S5R5V+0Fl8u/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVB4Bul4hEyNj0bQY0jgizGAaWvndzwq0+yO+m5nL+SXPO6ns
	YdFuio8Ivf1QnRcQKJJC4gzeC4KLKAznFepQBHVrM5xgHzyCFP36eooSGbkzu13uqB+3FuoD6cE
	/dQ9VyOSm6bOAmPWsZm/7DhbnKknLt2ZTShjWlbnXug==
X-Gm-Gg: AZuq6aLGb+QG8qP9LUq17T3oeEkme3AD3FMTgxnOm8xnGALGt3DKoaav6WeMpOzpjHd
	BX/LRU6zFeOvLrE4cuac4aAxEFGu9mANqgINxQLlHQB1dsQ2kXvu6OPKnoxpOb/4Uj0FTazccjY
	8CkDTmsumFgGhIklDPPal+MT1PIndg9rNZUQnqoOA+ABX+kLd/A+vnAn1AItityUR9GuWrF9KRR
	4V9OBRvR1NffmZDJ+0WhcD5/tFb6u14TqSz5VrPMOs89Mxyiqpzw/f+yxV5tiGLwpOYhql7wvDK
	l/W6VQOc
X-Received: by 2002:ac2:4bc1:0:b0:59d:e9df:6dcd with SMTP id
 2adb3069b0e04-5a0ed87df97mr2593500e87.15.1771852749330; Mon, 23 Feb 2026
 05:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219231624.8226-1-sean.wang@kernel.org>
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 14:18:33 +0100
X-Gm-Features: AaiRm53UIVVBouS8ori9IKqoVA3ZwCaDsyl3whmD_0t9aHnCuwJJwIQxLct_CEw
Message-ID: <CAPDyKFoiqit-_PWQ3SitGD2YV=J3ZcD97T4p-+MwYXjLVe6fdA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 at 00:16, Sean Wang <sean.wang@kernel.org> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

This should go along with the other patches, so I am not picking this
via my mmc tree.

With the sorting (pointed out by other reviewers) fixed, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..97cc834fb3d5 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -112,6 +112,7 @@
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7663         0x7663
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7668         0x7668
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7961         0x7961
> +#define SDIO_DEVICE_ID_MEDIATEK_MT7902         0x790a
>
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
> --
> 2.43.0
>
