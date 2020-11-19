Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B82C56201
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6989222261
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gm7HkMk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKSUU2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKSUU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 15:20:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245EBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:20:27 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id q16so7177875edv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXKatq4ZfGtxqP0LCqZi4m0XQ7MmaQqVIzjDpgxeiO8=;
        b=Gm7HkMk8ps5r2wbLkKIXVONDxZ2/eA0bzXqypFP52pP0La0M/MaGQ543VN+LUTXwcV
         BcEotv2b9W/++P9SjuGjL+6nIDzY6a8YL/sGxg0LbR9ksBieVgqUlEvSGsNNkDkkv/uG
         x7ys99wMRzwVx8n3nawz/Tdmzyx/pTemzTrV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXKatq4ZfGtxqP0LCqZi4m0XQ7MmaQqVIzjDpgxeiO8=;
        b=SPK+VZFf4HMiy2qFMEV1t53hUZkf3yo1ZlQ+ZFQIMyi8lmYFdE+T3anJxTO626xHgI
         +RPGOA91zMGnRJ/hoeXr7ejT48vwekYZ1XjYNNO4KUuHp5Db0V4LFJqdnkzEhYwSsXQl
         p2Uq4NOAsbe1eDBxskEhMVlp38lqKswGuhOyV2gF8fMOgtvRsUSRF7SSjXyfwGuhp2Ch
         0PB5CaEcEQwW8e5ZMLH0uv+CQKrSkdjHqeg+DWgOYdrq8TuQylZVaofeFWStkijVsvgC
         OubT5DkS9dcLCGvP8NslTz0LXnFqbN8X6ZOIBTka4F5IjwB/hm1hNtXM6XECltdtvPbB
         6JcQ==
X-Gm-Message-State: AOAM530gEcf13+3+n6d0TnY+3i5PUsDkWdUfseVfDb/401+lSwClul3p
        B3ru5ivzeQjPjFQaxwHZIVvY9gSFe4aLFQ==
X-Google-Smtp-Source: ABdhPJyKWKzhXgiYKSjIMJwz/ZoPlhO20jvgVJQDEvcxSt1qwrQ6KFkZEXsixWdD6pUXZLaEFH8aDg==
X-Received: by 2002:aa7:da81:: with SMTP id q1mr32234123eds.14.1605817225527;
        Thu, 19 Nov 2020 12:20:25 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id oh19sm304829ejb.104.2020.11.19.12.20.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 12:20:24 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id c9so8368751wml.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:20:24 -0800 (PST)
X-Received: by 2002:a1c:7402:: with SMTP id p2mr6621583wmc.104.1605817224161;
 Thu, 19 Nov 2020 12:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com> <815b138fb849b56a5ec71045b54c86f99ed9df2c.camel@hadess.net>
In-Reply-To: <815b138fb849b56a5ec71045b54c86f99ed9df2c.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 19 Nov 2020 12:20:12 -0800
X-Gmail-Original-Message-ID: <CAO271mn-3qK6TqDUf2ua06EAN58K592ondrZjC-pt6byPQXG8Q@mail.gmail.com>
Message-ID: <CAO271mn-3qK6TqDUf2ua06EAN58K592ondrZjC-pt6byPQXG8Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Nov 19, 2020 at 2:44 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2020-11-17 at 14:16 -0800, Sonny Sasaka wrote:
> > Hi Bastien,
> >
> > Thank you for the feedback. Please find my answers below.
> >
> > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > Hey Sonny,
> > >
> > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > This patch implements the BatteryProvider1 and
> > > > BatteryProviderManager1
> > > > API. This is a means for external clients to feed battery
> > > > information
> > > > to
> > > > BlueZ if they handle some profile and can decode battery
> > > > reporting.
> > > >
> > > > The battery information is then exposed externally via the
> > > > existing
> > > > Battery1 interface. UI components can consume this API to display
> > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > >
> > > Was this patch reviewed for potential security problems? From the
> > > top
> > > of my head, the possible problems would be:
> > > - I don't see any filters on which user could register battery
> > > providers, so on a multi user system, you could have a user logged
> > > in
> > > via SSH squatting all the battery providers, while the user "at the
> > > console" can't have their own providers. Also, what happens if the
> > > user
> > > at the console changes (fast user switching)?
> > > - It looks like battery providers don't check for paired, trusted
> > > or
> > > even connected devices, so I would be able to create nearly unbound
> > > number of battery providers depending on how big the cache for
> > > "seen"
> > > devices is.
> > For security, the API can be access-limited at D-Bus level using D-
> > Bus
> > configuration files. For example, we can let only trusted UNIX users
> > as the callers for this API. This D-Bus config file would be
> > distribution-specific. In Chrome OS, for example, only the "audio"
> > and
> > "power" users are allowed to call this API. This way we can make sure
> > that the callers do not abuse the API for denial-of-service kind of
> > attack.
>
> That wouldn't solve it, the point is to avoid one user causing problems
> for another logged in user. If both users are in the audio group, which
> they'd likely be to be able to use the computer, they'd be able to
> cause problems to each other.

If I understand your case correctly, both users being in "audio" group
still won't allow them both to become battery providers because the
D-Bus policy only allows "audio" user and not "audio" group.


>
> >
> > >
> > > Given that the interface between upower and bluez is supposedly
> > > trusted, it might be good to ensure that there are no fuzzing
> > > problems
> > > on the bluez API side that could translate to causing problems in
> > > upower itself.
> > Could you give an example of what potential problems of upower can be
> > caused by communicating with BlueZ through this API?
>
> I haven't looked at the code in depth, but I would expect property
> types to be checked before being exported, rather than relying on the
> original dbus type matching the expected export type, this sort of
> thing.
Yes, the code does not just forward information. The code processes
the input and exports it as a clearly defined output type.
>
> >
> > >
> > > I didn't review the code in depth, but, having written this
> > > mechanism
> > > for Bluetooth battery reporting, I think that this is the right way
> > > to
> > > go to allow daemons like pulseaudio to report battery status.
> > >
> > > Cheers
> > >
>
>
