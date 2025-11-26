Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5542F693F
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127763; cv=none; b=bOb6ngo0jcnZxEDcWuFCq64ETtiPll9ve8wDVCfgeQJrmBgT1nLOCsKLKYyuqMF8YoNEaU+whUnmN0WMiu6yO9kyl4tL2bG6tyQsQ4rXFhjriz2xtZuZIRczQzXy/mA5Jlpte/+OrklQzMkO3Gx4IOJDSDUHMyPU9pF5wZYtVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127763; c=relaxed/simple;
	bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJY859lt8dUMDeNmrdu98OVrKrr/fQcpnXwEgHmtZIxZooEhs+G1HNTGlP4Rdz8nEKIdpENg4xbIYCjE+r+/95Ep7Hd+HLizb8v8chtFtQpusvcYzUN8n5j2ry2NUHY0UX0ytCjPrWB3uRjJ/obPBKPOLlshRxTqTq0697G837s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN13IDGS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN13IDGS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso59858241fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 19:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127759; x=1764732559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
        b=YN13IDGSY92h9kDSlSF8YG3C050KMI1VARITQqyZZGfuCUUYLJMFwyIbO+/IAYTFtV
         wq1eKuzKSCG10ArqrimWUjpJIBDc9ajdt9iICgZFzF/pz9Zbyrf9/K7pj0zYG3u32FqP
         JMJ9kZlPgiRx4FZ+OEVF/Rh5ViVxJDw4MrKEaKspIoKwuANhaSliE8BYAmkuKKdOvGY9
         wXbyPi1O/FkhNXBDzw7vjxklc/0g4L0duyJdaUHAbQGEGSAGgf6drmu1Na+6BCa2H50l
         5Y2v3xISuqxNjcrikdAw9nf0Y+WUweKjJAt5eOfKykyc4hIhs+vnKWDsJWNoaY6Ft6gk
         zs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127759; x=1764732559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
        b=uCxdARRLY7OQT7GJzcijGO5Omm79P9JB2ALMfaTTziXMdkm7JoT4Y264nMlBREH9Yw
         A6rBtJGc9ErKebx6btaXKMGifHIiK+Ftizq3R/be/dSxSNM5xGeB7fhKe4iv5uwDhe39
         yTsNH2cLSySW73SQjBx4V1y5jSqzStC16dJZcjmUN4FoKE/ZonAbVcVEmo/jWthZM4kG
         3gEeiRgs76DOfWoMAF6oRA+/TneOl/RJ11IE65RMmv96IiiQhjAiiJWPjnTuwEcwjDOl
         cGf4YZ01L9UJwolunbZ6Jf4VPbn9GPxRr7vpVvshr5ebI5HLJ/IglHekJPpaBoJbQIxX
         W/iw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3cqsgjJ0aTOXyIzaz5hxrlx+ZIKfr2Q2Lpaq4V+olzu6fHOWghAivjW8foxu8wwNshKlP960MM3PUzZuyjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhMt/DilpxRinUVBVFU8EcVsbZcEpBSeYmwuSFLJaeDGPa5at
	3MUC+48iLz+Zzmu0Gpgu4I2t0xMPMitUdD7Q2u2An1MkbqK1Zg/NHWOdzNzlsa46WrAv2kwo09h
	T87Ib2C20eo2Nc7jgVJyGlroBMkE+hcA=
X-Gm-Gg: ASbGncvTbwVY6ZMBP63lrmyuYyIE09UQK3eb+hH9k/RQj9/rckzpyYUwBfEVmvRSNlO
	X1HzZyIYE2xfvFncN0hn+LLrfCAdpYg/WpEIHN9+m42pzXj57GPig5d4pbXh/lpZ1bBcbCm2p88
	yJcvwSo44Utr1G+IgYg1jUGTzI5svzXlp6UnAGlrmdJ6vuR+BB7RMfSXvzmLlax9pliQ5wWPAvQ
	9ns5GPQSKC5oLSp0o4dmzXf9SN4BveBm2hf+L9Y81f8apBousRCNLGyv19rrLWCfxJhUw==
X-Google-Smtp-Source: AGHT+IFXNDNWfBE/jdt0Dz9W+S2FZLkrdTl/cEteRJj+bVHvSnDXE5eODbEtCrm2sfh2BeISb+8B1VHSywmIxbn2U6I=
X-Received: by 2002:a05:651c:43d8:20b0:37a:432f:8ecc with SMTP id
 38308e7fff4ca-37d07953a3emr15608421fa.33.1764127759248; Tue, 25 Nov 2025
 19:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
 <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org> <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me>
In-Reply-To: <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Nov 2025 22:29:06 -0500
X-Gm-Features: AWmQ_bm2zfUBQgnJooefgPcNZ-tIRrataC9j9VnWGhDa0KJzloTqrrroBYDFEXM
Message-ID: <CABBYNZ+LrMOr-Bb-Sfk--FAHjMWxzeUCdDoGLuRqhF99xaGE3A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: incogcyberpunk@proton.me
Cc: patchwork-bot+bluetooth@kernel.org, Doug Anderson <dianders@chromium.org>, 
	marcel@holtmann.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, regressions@leemhuis.info, 
	regressions@lists.linux.dev, johan.hedberg@gmail.com, sean.wang@mediatek.com, 
	stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 25, 2025 at 10:18=E2=80=AFPM <incogcyberpunk@proton.me> wrote:
>
> Hey,
>
> It's been almost a week since the regression was reported and an patch wa=
s provided to fix the issue, which has now been accepted in the linux-next =
tree; but I see that despite being a patch for regression, a merge/pull req=
uest was not made upstream for the latest -rc mainline release.
>
> Is there any way that I can track the updates for this patch to be onto t=
he mainline release?
>
> Sorry, if I am missing anything.

This was merged into net tree a few days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D8a4dfa8fa6b5

So it should get into Linus tree in the next few days.

> Regards,
> IncogCyberpunk



--=20
Luiz Augusto von Dentz
