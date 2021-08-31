Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28965C4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0960A60E98
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 08:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhHaIlc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbhHaIlb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 04:41:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF0C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 01:40:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f2so30457219ljn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnoI6CG9LP4qkdU1r3LZclsflgNdl+r3ubqdleqrDpA=;
        b=hZhENILgB7B7CxGTuurHNSZ9xY7PN20ReVZ1bFVIW9lItww8Ml2tl9dmXlg5BBL8CM
         EnqmbSwGYT5lXxW+mTOBLCapr+kGa8SvjNsRszdEWdvmAyKIOT76hVCrihf1gWqEL9Bw
         B6vV5evQf6+6x8o9vCTKszBUe+ZLz8gKaRWh4IQB/0X+WXerBFzYxMH7BhSSB1osDGDu
         f8/kHfS5gl5kQTMynSY9oPnWrjF+6hId6HXf8edj8+q93ST53xYAF2829Ho/Tc4RRhiy
         6MZpDCFL5MwTCto4NVPk3f5S2Bnq3L8gnaCQ0exIiL1rXqqAQRrNwEgWING3F2F6NmHY
         tQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnoI6CG9LP4qkdU1r3LZclsflgNdl+r3ubqdleqrDpA=;
        b=LeaT2PaA+46ShqABOm6VEtkXeKx0jgitLASVxvQSoejeU1d6brUzFMwHNUaxYdd2TC
         /Uiq7/Se83pmg8A6nxEOWrnK1eoJrKt82wUAvLGnrIcthL1Re/rUmjAkCwrsr5/jriID
         WRGbGPrO/KKqXtrfCdmlrm9LAzzL08s+DcnQ15wczD4FQixRlGQRLoSc92mffd50zYuD
         vbfy2cI0uyS104WZMSmBWfhJnM7IBCxfgGtTe/XdaT0sub6OnflXNbsKIKezGBBrW6pz
         jSOXcc/PKusBCpuMOTPWRDPpsfsQ2HtwRV4l4FUIzDcBR+jRLcX2k01zTkqEITj0NvSW
         7ddQ==
X-Gm-Message-State: AOAM533lHggUfxMX84HxfAlP5Mw4IC/e2gMphqKvJQezf2sdm+ZTCrXd
        3ML38QUwGLs1c0DNccnJV0X+wmPPV6BTGZ6afVvIEPVpp8jCIA==
X-Google-Smtp-Source: ABdhPJwzAQGLJWHM9Y03GV/BJO/gAI8EDfEWDikhj8jiDhRMs3fWl9F/nONT7F+tzWmkVW7jPgxZFPg5ZZKmF9/tMpY=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr24330435ljg.97.1630399234674;
 Tue, 31 Aug 2021 01:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
 <CAEwN+MCbwrcGohpwuB7F4rKk7+uw9Y6r=Ov8xmKT_yJF4_tkUw@mail.gmail.com> <CABBYNZKoYEfNGZAa6-uM+Q5AAuifkFQPwe7VyfByn9Kj1_uSxA@mail.gmail.com>
In-Reply-To: <CABBYNZKoYEfNGZAa6-uM+Q5AAuifkFQPwe7VyfByn9Kj1_uSxA@mail.gmail.com>
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Tue, 31 Aug 2021 14:10:23 +0530
Message-ID: <CAEwN+MA8UDXTP34qBq8VvbMhsH905oP0SqA3YU2+kQpUFL--gQ@mail.gmail.com>
Subject: Re: Device doesnt show up on Ble Scanner - gatt-service example in
 tools folder as per Documentation(doc)
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 31, 2021 at 12:08 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Raul,
>
Hello Luiz,
> On Mon, Aug 30, 2021 at 11:32 PM Raul Piper <raulpblooper@gmail.com> wrote:
> >
> > Any inputs on this?
>
> Did you remember to advertise? I mean those only services but it
> doesn't necessarily advertise which is something perhaps could be
> updated on those samples so they become visible on the scanners.
>
Isnt ./gatt-service supposed to advertise as well?
I cross built and rant ./advtest with -h and it gave not much information :
./advtest --h
advtest - Advertising testing
Usage:
        advtest [options]

and when I ran
./advtest
it gave : At least 2 controllers are required
what other input does it take ? hci0?hci1?

when i try to run ./advtest -hci0
it gave :  Invalid command line parameters

 i tried to find bt controllers on my board and it gave :

hcitool dev
Devices :

It gave nothing.

Any idea how to proceed ?I suspect I need to enable the hci controller
or something?
But it is strange that ./gatt-service did not throw any error and
registered the services without any error?shouldn't  these examples
check for the ble controller first before proceeding further?


> > On Sun, Aug 29, 2021 at 11:42 PM Raul Piper <raulpblooper@gmail.com> wrote:
> > >
> > > Hello,
> > > I tried cross compiling the bluez and ported it to my linux platform.I
> > > think i have done it correctly as I am able to launch the gatt-service
> > > example successfully but i am not able to view it on the Smartphone
> > > app - blescanner or light blue.
> > >
> > > Below are the logs :
> > > ===============================================
> > > ./gatt-service
> > > gatt-service unique name: :1.18
> > > Registered service: /service1
> > > Registered service: /service2
> > > Registered service: /service3
> > > Get Primary: True
> > > Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> > > Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> > > Get Includes: 00001802-0000-1000-8000-00805f9b34fb
> > > Includes path: /service3
> > > Get Includes: /service2
> > > Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> > > Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> > > Get Primary: True
> > > Get UUID: A00C
> > > Exist Includes: A00C
> > > Characteristic(00002c07-0000-1000-8000-00805f9b34fb): Get("Value")
> > > Descriptor(FFFF): Get("Value")
> > > Get Primary: True
> > > Get UUID: A00D
> > > Exist Includes: A00D
> > > Characteristic(00002b06-0000-1000-8000-00805f9b34fb): Get("Value")
> > > Descriptor(0260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> > >
> > >
> > >
> > > I also tried to run the python example inside test/example-gatt-server
> > > but again I am not able to view the device name.
> > >
> > > Below are the logs :
> > > =======================================
> > > python3 example-gatt-server
> > > example-gatt-server:395: PyGIDeprecationWarning: GObject.timeout_add
> > > is deprecated; use GLib.timeout_add instead
> > >   GObject.timeout_add(5000, self.drain_battery)
> > > example-gatt-server:652: PyGIDeprecationWarning: GObject.MainLoop is
> > > deprecated; use GLib.MainLoop instead
> > >   mainloop = GObject.MainLoop()
> > > Registering GATT application...
> > > GetManagedObjects
> > > GATT application registered
> > >
> > > I even opened the btmon on a different tab but still I am not able to
> > > see anything on that.
> > > Is there any other application we have to run?
> > > Has any one ran  it successfully and able to view/connect and see all
> > > the 3 services it is advertising.
> > >
> > > Please advise / ask for any further information , I will provide.
> > >
> > > Thanks in advance !
> > >
> > > Regards,
> > > R
>
>
>
> --
> Luiz Augusto von Dentz
