Return-Path: <SRS0=Dy9H=BA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5953FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 21:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E062068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 21:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdgJGviA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgGUVjO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUVjO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 17:39:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356AC061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 14:39:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k17so151247lfg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ITLa5KsgjkvocWnqtKgbMwAzWNbO2EQZpxksrmEUcbM=;
        b=IdgJGviA4kEEP2CrsI6w9RMd6/0xRSq47+gOCLm46BYnFO4EsbVjl/ln6iEspjDAE7
         jbvmcC4OrT4xpuesHGL8GWGT0SBm+uTbZ8fdW4TdmzmXoikk56/oEOIo/wDwTo9hYzAT
         6DF9SWPWwQED5tW1grmFs+KCiKpmdRPAHx70CLaFi3dD7k5FCy1Pr+kfFikxBk0/d+6j
         8eBp+RJmeSlBk348CnQIjEgx4uAnA9M2sM5IQHv52CzLx/QfeVWAfnUItS6nSg/IhPOm
         o9fk2kK+/oXHeFhT+4mLUxN/aHita5cRC/V42MLW8HfgfjR2o+PcuuZFVgiWrTjEMKiT
         poRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ITLa5KsgjkvocWnqtKgbMwAzWNbO2EQZpxksrmEUcbM=;
        b=BGDsTuw2TP97zkcK3qlsO34nsSHzSZkh62ybDpqpfRo3D7JD8QohUO9q8mX2TWg1nq
         FKk+PJkyLjmYinPGdkPxZ3l6s+yPRBhbyUNWLhgEeGIRtcQpeWNOXgGLamzwzA18EWUz
         5JnYWk4Ev/50ZnUx0IYemaPE8lV0Ym1gROgPaFmZrtYtlzpa0aVlSBrzUT4RGGlSNQoN
         vCn57xcv5HNd9sCPCcVJPMNbh9bksfP21LaoumXiZLspg0UItPnzfeR1bFdDwOH1PVJl
         sIRQTlIMKnBPB+jnaRkWew5Y80ipVwPiX1C1sYzFHux2ZMSXFzX4etbJp2zGFpqdgD2L
         u4Fw==
X-Gm-Message-State: AOAM531tVdiNGycqVFjKqS3rfq1rTvATZbntZiK4B+uzALxNIu+plczK
        9nTqBjAf4JkXhbi2eNCZDLMta10Y51bWVarZIm8/au2s9+Y=
X-Google-Smtp-Source: ABdhPJxuuTiC7VG0TtVTycbwEMqlMG23YS0TL2mIT0fS9f/CKhxYPigS4jFiRiZyIQfkehQtvwY1gYefYr9e13rccng=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr10532695lff.189.1595367551520;
 Tue, 21 Jul 2020 14:39:11 -0700 (PDT)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Tue, 21 Jul 2020 22:38:59 +0100
Message-ID: <CAAu3APZ_SqZniWRsp68cKtnjUoP2u3Sx8j2esDDj7cM65rksEw@mail.gmail.com>
Subject: Networking - NetworkServer1
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am trying to get Bluetooth networking to happen between a couple of
Raspberry Pi's running the latest Raspberry Pi OS and BlueZ 5.50

$ uname -a
Linux raspberry 4.19.118-v7+ #1311 SMP Mon Apr 27 14:21:24 BST 2020
armv7l GNU/Linux
$ bluetoothctl --version
bluetoothctl: 5.50

I have been able to use the Network1 interface to Connect to my
Android phone using Bluetooth tethering.

However, when I use the NetworkServer1 interface to register a profile
I have not had success in getting two devices to communicate. I have
paired and trusted the two devices. This allows the Bluetooth to
connect but not for the networking interface to be created as can be
seen in the logs:

e.g. bluetoothd: BNEP server cannot be added

A search for that error message didn't seem to turn up anything actionable.

```
> ACL Data RX: Handle 11 flags 0x02 dlen 44                                           #50 [hci0] 21:54:01.130545
      Channel: 64 len 40 [PSM 15 mode 0] {chan 0}
      BNEP: Control (0x01|0)
         Filter MultAddr Set (0x05)
           Length: 0x0024
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           33:33:00:00:00:01 - 33:33:00:00:00:01
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL Data TX: Handle 11 flags 0x00 dlen 8
               #51 [hci0] 21:54:01.131140
      Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
      BNEP: Control (0x01|0)
         Filter MultAddr Rsp (0x06)
           Rsp msg: Operation Successful(0x0000)
> ACL Data RX: Handle 11 flags 0x02 dlen 56                                           #52 [hci0] 21:54:01.131800
      Channel: 64 len 52 [PSM 15 mode 0] {chan 0}
      BNEP: Control (0x01|0)
         Filter MultAddr Set (0x05)
           Length: 0x0030
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           33:33:00:00:00:01 - 33:33:00:00:00:01
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
           33:33:ff:d1:14:7e - 33:33:ff:d1:14:7e
< ACL Data TX: Handle 11 flags 0x00 dlen 8
               #53 [hci0] 21:54:01.131912
      Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
      BNEP: Control (0x01|0)
         Filter MultAddr Rsp (0x06)
           Rsp msg: Operation Successful(0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5                                #54 [hci0] 21:54:01.132894
        Num handles: 1
        Handle: 11
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                #55 [hci0] 21:54:01.135075
        Num handles: 1
        Handle: 11
        Count: 2
= bluetoothd: bnep: Can't add bnep0 to the bridge tether: No such
device(19)                     21:54:01.138304
= bluetoothd: BNEP server cannot be added
                          21:54:01.138429
> ACL Data RX: Handle 11 flags 0x02 dlen 89                                           #56 [hci0] 21:54:01.158957
      Channel: 64 len 85 [PSM 15 mode 0] {chan 0}
      BNEP: Compressed Ethernet DestOnly (0x04|0)
         dst 33:33:00:00:00:16 [proto 0x86dd]
        60 00 00 00 00 24 00 01 00 00 00 00 00 00 00 00  `....$..........
        00 00 00 00 00 00 00 00 ff 02 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 16 3a 00 05 02 00 00 01 00  ........:.......
        8f 00 5a 3b 00 00 00 01 04 00 00 00 ff 02 00 00  ..Z;............
        00 00 00 00 00 00 00 01 ff d1 14 7e              ...........~
> ACL Data RX: Handle 11 flags 0x02 dlen 68                                           #57 [hci0] 21:54:01.265654
      Channel: 64 len 64 [PSM 15 mode 0] {chan 0}
      BNEP: Control (0x01|0)
         Filter MultAddr Set (0x05)
           Length: 0x003c
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           33:33:00:00:00:01 - 33:33:00:00:00:01
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
           33:33:ff:d1:14:7e - 33:33:ff:d1:14:7e
           33:33:00:00:00:fb - 33:33:00:00:00:fb
```
The client seems to be created correctly.

I have been searching around and I cannot find any working solutions
being reported for GN or PANU using the tools that are currently
available.

There is this thread but it seems to have ended without conclusion
https://marc.info/?l=linux-bluetooth&m=149129850001348&w=2

I have added org.bluez.Network1 and org.bluez.NetworkServer1 to my
/etc/dbus-1/system.d/bluetooth.conf for both server and client.

Are there any other configuration files that need editing?

Any help or guidance gratefully received. Pointers to a tutorial or
the steps required would be good also as there appears to be some step
I'm missing.

Thanks,
Barry
