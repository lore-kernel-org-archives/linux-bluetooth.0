Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FC83B42DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747452; cv=none; b=dtYUuSjizhoztjx/YAj1HDlSs8Deddx7zCQVgiwO2eXiPjCvoiXpQYEqsVz0EFKY2LmsNdPNnSlN4fbMQEc1upeqH12Zpt74e6MJhLKxhI5qfKB82lcIMYxnFdNMzyaJUgvidyMq3R40TnqYmJAyxugWO8wqYl4NzJ0+YqTHm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747452; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBP72CoqzcMKhT5J6QDBBM44tzXDSP82KLTeak1qQJaTqZOnquj/ZcdIBYVFWor7SaKoX0Eg7fUN42OU6kd1PEqZIZlXU6x11lA8Oz+gLt4tYprXUKLUvk4zwtVm4qkykytV4W+ewiq9dcCHcK2nBZZMq9OPgaKXIuQoP4fH2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6687910a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747449; x=1783352249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=nifhDPBcFzd3Zi95v2dDI56wakI6FxAIZDkgne4BO9NBKYBQRw2mEpE3apamNK8Byz
         Q6SV5FJwJXNaJSoaYNcvKdKcedJlEiG8uCH1dJJ6geVVsp21AlOCEbG71hqVtS1iE4F/
         CbliLzr5pf+jS9Cns7yWihL6NvgW4bzXT4SJWylR6Sip6c73zMQdQ0ns8bF5pfUtBJ0G
         TVz+NACOM/skzkXlw/ViLgY6kYI0j/TIpBV2Mip4dAhdlS3ha738tQnBkmyVIwU0xdxa
         gT53cu+pL7DFlJTzsc/EdKK9f50fGYFcZvHNbQEqJYqguBoLxZNXT5SFtJGlDloDtwf5
         HjHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq74PonOgAH86h5lem/QKz0Msq6v2Lhsf6lzoeR8gxg/OZ252SePR2RgUJAXggXBY/7mkS+RgkZxjdkY7YW6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1lpzQHSTfik1FapZoADXV4SnxUQy7rYyWzfoZ3g2Jq6FkCSp
	gCvgRQwoXOF/yVnB75ueANWy4ypp4VdEWHS7nPE4Jd34x4e9PcSQIdPjGZntZAN05dc=
X-Gm-Gg: AfdE7cl8bS1Cuw2gimaq0dRqv3l5Zh4rndRtHRE5TsKL7CQ5dCV/QZSokZrRtLLPTHQ
	+m9SuCJsYQ6SFNWcwWH6pZK4LrjRFAsDjD1ijAgWsZaaB4+yJ/JI9+EhP4yhv96oLgV4MbZUmrx
	xpF2nX0kS+V5ctB74f4BISvDT054oTt0I+C0hz2sQ5CmlozfAhUNaMffgkjzJtaiXNuhuc1vHYP
	aabM1N8vy5S/iz2jnIxubfRFGWjHHPWQz7xrhhH6MEU9wxlDtnqyllAGokV+27Mwk7Qq9ONpj+O
	AhSV1XqUgbYz58/oNXxxXkDDzWrreSqAqSKs3OxW/4zI6eA+5tCnawJXsMBYPpbzRJF2WqUZH0n
	OVlwxlhRNKNwf+WD4s9SDz9w5JUeO7U9OIMiKES/kZSlbK81sLLrwQRMrlJe2vZxjblV/GvuDjC
	TcJlX2jvftU6N9Ee//65JUOG1fPSLZdgDvIYkUjXl1R6i0mhOZxw==
X-Received: by 2002:a17:907:969f:b0:bee:ac9b:9abc with SMTP id a640c23a62f3a-c1205ea96b2mr883157066b.22.1782747449333;
        Mon, 29 Jun 2026 08:37:29 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbaa46asm807946966b.10.2026.06.29.08.37.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:37:29 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b68b4643so3539165e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:37:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81E1M6ULNaikI6QvUY8sD+F5g6pUMtBJPzP+Sc6qTpKxim7YvTA2+nV9h9IpA7y0jUNdCcwwtH8wlVOkkzZNw=@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
