Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A4C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 19:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3142E20704
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 19:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjXR1k8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDXTig (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgDXTig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 15:38:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE6C09B048
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 12:38:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 72so14489900otu.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayXZdQW3Ixf8tc8FDnwyxka20Av9zwLO17ctcMqENm8=;
        b=pjXR1k8Cw6/0utnt0u922LnfCHmfDuL8hL7jxKBZ5YpVUbFN3FdcmG5DVodVLXf0sx
         so3k8K/8UgeekyPUQwnqMfsRZ8Q8cUS2J15PBccwXi8ZuDqXF4HyP4YlVU1bXzPfRil4
         5G2OUOeRbASuEAvEvY/5tYgPArz5QsHWeY7Rfc9W32Ic+Av+hHZxaE2ONg+PbjDjsCse
         cF5wPPlxL0QGgPT+KNOjrI6ptM/BJRmgltGeIMB4gaH6PXfX3Grc7HX6M84zGmV1D53K
         4ml77lXxkOXv0mcB1LuJoTHhxo530ilj0VPxakn7IJ7fRwAn/EGxdaU8IosRW1qw5tnP
         LhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayXZdQW3Ixf8tc8FDnwyxka20Av9zwLO17ctcMqENm8=;
        b=Spqor07dOTYs0RHSAi9Z+EWzQzjvg6rR4GXQ+eBX0dDVesuGAObi+FZQxTWLHgpzkm
         cZB+8SBS2rtmoE2LF2R6g/jVf/bWjknPEe/my0huQDOdj9dd+0EZqNKzen4tP930fVEb
         dClwtOZcO0YS2Go+M1mu0iY+QhIld/aZSmtDYhL6xPc485a749iEGJLQUoOM+5ZZIfF9
         nfa2/HLHOfaecTUKwCeU2AUuW8ca1MxJcaDzVY51iHnbS5cwS9stsewS42y7nyEwrmht
         Dd0pNABsGeimV4EDp6aHYCuYBJev1nMkz3r3XFqcA9xnRZerUr86OoJSY49NOWkFQRMM
         GRjg==
X-Gm-Message-State: AGi0Pua2tha98l/IgF7Vz5hs+JyuA9Fl8yVwjyA121DsZrIeWWrfASTc
        MBPd7tQ3dEiwDI/tSPXv7DqoMJmL5zhcqxNnZ1w=
X-Google-Smtp-Source: APiQypJ6Pn1F6l618CVEgcDb4we8GOFKWN+GR0ftL8WwX+0YZABLwOdxdjxRDTsOStFFKwZClPVnPdcrbHAyrJNoFSg=
X-Received: by 2002:a9d:644:: with SMTP id 62mr8103027otn.177.1587757115232;
 Fri, 24 Apr 2020 12:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200423141423.BlueZ.v3.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
In-Reply-To: <20200423141423.BlueZ.v3.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Apr 2020 12:38:23 -0700
Message-ID: <CABBYNZ+xN4GCDq2hiuHUG9Y3bgA38W_r2nW+UBwnwyUdo9UhAQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc: Add Advertisement Monitoring API
To:     Miao-chen Chou <mcchou@chromium.org>
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

Hi Miao,

On Thu, Apr 23, 2020 at 2:17 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This patch proposes an Advertisement Monitoring API for an application to
> register a job of monitoring ADV reports with content filter and RSSI
> thresholds.
> ---
>
> Changes in v3:
> - Introduce SupportedFeatures to reflect the features based on
> controller's capabilities.
> - Modify SupportedMonitorTypes to list available types of monitors.
>
> Changes in v2:
> - Rename the interfaces and functions.
> - Adopt the object manager mechanism so that a client can expose
> multiple monitor objects and expect to get notified on whether the
> monitor has been activated or not.
> - Change the contract of DeviceFound so that it is called to indicate
> the starting point of monitoring on a device instead of reporting every
> ADV. In other words, the client is expected to monitor corresponding
> device events.
>
>  doc/advertisement-monitor-api.txt | 134 ++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 doc/advertisement-monitor-api.txt
>
> diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> new file mode 100644
> index 000000000..b8b01536a
> --- /dev/null
> +++ b/doc/advertisement-monitor-api.txt
> @@ -0,0 +1,134 @@
> +BlueZ D-Bus Advertisement Monitor API Description
> +*************************************************
> +
> +This API allows an client to specify a job of monitoring advertisements by
> +registering the root of hierarchy and then exposing advertisement monitors
> +under the root with filtering conditions, thresholds of RSSI and timers
> +of RSSI thresholds.
> +
> +Once a monitoring job is activated by BlueZ, the client can expect to get
> +notified on the targeted advertisements no matter if there is an ongoing
> +discovery session (a discovery session is started/stopped with methods in
> +org.bluez.Adapter1 interface).
> +
> +Advertisement Monitor hierarchy
> +===============================
> +Service                org.bluez
> +Interface      org.bluez.AdvertisementMonitor1
> +Object path    freely definable
> +
> +Methods                void Release() [noreply]
> +
> +                       This gets called as a signal for a client to perform
> +                       clean-up when (1)a monitor cannot be activated after it
> +                       was exposed or (2)a monitor has been deactivated.
> +
> +               void Activate() [noreply]
> +
> +                       After a monitor was exposed, this gets called as a
> +                       signal for client to get acknowledged when a monitor
> +                       has been activated, so the client can expect to receive
> +                       calls on DeviceFound() or DeviceLost().
> +
> +               void DeviceFound(object device) [noreply]
> +
> +                       This gets called to notify the client of finding the
> +                       targeted device. Once receiving the call, the client
> +                       should start to monitor the corresponding device to
> +                       retrieve the changes on RSSI and advertisement content.
> +
> +               void DeviceLost(object device) [noreply]
> +
> +                       This gets called to notify the client of losing the
> +                       targeted device. Once receiving this call, the client
> +                       should stop monitoring the corresponding device.
> +
> +Properties     uint8 Type [read-only]
> +
> +                       The type of the monitor. See SupportedMonitorTypes in
> +                       org.bluez.AdvertisementMonitorManager1 for the available
> +                       options.
> +
> +               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> +
> +                       This contains HighRSSIThreshold, HighRSSIThresholdTimer,
> +                       LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> +                       unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
> +                       The unit of HighRSSIThresholdTimer and
> +                       LowRSSIThresholdTimer is second.
> +
> +                       If these are provided, RSSI would be used as a factor to
> +                       notify the client of whether a device stays in range or
> +                       move out of range. A device is considered in-range when
> +                       the RSSIs of the received advertisement(s) during
> +                       HighRSSIThresholdTimer seconds exceed HighRSSIThreshold.
> +                       Likewise, a device is considered out-of-range when the
> +                       RSSIs of the received advertisement(s) during
> +                       LowRSSIThresholdTimer do not reach LowRSSIThreshold.
> +
> +               array{(uint8, uint8, string)} Patterns [read-only, optional]
> +
> +                       If Type is set to 0x01, this must exist and has at least
> +                       one entry in the array.
> +
> +                       The structure of a pattern contains the following.
> +                       uint8 start_position
> +                               The index in an AD data field where the search
> +                               should start. The beginning of an AD data field
> +                               is index 0.
> +                       uint8 AD_data_type
> +                               See https://www.bluetooth.com/specifications/
> +                               assigned-numbers/generic-access-profile/ for
> +                               the possible allowed value.
> +                       string content_of_pattern
> +                               This is the value of the pattern.
> +
> +=======================================
> +Service                org.bluez
> +Interface      org.bluez.AdvertisementMonitorManager1
> +Object path    /org/bluez/{hci0,hci1,...}
> +Methods                void RegisterApplication(object application)
> +
> +                       This registers a hierarchy of advertisement monitors.
> +                       The application object path together with the D-Bus
> +                       system bus connection ID define the identification of
> +                       the application registering advertisement monitors.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.AlreadyExists
> +
> +               void UnregisterApplication(object application)
> +
> +                       This unregisters advertisement monitors that have been
> +                       previously registered. The object path parameter must
> +                       match the same value that has been used on
> +                       registration.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.DoesNotExist
> +
> +Properties     array{uint8} SupportedMonitorTypes [read-only]
> +
> +                       This lists the supported types of advertisement
> +                       monitors. An application should check this before
> +                       instantiate and expose an object of
> +                       org.bluez.AdvertisementMonitor1.
> +
> +                       Possible values for monitor types:
> +
> +                       0x01    Patterns with logic OR applied. With this type,
> +                               property "Patterns" must exist and has at least
> +                               one pattern.

Perhaps we should also have this as string, D-Bus don't really support
enums and it makes the types easier to debug if we express in them as
strings.

> +
> +               array{string} SupportedFeatures [read-only]
> +
> +                       This lists the features of advertisement monitoring
> +                       supported by BlueZ.
> +
> +                       Possible values for features:
> +
> +                       "controller-based-monitor-by-patterns"
> +                               If the controller is capable of performing
> +                               advertisement monitoring by patterns, BlueZ
> +                               would offload the patterns to the controller to
> +                               reduce power consumption.
> --
> 2.24.1

Other than that it looks good to me, the only thing Id mark this
interface as experimental for now so we still allow changes if we deem
necessary.


-- 
Luiz Augusto von Dentz
