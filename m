Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C68EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 21:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BCB60C3D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 21:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBQVWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhBQVW1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 16:22:27 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FFC061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 13:21:46 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id s23so3409641oot.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4elXU8Vm2uomhaPvYEGoeeCoWd9e3GVig1aBwMFkhA=;
        b=X0NdJ5ZKWJAsr6TFlWGNgdLko26mySkQYYGdVssrpPwEF1gbBFzN7yrLWbIbgruGYm
         uB/viSCOm2L/rn+G7YXVj1W3MZD7VHWKc5UuiBIlkZ5SMfB0RNTizEpZjQBVG1Az97Ft
         jhdIY1iEw30/7rIqTJbyMVattCwV/Sx+hSpAwIiCgL2y0JrzEnQUBdHCfmqhZNedjYm5
         0LmoABQCgoOWPxVDLLkJag43OvhCQgVWCMuaaC4OrjuQqHzs5hN+qy98g9By7L7Gkako
         IOPobQqmr1CQ2U53Qf7ZTe3m4LIC7ZRpNVDiDEnDcvgH6Y1Lqm9tRSsBwClnfWdmngo1
         q1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4elXU8Vm2uomhaPvYEGoeeCoWd9e3GVig1aBwMFkhA=;
        b=fT4HlTjv7ajvG37LWtjdhfef2CdupCcLng8kTvlUMZnCq15DXQO5hc1A1iu+wC6bXg
         Nxm4hRaoCbtPsQYY4WG07o+Yc0ApIRX4WIJjimbuinfAWwiWq4TLrGisdktNRSx36+Pa
         W3HvDC1EJCuXMGIAQ44EeR3RqDAxQthEMEVxulGMa+r9u1vTnV7bIzZzI5oK43M1Qw2w
         DdvAYkLIQARd7QQw/y/XrpPs15yYs0Dsr5OkNTMosdHUPFjLWZUXxpcw1fM8javvOuMi
         irQv+G9GP4MFpYm+2iJJ5PLeX9drmSzUxo8fcbglKq1sBGq6PQm7Dx8utQ9JR80wRgwu
         WoYQ==
X-Gm-Message-State: AOAM5308g/+cT8/STgmQuibjNEfxy6w7S0JABav7dT3GzhKHnUO87End
        BIfXucgmuJBOLrnGkxkt0Kp8Scp33GBwWvCwumimYNHNsos=
X-Google-Smtp-Source: ABdhPJyIHI2JCgCqUsazR5zb8vzSRxykM6Wxks6w2I328RXBobXfgwtsWLOg8T6qaCJ82r27fc13BsNFMIhLSs0acTU=
X-Received: by 2002:a4a:41cd:: with SMTP id x196mr703218ooa.63.1613596905765;
 Wed, 17 Feb 2021 13:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20210216233337.859955-1-luiz.dentz@gmail.com> <20210216233337.859955-3-luiz.dentz@gmail.com>
 <CABmPvSHG9M9f6kVb9+DzF0MsyUA56R0LJsd+KuZtPxZSccrKsA@mail.gmail.com>
In-Reply-To: <CABmPvSHG9M9f6kVb9+DzF0MsyUA56R0LJsd+KuZtPxZSccrKsA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Feb 2021 13:21:35 -0800
Message-ID: <CABBYNZK+Qm456J0Qeh-BHki_CuLfVewHnVDWHmSq6FYex0P8kg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] avdtp: Remove use of G_PRIORITY_LOW
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Wed, Feb 17, 2021 at 12:24 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for reforming the fix. I tested the series on my DUT and it
> works as expected where the paired device persists throughout the
> suspend and resume. However I observed the following sequence in the
> logs.
> Given that this series raises the priority of avdtp's IO, session_cb()
> got poked immediately after the index was removed, and that triggers
> avdtp_free() early. About ~100ms later, avdtp_unregister_sep was
> called with a non-NULL pointer to the sep with A2DP. However, that sep
> is no longer valid since avdtp_free() freed all the seps. I wonder if
> this can be a potential issue?

Are you referring to the local sep or the remote ones? avdtp_free
should not have free any local ones as it just have a reference to the
queue and that afaik was never meant to be free by avdtp_free.

> = Close Index: 5C:3A:45:9C:CF:8A
>                             [hci0] 2021-02-17 11:52:02.607860
> @ MGMT Event: Index Removed (0x0005) plen 0
>                    {0x0003} [hci0] 2021-02-17 11:52:02.607866
> ...
> = Delete Index: 5C:3A:45:9C:CF:8A
>                             [hci0] 2021-02-17 11:52:02.607876
> = bluetoothd: Unable to get io data for Hands-Free Voice gateway:
> getpeername: Transport endpoint is...   2021-02-17 11:52:02.618425
> = bluetoothd: src/service.c:change_state() 0x56093254dff0: device
> 28:11:A5:E1:4F:67 profile Hands-Fre..   2021-02-17 11:52:02.618480
> = bluetoothd: src/service.c:btd_service_unref() 0x56093254dff0: ref=2
>                                    2021-02-17 11:52:02.618486
> = bluetoothd: profiles/audio/avdtp.c:session_cb()
>                                    2021-02-17 11:52:02.618497
> = bluetoothd: profiles/audio/avdtp.c:avdtp_ref() 0x560932556830: ref=2
>                                    2021-02-17 11:52:02.618585
> = bluetoothd: profiles/audio/avdtp.c:connection_lost() Disconnected
> from 28:11:A5:E1:4F:67                2021-02-17 11:52:02.618594
> = bluetoothd: profiles/audio/a2dp.c:abort_cfm() Source 0x5609324c36b0:
> Abort_Cfm                          2021-02-17 11:52:02.618600
> = bluetoothd: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
> state changed: OPEN -> IDLE             2021-02-17 11:52:02.618605
> = bluetoothd: src/service.c:change_state() 0x560932552490: device
> 28:11:A5:E1:4F:67 profile a2dp-sink..   2021-02-17 11:52:02.621466
> = bluetoothd: profiles/audio/avdtp.c:avdtp_unref() 0x560932556830:
> ref=1                                  2021-02-17 11:52:02.621492
> = bluetoothd: profiles/audio/sink.c:sink_set_state() State changed
> /org/bluez/hci0/dev_28_11_A5_E1_4F..   2021-02-17 11:52:02.621500
> = bluetoothd: profiles/audio/a2dp.c:channel_remove() chan
> 0x5609324a7930                                  2021-02-17
> 11:52:02.621539
> = bluetoothd: profiles/audio/avdtp.c:avdtp_unref() 0x560932556830:
> ref=0                                  2021-02-17 11:52:02.621546
> = New Index: 00:00:00:00:00:00 (Primary,USB,hci0)
>                             [hci0] 2021-02-17 11:52:02.619195
> = bluetoothd: profiles/audio/avdtp.c:avdtp_free() 0x560932556830
>                                    2021-02-17 11:52:02.621615
> = bluetoothd: Endpoint unregistered: sender=:1.50
> path=/org/chromium/Cras/Bluetooth/A2DPSource            2021-02-17
> 11:52:02.764766
> = bluetoothd: profiles/audio/media.c:media_endpoint_destroy()
> sender=:1.50 path=/org/chromium/Cras/Bl..   2021-02-17 11:52:02.764792
> = bluetoothd: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP
> 0x5609324c36b0 unregistered: type:0 c..   2021-02-17 11:52:02.764797
> = bluetoothd: profiles/audio/media.c:media_player_destroy()
> sender=:1.50 path=/org/chromium/Cras/Blue..   2021-02-17
> 11:52:02.771347
>
> On Tue, Feb 16, 2021 at 3:35 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > G_PRIORITY_LOW was used in order to prioritize the AVDTP media transport
> > channel over the signalling channel but this has the side effect of
> > delaying the dispatching of other conditions such as HUP/NVAL, so now
> > that BtIO use G_PRIORITY_HIGH for its watches we no longer need to
> > deprioritize session_cb.
> > ---
> >  profiles/audio/avdtp.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 9ddcd6464..088ca58b3 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -2378,19 +2378,10 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
> >                 if (session->io_id)
> >                         g_source_remove(session->io_id);
> >
> > -               /* This watch should be low priority since otherwise the
> > -                * connect callback might be dispatched before the session
> > -                * callback if the kernel wakes us up at the same time for
> > -                * them. This could happen if a headset is very quick in
> > -                * sending the Start command after connecting the stream
> > -                * transport channel.
> > -                */
> > -               session->io_id = g_io_add_watch_full(chan,
> > -                                               G_PRIORITY_LOW,
> > +               session->io_id = g_io_add_watch(chan,
> >                                                 G_IO_IN | G_IO_ERR | G_IO_HUP
> >                                                 | G_IO_NVAL,
> > -                                               (GIOFunc) session_cb, session,
> > -                                               NULL);
> > +                                               (GIOFunc) session_cb, session);
> >
> >                 if (session->stream_setup)
> >                         set_disconnect_timer(session);
> > --
> > 2.29.2
> >
> Regards,
> Miao



-- 
Luiz Augusto von Dentz
