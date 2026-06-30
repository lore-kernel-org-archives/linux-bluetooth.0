Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B202F1FD0
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835298; cv=none; b=KtsHHn7jIRAmiXPiYszt7skas758D9uQX8FHKE0l2xNNqzZgr9j/eyqaWCCjkxrWSFkQQM7zxn7wFPGX/hBxCfFpll81erFG4L+u6VM3KxCn/KbjuN3s6AOlbK3LDJ0ShrBffoV8y4BdlYWjgPSvEy6gXUHbgwr3t84iZqSrScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835298; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSTFL0Irx4KfUs0XrnmkzWNVn1epZFZBnA+Ho3K/gNqh3Bybn69X/Z0cjo2CwjwFfTIt8dJKVp2VNVTXCDwJogzDquXKF2uG0OZCu/PZZSH+okjljIBBuZq7CSpUfK4WZIqoGtSyLbJjdHHtymItZzBnk6+FFgy2Nja/+y4jqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9696319e14dso473641241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 09:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835293; x=1783440093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=DKvVmypykib5iFMymM8W1coESGPL3WJI0ifHOLrIiaJmDw1SJSEzuxHVIru2hH3SlU
         tgG21tFjxiCP2bIFhICJGPj7yTlE2e47WEWVlNzYqcOwcyalTo81XAfOmOCiqTU2hZBs
         //zumZDfmOnKrYZiKSt7T6Yk/OGs2iNCNqP/k9XqeadLObdRMQB+x6px3Oe3yogRh4mf
         mlWAhblujuNYN7ZinLwZPdsNcMRyyNMuTDnBv0iBoQrXflV4GMMJ7SjcWjIub402xLgO
         hQxqqjow4YdHAnxzqWHcs/iZzaAr36E7ZMmtmG245/yAZaWLKb8v+/cVZwcdXXSxG8pW
         aqnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8mYkI0zXTwbMVQFXk7lftCiDqrsQtaI60tkaAdH393h7cjFqIp8whSW2R1leceLT13MApBwioDoGNw75YZCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAi4Q+IcxbS827NUH1kidMw4VuX4om44PIcY56wt4bKenmE5/v
	G45wpktRv/MIAAes4eTnVLwbUTtVeUdUfWFvXGk1lXeKrbNdZKPv+BEukHXcyGvqSN8=
X-Gm-Gg: AfdE7clo+7Owv9HJdD8efnv8niJ12+yOWIEG7Jc9qPh4QJZd2YlyiX05VFtmHEcgFLB
	k7oE5ljty/L6KZ3deSxz1fIkmXe3BElEBLaR31XpvkrUcrd8mq5rDlXPLJ7OIivEkKvP8vlcGKJ
	vzqidQfq7JkK7KPvwT+l7lZ1y34pOMPO5Cn+BGxAe86x4gh72EBxcmzVJ0/wvqaPs0euI0PTgk5
	y4+HAorRIiUVzx/pQH20micgwkYNG3ungX+KyIwjfnBBZsox3PU7TveU79SqasYiiuqrT18jJht
	cnmgsmpkqrf8Ggb/QAOdvV0T70DQIEh2ANtJOx9mZsNYZM61ED3i6kpNQ8gI+yIsaPTEX3Wbbj/
	z4624M8MDOMDGqX6aAnGN3aatD4QjByWEZzy68zFQNy3hFEl+x2aJuV9tAP80ppeTSWAlVlRd5M
	8F3eLGxvLZ18dvfH79vdoKepmVcfqxrCByhpy7w2oUFB0nJjzB7w==
X-Received: by 2002:a05:6102:598c:b0:738:befe:8f7e with SMTP id ada2fe7eead31-73a369e7be7mr1804678137.11.1782835282006;
        Tue, 30 Jun 2026 09:01:22 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-969668c59a7sm1137014241.11.2026.06.30.09.01.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso569429241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoRGUUyKVU8EECYIAD/9IskHmFfa+JMqIyfDOILzs8MBk0RUzwYaft+SJ9r+izXLo0BPTu3duPy7wG0yWV+2og=@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
