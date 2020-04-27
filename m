Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CCDC4CECD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE912073C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBhr8u8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD0UOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD0UOb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 16:14:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941FC0A3BF5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 13:14:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g10so14885844lfj.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWTOfieKttqxOaP7I87kPsku8QYB3HIBi6eV8yMsNHs=;
        b=mBhr8u8hezk+355wHKzbuawuVmr5LL6vSYp1Vb9DdDD4XiQmBBk3bmvHN5Jb+ECfML
         Ly9p1a66Ehad+HTDvsW6hta7qbu7EkS5BebvpCtcStHoT9jfqa9J5yP+ucotB75PYKCN
         V8rqHLUa0UfVl4iswza+aNb0FAg4rlGtQes7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWTOfieKttqxOaP7I87kPsku8QYB3HIBi6eV8yMsNHs=;
        b=Y9X6bxMlpuAEBSqjrY0VoCyKQbkgsFY7NemRuC34P21pbXEzBITaoAKBDO54vhjCy+
         CgoWOUMC4RVENLJwexZIlSyj1ohjU1pAGqaKIN/1z404/7hrwGGq17YJo/o6+8suEF4p
         K0g9g6JF57P2SBsqnBuXNYUfJR0S5Q6bs883stHdu22ZzcDW4hqSFyS1kuH2SoX7O8kZ
         wmKehpGYI8WsLBG2D7DSpe97s36L/uno4dQ8ulxuqcSKMgYxMyxsidliQSNK3R0Uo+1M
         XJbNjKHljUz6myYRpY9vmiseGn/EhRJqiPxCa78qHBSKuvcCgyVtfy6u6MKijRttYLC+
         OOew==
X-Gm-Message-State: AGi0PuZLGrTVkYZHILU+WBpH5bB+z7fpVmYgcz29BjedV4lsTedl+LYY
        ooFKbfBjDlSGZz6aWIXCiluDJoxh4eUi60pA9XPqxg==
X-Google-Smtp-Source: APiQypKRsEpHYHO5tOBpRbWuozpkak5UGhot2k6knL9zu44uQUPxmV9tw1FRW3rlAt+OrExZGl7IaUI1EoXVHBXC4HI=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr16087489lfm.144.1588018469741;
 Mon, 27 Apr 2020 13:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200423141423.BlueZ.v3.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <CABBYNZ+xN4GCDq2hiuHUG9Y3bgA38W_r2nW+UBwnwyUdo9UhAQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+xN4GCDq2hiuHUG9Y3bgA38W_r2nW+UBwnwyUdo9UhAQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 27 Apr 2020 13:14:16 -0700
Message-ID: <CABmPvSENDFtEfcQ8tL_A_6WaSLEDyemGVfavu4W=L=kwukj-cA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc: Add Advertisement Monitoring API
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for your feedback. Your comments were addressed in v4, please
take another look.

On Fri, Apr 24, 2020 at 12:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Thu, Apr 23, 2020 at 2:17 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This patch proposes an Advertisement Monitoring API for an application to
> > register a job of monitoring ADV reports with content filter and RSSI
> > thresholds.
> > ---
> >
> > Changes in v3:
> > - Introduce SupportedFeatures to reflect the features based on
> > controller's capabilities.
> > - Modify SupportedMonitorTypes to list available types of monitors.
> >
> > Changes in v2:
> > - Rename the interfaces and functions.
> > - Adopt the object manager mechanism so that a client can expose
> > multiple monitor objects and expect to get notified on whether the
> > monitor has been activated or not.
> > - Change the contract of DeviceFound so that it is called to indicate
> > the starting point of monitoring on a device instead of reporting every
> > ADV. In other words, the client is expected to monitor corresponding
> > device events.
> >
> >  doc/advertisement-monitor-api.txt | 134 ++++++++++++++++++++++++++++++
> >  1 file changed, 134 insertions(+)
> >  create mode 100644 doc/advertisement-monitor-api.txt
> >
> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> > new file mode 100644
> > index 000000000..b8b01536a
> > --- /dev/null
> > +++ b/doc/advertisement-monitor-api.txt
> > @@ -0,0 +1,134 @@
> > +BlueZ D-Bus Advertisement Monitor API Description
> > +*************************************************
> > +
> > +This API allows an client to specify a job of monitoring advertisements by
> > +registering the root of hierarchy and then exposing advertisement monitors
> > +under the root with filtering conditions, thresholds of RSSI and timers
> > +of RSSI thresholds.
> > +
> > +Once a monitoring job is activated by BlueZ, the client can expect to get
> > +notified on the targeted advertisements no matter if there is an ongoing
> > +discovery session (a discovery session is started/stopped with methods in
> > +org.bluez.Adapter1 interface).
> > +
> > +Advertisement Monitor hierarchy
> > +===============================
> > +Service                org.bluez
> > +Interface      org.bluez.AdvertisementMonitor1
> > +Object path    freely definable
> > +
> > +Methods                void Release() [noreply]
> > +
> > +                       This gets called as a signal for a client to perform
> > +                       clean-up when (1)a monitor cannot be activated after it
> > +                       was exposed or (2)a monitor has been deactivated.
> > +
> > +               void Activate() [noreply]
> > +
> > +                       After a monitor was exposed, this gets called as a
> > +                       signal for client to get acknowledged when a monitor
> > +                       has been activated, so the client can expect to receive
> > +                       calls on DeviceFound() or DeviceLost().
> > +
> > +               void DeviceFound(object device) [noreply]
> > +
> > +                       This gets called to notify the client of finding the
> > +                       targeted device. Once receiving the call, the client
> > +                       should start to monitor the corresponding device to
> > +                       retrieve the changes on RSSI and advertisement content.
> > +
> > +               void DeviceLost(object device) [noreply]
> > +
> > +                       This gets called to notify the client of losing the
> > +                       targeted device. Once receiving this call, the client
> > +                       should stop monitoring the corresponding device.
> > +
> > +Properties     uint8 Type [read-only]
> > +
> > +                       The type of the monitor. See SupportedMonitorTypes in
> > +                       org.bluez.AdvertisementMonitorManager1 for the available
> > +                       options.
> > +
> > +               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> > +
> > +                       This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> > +                       LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> > +                       unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
> > +                       The unit of HighRSSIThresholdTimer and
> > +                       LowRSSIThresholdTimer is second.
> > +
> > +                       If these are provided, RSSI would be used as a factor to
> > +                       notify the client of whether a device stays in range or
> > +                       move out of range. A device is considered in-range when
> > +                       the RSSIs of the received advertisement(s) during
> > +                       HighRSSIThresholdTimer seconds exceed HighRSSIThreshold.
> > +                       Likewise, a device is considered out-of-range when the
> > +                       RSSIs of the received advertisement(s) during
> > +                       LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> > +
> > +               array{(uint8, uint8, string)} Patterns [read-only, optional]
> > +
> > +                       If Type is set to 0x01, this must exist and has at least
> > +                       one entry in the array.
> > +
> > +                       The structure of a pattern contains the following.
> > +                       uint8 start_position
> > +                               The index in an AD data field where the search
> > +                               should start. The beginning of an AD data field
> > +                               is index 0.
> > +                       uint8 AD_data_type
> > +                               See https://www.bluetooth.com/specifications/
> > +                               assigned-numbers/generic-access-profile/ for
> > +                               the possible allowed value.
> > +                       string content_of_pattern
> > +                               This is the value of the pattern.
> > +
> > +=======================================
> > +Service                org.bluez
> > +Interface      org.bluez.AdvertisementMonitorManager1
> > +Object path    /org/bluez/{hci0,hci1,...}
> > +Methods                void RegisterApplication(object application)
> > +
> > +                       This registers a hierarchy of advertisement monitors.
> > +                       The application object path together with the D-Bus
> > +                       system bus connection ID define the identification of
> > +                       the application registering advertisement monitors.
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.AlreadyExists
> > +
> > +               void UnregisterApplication(object application)
> > +
> > +                       This unregisters advertisement monitors that have been
> > +                       previously registered. The object path parameter must
> > +                       match the same value that has been used on
> > +                       registration.
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.DoesNotExist
> > +
> > +Properties     array{uint8} SupportedMonitorTypes [read-only]
> > +
> > +                       This lists the supported types of advertisement
> > +                       monitors. An application should check this before
> > +                       instantiate and expose an object of
> > +                       org.bluez.AdvertisementMonitor1.
> > +
> > +                       Possible values for monitor types:
> > +
> > +                       0x01    Patterns with logic OR applied. With this type,
> > +                               property "Patterns" must exist and has at least
> > +                               one pattern.
>
> Perhaps we should also have this as string, D-Bus don't really support
> enums and it makes the types easier to debug if we express in them as
> strings.
>
> > +
> > +               array{string} SupportedFeatures [read-only]
> > +
> > +                       This lists the features of advertisement monitoring
> > +                       supported by BlueZ.
> > +
> > +                       Possible values for features:
> > +
> > +                       "controller-based-monitor-by-patterns"
> > +                               If the controller is capable of performing
> > +                               advertisement monitoring by patterns, BlueZ
> > +                               would offload the patterns to the controller to
> > +                               reduce power consumption.
> > --
> > 2.24.1
>
> Other than that it looks good to me, the only thing Id mark this
> interface as experimental for now so we still allow changes if we deem
> necessary.
>
>
> --
> Luiz Augusto von Dentz

Regards,
Miao
