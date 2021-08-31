Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F6C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF2C60F4B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhHaG37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhHaG36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 02:29:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69EDC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:29:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so36381413lfa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA7Lgqz7j1tIlllXk3N2YvxDqcytsnPUv9JEZMC4Auo=;
        b=Mt/p3pwg24kpBJvCngwTGURs6ueVEgtOy2tX/PzWKMU5FmOMUeUNJEs4aaJmn548SV
         SG248gZ76QocrCq4wndOyDNznXI4K8ciqyuU3RdoELD/H//HZa3CFk5KU9l3Eu+HOpr3
         MhfPRvgqob4OdkdnL7ITpmHepGJq2U6lgvLCs32wZY2m0w9mcDIJXSw32bmfnLmaet8P
         k1nWBsKarr4S99HAW1ov3jLzoh9u9fxSTBCmy7S7j3rVfMiOK8TlXZGek9za2pegIQNT
         aJIo15v3ErBloa7npwmadvJYUnwLicNRZWXGcc0nH2zeTlxiXrxY/iqQp6fDMk9+5Ijx
         YV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA7Lgqz7j1tIlllXk3N2YvxDqcytsnPUv9JEZMC4Auo=;
        b=r2X+LKL6I6namg/2CFEGPd7nLrKCGcvD/NrHSjHKLjc+hNLXTqPttA0KzZ993ij+t9
         XPPh8bfEkBMI3kdOXqZBnaFNkAnzG79BWyaa+hV2Y2lNYChX114mkQxZNPtPO1FyUVKa
         a5UTZYoupibSH+4hyG/oqiDW1mpB/cdnOz6OGhSIZTb1Or9/xxurcr4Eea7dZGpsfbc3
         qkQeEhkbkoVl4hKEaDmRnUSmp7BNEuTCaCpQzXdaDVcKdzW2+7EivU5J9aJKb2yFAyJ9
         anZklfHWWeNOVOL9hKUQGNwvVrQlPszxiGcQKzJDKVT83843yuu/6xEWntLcHlpjvQN/
         iRtQ==
X-Gm-Message-State: AOAM531JpfXnqfTwRGOSC+Mny/HpWW0xz+Z/qcwFVy62JyegcZ1voIkA
        Ho18iHu7MFf9BK7lenVnIFqqgzKkO3t4iB3mYYPVetQ0FkY=
X-Google-Smtp-Source: ABdhPJxc0zeMWIuXH+jRf0h9/CmHg4e9BCJtxmlE8pGl4gQIv6XnemLTzPdtH9jjxryo+LVoIJ5Ljkfp2I6T38lhN6Q=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr13752088lfu.67.1630391341623;
 Mon, 30 Aug 2021 23:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
In-Reply-To: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Tue, 31 Aug 2021 11:58:50 +0530
Message-ID: <CAEwN+MCbwrcGohpwuB7F4rKk7+uw9Y6r=Ov8xmKT_yJF4_tkUw@mail.gmail.com>
Subject: Re: Device doesnt show up on Ble Scanner - gatt-service example in
 tools folder as per Documentation(doc)
To:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any inputs on this?


On Sun, Aug 29, 2021 at 11:42 PM Raul Piper <raulpblooper@gmail.com> wrote:
>
> Hello,
> I tried cross compiling the bluez and ported it to my linux platform.I
> think i have done it correctly as I am able to launch the gatt-service
> example successfully but i am not able to view it on the Smartphone
> app - blescanner or light blue.
>
> Below are the logs :
> ===============================================
> ./gatt-service
> gatt-service unique name: :1.18
> Registered service: /service1
> Registered service: /service2
> Registered service: /service3
> Get Primary: True
> Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> Get Includes: 00001802-0000-1000-8000-00805f9b34fb
> Includes path: /service3
> Get Includes: /service2
> Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> Get Primary: True
> Get UUID: A00C
> Exist Includes: A00C
> Characteristic(00002c07-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(FFFF): Get("Value")
> Get Primary: True
> Get UUID: A00D
> Exist Includes: A00D
> Characteristic(00002b06-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(0260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
>
>
>
> I also tried to run the python example inside test/example-gatt-server
> but again I am not able to view the device name.
>
> Below are the logs :
> =======================================
> python3 example-gatt-server
> example-gatt-server:395: PyGIDeprecationWarning: GObject.timeout_add
> is deprecated; use GLib.timeout_add instead
>   GObject.timeout_add(5000, self.drain_battery)
> example-gatt-server:652: PyGIDeprecationWarning: GObject.MainLoop is
> deprecated; use GLib.MainLoop instead
>   mainloop = GObject.MainLoop()
> Registering GATT application...
> GetManagedObjects
> GATT application registered
>
> I even opened the btmon on a different tab but still I am not able to
> see anything on that.
> Is there any other application we have to run?
> Has any one ran  it successfully and able to view/connect and see all
> the 3 services it is advertising.
>
> Please advise / ask for any further information , I will provide.
>
> Thanks in advance !
>
> Regards,
> R
