Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B81598E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960099; cv=none; b=bjLCJb7X3UDciFV5Kcp8hOM64agGBNpus+eAcsglbF1rI1F1mTDprhtR0KOvWB+tueXYc7WdwV8J6eQNOQmyPruLttsYuIT85uWE3XMZdsESzzTt/llaHPtFwuMnH8zF9rwNXJvMEKN1gDn3CvlC2N1h0im1u+WwYKeOs9fx2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960099; c=relaxed/simple;
	bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3usfTA9PQkuns49As0LzesTZwi/CCEcGbrXjyPdFRXvvQT0f/3TPYK3TY4yQloA3AeNm8TPwkJCDgHkBPnb76yplRrA1z4D1a5PclNfoaAzjm1gTMPFsPKcR7sL4+pblkcx+pRQ6QpcRPVDTFtIhbNKFZKXBA6nTYuikbdkzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tmfjRh9W; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmfjRh9W"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de5809cd7b0so54601276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713960094; x=1714564894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
        b=tmfjRh9WA0Gim+MnjfLeMq6a+z6+t7/PoXocOAzy57tNcXm7MC4AkgITeQPBCgtX1l
         dGQA05mIOtl559U1U+vgqcljQp/jVzHYxjKyf7K0boxeYS+TelG6aS6JVfV2C/+VWAig
         y4xxi26AzN7/payAGJA3aJtp47TRYDB+xU27ht8Puj8Rnq7QIQczyfCfeNvUfbhHEny3
         OWDZ/mV151DA3Yed6m+IRfHi9vp3HLTSl/UGvEW9rmhk/55lGpLkHyBsrvLzE9z+TGSk
         0LCUlRjO7SpThDjPoouXc+aOw3JU2qYVv31Zz5DrUM2zu+8tXPCWGdHjZ/JCTP2kBmEW
         49Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960094; x=1714564894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
        b=o1AzFDlb9L8G7lPMq3/Biq0NmRWgFiL9hwHQZyRRfDLsgwlcc7ocm09pbv/7k2VLJI
         BgKxmsokz/dwVjKsgYvfOpkNT1zfxublhmCc1heMCMCwY96Mo2U/OoslHmiuNba6S4YB
         OvkOWW8ZFQEitm+pfvcP8ZIxPuiRfzp0urDoXMmgVEx/TwGrMp6qMICoII3FKnWwm+W2
         oGqPBdhUn71ckTgOeqYM8VqxrH0lJTRR0aht+zFrMAoVtw+wYa6egfMzuuaY8cdquuU+
         xmqjHI/njnBPtiQUpWx1YlRHLPa6n2j540AVkpRgEiDMKngXjopBifXPsVCQIwYMNfme
         0L+A==
X-Forwarded-Encrypted: i=1; AJvYcCWwpuE7QIIxiHuYinxaEkPE/WIfIwa0tuog2aoWoRQxlCiET/NR8WnOyzGuIsuGNy2fNyLQvHvk5f3OfOigLVI1bIn7QHuFkalwhYn+juwP
X-Gm-Message-State: AOJu0YzT8/qH6nYwXDKGUXcyR03Vmnp1lVZmm+B3uwMZ+aXvsSvn9PWL
	sx63EBmMx5M8jkWvoOIJKBAyYaoqVOtxD21LP+Jc3ewHDBwava+afb5EuyF44fCk+iKzyNf9Ng4
	/8+RBThD32Yf+RlJ/kmQm7u0yBI70zXDh/m/G4w==
X-Google-Smtp-Source: AGHT+IHzZo4Ut6gU9UO63GhCLg1BvH9isGdACES/j0J9GVRMC/W9uMmUWJy79G52Yy/44lup2sqppkr+3ipIco497iw=
X-Received: by 2002:a25:2fd1:0:b0:de4:6efa:debd with SMTP id
 v200-20020a252fd1000000b00de46efadebdmr2514071ybv.29.1713960093802; Wed, 24
 Apr 2024 05:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org> <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
 <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
In-Reply-To: <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 14:01:22 +0200
Message-ID: <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 13:59, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 4:53 AM, Bartosz Golaszewski wrote:
> > This must be your email client wrapping lines over a certain limit.
> > Try and get the diff from lore[1], it should be fine.
> >
> > Bart
> >
> > [1]https://lore.kernel.org/lkml/CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com/
>
> I don't think it's my client. The extra newlines are right there in the
> lore link.
>
> Look at the line that starts with "@@". That line is wrapped. The
> following line ("serdev_device *serdev)") should be at the end of the
> previous line. The same thing happened on the second "@@" line as well.
>

Indeed. I just noticed that it applies fine with git apply and figured
the output must be right. Anyway, this is not a proper patch, I will
send one once I adapt Zijun's code.

Bart
