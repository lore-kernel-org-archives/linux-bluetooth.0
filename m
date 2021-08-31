Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE7FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2129E60231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhHaGjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGjP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 02:39:15 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC9C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:38:20 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id j5so5088547vki.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hu4M9/WmcJDNMhRHkYOdCqfk9y76ko1yBnha4EtNw4=;
        b=hJEZVBOWV2D4SebrBS/2uZhxDlzuGAClN0WSjOCitvVlLFDUUunDDt0hwGJVj8WkCU
         HCIlRJceghsIb+I9n5E4GKgnmLaC7yGDb4wiK4ygjJXa5Nk0yNC8I2Odvw/o0iQyT/oR
         EOJH+CBmcMRRCrzJ+XojNRcWlkwUrciVx9AQB7CYMWzhRQGkwmz4Bd+51Ayt8b/IwOY8
         tXTtiA8z730DyqwC+WsNSAAJM7RDU/sBZtNoc8lVmXl6WGR8supGlCFxUKUr+Rz4i02K
         GZu8TMICoI3i9u/X9WoQfdHvtUeVFeTj/2KJBJmK8J87BkuJao/62+hT4bQiuR5RHQdX
         CbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hu4M9/WmcJDNMhRHkYOdCqfk9y76ko1yBnha4EtNw4=;
        b=lnr2H94X1m4w4ZQQQYOQNm9gZOZavJj9JgpATtKhvWd68MgX5gXvJDGZzm0Hg6oxwk
         ZjvDl1dDDRe3r01kMB/h88EoGS1MrIpuKUFAhB1sNeIcHKkO53UTlG8DTMA7hIRb9H6Z
         RGX1NtXxxBwZEsKJ3QkUHOP12G5MhLhOXk6ngVEqIyVbrURmltpv2rXhogGsAD8kH5/g
         tPD2ReQw7hX6yyjNY9tvIG5xi/giB7UtkDebP5XyqMScKkufJwD26FR19UE8cZIuXJxk
         Q0FWLL8HSy6Q6Sb8w/lkhSIb04nQmTiAE0XiUFP1A1qMu9uwFigTeHDshb+qj3Gkaid4
         5jkQ==
X-Gm-Message-State: AOAM5310aHl/NcsYvcJyQDW1VgFIWIvQDE3qTuqUOEEFvd2prdbwy27l
        FL53etI/bt1Ac+MGVBWrbbc/NuwM2QfuEH29cUY=
X-Google-Smtp-Source: ABdhPJxG/qgygwW+YKO9vju2dft55B0EyZpnmdLx4rNeWhOsepdm1yOpC+3MQPgbJNvj3/VfCTEQ2BRrMbxC4cQU878=
X-Received: by 2002:a1f:7c87:: with SMTP id x129mr7817185vkc.21.1630391899956;
 Mon, 30 Aug 2021 23:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
 <CAEwN+MCbwrcGohpwuB7F4rKk7+uw9Y6r=Ov8xmKT_yJF4_tkUw@mail.gmail.com>
In-Reply-To: <CAEwN+MCbwrcGohpwuB7F4rKk7+uw9Y6r=Ov8xmKT_yJF4_tkUw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Aug 2021 23:38:09 -0700
Message-ID: <CABBYNZKoYEfNGZAa6-uM+Q5AAuifkFQPwe7VyfByn9Kj1_uSxA@mail.gmail.com>
Subject: Re: Device doesnt show up on Ble Scanner - gatt-service example in
 tools folder as per Documentation(doc)
To:     Raul Piper <raulpblooper@gmail.com>
Cc:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raul,

On Mon, Aug 30, 2021 at 11:32 PM Raul Piper <raulpblooper@gmail.com> wrote:
>
> Any inputs on this?

Did you remember to advertise? I mean those only services but it
doesn't necessarily advertise which is something perhaps could be
updated on those samples so they become visible on the scanners.

>
> On Sun, Aug 29, 2021 at 11:42 PM Raul Piper <raulpblooper@gmail.com> wrote:
> >
> > Hello,
> > I tried cross compiling the bluez and ported it to my linux platform.I
> > think i have done it correctly as I am able to launch the gatt-service
> > example successfully but i am not able to view it on the Smartphone
> > app - blescanner or light blue.
> >
> > Below are the logs :
> > ===============================================
> > ./gatt-service
> > gatt-service unique name: :1.18
> > Registered service: /service1
> > Registered service: /service2
> > Registered service: /service3
> > Get Primary: True
> > Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> > Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> > Get Includes: 00001802-0000-1000-8000-00805f9b34fb
> > Includes path: /service3
> > Get Includes: /service2
> > Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> > Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> > Get Primary: True
> > Get UUID: A00C
> > Exist Includes: A00C
> > Characteristic(00002c07-0000-1000-8000-00805f9b34fb): Get("Value")
> > Descriptor(FFFF): Get("Value")
> > Get Primary: True
> > Get UUID: A00D
> > Exist Includes: A00D
> > Characteristic(00002b06-0000-1000-8000-00805f9b34fb): Get("Value")
> > Descriptor(0260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> >
> >
> >
> > I also tried to run the python example inside test/example-gatt-server
> > but again I am not able to view the device name.
> >
> > Below are the logs :
> > =======================================
> > python3 example-gatt-server
> > example-gatt-server:395: PyGIDeprecationWarning: GObject.timeout_add
> > is deprecated; use GLib.timeout_add instead
> >   GObject.timeout_add(5000, self.drain_battery)
> > example-gatt-server:652: PyGIDeprecationWarning: GObject.MainLoop is
> > deprecated; use GLib.MainLoop instead
> >   mainloop = GObject.MainLoop()
> > Registering GATT application...
> > GetManagedObjects
> > GATT application registered
> >
> > I even opened the btmon on a different tab but still I am not able to
> > see anything on that.
> > Is there any other application we have to run?
> > Has any one ran  it successfully and able to view/connect and see all
> > the 3 services it is advertising.
> >
> > Please advise / ask for any further information , I will provide.
> >
> > Thanks in advance !
> >
> > Regards,
> > R



-- 
Luiz Augusto von Dentz
