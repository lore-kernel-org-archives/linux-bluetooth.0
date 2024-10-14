Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED81474A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895031; cv=none; b=uhi8tc+zKKD87vJSt6h489PEQWO+A6WUNpJPBYLi1s8pyb73KERJyIubV343IIFpJJ6DiR8Z1zegRM5HJDGao2Uyl+ViizpZ8sG8kP/s/Su1ULH+va3HyUKT3pTE80GIxNCp3AjoTO+gx04KELAqUdYBPtDUdl/yHNB5PEzaWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895031; c=relaxed/simple;
	bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJTFeFr5E0GyhAol8xxfu6jOxyyEsu9Bb3ZtjbxNVf5AvcOKPp/sL+DRlLan8EswW2yGyJWG4b0AwKAX22mh4PcBTA2K9F8QEkdhBf4HtDopckylsDgKbsacsLLKENP61jf0KOnE1nlWnsmqCoBAMCRRpQ9a/82ELLE1Pi3pKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iTmhk7/q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iTmhk7/q"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1540447e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728895028; x=1729499828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
        b=iTmhk7/qw81o6OQdTc7Vd8tni5SBMVU4JIFFKqX8BgQgjS/QJJzYlF2mEsL9MVg8Kp
         E0MdPULACVh1nqjT+qtnOCeo8yfpluY9HhLSvepcdhFvD0N8m0wwbkqkeoJO41rZ3EQA
         D+yygDRAztGdigjPeMdzCTKsLjTbdtEZxwpcBl4Akbyp3X5QPRgtIWOVOKIic0w0GFLz
         Lqd7uNj1wepPvrp5JDQItPsVwlLmYRxgmQqDiOnh1MAtOSFpT1gynQoP9xMGaufXz/wE
         2V66pSYAq0GO92WRBi73GX8wV/8A4kIJLlHHwZiXM6hFJSbe+FuvpTRzjmkHsWypeaVH
         9z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895028; x=1729499828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
        b=awMtCEdk2Z1pwaS8lRMnn/KZf2jhDr7WOhtIuOuku5NbeDn7OWtxI+s4eZqXuLsqjZ
         z0tr/MT+p8jKPZByc8ZPK1Dcr80MMQyvwrQ+T9U2VAWz00E65u+VkLJIXAYkj5EJ7G+R
         gSDJaTYkn9aRPgsxJ9bEwWPQVG9nZjuMo6ZkLlgwSnRzIzGRgd37Aw4ChAlB4l2UVd2P
         PJuoFbnqMqvtMbcngc9ro3bnsvsUQ0/osMOfmILp+xvu+N93Fdfh1HHMX2SmgQXFDoep
         oh9+j5qi8D1m5mjERM1RTKL/HvP0Vrr2f0IJJ92i845TSjdzuqEXtEqoiHsdb8dD3Qeg
         4MJw==
X-Gm-Message-State: AOJu0Ywa6PTQMR3LcD7Q9tPTFBIq3b5HDhEUKCc1lPgvyuXmDJ9henC8
	hpbN3UqSJTyv0x18oQ8bkPN4ZvGqkA0ywkYMQyq48S1AuWtLTZ7CUqM+4MmAtiEvEQF5/QwsBEx
	4UcUUkDLpY3nHMwwzdLqKz+8gjcAHEGa8RVLiFg==
X-Google-Smtp-Source: AGHT+IGmwX4RUF9yi5GZQf3FK7ogVT2hx77a4BAjx/AyRr9zcJ5FNCqQj6Ns4j4UPtygQNm1AUkTia8xfUs9MVDiPKE=
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr5336025e87.13.1728895027606; Mon, 14 Oct 2024
 01:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930080938.12505-1-brgl@bgdev.pl>
In-Reply-To: <20240930080938.12505-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:36:56 +0200
Message-ID: <CAMRc=Mew5uRyWZvtv75MWRKxqgb7qbyrYxQd9hXZ4-b0ZHGo_g@mail.gmail.com>
Subject: Re: [RESEND PATCH] Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
> shrink the code a bit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

It's been two weeks, gentle ping.

Bart
