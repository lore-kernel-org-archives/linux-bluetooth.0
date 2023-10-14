Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0ECDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJNSwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjJNSwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 14:52:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E1BF
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 11:52:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b6a7e0deeso1924576eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697309542; x=1697914342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elVqQSyfPhurBvWwTLp9j0YocoOf6qVQXNgOxgKYhpY=;
        b=DbZaRIByMk5yX6ToDjvcqJHluuHCD+UEcjLCGD7GgzRVV0FHh0FsXPVtjJjt3coLem
         Wr1e2Phv6do7mMiX8RcObkx2yU6CLvfUDUxqwZifVStssdhwVB8U2fd6FAiOwJnJvWUP
         9s0NvV8xElyLetAOItEM8E7cDd428hIXOEiei7id40wsKZtafQirGFXY5l4L5sDb/WAm
         qZCZdcoMOXgiwlP5jxFxSb23tBxj/Wa/WP3qF9tO8lebYqOZuHhwQFQ4RNq6fRtPwa3o
         PFkUZUwWO/Kn7EqxyTjuNR56q4+41H20j7cznTNwVpFUlZY8bflwwjtaXcogcjA5+oBS
         SmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697309542; x=1697914342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elVqQSyfPhurBvWwTLp9j0YocoOf6qVQXNgOxgKYhpY=;
        b=ohO2joXP71BdDt4QEXFz0QDZ1xX2LqPj/9vI3Oei8BvLjkgb60CPvQNKVKaK7XXK8s
         4ExXfIPWSYcaym3FuQ/felfo9nc7qB6asvrPpi/sfqO54v1C0GCuhz6/kmCm9W6yky/x
         wRfIKLPo/9HkCeGg2YYlMEvCDEvSwsKFM2lAk5NI+Ck5EcgUW/qVk3BDIE7lFUNvgmOU
         UJItr3WYjBSCV0yaYCsu+Efnrli+FcenEgRO5+4Gm/0tMOqNKur0qIt0WH5uOgUd5XY9
         F8aPeYCM2GgvTPpnvPMC+fdLdcSEj07DdNZ/AohHZeMjQfMqw9upyRPr1kR+8N+DW95M
         L36w==
X-Gm-Message-State: AOJu0YxDECGVmxOJpspR6lGzNtJMEZIOfzZUgJGM7zAVH9+84Dcujvtx
        iJVRRxhPFY+Eehry1ALpHfj9EW7RegRxAHlwWd876i0rllQ/xQ==
X-Google-Smtp-Source: AGHT+IHjQB0osprDfzcSNLCSaFJUaG1wo1xJ5wHnIxxYdtieykEn49j5Ad8HygToV/+1XM2/Lgtvk9jeGO7z/GEVGlc=
X-Received: by 2002:a05:6870:1356:b0:1e9:c1e3:beb4 with SMTP id
 22-20020a056870135600b001e9c1e3beb4mr6987360oac.31.1697309542366; Sat, 14 Oct
 2023 11:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com> <e706186e-e64f-490f-9162-11bfdc589619@molgen.mpg.de>
In-Reply-To: <e706186e-e64f-490f-9162-11bfdc589619@molgen.mpg.de>
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date:   Sat, 14 Oct 2023 20:52:11 +0200
Message-ID: <CAGFh026-11qh0jRQ5=NS4SmH7JQy7BfNwJh9N=bs-K-aVNba-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

> > Real BLE devices transmit LE advertisement report packages in given
> > intervals (typically in range between 20 ms and 10.24 s). With current
> > kernel module Bluetooth stack implementation it is possible that the
> > first LE meta packet just after enabling scanning will be lost. It is
> > not an issue for real devices, because more advertisement reports will
> > be delivered later (in given interval time).
> >
> > This patch changes optimistic implementation of sending only one LE
> > meta packets just after enabling scanning to sending LE meta packets
> > in 200 ms intervals. Such behavior will better emulate real HCI and
> > will workaround the issue of dropping the very first LE meta packet
> > by the kernel.
>
> Could you please describe your test setup? I guess you optimized the 200
> ms for your setup, and that is the reason you did not choose an even
> lower value like 100 ms?

No, it's not an optimization for my particular setup, but more
generally for CPU load. I thought that it might be better not to run
advertisement code too frequently. But I guess that lower values
should also be OK, e.g. 100 ms or 50 ms. There is one "issue" with
that, though.... Now, the advertisement packet will be sent one
interval after the advertisement was enabled. If that's indeed an
issue, it can be fixed by calling the callback function in the moment
when the timer is armed.

> > -static void le_set_ext_adv_enable_complete(struct btdev *btdev,
> > -                                             struct le_ext_adv *ext_adv)
> > +static bool ext_adv_broadcast(void *user_data)
> >   {
> > +     struct le_ext_adv *ext_adv = user_data;
> > +     struct btdev *btdev = ext_adv->dev;
>
> Are these used?
>
> Why rename the function?

In the previous implementation, the le_set_ext_adv_enable_complete()
function was called after advertisement was enabled in order to send
LE meta packages to devices which have enabled scanning. But this code
was run only once. I thought that we can reuse this logic to send LE
meta packages every interval time. That's why I've renamed this
function, so the name will be more descriptive (it's not enable
complete callback anymore). And in order to provide compatibility with
new sygnature, I've added ext_adv and btdev variables.

> >   static void scan_pa(struct btdev *dev, struct btdev *remote)
> >   {
> >       if (dev->le_pa_sync_handle != INV_HANDLE || !remote->le_pa_enable)
> > @@ -5440,7 +5411,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
> >               if (!btdev_list[i] || btdev_list[i] == dev)
> >                       continue;
> >
> > -             scan_ext_adv(dev, btdev_list[i]);
> >               scan_pa(dev, btdev_list[i]);
> >       }
>
> Excuse my ignorance, but the remove code is really not necessary anymore?

Maybe I will briefly describe the previous implementation. There are
two possible cases for sending and receiving advertisements: a) device
A (B, C, ...) enables advertisement and then device Z enables
scanning; b) device Z enables scanning and then other devices enable
advertisement. So, in previous implementation, the LE meta packets
have been sent to devices with enabled scanning from devices which
have enabled advertisement either when the scan was enabled (in device
Z) or when the advertisement was enabled (in device A, B, C ...). The
removed code corresponds to the case of enabling scanning. It's not
required any more, because now advertising is governed by the devices
A, B, C by running advertisement logic every interval time (in the
original patch, every 200 ms, but that can be changed to lover
values).

To be honest I'm not sure what about scan_pa(). Maybe that logic
should also be moved to some timer callback and should be governed by
the A, C, B, ... devices? I would have to read more about sync in the
BLE spec.

Regards,
Arek
