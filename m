Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF2CC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 05:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C322087C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 05:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOVc1Mgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768514AbgJZFZm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 01:25:42 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34887 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768512AbgJZFZl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 01:25:41 -0400
Received: by mail-ot1-f50.google.com with SMTP id n11so6980921ota.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2020 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lADaFIka9MOeF6+EUbDF6MECLcr4NRcQlLYLeos4eHU=;
        b=WOVc1MgsAQ+wFyLI6ESpnAXUQmlO9c8ecA8DIrmTpWvM+W+QSFdO9ZLRHoj93Q1yib
         XCHMR9gNbaIUA8I8OtUuxI55P5pG/1kGzNwtJubq/xSdKzCMKdaGMWmkQYLrYW4y+cbW
         CdFjW5Zc5F5JR5OMse/PIgNcStXpg9lo1xF0a73SjGua55J8YWq6ciCufaBaFeBjW1Ig
         Xyae+KxkMCa++/ftavmh7ANyUR1C4QskzW4RjF1//mdrO7tIZBzCZch8doFp/4QYMHFx
         DDV3opU/BTTAdqS/Anefn8Vc3Pl6JWrm/qd92Ja/5XWuVGZCElPO0+ja0OjoCd+FlcMf
         T4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lADaFIka9MOeF6+EUbDF6MECLcr4NRcQlLYLeos4eHU=;
        b=uMSIcXIQei4nAd8Br3O5LFiVWxNhtxHUvzfhyklc8ma/dOQe4IFX1V1DxiBuw2ttQ4
         1nH2YT/aO7dxfqt8eX+9EX5Fq7ulZtiB7bt6Egugj+5/d6lDjO4Unl2Dj5WYE4f4w0p1
         A+Xp8lJPlIdf/Czpo9fEjLFHHbr4Ld2dD8vdyDEQm//JyandYmZsMED0yVWRKMaG0Mos
         h9Jz3a+UknYaloV20djUWeuXPG3Fbr6+YuQLt+HR1YhYf2r6AotFAd1HirIxEy3AQ3zx
         ZhNnU6csfGnowuqQkkrOa/zHxVbNXunjlXRHVRw6WlWwXdSNN3sv4J10lPciIhzTaBa3
         ogQw==
X-Gm-Message-State: AOAM532sv9CLQe0ptQLq4gazO+IfL+2x2ETFVxF0pAJyKA18cDGO9YdH
        6LmhlPMMNjXXc/VhyNl/j99m62uaCZRYrn3XXhM=
X-Google-Smtp-Source: ABdhPJyowuUzgpx6kAV9iEVn+7k6YBdU7U/5wZDhLF1g9KkNF/+wnOHACFHFAuefvtJ7aZ0Ko7B+uIz+jbepxN9kyBA=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr9817357otq.240.1603689940394;
 Sun, 25 Oct 2020 22:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACUBSc-wspy_yNuV49he6nR7hi-WVquRNAcasfK7MEOs6EB6HA@mail.gmail.com>
In-Reply-To: <CACUBSc-wspy_yNuV49he6nR7hi-WVquRNAcasfK7MEOs6EB6HA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 25 Oct 2020 22:25:29 -0700
Message-ID: <CABBYNZJwKk-vxJB-7H+j3SDwosWqhhLkteFx6DLMMoVOfPvTjg@mail.gmail.com>
Subject: Re: ASHA
To:     Peter Barrett <vk6fun@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Sat, Oct 24, 2020 at 4:46 AM Peter Barrett <vk6fun@gmail.com> wrote:
>
> Hi thanks for indulging me. Wondering if this hearing aid streaming
> service can be implemented in the Linux bluetooth stack. So far only
> found in iPhone and some Android phones
> There is more information at https://source.android.com/devices/bluetooth/asha
> I would be happy to help with testing if anyone is interested.
> I have a Nucleus7 CochlearSpeech Processor and I can connect to it
> with this RPi4B running 5.4.71-v7l+ with bluetoothd v5.5
> bluetoothctl v5.49 gives the following output:
>
> [bluetooth] [0m# list-attributes 84:77:XX:XX:XX:XX
> Primary Service
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075
> 0000fdf0-0000-1000-8000-00805f9b34fb
> Unknown
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007f
> 2d410339-82b6-42aa-b34e-e2e01df8cc1a
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007d
> 00e4ca9e-ab14-41e4-8823-f9e70c7e91df
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007a
> 38663f1a-e711-4cac-b641-326b56404837
> Vendor specific
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007a/desc007c
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char0078
> f0d4de7e-4a88-476c-9d9f-1937b0996cc0
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char0076
> 6333651e-c481-4a3e-9169-7c902aad37bb
> Vendor specific
> Primary Service
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064
> 3c3c6c6b-c9bc-4704-bb14-2ffd32b5aa31
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0073
> 18e77d96-c2a2-4da9-a848-436a8aea81ba
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0071
> 8e5abd16-d6e0-4efb-8881-4d9d257b017a
> Vendor specific
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006e
> 962020af-7715-4f77-b8db-b2ea0e89415b
> Vendor specific
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006e/desc0070
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006b
> 47c7e464-7bb4-4c8b-9515-3a2141b65300
> Vendor specific
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006b/desc006d
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0068
> 0472ca69-929b-44ad-9821-97078d06c362
> Vendor specific
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0068/desc006a
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0065
> 31291857-6a7e-4b77-8655-feb603498758
> Vendor specific
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0065/desc0067
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> Primary Service
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a
> 0000180a-0000-1000-8000-00805f9b34fb
> Device Information
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0015
> 00002a50-0000-1000-8000-00805f9b34fb
> PnP ID
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0013
> 00002a26-0000-1000-8000-00805f9b34fb
> Firmware Revision String
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0011
> 00002a27-0000-1000-8000-00805f9b34fb
> Hardware Revision String
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000f
> 00002a25-0000-1000-8000-00805f9b34fb
> Serial Number String
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000d
> 00002a24-0000-1000-8000-00805f9b34fb
> Model Number String
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000b
> 00002a29-0000-1000-8000-00805f9b34fb
> Manufacturer Name String
> Primary Service
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001
> 00001801-0000-1000-8000-00805f9b34fb
> Generic Attribute Profile
> Characteristic
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001/char0002
> 00002a05-0000-1000-8000-00805f9b34fb
> Service Changed
> Descriptor
> /org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001/char0002/desc0004
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration

It should be possible to implement it, but it probably doesn't make
sense to implement it as a plugin to bluetoothd given its proprietary
status it might be better to implement as part of an application.

-- 
Luiz Augusto von Dentz
