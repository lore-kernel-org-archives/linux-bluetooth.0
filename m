Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B85C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D26508C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCEQFR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhCEQE7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 11:04:59 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC411C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 08:04:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v12so2244928ott.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1XOhxDY/OrbZxvekTilQD0xHqcmTeI8Vc0IHI6eIyg=;
        b=sZtct8FrnxHiYpdxSDgN7dqRX9Myyz7nTSwFT+onZ9rn0n8PEy7zOHVQEGEsKVbMjU
         oQZhnnyWUS9yuMX07YCQ8ezMymML6jc/fQ7Pi/f/FX85wRNzZCZPYQLLlRXe1fVFd2iO
         qDIj4ycMlrd39LGkz8Or41jPUb/JvHnzFG1aysbCTSr+c+x9hu9ioGGODw1jC05WzFS/
         IqjkrJMqOChBX4O8890IyfESyvtabvkPM+a9Cua31ws3n+JXpf2MOeNf/bx26oN44cAv
         6wobZ/r2opNmRSwv/YjoL83zLBcz4rDCc0BKwweA8GR0vWI84Kwh40GDj0Fnrm65uugN
         RTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1XOhxDY/OrbZxvekTilQD0xHqcmTeI8Vc0IHI6eIyg=;
        b=OHuSOvwj52TVtqXVYJriZwOPse5DOYp+8ahdkCqBN6oxA5LO76mhhmswhrogrSWcXt
         AVrgtBByhhdV/rKZM6s+hVNFlrIh1u9/430rNqtosbaiG45+UjDnMhdLQvmY7fWdls3E
         t+BwSLDyKGWs+NwjSydJy3pmfLFqNLw3oEiOfHiFpCJVWJBPmwHpz8G7WvnrkBORi0je
         G2c/BfSa8srRQ6DfD3Zb3f1UHxHJOLO3sAwW//KR+WVuy4sRs9O2DDRHE3ksbEdFhMbk
         erDtv//c2SYAOTnrkVtnf86oD8xKCDUN/M6+Pbl1UeTw6nnGDbCEumJiWrfkAIH/wBMw
         58oQ==
X-Gm-Message-State: AOAM530+AFzK5bLgwC/TRCIkXMoc0XMbeygyrK0bkEJ7whVd4kRzceV6
        Twl+nRsG/EfC5YxZdApwfhjVhhYQaHRC2wuXi1c=
X-Google-Smtp-Source: ABdhPJzpDsHHC7yUsvGXOVXVONQ1QCTpft5xrCvbKTPuoEfvWh9nyFa2tYG7acdi1LnTUCu+k3eipvTolH3V40jaI1Q=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr8781712oto.371.1614960298201;
 Fri, 05 Mar 2021 08:04:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+0z1OhRZcC0F8kq4HFduJTZqehfaUfNowQBjoR1-vCk6w9Kng@mail.gmail.com>
 <CABBYNZK-Nf-aEsKxjCyGYm1-6nSyxRHCa1eZ3be6CqyYxHAeTw@mail.gmail.com>
 <CA+0z1OhhQa96d3RCFeHHRz+R=6tTohV3mhCS63GeFVQ3BvA03w@mail.gmail.com> <CA+0z1OiF5jsSXt2RW_N8AY8kpOjVKe1XjM1Qnpyw7Ejx06ipuA@mail.gmail.com>
In-Reply-To: <CA+0z1OiF5jsSXt2RW_N8AY8kpOjVKe1XjM1Qnpyw7Ejx06ipuA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Mar 2021 08:04:47 -0800
Message-ID: <CABBYNZLZ-jC2ogN3u3vAu+WcDpm6jg7CA_45ri7jYw=6aekKmw@mail.gmail.com>
Subject: Re: BlueZ Creates conflicting deviceinfo service.
To:     Ryan Walmsley <ryan@pi-supply.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ryan,

On Fri, Mar 5, 2021 at 2:01 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
>
> So is it possible for me to set the above values I require in main.conf?
>
> There's no documentation showing that it's possible to set the values
> in main.conf.

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n30

Or are you saying this is not enough and more fields need to be added?

> If not then I think that surely the override to disable the service
> being provided by BlueZ needs to be added?
>
> At the time the code was added it was even picked up that it would
> break operationality and suggested a kill switch to be added,  but now
> I'm reporting it as a bug it's not going to be added?

Well even with the kill switch for the daemon not to add another
instance of DIS the problem doesn't go away because then any other
application can register DIS as well, in fact we may need to put some
code together to stop registering multiple instances of services that
don't support such thing. Anyway if you have programmed the values on
main.conf, which is shared with classic, failing to register DIS
should have no impact.

>
> On Thu, Mar 4, 2021 at 8:07 PM Ryan Walmsley <ryan@pi-supply.com> wrote:
> >
> > Hi Luiz,
> >
> > Thanks for the response.
> >
> > We use our program to set characteristics 2A29 (Manufacturer Name),
> > 2A26 (Firmware) and 2A25 (Serial Number) under the 180A service. I
> > can't see where in main.conf I can set these variables.
> >
> > However for our use case this wouldn't really be a suitable method as
> > we have the software running in docker containers communicating with
> > bluez on the host via dbus. Setting the above values in main.conf
> > would require more than just the containers to be updated each time we
> > bump a new firmware version.
> >
> > I have tried removing the service before we add outs using the
> > "unregister-service 0x0000180a-0000-1000-8000-00805f9b34f" feature in
> > bluetoothctl but just get a failed to unregister service issue.
> >
> > While it might not be the ideal way to do it this way where we create
> > the service,  however if it was flagged at the time of commit that
> > enabled BlueZ to provide this service that it could cause stuff to
> > break then surely it's more an issue with BlueZ and the suggested
> > override should be added?
> >
> >
> > On Thu, Mar 4, 2021 at 7:36 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Ryan,
> > >
> > > On Thu, Mar 4, 2021 at 11:10 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > We've been working on something that uses Bluetooth to provide GATT
> > > > services and recently have updated to BlueZ 5.55 from 5.53 and have
> > > > found an issue.
> > > >
> > > > It seems that in the newer version a commit was made
> > > > (d5e07945c4aa36a83addc3c269f55c720c28afdb) that enabled the service
> > > > 0x180A with characteristic 0x2A50.
> > >
> > > Yep, DIS is controlled by the daemon since you can set the vendor,
> > > product and version using main.conf.
> > >
> > > > However as our software creates a service on 0x180A it causes a
> > > > conflict, as the application we are making our software with reads
> > > > from the first service available which is the one generated by BlueZ.
> > >
> > > You should probably stop doing that and just use main.conf to set the
> > > values you want to be published, we should actually blacklist DIS to
> > > be registered by applications since that is defined by the platform
> > > having the application to override may actually cause problems.
> > >
> > > > It looks like it was discussed about a kill switch being added of
> > > > "DeviceIdOverLE" to then disable this but I can't find any reference
> > > > to this at all.
> > > >
> > > > How would be best to disable this?
> > >
> > > Disable DIS on the application, you can actually check if the adapter
> > > has enabled it already using its UUIDs:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n321
> > >
> > > bluetoothctl also can be use to print the list of UUIDs that the
> > > adapter is exposing (0000180a-0000-1000-8000-00805f9b34fb is DIS):
> > >
> > > [bluetooth]# show
> > > Controller 00:AA:01:01:00:24 (public)
> > > Name:
> > > Alias:
> > > Class: 0x00000000
> > > Powered: no
> > > Discoverable: no
> > > DiscoverableTimeout: 0x000000b4
> > > Pairable: yes
> > > UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
> > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > > UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
> > > UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
> > > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > > UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
> > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > > UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
> > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > > UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
> > > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > > UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
> > > Modalias: usb:v1D6Bp0246d0538
> > > Discovering: no
> > > Roles: central
> > > Roles: peripheral
> > > Advertising Features:
> > > ActiveInstances: 0x00 (0)
> > > SupportedInstances: 0x01 (1)
> > > SupportedIncludes: tx-power
> > > SupportedIncludes: appearance
> > > SupportedIncludes: local-name
> > > SupportedSecondaryChannels: 1M
> > > SupportedSecondaryChannels: 2M
> > > SupportedSecondaryChannels: Coded
> > >
> > > > --
> > > > Ryan Walmsley
> > > >
> > > > Engineer
> > > >
> > > > Pi Supply Unit 4 Bells Yew Green Business Court,
> > > > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> >
> > Ryan Walmsley
> >
> > Engineer
> >
> > Pi Supply Unit 4 Bells Yew Green Business Court,
> > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> > Email us at sales@pi-supply.com
>
>
>
> --
>
> Ryan Walmsley
>
> Engineer
>
> Pi Supply Unit 4 Bells Yew Green Business Court,
> Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> Email us at sales@pi-supply.com



-- 
Luiz Augusto von Dentz
