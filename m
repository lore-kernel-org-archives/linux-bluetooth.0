Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982509;
	b=3aPrcIbyC1BqpIcwrao0roQGheql5qzNQP/am0KMrThTZLDpDZ0aoLiEEhINnK9buV7E
	 6s9JStcMp0ik5eJsbhwYzMy2naojYq/Wx5F885qnyR3AwNt+4twD2m/fGubMyFSPK2XNX
	 QDuUov6lzLaxEHs/NPwfGD8oqmLaTzRGKh7Bk+FiJcBtoHqPxGUcpDmkYSo4oOK9dx3LY
	 QYRCn2sIF70IDTX5nR4SkhseF5PDTcawvKqGS2j2D20vEnoJleDmrxRz1GNVCUvNUDwkj
	 fDKQUL4WClqUK9Iw34PRZghSlpremNFgRmCIF0O0VcDx07hBcE13Kj+/Ath/fYOhStQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3f2uOhpX7PbcT/0WiZRiFZhGB+wqgCccLfMeogp5CFU=;
	b=Zo5m+mVosbvn0FLbTw74Y9EMK15n7BYFjwyu3sn10AeaDWvNk+/5qY5MTpzv+oxks2He
	 suXtaQprrMOB0LKD5I+L4OmrWTbYM3AlTb6p4mQUNdSMDKTd8USLiFAbz7MrgZKx7gn5n
	 76lGdE7X3yaTs+SG6IjYyPqG+8puj6I1GBv5jemU5NqLIpsXkPP5ivizvuI8LI/pVXEca
	 zja5E7n4jGJW4xg8JV+EC2H0QxMiHuu0AFBL2jbmlfeA3YsCPIeYokUmFMVuNFP+G5idd
	 rMZGnPvebsaaaev0O38R6vf3doI+xflVkBVPVCBf+7lal5iZxlo+WN+jXvdpF2nrW+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbBTspXU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD965606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 16:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD965606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbBTspXU
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0d126f631so7224597b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 08:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982508; cv=none;
        d=google.com; s=arc-20260327;
        b=bvEJQHaJ0S6LzxlH6IwW5dzgNS6gbTN/5yeir+Pb+jSjANk9wCWFTvUFmRbKX1mwaP
         oZLCJ5/OYcrMp3XapnZFrRiV8efI+QO1QApBCm417UI+PenVbMuHLeMiKLoFPZ4yY69W
         vgcL5qqq0XVCk0Emcb928mcolExCBkd6v7aT4Lr5qFORFXsR0baiwMFsSPUvNV0JbxQ3
         pDqfh/OWM5QoP5tTci9faPcbfShFBbMXvkzci/p5LIDr+XliA/Cr15KLqnsDfLLCOz6t
         q8vPiVahIV9SZEiCvV1u6cv8y+AuFI2DeXRaUNLmCuYJy9SvlTSdK8sNFTko7FjU54yF
         OD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3f2uOhpX7PbcT/0WiZRiFZhGB+wqgCccLfMeogp5CFU=;
        fh=LUWgbrUuhMtahyXO6QT454ErJE9yEFx36d0SI3GxXhQ=;
        b=ZyD1oOlRqB6mj4/1TJOLHZNiw+jmRk5jyaffTbI8Mw2EO1uX3soh1Oz9IHqOO+hRiK
         PO89VWWBz4Oy9rFwUo59t7F5tWt5qDNdsKhUvY5MYQeSuLMmfxo3RsjijZHZdM2hRhPE
         GtD6Tb0m0cjHDNGxHKwiEAg2a0XceG/RxXDVfaQuGfAl6GKbrfk5RWftphxAA/YpNegT
         uvdaepI+wNCEMueA/wupYK72ZGUxUfRQonqRH4gsd9XGVu2PZ7ZT7qn0HSlblZQWl7WU
         OYWrmFYp+tQBuQFcJ2O5wx1Z82my+no5PjFrHZVGVuvPn3s3kAhmRdJJUPAQu6+3u+fx
         Rj3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982508; x=1794587308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3f2uOhpX7PbcT/0WiZRiFZhGB+wqgCccLfMeogp5CFU=;
        b=mbBTspXU9A2XKSOuDBA8F3P7oc5HEqWYObSyZVcoDAM+gN2sPIwvrTWyoX7JCK0jsW
         ARlA+qG8KZ8yMMLLgycM9irbKqHF0Jyj0CYjnZLXb8a4GdpCwBM2A5Dm3oixPrCysbMW
         hPFl9j86zW8E8ErZJTs27oLbk1zGBBeBfYwqOyivKJvpqF95wxK8jp+2QJp6VEPGkTWJ
         llkJp+WXOTOyFE6Urq3U0+vCUuIOpO7iCWQBBfMfnoK4QKX+d9RGIr7jHXiWWeiA/eJp
         cQvcZqIPKf04o+fl6VyTQrRxTZJaArSl6CW6lC1msVAUVmqBytBif/th0On7msCQVPOA
         pKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982508; x=1794587308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3f2uOhpX7PbcT/0WiZRiFZhGB+wqgCccLfMeogp5CFU=;
        b=rxJkXFd7LVaHLLT9Lad+WUvYRn2bkHd1Js2jp9FeA6TIltFs8sYAabmDusMJX3o9Ea
         g8ED1kQCih3Ws9wHmtTHRgt/CimFuwQsdF9NwlcJEcitgyQAauhxOvEm+LgSjQyIQbD+
         Di4tKGhdxEFD9PNrSeE0dvVtNq+bKMr6iIhmALKgtystJ0xJ1+fHW2OSPCEgLGIPX3+i
         WRLtYBfWr92a4kfm2oXW/SjKX27Z7sbQ9zIwDfSoFa+D83DMNlNfPx5mfXm9ScZLGZg3
         D5UkIt1rH7PdW/9kCfFygH0oeswvvm8UzlJFCUEnwAnljx1ySRyIyrHHTolewTsiFTvH
         pqoA==
X-Gm-Message-State: APuU4Z+OWtk6wxzVRPxt0iPfSI10+Y3pvX62Zke/gIdN1CJwxEX8mMsr
	oE1gpcA7CmIBxBflUt6r4fHm2zFs6EOtf6LI2aYF504oX8V6wP8B81YrpOWJpv1mReO+oMXqIxT
	RGcNpH8W/w/9sfJlJI1ZFfjOT8w9ZGp/mdg==
X-Gm-Gg: AYBFou3yKVs0G3KYayj1v5UtQwZqxyWJGPSr3kNbOmPM34GS2DqskUr8Frkp74cSoBN
	REHkQsSqdPTcbfKUmcqTN088dmx7qZRKnwQsUtZvY9NYYn31ulRHg2gjQqpgO1CS1t89ShzbP/1
	0RZE+rCDgTbPUxWdpaHRxBNRYKsQ3cTl8VfQPlZmwEsEk3zI8FPrttvJNirYxclBdayFSWnEBiL
	t38IJRXtjUxQkzpRw6FkY1IY9Kk2fWaPeXtIVd6W7vl9XZmDA5ffET+7hmPDRNWM8mh2fxPlxUg
	4tXgQfcbWnrM9g1yt2Cq782Io6WdbFYnGcNWwqnEDxBIPbcEz9m9GIM9eayVOi633oJh9/oXpau
	w1VY8TyrPu/E9Y5Ox8Fzjl3hi6gAWjMMS2OwrwVsgigpkR2PAh7qkByAWLwiVnaPnTRMtvqBSIz
	NQXy54Q2DPOboisf6ik5n+hLvjyoOsUn0lZ/y7JpYubDK7Ae2qmZmERJeH
X-Received: by 2002:a05:690c:a90d:b0:8b0:aba3:a3e2 with SMTP id
 00721157ae682-8b34196afdcmr17573687b3.37.1793982507618; Fri, 06 Nov 2026
 08:28:27 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me>
 <20261015181041.42873-1-cochcoder@proton.me> <20261106021809.631456-1-cochcoder@proton.me>
In-Reply-To: <20261106021809.631456-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Nov 2026 11:28:15 -0500
X-Gm-Features: AclHuK_oG993vFmHk_QFc21doitstfi-MMNDVa53ZxpQKtgS03JXmyP7dCMKwyw
Message-ID: <CABBYNZ+j8f978ykBprmgT9E+ZW2xW91k5e6W_TXC8Q5jwxnQsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: reject invalid LE supervision timeout relationships
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Thu, Nov 5, 2026 at 9:18=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> wr=
ote:
>
> The LE parameter validator calculates an unsigned maximum latency by
> subtracting one from a truncated quotient. If the quotient is zero,
> this wraps and accepts invalid parameters. Exact quotient boundaries
> also accept equality where the supervision timeout must be greater.
>
> Compare the products directly after checking the field bounds. The
> validated interval and latency limits keep the products within int.
> This enforces the strict timeout relationship without division or
> unsigned subtraction.
>
> Sashiko identified the underflow while reviewing the soft interval
> preference RFC. The bug is already present in its unpatched base; keep
> this common-validator fix independent of that preference policy.
>
> Assisted-by: LLM

No empty space, and lets add a Fixes tag.

> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Fix the pre-existing validator bug found during interval RFC review.
> AI review: https://sashiko.dev/#/patchset/20261015181041.42873-1-cochcode=
r%40proton.me
>
>  include/net/bluetooth/hci_core.h | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e33b15808..97ba716c0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2371,8 +2371,6 @@ static inline struct smp_irk *hci_get_irk(struct hc=
i_dev *hdev,
>  static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
>                                         u16 to_multiplier)
>  {
> -       u16 max_latency;
> -
>         if (min > max) {
>                 BT_WARN("min %d > max %d", min, max);
>                 return -EINVAL;
> @@ -2398,19 +2396,14 @@ static inline int hci_check_conn_params(u16 min, =
u16 max, u16 latency,
>                 return -EINVAL;
>         }
>
> -       if (max >=3D to_multiplier * 8) {
> -               BT_WARN("max %d >=3D to_multiplier %d * 8", max, to_multi=
plier);
> -               return -EINVAL;
> -       }
> -
> -       max_latency =3D (to_multiplier * 4 / max) - 1;
>         if (latency > 499) {
>                 BT_WARN("latency %d > 499", latency);
>                 return -EINVAL;
>         }
>
> -       if (latency > max_latency) {
> -               BT_WARN("latency %d > max_latency %d", latency, max_laten=
cy);
> +       if ((latency + 1) * max >=3D to_multiplier * 4) {
> +               BT_WARN("latency %d, max %d and timeout %d are incompatib=
le",
> +                       latency, max, to_multiplier);
>                 return -EINVAL;
>         }
>
>
> base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881
>


--=20
Luiz Augusto von Dentz
