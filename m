Return-Path: <SRS0=Dy9H=BA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8284EC433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680A20771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 23:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPw7zqlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgGUX15 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUX15 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 19:27:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07831C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 16:27:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id k4so252485oik.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPMF/rjSnUxtFQsQFf+E5YjSvyjHemQzNNUjLowFP0U=;
        b=tPw7zqlHX6OVd3pgkjh4d3OX7yPN/1czEGNZ8SYAQiYQsbFTzjzg5TwBNHRnuQXgok
         lm683FCiirtCFNptfx8x4XtoIE9ePJjQcwvTXVpFrbl5l9Y/zd+wPM6MOshQj586OMhb
         FDr6yyA01vN5cGAiqHfG/Lv0mgJA32ZfC92pfJ4ATK2XNm0NEAubrdb7edZF14/9FJcy
         WjEk+md+MrFP0fXLcJlPG1CjyPLk46Is7JTttn3BAFjiaQTcVh8UXmbHI9Xd0eMnpXxw
         LMyA2Rur1/aAui4qPUFaYSxU3oGqL39EwIMeTsr+Z67DZt1TZU/lX4vQWGR4GxMnToiW
         RFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPMF/rjSnUxtFQsQFf+E5YjSvyjHemQzNNUjLowFP0U=;
        b=Sf8ew95VJ4ZtSnxBx51+C1EcGIIOR3DKdZc3KlpuQ1oKwU8YurzO9b4wnB5x+UHPyL
         fo9xdWXhymio47YiWSpuXKN9aSgov3y0+v29oqONqYNsfyv0YT+2pxWEdcmOLbiQ0diT
         dJ4XtshGlflYx+QkR0hm8RFIMOoCfTSqUVaF19xYdx4st78k+04z4hXh17IMCI+6rigp
         21BeQ22XAKP1BxF39hZBpMF+xyMxDreaQHh5BdJ+BP210bMVO/xFaM/oXXSivvlseqHX
         3CSAJVGoUZpJEkQlSlnrvP6zOu/mWwPbz75V22JUJt3x90yc5ChOzpcEgx1yMG/kBKmh
         wgDA==
X-Gm-Message-State: AOAM532U23IPFV47i+S4FBKGd7qizLX1mxZsbSCa39t2iop9GxTw8mNr
        ee83AT89ufolkFP3FXBN16TFQgavUN/yIli5E+M=
X-Google-Smtp-Source: ABdhPJwu193y3SsRMvO3NGHV+Wthzdnl/vCdX9HFkBOseMhcy/v5Z5Ijy2QRtDPiIPY1Fr00A8n2b5JgFgk6tcvocn0=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4732728oix.48.1595374076109;
 Tue, 21 Jul 2020 16:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APZ_SqZniWRsp68cKtnjUoP2u3Sx8j2esDDj7cM65rksEw@mail.gmail.com>
In-Reply-To: <CAAu3APZ_SqZniWRsp68cKtnjUoP2u3Sx8j2esDDj7cM65rksEw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jul 2020 16:27:44 -0700
Message-ID: <CABBYNZLW=wDistFCgtKxBid4jxSV2zACLZDrT2fMz6UZTkzohg@mail.gmail.com>
Subject: Re: Networking - NetworkServer1
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

On Tue, Jul 21, 2020 at 2:45 PM Barry Byford <31baz66@gmail.com> wrote:
>
> I am trying to get Bluetooth networking to happen between a couple of
> Raspberry Pi's running the latest Raspberry Pi OS and BlueZ 5.50
>
> $ uname -a
> Linux raspberry 4.19.118-v7+ #1311 SMP Mon Apr 27 14:21:24 BST 2020
> armv7l GNU/Linux
> $ bluetoothctl --version
> bluetoothctl: 5.50
>
> I have been able to use the Network1 interface to Connect to my
> Android phone using Bluetooth tethering.
>
> However, when I use the NetworkServer1 interface to register a profile
> I have not had success in getting two devices to communicate. I have
> paired and trusted the two devices. This allows the Bluetooth to
> connect but not for the networking interface to be created as can be
> seen in the logs:
>
> e.g. bluetoothd: BNEP server cannot be added
>
> A search for that error message didn't seem to turn up anything actionable.
>
> ```
> > ACL Data RX: Handle 11 flags 0x02 dlen 44                                           #50 [hci0] 21:54:01.130545
>       Channel: 64 len 40 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Filter MultAddr Set (0x05)
>            Length: 0x0024
>            ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
>            33:33:00:00:00:01 - 33:33:00:00:00:01
>            01:00:5e:00:00:01 - 01:00:5e:00:00:01
> < ACL Data TX: Handle 11 flags 0x00 dlen 8
>                #51 [hci0] 21:54:01.131140
>       Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Filter MultAddr Rsp (0x06)
>            Rsp msg: Operation Successful(0x0000)
> > ACL Data RX: Handle 11 flags 0x02 dlen 56                                           #52 [hci0] 21:54:01.131800
>       Channel: 64 len 52 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Filter MultAddr Set (0x05)
>            Length: 0x0030
>            ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
>            33:33:00:00:00:01 - 33:33:00:00:00:01
>            01:00:5e:00:00:01 - 01:00:5e:00:00:01
>            33:33:ff:d1:14:7e - 33:33:ff:d1:14:7e
> < ACL Data TX: Handle 11 flags 0x00 dlen 8
>                #53 [hci0] 21:54:01.131912
>       Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Filter MultAddr Rsp (0x06)
>            Rsp msg: Operation Successful(0x0000)
> > HCI Event: Number of Completed Packets (0x13) plen 5                                #54 [hci0] 21:54:01.132894
>         Num handles: 1
>         Handle: 11
>         Count: 2
> > HCI Event: Number of Completed Packets (0x13) plen 5                                #55 [hci0] 21:54:01.135075
>         Num handles: 1
>         Handle: 11
>         Count: 2
> = bluetoothd: bnep: Can't add bnep0 to the bridge tether: No such
> device(19)                     21:54:01.138304

Well it looks like the bridge (tether) does not exist so we can't add
the bnep interface, perhaps the idea is not to have it attached to any
bridge in case of GN, PAN and just bring the interface up when an
empty string is given as bridge.

> = bluetoothd: BNEP server cannot be added
>                           21:54:01.138429
> > ACL Data RX: Handle 11 flags 0x02 dlen 89                                           #56 [hci0] 21:54:01.158957
>       Channel: 64 len 85 [PSM 15 mode 0] {chan 0}
>       BNEP: Compressed Ethernet DestOnly (0x04|0)
>          dst 33:33:00:00:00:16 [proto 0x86dd]
>         60 00 00 00 00 24 00 01 00 00 00 00 00 00 00 00  `....$..........
>         00 00 00 00 00 00 00 00 ff 02 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 16 3a 00 05 02 00 00 01 00  ........:.......
>         8f 00 5a 3b 00 00 00 01 04 00 00 00 ff 02 00 00  ..Z;............
>         00 00 00 00 00 00 00 01 ff d1 14 7e              ...........~
> > ACL Data RX: Handle 11 flags 0x02 dlen 68                                           #57 [hci0] 21:54:01.265654
>       Channel: 64 len 64 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Filter MultAddr Set (0x05)
>            Length: 0x003c
>            ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
>            33:33:00:00:00:01 - 33:33:00:00:00:01
>            01:00:5e:00:00:01 - 01:00:5e:00:00:01
>            33:33:ff:d1:14:7e - 33:33:ff:d1:14:7e
>            33:33:00:00:00:fb - 33:33:00:00:00:fb
> ```
> The client seems to be created correctly.
>
> I have been searching around and I cannot find any working solutions
> being reported for GN or PANU using the tools that are currently
> available.
>
> There is this thread but it seems to have ended without conclusion
> https://marc.info/?l=linux-bluetooth&m=149129850001348&w=2
>
> I have added org.bluez.Network1 and org.bluez.NetworkServer1 to my
> /etc/dbus-1/system.d/bluetooth.conf for both server and client.
>
> Are there any other configuration files that need editing?
>
> Any help or guidance gratefully received. Pointers to a tutorial or
> the steps required would be good also as there appears to be some step
> I'm missing.
>
> Thanks,
> Barry



-- 
Luiz Augusto von Dentz
