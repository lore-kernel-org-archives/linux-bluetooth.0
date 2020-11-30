Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69904C63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1952120857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RotZCRpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgK3V31 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbgK3V31 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 16:29:27 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCBDC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:28:47 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id y74so15806829oia.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRjBMK5nNgWBhe9x0Dva81MXFpxIorEfZyVBsP+c3jY=;
        b=RotZCRpcrIUhSCnhEn5yGVjwXYv8gcjbgG+6XljE3cJzg7buBAkzmo3XviDi11DU6F
         4mTaCpkCWaUzR7dVSmBKH4pkg6UR6an8Sgr114pbt1Bwij/ogvxBc9CikUn9GAJ8pEqd
         2GB65T6OsHcDzqzIppvA1lWYIx16Z+GSMa8LA3cRv+KYRcl1Z79EVkGzFs4hguaBH8oL
         d/Gv5Ps1rchrPV6dzISLDP/yLp/JLhgFy7UCU+VLa4yJs+4Zr5NkQ4NxVkGNXaxnPHIo
         DwhjueWwtekFCEn6yofjNleD29Jr2ULFClV+zfz56kVoUQLXxosF/XNfS7Czs39i4yKB
         4Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRjBMK5nNgWBhe9x0Dva81MXFpxIorEfZyVBsP+c3jY=;
        b=L6vLsSfmEfE3PEuDGoPlrIW6g0w2Wfyg/w3HerA7Z1sG6yYCDtX6k0KINyypynbA3N
         ff8DwBSWDlsTlwncOQyUHScYz0dXrCIS90IYJhxxvzfLFiqprfvHSFvZNtH85FKEI2EK
         veoLPUMRdQ4DPdbpThNVVuZwwHhNdsOg7WP6iaJ1oPSJZjguHWC5A8Fda21TzYkj5xvR
         9aF0sKitImoMEVxjo85KcuzowWAjddTWnXcp7F/t43e5fDtNwsB/NoOw/3nkw+Lwci43
         8B2U5X8dV2s+A74lmg7rV4glwZIQbmkeBBvBEOEHFaQCf23n5K0AnY7s5Nfimrzfh5rx
         3vuw==
X-Gm-Message-State: AOAM530A77rklwUIq8/E/7a36W91j3Ij3LDgJNPGy35wZUy5YQNCQXW+
        ucxYEni0TeyCyu1lK33MuvJJZW3o+iw0pBNMnEA=
X-Google-Smtp-Source: ABdhPJw3npwtaQegaD9pTd8VKXb8qyEH6XAm/iSD50rGIwkAqrYkK4SspTHBm8lOQMnaC2DkdmX61ANnPJqX28J0t0k=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr691004oig.161.1606771726567;
 Mon, 30 Nov 2020 13:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20201130200307.386410-1-sonnysasaka@chromium.org> <20201130200307.386410-4-sonnysasaka@chromium.org>
In-Reply-To: <20201130200307.386410-4-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Nov 2020 13:28:35 -0800
Message-ID: <CABBYNZJQebV4_CWjaFUVC4Ab6ZWKqWz0K-sp0sdKgMGxVgtZLQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 4/7] doc: Add Battery Provider API doc
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Nov 30, 2020 at 12:09 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
> index dc7dbeda2..9a6b4fd39 100644
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
> +                       This property is informational only and may be useful
> +                       for debugging purposes.
> +                       Providers from BatteryProvider1 may make use of this
> +                       property to indicate where the battery report comes from
> +                       (e.g. "HFP 1.7", "HID", or the profile UUID).

It seems you didn't address my concern related to use of friendly
names and version numbers here, although this is just an example. I'd
suggest we only accept UUIDs.

> +
> +
> +Battery Provider Manager hierarchy
> +==================================
> +A battery provider starts by registering itself as a battery provider with the
> +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> +it can start exposing org.bluez.BatteryProvider1 objects having the path
> +starting with the given provider ID. It can also remove objects at any time.
> +The objects and their properties exposed by battery providers will be reflected
> +on org.bluez.Battery1 interface.
> +
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
> +
> +
> +Battery Provider hierarchy
> +==========================
> +
> +Service                <client D-Bus address>
> +Interface      org.bluez.BatteryProvider1 [experimental]
> +Object path    {provider_root}/{unique battery object path}
> +
> +Properties     Objects provided on this interface contain the same properties
> +               as org.bluez.Battery1 interface. Additionally, this interface
> +               needs to have the Device property indicating the object path
> +               of the device this battery provides.
> +
> +               object Device [readonly]
> +
> +                       The object path of the device that has this battery.
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
