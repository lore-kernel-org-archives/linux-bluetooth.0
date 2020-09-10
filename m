Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F246C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4333E2076C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQ8p7VH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgIJExd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJExa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:53:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACDC061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:53:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a15so6475557ljk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpw2FWDzfPkYdf9A6lJBI6poyNed/Ldpp5XTVu6JlO8=;
        b=KQ8p7VH9tbAoZLKJ7vCx/MRbXvzSE2r5fS50ASi1jmjG4u/eITqhEmneDONvHLXwJ3
         FwjLtA3HwdJjUTN8AThtz+4Cb4ZpuZIWCXfjjzAA0o430x8v5R9U3xN6zd4fj3flne1N
         EQq1jQEfEVsw1qfrl++dqXHbQwcV+8VkxP+hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpw2FWDzfPkYdf9A6lJBI6poyNed/Ldpp5XTVu6JlO8=;
        b=kT2XJ2jmftpnFfyvC99iQAILwe8hPLIgMEvR4nbXs8Zwt9gYTH+5qAoGQ3Yz9gY1wx
         TW3WS0jrZjuSagLmg2f+O0G01VSI33YQThTnx7hwEc25NQIZr84bcyq1qigFBlXYUVpq
         cHkBm2bpyF1t6F44oMb4V0uGGXJuAOf7IWp8duO1hXA9BM23mZ/HoWxK8l3szHYhgtRq
         TXG6J9OVTVBN7VWOUwr7KCWe2XoxRhOqjM7glGeoNsqPb8D7vXw8xYiuK46uU769D3BZ
         peLP9u+C9rQJLo8jYMBe3RYyrXmyUlj5XwbtG5bs/ynjF2AowwlYjextjDD7wgYRCw/a
         5wvA==
X-Gm-Message-State: AOAM532iF7xHtWDzUAg/DGtKkFzUGMFl81BgRgGzd4Yjv7fywJLdYZZd
        JVBCW0rxysEpcPJmij0oRtfcAkqunUflwXqU2CTW7Q==
X-Google-Smtp-Source: ABdhPJx8eN+/6bWQE1W+iAAnNP3mVVebokcHBlwPT/N9EuUI66/V650S2mzhSVXcFxw1CAADF92XdzbEEh2Gvw6J+yU=
X-Received: by 2002:a2e:3615:: with SMTP id d21mr3622385lja.333.1599713607720;
 Wed, 09 Sep 2020 21:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
 <CABBYNZLCZ9FCEH=Z3sHzsg-jw_4CvnbMxBNbQem=x0JE_+y7NA@mail.gmail.com>
In-Reply-To: <CABBYNZLCZ9FCEH=Z3sHzsg-jw_4CvnbMxBNbQem=x0JE_+y7NA@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 9 Sep 2020 21:53:16 -0700
Message-ID: <CABmPvSEMoJEfpFPgnytgr+ig6TquAtg2kN+WpvAJ1oX6jUs6+Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 7/7] doc/advertisement-monitor-api: Update
 Advertisement Monitor API description
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Sep 8, 2020 at 10:40 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Tue, Aug 18, 2020 at 3:34 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This modifies the following description to Advertisement Monitor API.
> > - Add org.bluez.Error.Failed to RegisterMonitor() method.
> > - Add more description about the usage of RegisterMonitor() and
> > UnregisterMonitor() methods.
> > - Add description about the ranges for the fields in property
> > RSSIThresholdsAndTimers.
> >
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > ---
> >
> >  doc/advertisement-monitor-api.txt | 34 +++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> > index 74adbfae9..e09b6fd25 100644
> > --- a/doc/advertisement-monitor-api.txt
> > +++ b/doc/advertisement-monitor-api.txt
> > @@ -49,7 +49,7 @@ Properties    string Type [read-only]
> >                         org.bluez.AdvertisementMonitorManager1 for the available
> >                         options.
> >
> > -               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> > +               (Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
> >
> >                         This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> >                         LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> > @@ -66,7 +66,11 @@ Properties   string Type [read-only]
> >                         RSSIs of the received advertisement(s) during
> >                         LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> >
> > -               array{(uint8, uint8, string)} Patterns [read-only, optional]
> > +                       The valid range of a RSSI is -127 to +20 dBm while 127
> > +                       dBm indicates unset. The valid range of a timer is 1 to
> > +                       300 seconds while 0 indicates unset.
> > +
> > +               array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
> >
> >                         If Type is set to 0x01, this must exist and has at least
> >                         one entry in the array.
> > @@ -80,8 +84,9 @@ Properties    string Type [read-only]
> >                                 See https://www.bluetooth.com/specifications/
> >                                 assigned-numbers/generic-access-profile/ for
> >                                 the possible allowed value.
> > -                       string content_of_pattern
> > -                               This is the value of the pattern.
> > +                       array{byte} content_of_pattern
> > +                               This is the value of the pattern. The maximum
> > +                               length of the bytes is 31.
> >
> >  Advertisement Monitor Manager hierarchy
> >  =======================================
> > @@ -91,20 +96,31 @@ Object path /org/bluez/{hci0,hci1,...}
> >
> >  Methods                void RegisterMonitor(object application)
> >
> > -                       This registers a hierarchy of advertisement monitors.
> > +                       This registers the root path of a hierarchy of
> > +                       advertisement monitors.
> >                         The application object path together with the D-Bus
> >                         system bus connection ID define the identification of
> >                         the application registering advertisement monitors.
> > +                       Once a root path is registered by a client via this
> > +                       method, the client can freely expose/unexpose
> > +                       advertisement monitors without re-registering the root
> > +                       path again. After use, the client should call
> > +                       UnregisterMonitor() method to invalidate the
> > +                       advertisement monitors.
> >
> >                         Possible errors: org.bluez.Error.InvalidArguments
> >                                          org.bluez.Error.AlreadyExists
> > +                                        org.bluez.Error.Failed
> >
> >                 void UnregisterMonitor(object application)
> >
> > -                       This unregisters advertisement monitors that have been
> > -                       previously registered. The object path parameter must
> > -                       match the same value that has been used on
> > -                       registration.
> > +                       This unregisters a hierarchy of advertisement monitors
> > +                       that has been previously registered. The object path
> > +                       parameter must match the same value that has been used
> > +                       on registration. Upon unregistration, the advertisement
> > +                       monitor(s) should expect to receive Release() method as
> > +                       the signal that the advertisement monitor(s) has been
> > +                       deactivated.
> >
> >                         Possible errors: org.bluez.Error.InvalidArguments
> >                                          org.bluez.Error.DoesNotExist
> > --
> > 2.26.2
>
> These are still experimental so you will need to use EXPERIMENTAL
> version when declaring the methods/properties so it only gets enabled
> when the experimental flag is passed to bluetoothd.
g_dbus_register_interface()  does not allow to have all methods and
properties marked as experimental, so at least SupportedFeatures
should be non-experimental.

>
>
> --
> Luiz Augusto von Dentz

Thanks,
Miao
