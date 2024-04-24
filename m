Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4821DFCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961250; cv=none; b=Vcqpv9aUce+RUid6vpnaiAbZxJPcESEGZfAO57TOxQHBmvs5Ni8hyuAvsBCKdxByndaHnkdFagc/PZWhGtG7RXNI9tCLT2p2e2d1Nv7S+WWgHPSwscQTQ9x5zVTFYoKUuST5kQOI9ZLWkF5nOYeKuDtx2o9UD+LuByiPakwod2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961250; c=relaxed/simple;
	bh=QXyTAYtBEHqfKfsBRuXbIP00XZG3dAzuEqxSavK2oRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXtqukyQX81izrjpF8dsXtqiPUWf5eXEqe4zCE1/VrZE8VQOiDI45nwEfejnT795ygX0khLVS4hpEzzdn6fpLUYiSSnfyEiQa2HgPaGhze8Esw4gMkg8347etkJftnf/1OqdLDgNK2WDWrd6axVZJ1a2D8eStFbV/jVGk3JZX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gs3LSytU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gs3LSytU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61b2218ab6fso48766997b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713961248; x=1714566048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXyTAYtBEHqfKfsBRuXbIP00XZG3dAzuEqxSavK2oRs=;
        b=gs3LSytU3jDhhIAmFOvLS8BZCOMsXNtyS9bgBy53UYKVGLN6zf5ssNiEdMdi0xTChr
         ywCXPjONKVU5snKcK6O2uNUTa1SiX4G58vrrJ/kHUvS1alAKSq1LsXDvz/XViwd5sB1M
         wKEjvvymoQHuag26UJdD7j/2NXHHFXiYLMjjweTUvv5h0RMCwWSAdFgFQJcfSxwyV0eS
         6eoSMWzsXY4yuCBEJUNvMbxKEO7WVNqQUnPrxplOMZwTwsbtXKrqbYJH4dt4OE6HYUO8
         Bmuww/JC2NcxyR1nhLCVaHJIN1OVDI/XsJGgDK/jDq6+g8rmSTbRkuT/9hhJHz6T6iYc
         g3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961248; x=1714566048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXyTAYtBEHqfKfsBRuXbIP00XZG3dAzuEqxSavK2oRs=;
        b=jNGjnd2hqLMO9Y7+VbFojUKLPHgUN1WYfC5vHau8mWem/Bau4UOYdeiE4jw/4ztsDu
         uYOT7QJer6OEINmoH7rC9KP/sMGKrkmLdwRiVSktpwLqo5uw3vp0WZCfm8YlS1q3P3tX
         TWCDcDO73Qe46FyD72wxFJ/6gLcolgAQiwl3p2ZlcE4nsJ897YmlZPRJiEC3L03z1BEQ
         Tdxj21XeObKFdUeIOD4KL8N8FFoDMNHIoLz/JMJQWQALezAEm1OdEt2muxCXUGrjkOml
         JIEoCbfwdjQJb6LKoimJhZZ7VZ84FEEpS6OB5UazlIPC7hg/kTlX0m22jXyoEkiLHnfE
         4Jsw==
X-Forwarded-Encrypted: i=1; AJvYcCWcnSM1iccyWE/kVSCviPdEcGqcz//fmC5V/DKvClNufJcVDVOtQcBZD5adlkQTqpuZ4W2FBCm/oPJlKpUp3jsBoSV271SxmgF5mcBvnxKp
X-Gm-Message-State: AOJu0YwuJeddE6vAFMklBqndcNmdE7tZw85l4DOgWosdS+v79h3grDKa
	qdGtkEF23afjaAER6xLkIyqi5z14AZlhD+ntvTUcdv5IGgqKyXSoRr70Q57dugRYPOZwzm8NZjF
	gTn8SbB+X3cOBqyhRA/Lonq+HGMq1jZbjvQWdLg==
X-Google-Smtp-Source: AGHT+IFlnUzjZT7CIke7TNCrSUx76xu1l/kSb/3YVpva/PnKnsHU1IGww6Ek7hw5Vt+mX8BVYvB8BjcE5mbTfmYmXDY=
X-Received: by 2002:a05:6902:1024:b0:dca:e4fd:b6d6 with SMTP id
 x4-20020a056902102400b00dcae4fdb6d6mr2642434ybt.61.1713961248050; Wed, 24 Apr
 2024 05:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org> <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com> <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
In-Reply-To: <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 14:20:37 +0200
Message-ID: <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 14:17, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 4:56 AM, Bartosz Golaszewski wrote:
> > On Wed, Apr 24, 2024 at 1:53=E2=80=AFPM Wren Turkal <wt@penguintechs.or=
g> wrote:
> >>
> >> On 4/24/24 4:16 AM, Wren Turkal wrote:
> >>> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> >>>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>
> >>>> said:
> >>>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
> >>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >>>>>>
> >>>>>> Any return value from gpiod_get_optional() other than a pointer to=
 a
> >>>>>> GPIO descriptor or a NULL-pointer is an error and the driver shoul=
d
> >>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
> >>>>>> hci_qca:
> >>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer s=
ets
> >>>>>> power_ctrl_enabled on NULL-pointer returned by
> >>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
> >>>>>> errors.
> >>>>> Nack. This patch does fixes neither the disable/re-enable problem n=
or
> >>>>> the warm boot problem.
> >>>>>
> >>>>> Zijun replied to this patch also with what I think is the proper
> >>>>> reasoning for why it doesn't fix my setup.
> >>>>>
> >>>> Indeed, I only addressed a single issue here and not the code under =
the
> >>>> default: label of the switch case. Sorry.
> >>>>
> >>>> Could you give the following diff a try?
> >>>
> >>> I had a feeling that was what was going on. I'll give the patch a sho=
t.
> >>>
> >>> wt
> >>
> >> Considering this patch is basically equivalent to patch 1/2 from Zijun=
,
> >> I am not surprised that is works similarly. I.e. on a cold boot, I can
> >> disable/re-enable bluetooth as many time as I want.
> >>
> >
> > Zijun didn't bail out on errors which is the issue the original patch
> > tried to address and this one preserves.
> >
> >> However, since this patch doesn't include the quirk fix from Zijun's
> >> patchset (patch 2/2), bluetooth fails to work after a warm boot.
> >>
> >
> > That's OK, we have the first part right. Let's now see if we can reuse
> > patch 2/2 from Zijun.
>
> I'm compiling it right now. Be back soon.
>

Well I doubt it's correct as it removed Krzysztof's fix which looks
right. If I were to guess I'd say we need some mix of both.

Bart

> >> @Zijun, this patch looks more idiomatic when I look at the surrounding
> >> code than your patch 1/2. Notice how it doesn't use the "else if"
> >> construct. It does the NULL test separately after checking for errors.
> >>
> >> --
> >> You're more amazing than you think!
> >
> > Bart
>
> --
> You're more amazing than you think!
