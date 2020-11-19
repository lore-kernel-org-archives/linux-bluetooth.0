Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437AC388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C247422268
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8P0t6Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgKSUPp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKSUPp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 15:15:45 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4AC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:15:43 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lv15so3866875ejb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4YDXXNB29dy2L3aUm2jHY+iN9AruGRMeqSpuAZ56R8=;
        b=H8P0t6MzB3wg4hO1fsrJ2lePMArKiUgIL2myroxnCAsELWKvKO6tJNR1dowj2PDYlF
         3s73fBTInFZ+sgDb6Jh2R+moUGkr+YqBQORSzQFjOqfMERN1oxQIzLytX0LtYeQRz74E
         gHH0hK2qDNumFUjjOFW3zKywkUmunXuNVOcxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4YDXXNB29dy2L3aUm2jHY+iN9AruGRMeqSpuAZ56R8=;
        b=Fm6dALdfSx1B3May6fGgcqMPJqx9oWcPurwRwQnmXJfXJQ/Rewm7ixc4T7LETDsv93
         OAVc2rgzkE8DkZajo3CxnIhqDlIkq3a4eKK23a+PCot2v5H3iSgB5LMVRRba3u75TsVb
         CAPOtADPK24zGdeUIM5NXQJ1jZttuQi9EQziHgHTtjIYjG+FJ8XhjFUU0JdwDYd79JuL
         MZF5BQHZTDX5lIX6D/r76b59oClGrX9HlvMMDkmQ7m2mWlnXh9q1ZETuIeueuWrviiK7
         hcRKSs/PqAB0lAk4lyb6OtRS5yPzyuo/GRGO4tNBO84vM9teoKd50avta39kIeXibpxp
         nfhw==
X-Gm-Message-State: AOAM531/QY+VJA+t4vLOd4K1fvBKrLmxc1/kDXkCnuDxJYpzmVX5Zc+f
        uj4kFj8ihu9rM+psOgYdS299S85INyAfhg==
X-Google-Smtp-Source: ABdhPJxAuBKXKIgGxq+ONRHzml3lDaOdrpE9DqrOYfaLhCGBbuV8KQHmg7KmartxKFeA78biwdsM6w==
X-Received: by 2002:a17:906:86cc:: with SMTP id j12mr19038988ejy.174.1605816941379;
        Thu, 19 Nov 2020 12:15:41 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id j9sm294826ejf.105.2020.11.19.12.15.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 12:15:40 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id p1so7726689wrf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:15:40 -0800 (PST)
X-Received: by 2002:adf:9d84:: with SMTP id p4mr12201565wre.370.1605816939762;
 Thu, 19 Nov 2020 12:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com> <CABBYNZJjgdjsDXOQk=v4wJ7PLyHr-u2w6d+jgLKgwxV9J5OYdQ@mail.gmail.com>
In-Reply-To: <CABBYNZJjgdjsDXOQk=v4wJ7PLyHr-u2w6d+jgLKgwxV9J5OYdQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 19 Nov 2020 12:15:28 -0800
X-Gmail-Original-Message-ID: <CAO271m=L8yoD0JO70kVJqmH0+gBkCL=_dtpTKNDZ7ei5jfPz6w@mail.gmail.com>
Message-ID: <CAO271m=L8yoD0JO70kVJqmH0+gBkCL=_dtpTKNDZ7ei5jfPz6w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, Nov 17, 2020 at 2:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Nov 17, 2020 at 2:20 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Bastien,
> >
> > Thank you for the feedback. Please find my answers below.
> >
> > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera <hadess@hadess.net> wrote:
> > >
> > > Hey Sonny,
> > >
> > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > This patch implements the BatteryProvider1 and
> > > > BatteryProviderManager1
> > > > API. This is a means for external clients to feed battery information
> > > > to
> > > > BlueZ if they handle some profile and can decode battery reporting.
> > > >
> > > > The battery information is then exposed externally via the existing
> > > > Battery1 interface. UI components can consume this API to display
> > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > >
> > > Was this patch reviewed for potential security problems? From the top
> > > of my head, the possible problems would be:
> > > - I don't see any filters on which user could register battery
> > > providers, so on a multi user system, you could have a user logged in
> > > via SSH squatting all the battery providers, while the user "at the
> > > console" can't have their own providers. Also, what happens if the user
> > > at the console changes (fast user switching)?
> > > - It looks like battery providers don't check for paired, trusted or
> > > even connected devices, so I would be able to create nearly unbound
> > > number of battery providers depending on how big the cache for "seen"
> > > devices is.
> > For security, the API can be access-limited at D-Bus level using D-Bus
> > configuration files. For example, we can let only trusted UNIX users
> > as the callers for this API. This D-Bus config file would be
> > distribution-specific. In Chrome OS, for example, only the "audio" and
> > "power" users are allowed to call this API. This way we can make sure
> > that the callers do not abuse the API for denial-of-service kind of
> > attack.
>
> I guess there is still some the risk of conflicts even with the use of
> D-Bus policy blocking roge applications, there could still be multiple
> entities providing the battery status from the same source, which is
> why I suggested we couple the Battery1 with the Profile1, so only the
> entity that has registered to handle let say HFP can provide a battery
> status and we automatically deduce the source is from HFP.

These are two different issues. The issue with bad applications can be
overcome with D-Bus policy. The issue with multiple providers is
inherent: we have to have a duplicate resolution because one device
may report battery from different sources, e.g. via HFP and A2DP at
the same time. The latter case is rare in practice but still possible,
so I propose the simplest duplication resolution which is accept the
first provider registered (of that specific device) and ignore the
rest.

Coupling Battery1 with Profile1 will limit the flexibility of this
feature. For example, some speakers report battery status via a
separate LE channel (GATT). If we require Battery provider to be also
a registered Profile, we won't be able to support these cases since
GATT clients do not register any profile.


>
> > >
> > > Given that the interface between upower and bluez is supposedly
> > > trusted, it might be good to ensure that there are no fuzzing problems
> > > on the bluez API side that could translate to causing problems in
> > > upower itself.
> > Could you give an example of what potential problems of upower can be
> > caused by communicating with BlueZ through this API?
> >
> > >
> > > I didn't review the code in depth, but, having written this mechanism
> > > for Bluetooth battery reporting, I think that this is the right way to
> > > go to allow daemons like pulseaudio to report battery status.
> > >
> > > Cheers
> > >
>
>
>
> --
> Luiz Augusto von Dentz
