Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A7C63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B332B206C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dh7aeIfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgK3UDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgK3UDw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 15:03:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE3C0613D4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:12 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k4so17992118edl.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gm/4uQK2GuqgNOcEo3y8CdZNSz/uayd35zOUF0pAuD0=;
        b=dh7aeIfkVJk6UwN1Ruh5kx+Qk6TPz2k26YnUEQvhq7pp8gOA0f3ux4efq3CafB0BQH
         r+f5cin7yeFH6rps7PguNmNfIHGBjhGuQyI79f1XoqduPTfSVYB49pk/jItR48mIn41Y
         1t7kYRcvtWKRfn/Haa1VFuZwVxFmi2qQJ+j1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gm/4uQK2GuqgNOcEo3y8CdZNSz/uayd35zOUF0pAuD0=;
        b=H+YoMUJNXkfQUI3znFZZt3QIEr4aQlfAgbqeE5n8IDDUqyB/IdSgaqY14Yc4wW+76m
         5a7YWRSQeheOj+EULGpZ35sYQjJMO5kDBUAKSXJGqOMD+8kSKv1PU5Is6HBFZt9lbK1B
         HrNxKpV2x6xTHHfVPL0qbzops1igAlCZPoIFionnymK35zWoOPn3WxP8pLH8JkGt58IE
         I6zTNkSBoJ+t58khaz5fBVlSPnkuxY3lvz8vw3tx/ypApqw90s4xcXj3Z3tUy3kBvzSV
         NzHHRqObLlOQfbUpqhADbHVZW+OiQpR/OfG530JmcVIvQa2C4HDz+gwyXjkWsF10BjDP
         hPjA==
X-Gm-Message-State: AOAM531LQ52A9qqFxcI+9+VAaLJ5GLemEdrlUgAEcmzN5krS/pOpcAmn
        3xiXrbUgPKR1epoK8ZS4iJJINHnnElyiHg==
X-Google-Smtp-Source: ABdhPJw3uU0EVvS66Gd5vYJDLRfD8GAMBkTQn1099KLmSglEBiBlhY5tLpZDFqvGWZlP09c2yUqgMA==
X-Received: by 2002:aa7:c603:: with SMTP id h3mr4016012edq.254.1606766590591;
        Mon, 30 Nov 2020 12:03:10 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id mb15sm139375ejb.9.2020.11.30.12.03.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:03:09 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id x22so647898wmc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:09 -0800 (PST)
X-Received: by 2002:a1c:68d6:: with SMTP id d205mr548912wmc.154.1606766588674;
 Mon, 30 Nov 2020 12:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
 <20201120205728.339325-4-sonnysasaka@chromium.org> <CABBYNZLsGs5KDC8kGY4ahfA1Bmdhz1XaR9kNRBKNxN7dTZoFHw@mail.gmail.com>
 <CAO271m=Bsz8NXtHzjAn5iYxMs0hxd17DW9QCUnXZACywTDVcvg@mail.gmail.com>
 <CABBYNZ+ZtmfNxQRd1Zai__htG=xhg+iz-LZw=ktn3b49PwP1xg@mail.gmail.com>
 <CAO271mmNvaFuuG9Sv8EHZ6+giYvom8FfWCmQJvJTUfgmsJ3GjA@mail.gmail.com> <CABBYNZ+o+WXYZYdJdyAvHHJ2xZ6Bz21pwQ2m2h6N5AW3nkftng@mail.gmail.com>
In-Reply-To: <CABBYNZ+o+WXYZYdJdyAvHHJ2xZ6Bz21pwQ2m2h6N5AW3nkftng@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 30 Nov 2020 12:02:57 -0800
X-Gmail-Original-Message-ID: <CAO271mmkD4Yg9DKjj2ednfoxY7OVcigNKR4bCf-5mPv4B72Cbw@mail.gmail.com>
Message-ID: <CAO271mmkD4Yg9DKjj2ednfoxY7OVcigNKR4bCf-5mPv4B72Cbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/7] doc: Add Battery Provider API doc
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sat, Nov 28, 2020 at 10:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Nov 24, 2020 at 5:20 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Nov 24, 2020 at 4:23 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Tue, Nov 24, 2020 at 1:30 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > >
> > > > On Tue, Nov 24, 2020 at 1:21 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sonny,
> > > > >
> > > > > On Fri, Nov 20, 2020 at 1:00 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > > >
> > > > > > This patch add the documentation of the Battery Provider which lets
> > > > > > external clients feed battery information to BlueZ if they are able to
> > > > > > decode battery reporting via any profile. BlueZ UI clients can then use
> > > > > > the org.bluez.Battery1 API as a single source of battery information
> > > > > > coming from many different profiles.
> > > > > >
> > > > > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > > > >
> > > > > > ---
> > > > > > Changes in v3:
> > > > > > * Remove doc duplication in BatteryProvider1 and mention that it's the
> > > > > >   same as Battery1 instead.
> > > > > > * Suggest profile UUID in Source property.
> > > > > >
> > > > > >  doc/battery-api.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 49 insertions(+)
> > > > > >
> > > > > > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> > > > > > index dc7dbeda2..b5c9a7be1 100644
> > > > > > --- a/doc/battery-api.txt
> > > > > > +++ b/doc/battery-api.txt
> > > > > > @@ -12,3 +12,52 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > > > > >  Properties     byte Percentage [readonly]
> > > > > >
> > > > > >                         The percentage of battery left as an unsigned 8-bit integer.
> > > > > > +
> > > > > > +               string Source [readonly, optional, experimental]
> > > > > > +
> > > > > > +                       Describes where the battery information comes from
> > > > > > +                       This property is informational only and may be useful
> > > > > > +                       for debugging purposes.
> > > > > > +                       Providers from BatteryProvider1 may make use of this
> > > > > > +                       property to indicate where the battery report comes from
> > > > > > +                       (e.g. "HFP 1.7", "HID", or the profile UUID).
> > > > >
> > > > > We might need to remove the version number here since there is no
> > > > > equivalent on UUID, in fact friendly names may be a bad idea after all
> > > > > since for new profiles we may not have a friendly name to do the
> > > > > translation and since this is property that would be hard to notify
> > > > > the provider that we don't understand what is the Source while UUIDs,
> > > > > if well formatted, should not have this problem so Id just get rid of
> > > > > the use of friendly names altogether and expect the Source to be a
> > > > > 128bits UUID in string format.
> > > > Ack. Will change to 128bit UUID format.
> > > > >
> > > > > > +
> > > > > > +
> > > > > > +Battery Provider Manager hierarchy
> > > > > > +==================================
> > > > > > +A battery provider starts by registering itself as a battery provider with the
> > > > > > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > > > > > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > > > > > +starting with the given provider ID. It can also remove objects at any time.
> > > > > > +The objects and their properties exposed by battery providers will be reflected
> > > > > > +on org.bluez.Battery1 interface.
> > > > > > +
> > > > > > +BlueZ will stop monitoring these exposed and removed objects after
> > > > > > +UnregisterBatteryProvider is called for that provider ID.
> > > > > > +
> > > > > > +Service                org.bluez
> > > > > > +Interface      org.bluez.BatteryProviderManager1 [experimental]
> > > > > > +Object path    /org/bluez/{hci0,hci1,...}
> > > > > > +
> > > > > > +Methods                void RegisterBatteryProvider(object provider)
> > > > > > +
> > > > > > +                       This registers a battery provider. A registered
> > > > > > +                       battery provider can then expose objects with
> > > > > > +                       org.bluez.BatteryProvider1 interface described below.
> > > > >
> > > > > We should probably mention this expects an object implementing
> > > > > ObjectManaged in order to list the Battery1 provider.
> > > > Ack. Will add more explanation.
> > > > >
> > > > > > +               void UnregisterBatteryProvider(object provider)
> > > > > > +
> > > > > > +                       This unregisters a battery provider. After
> > > > > > +                       unregistration, the BatteryProvider1 objects provided
> > > > > > +                       by this client are ignored by BlueZ.
> > > > > > +
> > > > > > +
> > > > > > +Battery Provider hierarchy
> > > > > > +==========================
> > > > > > +
> > > > > > +Service                <client D-Bus address>
> > > > > > +Interface      org.bluez.BatteryProvider1 [experimental]
> > > > > > +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > > > >
> > > > > If this is on the client the object path does not necessarily need to
> > > > > follow our object hierarchy.
> > > > We need a convention to match the exposed object by the battery
> > > > provider and BlueZ's device. I am suggesting that the simplest
> > > > convention is to use the same path of the BlueZ's device object, which
> > > > is easy to follow and implement by providers. Otherwise, we would
> > > > still need another convention to match them, but I think any other
> > > > convention is likely more complex to implement by battery providers.
> > > > Can you suggest an alternative convention to match the battery and the
> > > > device?
> > >
> > > I thought the objects would be registered directly on the device
> > > object itself but it looks like it is on the adapter thus why you need
> > > the device in the first place, but if you are using the object path it
> > > is just a matter of moving BatteryProviderManager1 to the device
> > > object.
> > If we move BatteryProviderManager1 to the device object, that means we
> > can't use the object manager style and providers have to register each
> > battery once rather than registering once in the beginning and expose
> > several objects afterwards, so this would lose your suggestion to use
> > object manager in the first place. I prefer we stick to using object
> > manager style, it is simple, easy to understand and implement for
> > providers (refer to my python test app in one of the patches in this
> > series).
>
> Well not really, you can still use the object manager style the only
> difference is that you will register on a per-device basis instead of
> per adapter, not every device is going to have battery providers but
> some can have multiple providers from different profiles, but I guess
> you were suggesting that one could register a single time per adapter
> so we don't have round trips of registration per device in which case
> then I would prefer to just have a property indicating the device
> object path, but note that if there are different entities handling
> different profiles each would have to register individually anyway.
I like your idea of explicitly specifying the device path for each
provided battery. I will send a v4 for this change. Please take another look.


>
> > >
> > > > >
> > > > > > +
> > > > > > +Properties     Objects provided on this interface contain the same properties
> > > > > > +               as org.bluez.Battery1 interface.
> > > > > > --
> > > > > > 2.26.2
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
