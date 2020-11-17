Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DCC388F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DBE2465E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGGdAaCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgKQARA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgKQARA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 19:17:00 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA647C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:16:58 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w145so20748997oie.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drfr4OO5IXdiUxJlH3rbt+m7FzhiSe/+rW/x4KEO21E=;
        b=pGGdAaCG0ZyxtA5GExTeEXW4gOBRWXxSxP+3RlgREegWP1cOuBwxwk7fTp6yKOwMGG
         nx3rDqt18PeN14ZI5xwbbtuMUYy0xGgFW/zGaNGR7xHgWtfxC0woYSwrO7t8Is6KId/G
         YGNJp+3la6yJKTwTCrm+5fS1cTkzZJoT4iIHSSCP6iO1dl3i+ZYDm8T2Yk+C8tHkbf+U
         xjPDAjjp3uYrelXq5/I0NzbaIl8dUtcyMjQoOMP0eCSlb/fXviXm+yNhoTYrsEnM6Abh
         +1mv1JWaR/roUabjXzelf+l0lsCyJCiJjTtA+lTM3c+B/2DplaWM0TRCZnN9551eluVh
         Nxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drfr4OO5IXdiUxJlH3rbt+m7FzhiSe/+rW/x4KEO21E=;
        b=t/yK5s2ZQqzlsAYJDJ5/HOk95pYu7svaUId5zi1nX9Wnb0iw1+j+etbh0GYUQ/1aLS
         upTtE3V5fkcWoDOlI+jBq6PyT2Qrvel0T8qF5C6mZ2uUVxdULnaTwFfZTXwpjf43sWCP
         dtgMTwkJwL8CnSD9MQFb2XYqD/Cd9qtJHJveENtAxXn0AIN/PrqhXay3Plt057bY50fI
         K+L3HLGO1EaLsbFPqZojl+2RVgR5cYulzThYUcaZSijaUs9pZaY5lzcc07ZCTOR5q19T
         dCVCRo29GP4uBwyouwRgbJN11SBqrK11Mt4QemWCjthBLQLgu5NefAf4MFLSF/Z4xqhl
         LlhQ==
X-Gm-Message-State: AOAM531i9rJH4ZRZfqBWQ/vQpGD4Q682z9jetDZroZX1Felk1/ymsqlf
        IykNKfbb53HDwxJ1pD5A6Vh8d2v4vQT5Ps5mMs5D01IF
X-Google-Smtp-Source: ABdhPJwD0UkXx//xZFg603J8rxIihvXMaR40LBlZvezktrQ/kXLMVxE9RREKLCqtp5hZK3PG8/SovAEn8vNXWttF/cw=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr749183oig.161.1605572218234;
 Mon, 16 Nov 2020 16:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org> <20201111011745.2016-4-sonnysasaka@chromium.org>
In-Reply-To: <20201111011745.2016-4-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Nov 2020 16:16:47 -0800
Message-ID: <CABBYNZJkyOBT63aAYEc4CtCJtqaQEW3bLyyrJ=XJQ_EpeDDmuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/7] doc: Add Battery Provider API doc
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Nov 10, 2020 at 5:22 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This patch add the documentation of the Battery Provider which lets
> external clients feed battery information to BlueZ if they are able to
> decode battery reporting via any profile. BlueZ UI clients can then use
> the org.bluez.Battery1 API as a single source of battery information
> coming from many different profiles.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  doc/battery-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> index dc7dbeda2..058bf0c6e 100644
> --- a/doc/battery-api.txt
> +++ b/doc/battery-api.txt
> @@ -12,3 +12,58 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>  Properties     byte Percentage [readonly]
>
>                         The percentage of battery left as an unsigned 8-bit integer.
> +
> +               string Source [readonly, optional, experimental]
> +
> +                       Describes where the battery information comes from
> +                       (e.g. "HFP 1.7", "HID").
> +                       This property is informational only and may be useful
> +                       for debugging purposes.

We should probably tight this to UUID instead.

> +
> +
> +Battery Provider Manager hierarchy
> +==================================
> +A battery provider starts by registering itself as a battery provider with the
> +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> +it can start exposing org.bluez.BatteryProvider1 objects having the path
> +starting with the given provider ID. It can also remove objects at any time.
> +BlueZ will stop monitoring these exposed and removed objects after
> +UnregisterBatteryProvider is called for that provider ID.
> +
> +Service                org.bluez
> +Interface      org.bluez.BatteryProviderManager1 [experimental]
> +Object path    /org/bluez/{hci0,hci1,...}
> +
> +Methods                void RegisterBatteryProvider(object provider)
> +
> +                       This registers a battery provider. A registered
> +                       battery provider can then expose objects with
> +                       org.bluez.BatteryProvider1 interface described below.
> +
> +               void UnregisterBatteryProvider(object provider)
> +
> +                       This unregisters a battery provider. After
> +                       unregistration, the BatteryProvider1 objects provided
> +                       by this client are ignored by BlueZ.

Not sure if you were followinging the monitor patches, for registering
objects we do prefer the ObjectManager style so multiple provider can
be registered at once, also we may want to tight the control of
battery provider with Profile API so we guarantee that the same entity
that handles the profile connection is the one providing the battery
status.

> +
> +
> +Battery Provider hierarchy
> +==========================
> +
> +Service                <client D-Bus address>
> +Interface      org.bluez.BatteryProvider1 [experimental]
> +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Properties     byte Percentage [readonly]
> +
> +                       The percentage of battery left as an unsigned 8-bit
> +                       integer.
> +
> +               string Source [readonly, optional]
> +
> +                       Describes where the battery information comes from
> +                       (e.g. "HFP 1.7", "HID").
> +                       This property is informational only and may be useful
> +                       for debugging purposes. The content of this property is
> +                       a free string, but it is recommended to include the
> +                       profile name and version to be useful.
> --
> 2.26.2

Perhaps we should make this use the same interface as we use for the
daemon itself (Battery1) and the Source there as well. Last but not
least, have you explored the idea of exporting the battery status over
uHID? If I got this right this would aggregate the status of different
sources and then make the daemon expose them, which while it works for
now it means that upper layer have different interfaces for handling a
battery status of something plugged over USB and over Bluetooth.


-- 
Luiz Augusto von Dentz
