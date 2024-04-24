Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37015A49E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959781; cv=none; b=c8RIXWTF16d91WBd99PN50htBLcFhaXL2IXtXPXhmPGKhgP2l/YjnYFd4hP2Ve+MIKB0WtPsrtPQCdx6i4PjQT/HOxfT3hbgflIWDO3mG38sJ0rTexLzWawzOP7X2pUSppUbst10wdO7UrgvnbGCdgIErtLwgN5eEgHZVdroqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959781; c=relaxed/simple;
	bh=E1j8D+z+VDjM0jA1xb7bQtZFFSEdkHgBaKagxKEiWBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLHA7ogyMJHfN8/PSzWyu/1rMQZ2RSvJbYAGEzmRaXrLvi4pUMsXb+mAUKVAcXEYTeww71xHWivo5JOjHXOg6F9j6YU81W3/isGVgdvtp/72JCkQgoN4vy9ohErpsUoo3cv5tv8qsOgy7f4aQwX/9C9i2ob44xrUX5SdC1kW48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WLCmnJl4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WLCmnJl4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so4062203e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713959778; x=1714564578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1j8D+z+VDjM0jA1xb7bQtZFFSEdkHgBaKagxKEiWBI=;
        b=WLCmnJl4amCHJ8C5fwnsPKfQeSmOAFhmZWG1eoiCCO22RugspXJXHM0hgXFezREFDz
         VX6yGcpLooi0I9GG3h2DDEvlqWQI3vdzGEYUIrABH1HBvkQdvG3HHIPtzR8X5Kw8WmDp
         WU/8oko4ffmJsdp1KrO7rB8TIVIjtu5FOssr4/OBcMxjoe5fqbgmyovPuABAj6puOtEJ
         kGK/suNK9ug0mxZ5wJRxHLcjhnGBJeOCyYRKvhg9X/hQtu1Nh3PyxonUqGGTUCben/16
         5x1GYhPqJLqqhWENOjVe+HTSk22auqapkopXki7l/vxeMPwji7rN1a8/C7MX8E53bznK
         ULUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959778; x=1714564578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1j8D+z+VDjM0jA1xb7bQtZFFSEdkHgBaKagxKEiWBI=;
        b=lIc3OH7SEd0WfRRvMXtzRBGUOVkyMbeMk5vI2r792XCbCUnxspCQ0MU538XVG1ah2B
         5TuLIdStOXUUnFh0Uk5OW2/QHFqvR4+X/FRXNwCLakjoMwYEsRbwDONYyh5tdm8IvhZT
         nJUS5WCviGczo7yQe+v6tSjCvV6ZEgplvlYhZsomZQIMT2NHXJYl3OKvvXGXrIeRXK0y
         HUuhvKDrvOYs8E7saVd6uN8N3gC/8uzURORzqVw1bKL4x7rLlNByFrWt+dUMIvGcnija
         PorIJBhSzjtFKMxRihqrKIYxo0AemMYLo76ncBonIshNkh5tcGNSa79dU7R98riXC6Jp
         /i+g==
X-Gm-Message-State: AOJu0YzxIyMP/g8F+WUsSBAcxY+ZzODjbPJH1ne0fPAa0tWW7OghRkrv
	RUhQy3X8Ut8vyjzOMFwYjHZR5DphbstPSpq2jU8cc1kmMxOUVglzcpgAGpyK8LAqVQt9JpcwZcF
	ontt6CIWH2Kn1Nnm7OaqNb85w5UJ96Xr3EFurdg==
X-Google-Smtp-Source: AGHT+IGn2nOjGynSGGs86KzRli27o88A8Q0fLdg3mlD0Wzx4QSFJ+wXo2KW1LOEP2Tcgo/VJYD78wFE891jDnM6jmBU=
X-Received: by 2002:ac2:4daa:0:b0:516:d448:b42a with SMTP id
 h10-20020ac24daa000000b00516d448b42amr1567023lfe.26.1713959777778; Wed, 24
 Apr 2024 04:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org> <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
In-Reply-To: <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 13:56:07 +0200
Message-ID: <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:53=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 4/24/24 4:16 AM, Wren Turkal wrote:
> > On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> >> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>
> >> said:
> >>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >>>>
> >>>> Any return value from gpiod_get_optional() other than a pointer to a
> >>>> GPIO descriptor or a NULL-pointer is an error and the driver should
> >>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
> >>>> hci_qca:
> >>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer set=
s
> >>>> power_ctrl_enabled on NULL-pointer returned by
> >>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
> >>>> errors.
> >>> Nack. This patch does fixes neither the disable/re-enable problem nor
> >>> the warm boot problem.
> >>>
> >>> Zijun replied to this patch also with what I think is the proper
> >>> reasoning for why it doesn't fix my setup.
> >>>
> >> Indeed, I only addressed a single issue here and not the code under th=
e
> >> default: label of the switch case. Sorry.
> >>
> >> Could you give the following diff a try?
> >
> > I had a feeling that was what was going on. I'll give the patch a shot.
> >
> > wt
>
> Considering this patch is basically equivalent to patch 1/2 from Zijun,
> I am not surprised that is works similarly. I.e. on a cold boot, I can
> disable/re-enable bluetooth as many time as I want.
>

Zijun didn't bail out on errors which is the issue the original patch
tried to address and this one preserves.

> However, since this patch doesn't include the quirk fix from Zijun's
> patchset (patch 2/2), bluetooth fails to work after a warm boot.
>

That's OK, we have the first part right. Let's now see if we can reuse
patch 2/2 from Zijun.

> @Zijun, this patch looks more idiomatic when I look at the surrounding
> code than your patch 1/2. Notice how it doesn't use the "else if"
> construct. It does the NULL test separately after checking for errors.
>
> --
> You're more amazing than you think!

Bart
