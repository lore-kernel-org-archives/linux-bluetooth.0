Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58006509B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEXFV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCEXFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:05:15 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C9C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:05:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id l64so4289467oig.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BBxqbhm6hTVDrmH3bnXcIS9SbPP+ktq0OsLp4mlaTo=;
        b=nN30jy5su62eJ09PtbkhKZR9qRW+cnSKoLnTvKThUe2h0PCt5u4nPG1T/udtYqO/B6
         mAmOD8vr82pwqg8FWDERSrOInnB+tCpJtEXF7zAHi0debGuNZ6uASSdRS2fZngFPd532
         0+q2Pk1ttLTdfhuf/6mN3vwqwn0LlsygcV9apkryeU/hGmV1Pz/GbzQlbBM+Hzqs+SDx
         HHYCf524rLNGTZnYl/AFpSDTA8uXfDVkAuhVkSLWGemocLWlrIH26xch1llrGSkFki6d
         fpctPvD8pZadKlD5z+aKPmmmxBGvNg/L7U+/ul6RF+EyTNdUcQ7Ov8AO58kwyxSi7biQ
         uTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BBxqbhm6hTVDrmH3bnXcIS9SbPP+ktq0OsLp4mlaTo=;
        b=sxLDo5wOD5vsM0XeJpFVnrUviSCLT1vE0qYkhUO8K+vfkMN7ml1Sd5UxHk8nf/fhgR
         EATsdA5OCRZ40HcYoZS/gTlIim4hSeMpKyBHG25OvuUSqBegajj7Y4KtnU09UJ3rRfOR
         7VUNR1LJu0/wZDmSsvVnARlC24o7t9fmnWX5UhqN+NKZoTVzZvFFjD9YQG1Spghu85B7
         10T1VbwCPgSvPib8RlYuig4awqRzif3WWEsV6vcrImesf7IXgN4PwdFp8fBA/dz6JD69
         xzy4Lfu7jYFKONVyn2Y+17LIhLuYtGtBOE2si6zm/JLv5BElNadglNkN9PhITMKDZoXd
         ga6g==
X-Gm-Message-State: AOAM530x7Q+G2CImA12PcvJZTgatia4Mku4MVMOCOWHXOHbvVhiRo81/
        5CLuQTOwUbirvxIFXEW65q6oJITs3xWELaHREL75s/zE3TVdFw==
X-Google-Smtp-Source: ABdhPJxgTyYlx7iWYX0ycpb7YNIrf1HxKeNL3DOuIRQZEXH5FwlVPbQpSPXGg96d0ATUm6wmgub+2D5ErrFxcoLG1FQ=
X-Received: by 2002:a54:468f:: with SMTP id k15mr8851729oic.58.1614985514486;
 Fri, 05 Mar 2021 15:05:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+0z1OhRZcC0F8kq4HFduJTZqehfaUfNowQBjoR1-vCk6w9Kng@mail.gmail.com>
 <CABBYNZK-Nf-aEsKxjCyGYm1-6nSyxRHCa1eZ3be6CqyYxHAeTw@mail.gmail.com>
 <CA+0z1OhhQa96d3RCFeHHRz+R=6tTohV3mhCS63GeFVQ3BvA03w@mail.gmail.com>
 <CA+0z1OiF5jsSXt2RW_N8AY8kpOjVKe1XjM1Qnpyw7Ejx06ipuA@mail.gmail.com>
 <CABBYNZLZ-jC2ogN3u3vAu+WcDpm6jg7CA_45ri7jYw=6aekKmw@mail.gmail.com> <CA+0z1OjMNjgJMNZXU4C26CYGUSsQOvKYwq14LNboCHkw=n=D=w@mail.gmail.com>
In-Reply-To: <CA+0z1OjMNjgJMNZXU4C26CYGUSsQOvKYwq14LNboCHkw=n=D=w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Mar 2021 15:05:03 -0800
Message-ID: <CABBYNZKFiFQ+tDxznRm6TBEVDVHvWkg_358YWJ5P_N8Nfz39Fw@mail.gmail.com>
Subject: Re: BlueZ Creates conflicting deviceinfo service.
To:     Ryan Walmsley <ryan@pi-supply.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ryan,

On Fri, Mar 5, 2021 at 8:14 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
>
> Hi Luiz,
>
> The Device ID setting in the main.conf only sets the PnP ID
> Characteristic under the DIS.
>
> My service was providing other characteristics (Manufacturer Name
> [2A29] & Firmware Revision [2A26]) which aren't settable with that
> configuration variable.
>
> So it'd be how would I set the above characteristics?
>
> If this service isn't suitable to be used then that is fine if it
> comes to it as I can go back to the App developers and say that it
> won't be suitable to use, but unfortunately so far they're just
> recommending that we keep with an older version of BlueZ where this
> issue doesn't occur.

Ive just sent a patch ([PATCH BlueZ 1/2] main.conf: Enable passing
false to DeviceID) that should allow platforms to disable DeviceID via
main.conf, that seems to be the original intend from the beginning but
we probably forgot to implement it.

>
> On Fri, Mar 5, 2021 at 4:04 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Ryan,
> >
> > On Fri, Mar 5, 2021 at 2:01 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
> > >
> > > So is it possible for me to set the above values I require in main.conf?
> > >
> > > There's no documentation showing that it's possible to set the values
> > > in main.conf.
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n30
> >
> > Or are you saying this is not enough and more fields need to be added?
> >
> > > If not then I think that surely the override to disable the service
> > > being provided by BlueZ needs to be added?
> > >
> > > At the time the code was added it was even picked up that it would
> > > break operationality and suggested a kill switch to be added,  but now
> > > I'm reporting it as a bug it's not going to be added?
> >
> > Well even with the kill switch for the daemon not to add another
> > instance of DIS the problem doesn't go away because then any other
> > application can register DIS as well, in fact we may need to put some
> > code together to stop registering multiple instances of services that
> > don't support such thing. Anyway if you have programmed the values on
> > main.conf, which is shared with classic, failing to register DIS
> > should have no impact.
> >
> > >
> > > On Thu, Mar 4, 2021 at 8:07 PM Ryan Walmsley <ryan@pi-supply.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Thanks for the response.
> > > >
> > > > We use our program to set characteristics 2A29 (Manufacturer Name),
> > > > 2A26 (Firmware) and 2A25 (Serial Number) under the 180A service. I
> > > > can't see where in main.conf I can set these variables.
> > > >
> > > > However for our use case this wouldn't really be a suitable method as
> > > > we have the software running in docker containers communicating with
> > > > bluez on the host via dbus. Setting the above values in main.conf
> > > > would require more than just the containers to be updated each time we
> > > > bump a new firmware version.
> > > >
> > > > I have tried removing the service before we add outs using the
> > > > "unregister-service 0x0000180a-0000-1000-8000-00805f9b34f" feature in
> > > > bluetoothctl but just get a failed to unregister service issue.
> > > >
> > > > While it might not be the ideal way to do it this way where we create
> > > > the service,  however if it was flagged at the time of commit that
> > > > enabled BlueZ to provide this service that it could cause stuff to
> > > > break then surely it's more an issue with BlueZ and the suggested
> > > > override should be added?
> > > >
> > > >
> > > > On Thu, Mar 4, 2021 at 7:36 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Ryan,
> > > > >
> > > > > On Thu, Mar 4, 2021 at 11:10 AM Ryan Walmsley <ryan@pi-supply.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > We've been working on something that uses Bluetooth to provide GATT
> > > > > > services and recently have updated to BlueZ 5.55 from 5.53 and have
> > > > > > found an issue.
> > > > > >
> > > > > > It seems that in the newer version a commit was made
> > > > > > (d5e07945c4aa36a83addc3c269f55c720c28afdb) that enabled the service
> > > > > > 0x180A with characteristic 0x2A50.
> > > > >
> > > > > Yep, DIS is controlled by the daemon since you can set the vendor,
> > > > > product and version using main.conf.
> > > > >
> > > > > > However as our software creates a service on 0x180A it causes a
> > > > > > conflict, as the application we are making our software with reads
> > > > > > from the first service available which is the one generated by BlueZ.
> > > > >
> > > > > You should probably stop doing that and just use main.conf to set the
> > > > > values you want to be published, we should actually blacklist DIS to
> > > > > be registered by applications since that is defined by the platform
> > > > > having the application to override may actually cause problems.
> > > > >
> > > > > > It looks like it was discussed about a kill switch being added of
> > > > > > "DeviceIdOverLE" to then disable this but I can't find any reference
> > > > > > to this at all.
> > > > > >
> > > > > > How would be best to disable this?
> > > > >
> > > > > Disable DIS on the application, you can actually check if the adapter
> > > > > has enabled it already using its UUIDs:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n321
> > > > >
> > > > > bluetoothctl also can be use to print the list of UUIDs that the
> > > > > adapter is exposing (0000180a-0000-1000-8000-00805f9b34fb is DIS):
> > > > >
> > > > > [bluetooth]# show
> > > > > Controller 00:AA:01:01:00:24 (public)
> > > > > Name:
> > > > > Alias:
> > > > > Class: 0x00000000
> > > > > Powered: no
> > > > > Discoverable: no
> > > > > DiscoverableTimeout: 0x000000b4
> > > > > Pairable: yes
> > > > > UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
> > > > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > > > > UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
> > > > > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > > > > UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > > > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > > > > UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
> > > > > Modalias: usb:v1D6Bp0246d0538
> > > > > Discovering: no
> > > > > Roles: central
> > > > > Roles: peripheral
> > > > > Advertising Features:
> > > > > ActiveInstances: 0x00 (0)
> > > > > SupportedInstances: 0x01 (1)
> > > > > SupportedIncludes: tx-power
> > > > > SupportedIncludes: appearance
> > > > > SupportedIncludes: local-name
> > > > > SupportedSecondaryChannels: 1M
> > > > > SupportedSecondaryChannels: 2M
> > > > > SupportedSecondaryChannels: Coded
> > > > >
> > > > > > --
> > > > > > Ryan Walmsley
> > > > > >
> > > > > > Engineer
> > > > > >
> > > > > > Pi Supply Unit 4 Bells Yew Green Business Court,
> > > > > > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Ryan Walmsley
> > > >
> > > > Engineer
> > > >
> > > > Pi Supply Unit 4 Bells Yew Green Business Court,
> > > > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> > > > Email us at sales@pi-supply.com
> > >
> > >
> > >
> > > --
> > >
> > > Ryan Walmsley
> > >
> > > Engineer
> > >
> > > Pi Supply Unit 4 Bells Yew Green Business Court,
> > > Bells Yew Green, East Sussex, TN3 9BJ, United Kingdom
> > > Email us at sales@pi-supply.com
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
Luiz Augusto von Dentz
