Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C046C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 22:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD9A221F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 22:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KX4AmIxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgDPWqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgDPWqW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Apr 2020 18:46:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A7EC061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 15:46:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r7so111193ljg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RxpsVjl4t2cnrk6yzcWs0XK4ICmxlqbzV/Hlnay+yw=;
        b=KX4AmIxta8gaF0ocXF5XxwyQif24L9bZ9sjGAI7SkcJv1BccXxZN/HfZBR5itHaltw
         s6+6xr/5RwZuxSZ0RpIgo99Kn8UemHXX98iqwOCiN/SVp2qxxDnrq3DrWdW7J3pZ3cHk
         x2abjqGsPmV1CDCf2oXXFAddFnQ2WzMWHWwEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RxpsVjl4t2cnrk6yzcWs0XK4ICmxlqbzV/Hlnay+yw=;
        b=Z7oiFGzd5+IDZnAwLc/MB3VQDFlkCPkmR76YaT3/5jYUQrt/Qig55rLF8fNomYqHtF
         /antPoI9IDo1fQyhk+slKJRuMr4fmv6zFVaUVbD7U4ef4Az0aI5vRx+G1ARWPnxRh+Xv
         xTr0nApeB7qV28bUeCvUoJcng9Zzgdqjv7TDvW6hy1xGftYNypqoiVwdin6e9q1aUT5J
         4qcwjhcQXXMIE2DbW8Wen87ROxGTRSZHylF/2+NKdUNTN+Yh0iQM0nvRBjyYFI/r09PH
         Hcfyr7ACbdVNBYj4FxFYlDnK00qMWwIlAV+DEoTpSO9RJtfHNvw8kFUrbSyt+wvzpAsR
         zOyg==
X-Gm-Message-State: AGi0PuafyyibA7HPb4Dhcv6xL32WpoWdz/YUtoFhkiRH+JC8AUe6osqa
        BdP6m7yY/4J/PuJI2+GG5lzb9GWtmqe1RzleL1J77g==
X-Google-Smtp-Source: APiQypKK+P8q4b1/k9hHvmSK0GWsHuBynAB3YXHi/liGIr8K45wwrzW9ijlcVFI1Fg0qQMgvEu+WZ4b8xQMGpENnFSY=
X-Received: by 2002:a2e:9644:: with SMTP id z4mr238920ljh.86.1587077180617;
 Thu, 16 Apr 2020 15:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200415200831.BlueZ.v2.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <13923060.5j3lsEUdY8@ix>
In-Reply-To: <13923060.5j3lsEUdY8@ix>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 16 Apr 2020 15:46:09 -0700
Message-ID: <CABmPvSE4SS9__rHdzrp2haCd+t0NXKyVSHx1g1rKt1_5gdMFXQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] doc: Add Advertisement Monitoring API
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

Thanks for your comments. Please see my inline replies below.

On Thu, Apr 16, 2020 at 12:49 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Thursday, 16 April 2020 05:09:03 CEST Miao-chen Chou wrote:
> > This patch proposes an Advertisement Monitoring API for an application to
> > register a job of monitoring ADV reports with content filter and RSSI
> > thresholds.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
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
> >  doc/advertisement-monitor-api.txt | 127 ++++++++++++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 doc/advertisement-monitor-api.txt
> >
> > diff --git a/doc/advertisement-monitor-api.txt
> > b/doc/advertisement-monitor-api.txt new file mode 100644
> > index 000000000..6491dab29
> > --- /dev/null
> > +++ b/doc/advertisement-monitor-api.txt
> > @@ -0,0 +1,127 @@
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
> > +Service              org.bluez
> > +Interface    org.bluez.AdvertisementMonitor1
> > +Object path  freely definable
> > +
> > +Methods              void Release() [noreply]
> > +
> > +                     This gets called as a signal for a client to
> perform
> > +                     clean-up when (1)a monitor cannot be activated
> after it
> > +                     was exposed or (2)a monitor has been
> deactivated.
> > +
> > +             void Activate() [noreply]
>
> Isn't is enough for RegisterApplication to return to ack this?
RegisterApplication() only registers the root of a hierarchy, it
doesn't actually add any monitor, so the return of it reflects the
result of creating the root only. A client can expose some monitors
later under that root, and once bluetooth gets object-added via object
manager, it would call either Release() or Activate() to let the
client know about whether a monitor has been adopted by bluetoothd or
not.
>
> > +
> > +                     After a monitor was exposed, this gets called as
> a
> > +                     signal for client to get acknowledged when a
> monitor
> > +                     has been activated, so the client can expect to
> receive
> > +                     calls on DeviceFound() or DeviceLost().
> > +
> > +             void DeviceFound(object device) [noreply]
> > +
> > +                     This gets called to notify the client of finding
> the
> > +                     targeted device. Once receiving the call, the
> client
> > +                     should start to monitor the corresponding device
> to
> > +                     retrieve the changes on RSSI and advertisement
> content.
> > +
> > +             void DeviceLost(object device) [noreply]
> > +
> > +                     This gets called to notify the client of losing
> the
> > +                     targeted device. Once receiving this call, the
> client
> > +                     should stop monitoring the corresponding device.
> > +
> > +Properties   uint8 Type [read-only]
> > +
> > +                     The type of a monitor can be the following
> values. More
> > +                     will be added.
> > +                     0x01 - Patterns with logic OR applied
> > +                             Supported only if "patterns-with-
> logic-or-
> > +                             applied" is supported.
> > +
> > +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers
> [read-only,
> > optional] +
> > +                     This contains HighRSSIThreshold,
> HighRSSIThresholdTimer,
> > +                     LowRSSIThreshold, LowRSSIThresholdTimer in
> order. The
> > +                     unit of HighRSSIThreshold and LowRSSIThreshold
> is dBm.
> > +                     The unit of HighRSSIThresholdTimer and
> > +                     LowRSSIThresholdTimer is second.
> > +
> > +                     If these are provided, RSSI would be used as a
> factor to
> > +                     notify the client of whether a device stays in
> range or
> > +                     move out of range. A device is considered in-
> range when
> > +                     the RSSIs of the received advertisement(s)
> during
> > +                     HighRSSIThresholdTimer seconds exceed
> HighRSSIThreshold.
> > +                     Likewise, a device is considered out-of-range
> when the
> > +                     RSSIs of the received advertisement(s) during
> > +                     LowRSSIThresholdTimer do not reach
> LowRSSIThreshold.
> > +
> > +             array{(uint8, uint8, string)} Patterns [read-only,
> optional]
> > +
> > +                     If Type is set to 0x01, this must exist and has
> at least
> > +                     one entry in the array.
> > +
> > +                     The structure of a pattern contains the
> following.
> > +                     uint8 start_position
> > +                             The index in an AD data field where
> the search
> > +                             should start. The beginning of an AD
> data field
> > +                             is index 0.
> > +                     uint8 AD_data_type
> > +                             See https://www.bluetooth.com/
> specifications/
> > +                             assigned-numbers/generic-access-
> profile/ for
> > +                             the possible allowed value.
> > +                     string content_of_pattern
> > +                             This is the value of the pattern.
> > +
> > +=======================================
> > +Service              org.bluez
> > +Interface    org.bluez.AdvertisementMonitorManager1
> > +Object path  /org/bluez/{hci0,hci1,...}
> > +Methods              void RegisterApplication(object application)
> > +
> > +                     This registers a hierarchy of advertisement
> monitors.
> > +                     The application object path together with the D-
> Bus
> > +                     system bus connection ID define the
> identification of
> > +                     the application registering advertisement
> monitors.
> > +
> > +                     Possible errors:
> org.bluez.Error.InvalidArguments
> > +
> org.bluez.Error.AlreadyExists
> > +
> > +             void UnregisterApplication(object application)
> > +
> > +                     This unregisters advertisement monitors that
> have been
> > +                     previously registered. The object path parameter
> must
> > +                     match the same value that has been used on
> > +                     registration.
> > +
> > +                     Possible errors:
> org.bluez.Error.InvalidArguments
> > +
> org.bluez.Error.DoesNotExist
> > +
> > +Properties   array{string} SupportedFeatures [read-only]
> > +
> > +                     This reflects the supported features of
> advertisement
> > +                     monitoring. An application should check this
> before
> > +                     instantiate and expose an object of
> > +                     org.bluez.AdvertisementMonitor1.
> > +
> > +                     Here are the potential features. More will be
> added.
> > +                     software-based-filtering
> > +                             The filtering process is mainly done
> in BlueZ.
> > +                     patterns-with-logic-or-applied
> > +                             Logic OR would be applied among the
> patterns
> > +                             provided by a monitor object.
> > +                     rssi-monitoring
> > +                             Values of RSSIThreshholdsAndTimers
> would be
> > +                             applied during the filtering process.
>
>
> I'm bit confused about this API. Why can't this be achieved with (possible
> extended)  SetDiscoveryFilter? We could just add extra prop to Device1 to
> indicate that device is "present".
This API is fundamentally different from the existing APIs. Currently,
in terms of LE there are 2 entries to perform scanning in BlueZ
(bluetoothd + kernel) - (1) Discovery session (with transport dual or
le) actively managed by D-Bus client (2) passive scanning managed by
kernel for auto-reconnection purpose. The intention of (1) is to find
the device ASAP, and (1) is widely used in the case where people open
a Bluetooth setting page to locate the device for pairing or
connection. The intention of (2) is to detect the LE devices for
reconnection, and this is purely done in the kernel. In addition to
(1) and (2), this API intends to provide the third entry to perform
scanning, and that is to allow D-Bus clients to monitor on LE
advertisements with RSSI thresholds and content filtering but without
the need of actively managed by D-Bus in a power efficient way (There
will be future works around offloading filtering to controllers based
on Microsoft HCI extension or Android HCI extension.) This would
empower applications which requires LE scanning in the background and
eventually trigger some events. For instance, prompting a notification
to the user if a new BLE mouse is close by and asking a user if he/she
would like to pair with it, this way, the user doesn't need to
manually look for the targeted device.

Thanks,
Miao
