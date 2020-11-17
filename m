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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF2C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C7C2220B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g99uaS8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgKQXBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKQXBT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 18:01:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BCC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:01:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 79so21143431otc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMnwQtKbGa21SPEAMi/vihnkP/ksN38wNSlZ5UM3lzY=;
        b=g99uaS8VlzCBIMiuEwdV/Ja4crCZ58mL661Y0kNVpl95FX6zKRn3gXIG7Qm0xgw9Nl
         vYoMUP6mOFhMK0LTB4kGE3SuQ5vjPOoSi+AoPwROefgw35DUjOLhUPK+H/iyfBCgh4Br
         Z5yx9k3ulxhJCdOOLUDslcBxZgTusUp5SRjWk9JQjhjjBAGjK/WU9zuk6iyEIt9jqt2n
         RhiOvsKPXm1AknFYdulnxyzq8JhDr4W38q2KylvAzxOTKOeR1OY27DwNp18accufCI0m
         cRdVc/9guAh2YT5eky91TBf+11nuF+uNgBJ7p52LF0YWUE0lCPhTzNToFAmEUcCnhmQ3
         Bs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMnwQtKbGa21SPEAMi/vihnkP/ksN38wNSlZ5UM3lzY=;
        b=nzRbRfk2MU7nAAlHnDYtX84+VCe6rwgNcsvZtrXEqOp2xNcv/ka6lCeJYWge01PkjK
         WbVTZaMMYuThWJre6nn8yxAAEyPozOJM9zSCJC6maek/JDCHFLtKtQuZjoExhUMqLXxW
         MLccJktHaXu3XV+vOQO4H4gk8KbrZE4q3RYnQDIrKo7WS6rJwvLxJxtAdAZmM1lBkt9S
         nnawCsUHw1vKDbEjXzHEsIkot9gBr8TNEpnJNbCHiJnbyqttp8K6Gs4lxgzHHcaIzQwm
         gOzOghpnBmZTOLWF04GYfiyFfE1Dz+Ss8BF9LJWozVStmV7CEgoqO8lmV6TofyAkyBpO
         eOAQ==
X-Gm-Message-State: AOAM533h/rzORaOtJXAELwAl4hK6yvmywU7kC2sWoACT6pInJi/9O/MF
        TA9piPUgywLPLiilg+n2XW6EYT5q4nRE7Vo2dbo=
X-Google-Smtp-Source: ABdhPJxH2tXiJShYk13SfbtFvtxbKYrl07OcwHNmeRc9m+p4Hk5ySqhyv4qbndaW3QESpJ6XFFdptXzRq2quKh0B7ME=
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr4436125ote.240.1605654078245;
 Tue, 17 Nov 2020 15:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-4-sonnysasaka@chromium.org> <CABBYNZJkyOBT63aAYEc4CtCJtqaQEW3bLyyrJ=XJQ_EpeDDmuQ@mail.gmail.com>
 <CAO271mkHCaQ0f+3PKjmnoAqszk1XuUFi_gF5rO9GvsgmqOOiVQ@mail.gmail.com>
In-Reply-To: <CAO271mkHCaQ0f+3PKjmnoAqszk1XuUFi_gF5rO9GvsgmqOOiVQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Nov 2020 15:01:07 -0800
Message-ID: <CABBYNZKebbsGiQueqcE5svRbFON8hgL9wqTqtMFa9m=u+TsO4w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/7] doc: Add Battery Provider API doc
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Nov 17, 2020 at 2:37 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for the feedback. Please find my responses below.
>
> On Mon, Nov 16, 2020 at 4:17 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Tue, Nov 10, 2020 at 5:22 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
> > >  doc/battery-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > >
> > > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> > > index dc7dbeda2..058bf0c6e 100644
> > > --- a/doc/battery-api.txt
> > > +++ b/doc/battery-api.txt
> > > @@ -12,3 +12,58 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > >  Properties     byte Percentage [readonly]
> > >
> > >                         The percentage of battery left as an unsigned 8-bit integer.
> > > +
> > > +               string Source [readonly, optional, experimental]
> > > +
> > > +                       Describes where the battery information comes from
> > > +                       (e.g. "HFP 1.7", "HID").
> > > +                       This property is informational only and may be useful
> > > +                       for debugging purposes.
> >
> > We should probably tight this to UUID instead.
> Ack. Will update the doc to suggest UUID in this source field.
>
> >
> > > +
> > > +
> > > +Battery Provider Manager hierarchy
> > > +==================================
> > > +A battery provider starts by registering itself as a battery provider with the
> > > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > > +starting with the given provider ID. It can also remove objects at any time.
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
> > > +
> > > +               void UnregisterBatteryProvider(object provider)
> > > +
> > > +                       This unregisters a battery provider. After
> > > +                       unregistration, the BatteryProvider1 objects provided
> > > +                       by this client are ignored by BlueZ.
> >
> > Not sure if you were followinging the monitor patches, for registering
> > objects we do prefer the ObjectManager style so multiple provider can
> > be registered at once, also we may want to tight the control of
> > battery provider with Profile API so we guarantee that the same entity
> > that handles the profile connection is the one providing the battery
> > status.
> It is actually already in ObjectManager style. After the "root path"
> is registered, the provider can expose many D-Bus objects at once and
> bluetoothd can detect it.
> About tying it with the Profile API, I will take a look at how it could be done.
>
> >
> > > +
> > > +
> > > +Battery Provider hierarchy
> > > +==========================
> > > +
> > > +Service                <client D-Bus address>
> > > +Interface      org.bluez.BatteryProvider1 [experimental]
> > > +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > > +
> > > +Properties     byte Percentage [readonly]
> > > +
> > > +                       The percentage of battery left as an unsigned 8-bit
> > > +                       integer.
> > > +
> > > +               string Source [readonly, optional]
> > > +
> > > +                       Describes where the battery information comes from
> > > +                       (e.g. "HFP 1.7", "HID").
> > > +                       This property is informational only and may be useful
> > > +                       for debugging purposes. The content of this property is
> > > +                       a free string, but it is recommended to include the
> > > +                       profile name and version to be useful.
> > > --
> > > 2.26.2
> >
> > Perhaps we should make this use the same interface as we use for the
> > daemon itself (Battery1) and the Source there as well. Last but not
> > least, have you explored the idea of exporting the battery status over
> > uHID? If I got this right this would aggregate the status of different
> > sources and then make the daemon expose them, which while it works for
> > now it means that upper layer have different interfaces for handling a
> > battery status of something plugged over USB and over Bluetooth.
> I am okay with naming the interface Battery1, the same as the daemon.
> Will make an update.
> About the exporting battery status via UHID, it is possible to be
> done, but it is an orthogonal problem that we plan to tackle
> separately. Right now, this API is general enough for Chrome OS to
> allow both HFP and HID batteries to be consolidated in BlueZ. Chrome
> OS's powerd feeds only Bluetooth battery levels from
> /sys/class/power_supply and filters out USB devices so the UI layer
> does not need to worry about it: everything from BlueZ is tied to a
> Bluetooth device.

But how about devices pushing their battery status over HID reports
instead of GATT? Afaik this is possible since the HID device may have
support for USB (wired) as well where it exposes its battery status
over HID it may just choose to continue doing so while connected over
Bluetooth.

> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
