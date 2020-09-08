Return-Path: <SRS0=n2jO=CR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE761C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39392087D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOnuZLcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgIHRkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbgIHRkG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Sep 2020 13:40:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB828C061573
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2020 10:40:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x19so17261139oix.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2020 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePGggpstFNkFEEnTmmuscQ1dhqKn/sONJ384rV4WzoA=;
        b=bOnuZLcBaNNO2Ev4vohQEajD0KiV6UmoWjrGkPUlfpamdosEbQpIQUSV8G58euzytQ
         uFlyS8sNk11PsKByyYgr8k9FzLxHHQmXorG7dH4WE7YenMUTtPTk8QnDVvMZyZU5vsTc
         BOyacvRCd0dFC2jozjdY9wMyP9e3t6x+VMhv7pQvQw+S8ZNE0pGdtuXujOfUCxtFjDA9
         aQqxklNCu725PSJxxhxl2TKuJaQCrbYXQ/MjrtG8y/ITAcFIa9irOLq1U9vy0PiX1HXF
         0kquodIA4ecnXhWvGjKqk8yppZbxyvTBywnYDUcgWfhNTARRYIRQTCx/GcYRJkOnhfWm
         m3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePGggpstFNkFEEnTmmuscQ1dhqKn/sONJ384rV4WzoA=;
        b=sit568Bu6BDUnEH0txjqcSLwdFm/RZO/0XTgKhB3k+444MMuES7jQCtj2+Fl9jQ7e4
         xvkvnxYsja2X8ziP+NZuUaMIs02HGKmcS3dKCApUWhr3hbkwix2gPXk2DCwom3ORM3I3
         QmltBgmEIgioGghUs5CYrtpMJklQzPKBZQfdbR0py1fCxVckPzEKqCl8Br+7pFE+ue8j
         EpWhfQDwC8KXaRiPSq0aZS0KyDfy7JJ5wWjkzCyPaJYaDdnuCJl43+jeobAeHtlhJHWQ
         FdKDe/9fGDrDCL9dHZWE4kQ77SGvmdhOi4z2H6922ug+tXJzmLnRnM+j9xVKamXDaiG2
         cRIQ==
X-Gm-Message-State: AOAM532U4gDb4gr3qYuMbAnic1TTpJAiC3dd8Lx5wTRQQEdQUIc/Fgwd
        zR1qxDIjKX46KVzREn+T4c4/csHHcTed4t0seLI=
X-Google-Smtp-Source: ABdhPJx95TC36KFLhC2TPIH7NxoPHbzdrgeC9JWqLpINuaR9t+DkWqw55xQI0hzrjsHFGNb0WZ2MTWtrYErvBTHvui0=
X-Received: by 2002:aca:aad0:: with SMTP id t199mr60893oie.48.1599586805263;
 Tue, 08 Sep 2020 10:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
In-Reply-To: <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Sep 2020 10:39:54 -0700
Message-ID: <CABBYNZLCZ9FCEH=Z3sHzsg-jw_4CvnbMxBNbQem=x0JE_+y7NA@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 3:34 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This modifies the following description to Advertisement Monitor API.
> - Add org.bluez.Error.Failed to RegisterMonitor() method.
> - Add more description about the usage of RegisterMonitor() and
> UnregisterMonitor() methods.
> - Add description about the ranges for the fields in property
> RSSIThresholdsAndTimers.
>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> ---
>
>  doc/advertisement-monitor-api.txt | 34 +++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> index 74adbfae9..e09b6fd25 100644
> --- a/doc/advertisement-monitor-api.txt
> +++ b/doc/advertisement-monitor-api.txt
> @@ -49,7 +49,7 @@ Properties    string Type [read-only]
>                         org.bluez.AdvertisementMonitorManager1 for the available
>                         options.
>
> -               (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
> +               (Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
>
>                         This contains HighRSSIThreshold, HighRSSIThresholdTimer,
>                         LowRSSIThreshold, LowRSSIThresholdTimer in order. The
> @@ -66,7 +66,11 @@ Properties   string Type [read-only]
>                         RSSIs of the received advertisement(s) during
>                         LowRSSIThresholdTimer do not reach LowRSSIThreshold.
>
> -               array{(uint8, uint8, string)} Patterns [read-only, optional]
> +                       The valid range of a RSSI is -127 to +20 dBm while 127
> +                       dBm indicates unset. The valid range of a timer is 1 to
> +                       300 seconds while 0 indicates unset.
> +
> +               array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
>
>                         If Type is set to 0x01, this must exist and has at least
>                         one entry in the array.
> @@ -80,8 +84,9 @@ Properties    string Type [read-only]
>                                 See https://www.bluetooth.com/specifications/
>                                 assigned-numbers/generic-access-profile/ for
>                                 the possible allowed value.
> -                       string content_of_pattern
> -                               This is the value of the pattern.
> +                       array{byte} content_of_pattern
> +                               This is the value of the pattern. The maximum
> +                               length of the bytes is 31.
>
>  Advertisement Monitor Manager hierarchy
>  =======================================
> @@ -91,20 +96,31 @@ Object path /org/bluez/{hci0,hci1,...}
>
>  Methods                void RegisterMonitor(object application)
>
> -                       This registers a hierarchy of advertisement monitors.
> +                       This registers the root path of a hierarchy of
> +                       advertisement monitors.
>                         The application object path together with the D-Bus
>                         system bus connection ID define the identification of
>                         the application registering advertisement monitors.
> +                       Once a root path is registered by a client via this
> +                       method, the client can freely expose/unexpose
> +                       advertisement monitors without re-registering the root
> +                       path again. After use, the client should call
> +                       UnregisterMonitor() method to invalidate the
> +                       advertisement monitors.
>
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.AlreadyExists
> +                                        org.bluez.Error.Failed
>
>                 void UnregisterMonitor(object application)
>
> -                       This unregisters advertisement monitors that have been
> -                       previously registered. The object path parameter must
> -                       match the same value that has been used on
> -                       registration.
> +                       This unregisters a hierarchy of advertisement monitors
> +                       that has been previously registered. The object path
> +                       parameter must match the same value that has been used
> +                       on registration. Upon unregistration, the advertisement
> +                       monitor(s) should expect to receive Release() method as
> +                       the signal that the advertisement monitor(s) has been
> +                       deactivated.
>
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.DoesNotExist
> --
> 2.26.2

These are still experimental so you will need to use EXPERIMENTAL
version when declaring the methods/properties so it only gets enabled
when the experimental flag is passed to bluetoothd.


-- 
Luiz Augusto von Dentz
