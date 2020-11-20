Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10478C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84A422264
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBAd7LL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgKTTlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgKTTlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 14:41:45 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5B4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 11:41:44 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id y17so14435007ejh.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v1z89IytSxRjRKfyLg9LCbsQmX2FG1EP4QiyfjgDEA=;
        b=oBAd7LL5gCU3K1CgvDmJCvqpujlOzAHTsNHCvaKMxBeMrCpX5LxSe2KdxDK4jH7csR
         ST8xArlYQ+0saThs44Lidi0Y1Pic3UbtKD6dQrjAarypkNmmUCHO4bcsCXBxOlu3L7fc
         RjNu24X4GAY89dCeWeozzFbaC359UveGX1Olc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v1z89IytSxRjRKfyLg9LCbsQmX2FG1EP4QiyfjgDEA=;
        b=nyqorEJSHrcRK5/920sBf+U2aw07ZGy0KiXT4DoIme0CKMNovJy/b5ecbQPHd/huJu
         HizfA5b6dF0Z1qNdEYUxNyJhxg9qwfc2rawJpCEVZKt1vehlgXuDgpRRH9fFWpyfpBRU
         WSUpdf1pk8Jh1SCkGycKx5CnIURW+Cn4G23xgc5HolkdkPxTKf9I/Xv1JUuhuy6V7uT/
         Ji1jM/DEjagKZxshwOEfY36KcQ5bcDbn0m1kr/iNaWYCgLqZCL9wk4/X2HQW8Fs2NB5w
         PsbsZu+kcd36VRBJAMrwov9SUyW7tYpacZGtFTiCyil37dF0G+5fJE8v6MVpFbNTeeWK
         uh+w==
X-Gm-Message-State: AOAM5312kUZlT6m4t0nt6HhLnA8LQEklk42rX1A5XbQJu1hRXNbj3cib
        dz6FSBT4qPXELqeARY6BnFDutAE1/0ICyw==
X-Google-Smtp-Source: ABdhPJy8tXqvM9W1EEmP685evfS5nHbOEbxozg2c7lpLecKxBPcHWBPhGAoF6iwJJeUi5wD0BkkL7g==
X-Received: by 2002:a17:906:1e84:: with SMTP id e4mr16723040ejj.57.1605901303020;
        Fri, 20 Nov 2020 11:41:43 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id q9sm1476873ejr.115.2020.11.20.11.41.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 11:41:41 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id u12so11258828wrt.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 11:41:41 -0800 (PST)
X-Received: by 2002:adf:9d84:: with SMTP id p4mr17885403wre.370.1605901301233;
 Fri, 20 Nov 2020 11:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
 <815b138fb849b56a5ec71045b54c86f99ed9df2c.camel@hadess.net>
 <CAO271mn-3qK6TqDUf2ua06EAN58K592ondrZjC-pt6byPQXG8Q@mail.gmail.com> <8b0420db9d7a9ee73c323fb311ee4faadacead1f.camel@hadess.net>
In-Reply-To: <8b0420db9d7a9ee73c323fb311ee4faadacead1f.camel@hadess.net>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 20 Nov 2020 11:41:30 -0800
X-Gmail-Original-Message-ID: <CAO271mkgnruxgdGsFC+wt5b-ZbxCTyJDU9q7niyNqEdg+DL0iA@mail.gmail.com>
Message-ID: <CAO271mkgnruxgdGsFC+wt5b-ZbxCTyJDU9q7niyNqEdg+DL0iA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Bastien Nocera <hadess@hadess.net>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Fri, Nov 20, 2020 at 2:33 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2020-11-19 at 12:20 -0800, Sonny Sasaka wrote:
> > Hi Bastien,
> >
> > On Thu, Nov 19, 2020 at 2:44 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > On Tue, 2020-11-17 at 14:16 -0800, Sonny Sasaka wrote:
> > > > Hi Bastien,
> > > >
> > > > Thank you for the feedback. Please find my answers below.
> > > >
> > > > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera
> > > > <hadess@hadess.net>
> > > > wrote:
> > > > >
> > > > > Hey Sonny,
> > > > >
> > > > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > > > This patch implements the BatteryProvider1 and
> > > > > > BatteryProviderManager1
> > > > > > API. This is a means for external clients to feed battery
> > > > > > information
> > > > > > to
> > > > > > BlueZ if they handle some profile and can decode battery
> > > > > > reporting.
> > > > > >
> > > > > > The battery information is then exposed externally via the
> > > > > > existing
> > > > > > Battery1 interface. UI components can consume this API to
> > > > > > display
> > > > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > > > >
> > > > > Was this patch reviewed for potential security problems? From
> > > > > the
> > > > > top
> > > > > of my head, the possible problems would be:
> > > > > - I don't see any filters on which user could register battery
> > > > > providers, so on a multi user system, you could have a user
> > > > > logged
> > > > > in
> > > > > via SSH squatting all the battery providers, while the user "at
> > > > > the
> > > > > console" can't have their own providers. Also, what happens if
> > > > > the
> > > > > user
> > > > > at the console changes (fast user switching)?
> > > > > - It looks like battery providers don't check for paired,
> > > > > trusted
> > > > > or
> > > > > even connected devices, so I would be able to create nearly
> > > > > unbound
> > > > > number of battery providers depending on how big the cache for
> > > > > "seen"
> > > > > devices is.
> > > > For security, the API can be access-limited at D-Bus level using
> > > > D-
> > > > Bus
> > > > configuration files. For example, we can let only trusted UNIX
> > > > users
> > > > as the callers for this API. This D-Bus config file would be
> > > > distribution-specific. In Chrome OS, for example, only the
> > > > "audio"
> > > > and
> > > > "power" users are allowed to call this API. This way we can make
> > > > sure
> > > > that the callers do not abuse the API for denial-of-service kind
> > > > of
> > > > attack.
> > >
> > > That wouldn't solve it, the point is to avoid one user causing
> > > problems
> > > for another logged in user. If both users are in the audio group,
> > > which
> > > they'd likely be to be able to use the computer, they'd be able to
> > > cause problems to each other.
> >
> > If I understand your case correctly, both users being in "audio"
> > group
> > still won't allow them both to become battery providers because the
> > D-Bus policy only allows "audio" user and not "audio" group.
>
> OK, I guess that means that this is a separate daemon running as a
> different user, not, say, PulseAudio running in the user's session
> feeding information. Is that right?
Yes, that's right.

>
> Either way, I guess we'll need to test this out once the feature is
> merged.
It will first be tested in Chrome OS with CRAS as the battery provider
from HFP (I am working on it too). I guess PulseAudio can then follow
along so Linux desktops can get headphones batteries in the UI. Then,
as Luiz suggested, batteries from HID will be parsed directly from
within bluetoothd (a TODO, not blocking the progress of the API).

>
> Apart from the concern about having to duplicate the exported
> properties, the rest looks good. I've made some additional comments
> about the architecture in the design document you shared, but those
> should not have any impact on the implementation.

Thanks for the review. I will update the patches based on your and
Luiz's feedback.
>
> Good job :)
>
