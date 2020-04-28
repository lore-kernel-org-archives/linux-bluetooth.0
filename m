Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88C1C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 22:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADC0206D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 22:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8Sly55F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD1WCj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD1WCj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 18:02:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FEC03C1AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 15:02:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f8so18121169lfe.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSi7aTQiGBFWtl/N3/RLyQibHZcuchs5ZvLVr2t+HMo=;
        b=g8Sly55FBb6gRbW4Vr4PsoSkm3ZW4YDr9GtWLEDSFU16lMSaGO9FvErZm4kAJZqHOB
         Jb0rh1k9AWVNGXSNaL5+Oqrgl3vN1GP9Yv+aVmRrjm6ELKfpDKlGw1zU0BWZ1VdkpDxt
         UsGXV3vjXGDzQhp4lNDlbqiZpRyUDIrIcO2cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSi7aTQiGBFWtl/N3/RLyQibHZcuchs5ZvLVr2t+HMo=;
        b=m878eg2LKFvFPSDWC/G+lHn9JewzEwE+pkAnN0kAdVlMx2NnthAZYAunITp/uPks+g
         42NIF61ue1D5lVXQTcrvqD2n/Wn0lXdTdz/ayfnOK5y6KktlhBzHHCKsevhtpNZ3lhny
         /rQAtzQtEoCtqKIYY9EU8/RzSFcoU23wEFbP493PkcLf8kUHaWHxkrIo2PaIBytp1cjC
         fA2fOP1g1P6jJrGOP+HQPXiQEdEMc32/pvYLqxcqMK29uhwwXSJBxcY0fc7KPzSG4QYb
         bij/VuFEqFkVoAUOEji/C7wALHyA34Ap1CDSVdZYSUCJTR3M7Ofh40Fb5DAh8R0+S3/g
         UgqA==
X-Gm-Message-State: AGi0Pua/oTiEC/Em6V695Qo96pTiZ1+xSKDTnzy00c7VBfkIyxPk9lyI
        7ZeabMP6bS0JYg8AVRR5tUGNNup5DtMIGpD6S/kRIg==
X-Google-Smtp-Source: APiQypIG7hE7zp8+J181qo+6cQGjH2MiY+ZVTnqiJbjUC3F0rcbw7I1iK3PO5L8kGT18FEP8ZuMy1zwVglCcLcyqh2o=
X-Received: by 2002:ac2:569b:: with SMTP id 27mr20694044lfr.134.1588111355781;
 Tue, 28 Apr 2020 15:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200427131208.BlueZ.v4.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <CABBYNZ+dh=ypP8hqhPEiB7mu2u5v-AfD+3y2W63_7ZCitJ=dOQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+dh=ypP8hqhPEiB7mu2u5v-AfD+3y2W63_7ZCitJ=dOQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 28 Apr 2020 15:02:24 -0700
Message-ID: <CABmPvSGkW9=f7uFVfwiLB7-UiMm+C6-d+Y7UX+4iw6Hy0YCE=A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4] doc: Add Advertisement Monitoring API
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Great! Thank you so much.

On Mon, Apr 27, 2020 at 2:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Mon, Apr 27, 2020 at 1:16 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This patch proposes an Advertisement Monitoring API for an application to
> > register a job of monitoring ADV reports with content filter and RSSI
> > thresholds.
> > ---
> >
> > Changes in v4:
> > - Change the signature of SupportedMonitorTypes to be array of strings.
> > - Fix document formatting.
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
> >  doc/advertisement-monitor-api.txt | 137 ++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >  create mode 100644 doc/advertisement-monitor-api.txt
> >
> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> > new file mode 100644
> > index 000000000..012fce420
> > --- /dev/null
> > +++ b/doc/advertisement-monitor-api.txt
> > @@ -0,0 +1,137 @@
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
> > +Interface      org.bluez.AdvertisementMonitor1 [experimental]
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
> > +Advertisement Monitor Manager hierarchy
> > +=======================================
> > +Service                org.bluez
> > +Interface      org.bluez.AdvertisementMonitorManager1 [experimental]
> > +Object path    /org/bluez/{hci0,hci1,...}
> > +
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
> > +Properties     array{string} SupportedMonitorTypes [read-only]
> > +
> > +                       This lists the supported types of advertisement
> > +                       monitors. An application should check this before
> > +                       instantiate and expose an object of
> > +                       org.bluez.AdvertisementMonitor1.
> > +
> > +                       Possible values for monitor types:
> > +
> > +                       "patterns_with_logic_or"
> > +                               Patterns with logic OR applied. With this type,
> > +                               property "Patterns" must exist and has at least
> > +                               one pattern.
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
> Applied, thanks, note that I did change the Type to be string as well
> so we is consistent with SupportMonitorTypes.
>
> --
> Luiz Augusto von Dentz
