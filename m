Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE62C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D28223124
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbhAFTC6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbhAFTC6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 14:02:58 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD94BC06134C
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 11:02:17 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id e15so2346571vsa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yswo6jacExdlkQbOinSMm6fgWM1NkYxIWMNj1LlTB1I=;
        b=RnkDDsR0z9Z5wWLGVPWkTkBQiKOqS6Q7/BLqFzVzCxMVmh/DXKvFcz08kdCo3i4ai9
         GzPnnMYlMNZizxRHLlBmPDrT1B9l1rdwLwL2NYaQHTHb7aEU5wVSwlWIdM0lJj1bQJQn
         hOXcPHheu6WOR0uxsKAOheR/2rY1ShFJ/CBqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yswo6jacExdlkQbOinSMm6fgWM1NkYxIWMNj1LlTB1I=;
        b=B0gMOM+3fTNG9W75q8MN1dE/+BhW5BZL/z+gu4kKqBet84nJ61sl0fLJHneU32/Ckg
         /v6ptmFmVbfzTkAq4YtuowpvdXj4zKWVgRoTdqwfj6+qb5GzXtdejR403AxGiurY0bjJ
         JQS6Sa9gRK2r05POaMmiK6paldI7OS4RTdqZAdpAfCSLutqN5XthyjnVzz1PM35UcMwP
         kC/4k9DPfkRUCpdEL+AxA+L9HHUE0OFxPDTWjs9SaUKDThPByZ8fiiHZrRnU/yAMtF4G
         vhJGXda/8+vqUN6QO7xYfsXIYaM8Dhp7gIU0BE8Q5k6zq1hGLU2CwDvZAKOa4uS1FZQH
         1deg==
X-Gm-Message-State: AOAM531YON6GXHPYGZyY8SWMbaRagj7bIvXIqDt6luTCNJ18WEb7TiHa
        FUgxWDx5gNeaJfU26ZUu/LjB3THqjQxtSgIFYxqT4g==
X-Google-Smtp-Source: ABdhPJwVHCGFO3PeF07THo8lpVOwBsIItaNZ01CnRC/fCY330JxsUv6miRFK8JP1wTVirNvi0K7N75X4JfdyZIuHy+A=
X-Received: by 2002:a67:c983:: with SMTP id y3mr4363240vsk.59.1609959736237;
 Wed, 06 Jan 2021 11:02:16 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 6 Jan 2021 11:02:04 -0800
Message-ID: <CANFp7mXtX4H=tQ5usRiOXRBzfuQORc6-MCznbjmsMBRAQMo36w@mail.gmail.com>
Subject: Re: BT large file transfer failed when do suspend/resume test
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sherry,

On Wed, Jan 6, 2021 at 5:40 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Hi Abhishek,
>
> I want to ask you some questions about your patch: Bluetooth: Handle BR/EDR devices during suspend. (https://patchwork.kernel.org/project/bluetooth/patch/20200311085359.RFC.v6.2.Icc7c35e1cabf10f8a383a009694987520f1d1b35@changeid/)
>
> Platform: L5.10 + Bluez5.55 + Marvell BT chip
>
> Background: Our test team usually try suspend/resume test when transferring large file through BT, to see if the file transfer can be continued after suspend/resume. It can works well before L5.10
> But we found on L5.10, the BT connection lost if we try to suspend/resume, so the file transfer(through OBEX Object Push) shows failed. Then we found your patches when debugging.
>
> Questions:
> 1. Before L5.10, kernel always keep BT connected during suspend/resume. So why we need to disconnect all the BT devices when system suspend now?

Bluetooth has often been a source of spurious wakes in the past. Using
rfkill or masking the wake interrupt were used in the past to make
this more reliable but this was resulting in instability on the
controller (controller needs to drop traffic if host is asleep and
there's no clean way to do that).

The new suspend behavior is the following:
- All devices get disconnected during suspend.
- Only HID devices can wake the device from suspend (i.e. Remote
Wake). The BT controller will be configured to scan (page scan and/or
LE passive scan) based on currently paired devices. If the device is
not configured for wakeup (i.e. power/wakeup in sysfs is "disabled"),
we will not configure this scanning either (see the hdev->prevent_wake
implementation in btusb for an example)
- On resume, devices that support a2dp-sink will be automatically reconnected

This results in more reliable behavior from Bluetooth around suspend
while allowing Remote Wake to work properly.

> 2. I found that the device been disconnected due to suspend won't been auto-connected after resume, shouldn't we get the BT device auto-connected after resume like wifi devices done?

We do this currently only for Bluetooth headphones (reconnect on
a2dp-sink service). I'm not familiar with Obex so I don't know if this
would work for that as well. I did send up a patch making reconnect on
resume configurable based on service uuid that may be relevant to
this: https://patchwork.kernel.org/project/bluetooth/patch/20201207154903.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid/

> 3. For the large file transfer, if the BT been disconnected during suspend, the transfer will fail, do we have any methods to avoid this issue?

If you have an active transfer, does it make sense to be suspending?
Perhaps you should hold a wakelock while a transfer is ongoing.
I am not sure how Obex and other services should behave here so I will
defer to Luiz and Marcel's opinion on this topic.

>
> I'm new to Bluetooth, there are many things I don't understand, looking forward to your answer, and thanks for now!
>
> Best regards
> Sherry sun
>

Thanks
Abhishek
