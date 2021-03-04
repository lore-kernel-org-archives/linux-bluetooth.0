Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A396C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421CE64F6B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCDUIv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbhCDUIs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:08:48 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28272C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:08:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f33so28482544otf.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pi-supply-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pn9hR9Hfchld8zv2zdWQHBg9GYTnOAR7rWDMfQhO/yw=;
        b=nziJkSYdTJbQLEgL7S+LfcYoKyYyVbJuJVL1A2cUgNlEEBjjfAFG4TiLONnvYHhzPc
         4qOHA7gu/PjLsayLjUEC98Z6Rbz2D6q0pG//p3TTYRdUQayxI4x5wcqyDcItxMrlQr7H
         wUeJO04Fqzac9tKYKYu4ekM7gz5T5UB/vj9rpjBj8cIl+tNU/lkAqno0pJbVxm3gYSbN
         vQPvMLMpDlzvw3SW6BLBhLvPH4CvUk0lQ+RuQMFfp7bT1f5TgBDeRq9QLrqMNKv/q9Zu
         FID6+WkoY3FCv8OQYohknYEqZToabi8xiRCYpml/ydoZ4FdNUdauevTef5Drjs4dWFdt
         AIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pn9hR9Hfchld8zv2zdWQHBg9GYTnOAR7rWDMfQhO/yw=;
        b=hqHq9UpDPzq7vtOt5DuYauNFrQBbc1TbB3BL5fJKww89YXvxDWlU1zQCmfr5vLvuJj
         W3sBoRvn2qAlfyx6tk6Otahg/fsM7UwefSqzpkk8yFnbqgzGMaetFHX6FgreHzJddj2M
         zcSXOB3HJw0Z7EBgmIE6iDhE5Bt6ruTFvXIYmWe2yszsmZzTIt9isKb51w0siSgTJjxj
         Xm6WhCVCs7IHYVk9Qi6wOywKKZi7VnQkxEtFmsBn7uZP1pt272VvWiyXYtY1NujTHYGi
         EoBWh0n1m9cFzR1XSo6tMGzwrPk42oMv8rZ2fxEtEKCMsEHBjoaV+h6/+Aiggz9jVmPR
         K8Dw==
X-Gm-Message-State: AOAM532YRA9MquoxHYVEpOqnh8g498hycoLqkXTY/jP6WW/0j+K3ELLi
        OeIWq7LMvzs4VG8Rd4oWaozXawf+/v2bp3okAiDd6w==
X-Google-Smtp-Source: ABdhPJzLGqhjeTcRDoWUZh1rFKTWtvDuII4107077eFMFmCu1Gx9uWWyJq5RquvRx6KCX1RzOnKJz1PYdrVDaLgRuEU=
X-Received: by 2002:a9d:74cc:: with SMTP id a12mr3126825otl.135.1614888487544;
 Thu, 04 Mar 2021 12:08:07 -0800 (PST)
MIME-Version: 1.0
References: <CA+0z1OhRZcC0F8kq4HFduJTZqehfaUfNowQBjoR1-vCk6w9Kng@mail.gmail.com>
 <CABBYNZK-Nf-aEsKxjCyGYm1-6nSyxRHCa1eZ3be6CqyYxHAeTw@mail.gmail.com>
In-Reply-To: <CABBYNZK-Nf-aEsKxjCyGYm1-6nSyxRHCa1eZ3be6CqyYxHAeTw@mail.gmail.com>
From:   Ryan Walmsley <ryan@pi-supply.com>
Date:   Thu, 4 Mar 2021 20:07:56 +0000
Message-ID: <CA+0z1OhhQa96d3RCFeHHRz+R=6tTohV3mhCS63GeFVQ3BvA03w@mail.gmail.com>
Subject: Re: BlueZ Creates conflicting deviceinfo service.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the response.

We use our program to set characteristics 2A29 (Manufacturer Name),
2A26 (Firmware) and 2A25 (Serial Number) under the 180A service. I
can't see where in main.conf I can set these variables.

However for our use case this wouldn't really be a suitable method as
we have the software running in docker containers communicating with
bluez on the host via dbus. Setting the above values in main.conf
would require more than just the containers to be updated each time we
bump a new firmware version.

I have tried removing the service before we add outs using the
"unregister-service 0x0000180a-0000-1000-8000-00805f9b34f" feature in
bluetoothctl but just get a failed to unregister service issue.

While it might not be the ideal way to do it this way where we create
the service,  however if it was flagged at the time of commit that
enabled BlueZ to provide this service that it could cause stuff to
break then surely it's more an issue with BlueZ and the suggested
override should be added?


On Thu, Mar 4, 2021 at 7:36 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ryan,
>
> On Thu, Mar 4, 2021 at 11:10 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
> >
> > Hi,
> >
> > We've been working on something that uses Bluetooth to provide GATT
> > services and recently have updated to BlueZ 5.55 from 5.53 and have
> > found an issue.
> >
> > It seems that in the newer version a commit was made
> > (d5e07945c4aa36a83addc3c269f55c720c28afdb) that enabled the service
> > 0x180A with characteristic 0x2A50.
>
> Yep, DIS is controlled by the daemon since you can set the vendor,
> product and version using main.conf.
>
> > However as our software creates a service on 0x180A it causes a
> > conflict, as the application we are making our software with reads
> > from the first service available which is the one generated by BlueZ.
>
> You should probably stop doing that and just use main.conf to set the
> values you want to be published, we should actually blacklist DIS to
> be registered by applications since that is defined by the platform
> having the application to override may actually cause problems.
>
> > It looks like it was discussed about a kill switch being added of
> > "DeviceIdOverLE" to then disable this but I can't find any reference
> > to this at all.
> >
> > How would be best to disable this?
>
> Disable DIS on the application, you can actually check if the adapter
> has enabled it already using its UUIDs:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n321
>
> bluetoothctl also can be use to print the list of UUIDs that the
> adapter is exposing (0000180a-0000-1000-8000-00805f9b34fb is DIS):
>
> [bluetooth]# show
> Controller 00:AA:01:01:00:24 (public)
> Name:
> Alias:
> Class: 0x00000000
> Powered: no
> Discoverable: no
> DiscoverableTimeout: 0x000000b4
> Pairable: yes
> UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
> UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
> UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
> UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
> UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
> UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v1D6Bp0246d0538
> Discovering: no
> Roles: central
> Roles: peripheral
> Advertising Features:
> ActiveInstances: 0x00 (0)
> SupportedInstances: 0x01 (1)
> SupportedIncludes: tx-power
> SupportedIncludes: appearance
> SupportedIncludes: local-name
> SupportedSecondaryChannels: 1M
> SupportedSecondaryChannels: 2M
> SupportedSecondaryChannels: Coded
>
> > --
> > Ryan Walmsley
> >
> > Engineer
> >
> > Pi Supply Unit 4 Bells Yew Green Business Court,
> > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
>
>
>
> --
> Luiz Augusto von Dentz



-- 

Ryan Walmsley

Engineer

Pi Supply Unit 4 Bells Yew Green Business Court,
Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
Email us at sales@pi-supply.com
