Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30C1714CA
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864103; cv=none; b=sgPIHQGEH0DE5XWCA8A2hwMyuoyam6qce56R8AkHCczrApQX8ANmvTLjmnOhmm6kTe7CqHcPl7SIJTSm6HsEJFNqfbhNFd+07dGEpftJnC545oKBqXnc8VmMi7MkXUkUo7/4Ey2HdWvrfsxFkRdN6oG3JNMLgLGYPMy4WyjaBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864103; c=relaxed/simple;
	bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKKphjARqItvwQGXoXBpT/qdMI9gMQtSPHpIn97syZipFXKpSinszh7AONzCJznRLlpbQLMI7pv3jy07ivomfFwnb89W1uFOvUyIiP0CaLYVqsnsfZya8K9Yv+ttn9opqmKj6jOtsRw9InR12f9V0ZOs5oN3ChW1WN49KWX+FTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ejm9gFHB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ejm9gFHB"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f759688444so18875171fa.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Sep 2024 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725864099; x=1726468899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
        b=ejm9gFHBlB4n0R4/aQxd04ztrJBkWEiOSQyXoEzlMMxnjimjO4oRLjYJyyDvmaWsjx
         8jTREf1Mc4fVPNatUuLYazz5uDxsd+hzXZYFZ7efsjCx1uoBMQiH4oiJ/Jxru8IFaVKp
         V5nn496czRLkyF5DTGI1RpB4322U0JyCPiJW86nXB23wQ/Li/aF+QpDMhxLJw1WpYOOu
         RQz82kqcLWbJ3HKTEHsSZggBCmFzBDpcXfWjmrBStVZfV1aNMBmL6B8jXzINhvtx97Bh
         OzCYcZe9v06UEmkpQ/MChGiMUW+YAcCHGr8SrG9c+c+sTNsgCCproLpQxfQGZlx4ans8
         3eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864099; x=1726468899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
        b=HzG9i2NclujRQAyL/a17MDbKAz5eNQDW1vypPKRZUErE91PtL50BJmTkm/PyjjvOuH
         sNVYHiu6sN06OGqymzEDXOyA3RtURT+EfUYj6CwNOJrqLfIbOBBmNWyZEqis1wBiHZEX
         K9/WPRvuswJsHS6kzseFfCRbuo5MjXnGD1r42xq4pHGynPgegvIxQ3S8MDYliqAXGa/9
         QlNUqsJqz+yLheCAxl2ZltMxBww3zI/jAtVlYWT9u1ccDSrYcmAaq3kmBu9lNl/7iGJi
         0cz+skZXvXRTd5ZSRAIuGy2VKwl2TKldxfawxHYNQqBqojYtqPjYvh2GRLJmP6Axc1IV
         tOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVKck9KLi71MtKqn44k7DyR/7nD6y/qlCshXnTdJkKeRslli0bkfwGV9xvCS1z/N8ctfP8ToJ6R55r9BNHalY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTkQAQrCgV9ZpukW0VQOox/axM1tMpzA1WLazohjpv9v0S4Gj
	ZloY7n0sfSXSMYV10tBbMs1u4ZGXzskE0u4soxik2stCv1WlK963c0g1PghoMk62g5z9gT6L2pd
	kFe/LIWPVZGRFjeEglAe4Wfs9hVkynKVFIfbx1w==
X-Google-Smtp-Source: AGHT+IE8ksXdclQfbBIHEdbZ5UrRT4fGD9jPz2IvJmQUAOXzM2ZmMquUIzTiHIzZZ8GahzqMtT72RkXTS/ePPAEEnU4=
X-Received: by 2002:a2e:b8cb:0:b0:2f7:64b9:ffa4 with SMTP id
 38308e7fff4ca-2f764ba01fdmr23131841fa.9.1725864098538; Sun, 08 Sep 2024
 23:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
 <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org> <220024b46504658718c21c5f0c221007.sboyd@kernel.org>
In-Reply-To: <220024b46504658718c21c5f0c221007.sboyd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Sep 2024 08:41:27 +0200
Message-ID: <CAMRc=Meei90ZjFn-jZkyv4=SpijMevxhiF7G1Q7Q7dUUYiRbKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: provide devm_clk_get_optional_enabled_with_rate()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:42=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Bartosz Golaszewski (2024-08-05 01:57:31)
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There are clock users in the kernel that can't use
> > devm_clk_get_optional_enabled() as they need to set rate after getting
> > the clock and before enabling it. Provide a managed helper that wraps
> > these operations in the correct order.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> Applied to clk-next

Thanks, I will add some users in the next cycle. Unless Luiz really
wants to play with cross-tree merges again. :)

Bart
