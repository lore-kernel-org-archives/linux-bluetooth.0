Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EE4C6379D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4D206E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEIb8aJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgKQWht (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgKQWhs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 17:37:48 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC48C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:37:48 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so3957941ejj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEzBSD/AMZFTCsg5PjvB40b+tF/UQWduVMCbxO989o0=;
        b=ZEIb8aJAMKE0Jlz2xD6MUL3RXBBg2HUr5kEL26nXCY0XjWHApV5JWS4qUhdvmB6gHl
         rlPk6hkuXPjsE84YFOV9e3kPA9cs0sDXNezi/l6ZZAGGcRRSwOxdp+Bzt2SVsf5nfbWi
         DepfcU83ydHIzV+BLScUTmLRBd0GKryOWhdIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEzBSD/AMZFTCsg5PjvB40b+tF/UQWduVMCbxO989o0=;
        b=QWsDwkN8q+hVO4SK9fFMu5ttjUOjnk29DtSfa9vafB9dTNDSVSHf6VS9Eu58p1GxLr
         m/XjvH9VOL5GMi4YMi/d+vcOPIgnRf5cCmsXdrrudb3C8XNQ2+nPAnhEM7IrhfsentO9
         hjWOfTNza1veKs8ot8JcszCkY5ofmNJ2VdxgMyl1RjrPd8cL/5rKH96u2ERfSfbJuXWz
         cz0xvZ29sVz3pXu7MGOOuXOaqIfub50vOVN9OooW1QZhV5ulMe15ZDyob6CNsOZhFMCm
         oUEgcEDjZhceHmlRlTJEqtHuEy90l7HxZEQlbmvwXaYdu0iZk7zfCgZyJf9+qYI9QAKP
         uo5g==
X-Gm-Message-State: AOAM531T8j+8MtjxjcDMvq/Np6dDB2SWfgD1vhcEdS2HH4jBm7GdVTAB
        QnuQw1ML1L9t0RdV5mG0/3vSZOu90GA10w==
X-Google-Smtp-Source: ABdhPJw09OARuLzRGOrbQlz3O6Oyqik3fXnj1lQ+jjqFg6PFKbBVarvWoXFsUEiMhU1pqR7kghTVTg==
X-Received: by 2002:a17:906:d9dd:: with SMTP id qk29mr22075889ejb.487.1605652666701;
        Tue, 17 Nov 2020 14:37:46 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id x20sm12059733ejv.66.2020.11.17.14.37.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:37:45 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 19so322204wmf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 14:37:45 -0800 (PST)
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr1175412wmh.141.1605652665212;
 Tue, 17 Nov 2020 14:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-4-sonnysasaka@chromium.org> <CABBYNZJkyOBT63aAYEc4CtCJtqaQEW3bLyyrJ=XJQ_EpeDDmuQ@mail.gmail.com>
In-Reply-To: <CABBYNZJkyOBT63aAYEc4CtCJtqaQEW3bLyyrJ=XJQ_EpeDDmuQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 Nov 2020 14:37:33 -0800
X-Gmail-Original-Message-ID: <CAO271mkHCaQ0f+3PKjmnoAqszk1XuUFi_gF5rO9GvsgmqOOiVQ@mail.gmail.com>
Message-ID: <CAO271mkHCaQ0f+3PKjmnoAqszk1XuUFi_gF5rO9GvsgmqOOiVQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/7] doc: Add Battery Provider API doc
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the feedback. Please find my responses below.

On Mon, Nov 16, 2020 at 4:17 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Nov 10, 2020 at 5:22 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
> > index dc7dbeda2..058bf0c6e 100644
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
> > +                       (e.g. "HFP 1.7", "HID").
> > +                       This property is informational only and may be useful
> > +                       for debugging purposes.
>
> We should probably tight this to UUID instead.
Ack. Will update the doc to suggest UUID in this source field.

>
> > +
> > +
> > +Battery Provider Manager hierarchy
> > +==================================
> > +A battery provider starts by registering itself as a battery provider with the
> > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > +starting with the given provider ID. It can also remove objects at any time.
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
>
> Not sure if you were followinging the monitor patches, for registering
> objects we do prefer the ObjectManager style so multiple provider can
> be registered at once, also we may want to tight the control of
> battery provider with Profile API so we guarantee that the same entity
> that handles the profile connection is the one providing the battery
> status.
It is actually already in ObjectManager style. After the "root path"
is registered, the provider can expose many D-Bus objects at once and
bluetoothd can detect it.
About tying it with the Profile API, I will take a look at how it could be done.

>
> > +
> > +
> > +Battery Provider hierarchy
> > +==========================
> > +
> > +Service                <client D-Bus address>
> > +Interface      org.bluez.BatteryProvider1 [experimental]
> > +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > +
> > +Properties     byte Percentage [readonly]
> > +
> > +                       The percentage of battery left as an unsigned 8-bit
> > +                       integer.
> > +
> > +               string Source [readonly, optional]
> > +
> > +                       Describes where the battery information comes from
> > +                       (e.g. "HFP 1.7", "HID").
> > +                       This property is informational only and may be useful
> > +                       for debugging purposes. The content of this property is
> > +                       a free string, but it is recommended to include the
> > +                       profile name and version to be useful.
> > --
> > 2.26.2
>
> Perhaps we should make this use the same interface as we use for the
> daemon itself (Battery1) and the Source there as well. Last but not
> least, have you explored the idea of exporting the battery status over
> uHID? If I got this right this would aggregate the status of different
> sources and then make the daemon expose them, which while it works for
> now it means that upper layer have different interfaces for handling a
> battery status of something plugged over USB and over Bluetooth.
I am okay with naming the interface Battery1, the same as the daemon.
Will make an update.
About the exporting battery status via UHID, it is possible to be
done, but it is an orthogonal problem that we plan to tackle
separately. Right now, this API is general enough for Chrome OS to
allow both HFP and HID batteries to be consolidated in BlueZ. Chrome
OS's powerd feeds only Bluetooth battery levels from
/sys/class/power_supply and filters out USB devices so the UI layer
does not need to worry about it: everything from BlueZ is tied to a
Bluetooth device.

>
>
> --
> Luiz Augusto von Dentz
