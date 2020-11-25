Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F93C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 00:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428712151B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 00:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkjfsYdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKYAX2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKYAX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 19:23:27 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A10C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 16:23:27 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l10so89851ooh.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG3xc5aGQcCjPGjq0duDmXODBFAoYaZ5yQBrwdx0m00=;
        b=WkjfsYdSlF4VURzt06OALKNYWoiTghI2k5ATwA3jxhnivyFo66lhDfWG+MokuHTMb9
         Z+OSrxK3DDXpYs3Sd/ObX324vMJvLe3ta1r7AsC8MtoG3nffu9b0/26eH/SFJudRu+Rc
         QfiWofj2erVbdcYk7HA9MpqAjWOsW57zAcve4x+aa+SjW2SiMjAuTv5H9aLjpk4xVIDJ
         gkJoX2pitWy/cEGZj3kfhCyB/U9b44EMfc8eFhTcItf3G2X+J1iiDh93hi2C7rx6vcMW
         VR+PVPQ0JPflL/0GnUrOlS5HWPYc9p2VZezNbGPdy6tMzKUiKUN0h85XCqmnWvHMH+Po
         uNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG3xc5aGQcCjPGjq0duDmXODBFAoYaZ5yQBrwdx0m00=;
        b=bN8hNZORLTwbGzIQPb4qC/bNfvnjmWodb2QRiYsh3hWplj6jH2Ezz69SqYOZSUoSXI
         6+azezLZF37uj9Hzcc4XndGBphBJLS9+bmsVeQAyKvutSD4jNQWVhvhSG89G/hBps98/
         pdrX/dHI82xDYb772xlREiXLpgPRJDodW7U0OeUKx8Nl1xnltkp5vYu7gRpev54xxxdS
         s4N/n+d5i8oAkJUQf22zfXCqgLWX7jyoFwcaBTpufqT4vQMbnt2XeDDFAngvTYkeVQQp
         qvqI75FLjj+ZiFZDu8DKBdK41vvZozf8DBzsU6K//O8t9EOS4pv5DKAZm/1MkEfEGect
         MxFQ==
X-Gm-Message-State: AOAM533POaqeij/FIlu9G3EPhzGDvGGDqTJOlw2gGCMpmGmmSu//M31L
        WhZrUKiHl9b+z1XPE30WtNhtjB2oU7bwwzoEHVs=
X-Google-Smtp-Source: ABdhPJzpaA46u3B28RAhLeQvpF9LT14oALdBehM1gtLXuQyIm+3KYCsXLtF0SytkI0iQPH7lXMn6D0baLp1NAFCm4F4=
X-Received: by 2002:a4a:8849:: with SMTP id e9mr844507ooi.65.1606263806632;
 Tue, 24 Nov 2020 16:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
 <20201120205728.339325-4-sonnysasaka@chromium.org> <CABBYNZLsGs5KDC8kGY4ahfA1Bmdhz1XaR9kNRBKNxN7dTZoFHw@mail.gmail.com>
 <CAO271m=Bsz8NXtHzjAn5iYxMs0hxd17DW9QCUnXZACywTDVcvg@mail.gmail.com>
In-Reply-To: <CAO271m=Bsz8NXtHzjAn5iYxMs0hxd17DW9QCUnXZACywTDVcvg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Nov 2020 16:23:15 -0800
Message-ID: <CABBYNZ+ZtmfNxQRd1Zai__htG=xhg+iz-LZw=ktn3b49PwP1xg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/7] doc: Add Battery Provider API doc
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Nov 24, 2020 at 1:30 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
>
> On Tue, Nov 24, 2020 at 1:21 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Fri, Nov 20, 2020 at 1:00 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > This patch add the documentation of the Battery Provider which lets
> > > external clients feed battery information to BlueZ if they are able to
> > > decode battery reporting via any profile. BlueZ UI clients can then use
> > > the org.bluez.Battery1 API as a single source of battery information
> > > coming from many different profiles.
> > >
> > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > >
> > > ---
> > > Changes in v3:
> > > * Remove doc duplication in BatteryProvider1 and mention that it's the
> > >   same as Battery1 instead.
> > > * Suggest profile UUID in Source property.
> > >
> > >  doc/battery-api.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >
> > > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> > > index dc7dbeda2..b5c9a7be1 100644
> > > --- a/doc/battery-api.txt
> > > +++ b/doc/battery-api.txt
> > > @@ -12,3 +12,52 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > >  Properties     byte Percentage [readonly]
> > >
> > >                         The percentage of battery left as an unsigned 8-bit integer.
> > > +
> > > +               string Source [readonly, optional, experimental]
> > > +
> > > +                       Describes where the battery information comes from
> > > +                       This property is informational only and may be useful
> > > +                       for debugging purposes.
> > > +                       Providers from BatteryProvider1 may make use of this
> > > +                       property to indicate where the battery report comes from
> > > +                       (e.g. "HFP 1.7", "HID", or the profile UUID).
> >
> > We might need to remove the version number here since there is no
> > equivalent on UUID, in fact friendly names may be a bad idea after all
> > since for new profiles we may not have a friendly name to do the
> > translation and since this is property that would be hard to notify
> > the provider that we don't understand what is the Source while UUIDs,
> > if well formatted, should not have this problem so Id just get rid of
> > the use of friendly names altogether and expect the Source to be a
> > 128bits UUID in string format.
> Ack. Will change to 128bit UUID format.
> >
> > > +
> > > +
> > > +Battery Provider Manager hierarchy
> > > +==================================
> > > +A battery provider starts by registering itself as a battery provider with the
> > > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > > +starting with the given provider ID. It can also remove objects at any time.
> > > +The objects and their properties exposed by battery providers will be reflected
> > > +on org.bluez.Battery1 interface.
> > > +
> > > +BlueZ will stop monitoring these exposed and removed objects after
> > > +UnregisterBatteryProvider is called for that provider ID.
> > > +
> > > +Service                org.bluez
> > > +Interface      org.bluez.BatteryProviderManager1 [experimental]
> > > +Object path    /org/bluez/{hci0,hci1,...}
> > > +
> > > +Methods                void RegisterBatteryProvider(object provider)
> > > +
> > > +                       This registers a battery provider. A registered
> > > +                       battery provider can then expose objects with
> > > +                       org.bluez.BatteryProvider1 interface described below.
> >
> > We should probably mention this expects an object implementing
> > ObjectManaged in order to list the Battery1 provider.
> Ack. Will add more explanation.
> >
> > > +               void UnregisterBatteryProvider(object provider)
> > > +
> > > +                       This unregisters a battery provider. After
> > > +                       unregistration, the BatteryProvider1 objects provided
> > > +                       by this client are ignored by BlueZ.
> > > +
> > > +
> > > +Battery Provider hierarchy
> > > +==========================
> > > +
> > > +Service                <client D-Bus address>
> > > +Interface      org.bluez.BatteryProvider1 [experimental]
> > > +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> >
> > If this is on the client the object path does not necessarily need to
> > follow our object hierarchy.
> We need a convention to match the exposed object by the battery
> provider and BlueZ's device. I am suggesting that the simplest
> convention is to use the same path of the BlueZ's device object, which
> is easy to follow and implement by providers. Otherwise, we would
> still need another convention to match them, but I think any other
> convention is likely more complex to implement by battery providers.
> Can you suggest an alternative convention to match the battery and the
> device?

I thought the objects would be registered directly on the device
object itself but it looks like it is on the adapter thus why you need
the device in the first place, but if you are using the object path it
is just a matter of moving BatteryProviderManager1 to the device
object.

> >
> > > +
> > > +Properties     Objects provided on this interface contain the same properties
> > > +               as org.bluez.Battery1 interface.
> > > --
> > > 2.26.2
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
