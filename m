Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391249F11D
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264709; cv=pass; b=kxsXU/Ke5yeE3ZpVv0xDKosTXpH60wlwSS5J+MRPiAPsMUQTKwTFBatPhK4HLPS0ohOmswd5dW+U3iuhekNLePYc21LKZLEclb/dIgcBD7AB5FqXvY5tCySKRBnCxRXMMCT7ALlIVtzCNyC7q9reWTqWrtVCEXcilfFsEOe/7lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264709; c=relaxed/simple;
	bh=DluWJNSjpap6aa/OzHf+XOI9kFsHucgilOgKRqSpunc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmowwzVZv+X5nikb7uwi6KCSe56zk+vizc+DZJec2njB07bAC4yRzPsqZhQFC3FRqdhEEJIuNg2Mv5S+fSftCFPcyPUSgHl7BAf00cJnhCxo89trUrcZ922457pj42vNdANEE5ySTBXQ6MNl0JqzrCu5Ro8ReoTdt0steFd0wTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2NzEFLK; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2NzEFLK"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-670fee39d73so47629d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264706; cv=none;
        d=google.com; s=arc-20260327;
        b=OzbCcvch28SOhVq2+GdtvhwRAnBSxW3OC+BXXO05k2PUutlZ57FJd/9I9Ogjj/89aC
         v60MYJ3+8IOXP10iqpWyDv03k/ksrvD/mqFD/fiJv4cOenIS8d7u7IcBsSnpr2bKJ1iU
         3W/bw7h+bRGu+8d8Y9qQBObgsmwkmuN1iaVMNh/KL6qVBV1gprfE6tWnXlfD36IRoOe3
         Pf1M4FDgVEDyjaabnGmgNbJULc2gnY7TafIU63+YRsiMyY5u0drlO1dTQynqktUjIVMc
         Bndwlq1URD4+Z/ioiuiPp7a41YZ4y5pINAgG0OY3TiTFBRXUDPDXCslylF7HOxvJ78jU
         h9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zjjVRgIuGMJiVAompZOSoaXToun6IskM2FW6ji4V+CI=;
        fh=eweP1YhvcjXVD2VCpv9Qe49bgfEV1tiRtN8jgp3DAS0=;
        b=U9Zu5p2i4ZIpVFUAE2VxtJpmVkcHCAxVnwDYSIuxS/aIwGXpt1Dd8Dr8sauNoMaNjv
         LaIMYAxvZZmNP1mH7+nTZ1icYJ9GPRfQWWM39GmYVjfg9/HuuMBowRuOQEWako+4luEw
         6tYxYEX/9HGGpXoC0RERwZnvTIl0jk3dM1L6+3jgJWWXLLkhhZDOEep0/y4Cwd7Cs11G
         fUth/WF+XhgDNBkrHG2dWh8F+69cIsA9Wz9tPId/XghbzI6htwV1vc4lf7tLIOzGy8xS
         GoBmr1nuCSszF6xFc+ekTJ1IJJpgT57cl9IInv3GfKM21YaFzTEk1UN+s5EYHjqskv+K
         3bYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264706; x=1790869506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zjjVRgIuGMJiVAompZOSoaXToun6IskM2FW6ji4V+CI=;
        b=B2NzEFLKVRoN8yZUWimPBpGB7UhMygOWzsrua+SRmz78fRkm8CnlWmDjOT4SpDGoTB
         jKPMKQpVHH2fjNzy1V1iCbEqrfaN1BD1EJrfHRMGs32K4ZwN7qloZoWTZzOf/YGWtBAT
         D0bC8nnOfdZwJF1f7B4HC+eb58Ff2AC9m7mf0qBoInzyxP/T8SqQSZWYyaFj5ofpAgEB
         wMcBGGP1FcWW4LvB4uastr1y1/vFZ6Moe+agH1Y6LWZmUprK+FC4oOsfTwEyuKhbYJ43
         QaSgPOmF8t0/vJPxZff1qUhRSRE2wcY/9Ji/5nqD8HDF7FWyaqwoKIGP53mSoM4YyoRZ
         u8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264706; x=1790869506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjjVRgIuGMJiVAompZOSoaXToun6IskM2FW6ji4V+CI=;
        b=M39ZnmRNkTPw5dnUaeTUMTYw+SrqwNnxJRI3LGcqA5gZHgPQ7rvpYYDWDHhWczsmxs
         RJblcpW7OCU6XW+dyWAHa0MSTWgkPVhK32wjXt9Co3FTadHkBhclaRbTbEDI69g2ylpm
         16LDu3WrAAcrbdpATUt9SeUdtNbCjzs8gHLq6X7AGfTbUiJM/nX3Y+MFRYDnajmY/n2j
         9bET6k50Zwg9YCwz5leO/w5xm/z9c9luFhvTJadMzRLqQQWSl6ATjlt32Rwt3nvBYO91
         /VAndtAc4/3faCuliclgcQJ/Mi4iijXhm3DfJkbM7p8SsMKTjSIUG10SI4glsyNwJfxC
         vI9g==
X-Gm-Message-State: AFq9FYJfJZ3PUa4tGuz841FBQoCukFquwZX7f7RDIBDXIRuVqj3qA643
	m/xyvMPfmvQ9jyU8q+YV8amvLiCTOkllGRkijTj2nJjuHLRu4x4Gv8bk8qJCkYlUL28Mjtv70d7
	AM+NA8x433rUZgxmCN+YDFOKgm9cWbyiX2m3SaZfee91/
X-Gm-Gg: AYBFou1PFmOm03MHHWCFYB+/G5Wypg13gm8Fc4iEVX373+BCjNeAEZjvGsFQa+ailf2
	2wpXfwcDLNTvjUirElUNU0ZVIgzwvmaU332q2j6MuI7Erd7S1ga5SE6PBxkbih12TjqWRHAiaxh
	fk/Di9qfX3/ngyY47aZMiG+NaJauzczLx9uQEF09LBH2DyIJ0n48zVivenzgfB8z6iEjscsSBOn
	VqI261jJ3/0wRbA437j4yG00wJl6STlzzx1Y5EaFeq1K8MeAtNx5aJD4DdrVBIeQsdYHnME7fQE
	UJF2+Wrgk9cdk9XhJKzQtzoOAcaPLDDO7nPKlV2AytyWR/addE/g0kjkXRDEreNhulswW4yPK41
	gL15Gnd05AkiR5ae5fxFp2X5op2xU1RFCo1saZZwgHQhsfg+H8LQc
X-Received: by 2002:a05:690e:128d:b0:66c:ea12:95d9 with SMTP id
 956f58d0204a3-672ed25e87bmr2024424d50.22.1790264706131; Thu, 24 Sep 2026
 08:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924151720.1769259-1-as@discnull.de>
In-Reply-To: <20260924151720.1769259-1-as@discnull.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Sep 2026 11:44:54 -0400
X-Gm-Features: AclHuK8QTpvBwUU_cgOOijEKxB6hklK-hWsOoNfO3uwEBaMVlbw3G13MhyPVqMA
Message-ID: <CABBYNZJhvRubX7w7Wj6cKMPvSUFr-GsnqYBYJp66sWGW153Y6w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] org.bluez.LEAdvertisement: Add broadcast name support
To: Alexander Sarmanow <as@discnull.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Thu, Sep 24, 2026 at 11:36=E2=80=AFAM Alexander Sarmanow <as@discnull.de=
> wrote:
>
> From: Alexander Sarmanow (Televic) <as@discnull.de>
>
> This series adds dedicated support for setting the broadcast name via DBu=
s
> to the org.bluez.LEAdvertisement object. Should make it easier for upper
> layers to set this advertisement property.
>
> The Public Broadcast Profile (PBP v1.0, see section 5.1.1) restricts the
> string length to a minimum of 4 and a maximum of 32 characters. If the
> provided name is shorter than the minimum, pasring returns an error.If it
> exceeds the maximum, it is truncated, consistent with the behavior for th=
e
> local name.
>
> The BroadcastName property will be parsed in any case, but only added to
> the advertisement data in case it's of type broadcast.
>
> Tested by setting a broadcast name via pipewire bluez spa plugin.
>
> Alexander Sarmanow (2):
>   doc/org.bluez.LEAdvertisement: Add broadcast name
>   advertising: Add broadcast name property support
>
>  doc/org.bluez.LEAdvertisement.rst |  7 +++++
>  src/advertising.c                 | 44 +++++++++++++++++++++++++++++++
>  src/shared/ad.h                   |  3 +++
>  3 files changed, 54 insertions(+)
>
> --
> 2.30.2

This is already supported on bluetoothctl; see:

commit 278f3439c45ffcb1309f9fe961be1b120bdde459
Author: raghavendra <raghavendra.rao@collabora.com>
Date:   Wed Apr 29 13:16:05 2026 +0530

    client: make advertise.name use public broadcast name

Now it doesn't seem to have the string limits you pointed out, so
perhaps it is worth extending it. We could, in theory move the
detection of the PBP uuid to bluetoothd and then automatically use the
advertising name as the broadcast name, or if the name is included,
use the adapter name as the broadcast name. However, that is sort of
client business, I'd say, which is why we left it at bluetoothctl.

--=20
Luiz Augusto von Dentz
