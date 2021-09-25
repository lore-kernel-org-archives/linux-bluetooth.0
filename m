Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA73C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Sep 2021 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BBA61051
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Sep 2021 21:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhIYVfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Sep 2021 17:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIYVfJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Sep 2021 17:35:09 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83115C061570
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Sep 2021 14:33:34 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id t200so5450151vkt.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Sep 2021 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=porFZzdm8JVmmHzZZ5ZKPQUFfxSegDPiNcGaBMKMqUg=;
        b=R3ZrKq9ExOsgiv6PC2HIEavzgxEczoGMDfpsnwa4wIa+/q7h1T6XOQy89mwUImwmxg
         GUcGaja7V5xKheFVFkX/Y/vCDyJEMPAvZBD7Q/mC5nb0uEM9ngWB2JqZUAFRoEFGJf6x
         0MJ12jtyvN/n044pTC3c4ORLFMYGjYbU9IOWQlnZFCcAGbjlo5vPKHRWAq1CL9XSt2O1
         H3MRgiczqUUoD/xSxhDlpLpmZ1rvUCvYE4w5pPTBWel7KTFwN7ZccY0cmT9jdEd5YBZT
         ushhUkAH37juIlKTEcgvucB2H4KfcMtPI+Yaih90a/yc+WMh90AmSur6XPBKOD7x+ntC
         Nc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=porFZzdm8JVmmHzZZ5ZKPQUFfxSegDPiNcGaBMKMqUg=;
        b=OT3OlUO3W0chI7JokXNpYG3ekjrGmB2fXEVehM5TGRFUTm7LeCkui8E/IHAq2mvo/0
         lYTBkRlGXjPlfwQiBDflgE5cmqeU2WJ5VVP+5Sw9d32C3kEZmjP7r1wF4ZLND+aKivkJ
         GKSarRrF6ZbEDgoXK8RZdbvzQIz8PgW+oQtSGyqX3L73ZCTMmK4i097Z0duyEtSylc9+
         7vKQzhow+hmy9DXLEQhXQsIOPfRY6Qm1ytT1IYD6x0vmCteWrP/82aznGgaarAYmJ/Dj
         BS1Xrk8Cm/zs/5RoTCUixVaQLjtymZIVwUQkUNLfUHzVeObSy1IeF7/aGDNaBH3/OFvo
         nbKg==
X-Gm-Message-State: AOAM531pSh2TjYL0eSSoPx8zxi3zKPMFTb5EtMvv+MeR6psDEQL8CSXF
        iwlVs2YgyO3WuyRPnpi7rnVQMwFF7Ku1LV6h6NlydCf0
X-Google-Smtp-Source: ABdhPJz4478vrEY9FlLR9CrlHZGuwAmLiGsuLz4jECetkvZyfhg5Y+KeGRIGGAIhtdbd8LMggl/iF39gWn9Lq/Wb1Tg=
X-Received: by 2002:a1f:2952:: with SMTP id p79mr12753142vkp.11.1632605613176;
 Sat, 25 Sep 2021 14:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
 <CAEwN+MCbwrcGohpwuB7F4rKk7+uw9Y6r=Ov8xmKT_yJF4_tkUw@mail.gmail.com>
 <CABBYNZKoYEfNGZAa6-uM+Q5AAuifkFQPwe7VyfByn9Kj1_uSxA@mail.gmail.com> <CAEwN+MA8UDXTP34qBq8VvbMhsH905oP0SqA3YU2+kQpUFL--gQ@mail.gmail.com>
In-Reply-To: <CAEwN+MA8UDXTP34qBq8VvbMhsH905oP0SqA3YU2+kQpUFL--gQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Sat, 25 Sep 2021 15:33:06 -0600
Message-ID: <CAJfuBxy+ZY3tYYsr4y828zb5Hc8LPznEyTJZq0afu7tMCJCSfg@mail.gmail.com>
Subject: Re: Device doesnt show up on Ble Scanner - gatt-service example in
 tools folder as per Documentation(doc)
To:     Raul Piper <raulpblooper@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 31, 2021 at 2:41 AM Raul Piper <raulpblooper@gmail.com> wrote:
>
> On Tue, Aug 31, 2021 at 12:08 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Raul,
> >
> Hello Luiz,
> > On Mon, Aug 30, 2021 at 11:32 PM Raul Piper <raulpblooper@gmail.com> wrote:
> > >
> > > Any inputs on this?
> >
> > Did you remember to advertise? I mean those only services but it
> > doesn't necessarily advertise which is something perhaps could be
> > updated on those samples so they become visible on the scanners.
> >
> Isnt ./gatt-service supposed to advertise as well?
> I cross built and rant ./advtest with -h and it gave not much information :
> ./advtest --h
> advtest - Advertising testing
> Usage:
>         advtest [options]
>
> and when I ran
> ./advtest
> it gave : At least 2 controllers are required
> what other input does it take ? hci0?hci1?
>
> when i try to run ./advtest -hci0
> it gave :  Invalid command line parameters
>
>  i tried to find bt controllers on my board and it gave :
>
> hcitool dev
> Devices :
>
> It gave nothing.
>
> Any idea how to proceed ?I suspect I need to enable the hci controller
> or something?
> But it is strange that ./gatt-service did not throw any error and
> registered the services without any error?shouldn't  these examples
> check for the ble controller first before proceeding further?
>
>
> > > On Sun, Aug 29, 2021 at 11:42 PM Raul Piper <raulpblooper@gmail.com> wrote:
> > > >
> > > > Hello,
> > > > I tried cross compiling the bluez and ported it to my linux platform.I
> > > > think i have done it correctly as I am able to launch the gatt-service
> > > > example successfully but i am not able to view it on the Smartphone
> > > > app - blescanner or light blue.
> > > >
> > > > Below are the logs :
> > > > ===============================================
> > > > ./gatt-service
> > > > gatt-service unique name: :1.18
> > > > Registered service: /service1
> > > > Registered service: /service2
> > > > Registered service: /service3
> > > > Get Primary: True
> > > > Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> > > > Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> > > > Get Includes: 00001802-0000-1000-8000-00805f9b34fb
> > > > Includes path: /service3
> > > > Get Includes: /service2
> > > > Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> > > > Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> > > > Get Primary: True
> > > > Get UUID: A00C
> > > > Exist Includes: A00C
> > > > Characteristic(00002c07-0000-1000-8000-00805f9b34fb): Get("Value")
> > > > Descriptor(FFFF): Get("Value")
> > > > Get Primary: True
> > > > Get UUID: A00D
> > > > Exist Includes: A00D
> > > > Characteristic(00002b06-0000-1000-8000-00805f9b34fb): Get("Value")
> > > > Descriptor(0260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> > > >
> > > >
> > > >
> > > > I also tried to run the python example inside test/example-gatt-server
> > > > but again I am not able to view the device name.
> > > >
> > > > Below are the logs :
> > > > =======================================
> > > > python3 example-gatt-server
> > > > example-gatt-server:395: PyGIDeprecationWarning: GObject.timeout_add
> > > > is deprecated; use GLib.timeout_add instead
> > > >   GObject.timeout_add(5000, self.drain_battery)
> > > > example-gatt-server:652: PyGIDeprecationWarning: GObject.MainLoop is
> > > > deprecated; use GLib.MainLoop instead
> > > >   mainloop = GObject.MainLoop()
> > > > Registering GATT application...
> > > > GetManagedObjects
> > > > GATT application registered
> > > >
> > > > I even opened the btmon on a different tab but still I am not able to
> > > > see anything on that.
> > > > Is there any other application we have to run?
> > > > Has any one ran  it successfully and able to view/connect and see all
> > > > the 3 services it is advertising.
> > > >
> > > > Please advise / ask for any further information , I will provide.
> > > >
> > > > Thanks in advance !
> > > >
> > > > Regards,
> > > > R
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>


any progress ?
this thread looked promising...
