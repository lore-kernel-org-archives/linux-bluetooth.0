Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B7C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB3E24248
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e11+uNVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKQWQY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQWQY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 17:16:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE9C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:16:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 7so31651291ejm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixPiRxkVkVKnN/17AmSUtHHj8gUl2ifYZ17k8XeoqqA=;
        b=e11+uNVllmJ5l3FsoykxEMYbqAnBV6uzkyAjiCLjQIT0/V/bB5GcZZU4IURPYq8BdU
         PXDW41Sb9RtL7KYyZvK0UQ7k5aOkPn4SQ73al85Nwk8wA9Ar/yxSzDkHSSFt/6Y4b9n9
         sL6sNRwFcmd6gDIDG/3Jv6p/xhfMW8mLDoZPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixPiRxkVkVKnN/17AmSUtHHj8gUl2ifYZ17k8XeoqqA=;
        b=HJ05rQvDuH52yOjHFDxxQXMyvSPSfdKJvfWn6Z/Of6Yr2Vxa+sM0EetzuruqUOqQxj
         2PvAuzq7HbhU7U7OjxLu0UXMxz9IwFOcMu4uNft52SuH32FzU2DkFnI+LpRblkn8Y27J
         cmOhvBMZiJNf4lKuggSM6/tVLUlIH8OT7iVHle0EOiUJwwl9qs9x/WJL74EwKOgn9P8m
         hcDUPByKUudVlHK84GkRMseu6muhs42/iuLz2/JHcOHIH0pfQa7RuH/RTgLJZxQe4c5B
         EXVQdV8iOsexGHCMB9tMfX78WgWw/F3zCh5tV/o4cNcWoS30buU3D5850CGVX3d2852q
         551A==
X-Gm-Message-State: AOAM531nc0Rv1tnK1ao2cUIBXgtlv40jw7XkEZpSueVLcnNW4znnky1I
        C/YUn7Pz388NYmJwuKoMZFy9AAQ6SGnC/A==
X-Google-Smtp-Source: ABdhPJzv/8XBKxQAjWarn/72NxZEzk7KWwILYyjW8yjTEwvIFsdr1N2VWZ9Q0aLx/1dBEmr6D25IzA==
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr21178816ejq.303.1605651382152;
        Tue, 17 Nov 2020 14:16:22 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id c4sm12125544ejx.9.2020.11.17.14.16.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:16:21 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id p8so25053676wrx.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:16:20 -0800 (PST)
X-Received: by 2002:adf:fd85:: with SMTP id d5mr1515025wrr.99.1605651380258;
 Tue, 17 Nov 2020 14:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
In-Reply-To: <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 Nov 2020 14:16:08 -0800
X-Gmail-Original-Message-ID: <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
Message-ID: <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

Thank you for the feedback. Please find my answers below.

On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> Hey Sonny,
>
> On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > This patch implements the BatteryProvider1 and
> > BatteryProviderManager1
> > API. This is a means for external clients to feed battery information
> > to
> > BlueZ if they handle some profile and can decode battery reporting.
> >
> > The battery information is then exposed externally via the existing
> > Battery1 interface. UI components can consume this API to display
> > Bluetooth peripherals' battery via a unified BlueZ API.
>
> Was this patch reviewed for potential security problems? From the top
> of my head, the possible problems would be:
> - I don't see any filters on which user could register battery
> providers, so on a multi user system, you could have a user logged in
> via SSH squatting all the battery providers, while the user "at the
> console" can't have their own providers. Also, what happens if the user
> at the console changes (fast user switching)?
> - It looks like battery providers don't check for paired, trusted or
> even connected devices, so I would be able to create nearly unbound
> number of battery providers depending on how big the cache for "seen"
> devices is.
For security, the API can be access-limited at D-Bus level using D-Bus
configuration files. For example, we can let only trusted UNIX users
as the callers for this API. This D-Bus config file would be
distribution-specific. In Chrome OS, for example, only the "audio" and
"power" users are allowed to call this API. This way we can make sure
that the callers do not abuse the API for denial-of-service kind of
attack.

>
> Given that the interface between upower and bluez is supposedly
> trusted, it might be good to ensure that there are no fuzzing problems
> on the bluez API side that could translate to causing problems in
> upower itself.
Could you give an example of what potential problems of upower can be
caused by communicating with BlueZ through this API?

>
> I didn't review the code in depth, but, having written this mechanism
> for Bluetooth battery reporting, I think that this is the right way to
> go to allow daemons like pulseaudio to report battery status.
>
> Cheers
>
