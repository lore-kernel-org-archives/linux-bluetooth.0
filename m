Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1015E81E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968358; cv=none; b=KOptuyF1V5O4PMXH6jbgI8ASKPGOPL5vD0+WNicyDrwrZSyL9FocQWjDFoWcf6un/5D65lgI0yh7YpyQnse1t3Sr1sZi5dfdfqgD++K+J84MSRyvzrhEC9U8+aLyfQLWwUVmuk1neX/jmmgFoXz9SY+SFecwFgqa3mVyc+xp9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968358; c=relaxed/simple;
	bh=tiNw2EllSa9kVNGgrjm20ppbjckIo/MlMqTrgILjBEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5GoF+UrnuWg2g0cHn2ipxVgfeSu4QdsXKG9BbrGaNHvJ/+gsvqe1MgZlCd1eckUeCUu3BXIj0BAN/ism96FuX3LmqORcacDior44AIjRzHrD+4CYms0T6IN29hoIdOnE9cQl0b/pSr5hWsSJq8tnGYQ+8pxc52JQb/A8pITB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fb/lGT5X; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb/lGT5X"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-617e6c873f3so75247647b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713968356; x=1714573156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiNw2EllSa9kVNGgrjm20ppbjckIo/MlMqTrgILjBEs=;
        b=Fb/lGT5XFqIRyd09hM4YX9jjg5nVHec+OcdGpsbrETyQT6l04Pri5uVHjuUSdEhdNq
         NxPLi/odiWtH31CtlrxOJ9MgZjtmdOXO4DHFF5yAY0kwswZuUmvKfh/1UuZLzL0Jk43t
         YGc8iHVKwBUeJSFzNH2PDe99emzpSv6JV0SDrzCJ0dJUhhz6PEf7kVAUtXvijWGyuEGK
         NNSgVQ86ZoTZfKqk8A7RUD0DWryrMKx7temjsNVYnBHiy+5UH4dI9CdNnBSQihace8RQ
         1sAtGxZON21SMzAPYGqcgB/ycVKppn4aTlTTlZRfPpzjQbL/ivCMZ7HGUHYQdw0oYb0A
         4XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968356; x=1714573156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiNw2EllSa9kVNGgrjm20ppbjckIo/MlMqTrgILjBEs=;
        b=JS8bOy7EggYVN9UM5RyEJ8+pYCGuihg+ByvHTWTPu8oI9RkmRa5R/XukDmNy62DcJ2
         d8QJLgrbVZC6IJ0oybyQHSUAjfYtmfxF0kImdQIATVmuJfWx1CEfw/DTXnfa7m46MX4r
         xm4P9cLWYWb7ChmP8BBNcnnlrTaZIlSilcg8svRWV7fxo4zHwCVY6aZBEgJsKCoxbgZA
         ks7DW5vVOrVepuTcCZyQsO5kMBKnGVRf0EjPi6u1nPMth8OQerMwZqAnw1w+lTVo+B6e
         2iceQUCvk/Ajab224+LHneCJQWYnKWJmfQp+F0VOLz8wveJk3hsKDTBXYiTjoXP08GYt
         PktA==
X-Forwarded-Encrypted: i=1; AJvYcCXjAgqz+3yJ5gh43sbuzrJBxIaGkArhBH9byojAKnJLDb/Wsco7bxARopQ7N4ymZ34kEgUUwL8kh5vNVPGRFyPGDFX0atKlLAq2jowjrRAB
X-Gm-Message-State: AOJu0YyHNAlR7VGg2m2p9yhIfbBBzk3X6i7P/b9RNPsnwyKyppTob2QU
	iqqZVvaEu5g2ShB9S4hPDI6eMKZI89nXWnvArWH2wCk8V4nIpb81x2KU6lIut+wCoAI3k8aJQXP
	N69DTwajq3SvviguEV28Q+VlvN/5A+x1m1kYLuw==
X-Google-Smtp-Source: AGHT+IEfpVJsvU7WBcCmWKZ766zMf2W1vFg3CfGq26NV2z3LZItXBni+z26AgIUQiZe5VcI3MHI3+sxbkskNV1l1l/8=
X-Received: by 2002:a25:aa67:0:b0:dce:9c23:eafc with SMTP id
 s94-20020a25aa67000000b00dce9c23eafcmr3080514ybi.1.1713968355690; Wed, 24 Apr
 2024 07:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org> <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org> <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org> <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
 <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com>
 <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com> <CACMJSev8=gBCw9o-ur87fMMj9K=ZWY-ECzxZjyvERYQ8P=VS7A@mail.gmail.com>
 <CABBYNZ+PvZb6azHoXAbO2czqK2zQnZ1ddcKRb_YX-zGSVfy+KQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+PvZb6azHoXAbO2czqK2zQnZ1ddcKRb_YX-zGSVfy+KQ@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 16:19:04 +0200
Message-ID: <CACMJSeue3kM-G1UvO0REEAJbhU9vOqbeEzy0Qny5udKLB97e8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	regressions@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 16:08, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Apr 24, 2024 at 10:00=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com> wro=
te:
> > >
> > > >>>
> > > >>> Please slow down here. Zijun's patch works and Bartosz's patch do=
es not.
> > > >>> I don't think Zijun means any ill intent. I am replying to Bartos=
z's
> > > >>> patch right now.
> > > >>
> > > >> Ok, that is great feedback, so I might be picking up the Zijun v7 =
set
> > > >> if we don't find any major problems with it.
> > > >>
> > > >
> > > > Luiz,
> > > >
> > > > Please consider my alternative[1] also tested by Wren. Zijun's usag=
e
> > > > of GPIO API is wrong.
> > > >
> > > why is it wrong ?
> > >
> >
> > I have already told you that at least three times. But whatever, let
> > me repeat again: gpiod_get_optional() returns NULL if the given GPIO
> > is not assigned to the device in question OR a pointer to a valid GPIO
> > descriptor. Anything else returned by it is an error and the driver
> > must abort probe().
>
> Ok, but there are other fixes on top of it:
>
> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-g=
it-send-email-quic_zijuhu@quicinc.com/
>
> I guess that could go in but it would really help if you guys could
> work together so we don't have more competing solutions.
>

These threads with their 7 patch versions from Zijun within 2 days or
so have become very chaotic. Let me summarize: there are two
regressions: one caused by my commit 6845667146a2 ("Bluetooth:
hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe") and a
second caused by Krzysztof's commit 272970be3dab ("Bluetooth: hci_qca:
Fix driver shutdown on closed serdev"). The patch I linked here is how
I propose to fix my regression only. These fixes don't seem to
conflict with one another.

We (Krzysztof and I) have provided feedback to Zijun but he refused to
address it and instead kept on resending his patches every couple
hours. Zijun's patch 1/2 proposed to revert my commit 6845667146a2. I
disagreed and proposed a way forward by fixing the regression. This
fix was incorrect as pointed out by Wren, so I submitted v2 which
works.

Bartosz
