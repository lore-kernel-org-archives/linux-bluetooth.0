Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 09:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A0564F45
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 09:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCEJ7D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCEJ6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 04:58:53 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C9AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 01:58:53 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id e17so287025oow.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pi-supply-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sJQXOIWRxCoev3BWNrI6cs/7SHfaGI0jwwNojEsQKtk=;
        b=CbtvQ/KbK1p/lKeOPGSZjYCkR/xc1vnUaVY1GL94XbsxxFxsQbZLIOXvGXsedvTB6r
         WJvagq6rhvr32G2x3qQMyTUvy9hvZwzEHHUHe+QQiQjpQ9utIZ4A7inwSKSF3H4w9Qtm
         R1O86JJgSYbnLg+ooOrE/CTzfi917U8uEf7uH6cV1gOVOdhKSmRh9Yt2QDYDKiBPgm8G
         6sGPjs2hgA9Fj76KYXz1t03CKE4ynZUkuiA4ieNctKapy0yCvcdxBZ8b/3Erx23+1Aw8
         O1ImmHUbKGPAtFVJaUkLjyskqf+daojUDCAPNsFQeSCFG8ASS2SU2b96Y9UeWW0Gv3MM
         V8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sJQXOIWRxCoev3BWNrI6cs/7SHfaGI0jwwNojEsQKtk=;
        b=PT+KkPwQXV2E+dY6+j3mZRcZ+3Kr657EtYmVOcou1w6IVdpD39X9lOHGh9nWEypdWI
         XYEqr6Rk53zeiIcdQ565/9JgDsVF49BKEjT/L/Wzp0obvip+DugkUhPGxaGp87tpRKH5
         bXCti+33hvZWwFZ2QFDEpWrx4pnR4wdmHDeVvXFm+bvdZJLqDnnHXDpLyZIe8qhq5AlV
         zhZM9qC8aSv100/OHHrlQCLpYuFXSV2UhbYXr5frbO47GJD/Fw+F2ewGGLszXSyP2qhg
         J1f2lyHQ5D8d8LXDcwFbXgudoHux2pTNvU9CSQdTU7AuMEanT+LXFM0QKjrZqNzUGeNw
         mgAA==
X-Gm-Message-State: AOAM533V3Uba5mKACvpCYAGR3ClOWx1JCBio5rrV0AoGjFBEZX+sNSWs
        iki+uOHDqurtJBS4MwWCprl9tmVYrNYXgmQy7KxBCkQi1YLjhw==
X-Google-Smtp-Source: ABdhPJyUx4dtcOpnpAJI9wdZ8Z2t5W2ltTDHPzCbvI8MCEj1BK6Ob/rNHNSpy5wb+i+zdNyFs9MuflCE3ooBJ5wtXM0=
X-Received: by 2002:a05:6820:58:: with SMTP id v24mr6910911oob.55.1614938332306;
 Fri, 05 Mar 2021 01:58:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+0z1OhRZcC0F8kq4HFduJTZqehfaUfNowQBjoR1-vCk6w9Kng@mail.gmail.com>
 <CABBYNZK-Nf-aEsKxjCyGYm1-6nSyxRHCa1eZ3be6CqyYxHAeTw@mail.gmail.com> <CA+0z1OhhQa96d3RCFeHHRz+R=6tTohV3mhCS63GeFVQ3BvA03w@mail.gmail.com>
In-Reply-To: <CA+0z1OhhQa96d3RCFeHHRz+R=6tTohV3mhCS63GeFVQ3BvA03w@mail.gmail.com>
From:   Ryan Walmsley <ryan@pi-supply.com>
Date:   Fri, 5 Mar 2021 09:58:41 +0000
Message-ID: <CA+0z1OiF5jsSXt2RW_N8AY8kpOjVKe1XjM1Qnpyw7Ejx06ipuA@mail.gmail.com>
Subject: Re: BlueZ Creates conflicting deviceinfo service.
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

So is it possible for me to set the above values I require in main.conf?

There's no documentation showing that it's possible to set the values
in main.conf.

If not then I think that surely the override to disable the service
being provided by BlueZ needs to be added?

At the time the code was added it was even picked up that it would
break operationality and suggested a kill switch to be added,  but now
I'm reporting it as a bug it's not going to be added?


On Thu, Mar 4, 2021 at 8:07 PM Ryan Walmsley <ryan@pi-supply.com> wrote:
>
> Hi Luiz,
>
> Thanks for the response.
>
> We use our program to set characteristics 2A29 (Manufacturer Name),
> 2A26 (Firmware) and 2A25 (Serial Number) under the 180A service. I
> can't see where in main.conf I can set these variables.
>
> However for our use case this wouldn't really be a suitable method as
> we have the software running in docker containers communicating with
> bluez on the host via dbus. Setting the above values in main.conf
> would require more than just the containers to be updated each time we
> bump a new firmware version.
>
> I have tried removing the service before we add outs using the
> "unregister-service 0x0000180a-0000-1000-8000-00805f9b34f" feature in
> bluetoothctl but just get a failed to unregister service issue.
>
> While it might not be the ideal way to do it this way where we create
> the service,  however if it was flagged at the time of commit that
> enabled BlueZ to provide this service that it could cause stuff to
> break then surely it's more an issue with BlueZ and the suggested
> override should be added?
>
>
> On Thu, Mar 4, 2021 at 7:36 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Ryan,
> >
> > On Thu, Mar 4, 2021 at 11:10 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
> > >
> > > Hi,
> > >
> > > We've been working on something that uses Bluetooth to provide GATT
> > > services and recently have updated to BlueZ 5.55 from 5.53 and have
> > > found an issue.
> > >
> > > It seems that in the newer version a commit was made
> > > (d5e07945c4aa36a83addc3c269f55c720c28afdb) that enabled the service
> > > 0x180A with characteristic 0x2A50.
> >
> > Yep, DIS is controlled by the daemon since you can set the vendor,
> > product and version using main.conf.
> >
> > > However as our software creates a service on 0x180A it causes a
> > > conflict, as the application we are making our software with reads
> > > from the first service available which is the one generated by BlueZ.
> >
> > You should probably stop doing that and just use main.conf to set the
> > values you want to be published, we should actually blacklist DIS to
> > be registered by applications since that is defined by the platform
> > having the application to override may actually cause problems.
> >
> > > It looks like it was discussed about a kill switch being added of
> > > "DeviceIdOverLE" to then disable this but I can't find any reference
> > > to this at all.
> > >
> > > How would be best to disable this?
> >
> > Disable DIS on the application, you can actually check if the adapter
> > has enabled it already using its UUIDs:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n321
> >
> > bluetoothctl also can be use to print the list of UUIDs that the
> > adapter is exposing (0000180a-0000-1000-8000-00805f9b34fb is DIS):
> >
> > [bluetooth]# show
> > Controller 00:AA:01:01:00:24 (public)
> > Name:
> > Alias:
> > Class: 0x00000000
> > Powered: no
> > Discoverable: no
> > DiscoverableTimeout: 0x000000b4
> > Pairable: yes
> > UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
> > UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
> > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
> > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
> > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
> > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
> > Modalias: usb:v1D6Bp0246d0538
> > Discovering: no
> > Roles: central
> > Roles: peripheral
> > Advertising Features:
> > ActiveInstances: 0x00 (0)
> > SupportedInstances: 0x01 (1)
> > SupportedIncludes: tx-power
> > SupportedIncludes: appearance
> > SupportedIncludes: local-name
> > SupportedSecondaryChannels: 1M
> > SupportedSecondaryChannels: 2M
> > SupportedSecondaryChannels: Coded
> >
> > > --
> > > Ryan Walmsley
> > >
> > > Engineer
> > >
> > > Pi Supply Unit 4 Bells Yew Green Business Court,
> > > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
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

Ryan Walmsley

Engineer

Pi Supply Unit 4 Bells Yew Green Business Court,
Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
Email us at sales@pi-supply.com
