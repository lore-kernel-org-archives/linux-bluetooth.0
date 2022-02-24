Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 08:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiBXIRg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBXIRe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 03:17:34 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78F427F1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:17:04 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e140so2274512ybh.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7lNbImV3Z10ZjXcudhZazLv+AgZ55szaYV4Qs5t+7U=;
        b=GEEs/CQk895WuURbHz2ywOidmKSr0Ijokt//oWrBv2E62vDbTQhRYLZe5jsDx355I9
         gcehldSJnuIx5Ajn2yXrUewxC+ZYc8O5z5Tl0mL8YPIO8kxF/DuWY3/0weSsCMAMeE8B
         slCH+2XRYfqX22P7ljs+pqHxJv4afi04YESe7uhCpQRXIpA+lQy5OF0/DLfg/lAP93O9
         tNqxu6aZ3NcTbPVSv/6qs3lleh0z2o1fyVk0WDCNVGCF4AqKYJ2V9YgxA7p3RK9mbloT
         /qpZqnRRO2QO/Hmod6yrfavt3rreyBm1/qkmB05sMbnhwRjERoNoXs00HlKt72OVlh+f
         xP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7lNbImV3Z10ZjXcudhZazLv+AgZ55szaYV4Qs5t+7U=;
        b=184UzMNdwiwO2pEWHCYUuw4uGMC7nt+jsphFeJ0CU6pQkl3UvUMdtKZUl3ijGLuhQh
         gN7so4yfQf0vn4dyJH7q9Oc5qigJ9WP27jw6cP9KZADRfGT8A2OPSoFzoKSRD51Eb4Gx
         mFfED41sWMKYimdwQAjGXpAmJnfhQI9k8CM9VY/TVSa9Ij7kpAvSLt+83YvXhv+7xCg6
         ICeOL2G+rNIAqmDCggxyhYoqCoGauW4qe4EtwmCGLqcrwu2SW8EyfvAXvzX/ET58+tg0
         yX54qm2KBVhqOU+zNOIolJXJ28t+HhcLnXrQWSQ1zHBpes2aJgiSSKD/ntiQUF81It+D
         BxJA==
X-Gm-Message-State: AOAM5336uQn+ZwHCRt04SbJLBko3KHj/LJEfuuSIFX82bvjpHE0uWKHd
        VC2q3on7C/oVtnfCfT5dESJT2fy9nmduXpcTJzciKFNot90=
X-Google-Smtp-Source: ABdhPJyo1POtN6OaSXhvOsD45xS5qgmaoF/mqOz2cN0Ck2aGeIFigSzUdLIS1HMreewARC8W50j2V+FUo8pIb0Uwg1o=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr1425929ybo.578.1645690623295; Thu, 24
 Feb 2022 00:17:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
 <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com> <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com> <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com> <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com> <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
In-Reply-To: <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Feb 2022 00:16:52 -0800
Message-ID: <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Wed, Feb 23, 2022 at 9:59 PM Chris Clayton <chris2553@googlemail.com> wrote:
>
>
>
> On 23/02/2022 22:42, Chris Clayton wrote:
> > Hi.
> >
> > <snip>
> >
> >>
> >> We are starting to suspect this is not a new issue, it just become
> >> easier to reproduce with newer kernels since the mgmt commands are now
> >> handled by a different work/thread which probably takes longer to
> >> respond hitting problems such as:
> >>
> >> https://github.com/bluez/bluez/issues/275#issuecomment-1020608282
> >>
> >> This has been fixed by:
> >>
> >> https://github.com/bluez/bluez/commit/faad125c5505b941f06c54525616e192a6369208
> >> https://github.com/bluez/bluez/commit/5f378404bff6bbfea3f20e36535c494efa5066a5
> >>
> >
> > I cloned bluez, but that FTBFS, so I applied the two patches by hand.
> >
> > After the first boot, my bluetooth devices connected fine. But after a poweroff and boot, they didn't. Nor did they on
> > the third and fourth boots, so the patches don't seem to be the answer. (They couldn't really be anyway because changes
> > to the kernel have broken user-space which I understand is a big no no unless there is a really compelling reason.)
> >
> > I've gathered some diagnostics today and they are attached. They consist of 6 files containing the output from btmon and
> > dmesg and the log file for the system daemons, which, of course, includes bluetoothd. There are 2 sets of these files -
> > one from a boot that resulted in a system where my devices would not connect and another from a boot where they could
>
> s/would not connect and another/would connect and another/
>
> > not connect. You'll note that the btmon log is empty for a failed connection.
> >
> > I also tried a bisection with v5.16 as good and v5.17-rc1 as bad. Unfortunately, I found several steps resulted in a
> > kernel where bluetooth seemed to be substantially borked - to the extent that blueman was non-functional and clicking on
> > the tray icon did not start up the blueman-manager application.

Running with 5.17.0-0.rc5.102.fc37.x86_64 there doesn't seem to be any
problems, well apart from LE device with Privacy/RPA:

https://gist.github.com/Vudentz/5792f4989198c7f2994af2e31eb973af

Ive tried suspend/resume a couple of times just to see if there is
something odd going own, anyway I'm running with the latest userspace
so perhaps I really need some old userspace to reproduce this. There
might be something with name resolving though, it appears gnome don't
show devices if they don't have a proper name (that is not their
address) so perhaps that gives the impression there is nothing going
on when in fact that all normal, well apart from the fact that names
takes way too long to be resolved.

> > I also booted into a 5.16.10 kernel and connecting bluetooth devices worked flawlessly. (This was with the unpatched
> > bluez daemon)
> >
> > Chris
> >> So the timer doesn't start until the request is sent. but obvoiusly
> >> older versions of userspace don't have that fix so they end up
> >> cancelling the loading of LTKs, this would explain why reloading the
> >> daemon would make it work again.



-- 
Luiz Augusto von Dentz
