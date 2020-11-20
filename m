Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C98C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D97221EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VjOTpwja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKTUdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbgKTUdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:33:32 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC297C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:33:31 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q16so10825472edv.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la4Ldawr3vNkw+cC8CvlJU3F9whvbCsCeBXqgl2pVpY=;
        b=VjOTpwjadZMZSWPKR9FgWUOra/vTTciwjZbPYfoSsJPLWVwuHA8FNxsaRaWqo9hkU8
         jastj/ZaJKZH+EkOVCro2nGjC8RjEL4bUE0jAMzgY7wnPlkx/Fkofp0fh8WeULetDaHt
         CFgAPl2KRayOOh7P0nU7l9akjPfJn/tVkX8bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la4Ldawr3vNkw+cC8CvlJU3F9whvbCsCeBXqgl2pVpY=;
        b=Cw8tV6NE1DqzrFGyoT9CCaRWci6R0ARtw75EnfImuKcKbxXKHiNtFMamVjPQwoQWr6
         MdVd3rAHaN7pVP41S5hRWGjd3kXSShSa4fd0FewHJ5mLDOMCscFIRe4ZAUojYKLWH1XF
         +JvlwA+3tMV11QSeafuf7fQVK26geMgUrzJukGhzFW9UcNxOz719deKVu3F9aUoCPRwF
         jtLhAw/ylAuaZwB/TGM5iVYNlVAVrJE0+u6KS4/g9Q4WnjL6T/8Q4xGV3wmp0F5DxfXa
         /I2SUQuken2oE+1z0iL6r2itSIwmEmKknn+4nqXJk21O78wSSeU9Hwddn6tjndg8smfx
         aBXg==
X-Gm-Message-State: AOAM533gFoJ8vg9Tc3hjnQOE4JzSptIO/TqUXamwp8kyZ5BjzdstdDTg
        nfN3xTaQ0DFP6e2L30Mu9kF6R3Mq59JocA==
X-Google-Smtp-Source: ABdhPJxSroxSW+W/UPcKisRPNUpfkSg73NL4Ko1h0kOWtLv5gPf0JRB3tsf5ik2ry+SpcNNU9THa8w==
X-Received: by 2002:a50:bb26:: with SMTP id y35mr26095778ede.257.1605904409781;
        Fri, 20 Nov 2020 12:33:29 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id rp13sm1532691ejb.79.2020.11.20.12.33.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:33:28 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id h21so11007171wmb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:33:28 -0800 (PST)
X-Received: by 2002:a1c:6306:: with SMTP id x6mr11536936wmb.154.1605904407953;
 Fri, 20 Nov 2020 12:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
 <CABBYNZJjgdjsDXOQk=v4wJ7PLyHr-u2w6d+jgLKgwxV9J5OYdQ@mail.gmail.com>
 <CAO271m=L8yoD0JO70kVJqmH0+gBkCL=_dtpTKNDZ7ei5jfPz6w@mail.gmail.com> <CABBYNZ+FBdCzqqcOuaKou-A5S_QCZsgHvj0ygyZP3L3v90L_8A@mail.gmail.com>
In-Reply-To: <CABBYNZ+FBdCzqqcOuaKou-A5S_QCZsgHvj0ygyZP3L3v90L_8A@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 20 Nov 2020 12:33:16 -0800
X-Gmail-Original-Message-ID: <CAO271mkGiN=qZozt9+yUAnqtz35GpkSWbW9A9pWicMSx6d3ZLw@mail.gmail.com>
Message-ID: <CAO271mkGiN=qZozt9+yUAnqtz35GpkSWbW9A9pWicMSx6d3ZLw@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 3:56 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Nov 19, 2020 at 12:15 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> >
> > On Tue, Nov 17, 2020 at 2:26 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Tue, Nov 17, 2020 at 2:20 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Hi Bastien,
> > > >
> > > > Thank you for the feedback. Please find my answers below.
> > > >
> > > > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera <hadess@hadess.net> wrote:
> > > > >
> > > > > Hey Sonny,
> > > > >
> > > > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > > > This patch implements the BatteryProvider1 and
> > > > > > BatteryProviderManager1
> > > > > > API. This is a means for external clients to feed battery information
> > > > > > to
> > > > > > BlueZ if they handle some profile and can decode battery reporting.
> > > > > >
> > > > > > The battery information is then exposed externally via the existing
> > > > > > Battery1 interface. UI components can consume this API to display
> > > > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > > > >
> > > > > Was this patch reviewed for potential security problems? From the top
> > > > > of my head, the possible problems would be:
> > > > > - I don't see any filters on which user could register battery
> > > > > providers, so on a multi user system, you could have a user logged in
> > > > > via SSH squatting all the battery providers, while the user "at the
> > > > > console" can't have their own providers. Also, what happens if the user
> > > > > at the console changes (fast user switching)?
> > > > > - It looks like battery providers don't check for paired, trusted or
> > > > > even connected devices, so I would be able to create nearly unbound
> > > > > number of battery providers depending on how big the cache for "seen"
> > > > > devices is.
> > > > For security, the API can be access-limited at D-Bus level using D-Bus
> > > > configuration files. For example, we can let only trusted UNIX users
> > > > as the callers for this API. This D-Bus config file would be
> > > > distribution-specific. In Chrome OS, for example, only the "audio" and
> > > > "power" users are allowed to call this API. This way we can make sure
> > > > that the callers do not abuse the API for denial-of-service kind of
> > > > attack.
> > >
> > > I guess there is still some the risk of conflicts even with the use of
> > > D-Bus policy blocking roge applications, there could still be multiple
> > > entities providing the battery status from the same source, which is
> > > why I suggested we couple the Battery1 with the Profile1, so only the
> > > entity that has registered to handle let say HFP can provide a battery
> > > status and we automatically deduce the source is from HFP.
> >
> > These are two different issues. The issue with bad applications can be
> > overcome with D-Bus policy. The issue with multiple providers is
> > inherent: we have to have a duplicate resolution because one device
> > may report battery from different sources, e.g. via HFP and A2DP at
> > the same time. The latter case is rare in practice but still possible,
> > so I propose the simplest duplication resolution which is accept the
> > first provider registered (of that specific device) and ignore the
> > rest.
> >
> > Coupling Battery1 with Profile1 will limit the flexibility of this
> > feature. For example, some speakers report battery status via a
> > separate LE channel (GATT). If we require Battery provider to be also
> > a registered Profile, we won't be able to support these cases since
> > GATT clients do not register any profile.
>
> Actually it is a good policy to provide GattProfile1 if you are
> interested in enabling auto-connect, which I suppose most third-party
> services would like to enable:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n367
>
> Note that we are doing to avoid complicate conflict resolution since
> profiles by design can only be registered once that means Battery
> sources will also be limited to one per profile, Im fine if you choose
> not to have this integration in the first version .
Thanks, Luiz. I will proceed without profile integration in the first
iteration, since battery sources will be limited to one per profile
anyway.

>
> >
> > >
> > > > >
> > > > > Given that the interface between upower and bluez is supposedly
> > > > > trusted, it might be good to ensure that there are no fuzzing problems
> > > > > on the bluez API side that could translate to causing problems in
> > > > > upower itself.
> > > > Could you give an example of what potential problems of upower can be
> > > > caused by communicating with BlueZ through this API?
> > > >
> > > > >
> > > > > I didn't review the code in depth, but, having written this mechanism
> > > > > for Bluetooth battery reporting, I think that this is the right way to
> > > > > go to allow daemons like pulseaudio to report battery status.
> > > > >
> > > > > Cheers
> > > > >
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
