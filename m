Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A6C83011
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E627E20857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i0sXFQa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgK3V5n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbgK3V5n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 16:57:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A5C0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:57:02 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id m19so2122297ejj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqIEbGKcheEOMHK5QQOKkwuh74LyDjP4/ag1qEiyNPE=;
        b=i0sXFQa8Jl8AN8WI8v8KGXVgwloKzqbvT18rsqUbZwb5872b+B/WFuc5ABNuD2VLtt
         iqVctHMgBIT++UjFX6TEVuEm00XnGEauQIc6iI503z7LVGA9B1xhizxrClOs+MlIPKlm
         2NRyV8zVAm8SglCpNy3PWOcI1Uxwle943i+n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqIEbGKcheEOMHK5QQOKkwuh74LyDjP4/ag1qEiyNPE=;
        b=riXp8nfL/UQqtngx9nv3w8cPGTJuMzOZrisJkEhdTu0PwLyJbrBF4dwMtYvAr6MnO1
         to8RZ1dlbAemvjk6P4xeuBWlPY+sZWqZMS7+1GO3sJZYMqgVYkDEMJWBIE6mS4QzImIn
         fCdyN52d74MY7LcFlcQPeLaCsPE00JDXPK6eRqXboqivRXQvEmn3X7HAoJK8Zwe7ByhG
         DqVhvlCgdik/cJfECnYyIJPl2q18E0WKNLAjm6cO5uOI/Azlj9waoP61z3nNkNGMDEUW
         g4OhVjPrFxxYAAQRPIpqQYB0DZ0v6BB7Kn+bHitlzWX3hStsxNyB8N1kGKXZmT4pH/20
         CwrQ==
X-Gm-Message-State: AOAM532wllbwc8lDLYbkZRMdvHhQKdhhxIHY69cpiaxwBYQSvKSLZfoG
        WurOCei7zIBdJzCUITgrUKkttI+NidaQig==
X-Google-Smtp-Source: ABdhPJyWoFAuGbCZ4xV81oGU0jU9yf0RKFMOl1BvqyhGiJIxQVc1sRR+7G7BhHSNtIx636UovJPwTA==
X-Received: by 2002:a17:906:1f44:: with SMTP id d4mr15326905ejk.368.1606773421074;
        Mon, 30 Nov 2020 13:57:01 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id s5sm6928120eju.98.2020.11.30.13.57.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:57:00 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id z7so18352724wrn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:57:00 -0800 (PST)
X-Received: by 2002:adf:c589:: with SMTP id m9mr2392909wrg.370.1606773419862;
 Mon, 30 Nov 2020 13:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20201130200307.386410-1-sonnysasaka@chromium.org>
 <20201130200307.386410-4-sonnysasaka@chromium.org> <CABBYNZJQebV4_CWjaFUVC4Ab6ZWKqWz0K-sp0sdKgMGxVgtZLQ@mail.gmail.com>
In-Reply-To: <CABBYNZJQebV4_CWjaFUVC4Ab6ZWKqWz0K-sp0sdKgMGxVgtZLQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 30 Nov 2020 13:56:49 -0800
X-Gmail-Original-Message-ID: <CAO271mka6V6sDAg0GH3Cw4Jeo83kH1sEEUegGRkth6L8L0oG2w@mail.gmail.com>
Message-ID: <CAO271mka6V6sDAg0GH3Cw4Jeo83kH1sEEUegGRkth6L8L0oG2w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 4/7] doc: Add Battery Provider API doc
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Nov 30, 2020 at 1:28 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Mon, Nov 30, 2020 at 12:09 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > This patch add the documentation of the Battery Provider which lets
> > external clients feed battery information to BlueZ if they are able to
> > decode battery reporting via any profile. BlueZ UI clients can then use
> > the org.bluez.Battery1 API as a single source of battery information
> > coming from many different profiles.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >
> > ---
> >  doc/battery-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> > index dc7dbeda2..9a6b4fd39 100644
> > --- a/doc/battery-api.txt
> > +++ b/doc/battery-api.txt
> > @@ -12,3 +12,58 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> >  Properties     byte Percentage [readonly]
> >
> >                         The percentage of battery left as an unsigned 8-bit integer.
> > +
> > +               string Source [readonly, optional, experimental]
> > +
> > +                       Describes where the battery information comes from
> > +                       This property is informational only and may be useful
> > +                       for debugging purposes.
> > +                       Providers from BatteryProvider1 may make use of this
> > +                       property to indicate where the battery report comes from
> > +                       (e.g. "HFP 1.7", "HID", or the profile UUID).
>
> It seems you didn't address my concern related to use of friendly
> names and version numbers here, although this is just an example. I'd
> suggest we only accept UUIDs.
I revised the patch. Please take another look.
>
> > +
> > +
> > +Battery Provider Manager hierarchy
> > +==================================
> > +A battery provider starts by registering itself as a battery provider with the
> > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > +starting with the given provider ID. It can also remove objects at any time.
> > +The objects and their properties exposed by battery providers will be reflected
> > +on org.bluez.Battery1 interface.
> > +
> > +BlueZ will stop monitoring these exposed and removed objects after
> > +UnregisterBatteryProvider is called for that provider ID.
> > +
> > +Service                org.bluez
> > +Interface      org.bluez.BatteryProviderManager1 [experimental]
> > +Object path    /org/bluez/{hci0,hci1,...}
> > +
> > +Methods                void RegisterBatteryProvider(object provider)
> > +
> > +                       This registers a battery provider. A registered
> > +                       battery provider can then expose objects with
> > +                       org.bluez.BatteryProvider1 interface described below.
> > +
> > +               void UnregisterBatteryProvider(object provider)
> > +
> > +                       This unregisters a battery provider. After
> > +                       unregistration, the BatteryProvider1 objects provided
> > +                       by this client are ignored by BlueZ.
> > +
> > +
> > +Battery Provider hierarchy
> > +==========================
> > +
> > +Service                <client D-Bus address>
> > +Interface      org.bluez.BatteryProvider1 [experimental]
> > +Object path    {provider_root}/{unique battery object path}
> > +
> > +Properties     Objects provided on this interface contain the same properties
> > +               as org.bluez.Battery1 interface. Additionally, this interface
> > +               needs to have the Device property indicating the object path
> > +               of the device this battery provides.
> > +
> > +               object Device [readonly]
> > +
> > +                       The object path of the device that has this battery.
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
