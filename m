Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EAAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3D120754
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhA0Itn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhA0IrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 03:47:09 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAB0C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 00:46:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d15so843616qtw.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qN6c7vg3B14DRwsxa6Id/EPg+1kcCEam3iW4CnoOWf0=;
        b=lQhQTgPcIUgcJbYuIg8I1PKO6CF3F+nRCSYW9JfdjF7x0i0ZvqcMwjJq9b1WzTouFA
         Fq6WG55FnXr1aR3TKR5VkU5r62R8/uwhztYuj98jx1S2HbuIm4PCO09JrzQY/YAYIhCL
         MaXq84DGtYO2H/c9D2m+hHUtpNI/nKuWfbQQLWu1j3US09MkTcPPZW4xnJYRo46b9OV8
         NcfZhig835ulXvkLcVpFI/3/Vxjr9nMN2ELOTtfs5e2Dc39BQRMk0bCRW7kGoIEa8WQr
         N6p1WbdbfHq+Wu93igLq/WiV/lenxjK+G+gbBsjmwIdjfZHtHESp96zksaXbj2L6Ce43
         n+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qN6c7vg3B14DRwsxa6Id/EPg+1kcCEam3iW4CnoOWf0=;
        b=s2VZ+K+8tqrBuXMh8woNzjzackOhq7F1cYjTqnEu+g97kxmmBUo/JzXTirl6IBRsZb
         GdtIVeh7UVPnE1YRo6T5gSp7cyRybdLH7x5OIrKplM/fwcqw9Qc3c2dsqQgCKL+FHhCn
         Fd7e/NRy83ek34XZD47WkPrABoavTyQ58oMso8SE7uoqbF41I8ckaK1w856NnZKVR+er
         gH5LRTzY+868c0hHqRP4WlXZ5wj+wQrEqf37DD4NvSkC2Huyi98evnhbqOiKAcL49VKC
         JMF/6vYaa+sYReyUkAtTjDWaI+l4ARZbRhvR8R/gYKZuUs7/zj3jc4+sv0gNNM/HAdlJ
         uk6Q==
X-Gm-Message-State: AOAM532C708+4mp+fhG4jh2FsyfhRJifdAVK7Je1DwPqFI94iV3OHB/+
        5Eo+qhbHiUPTQ71/As+e2hvWc1E6KXFl8R8uqw==
X-Google-Smtp-Source: ABdhPJyvJmF5sUXcLCbqOZUdedIAtaNOU1zlerXA6AMHp+AWtdiLNWkVKWTFmiJwFUw2Gi+ZmyKvpplY9SFn+06nG8A=
X-Received: by 2002:ac8:6b90:: with SMTP id z16mr8714444qts.245.1611737188365;
 Wed, 27 Jan 2021 00:46:28 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
 <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
 <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
 <CABBYNZKeLsp+QhUOZQBhFuq6ZgHpZ+VPX=LYevad1UmZb5qq5g@mail.gmail.com> <CAC9s0Nbeo5-i9b_8Q2nJJfXQs=shCTFEkQ5ZVeevghp-PEQfKw@mail.gmail.com>
In-Reply-To: <CAC9s0Nbeo5-i9b_8Q2nJJfXQs=shCTFEkQ5ZVeevghp-PEQfKw@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Wed, 27 Jan 2021 00:46:17 -0800
Message-ID: <CAC9s0NZyTd-2Sk+p6ZmxpTuPzL5WJpF8fauQY-9Ek2HSKE58Ew@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, Jan 27, 2021 at 12:42 AM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> Thank you so much for your information.
>
> I created a test GATT server from the sample
> code(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> I have 2 python scripts. In the "bt_read.py" I created, the Heart Rate
> Measurement(2A37) and Body Sensor Location(2A38) only have Read
> attribute. In the "bt_notify.py" I created, the Heart Rate
> Measurement(2A37) and Body Sensor Location(2A38) only have both the
> Read and Notify attribute.
>
> Here is what I did:
> I ran the "bt_read.py" and captured the btmon log. Then I ran
> "bt_notify.py" and captured the btmon log. I read both logs. But I
> don't see there is any info regarding the "Service Changed
> Indication".
>
> Here is the btmon log with both the Read and Notify attributes below.
> Thanks again for your help!
> =========================================================================
> Bluetooth monitor ver 5.48
> = Note: Linux version 4.19.35-g92e18fefc77 (armv7l)                    0.809169
> = Note: Bluetooth subsystem version 2.22                               0.809182
> = New Index: 00:16:A4:4A:2D:27 (Primary,UART,hci0)              [hci0] 0.809187
> = Open Index: 00:16:A4:4A:2D:27                                 [hci0] 0.809190
> = Index Info: 00:16:A4:4.. (Cypress Semiconductor Corporation)  [hci0] 0.809194
> @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0002} 0.809200
> @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.809203
> @ MGMT Open: btmon (privileged) version 1.14                  {0x0003} 0.809276
> > ACL Data RX: Handle 65 flags 0x02 dlen 8                   #1 [hci0] 4.543721
>       ATT: Handle Value Notification (0x1b) len 3
>         Handle: 0x0016
>           Data: 64
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #2 [hci0] 6.883753
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0001-0xffff
>         Attribute group type: Primary Service (0x2800)
> < ACL Data TX: Handle 65 flags 0x00 dlen 30                  #3 [hci0] 6.884412
>       ATT: Read By Group Type Response (0x11) len 25
>         Attribute data length: 6
>         Attribute group list: 4 entries
>         Handle range: 0x0001-0x0005
>         UUID: Generic Access Profile (0x1800)
>         Handle range: 0x0006-0x0009
>         UUID: Generic Attribute Profile (0x1801)
>         Handle range: 0x0234-0x023c
>         UUID: Heart Rate (0x180d)
>         Handle range: 0x023d-0x0240
>         UUID: Battery Service (0x180f)
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #4 [hci0] 6.944638
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0241-0xffff
>         Attribute group type: Primary Service (0x2800)
> < ACL Data TX: Handle 65 flags 0x00 dlen 26                  #5 [hci0] 6.945293
>       ATT: Read By Group Type Response (0x11) len 21
>         Attribute data length: 20
>         Attribute group list: 1 entry
>         Handle range: 0x0241-0x0250
>         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #6 [hci0] 7.004723
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0251-0xffff
>         Attribute group type: Primary Service (0x2800)
> < ACL Data TX: Handle 65 flags 0x00 dlen 9                   #7 [hci0] 7.005369
>       ATT: Error Response (0x01) len 4
>         Read By Group Type Request (0x10)
>         Handle: 0x0251
>         Error: Attribute Not Found (0x0a)
> > HCI Event: Number of Completed Packets (0x13) plen 5       #8 [hci0] 7.005549
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #9 [hci0] 7.064450
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0234-0x023c
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 65 flags 0x00 dlen 27                 #10 [hci0] 7.065112
>       ATT: Read By Type Response (0x09) len 22
>         Attribute data length: 7
>         Attribute data list: 3 entries
>         Handle: 0x0235
>         Value: 123602372a
>         Handle: 0x0238
>         Value: 123902382a
>         Handle: 0x023b
>         Value: 083c02392a
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #11 [hci0] 7.124428
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x023d-0x0240
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 65 flags 0x00 dlen 13                 #12 [hci0] 7.125226
>       ATT: Read By Type Response (0x09) len 8
>         Attribute data length: 7
>         Attribute data list: 1 entry
>         Handle: 0x023e
>         Value: 123f02192a
> > HCI Event: Number of Completed Packets (0x13) plen 5      #13 [hci0] 7.125376
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #14 [hci0] 7.184416
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0241-0x0250
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 65 flags 0x00 dlen 69                 #15 [hci0] 7.185101
>       ATT: Read By Type Response (0x09) len 64
>         Attribute data length: 21
>         Attribute data list: 3 entries
>         Handle: 0x0242
>         Value: 8a4302f1debc9a785634127856341278563412
>         Handle: 0x0247
>         Value: 8a4802f3debc9a785634127856341278563412
>         Handle: 0x024c
>         Value: 8a4d02f5debc9a785634127856341278563412
> > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #16 [hci0] 7.244526
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x024e-0x0250
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 65 flags 0x00 dlen 9                  #17 [hci0] 7.246144
>       ATT: Error Response (0x01) len 4
>         Read By Type Request (0x08)
>         Handle: 0x024e
>         Error: Attribute Not Found (0x0a)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #18 [hci0] 7.246564
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #19 [hci0] 7.304500
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0237-0x0237
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #20 [hci0] 7.305951
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0237
>         UUID: Client Characteristic Configuration (0x2902)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #21 [hci0] 7.364540
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x023a-0x023a
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #22 [hci0] 7.366242
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x023a
>         UUID: Client Characteristic Configuration (0x2902)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 7.366660
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #24 [hci0] 7.424617
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0240-0x0240
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #25 [hci0] 7.426085
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0240
>         UUID: Client Characteristic Configuration (0x2902)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #26 [hci0] 7.484523
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0244-0x0246
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #27 [hci0] 7.486104
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0244
>         UUID: Characteristic Extended Properties (0x2900)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #28 [hci0] 7.486520
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #29 [hci0] 7.544546
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0245-0x0246
> < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #30 [hci0] 7.546011
>       ATT: Find Information Response (0x05) len 19
>         Format: UUID-128 (0x02)
>         Handle: 0x0245
>         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef2)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #31 [hci0] 7.604713
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0246-0x0246
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #32 [hci0] 7.606323
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0246
>         UUID: Characteristic User Description (0x2901)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #33 [hci0] 7.606747
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #34 [hci0] 7.664243
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0249-0x024b
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #35 [hci0] 7.665862
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0249
>         UUID: Characteristic Extended Properties (0x2900)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #36 [hci0] 7.724603
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x024a-0x024b
> < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #37 [hci0] 7.726315
>       ATT: Find Information Response (0x05) len 19
>         Format: UUID-128 (0x02)
>         Handle: 0x024a
>         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef4)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #38 [hci0] 7.726625
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #39 [hci0] 7.784545
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x024b-0x024b
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #40 [hci0] 7.785996
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x024b
>         UUID: Characteristic User Description (0x2901)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #41 [hci0] 7.844187
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x024e-0x0250
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #42 [hci0] 7.845777
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x024e
>         UUID: Characteristic Extended Properties (0x2900)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #43 [hci0] 7.846215
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #44 [hci0] 7.904466
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x024f-0x0250
> < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #45 [hci0] 7.906160
>       ATT: Find Information Response (0x05) len 19
>         Format: UUID-128 (0x02)
>         Handle: 0x024f
>         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef6)
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #46 [hci0] 7.964493
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0250-0x0250
> < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #47 [hci0] 7.966067
>       ATT: Find Information Response (0x05) len 5
>         Format: UUID-16 (0x01)
>         Handle: 0x0250
>         UUID: Characteristic User Description (0x2901)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #48 [hci0] 7.966489
>         Num handles: 1
>         Handle: 65
>         Count: 2
> > HCI Event: Number of Completed Packets (0x13) plen 5      #49 [hci0] 8.203559
>         Num handles: 1
>         Handle: 65
>         Count: 1
> > ACL Data RX: Handle 65 flags 0x02 dlen 7                 #50 [hci0] 11.833674
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x0236
> < ACL Data TX: Handle 65 flags 0x00 dlen 7                 #51 [hci0] 11.840770
>       ATT: Read Response (0x0b) len 2
>         Value: 0663
> > HCI Event: Number of Completed Packets (0x13) plen 5     #52 [hci0] 12.078687
>         Num handles: 1
>         Handle: 65
>         Count: 1
> > ACL Data RX: Handle 65 flags 0x02 dlen 9                 #53 [hci0] 14.055212
>       ATT: Write Request (0x12) len 4
>         Handle: 0x0237
>           Data: 0100
> < ACL Data TX: Handle 65 flags 0x00 dlen 5                 #54 [hci0] 14.056230
>       ATT: Write Response (0x13) len 0
> > HCI Event: Number of Completed Packets (0x13) plen 5     #55 [hci0] 14.329045
>         Num handles: 1
>         Handle: 65
>         Count: 1
> < ACL Data TX: Handle 65 flags 0x00 dlen 11                #56 [hci0] 15.078671
>       ATT: Handle Value Notification (0x1b) len 6
>         Handle: 0x0236
>           Data: 0e750000
> > HCI Event: Number of Completed Packets (0x13) plen 5     #57 [hci0] 15.330353
>         Num handles: 1
>         Handle: 65
>         Count: 1
> < ACL Data TX: Handle 65 flags 0x00 dlen 9                 #58 [hci0] 16.071839
>       ATT: Handle Value Notification (0x1b) len 4
>         Handle: 0x0236
>           Data: 066e
> > ACL Data RX: H
>
> On Mon, Jan 25, 2021 at 9:59 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Kenny,
> >
> > On Sun, Jan 24, 2021 at 10:42 PM Kenny Bian <kennybian@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thank you so much for your reply. I appreciate it.
> > >
> > > By "registering the services", do you mean "RegisterApplication()" in
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n656?
> > > If that is the case, I believe I already registered the services.
> > > I checked the files in /var/lib/bluetooth. According to
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321,
> > > there should be a "[ServiceChanged]" section in the "info" file. But I
> > > don't see it in the "info" file. Is there a way to tell the "Service
> > > Changed Indication" is actually working?
> > > Let's suppose the "Service Changed Indication" is already enabled, is
> > > there a way for the mobile app to check on their side to tell which
> > > service(s) got changed?
> >
> > HCI traces (btmon) should be able to tell you if it has been
> > subscribed or not, if there is an Indication in it it probably means
> > the remote has subscribed.
> >
> > > Thanks again for your help.
> > >
> > > On Sun, Jan 24, 2021 at 7:35 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Kenny,
> > > >
> > > > On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > We implemented a GATT server on Linux in Python. The code is based on
> > > > > the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > > > > The BlueZ version is 5.48. But we found a problem. The cached data in
> > > > > /var/lib/bluetooth caused the mobile app to crash if some
> > > > > characteristics are changed. After some research, we found "Under BLE
> > > > > standard 'Generic Attribute'(0x1801), there is a Characteristic
> > > > > 'Service Changed' (0x2A05) with 'indicate' property", see
> > > > > https://github.com/espressif/esp-idf/issues/1777.
> > > > >
> > > > > The questions we have:
> > > > > How to enable the "Service Changed Indication"(0x2A05) in the
> > > > > bluetooth? Is there any code example in Python?
> > > >
> > > > If you are registering the services with Bluetoothd then it should
> > > > generate the service change automatically:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185
> > > >
> > > > When a new service is registered it is indicated here:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
