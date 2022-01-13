Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiAMHve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiAMHve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 02:51:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C020C06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:51:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso4280438wmj.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9Au63tSnVxGZPBOW/2rWGIC8jZbuuHsjm87gTkj+0E=;
        b=CFk/eN4C1Hi7m5nYDby5n7v6zpdPGKmN/Jzj8EBoIhl6lK7dB6hbINpOeq7uz1aL7u
         yM7EBdjOizK9p810oFNiXUf7SzRN5MfpdSeZ23+ddk5PrnYZ8VNlbIBz5U+hUDgfoiR/
         PHL9eri/1zkzSndCPZ1AaF/YjGzmRDnJtJOfn3jGhNIC8yCemWt6OEh3rFpCk6SCvJhh
         JhiT98hktFO384igS1lIJ1u/N1m6Xk+5DHErdYLJcHWZY9ZI/7FhgdjdY4Cw9/fZE5nQ
         FCCtTf32l65pmonF+3p1UUAPr+kRdui0WsEYlIU9RL0vSoFQREsqfDVwyXodV4X4UPxi
         smkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9Au63tSnVxGZPBOW/2rWGIC8jZbuuHsjm87gTkj+0E=;
        b=5SMvQKvH5G++xNBJosgXjlbKaYp7nZEaZoRaCfHo3wm9B72E0QBZsIKBT2Kor9YQ77
         wWZJXFnK46fx0JbYXM+yCQX9XWZUFesIJDxfkLdEky8m1Br3zg8V6AfYIdzfWW7/hgBz
         PLNZm8jnRwo3XGHnfcET3IdASJmyhzJ8wXhG0KqheLTMVzjtBKtrifNRQ9iDQbdKlVBE
         bmWLTNd/NOc1HORrwsupx4EG9pboJ0JqOnViLaZ4YrbeAEe+Rcrd3IgTqPbZr8xAIrs1
         i8c3DS00Y9sXFlhhBkjNozbITqrgRS+WIJ+ebJeJ/D1LvORXkjpqmzDmD9grCbvCt7sE
         s8Ew==
X-Gm-Message-State: AOAM532+xJL+eHr3ZGD2Pih2cVl4Ro5ILpB4w36+bYKZVYYo5s27EqAh
        9vQBoW6BUMTIeRJRlkV0jZx38W34nHIsojlBP4pSuA==
X-Google-Smtp-Source: ABdhPJzf1RLUZe64m8omKLxgmX8N8zYBWExZ0DIbTq9Jff/RYrQMvgLENYRd6w5z5QeiyMqqUm95LD2uaJhygbhoZLM=
X-Received: by 2002:a05:600c:4caa:: with SMTP id g42mr5678472wmp.60.1642060291656;
 Wed, 12 Jan 2022 23:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
 <2413B80E-E93D-49F1-849D-BAA899BAF832@holtmann.org>
In-Reply-To: <2413B80E-E93D-49F1-849D-BAA899BAF832@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 13 Jan 2022 15:51:20 +0800
Message-ID: <CAJQfnxHEG0pmsucfs+VOp67RvzVO9g1i1oHjdePGaqmcwo+9nA@mail.gmail.com>
Subject: Re: [Bluez PATCH] device: Fix device can't be scanned for 5 mins
 after reboot
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Shuo-Peng Liao <deanliao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 13 Jan 2022 at 15:05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > After the patches which limit the attempts of doing remote name
> > resolving, there's an issue which prevents BlueZ to RNR new devices
> > for 5 minutes after reboot. It's caused by failed_time is init to 0,
> > and is then treated as the timestamp when the device failed RNR.
> > However, actually there is no failure yet.
> >
> > This CL fixes it by always allowing RNR when failed_time = 0.
> >
> > Reviewed-by: Shuo-Peng Liao <deanliao@chromium.org>
> > ---
> >
> > src/device.c | 11 ++++++++---
> > 1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index f2447c478e..16b1ed5bd3 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -4487,10 +4487,15 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
> >
> >       clock_gettime(CLOCK_MONOTONIC, &now);
> >
> > -     /* If now < failed_time, it means the clock has somehow turned back,
> > -      * possibly because of system restart. Allow name request in this case.
> > +     /* Allow name request for any of these cases:
> > +      * (1) failed_time is empty (0). Meaning no prior failure.
> > +      * (2) now < failed_time. Meaning the clock has somehow turned back,
> > +      *     possibly because of system restart. Allow just to be safe.
> > +      * (3) now >= failed_time + name_request_retry_delay. Meaning the
> > +      *     period of not sending name request is over.
> >        */
> > -     return now.tv_sec < device->name_resolve_failed_time ||
> > +     return device->name_resolve_failed_time == 0 ||
> > +             now.tv_sec < device->name_resolve_failed_time ||
> >               now.tv_sec >= device->name_resolve_failed_time +
> >                                       btd_opts.name_request_retry_delay;
> > }
>
> I have the feeling this becomes complex and hard to follow. I appreciate the comment above, but just for thoughts, would it be better to do something like this:
>
>         /* failed_time is empty (0). Meaning no prior failure. */
>         if (device->name_..failed_time == 0)
>                 return true;
>
>         ..
>
>         return false;
>

I actually prefer your suggestion, this makes the code much easier to read.
However it's not a very common pattern I observe so I went with the
previous approach.

I have sent a v2 to separate the big if, please take a look.

Thanks,
Archie

> Regards
>
> Marcel
>
