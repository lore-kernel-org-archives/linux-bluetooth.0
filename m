Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE636C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99542208A9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLOI6/JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgIJXT2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJXTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:19:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA222C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:19:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so10363980lja.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7AucZqvu579iulSUU1SYvC0/k1Tat5DA+g3riwowxU=;
        b=nLOI6/JIxbBHNnpC3p+Au/rVkeEC3FyE+mSBpRc9xCFiQQ3Ce0pxHTfiQALzOP70ky
         IgW3z1YtZVQP1V3Xh3wvZ/XNrPvZYHb4IlT4XfET6QgPIrQNtQLpydn3MrSkiVas5RtR
         Yhon18I/QAkcDlP1YblEvqewU8EC8IbK2dmbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7AucZqvu579iulSUU1SYvC0/k1Tat5DA+g3riwowxU=;
        b=Gp5HTzDIa4aHEe7OaIu64uolb2ci/yuF231i2N5lsFGFbLUXemIAVWLT1DbSTHp1qu
         zs/rjvEX5W85WGx3OYxxeG2qOjQ41fgAQyyEy0TP1wr2xJskriUsvQMdCMEf2u3yG8xp
         pOjG5/k4gALmIX/3uw8Rn68YxnKFPlyvZgPriWcvpcN8uOUTJwL1RfkdW9iBV6mvAyQc
         S+RzEH+xoXk9Ykl0IOZjAiPypWLaxxadpvuP+/E8n7oBF+jDNs7yia0kbfDyXaYpTEiO
         odJbFSzqIHYBS436YXJiunJYJvgSG0vA/tOQQxBhdvFAgv4iE6BY28EFPh/sPMxvX6+X
         yXVw==
X-Gm-Message-State: AOAM530qTuee0UVJI0aaMzkzD5DLm79TdWp3dcgQpzerFurSos89NZbd
        fB636N8fKfpnc9GXaYf918x+jCVWPhqRHzVE38Kt8UFFdfU=
X-Google-Smtp-Source: ABdhPJyARvKcs5Xuu5X8ZVllTM1EPTTaoRzH5udy8UT5ug+0U0u/5iSBRc0jzJvgGuEBB7+xk8/UUhgnzyjGKn+435o=
X-Received: by 2002:a2e:b051:: with SMTP id d17mr5365075ljl.190.1599779961328;
 Thu, 10 Sep 2020 16:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
 <CABBYNZLCZ9FCEH=Z3sHzsg-jw_4CvnbMxBNbQem=x0JE_+y7NA@mail.gmail.com>
 <CABmPvSEMoJEfpFPgnytgr+ig6TquAtg2kN+WpvAJ1oX6jUs6+Q@mail.gmail.com> <CABBYNZKTQsHP9r_WqrQTkof3DQ5kRXTHNBcXRkR8k2d==vDmxQ@mail.gmail.com>
In-Reply-To: <CABBYNZKTQsHP9r_WqrQTkof3DQ5kRXTHNBcXRkR8k2d==vDmxQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 10 Sep 2020 16:19:10 -0700
Message-ID: <CABmPvSHfb1w-DwvJkHHo4y_mpxdfpswQ8n7fJ4RmOPyOFYdavw@mail.gmail.com>
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

On Thu, Sep 10, 2020 at 10:43 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Wed, Sep 9, 2020 at 9:53 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Sep 8, 2020 at 10:40 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Miao,
> > >
> > > On Tue, Aug 18, 2020 at 3:34 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > > >
> > > > This modifies the following description to Advertisement Monitor API.
> > > > - Add org.bluez.Error.Failed to RegisterMonitor() method.
> > > > - Add more description about the usage of RegisterMonitor() and
> > > > UnregisterMonitor() methods.
> > > > - Add description about the ranges for the fields in property
> > > > RSSIThresholdsAndTimers.
> > > >
> > > > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > > > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > > > ---
> > > >
> > > >  doc/advertisement-monitor-api.txt | 34 +++++++++++++++++++++++--------
> > > >  1 file changed, 25 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> > > > index 74adbfae9..e09b6fd25 100644
> > > > --- a/doc/advertisement-monitor-api.txt
> > > > +++ b/doc/advertisement-monitor-api.txt
> > > > @@ -49,7 +49,7 @@ Properties    string Type [read-only]
> > > >                         org.bluez.AdvertisementMonitorManager1 for the available
> > > >                         options.
> > > >
> > > > -               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> > > > +               (Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
> > > >
> > > >                         This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> > > >                         LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> > > > @@ -66,7 +66,11 @@ Properties   string Type [read-only]
> > > >                         RSSIs of the received advertisement(s) during
> > > >                         LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> > > >
> > > > -               array{(uint8, uint8, string)} Patterns [read-only, optional]
> > > > +                       The valid range of a RSSI is -127 to +20 dBm while 127
> > > > +                       dBm indicates unset. The valid range of a timer is 1 to
> > > > +                       300 seconds while 0 indicates unset.
> > > > +
> > > > +               array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
> > > >
> > > >                         If Type is set to 0x01, this must exist and has at least
> > > >                         one entry in the array.
> > > > @@ -80,8 +84,9 @@ Properties    string Type [read-only]
> > > >                                 See https://www.bluetooth.com/specifications/
> > > >                                 assigned-numbers/generic-access-profile/ for
> > > >                                 the possible allowed value.
> > > > -                       string content_of_pattern
> > > > -                               This is the value of the pattern.
> > > > +                       array{byte} content_of_pattern
> > > > +                               This is the value of the pattern. The maximum
> > > > +                               length of the bytes is 31.
> > > >
> > > >  Advertisement Monitor Manager hierarchy
> > > >  =======================================
> > > > @@ -91,20 +96,31 @@ Object path /org/bluez/{hci0,hci1,...}
> > > >
> > > >  Methods                void RegisterMonitor(object application)
> > > >
> > > > -                       This registers a hierarchy of advertisement monitors.
> > > > +                       This registers the root path of a hierarchy of
> > > > +                       advertisement monitors.
> > > >                         The application object path together with the D-Bus
> > > >                         system bus connection ID define the identification of
> > > >                         the application registering advertisement monitors.
> > > > +                       Once a root path is registered by a client via this
> > > > +                       method, the client can freely expose/unexpose
> > > > +                       advertisement monitors without re-registering the root
> > > > +                       path again. After use, the client should call
> > > > +                       UnregisterMonitor() method to invalidate the
> > > > +                       advertisement monitors.
> > > >
> > > >                         Possible errors: org.bluez.Error.InvalidArguments
> > > >                                          org.bluez.Error.AlreadyExists
> > > > +                                        org.bluez.Error.Failed
> > > >
> > > >                 void UnregisterMonitor(object application)
> > > >
> > > > -                       This unregisters advertisement monitors that have been
> > > > -                       previously registered. The object path parameter must
> > > > -                       match the same value that has been used on
> > > > -                       registration.
> > > > +                       This unregisters a hierarchy of advertisement monitors
> > > > +                       that has been previously registered. The object path
> > > > +                       parameter must match the same value that has been used
> > > > +                       on registration. Upon unregistration, the advertisement
> > > > +                       monitor(s) should expect to receive Release() method as
> > > > +                       the signal that the advertisement monitor(s) has been
> > > > +                       deactivated.
> > > >
> > > >                         Possible errors: org.bluez.Error.InvalidArguments
> > > >                                          org.bluez.Error.DoesNotExist
> > > > --
> > > > 2.26.2
> > >
> > > These are still experimental so you will need to use EXPERIMENTAL
> > > version when declaring the methods/properties so it only gets enabled
> > > when the experimental flag is passed to bluetoothd.
> > g_dbus_register_interface()  does not allow to have all methods and
> > properties marked as experimental, so at least SupportedFeatures
> > should be non-experimental.
>
> You will need to do something like the following:
>
> if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
>
> You can see how it was used in adv_manager:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d6e9539e31c6bb5afd39ec6f09c518d232e6345d
>
Thanks for the pointer. Please see v4 for the changes.

> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Miao
>
>
>
> --
> Luiz Augusto von Dentz
Regards,
Miao
