Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE8C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 17:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5509D206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 17:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIuUCBKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIJRp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgIJRnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 13:43:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3978C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 10:43:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y6so6725322oie.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7kn8gB+kxU9eN3AY5RgvnfQYBYcgCoCiotDOEu3YVQ=;
        b=RIuUCBKa38+6vQSbBxQpMWorkPP1vG4k9gO3j5pgusJ7yhasdtWiwHFFxmzqseyilv
         YWbDbRfXKRpQzvhhrDbtIdF5kf+oN1udLVBy02Mgeq0jqRD+X6+kt3FqwxdF35czXa/Z
         GprHcxoV/pwbMesovBpZmffZwE2HDniDWofmhOiLE3+R+jUNnxARctjCPiUQjO+8l8Na
         RUvDfmFSN7Oefi+Pyfw9OsP7ZR6/s/nIbbXyVP/DwqhTNMnR/NmVElh4S1VsmCzSyl0H
         O3yJ1AeNTro3SmYgNVn4Iv/6mHeQQ1111sPSKmzS1FSEW84rBPtSMxfMkp09Onq083ON
         71DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7kn8gB+kxU9eN3AY5RgvnfQYBYcgCoCiotDOEu3YVQ=;
        b=J2AvoqfxFmVSDwqHiYW/dr/XrwQfU5y4rJdNA4O6gpcM76AUQQhks06OXxRucCyFm4
         wca90UlC/uwgmYX9/QsT2kPceJz5MOTZtF4rpA4qRzMcxCqq2g+9WcxQEvl4vbIZTX4i
         Z75O3kg08KP5jALVZ/7Q+IxGv1VSb5bJVuemQ2lNr9YY6RT0uOQf5IWmVTOhh/RvxiVG
         S5ItrQDJvKbrBqTSIrB4E5qcHmGtts4aW1EEa2yQ4kP3gCiDaOcvX7bUYCQw+Td6n3Ti
         9QGFh6BpdrkJk5j5R+4ONkJ5PcL95dMfKYOTpdVAjfw3bgblqnJMSmBPT0ykCmPbCM24
         uEIw==
X-Gm-Message-State: AOAM532mWFXx7YsRGTVbKUr0H/vU+fWhz2ZGmPIxC+BXAtRgSFN4UwYE
        UwxW8DmSOLPhoWznJeX6pHkAIotm+YiSkjs44SRvEMgUvL8=
X-Google-Smtp-Source: ABdhPJxfzEqk07uyyHZyQ9x0mTwShhBJySeDS0r0rVF3/X5GJbLrkNfieGA18+HMOLAXQywCFoBlItyR42Yi4BPajNE=
X-Received: by 2002:aca:aad0:: with SMTP id t199mr685707oie.48.1599759813999;
 Thu, 10 Sep 2020 10:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
 <CABBYNZLCZ9FCEH=Z3sHzsg-jw_4CvnbMxBNbQem=x0JE_+y7NA@mail.gmail.com> <CABmPvSEMoJEfpFPgnytgr+ig6TquAtg2kN+WpvAJ1oX6jUs6+Q@mail.gmail.com>
In-Reply-To: <CABmPvSEMoJEfpFPgnytgr+ig6TquAtg2kN+WpvAJ1oX6jUs6+Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Sep 2020 10:43:23 -0700
Message-ID: <CABBYNZKTQsHP9r_WqrQTkof3DQ5kRXTHNBcXRkR8k2d==vDmxQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 7/7] doc/advertisement-monitor-api: Update
 Advertisement Monitor API description
To:     Miao-chen Chou <mcchou@chromium.org>
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

Hi Miao,

On Wed, Sep 9, 2020 at 9:53 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> On Tue, Sep 8, 2020 at 10:40 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Tue, Aug 18, 2020 at 3:34 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > This modifies the following description to Advertisement Monitor API.
> > > - Add org.bluez.Error.Failed to RegisterMonitor() method.
> > > - Add more description about the usage of RegisterMonitor() and
> > > UnregisterMonitor() methods.
> > > - Add description about the ranges for the fields in property
> > > RSSIThresholdsAndTimers.
> > >
> > > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > > ---
> > >
> > >  doc/advertisement-monitor-api.txt | 34 +++++++++++++++++++++++--------
> > >  1 file changed, 25 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> > > index 74adbfae9..e09b6fd25 100644
> > > --- a/doc/advertisement-monitor-api.txt
> > > +++ b/doc/advertisement-monitor-api.txt
> > > @@ -49,7 +49,7 @@ Properties    string Type [read-only]
> > >                         org.bluez.AdvertisementMonitorManager1 for the available
> > >                         options.
> > >
> > > -               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> > > +               (Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
> > >
> > >                         This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> > >                         LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> > > @@ -66,7 +66,11 @@ Properties   string Type [read-only]
> > >                         RSSIs of the received advertisement(s) during
> > >                         LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> > >
> > > -               array{(uint8, uint8, string)} Patterns [read-only, optional]
> > > +                       The valid range of a RSSI is -127 to +20 dBm while 127
> > > +                       dBm indicates unset. The valid range of a timer is 1 to
> > > +                       300 seconds while 0 indicates unset.
> > > +
> > > +               array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
> > >
> > >                         If Type is set to 0x01, this must exist and has at least
> > >                         one entry in the array.
> > > @@ -80,8 +84,9 @@ Properties    string Type [read-only]
> > >                                 See https://www.bluetooth.com/specifications/
> > >                                 assigned-numbers/generic-access-profile/ for
> > >                                 the possible allowed value.
> > > -                       string content_of_pattern
> > > -                               This is the value of the pattern.
> > > +                       array{byte} content_of_pattern
> > > +                               This is the value of the pattern. The maximum
> > > +                               length of the bytes is 31.
> > >
> > >  Advertisement Monitor Manager hierarchy
> > >  =======================================
> > > @@ -91,20 +96,31 @@ Object path /org/bluez/{hci0,hci1,...}
> > >
> > >  Methods                void RegisterMonitor(object application)
> > >
> > > -                       This registers a hierarchy of advertisement monitors.
> > > +                       This registers the root path of a hierarchy of
> > > +                       advertisement monitors.
> > >                         The application object path together with the D-Bus
> > >                         system bus connection ID define the identification of
> > >                         the application registering advertisement monitors.
> > > +                       Once a root path is registered by a client via this
> > > +                       method, the client can freely expose/unexpose
> > > +                       advertisement monitors without re-registering the root
> > > +                       path again. After use, the client should call
> > > +                       UnregisterMonitor() method to invalidate the
> > > +                       advertisement monitors.
> > >
> > >                         Possible errors: org.bluez.Error.InvalidArguments
> > >                                          org.bluez.Error.AlreadyExists
> > > +                                        org.bluez.Error.Failed
> > >
> > >                 void UnregisterMonitor(object application)
> > >
> > > -                       This unregisters advertisement monitors that have been
> > > -                       previously registered. The object path parameter must
> > > -                       match the same value that has been used on
> > > -                       registration.
> > > +                       This unregisters a hierarchy of advertisement monitors
> > > +                       that has been previously registered. The object path
> > > +                       parameter must match the same value that has been used
> > > +                       on registration. Upon unregistration, the advertisement
> > > +                       monitor(s) should expect to receive Release() method as
> > > +                       the signal that the advertisement monitor(s) has been
> > > +                       deactivated.
> > >
> > >                         Possible errors: org.bluez.Error.InvalidArguments
> > >                                          org.bluez.Error.DoesNotExist
> > > --
> > > 2.26.2
> >
> > These are still experimental so you will need to use EXPERIMENTAL
> > version when declaring the methods/properties so it only gets enabled
> > when the experimental flag is passed to bluetoothd.
> g_dbus_register_interface()  does not allow to have all methods and
> properties marked as experimental, so at least SupportedFeatures
> should be non-experimental.

You will need to do something like the following:

if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)

You can see how it was used in adv_manager:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=d6e9539e31c6bb5afd39ec6f09c518d232e6345d

> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Miao



-- 
Luiz Augusto von Dentz
