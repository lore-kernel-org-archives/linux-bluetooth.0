Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA80C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736C922266
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gi08QlF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKQXzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 18:55:45 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:55:44 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so19541edj.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hr0OBg7pTYAS5bqkLFXu3XJazTDgWvVfk/W3QdpXlA=;
        b=Gi08QlF4yE/kgnOpIFFfP8OjULuF4FI3tpfCde79q4YA2gE51j9I5RkJWPiQGjmVUb
         PWj7s8kazzAXS0bfr9jib3xTO1xGwISTud7tU8s7AjYFPOEFC6f1t5WfOiZgj50GBBBo
         8pU7YviPpXCmH8yuEAkZe/yVIv8YROv8/Qi8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hr0OBg7pTYAS5bqkLFXu3XJazTDgWvVfk/W3QdpXlA=;
        b=BlJdIFlDyY+l/ybQHZ+t7e4c9PKmmml49jSWd1JiDhg3Fkv3avKmXd6gB4x0Xo4x0O
         kNrOMEZP1I8Kj7nrpJ61SHeqtdOZMlHPuGqCAUJGwM/2LpM4eZpZhiz7Hu3uqz7ySXus
         yk5Jw9ySJq4JZHQkLwMcpBhkGdTo3nkLZ/rpuuXICFvPyvSDY42EOX0Ep8JXEYaI40dr
         dcFH0osPDNrj7YyqHlr5aFZFUsli22cUN036juye+4MeBf1C28WBJtRLcpyzS340hRuk
         kg3VR/rb2HZB0S27ZZorZ7asIld2INSuWKEMhVKt8/F21zHX2VyJGFdx7JbQjwKKNygD
         vHmw==
X-Gm-Message-State: AOAM532GFsehgBjzLBV4HrHi+pSmJGDnGazcazE6PbdXW6c67HDlybkQ
        eASs5M7Bbr5RNhpfsqtXy4ZJ0VHgvpYdtg==
X-Google-Smtp-Source: ABdhPJwTQNUl+jjvke55H35K2vhs2DYBrk8vpZuLE8laEtiR5uAkd4rqi6mDRR69duoP12/lCKWvtw==
X-Received: by 2002:a05:6402:411:: with SMTP id q17mr23852166edv.125.1605657342479;
        Tue, 17 Nov 2020 15:55:42 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id g7sm12765768edl.5.2020.11.17.15.55.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:55:41 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 10so655218wml.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:55:41 -0800 (PST)
X-Received: by 2002:a1c:7402:: with SMTP id p2mr1518464wmc.104.1605657341087;
 Tue, 17 Nov 2020 15:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-4-sonnysasaka@chromium.org> <CABBYNZJkyOBT63aAYEc4CtCJtqaQEW3bLyyrJ=XJQ_EpeDDmuQ@mail.gmail.com>
 <CAO271mkHCaQ0f+3PKjmnoAqszk1XuUFi_gF5rO9GvsgmqOOiVQ@mail.gmail.com>
 <CABBYNZKebbsGiQueqcE5svRbFON8hgL9wqTqtMFa9m=u+TsO4w@mail.gmail.com>
 <CAO271m=CrnNwfWRg5NKUjTMyw-tHiw1xjHZDgzX9cUfJ9zWyHA@mail.gmail.com> <CABBYNZJ3fwUVusqq2gqeOFu3u+ZD-OQaWdrUHMM1Z7PtgY5jvQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ3fwUVusqq2gqeOFu3u+ZD-OQaWdrUHMM1Z7PtgY5jvQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 Nov 2020 15:55:28 -0800
X-Gmail-Original-Message-ID: <CAO271m=rMLHfjM9uhrMCb9ytcarGjZcYgg56aSNkS-A8DB5YXA@mail.gmail.com>
Message-ID: <CAO271m=rMLHfjM9uhrMCb9ytcarGjZcYgg56aSNkS-A8DB5YXA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/7] doc: Add Battery Provider API doc
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, Nov 17, 2020 at 3:33 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Nov 17, 2020 at 3:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Nov 17, 2020 at 3:01 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Tue, Nov 17, 2020 at 2:37 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Thanks for the feedback. Please find my responses below.
> > > >
> > > > On Mon, Nov 16, 2020 at 4:17 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sonny,
> > > > >
> > > > > On Tue, Nov 10, 2020 at 5:22 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
> > > > > >  doc/battery-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 55 insertions(+)
> > > > > >
> > > > > > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> > > > > > index dc7dbeda2..058bf0c6e 100644
> > > > > > --- a/doc/battery-api.txt
> > > > > > +++ b/doc/battery-api.txt
> > > > > > @@ -12,3 +12,58 @@ Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > > > > >  Properties     byte Percentage [readonly]
> > > > > >
> > > > > >                         The percentage of battery left as an unsigned 8-bit integer.
> > > > > > +
> > > > > > +               string Source [readonly, optional, experimental]
> > > > > > +
> > > > > > +                       Describes where the battery information comes from
> > > > > > +                       (e.g. "HFP 1.7", "HID").
> > > > > > +                       This property is informational only and may be useful
> > > > > > +                       for debugging purposes.
> > > > >
> > > > > We should probably tight this to UUID instead.
> > > > Ack. Will update the doc to suggest UUID in this source field.
> > > >
> > > > >
> > > > > > +
> > > > > > +
> > > > > > +Battery Provider Manager hierarchy
> > > > > > +==================================
> > > > > > +A battery provider starts by registering itself as a battery provider with the
> > > > > > +RegisterBatteryProvider method passing an object path as the provider ID. Then,
> > > > > > +it can start exposing org.bluez.BatteryProvider1 objects having the path
> > > > > > +starting with the given provider ID. It can also remove objects at any time.
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
> > > > > > +
> > > > > > +               void UnregisterBatteryProvider(object provider)
> > > > > > +
> > > > > > +                       This unregisters a battery provider. After
> > > > > > +                       unregistration, the BatteryProvider1 objects provided
> > > > > > +                       by this client are ignored by BlueZ.
> > > > >
> > > > > Not sure if you were followinging the monitor patches, for registering
> > > > > objects we do prefer the ObjectManager style so multiple provider can
> > > > > be registered at once, also we may want to tight the control of
> > > > > battery provider with Profile API so we guarantee that the same entity
> > > > > that handles the profile connection is the one providing the battery
> > > > > status.
> > > > It is actually already in ObjectManager style. After the "root path"
> > > > is registered, the provider can expose many D-Bus objects at once and
> > > > bluetoothd can detect it.
> > > > About tying it with the Profile API, I will take a look at how it could be done.
> > > >
> > > > >
> > > > > > +
> > > > > > +
> > > > > > +Battery Provider hierarchy
> > > > > > +==========================
> > > > > > +
> > > > > > +Service                <client D-Bus address>
> > > > > > +Interface      org.bluez.BatteryProvider1 [experimental]
> > > > > > +Object path    {provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > > > > > +
> > > > > > +Properties     byte Percentage [readonly]
> > > > > > +
> > > > > > +                       The percentage of battery left as an unsigned 8-bit
> > > > > > +                       integer.
> > > > > > +
> > > > > > +               string Source [readonly, optional]
> > > > > > +
> > > > > > +                       Describes where the battery information comes from
> > > > > > +                       (e.g. "HFP 1.7", "HID").
> > > > > > +                       This property is informational only and may be useful
> > > > > > +                       for debugging purposes. The content of this property is
> > > > > > +                       a free string, but it is recommended to include the
> > > > > > +                       profile name and version to be useful.
> > > > > > --
> > > > > > 2.26.2
> > > > >
> > > > > Perhaps we should make this use the same interface as we use for the
> > > > > daemon itself (Battery1) and the Source there as well. Last but not
> > > > > least, have you explored the idea of exporting the battery status over
> > > > > uHID? If I got this right this would aggregate the status of different
> > > > > sources and then make the daemon expose them, which while it works for
> > > > > now it means that upper layer have different interfaces for handling a
> > > > > battery status of something plugged over USB and over Bluetooth.
> > > > I am okay with naming the interface Battery1, the same as the daemon.
> > > > Will make an update.
> > > > About the exporting battery status via UHID, it is possible to be
> > > > done, but it is an orthogonal problem that we plan to tackle
> > > > separately. Right now, this API is general enough for Chrome OS to
> > > > allow both HFP and HID batteries to be consolidated in BlueZ. Chrome
> > > > OS's powerd feeds only Bluetooth battery levels from
> > > > /sys/class/power_supply and filters out USB devices so the UI layer
> > > > does not need to worry about it: everything from BlueZ is tied to a
> > > > Bluetooth device.
> > >
> > > But how about devices pushing their battery status over HID reports
> > > instead of GATT? Afaik this is possible since the HID device may have
> > > support for USB (wired) as well where it exposes its battery status
> > > over HID it may just choose to continue doing so while connected over
> > > Bluetooth.
> > If the Bluetooth device reports battery status via HID, it will go
> > into sys/class/power_supply. In Chrome OS, powerd sends this back to
> > BlueZ because it knows the Bluetooth device address from
> > /sys/class/power_supply/ file name.
>
> Well that is something Id like to avoid since if we do in the future
> create an HID report this sort of logic could cause duplications as it
> either the daemon or the kernel may start parsing these so we will
> need some way to identify each source (perhaps by UUID) to avoid
> duplications. Also having differences in upower and powerd really
> doesn't help us unifying the handling here, I hope at least for
> Bluetooth we end up with something similar when either daemons are
> used, otherwise we may need plugins for each separately.
Duplication is something that we have to deal with, regardless whether
it's about HID or anything else. As I originally proposed and
reflected in the code, we start with the simplest duplicate
resolution: accepting the first one who registered and ignores the
rest. From BlueZ point of view, clients can feed battery information
and it handles the duplication. From external clients point of view,
they do not know whether there is already another source (provider
from HFP does not know that there is already another provider from
FastPair, for example) so what they do is feed what they have and let
BlueZ handle the duplication. With this behavior defined, I don't
understand why it becomes necessary for BlueZ to extract HID battery
information directly? I *do* think it is a good idea, but I don't
understand why it (extracting HID battery directly by BlueZ) is a
prerequisite to have the battery provider API in place.

>
> > >
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
