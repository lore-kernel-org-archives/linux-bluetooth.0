Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC6C56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EE02086A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpMpN+Eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgKXVVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgKXVVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 16:21:22 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020BC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:21:22 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s18so312679oih.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aum/X9Od4wA35Sx6OJZNb0T9DuxiNcfT+bG/Xc9nyZY=;
        b=bpMpN+Eb5Pmk+ychZYLJfJ65P/YsY91xcA5N5xCODMeI7vTAhhWcGIbOTouRKVLjml
         o9VuSFulNiYCgYCrNvrXSgBvGcOLuIdbYEiCvFHF8aDe6//wt3N0J5fbLkG/DcqD0euV
         oYsC5dl7WR9YcMDueiNk7yYqQhohJCXcfUCBBlVvUfup2vMJCLcrGUB8jyEVwkrsXO/i
         zirCDAp78u8ygLIhnEDHHd85jMjSe+5Zbnnjo32GGd4kO5zHwlKs+U2d/DONeJcPpDgY
         wBBVLMvCcBgO5UEBz3bmhRgB0B31+WvXkT+rNQ3hJHC20Md/KEotPOALKZQtE2/BqBi9
         KvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aum/X9Od4wA35Sx6OJZNb0T9DuxiNcfT+bG/Xc9nyZY=;
        b=WzGBbj5gYh0wBM6WnLHliz9KdbbCZzR4FxkDCAyEWpf76srmlASHCWxrStBOk9z8Dg
         kkOgBh+FPbhH48CyVYk8H6NtRP4NAC5MIeWQ4dQ5BsLoC80fMTVczN8+MC9eH6JwG/5f
         8v5zK4gfVeaZ/xXL+MPCr4RJ9w5zM3LtGQTBhcS9X3Ax774O0EoB5sY27d61PIBmN9N3
         64WcRk921szRT3Z33dsdz4M1S+8mBBMeJxv4bUjAvAfUqIZ9ZRIU9T/wf8O5imOOGEqP
         eL684TQoaqrusiePgMrrki9NPBdCOtYShyfTIi9bmBMdHuytb1ueC2yvk8zh8NrdjYsJ
         TdCA==
X-Gm-Message-State: AOAM532RL0mYPxBxZTBFxtd/i7X6/vRjXIBQizKrdkb63jL+9PjVIpVc
        kZHyPQEnYU8+PXpdqiGRO3KaDVGqwTZ1WroaVmM=
X-Google-Smtp-Source: ABdhPJw+dp6iAzOD799tPufevPHOfPVt9ihPPpH0ICtMXt2rMJS+JzeyrqBrU/H1rddBCaA0Uk+ncNsi9/sOxcKYrZw=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr99044oig.161.1606252881694;
 Tue, 24 Nov 2020 13:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20201120205728.339325-1-sonnysasaka@chromium.org> <20201120205728.339325-4-sonnysasaka@chromium.org>
In-Reply-To: <20201120205728.339325-4-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Nov 2020 13:21:10 -0800
Message-ID: <CABBYNZLsGs5KDC8kGY4ahfA1Bmdhz1XaR9kNRBKNxN7dTZoFHw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/7] doc: Add Battery Provider API doc
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Nov 20, 2020 at 1:00 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
> Changes in v3:
> * Remove doc duplication in BatteryProvider1 and mention that it's the
>   same as Battery1 instead.
> * Suggest profile UUID in Source property.
>
>  doc/battery-api.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> index dc7dbeda2..b5c9a7be1 100644
> --- a/doc/battery-api.txt
> +++ b/doc/battery-api.txt
> @@ -12,3 +12,52 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
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

We might need to remove the version number here since there is no
equivalent on UUID, in fact friendly names may be a bad idea after all
since for new profiles we may not have a friendly name to do the
translation and since this is property that would be hard to notify
the provider that we don't understand what is the Source while UUIDs,
if well formatted, should not have this problem so Id just get rid of
the use of friendly names altogether and expect the Source to be a
128bits UUID in string format.

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

We should probably mention this expects an object implementing
ObjectManaged in order to list the Battery1 provider.

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
> +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX

If this is on the client the object path does not necessarily need to
follow our object hierarchy.

> +
> +Properties     Objects provided on this interface contain the same properties
> +               as org.bluez.Battery1 interface.
> --
> 2.26.2



-- 
Luiz Augusto von Dentz
