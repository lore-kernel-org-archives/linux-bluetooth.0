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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF12420754
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 08:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhA0IxT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhA0IvQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 03:51:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D4C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 00:50:34 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id a12so1004794qkh.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7b0L8DwgxG5510BBymAHhINQThvF7yLZYvaBaZtH0M=;
        b=VW79dsuXIxTVVSGiIQkZLyzA32RtZ4ukPAEv0vSPyH3/EvWXZzlLw92m5TZHiF0kqF
         rdBv7YeCU6UshRHGFFhAg/lPNqXgbwK9ArHJZxMAF9K+G/7+cczb8/qx9wYrvQ1zcA7M
         x19vfip2ODJwLfI/GeKOHsbo5L8UigLiPbiwgmI7r9lQHfGemSqRV/FgMBCQW4yI6Umk
         6JRSl24YDeddN1t5X5YOKfIZKif5Dq9wbnzc/oT+6ImJps+kg4TBlUZvIMNY4XSMTC9/
         WdCL8XZ5iP9tRWK8Eu4Xn/sYrVvlRDidAkN2KqYTh5c/ZECCu3NURwOqLfJQvaafji0+
         IpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7b0L8DwgxG5510BBymAHhINQThvF7yLZYvaBaZtH0M=;
        b=V0ODfu2lFTLmxu+vW/CKgOGqeabzwQ/SSb9tzGAxW80xo+yxQRpayeoX0fY6F8ruo5
         u/cbALaYcLCtS2FpTAp4ZQSl+MyJ0hCZguYLeHDS79q5aI0/v6nnDscI97kBfBCILVvp
         6iIQq2kKoRbMjcTGkJGhUubq0T0+ST7z2iLjXDgZdXPt9mHc18xe2VvVPCEVcqpkfZAV
         j4UcP68gDLrc3fAe1pXdSy8l0+FM69aUl34E+Ap8HDMnyXzcXwDgeVuWnk05Y/LTEFuZ
         jcsfU2MDtKzIg84rtnSH5uaMDHRCHeVahFouSK/SvQ4LKVefG+DutQCSKjmdvO5gOzLi
         TKng==
X-Gm-Message-State: AOAM531UedXuP+LuTud1namzMGmNtS+4TAlNWNpDO+MtPDOfOb1FpLOe
        H3z6cMzPbeIaeFgxGq7C1z7llhzh4MN8Uotmk3xB78tY2FpC
X-Google-Smtp-Source: ABdhPJxfMIA697xENc4MvQ/8Mygj4C5EEIXQkVOzv4Cc9vKBiPbXv0YDu/YgeP/Ah4KKB1BwQQsbFCuZCpI8qgUCGUU=
X-Received: by 2002:a37:d286:: with SMTP id f128mr9305009qkj.462.1611737432619;
 Wed, 27 Jan 2021 00:50:32 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
 <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
 <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
 <CABBYNZKeLsp+QhUOZQBhFuq6ZgHpZ+VPX=LYevad1UmZb5qq5g@mail.gmail.com>
 <CAC9s0Nbeo5-i9b_8Q2nJJfXQs=shCTFEkQ5ZVeevghp-PEQfKw@mail.gmail.com> <CAC9s0NZyTd-2Sk+p6ZmxpTuPzL5WJpF8fauQY-9Ek2HSKE58Ew@mail.gmail.com>
In-Reply-To: <CAC9s0NZyTd-2Sk+p6ZmxpTuPzL5WJpF8fauQY-9Ek2HSKE58Ew@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Wed, 27 Jan 2021 00:50:21 -0800
Message-ID: <CAC9s0NawyWK=nvjt1O4mN_DAJd_-YVF+1eJ1QWXCudjYXeuXpA@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000024a89405b9dddda4"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--00000000000024a89405b9dddda4
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

I'm not sure if I can attach files to this forum. I just try to attach
the files about the "Service Changed Indication" issue.

Here is the list of files:
bt_read.py - the script that the "Heart Rate Measurement" and "Body
Sensor Location" characteristics only have the Read attribute
bt_notify.py - the script that the "Heart Rate Measurement" and "Body
Sensor Location" characteristics only have both the Read and Notify
attributes
btmon_read.log - the btmon log when running bt_read.py
btmon_notify.log - the btmon log when running bt_notify.py

Thank you very much!

On Wed, Jan 27, 2021 at 12:46 AM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> On Wed, Jan 27, 2021 at 12:42 AM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > Thank you so much for your information.
> >
> > I created a test GATT server from the sample
> > code(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > I have 2 python scripts. In the "bt_read.py" I created, the Heart Rate
> > Measurement(2A37) and Body Sensor Location(2A38) only have Read
> > attribute. In the "bt_notify.py" I created, the Heart Rate
> > Measurement(2A37) and Body Sensor Location(2A38) only have both the
> > Read and Notify attribute.
> >
> > Here is what I did:
> > I ran the "bt_read.py" and captured the btmon log. Then I ran
> > "bt_notify.py" and captured the btmon log. I read both logs. But I
> > don't see there is any info regarding the "Service Changed
> > Indication".
> >
> > Here is the btmon log with both the Read and Notify attributes below.
> > Thanks again for your help!
> > =========================================================================
> > Bluetooth monitor ver 5.48
> > = Note: Linux version 4.19.35-g92e18fefc77 (armv7l)                    0.809169
> > = Note: Bluetooth subsystem version 2.22                               0.809182
> > = New Index: 00:16:A4:4A:2D:27 (Primary,UART,hci0)              [hci0] 0.809187
> > = Open Index: 00:16:A4:4A:2D:27                                 [hci0] 0.809190
> > = Index Info: 00:16:A4:4.. (Cypress Semiconductor Corporation)  [hci0] 0.809194
> > @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0002} 0.809200
> > @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.809203
> > @ MGMT Open: btmon (privileged) version 1.14                  {0x0003} 0.809276
> > > ACL Data RX: Handle 65 flags 0x02 dlen 8                   #1 [hci0] 4.543721
> >       ATT: Handle Value Notification (0x1b) len 3
> >         Handle: 0x0016
> >           Data: 64
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #2 [hci0] 6.883753
> >       ATT: Read By Group Type Request (0x10) len 6
> >         Handle range: 0x0001-0xffff
> >         Attribute group type: Primary Service (0x2800)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 30                  #3 [hci0] 6.884412
> >       ATT: Read By Group Type Response (0x11) len 25
> >         Attribute data length: 6
> >         Attribute group list: 4 entries
> >         Handle range: 0x0001-0x0005
> >         UUID: Generic Access Profile (0x1800)
> >         Handle range: 0x0006-0x0009
> >         UUID: Generic Attribute Profile (0x1801)
> >         Handle range: 0x0234-0x023c
> >         UUID: Heart Rate (0x180d)
> >         Handle range: 0x023d-0x0240
> >         UUID: Battery Service (0x180f)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #4 [hci0] 6.944638
> >       ATT: Read By Group Type Request (0x10) len 6
> >         Handle range: 0x0241-0xffff
> >         Attribute group type: Primary Service (0x2800)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 26                  #5 [hci0] 6.945293
> >       ATT: Read By Group Type Response (0x11) len 21
> >         Attribute data length: 20
> >         Attribute group list: 1 entry
> >         Handle range: 0x0241-0x0250
> >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #6 [hci0] 7.004723
> >       ATT: Read By Group Type Request (0x10) len 6
> >         Handle range: 0x0251-0xffff
> >         Attribute group type: Primary Service (0x2800)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 9                   #7 [hci0] 7.005369
> >       ATT: Error Response (0x01) len 4
> >         Read By Group Type Request (0x10)
> >         Handle: 0x0251
> >         Error: Attribute Not Found (0x0a)
> > > HCI Event: Number of Completed Packets (0x13) plen 5       #8 [hci0] 7.005549
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #9 [hci0] 7.064450
> >       ATT: Read By Type Request (0x08) len 6
> >         Handle range: 0x0234-0x023c
> >         Attribute type: Characteristic (0x2803)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 27                 #10 [hci0] 7.065112
> >       ATT: Read By Type Response (0x09) len 22
> >         Attribute data length: 7
> >         Attribute data list: 3 entries
> >         Handle: 0x0235
> >         Value: 123602372a
> >         Handle: 0x0238
> >         Value: 123902382a
> >         Handle: 0x023b
> >         Value: 083c02392a
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #11 [hci0] 7.124428
> >       ATT: Read By Type Request (0x08) len 6
> >         Handle range: 0x023d-0x0240
> >         Attribute type: Characteristic (0x2803)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 13                 #12 [hci0] 7.125226
> >       ATT: Read By Type Response (0x09) len 8
> >         Attribute data length: 7
> >         Attribute data list: 1 entry
> >         Handle: 0x023e
> >         Value: 123f02192a
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #13 [hci0] 7.125376
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #14 [hci0] 7.184416
> >       ATT: Read By Type Request (0x08) len 6
> >         Handle range: 0x0241-0x0250
> >         Attribute type: Characteristic (0x2803)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 69                 #15 [hci0] 7.185101
> >       ATT: Read By Type Response (0x09) len 64
> >         Attribute data length: 21
> >         Attribute data list: 3 entries
> >         Handle: 0x0242
> >         Value: 8a4302f1debc9a785634127856341278563412
> >         Handle: 0x0247
> >         Value: 8a4802f3debc9a785634127856341278563412
> >         Handle: 0x024c
> >         Value: 8a4d02f5debc9a785634127856341278563412
> > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #16 [hci0] 7.244526
> >       ATT: Read By Type Request (0x08) len 6
> >         Handle range: 0x024e-0x0250
> >         Attribute type: Characteristic (0x2803)
> > < ACL Data TX: Handle 65 flags 0x00 dlen 9                  #17 [hci0] 7.246144
> >       ATT: Error Response (0x01) len 4
> >         Read By Type Request (0x08)
> >         Handle: 0x024e
> >         Error: Attribute Not Found (0x0a)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #18 [hci0] 7.246564
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #19 [hci0] 7.304500
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0237-0x0237
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #20 [hci0] 7.305951
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0237
> >         UUID: Client Characteristic Configuration (0x2902)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #21 [hci0] 7.364540
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x023a-0x023a
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #22 [hci0] 7.366242
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x023a
> >         UUID: Client Characteristic Configuration (0x2902)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 7.366660
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #24 [hci0] 7.424617
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0240-0x0240
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #25 [hci0] 7.426085
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0240
> >         UUID: Client Characteristic Configuration (0x2902)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #26 [hci0] 7.484523
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0244-0x0246
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #27 [hci0] 7.486104
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0244
> >         UUID: Characteristic Extended Properties (0x2900)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #28 [hci0] 7.486520
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #29 [hci0] 7.544546
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0245-0x0246
> > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #30 [hci0] 7.546011
> >       ATT: Find Information Response (0x05) len 19
> >         Format: UUID-128 (0x02)
> >         Handle: 0x0245
> >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef2)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #31 [hci0] 7.604713
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0246-0x0246
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #32 [hci0] 7.606323
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0246
> >         UUID: Characteristic User Description (0x2901)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #33 [hci0] 7.606747
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #34 [hci0] 7.664243
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0249-0x024b
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #35 [hci0] 7.665862
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0249
> >         UUID: Characteristic Extended Properties (0x2900)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #36 [hci0] 7.724603
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x024a-0x024b
> > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #37 [hci0] 7.726315
> >       ATT: Find Information Response (0x05) len 19
> >         Format: UUID-128 (0x02)
> >         Handle: 0x024a
> >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef4)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #38 [hci0] 7.726625
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #39 [hci0] 7.784545
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x024b-0x024b
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #40 [hci0] 7.785996
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x024b
> >         UUID: Characteristic User Description (0x2901)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #41 [hci0] 7.844187
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x024e-0x0250
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #42 [hci0] 7.845777
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x024e
> >         UUID: Characteristic Extended Properties (0x2900)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #43 [hci0] 7.846215
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #44 [hci0] 7.904466
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x024f-0x0250
> > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #45 [hci0] 7.906160
> >       ATT: Find Information Response (0x05) len 19
> >         Format: UUID-128 (0x02)
> >         Handle: 0x024f
> >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef6)
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #46 [hci0] 7.964493
> >       ATT: Find Information Request (0x04) len 4
> >         Handle range: 0x0250-0x0250
> > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #47 [hci0] 7.966067
> >       ATT: Find Information Response (0x05) len 5
> >         Format: UUID-16 (0x01)
> >         Handle: 0x0250
> >         UUID: Characteristic User Description (0x2901)
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #48 [hci0] 7.966489
> >         Num handles: 1
> >         Handle: 65
> >         Count: 2
> > > HCI Event: Number of Completed Packets (0x13) plen 5      #49 [hci0] 8.203559
> >         Num handles: 1
> >         Handle: 65
> >         Count: 1
> > > ACL Data RX: Handle 65 flags 0x02 dlen 7                 #50 [hci0] 11.833674
> >       ATT: Read Request (0x0a) len 2
> >         Handle: 0x0236
> > < ACL Data TX: Handle 65 flags 0x00 dlen 7                 #51 [hci0] 11.840770
> >       ATT: Read Response (0x0b) len 2
> >         Value: 0663
> > > HCI Event: Number of Completed Packets (0x13) plen 5     #52 [hci0] 12.078687
> >         Num handles: 1
> >         Handle: 65
> >         Count: 1
> > > ACL Data RX: Handle 65 flags 0x02 dlen 9                 #53 [hci0] 14.055212
> >       ATT: Write Request (0x12) len 4
> >         Handle: 0x0237
> >           Data: 0100
> > < ACL Data TX: Handle 65 flags 0x00 dlen 5                 #54 [hci0] 14.056230
> >       ATT: Write Response (0x13) len 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5     #55 [hci0] 14.329045
> >         Num handles: 1
> >         Handle: 65
> >         Count: 1
> > < ACL Data TX: Handle 65 flags 0x00 dlen 11                #56 [hci0] 15.078671
> >       ATT: Handle Value Notification (0x1b) len 6
> >         Handle: 0x0236
> >           Data: 0e750000
> > > HCI Event: Number of Completed Packets (0x13) plen 5     #57 [hci0] 15.330353
> >         Num handles: 1
> >         Handle: 65
> >         Count: 1
> > < ACL Data TX: Handle 65 flags 0x00 dlen 9                 #58 [hci0] 16.071839
> >       ATT: Handle Value Notification (0x1b) len 4
> >         Handle: 0x0236
> >           Data: 066e
> > > ACL Data RX: H
> >
> > On Mon, Jan 25, 2021 at 9:59 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Kenny,
> > >
> > > On Sun, Jan 24, 2021 at 10:42 PM Kenny Bian <kennybian@gmail.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Thank you so much for your reply. I appreciate it.
> > > >
> > > > By "registering the services", do you mean "RegisterApplication()" in
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n656?
> > > > If that is the case, I believe I already registered the services.
> > > > I checked the files in /var/lib/bluetooth. According to
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321,
> > > > there should be a "[ServiceChanged]" section in the "info" file. But I
> > > > don't see it in the "info" file. Is there a way to tell the "Service
> > > > Changed Indication" is actually working?
> > > > Let's suppose the "Service Changed Indication" is already enabled, is
> > > > there a way for the mobile app to check on their side to tell which
> > > > service(s) got changed?
> > >
> > > HCI traces (btmon) should be able to tell you if it has been
> > > subscribed or not, if there is an Indication in it it probably means
> > > the remote has subscribed.
> > >
> > > > Thanks again for your help.
> > > >
> > > > On Sun, Jan 24, 2021 at 7:35 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Kenny,
> > > > >
> > > > > On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > We implemented a GATT server on Linux in Python. The code is based on
> > > > > > the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > > > > > The BlueZ version is 5.48. But we found a problem. The cached data in
> > > > > > /var/lib/bluetooth caused the mobile app to crash if some
> > > > > > characteristics are changed. After some research, we found "Under BLE
> > > > > > standard 'Generic Attribute'(0x1801), there is a Characteristic
> > > > > > 'Service Changed' (0x2A05) with 'indicate' property", see
> > > > > > https://github.com/espressif/esp-idf/issues/1777.
> > > > > >
> > > > > > The questions we have:
> > > > > > How to enable the "Service Changed Indication"(0x2A05) in the
> > > > > > bluetooth? Is there any code example in Python?
> > > > >
> > > > > If you are registering the services with Bluetoothd then it should
> > > > > generate the service change automatically:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185
> > > > >
> > > > > When a new service is registered it is indicated here:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz

--00000000000024a89405b9dddda4
Content-Type: text/plain; charset="US-ASCII"; name="bt_read.py"
Content-Disposition: attachment; filename="bt_read.py"
Content-Transfer-Encoding: base64
Content-ID: <f_kkf6ucqm1>
X-Attachment-Id: f_kkf6ucqm1

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKaW1wb3J0IGRidXMKaW1wb3J0IGRidXMuZXhjZXB0aW9u
cwppbXBvcnQgZGJ1cy5tYWlubG9vcC5nbGliCmltcG9ydCBkYnVzLnNlcnZpY2UKCmltcG9ydCBh
cnJheQp0cnk6CiAgZnJvbSBnaS5yZXBvc2l0b3J5IGltcG9ydCBHT2JqZWN0CmV4Y2VwdCBJbXBv
cnRFcnJvcjoKICBpbXBvcnQgZ29iamVjdCBhcyBHT2JqZWN0CmltcG9ydCBzeXMKCmZyb20gcmFu
ZG9tIGltcG9ydCByYW5kaW50CgojIEFkdmVydAppbXBvcnQgZ29iamVjdAoKbWFpbmxvb3AgPSBO
b25lCgpCTFVFWl9TRVJWSUNFX05BTUUgPSAnb3JnLmJsdWV6JwpHQVRUX01BTkFHRVJfSUZBQ0Ug
PSAnb3JnLmJsdWV6LkdhdHRNYW5hZ2VyMScKREJVU19PTV9JRkFDRSA9ICAgICAgJ29yZy5mcmVl
ZGVza3RvcC5EQnVzLk9iamVjdE1hbmFnZXInCkRCVVNfUFJPUF9JRkFDRSA9ICAgICdvcmcuZnJl
ZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzJwoKR0FUVF9TRVJWSUNFX0lGQUNFID0gJ29yZy5ibHVl
ei5HYXR0U2VydmljZTEnCkdBVFRfQ0hSQ19JRkFDRSA9ICAgICdvcmcuYmx1ZXouR2F0dENoYXJh
Y3RlcmlzdGljMScKR0FUVF9ERVNDX0lGQUNFID0gICAgJ29yZy5ibHVlei5HYXR0RGVzY3JpcHRv
cjEnCgojIEFkdmVydApMRV9BRFZFUlRJU0lOR19NQU5BR0VSX0lGQUNFID0gJ29yZy5ibHVlei5M
RUFkdmVydGlzaW5nTWFuYWdlcjEnCkxFX0FEVkVSVElTRU1FTlRfSUZBQ0UgPSAnb3JnLmJsdWV6
LkxFQWR2ZXJ0aXNlbWVudDEnCgojIEFkdmVydApjbGFzcyBJbnZhbGlkQXJnc0V4Y2VwdGlvbihk
YnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1c19lcnJvcl9uYW1lID0gJ29y
Zy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLkludmFsaWRBcmdzJwoKCmNsYXNzIE5vdFN1cHBvcnRl
ZEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1c19lcnJv
cl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5Ob3RTdXBwb3J0ZWQnCgoKY2xhc3MgTm90UGVybWl0
dGVkRXhjZXB0aW9uKGRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vy
cm9yX25hbWUgPSAnb3JnLmJsdWV6LkVycm9yLk5vdFBlcm1pdHRlZCcKCgpjbGFzcyBJbnZhbGlk
VmFsdWVMZW5ndGhFeGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAg
X2RidXNfZXJyb3JfbmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuSW52YWxpZFZhbHVlTGVuZ3RoJwoK
CmNsYXNzIEZhaWxlZEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAg
ICBfZGJ1c19lcnJvcl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5GYWlsZWQnCgoKY2xhc3MgQWR2
ZXJ0aXNlbWVudChkYnVzLnNlcnZpY2UuT2JqZWN0KToKICAgIFBBVEhfQkFTRSA9ICcvb3JnL2Js
dWV6L2V4YW1wbGUvYWR2ZXJ0aXNlbWVudCcKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBp
bmRleCwgYWR2ZXJ0aXNpbmdfdHlwZSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VsZi5QQVRIX0JB
U0UgKyBzdHIoaW5kZXgpCiAgICAgICAgc2VsZi5idXMgPSBidXMKICAgICAgICBzZWxmLmFkX3R5
cGUgPSBhZHZlcnRpc2luZ190eXBlCiAgICAgICAgc2VsZi5zZXJ2aWNlX3V1aWRzID0gTm9uZQog
ICAgICAgIHNlbGYubWFudWZhY3R1cmVyX2RhdGEgPSBOb25lCiAgICAgICAgc2VsZi5zb2xpY2l0
X3V1aWRzID0gTm9uZQogICAgICAgIHNlbGYuc2VydmljZV9kYXRhID0gTm9uZQogICAgICAgIHNl
bGYubG9jYWxfbmFtZSA9IE5vbmUKICAgICAgICBzZWxmLmluY2x1ZGVfdHhfcG93ZXIgPSBOb25l
CiAgICAgICAgc2VsZi5kYXRhID0gTm9uZQogICAgICAgIGRidXMuc2VydmljZS5PYmplY3QuX19p
bml0X18oc2VsZiwgYnVzLCBzZWxmLnBhdGgpCgogICAgZGVmIGdldF9wcm9wZXJ0aWVzKHNlbGYp
OgogICAgICAgIHByb3BlcnRpZXMgPSBkaWN0KCkKICAgICAgICBwcm9wZXJ0aWVzWydUeXBlJ10g
PSBzZWxmLmFkX3R5cGUKICAgICAgICBpZiBzZWxmLnNlcnZpY2VfdXVpZHMgaXMgbm90IE5vbmU6
CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ1NlcnZpY2VVVUlEcyddID0gZGJ1cy5BcnJheShzZWxm
LnNlcnZpY2VfdXVpZHMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaWduYXR1cmU9J3MnKQogICAgICAgIGlmIHNlbGYuc29saWNpdF91dWlkcyBp
cyBub3QgTm9uZToKICAgICAgICAgICAgcHJvcGVydGllc1snU29saWNpdFVVSURzJ10gPSBkYnVz
LkFycmF5KHNlbGYuc29saWNpdF91dWlkcywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpZ25hdHVyZT0ncycpCiAgICAgICAgaWYgc2VsZi5tYW51
ZmFjdHVyZXJfZGF0YSBpcyBub3QgTm9uZToKICAgICAgICAgICAgcHJvcGVydGllc1snTWFudWZh
Y3R1cmVyRGF0YSddID0gZGJ1cy5EaWN0aW9uYXJ5KAogICAgICAgICAgICAgICAgc2VsZi5tYW51
ZmFjdHVyZXJfZGF0YSwgc2lnbmF0dXJlPSdxdicpCiAgICAgICAgaWYgc2VsZi5zZXJ2aWNlX2Rh
dGEgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ1NlcnZpY2VEYXRhJ10gPSBk
YnVzLkRpY3Rpb25hcnkoc2VsZi5zZXJ2aWNlX2RhdGEsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2lnbmF0dXJlPSdzdicpCiAgICAgICAg
aWYgc2VsZi5sb2NhbF9uYW1lIGlzIG5vdCBOb25lOgogICAgICAgICAgICBwcm9wZXJ0aWVzWydM
b2NhbE5hbWUnXSA9IGRidXMuU3RyaW5nKHNlbGYubG9jYWxfbmFtZSkKICAgICAgICBpZiBzZWxm
LmluY2x1ZGVfdHhfcG93ZXIgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ0lu
Y2x1ZGVUeFBvd2VyJ10gPSBkYnVzLkJvb2xlYW4oc2VsZi5pbmNsdWRlX3R4X3Bvd2VyKQoKICAg
ICAgICBpZiBzZWxmLmRhdGEgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ0Rh
dGEnXSA9IGRidXMuRGljdGlvbmFyeSgKICAgICAgICAgICAgICAgIHNlbGYuZGF0YSwgc2lnbmF0
dXJlPSd5dicpCiAgICAgICAgcmV0dXJuIHtMRV9BRFZFUlRJU0VNRU5UX0lGQUNFOiBwcm9wZXJ0
aWVzfQoKICAgIGRlZiBnZXRfcGF0aChzZWxmKToKICAgICAgICByZXR1cm4gZGJ1cy5PYmplY3RQ
YXRoKHNlbGYucGF0aCkKCiAgICBkZWYgYWRkX3NlcnZpY2VfdXVpZChzZWxmLCB1dWlkKToKICAg
ICAgICBpZiBub3Qgc2VsZi5zZXJ2aWNlX3V1aWRzOgogICAgICAgICAgICBzZWxmLnNlcnZpY2Vf
dXVpZHMgPSBbXQogICAgICAgIHNlbGYuc2VydmljZV91dWlkcy5hcHBlbmQodXVpZCkKCiAgICBk
ZWYgYWRkX3NvbGljaXRfdXVpZChzZWxmLCB1dWlkKToKICAgICAgICBpZiBub3Qgc2VsZi5zb2xp
Y2l0X3V1aWRzOgogICAgICAgICAgICBzZWxmLnNvbGljaXRfdXVpZHMgPSBbXQogICAgICAgIHNl
bGYuc29saWNpdF91dWlkcy5hcHBlbmQodXVpZCkKCiAgICBkZWYgYWRkX21hbnVmYWN0dXJlcl9k
YXRhKHNlbGYsIG1hbnVmX2NvZGUsIGRhdGEpOgogICAgICAgIGlmIG5vdCBzZWxmLm1hbnVmYWN0
dXJlcl9kYXRhOgogICAgICAgICAgICBzZWxmLm1hbnVmYWN0dXJlcl9kYXRhID0gZGJ1cy5EaWN0
aW9uYXJ5KHt9LCBzaWduYXR1cmU9J3F2JykKICAgICAgICBzZWxmLm1hbnVmYWN0dXJlcl9kYXRh
W21hbnVmX2NvZGVdID0gZGJ1cy5BcnJheShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIGRlZiBh
ZGRfc2VydmljZV9kYXRhKHNlbGYsIHV1aWQsIGRhdGEpOgogICAgICAgIGlmIG5vdCBzZWxmLnNl
cnZpY2VfZGF0YToKICAgICAgICAgICAgc2VsZi5zZXJ2aWNlX2RhdGEgPSBkYnVzLkRpY3Rpb25h
cnkoe30sIHNpZ25hdHVyZT0nc3YnKQogICAgICAgIHNlbGYuc2VydmljZV9kYXRhW3V1aWRdID0g
ZGJ1cy5BcnJheShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIGRlZiBhZGRfbG9jYWxfbmFtZShz
ZWxmLCBuYW1lKToKICAgICAgICBpZiBub3Qgc2VsZi5sb2NhbF9uYW1lOgogICAgICAgICAgICBz
ZWxmLmxvY2FsX25hbWUgPSAiIgogICAgICAgIHNlbGYubG9jYWxfbmFtZSA9IGRidXMuU3RyaW5n
KG5hbWUpCgogICAgZGVmIGFkZF9kYXRhKHNlbGYsIGFkX3R5cGUsIGRhdGEpOgogICAgICAgIGlm
IG5vdCBzZWxmLmRhdGE6CiAgICAgICAgICAgIHNlbGYuZGF0YSA9IGRidXMuRGljdGlvbmFyeSh7
fSwgc2lnbmF0dXJlPSd5dicpCiAgICAgICAgc2VsZi5kYXRhW2FkX3R5cGVdID0gZGJ1cy5BcnJh
eShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKERCVVNfUFJP
UF9JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgIGluX3NpZ25hdHVyZT0ncycsCiAgICAg
ICAgICAgICAgICAgICAgICAgICBvdXRfc2lnbmF0dXJlPSdhe3N2fScpCiAgICBkZWYgR2V0QWxs
KHNlbGYsIGludGVyZmFjZSk6CiAgICAgICAgcHJpbnQoICdHZXRBbGwnKQogICAgICAgIGlmIGlu
dGVyZmFjZSAhPSBMRV9BRFZFUlRJU0VNRU5UX0lGQUNFOgogICAgICAgICAgICByYWlzZSBJbnZh
bGlkQXJnc0V4Y2VwdGlvbigpCiAgICAgICAgcHJpbnQoICdyZXR1cm5pbmcgcHJvcHMnKQogICAg
ICAgIHJldHVybiBzZWxmLmdldF9wcm9wZXJ0aWVzKClbTEVfQURWRVJUSVNFTUVOVF9JRkFDRV0K
CiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChMRV9BRFZFUlRJU0VNRU5UX0lGQUNFLAogICAgICAg
ICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPScnLAogICAgICAgICAgICAgICAgICAgICAg
ICAgb3V0X3NpZ25hdHVyZT0nJykKICAgIGRlZiBSZWxlYXNlKHNlbGYpOgogICAgICAgIHByaW50
KCAnJXM6IFJlbGVhc2VkIScgJSBzZWxmLnBhdGgpCgpjbGFzcyBUZXN0QWR2ZXJ0aXNlbWVudChB
ZHZlcnRpc2VtZW50KToKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCk6CiAgICAg
ICAgQWR2ZXJ0aXNlbWVudC5fX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCAncGVyaXBoZXJhbCcp
CiAgICAgICAgc2VsZi5hZGRfc2VydmljZV91dWlkKCcxODBEJykKICAgICAgICBzZWxmLmFkZF9z
ZXJ2aWNlX3V1aWQoJzE4MEYnKQogICAgICAgIHNlbGYuYWRkX21hbnVmYWN0dXJlcl9kYXRhKDB4
ZmZmZiwgWzB4MDAsIDB4MDEsIDB4MDIsIDB4MDMsIDB4MDRdKQogICAgICAgIHNlbGYuYWRkX3Nl
cnZpY2VfZGF0YSgnOTk5OScsIFsweDAwLCAweDAxLCAweDAyLCAweDAzLCAweDA0XSkKICAgICAg
ICBzZWxmLmFkZF9sb2NhbF9uYW1lKCdUZXN0QWR2ZXJ0aXNlbWVudCcpCiAgICAgICAgc2VsZi5p
bmNsdWRlX3R4X3Bvd2VyID0gVHJ1ZQogICAgICAgIHNlbGYuYWRkX2RhdGEoMHgyNiwgWzB4MDEs
IDB4MDEsIDB4MDBdKQoKCmRlZiByZWdpc3Rlcl9hZF9jYigpOgogICAgcHJpbnQoICdBZHZlcnRp
c2VtZW50IHJlZ2lzdGVyZWQnKQoKCmRlZiByZWdpc3Rlcl9hZF9lcnJvcl9jYihlcnJvcik6CiAg
ICBwcmludCggJ0ZhaWxlZCB0byByZWdpc3RlciBhZHZlcnRpc2VtZW50OiAnICsgc3RyKGVycm9y
KSkKICAgIG1haW5sb29wLnF1aXQoKQoKCgoKCmNsYXNzIEludmFsaWRBcmdzRXhjZXB0aW9uKGRi
dXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vycm9yX25hbWUgPSAnb3Jn
LmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuSW52YWxpZEFyZ3MnCgpjbGFzcyBOb3RTdXBwb3J0ZWRF
eGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAgX2RidXNfZXJyb3Jf
bmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuTm90U3VwcG9ydGVkJwoKY2xhc3MgTm90UGVybWl0dGVk
RXhjZXB0aW9uKGRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vycm9y
X25hbWUgPSAnb3JnLmJsdWV6LkVycm9yLk5vdFBlcm1pdHRlZCcKCmNsYXNzIEludmFsaWRWYWx1
ZUxlbmd0aEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1
c19lcnJvcl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5JbnZhbGlkVmFsdWVMZW5ndGgnCgpjbGFz
cyBGYWlsZWRFeGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAgX2Ri
dXNfZXJyb3JfbmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuRmFpbGVkJwoKCmNsYXNzIEFwcGxpY2F0
aW9uKGRidXMuc2VydmljZS5PYmplY3QpOgogICAgIiIiCiAgICBvcmcuYmx1ZXouR2F0dEFwcGxp
Y2F0aW9uMSBpbnRlcmZhY2UgaW1wbGVtZW50YXRpb24KICAgICIiIgogICAgZGVmIF9faW5pdF9f
KHNlbGYsIGJ1cyk6CiAgICAgICAgc2VsZi5wYXRoID0gJy8nCiAgICAgICAgc2VsZi5zZXJ2aWNl
cyA9IFtdCiAgICAgICAgZGJ1cy5zZXJ2aWNlLk9iamVjdC5fX2luaXRfXyhzZWxmLCBidXMsIHNl
bGYucGF0aCkKICAgICAgICBzZWxmLmFkZF9zZXJ2aWNlKEhlYXJ0UmF0ZVNlcnZpY2UoYnVzLCAw
KSkKICAgICAgICBzZWxmLmFkZF9zZXJ2aWNlKEJhdHRlcnlTZXJ2aWNlKGJ1cywgMSkpCiAgICAg
ICAgc2VsZi5hZGRfc2VydmljZShUZXN0U2VydmljZShidXMsIDIpKQoKICAgIGRlZiBnZXRfcGF0
aChzZWxmKToKICAgICAgICByZXR1cm4gZGJ1cy5PYmplY3RQYXRoKHNlbGYucGF0aCkKCiAgICBk
ZWYgYWRkX3NlcnZpY2Uoc2VsZiwgc2VydmljZSk6CiAgICAgICAgc2VsZi5zZXJ2aWNlcy5hcHBl
bmQoc2VydmljZSkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChEQlVTX09NX0lGQUNFLCBvdXRf
c2lnbmF0dXJlPSdhe29he3Nhe3N2fX19JykKICAgIGRlZiBHZXRNYW5hZ2VkT2JqZWN0cyhzZWxm
KToKICAgICAgICByZXNwb25zZSA9IHt9CiAgICAgICAgcHJpbnQoJ0dldE1hbmFnZWRPYmplY3Rz
JykKCiAgICAgICAgZm9yIHNlcnZpY2UgaW4gc2VsZi5zZXJ2aWNlczoKICAgICAgICAgICAgcmVz
cG9uc2Vbc2VydmljZS5nZXRfcGF0aCgpXSA9IHNlcnZpY2UuZ2V0X3Byb3BlcnRpZXMoKQogICAg
ICAgICAgICBjaHJjcyA9IHNlcnZpY2UuZ2V0X2NoYXJhY3RlcmlzdGljcygpCiAgICAgICAgICAg
IGZvciBjaHJjIGluIGNocmNzOgogICAgICAgICAgICAgICAgcmVzcG9uc2VbY2hyYy5nZXRfcGF0
aCgpXSA9IGNocmMuZ2V0X3Byb3BlcnRpZXMoKQogICAgICAgICAgICAgICAgZGVzY3MgPSBjaHJj
LmdldF9kZXNjcmlwdG9ycygpCiAgICAgICAgICAgICAgICBmb3IgZGVzYyBpbiBkZXNjczoKICAg
ICAgICAgICAgICAgICAgICByZXNwb25zZVtkZXNjLmdldF9wYXRoKCldID0gZGVzYy5nZXRfcHJv
cGVydGllcygpCgogICAgICAgIHJldHVybiByZXNwb25zZQoKCmNsYXNzIFNlcnZpY2UoZGJ1cy5z
ZXJ2aWNlLk9iamVjdCk6CiAgICAiIiIKICAgIG9yZy5ibHVlei5HYXR0U2VydmljZTEgaW50ZXJm
YWNlIGltcGxlbWVudGF0aW9uCiAgICAiIiIKICAgIFBBVEhfQkFTRSA9ICcvb3JnL2JsdWV6L2V4
YW1wbGUvc2VydmljZScKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgdXVpZCwg
cHJpbWFyeSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VsZi5QQVRIX0JBU0UgKyBzdHIoaW5kZXgp
CiAgICAgICAgc2VsZi5idXMgPSBidXMKICAgICAgICBzZWxmLnV1aWQgPSB1dWlkCiAgICAgICAg
c2VsZi5wcmltYXJ5ID0gcHJpbWFyeQogICAgICAgIHNlbGYuY2hhcmFjdGVyaXN0aWNzID0gW10K
ICAgICAgICBkYnVzLnNlcnZpY2UuT2JqZWN0Ll9faW5pdF9fKHNlbGYsIGJ1cywgc2VsZi5wYXRo
KQoKICAgIGRlZiBnZXRfcHJvcGVydGllcyhzZWxmKToKICAgICAgICByZXR1cm4gewogICAgICAg
ICAgICAgICAgR0FUVF9TRVJWSUNFX0lGQUNFOiB7CiAgICAgICAgICAgICAgICAgICAgICAgICdV
VUlEJzogc2VsZi51dWlkLAogICAgICAgICAgICAgICAgICAgICAgICAnUHJpbWFyeSc6IHNlbGYu
cHJpbWFyeSwKICAgICAgICAgICAgICAgICAgICAgICAgJ0NoYXJhY3RlcmlzdGljcyc6IGRidXMu
QXJyYXkoCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VsZi5nZXRfY2hhcmFjdGVy
aXN0aWNfcGF0aHMoKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaWduYXR1cmU9
J28nKQogICAgICAgICAgICAgICAgfQogICAgICAgIH0KCiAgICBkZWYgZ2V0X3BhdGgoc2VsZik6
CiAgICAgICAgcmV0dXJuIGRidXMuT2JqZWN0UGF0aChzZWxmLnBhdGgpCgogICAgZGVmIGFkZF9j
aGFyYWN0ZXJpc3RpYyhzZWxmLCBjaGFyYWN0ZXJpc3RpYyk6CiAgICAgICAgc2VsZi5jaGFyYWN0
ZXJpc3RpY3MuYXBwZW5kKGNoYXJhY3RlcmlzdGljKQoKICAgIGRlZiBnZXRfY2hhcmFjdGVyaXN0
aWNfcGF0aHMoc2VsZik6CiAgICAgICAgcmVzdWx0ID0gW10KICAgICAgICBmb3IgY2hyYyBpbiBz
ZWxmLmNoYXJhY3RlcmlzdGljczoKICAgICAgICAgICAgcmVzdWx0LmFwcGVuZChjaHJjLmdldF9w
YXRoKCkpCiAgICAgICAgcmV0dXJuIHJlc3VsdAoKICAgIGRlZiBnZXRfY2hhcmFjdGVyaXN0aWNz
KHNlbGYpOgogICAgICAgIHJldHVybiBzZWxmLmNoYXJhY3RlcmlzdGljcwoKICAgIEBkYnVzLnNl
cnZpY2UubWV0aG9kKERCVVNfUFJPUF9JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgIGlu
X3NpZ25hdHVyZT0ncycsCiAgICAgICAgICAgICAgICAgICAgICAgICBvdXRfc2lnbmF0dXJlPSdh
e3N2fScpCiAgICBkZWYgR2V0QWxsKHNlbGYsIGludGVyZmFjZSk6CiAgICAgICAgaWYgaW50ZXJm
YWNlICE9IEdBVFRfU0VSVklDRV9JRkFDRToKICAgICAgICAgICAgcmFpc2UgSW52YWxpZEFyZ3NF
eGNlcHRpb24oKQoKICAgICAgICByZXR1cm4gc2VsZi5nZXRfcHJvcGVydGllcygpW0dBVFRfU0VS
VklDRV9JRkFDRV0KCgpjbGFzcyBDaGFyYWN0ZXJpc3RpYyhkYnVzLnNlcnZpY2UuT2JqZWN0KToK
ICAgICIiIgogICAgb3JnLmJsdWV6LkdhdHRDaGFyYWN0ZXJpc3RpYzEgaW50ZXJmYWNlIGltcGxl
bWVudGF0aW9uCiAgICAiIiIKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCB1dWlk
LCBmbGFncywgc2VydmljZSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VydmljZS5wYXRoICsgJy9j
aGFyJyArIHN0cihpbmRleCkKICAgICAgICBzZWxmLmJ1cyA9IGJ1cwogICAgICAgIHNlbGYudXVp
ZCA9IHV1aWQKICAgICAgICBzZWxmLnNlcnZpY2UgPSBzZXJ2aWNlCiAgICAgICAgc2VsZi5mbGFn
cyA9IGZsYWdzCiAgICAgICAgc2VsZi5kZXNjcmlwdG9ycyA9IFtdCiAgICAgICAgZGJ1cy5zZXJ2
aWNlLk9iamVjdC5fX2luaXRfXyhzZWxmLCBidXMsIHNlbGYucGF0aCkKCiAgICBkZWYgZ2V0X3By
b3BlcnRpZXMoc2VsZik6CiAgICAgICAgcmV0dXJuIHsKICAgICAgICAgICAgICAgIEdBVFRfQ0hS
Q19JRkFDRTogewogICAgICAgICAgICAgICAgICAgICAgICAnU2VydmljZSc6IHNlbGYuc2Vydmlj
ZS5nZXRfcGF0aCgpLAogICAgICAgICAgICAgICAgICAgICAgICAnVVVJRCc6IHNlbGYudXVpZCwK
ICAgICAgICAgICAgICAgICAgICAgICAgJ0ZsYWdzJzogc2VsZi5mbGFncywKICAgICAgICAgICAg
ICAgICAgICAgICAgJ0Rlc2NyaXB0b3JzJzogZGJ1cy5BcnJheSgKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzZWxmLmdldF9kZXNjcmlwdG9yX3BhdGhzKCksCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2lnbmF0dXJlPSdvJykKICAgICAgICAgICAgICAgIH0KICAgICAg
ICB9CgogICAgZGVmIGdldF9wYXRoKHNlbGYpOgogICAgICAgIHJldHVybiBkYnVzLk9iamVjdFBh
dGgoc2VsZi5wYXRoKQoKICAgIGRlZiBhZGRfZGVzY3JpcHRvcihzZWxmLCBkZXNjcmlwdG9yKToK
ICAgICAgICBzZWxmLmRlc2NyaXB0b3JzLmFwcGVuZChkZXNjcmlwdG9yKQoKICAgIGRlZiBnZXRf
ZGVzY3JpcHRvcl9wYXRocyhzZWxmKToKICAgICAgICByZXN1bHQgPSBbXQogICAgICAgIGZvciBk
ZXNjIGluIHNlbGYuZGVzY3JpcHRvcnM6CiAgICAgICAgICAgIHJlc3VsdC5hcHBlbmQoZGVzYy5n
ZXRfcGF0aCgpKQogICAgICAgIHJldHVybiByZXN1bHQKCiAgICBkZWYgZ2V0X2Rlc2NyaXB0b3Jz
KHNlbGYpOgogICAgICAgIHJldHVybiBzZWxmLmRlc2NyaXB0b3JzCgogICAgQGRidXMuc2Vydmlj
ZS5tZXRob2QoREJVU19QUk9QX0lGQUNFLAogICAgICAgICAgICAgICAgICAgICAgICAgaW5fc2ln
bmF0dXJlPSdzJywKICAgICAgICAgICAgICAgICAgICAgICAgIG91dF9zaWduYXR1cmU9J2F7c3Z9
JykKICAgIGRlZiBHZXRBbGwoc2VsZiwgaW50ZXJmYWNlKToKICAgICAgICBpZiBpbnRlcmZhY2Ug
IT0gR0FUVF9DSFJDX0lGQUNFOgogICAgICAgICAgICByYWlzZSBJbnZhbGlkQXJnc0V4Y2VwdGlv
bigpCgogICAgICAgIHJldHVybiBzZWxmLmdldF9wcm9wZXJ0aWVzKClbR0FUVF9DSFJDX0lGQUNF
XQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRfQ0hSQ19JRkFDRSwKICAgICAgICAgICAg
ICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdhe3N2fScsCiAgICAgICAgICAgICAgICAgICAgICAg
IG91dF9zaWduYXR1cmU9J2F5JykKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAg
ICAgICAgcHJpbnQoJ0RlZmF1bHQgUmVhZFZhbHVlIGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykK
ICAgICAgICByYWlzZSBOb3RTdXBwb3J0ZWRFeGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2Uu
bWV0aG9kKEdBVFRfQ0hSQ19JRkFDRSwgaW5fc2lnbmF0dXJlPSdheWF7c3Z9JykKICAgIGRlZiBX
cml0ZVZhbHVlKHNlbGYsIHZhbHVlLCBvcHRpb25zKToKICAgICAgICBwcmludCgnRGVmYXVsdCBX
cml0ZVZhbHVlIGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykKICAgICAgICByYWlzZSBOb3RTdXBw
b3J0ZWRFeGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRfQ0hSQ19JRkFD
RSkKICAgIGRlZiBTdGFydE5vdGlmeShzZWxmKToKICAgICAgICBwcmludCgnRGVmYXVsdCBTdGFy
dE5vdGlmeSBjYWxsZWQsIHJldHVybmluZyBlcnJvcicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9y
dGVkRXhjZXB0aW9uKCkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChHQVRUX0NIUkNfSUZBQ0Up
CiAgICBkZWYgU3RvcE5vdGlmeShzZWxmKToKICAgICAgICBwcmludCgnRGVmYXVsdCBTdG9wTm90
aWZ5IGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykKICAgICAgICByYWlzZSBOb3RTdXBwb3J0ZWRF
eGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2Uuc2lnbmFsKERCVVNfUFJPUF9JRkFDRSwKICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpZ25hdHVyZT0nc2F7c3Z9YXMnKQogICAgZGVmIFByb3Bl
cnRpZXNDaGFuZ2VkKHNlbGYsIGludGVyZmFjZSwgY2hhbmdlZCwgaW52YWxpZGF0ZWQpOgogICAg
ICAgIHBhc3MKCgpjbGFzcyBEZXNjcmlwdG9yKGRidXMuc2VydmljZS5PYmplY3QpOgogICAgIiIi
CiAgICBvcmcuYmx1ZXouR2F0dERlc2NyaXB0b3IxIGludGVyZmFjZSBpbXBsZW1lbnRhdGlvbgog
ICAgIiIiCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgdXVpZCwgZmxhZ3MsIGNo
YXJhY3RlcmlzdGljKToKICAgICAgICBzZWxmLnBhdGggPSBjaGFyYWN0ZXJpc3RpYy5wYXRoICsg
Jy9kZXNjJyArIHN0cihpbmRleCkKICAgICAgICBzZWxmLmJ1cyA9IGJ1cwogICAgICAgIHNlbGYu
dXVpZCA9IHV1aWQKICAgICAgICBzZWxmLmZsYWdzID0gZmxhZ3MKICAgICAgICBzZWxmLmNocmMg
PSBjaGFyYWN0ZXJpc3RpYwogICAgICAgIGRidXMuc2VydmljZS5PYmplY3QuX19pbml0X18oc2Vs
ZiwgYnVzLCBzZWxmLnBhdGgpCgogICAgZGVmIGdldF9wcm9wZXJ0aWVzKHNlbGYpOgogICAgICAg
IHJldHVybiB7CiAgICAgICAgICAgICAgICBHQVRUX0RFU0NfSUZBQ0U6IHsKICAgICAgICAgICAg
ICAgICAgICAgICAgJ0NoYXJhY3RlcmlzdGljJzogc2VsZi5jaHJjLmdldF9wYXRoKCksCiAgICAg
ICAgICAgICAgICAgICAgICAgICdVVUlEJzogc2VsZi51dWlkLAogICAgICAgICAgICAgICAgICAg
ICAgICAnRmxhZ3MnOiBzZWxmLmZsYWdzLAogICAgICAgICAgICAgICAgfQogICAgICAgIH0KCiAg
ICBkZWYgZ2V0X3BhdGgoc2VsZik6CiAgICAgICAgcmV0dXJuIGRidXMuT2JqZWN0UGF0aChzZWxm
LnBhdGgpCgogICAgQGRidXMuc2VydmljZS5tZXRob2QoREJVU19QUk9QX0lGQUNFLAogICAgICAg
ICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdzJywKICAgICAgICAgICAgICAgICAgICAg
ICAgIG91dF9zaWduYXR1cmU9J2F7c3Z9JykKICAgIGRlZiBHZXRBbGwoc2VsZiwgaW50ZXJmYWNl
KToKICAgICAgICBpZiBpbnRlcmZhY2UgIT0gR0FUVF9ERVNDX0lGQUNFOgogICAgICAgICAgICBy
YWlzZSBJbnZhbGlkQXJnc0V4Y2VwdGlvbigpCgogICAgICAgIHJldHVybiBzZWxmLmdldF9wcm9w
ZXJ0aWVzKClbR0FUVF9ERVNDX0lGQUNFXQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRf
REVTQ19JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdhe3N2fScs
CiAgICAgICAgICAgICAgICAgICAgICAgIG91dF9zaWduYXR1cmU9J2F5JykKICAgIGRlZiBSZWFk
VmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQgKCdEZWZhdWx0IFJlYWRWYWx1ZSBj
YWxsZWQsIHJldHVybmluZyBlcnJvcicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9ydGVkRXhjZXB0
aW9uKCkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChHQVRUX0RFU0NfSUZBQ0UsIGluX3NpZ25h
dHVyZT0nYXlhe3N2fScpCiAgICBkZWYgV3JpdGVWYWx1ZShzZWxmLCB2YWx1ZSwgb3B0aW9ucyk6
CiAgICAgICAgcHJpbnQoJ0RlZmF1bHQgV3JpdGVWYWx1ZSBjYWxsZWQsIHJldHVybmluZyBlcnJv
cicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9ydGVkRXhjZXB0aW9uKCkKCgpjbGFzcyBIZWFydFJh
dGVTZXJ2aWNlKFNlcnZpY2UpOgogICAgIiIiCiAgICBGYWtlIEhlYXJ0IFJhdGUgU2VydmljZSB0
aGF0IHNpbXVsYXRlcyBhIGZha2UgaGVhcnQgYmVhdCBhbmQgY29udHJvbCBwb2ludAogICAgYmVo
YXZpb3IuCgogICAgIiIiCiAgICBIUl9VVUlEID0gJzAwMDAxODBkLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYicKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCk6CiAgICAgICAg
U2VydmljZS5fX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBzZWxmLkhSX1VVSUQsIFRydWUpCiAg
ICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoSGVhcnRSYXRlTWVhc3VyZW1lbnRDaHJjKGJ1
cywgMCwgc2VsZikpCiAgICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoQm9keVNlbnNvckxv
Y2F0aW9uQ2hyYyhidXMsIDEsIHNlbGYpKQogICAgICAgIHNlbGYuYWRkX2NoYXJhY3RlcmlzdGlj
KEhlYXJ0UmF0ZUNvbnRyb2xQb2ludENocmMoYnVzLCAyLCBzZWxmKSkKICAgICAgICBzZWxmLmVu
ZXJneV9leHBlbmRlZCA9IDAKCgpjbGFzcyBIZWFydFJhdGVNZWFzdXJlbWVudENocmMoQ2hhcmFj
dGVyaXN0aWMpOgogICAgSFJfTVNSTVRfVVVJRCA9ICcwMDAwMmEzNy0wMDAwLTEwMDAtODAwMC0w
MDgwNWY5YjM0ZmInCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgsIHNlcnZpY2Up
OgogICAgICAgIENoYXJhY3RlcmlzdGljLl9faW5pdF9fKAogICAgICAgICAgICAgICAgc2VsZiwg
YnVzLCBpbmRleCwKICAgICAgICAgICAgICAgIHNlbGYuSFJfTVNSTVRfVVVJRCwKICAgICAgICAg
ICAgICAgIFsncmVhZCddLAogICAgICAgICAgICAgICAgc2VydmljZSkKICAgICAgICBzZWxmLm5v
dGlmeWluZyA9IEZhbHNlCiAgICAgICAgc2VsZi5ocl9lZV9jb3VudCA9IDAKICAgICAgICAKCiAg
ICBkZWYgUmVhZFZhbHVlKHNlbGYsIG9wdGlvbnMpOgogICAgICAgIHByaW50KCdIZWFydFJhdGVN
ZWFzdXJlbWVudENocmMgUmVhZCcpCiAgICAgICAgcmV0dXJuIFtkYnVzLkJ5dGUoNiksIGRidXMu
Qnl0ZSg5OSldCgoKICAgIGRlZiBocl9tc3JtdF9jYihzZWxmKToKICAgICAgICB2YWx1ZSA9IFtd
CiAgICAgICAgdmFsdWUuYXBwZW5kKGRidXMuQnl0ZSgweDA2KSkKCiAgICAgICAgdmFsdWUuYXBw
ZW5kKGRidXMuQnl0ZShyYW5kaW50KDkwLCAxMzApKSkKCiAgICAgICAgaWYgc2VsZi5ocl9lZV9j
b3VudCAlIDEwID09IDA6CiAgICAgICAgICAgIHZhbHVlWzBdID0gZGJ1cy5CeXRlKHZhbHVlWzBd
IHwgMHgwOCkKICAgICAgICAgICAgdmFsdWUuYXBwZW5kKGRidXMuQnl0ZShzZWxmLnNlcnZpY2Uu
ZW5lcmd5X2V4cGVuZGVkICYgMHhmZikpCiAgICAgICAgICAgIHZhbHVlLmFwcGVuZChkYnVzLkJ5
dGUoKHNlbGYuc2VydmljZS5lbmVyZ3lfZXhwZW5kZWQgPj4gOCkgJiAweGZmKSkKCiAgICAgICAg
c2VsZi5zZXJ2aWNlLmVuZXJneV9leHBlbmRlZCA9IFwKICAgICAgICAgICAgICAgIG1pbigweGZm
ZmYsIHNlbGYuc2VydmljZS5lbmVyZ3lfZXhwZW5kZWQgKyAxKQogICAgICAgIHNlbGYuaHJfZWVf
Y291bnQgKz0gMQoKICAgICAgICBwcmludCgnVXBkYXRpbmcgdmFsdWU6ICcgKyByZXByKHZhbHVl
KSkKCiAgICAgICAgc2VsZi5Qcm9wZXJ0aWVzQ2hhbmdlZChHQVRUX0NIUkNfSUZBQ0UsIHsgJ1Zh
bHVlJzogdmFsdWUgfSwgW10pCgogICAgICAgIHJldHVybiBzZWxmLm5vdGlmeWluZwoKICAgIGRl
ZiBfdXBkYXRlX2hyX21zcm10X3NpbXVsYXRpb24oc2VsZik6CiAgICAgICAgcHJpbnQoJ1VwZGF0
ZSBIUiBNZWFzdXJlbWVudCBTaW11bGF0aW9uJykKCiAgICAgICAgaWYgbm90IHNlbGYubm90aWZ5
aW5nOgogICAgICAgICAgICByZXR1cm4KCiAgICAgICAgR09iamVjdC50aW1lb3V0X2FkZCgxMDAw
LCBzZWxmLmhyX21zcm10X2NiKQoKICAgIGRlZiBTdGFydE5vdGlmeShzZWxmKToKICAgICAgICBp
ZiBzZWxmLm5vdGlmeWluZzoKICAgICAgICAgICAgcHJpbnQoJ0FscmVhZHkgbm90aWZ5aW5nLCBu
b3RoaW5nIHRvIGRvJykKICAgICAgICAgICAgcmV0dXJuCgogICAgICAgIHNlbGYubm90aWZ5aW5n
ID0gVHJ1ZQogICAgICAgIHNlbGYuX3VwZGF0ZV9ocl9tc3JtdF9zaW11bGF0aW9uKCkKCiAgICBk
ZWYgU3RvcE5vdGlmeShzZWxmKToKICAgICAgICBpZiBub3Qgc2VsZi5ub3RpZnlpbmc6CiAgICAg
ICAgICAgIHByaW50KCdOb3Qgbm90aWZ5aW5nLCBub3RoaW5nIHRvIGRvJykKICAgICAgICAgICAg
cmV0dXJuCgogICAgICAgIHNlbGYubm90aWZ5aW5nID0gRmFsc2UKICAgICAgICBzZWxmLl91cGRh
dGVfaHJfbXNybXRfc2ltdWxhdGlvbigpCgoKY2xhc3MgQm9keVNlbnNvckxvY2F0aW9uQ2hyYyhD
aGFyYWN0ZXJpc3RpYyk6CiAgICBCT0RZX1NOU1JfTE9DX1VVSUQgPSAnMDAwMDJhMzgtMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiJwoKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4
LCBzZXJ2aWNlKToKICAgICAgICBDaGFyYWN0ZXJpc3RpYy5fX2luaXRfXygKICAgICAgICAgICAg
ICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAgICAgICAgICAgICAgICBzZWxmLkJPRFlfU05TUl9MT0Nf
VVVJRCwKICAgICAgICAgICAgICAgIFsncmVhZCddLAogICAgICAgICAgICAgICAgc2VydmljZSkK
ICAgICAgICBzZWxmLm5vdGlmeWluZyA9IEZhbHNlCiAgICAgICAgc2VsZi52YWx1ZSA9IFsweDAx
XQoKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAgICAgICAgIyBSZXR1cm4gJ0No
ZXN0JyBhcyB0aGUgc2Vuc29yIGxvY2F0aW9uLgogICAgICAgIHJldHVybiBbIDB4MDIgXQoKCiAg
ICBkZWYgX2NiKHNlbGYpOgogICAgICAgIHZhbHVlID0gW10KCiAgICAgICAgdmFsdWUuYXBwZW5k
KGRidXMuQnl0ZShyYW5kaW50KDEsIDMpKSkKCiAgICAgICAgcHJpbnQoJ1VwZGF0aW5nIHZhbHVl
OiAnICsgcmVwcih2YWx1ZSkpCgogICAgICAgIHNlbGYuUHJvcGVydGllc0NoYW5nZWQoR0FUVF9D
SFJDX0lGQUNFLCB7ICdWYWx1ZSc6IHZhbHVlIH0sIFtdKQoKICAgICAgICByZXR1cm4gc2VsZi5u
b3RpZnlpbmcKCiAgICBkZWYgX3VwZGF0ZV9zaW11bGF0aW9uKHNlbGYpOgogICAgICAgIHByaW50
KCdVcGRhdGUgU2ltdWxhdGlvbicpCgogICAgICAgIGlmIG5vdCBzZWxmLm5vdGlmeWluZzoKICAg
ICAgICAgICAgcmV0dXJuCgogICAgICAgIEdPYmplY3QudGltZW91dF9hZGQoMTAwMCwgc2VsZi5f
Y2IpCgogICAgZGVmIFN0YXJ0Tm90aWZ5KHNlbGYpOgogICAgICAgIGlmIHNlbGYubm90aWZ5aW5n
OgogICAgICAgICAgICBwcmludCgnQWxyZWFkeSBub3RpZnlpbmcsIG5vdGhpbmcgdG8gZG8nKQog
ICAgICAgICAgICByZXR1cm4KCiAgICAgICAgc2VsZi5ub3RpZnlpbmcgPSBUcnVlCiAgICAgICAg
c2VsZi5fdXBkYXRlX3NpbXVsYXRpb24oKQoKICAgIGRlZiBTdG9wTm90aWZ5KHNlbGYpOgogICAg
ICAgIGlmIG5vdCBzZWxmLm5vdGlmeWluZzoKICAgICAgICAgICAgcHJpbnQoJ05vdCBub3RpZnlp
bmcsIG5vdGhpbmcgdG8gZG8nKQogICAgICAgICAgICByZXR1cm4KCiAgICAgICAgc2VsZi5ub3Rp
ZnlpbmcgPSBGYWxzZQogICAgICAgIHNlbGYuX3VwZGF0ZV9zaW11bGF0aW9uKCkKCgpjbGFzcyBI
ZWFydFJhdGVDb250cm9sUG9pbnRDaHJjKENoYXJhY3RlcmlzdGljKToKICAgIEhSX0NUUkxfUFRf
VVVJRCA9ICcwMDAwMmEzOS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmInCgogICAgZGVmIF9f
aW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgsIHNlcnZpY2UpOgogICAgICAgIENoYXJhY3RlcmlzdGlj
Ll9faW5pdF9fKAogICAgICAgICAgICAgICAgc2VsZiwgYnVzLCBpbmRleCwKICAgICAgICAgICAg
ICAgIHNlbGYuSFJfQ1RSTF9QVF9VVUlELAogICAgICAgICAgICAgICAgWyd3cml0ZSddLAogICAg
ICAgICAgICAgICAgc2VydmljZSkKCiAgICBkZWYgV3JpdGVWYWx1ZShzZWxmLCB2YWx1ZSwgb3B0
aW9ucyk6CiAgICAgICAgcHJpbnQoJ0hlYXJ0IFJhdGUgQ29udHJvbCBQb2ludCBXcml0ZVZhbHVl
IGNhbGxlZCcpCgogICAgICAgIGlmIGxlbih2YWx1ZSkgIT0gMToKICAgICAgICAgICAgcmFpc2Ug
SW52YWxpZFZhbHVlTGVuZ3RoRXhjZXB0aW9uKCkKCiAgICAgICAgYnl0ZSA9IHZhbHVlWzBdCiAg
ICAgICAgcHJpbnQoJ0NvbnRyb2wgUG9pbnQgdmFsdWU6ICcgKyByZXByKGJ5dGUpKQoKICAgICAg
ICBpZiBieXRlICE9IDE6CiAgICAgICAgICAgIHJhaXNlIEZhaWxlZEV4Y2VwdGlvbigiMHg4MCIp
CgogICAgICAgIHByaW50KCdFbmVyZ3kgRXhwZW5kZWQgZmllbGQgcmVzZXQhJykKICAgICAgICBz
ZWxmLnNlcnZpY2UuZW5lcmd5X2V4cGVuZGVkID0gMAoKCmNsYXNzIEJhdHRlcnlTZXJ2aWNlKFNl
cnZpY2UpOgogICAgIiIiCiAgICBGYWtlIEJhdHRlcnkgc2VydmljZSB0aGF0IGVtdWxhdGVzIGEg
ZHJhaW5pbmcgYmF0dGVyeS4KCiAgICAiIiIKICAgIEJBVFRFUllfVVVJRCA9ICcxODBmJwoKICAg
IGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4KToKICAgICAgICBTZXJ2aWNlLl9faW5pdF9f
KHNlbGYsIGJ1cywgaW5kZXgsIHNlbGYuQkFUVEVSWV9VVUlELCBUcnVlKQogICAgICAgIHNlbGYu
YWRkX2NoYXJhY3RlcmlzdGljKEJhdHRlcnlMZXZlbENoYXJhY3RlcmlzdGljKGJ1cywgMCwgc2Vs
ZikpCgoKY2xhc3MgQmF0dGVyeUxldmVsQ2hhcmFjdGVyaXN0aWMoQ2hhcmFjdGVyaXN0aWMpOgog
ICAgIiIiCiAgICBGYWtlIEJhdHRlcnkgTGV2ZWwgY2hhcmFjdGVyaXN0aWMuIFRoZSBiYXR0ZXJ5
IGxldmVsIGlzIGRyYWluZWQgYnkgMiBwb2ludHMKICAgIGV2ZXJ5IDUgc2Vjb25kcy4KCiAgICAi
IiIKICAgIEJBVFRFUllfTFZMX1VVSUQgPSAnMmExOScKCiAgICBkZWYgX19pbml0X18oc2VsZiwg
YnVzLCBpbmRleCwgc2VydmljZSk6CiAgICAgICAgQ2hhcmFjdGVyaXN0aWMuX19pbml0X18oCiAg
ICAgICAgICAgICAgICBzZWxmLCBidXMsIGluZGV4LAogICAgICAgICAgICAgICAgc2VsZi5CQVRU
RVJZX0xWTF9VVUlELAogICAgICAgICAgICAgICAgWydyZWFkJywgJ25vdGlmeSddLAogICAgICAg
ICAgICAgICAgc2VydmljZSkKICAgICAgICBzZWxmLm5vdGlmeWluZyA9IEZhbHNlCiAgICAgICAg
c2VsZi5iYXR0ZXJ5X2x2bCA9IDEwMAogICAgICAgIEdPYmplY3QudGltZW91dF9hZGQoNTAwMCwg
c2VsZi5kcmFpbl9iYXR0ZXJ5KQoKICAgIGRlZiBub3RpZnlfYmF0dGVyeV9sZXZlbChzZWxmKToK
ICAgICAgICBpZiBub3Qgc2VsZi5ub3RpZnlpbmc6CiAgICAgICAgICAgIHJldHVybgogICAgICAg
IHNlbGYuUHJvcGVydGllc0NoYW5nZWQoCiAgICAgICAgICAgICAgICBHQVRUX0NIUkNfSUZBQ0Us
CiAgICAgICAgICAgICAgICB7ICdWYWx1ZSc6IFtkYnVzLkJ5dGUoc2VsZi5iYXR0ZXJ5X2x2bCld
IH0sIFtdKQoKICAgIGRlZiBkcmFpbl9iYXR0ZXJ5KHNlbGYpOgogICAgICAgIGlmIG5vdCBzZWxm
Lm5vdGlmeWluZzoKICAgICAgICAgICAgcmV0dXJuIFRydWUKICAgICAgICBpZiBzZWxmLmJhdHRl
cnlfbHZsID4gMDoKICAgICAgICAgICAgc2VsZi5iYXR0ZXJ5X2x2bCAtPSAyCiAgICAgICAgICAg
IGlmIHNlbGYuYmF0dGVyeV9sdmwgPCAwOgogICAgICAgICAgICAgICAgc2VsZi5iYXR0ZXJ5X2x2
bCA9IDAKICAgICAgICBwcmludCgnQmF0dGVyeSBMZXZlbCBkcmFpbmVkOiAnICsgcmVwcihzZWxm
LmJhdHRlcnlfbHZsKSkKICAgICAgICBzZWxmLm5vdGlmeV9iYXR0ZXJ5X2xldmVsKCkKICAgICAg
ICByZXR1cm4gVHJ1ZQoKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAgICAgICAg
cHJpbnQoJ0JhdHRlcnkgTGV2ZWwgcmVhZDogJyArIHJlcHIoc2VsZi5iYXR0ZXJ5X2x2bCkpCiAg
ICAgICAgcmV0dXJuIFtkYnVzLkJ5dGUoc2VsZi5iYXR0ZXJ5X2x2bCldCgogICAgZGVmIFN0YXJ0
Tm90aWZ5KHNlbGYpOgogICAgICAgIGlmIHNlbGYubm90aWZ5aW5nOgogICAgICAgICAgICBwcmlu
dCgnQWxyZWFkeSBub3RpZnlpbmcsIG5vdGhpbmcgdG8gZG8nKQogICAgICAgICAgICByZXR1cm4K
CiAgICAgICAgc2VsZi5ub3RpZnlpbmcgPSBUcnVlCiAgICAgICAgc2VsZi5ub3RpZnlfYmF0dGVy
eV9sZXZlbCgpCgogICAgZGVmIFN0b3BOb3RpZnkoc2VsZik6CiAgICAgICAgaWYgbm90IHNlbGYu
bm90aWZ5aW5nOgogICAgICAgICAgICBwcmludCgnTm90IG5vdGlmeWluZywgbm90aGluZyB0byBk
bycpCiAgICAgICAgICAgIHJldHVybgoKICAgICAgICBzZWxmLm5vdGlmeWluZyA9IEZhbHNlCgoK
Y2xhc3MgVGVzdFNlcnZpY2UoU2VydmljZSk6CiAgICAiIiIKICAgIER1bW15IHRlc3Qgc2Vydmlj
ZSB0aGF0IHByb3ZpZGVzIGNoYXJhY3RlcmlzdGljcyBhbmQgZGVzY3JpcHRvcnMgdGhhdAogICAg
ZXhlcmNpc2UgdmFyaW91cyBBUEkgZnVuY3Rpb25hbGl0eS4KCiAgICAiIiIKICAgIFRFU1RfU1ZD
X1VVSUQgPSAnMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWYwJwoKICAgIGRlZiBf
X2luaXRfXyhzZWxmLCBidXMsIGluZGV4KToKICAgICAgICBTZXJ2aWNlLl9faW5pdF9fKHNlbGYs
IGJ1cywgaW5kZXgsIHNlbGYuVEVTVF9TVkNfVVVJRCwgVHJ1ZSkKICAgICAgICBzZWxmLmFkZF9j
aGFyYWN0ZXJpc3RpYyhUZXN0Q2hhcmFjdGVyaXN0aWMoYnVzLCAwLCBzZWxmKSkKICAgICAgICBz
ZWxmLmFkZF9jaGFyYWN0ZXJpc3RpYyhUZXN0RW5jcnlwdENoYXJhY3RlcmlzdGljKGJ1cywgMSwg
c2VsZikpCiAgICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoVGVzdFNlY3VyZUNoYXJhY3Rl
cmlzdGljKGJ1cywgMiwgc2VsZikpCgpjbGFzcyBUZXN0Q2hhcmFjdGVyaXN0aWMoQ2hhcmFjdGVy
aXN0aWMpOgogICAgIiIiCiAgICBEdW1teSB0ZXN0IGNoYXJhY3RlcmlzdGljLiBBbGxvd3Mgd3Jp
dGluZyBhcmJpdHJhcnkgYnl0ZXMgdG8gaXRzIHZhbHVlLCBhbmQKICAgIGNvbnRhaW5zICJleHRl
bmRlZCBwcm9wZXJ0aWVzIiwgYXMgd2VsbCBhcyBhIHRlc3QgZGVzY3JpcHRvci4KCiAgICAiIiIK
ICAgIFRFU1RfQ0hSQ19VVUlEID0gJzEyMzQ1Njc4LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVm
MScKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgc2VydmljZSk6CiAgICAgICAg
Q2hhcmFjdGVyaXN0aWMuX19pbml0X18oCiAgICAgICAgICAgICAgICBzZWxmLCBidXMsIGluZGV4
LAogICAgICAgICAgICAgICAgc2VsZi5URVNUX0NIUkNfVVVJRCwKICAgICAgICAgICAgICAgIFsn
cmVhZCcsICd3cml0ZScsICd3cml0YWJsZS1hdXhpbGlhcmllcyddLAogICAgICAgICAgICAgICAg
c2VydmljZSkKICAgICAgICBzZWxmLnZhbHVlID0gW10KICAgICAgICBzZWxmLmFkZF9kZXNjcmlw
dG9yKFRlc3REZXNjcmlwdG9yKGJ1cywgMCwgc2VsZikpCiAgICAgICAgc2VsZi5hZGRfZGVzY3Jp
cHRvcigKICAgICAgICAgICAgICAgIENoYXJhY3RlcmlzdGljVXNlckRlc2NyaXB0aW9uRGVzY3Jp
cHRvcihidXMsIDEsIHNlbGYpKQoKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAg
ICAgICAgcHJpbnQoJ1Rlc3RDaGFyYWN0ZXJpc3RpYyBSZWFkOiAnICsgcmVwcihzZWxmLnZhbHVl
KSkKICAgICAgICByZXR1cm4gc2VsZi52YWx1ZQoKICAgIGRlZiBXcml0ZVZhbHVlKHNlbGYsIHZh
bHVlLCBvcHRpb25zKToKICAgICAgICBwcmludCgnVGVzdENoYXJhY3RlcmlzdGljIFdyaXRlOiAn
ICsgcmVwcih2YWx1ZSkpCiAgICAgICAgc2VsZi52YWx1ZSA9IHZhbHVlCgoKY2xhc3MgVGVzdERl
c2NyaXB0b3IoRGVzY3JpcHRvcik6CiAgICAiIiIKICAgIER1bW15IHRlc3QgZGVzY3JpcHRvci4g
UmV0dXJucyBhIHN0YXRpYyB2YWx1ZS4KCiAgICAiIiIKICAgIFRFU1RfREVTQ19VVUlEID0gJzEy
MzQ1Njc4LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVmMicKCiAgICBkZWYgX19pbml0X18oc2Vs
ZiwgYnVzLCBpbmRleCwgY2hhcmFjdGVyaXN0aWMpOgogICAgICAgIERlc2NyaXB0b3IuX19pbml0
X18oCiAgICAgICAgICAgICAgICBzZWxmLCBidXMsIGluZGV4LAogICAgICAgICAgICAgICAgc2Vs
Zi5URVNUX0RFU0NfVVVJRCwKICAgICAgICAgICAgICAgIFsncmVhZCcsICd3cml0ZSddLAogICAg
ICAgICAgICAgICAgY2hhcmFjdGVyaXN0aWMpCgogICAgZGVmIFJlYWRWYWx1ZShzZWxmLCBvcHRp
b25zKToKICAgICAgICByZXR1cm4gWwogICAgICAgICAgICAgICAgZGJ1cy5CeXRlKCdUJyksIGRi
dXMuQnl0ZSgnZScpLCBkYnVzLkJ5dGUoJ3MnKSwgZGJ1cy5CeXRlKCd0JykKICAgICAgICBdCgoK
Y2xhc3MgQ2hhcmFjdGVyaXN0aWNVc2VyRGVzY3JpcHRpb25EZXNjcmlwdG9yKERlc2NyaXB0b3Ip
OgogICAgIiIiCiAgICBXcml0YWJsZSBDVUQgZGVzY3JpcHRvci4KCiAgICAiIiIKICAgIENVRF9V
VUlEID0gJzI5MDEnCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgsIGNoYXJhY3Rl
cmlzdGljKToKICAgICAgICBzZWxmLndyaXRhYmxlID0gJ3dyaXRhYmxlLWF1eGlsaWFyaWVzJyBp
biBjaGFyYWN0ZXJpc3RpYy5mbGFncwogICAgICAgIHNlbGYudmFsdWUgPSBhcnJheS5hcnJheSgn
QicsIGInVGhpcyBpcyBhIGNoYXJhY3RlcmlzdGljIGZvciB0ZXN0aW5nJykKICAgICAgICBzZWxm
LnZhbHVlID0gc2VsZi52YWx1ZS50b2xpc3QoKQogICAgICAgIERlc2NyaXB0b3IuX19pbml0X18o
CiAgICAgICAgICAgICAgICBzZWxmLCBidXMsIGluZGV4LAogICAgICAgICAgICAgICAgc2VsZi5D
VURfVVVJRCwKICAgICAgICAgICAgICAgIFsncmVhZCcsICd3cml0ZSddLAogICAgICAgICAgICAg
ICAgY2hhcmFjdGVyaXN0aWMpCgogICAgZGVmIFJlYWRWYWx1ZShzZWxmLCBvcHRpb25zKToKICAg
ICAgICByZXR1cm4gc2VsZi52YWx1ZQoKICAgIGRlZiBXcml0ZVZhbHVlKHNlbGYsIHZhbHVlLCBv
cHRpb25zKToKICAgICAgICBpZiBub3Qgc2VsZi53cml0YWJsZToKICAgICAgICAgICAgcmFpc2Ug
Tm90UGVybWl0dGVkRXhjZXB0aW9uKCkKICAgICAgICBzZWxmLnZhbHVlID0gdmFsdWUKCmNsYXNz
IFRlc3RFbmNyeXB0Q2hhcmFjdGVyaXN0aWMoQ2hhcmFjdGVyaXN0aWMpOgogICAgIiIiCiAgICBE
dW1teSB0ZXN0IGNoYXJhY3RlcmlzdGljIHJlcXVpcmluZyBlbmNyeXB0aW9uLgoKICAgICIiIgog
ICAgVEVTVF9DSFJDX1VVSUQgPSAnMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWYz
JwoKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBzZXJ2aWNlKToKICAgICAgICBD
aGFyYWN0ZXJpc3RpYy5fX2luaXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgs
CiAgICAgICAgICAgICAgICBzZWxmLlRFU1RfQ0hSQ19VVUlELAogICAgICAgICAgICAgICAgWydl
bmNyeXB0LXJlYWQnLCAnZW5jcnlwdC13cml0ZSddLAogICAgICAgICAgICAgICAgc2VydmljZSkK
ICAgICAgICBzZWxmLnZhbHVlID0gW10KICAgICAgICBzZWxmLmFkZF9kZXNjcmlwdG9yKFRlc3RF
bmNyeXB0RGVzY3JpcHRvcihidXMsIDIsIHNlbGYpKQogICAgICAgIHNlbGYuYWRkX2Rlc2NyaXB0
b3IoCiAgICAgICAgICAgICAgICBDaGFyYWN0ZXJpc3RpY1VzZXJEZXNjcmlwdGlvbkRlc2NyaXB0
b3IoYnVzLCAzLCBzZWxmKSkKCiAgICBkZWYgUmVhZFZhbHVlKHNlbGYsIG9wdGlvbnMpOgogICAg
ICAgIHByaW50KCdUZXN0RW5jcnlwdENoYXJhY3RlcmlzdGljIFJlYWQ6ICcgKyByZXByKHNlbGYu
dmFsdWUpKQogICAgICAgIHJldHVybiBzZWxmLnZhbHVlCgogICAgZGVmIFdyaXRlVmFsdWUoc2Vs
ZiwgdmFsdWUsIG9wdGlvbnMpOgogICAgICAgIHByaW50KCdUZXN0RW5jcnlwdENoYXJhY3Rlcmlz
dGljIFdyaXRlOiAnICsgcmVwcih2YWx1ZSkpCiAgICAgICAgc2VsZi52YWx1ZSA9IHZhbHVlCgpj
bGFzcyBUZXN0RW5jcnlwdERlc2NyaXB0b3IoRGVzY3JpcHRvcik6CiAgICAiIiIKICAgIER1bW15
IHRlc3QgZGVzY3JpcHRvciByZXF1aXJpbmcgZW5jcnlwdGlvbi4gUmV0dXJucyBhIHN0YXRpYyB2
YWx1ZS4KCiAgICAiIiIKICAgIFRFU1RfREVTQ19VVUlEID0gJzEyMzQ1Njc4LTEyMzQtNTY3OC0x
MjM0LTU2Nzg5YWJjZGVmNCcKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgY2hh
cmFjdGVyaXN0aWMpOgogICAgICAgIERlc2NyaXB0b3IuX19pbml0X18oCiAgICAgICAgICAgICAg
ICBzZWxmLCBidXMsIGluZGV4LAogICAgICAgICAgICAgICAgc2VsZi5URVNUX0RFU0NfVVVJRCwK
ICAgICAgICAgICAgICAgIFsnZW5jcnlwdC1yZWFkJywgJ2VuY3J5cHQtd3JpdGUnXSwKICAgICAg
ICAgICAgICAgIGNoYXJhY3RlcmlzdGljKQoKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9u
cyk6CiAgICAgICAgcmV0dXJuIFsKICAgICAgICAgICAgICAgIGRidXMuQnl0ZSgnVCcpLCBkYnVz
LkJ5dGUoJ2UnKSwgZGJ1cy5CeXRlKCdzJyksIGRidXMuQnl0ZSgndCcpCiAgICAgICAgXQoKCmNs
YXNzIFRlc3RTZWN1cmVDaGFyYWN0ZXJpc3RpYyhDaGFyYWN0ZXJpc3RpYyk6CiAgICAiIiIKICAg
IER1bW15IHRlc3QgY2hhcmFjdGVyaXN0aWMgcmVxdWlyaW5nIHNlY3VyZSBjb25uZWN0aW9uLgoK
ICAgICIiIgogICAgVEVTVF9DSFJDX1VVSUQgPSAnMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3
ODlhYmNkZWY1JwoKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBzZXJ2aWNlKToK
ICAgICAgICBDaGFyYWN0ZXJpc3RpYy5fX2luaXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1
cywgaW5kZXgsCiAgICAgICAgICAgICAgICBzZWxmLlRFU1RfQ0hSQ19VVUlELAogICAgICAgICAg
ICAgICAgWydzZWN1cmUtcmVhZCcsICdzZWN1cmUtd3JpdGUnXSwKICAgICAgICAgICAgICAgIHNl
cnZpY2UpCiAgICAgICAgc2VsZi52YWx1ZSA9IFtdCiAgICAgICAgc2VsZi5hZGRfZGVzY3JpcHRv
cihUZXN0U2VjdXJlRGVzY3JpcHRvcihidXMsIDIsIHNlbGYpKQogICAgICAgIHNlbGYuYWRkX2Rl
c2NyaXB0b3IoCiAgICAgICAgICAgICAgICBDaGFyYWN0ZXJpc3RpY1VzZXJEZXNjcmlwdGlvbkRl
c2NyaXB0b3IoYnVzLCAzLCBzZWxmKSkKCiAgICBkZWYgUmVhZFZhbHVlKHNlbGYsIG9wdGlvbnMp
OgogICAgICAgIHByaW50KCdUZXN0U2VjdXJlQ2hhcmFjdGVyaXN0aWMgUmVhZDogJyArIHJlcHIo
c2VsZi52YWx1ZSkpCiAgICAgICAgcmV0dXJuIHNlbGYudmFsdWUKCiAgICBkZWYgV3JpdGVWYWx1
ZShzZWxmLCB2YWx1ZSwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQoJ1Rlc3RTZWN1cmVDaGFyYWN0
ZXJpc3RpYyBXcml0ZTogJyArIHJlcHIodmFsdWUpKQogICAgICAgIHNlbGYudmFsdWUgPSB2YWx1
ZQoKCmNsYXNzIFRlc3RTZWN1cmVEZXNjcmlwdG9yKERlc2NyaXB0b3IpOgogICAgIiIiCiAgICBE
dW1teSB0ZXN0IGRlc2NyaXB0b3IgcmVxdWlyaW5nIHNlY3VyZSBjb25uZWN0aW9uLiBSZXR1cm5z
IGEgc3RhdGljIHZhbHVlLgoKICAgICIiIgogICAgVEVTVF9ERVNDX1VVSUQgPSAnMTIzNDU2Nzgt
MTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY2JwoKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMs
IGluZGV4LCBjaGFyYWN0ZXJpc3RpYyk6CiAgICAgICAgRGVzY3JpcHRvci5fX2luaXRfXygKICAg
ICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAgICAgICAgICAgICAgICBzZWxmLlRFU1Rf
REVTQ19VVUlELAogICAgICAgICAgICAgICAgWydzZWN1cmUtcmVhZCcsICdzZWN1cmUtd3JpdGUn
XSwKICAgICAgICAgICAgICAgIGNoYXJhY3RlcmlzdGljKQoKICAgIGRlZiBSZWFkVmFsdWUoc2Vs
Ziwgb3B0aW9ucyk6CiAgICAgICAgcmV0dXJuIFsKICAgICAgICAgICAgICAgIGRidXMuQnl0ZSgn
VCcpLCBkYnVzLkJ5dGUoJ2UnKSwgZGJ1cy5CeXRlKCdzJyksIGRidXMuQnl0ZSgndCcpCiAgICAg
ICAgXQoKZGVmIHJlZ2lzdGVyX2FwcF9jYigpOgogICAgcHJpbnQoJ0dBVFQgYXBwbGljYXRpb24g
cmVnaXN0ZXJlZCcpCgoKZGVmIHJlZ2lzdGVyX2FwcF9lcnJvcl9jYihlcnJvcik6CiAgICBwcmlu
dCgnRmFpbGVkIHRvIHJlZ2lzdGVyIGFwcGxpY2F0aW9uOiAnICsgc3RyKGVycm9yKSkKICAgIG1h
aW5sb29wLnF1aXQoKQoKCmRlZiBmaW5kX2FkYXB0ZXIoYnVzKToKICAgIHJlbW90ZV9vbSA9IGRi
dXMuSW50ZXJmYWNlKGJ1cy5nZXRfb2JqZWN0KEJMVUVaX1NFUlZJQ0VfTkFNRSwgJy8nKSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIERCVVNfT01fSUZBQ0UpCiAgICBvYmplY3RzID0g
cmVtb3RlX29tLkdldE1hbmFnZWRPYmplY3RzKCkKCiAgICBmb3IgbywgcHJvcHMgaW4gb2JqZWN0
cy5pdGVtcygpOgogICAgICAgIGlmIEdBVFRfTUFOQUdFUl9JRkFDRSBpbiBwcm9wcy5rZXlzKCk6
CiAgICAgICAgICAgIHJldHVybiBvCgogICAgcmV0dXJuIE5vbmUKCmRlZiBtYWluKCk6CiAgICBn
bG9iYWwgbWFpbmxvb3AKCiAgICBkYnVzLm1haW5sb29wLmdsaWIuREJ1c0dNYWluTG9vcChzZXRf
YXNfZGVmYXVsdD1UcnVlKQoKICAgIGJ1cyA9IGRidXMuU3lzdGVtQnVzKCkKCiAgICBhZGFwdGVy
ID0gZmluZF9hZGFwdGVyKGJ1cykKICAgIGlmIG5vdCBhZGFwdGVyOgogICAgICAgIHByaW50KCdH
YXR0TWFuYWdlcjEgaW50ZXJmYWNlIG5vdCBmb3VuZCcpCiAgICAgICAgcmV0dXJuCgogICAgc2Vy
dmljZV9tYW5hZ2VyID0gZGJ1cy5JbnRlcmZhY2UoCiAgICAgICAgICAgIGJ1cy5nZXRfb2JqZWN0
KEJMVUVaX1NFUlZJQ0VfTkFNRSwgYWRhcHRlciksCiAgICAgICAgICAgIEdBVFRfTUFOQUdFUl9J
RkFDRSkKCiAgICBhcHAgPSBBcHBsaWNhdGlvbihidXMpCgogICAgbWFpbmxvb3AgPSBHT2JqZWN0
Lk1haW5Mb29wKCkKCiAgICBwcmludCgnUmVnaXN0ZXJpbmcgR0FUVCBhcHBsaWNhdGlvbi4uLicp
CgogICAgc2VydmljZV9tYW5hZ2VyLlJlZ2lzdGVyQXBwbGljYXRpb24oYXBwLmdldF9wYXRoKCks
IHt9LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXBseV9oYW5kbGVyPXJl
Z2lzdGVyX2FwcF9jYiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3Jf
aGFuZGxlcj1yZWdpc3Rlcl9hcHBfZXJyb3JfY2IpCgoKICAgICMgQWR2ZXJ0CiAgICBpZiBub3Qg
YWRhcHRlcjoKICAgICAgICBwcmludCggJ0xFQWR2ZXJ0aXNpbmdNYW5hZ2VyMSBpbnRlcmZhY2Ug
bm90IGZvdW5kJykKICAgICAgICByZXR1cm4KCiAgICBhZGFwdGVyX3Byb3BzID0gZGJ1cy5JbnRl
cmZhY2UoYnVzLmdldF9vYmplY3QoQkxVRVpfU0VSVklDRV9OQU1FLCBhZGFwdGVyKSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAib3JnLmZyZWVkZXNrdG9wLkRCdXMuUHJvcGVy
dGllcyIpOwoKICAgIGFkYXB0ZXJfcHJvcHMuU2V0KCJvcmcuYmx1ZXouQWRhcHRlcjEiLCAiUG93
ZXJlZCIsIGRidXMuQm9vbGVhbigxKSkKCiAgICBhZF9tYW5hZ2VyID0gZGJ1cy5JbnRlcmZhY2Uo
YnVzLmdldF9vYmplY3QoQkxVRVpfU0VSVklDRV9OQU1FLCBhZGFwdGVyKSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBMRV9BRFZFUlRJU0lOR19NQU5BR0VSX0lGQUNFKQoKICAgIHRl
c3RfYWR2ZXJ0aXNlbWVudCA9IFRlc3RBZHZlcnRpc2VtZW50KGJ1cywgMCkKCiAgICBhZF9tYW5h
Z2VyLlJlZ2lzdGVyQWR2ZXJ0aXNlbWVudCh0ZXN0X2FkdmVydGlzZW1lbnQuZ2V0X3BhdGgoKSwg
e30sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXBseV9oYW5kbGVyPXJl
Z2lzdGVyX2FkX2NiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3Jf
aGFuZGxlcj1yZWdpc3Rlcl9hZF9lcnJvcl9jYikKCiAgICBtYWlubG9vcC5ydW4oKQoKaWYgX19u
YW1lX18gPT0gJ19fbWFpbl9fJzoKICAgIG1haW4oKQoK
--00000000000024a89405b9dddda4
Content-Type: text/plain; charset="US-ASCII"; name="bt_notify.py"
Content-Disposition: attachment; filename="bt_notify.py"
Content-Transfer-Encoding: base64
Content-ID: <f_kkf6ucpq0>
X-Attachment-Id: f_kkf6ucpq0

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKaW1wb3J0IGRidXMKaW1wb3J0IGRidXMuZXhjZXB0aW9u
cwppbXBvcnQgZGJ1cy5tYWlubG9vcC5nbGliCmltcG9ydCBkYnVzLnNlcnZpY2UKCmltcG9ydCBh
cnJheQp0cnk6CiAgZnJvbSBnaS5yZXBvc2l0b3J5IGltcG9ydCBHT2JqZWN0CmV4Y2VwdCBJbXBv
cnRFcnJvcjoKICBpbXBvcnQgZ29iamVjdCBhcyBHT2JqZWN0CmltcG9ydCBzeXMKCmZyb20gcmFu
ZG9tIGltcG9ydCByYW5kaW50CgojIEFkdmVydAppbXBvcnQgZ29iamVjdAoKbWFpbmxvb3AgPSBO
b25lCgpCTFVFWl9TRVJWSUNFX05BTUUgPSAnb3JnLmJsdWV6JwpHQVRUX01BTkFHRVJfSUZBQ0Ug
PSAnb3JnLmJsdWV6LkdhdHRNYW5hZ2VyMScKREJVU19PTV9JRkFDRSA9ICAgICAgJ29yZy5mcmVl
ZGVza3RvcC5EQnVzLk9iamVjdE1hbmFnZXInCkRCVVNfUFJPUF9JRkFDRSA9ICAgICdvcmcuZnJl
ZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzJwoKR0FUVF9TRVJWSUNFX0lGQUNFID0gJ29yZy5ibHVl
ei5HYXR0U2VydmljZTEnCkdBVFRfQ0hSQ19JRkFDRSA9ICAgICdvcmcuYmx1ZXouR2F0dENoYXJh
Y3RlcmlzdGljMScKR0FUVF9ERVNDX0lGQUNFID0gICAgJ29yZy5ibHVlei5HYXR0RGVzY3JpcHRv
cjEnCgojIEFkdmVydApMRV9BRFZFUlRJU0lOR19NQU5BR0VSX0lGQUNFID0gJ29yZy5ibHVlei5M
RUFkdmVydGlzaW5nTWFuYWdlcjEnCkxFX0FEVkVSVElTRU1FTlRfSUZBQ0UgPSAnb3JnLmJsdWV6
LkxFQWR2ZXJ0aXNlbWVudDEnCgojIEFkdmVydApjbGFzcyBJbnZhbGlkQXJnc0V4Y2VwdGlvbihk
YnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1c19lcnJvcl9uYW1lID0gJ29y
Zy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLkludmFsaWRBcmdzJwoKCmNsYXNzIE5vdFN1cHBvcnRl
ZEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1c19lcnJv
cl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5Ob3RTdXBwb3J0ZWQnCgoKY2xhc3MgTm90UGVybWl0
dGVkRXhjZXB0aW9uKGRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vy
cm9yX25hbWUgPSAnb3JnLmJsdWV6LkVycm9yLk5vdFBlcm1pdHRlZCcKCgpjbGFzcyBJbnZhbGlk
VmFsdWVMZW5ndGhFeGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAg
X2RidXNfZXJyb3JfbmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuSW52YWxpZFZhbHVlTGVuZ3RoJwoK
CmNsYXNzIEZhaWxlZEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAg
ICBfZGJ1c19lcnJvcl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5GYWlsZWQnCgoKY2xhc3MgQWR2
ZXJ0aXNlbWVudChkYnVzLnNlcnZpY2UuT2JqZWN0KToKICAgIFBBVEhfQkFTRSA9ICcvb3JnL2Js
dWV6L2V4YW1wbGUvYWR2ZXJ0aXNlbWVudCcKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBp
bmRleCwgYWR2ZXJ0aXNpbmdfdHlwZSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VsZi5QQVRIX0JB
U0UgKyBzdHIoaW5kZXgpCiAgICAgICAgc2VsZi5idXMgPSBidXMKICAgICAgICBzZWxmLmFkX3R5
cGUgPSBhZHZlcnRpc2luZ190eXBlCiAgICAgICAgc2VsZi5zZXJ2aWNlX3V1aWRzID0gTm9uZQog
ICAgICAgIHNlbGYubWFudWZhY3R1cmVyX2RhdGEgPSBOb25lCiAgICAgICAgc2VsZi5zb2xpY2l0
X3V1aWRzID0gTm9uZQogICAgICAgIHNlbGYuc2VydmljZV9kYXRhID0gTm9uZQogICAgICAgIHNl
bGYubG9jYWxfbmFtZSA9IE5vbmUKICAgICAgICBzZWxmLmluY2x1ZGVfdHhfcG93ZXIgPSBOb25l
CiAgICAgICAgc2VsZi5kYXRhID0gTm9uZQogICAgICAgIGRidXMuc2VydmljZS5PYmplY3QuX19p
bml0X18oc2VsZiwgYnVzLCBzZWxmLnBhdGgpCgogICAgZGVmIGdldF9wcm9wZXJ0aWVzKHNlbGYp
OgogICAgICAgIHByb3BlcnRpZXMgPSBkaWN0KCkKICAgICAgICBwcm9wZXJ0aWVzWydUeXBlJ10g
PSBzZWxmLmFkX3R5cGUKICAgICAgICBpZiBzZWxmLnNlcnZpY2VfdXVpZHMgaXMgbm90IE5vbmU6
CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ1NlcnZpY2VVVUlEcyddID0gZGJ1cy5BcnJheShzZWxm
LnNlcnZpY2VfdXVpZHMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaWduYXR1cmU9J3MnKQogICAgICAgIGlmIHNlbGYuc29saWNpdF91dWlkcyBp
cyBub3QgTm9uZToKICAgICAgICAgICAgcHJvcGVydGllc1snU29saWNpdFVVSURzJ10gPSBkYnVz
LkFycmF5KHNlbGYuc29saWNpdF91dWlkcywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpZ25hdHVyZT0ncycpCiAgICAgICAgaWYgc2VsZi5tYW51
ZmFjdHVyZXJfZGF0YSBpcyBub3QgTm9uZToKICAgICAgICAgICAgcHJvcGVydGllc1snTWFudWZh
Y3R1cmVyRGF0YSddID0gZGJ1cy5EaWN0aW9uYXJ5KAogICAgICAgICAgICAgICAgc2VsZi5tYW51
ZmFjdHVyZXJfZGF0YSwgc2lnbmF0dXJlPSdxdicpCiAgICAgICAgaWYgc2VsZi5zZXJ2aWNlX2Rh
dGEgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ1NlcnZpY2VEYXRhJ10gPSBk
YnVzLkRpY3Rpb25hcnkoc2VsZi5zZXJ2aWNlX2RhdGEsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2lnbmF0dXJlPSdzdicpCiAgICAgICAg
aWYgc2VsZi5sb2NhbF9uYW1lIGlzIG5vdCBOb25lOgogICAgICAgICAgICBwcm9wZXJ0aWVzWydM
b2NhbE5hbWUnXSA9IGRidXMuU3RyaW5nKHNlbGYubG9jYWxfbmFtZSkKICAgICAgICBpZiBzZWxm
LmluY2x1ZGVfdHhfcG93ZXIgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ0lu
Y2x1ZGVUeFBvd2VyJ10gPSBkYnVzLkJvb2xlYW4oc2VsZi5pbmNsdWRlX3R4X3Bvd2VyKQoKICAg
ICAgICBpZiBzZWxmLmRhdGEgaXMgbm90IE5vbmU6CiAgICAgICAgICAgIHByb3BlcnRpZXNbJ0Rh
dGEnXSA9IGRidXMuRGljdGlvbmFyeSgKICAgICAgICAgICAgICAgIHNlbGYuZGF0YSwgc2lnbmF0
dXJlPSd5dicpCiAgICAgICAgcmV0dXJuIHtMRV9BRFZFUlRJU0VNRU5UX0lGQUNFOiBwcm9wZXJ0
aWVzfQoKICAgIGRlZiBnZXRfcGF0aChzZWxmKToKICAgICAgICByZXR1cm4gZGJ1cy5PYmplY3RQ
YXRoKHNlbGYucGF0aCkKCiAgICBkZWYgYWRkX3NlcnZpY2VfdXVpZChzZWxmLCB1dWlkKToKICAg
ICAgICBpZiBub3Qgc2VsZi5zZXJ2aWNlX3V1aWRzOgogICAgICAgICAgICBzZWxmLnNlcnZpY2Vf
dXVpZHMgPSBbXQogICAgICAgIHNlbGYuc2VydmljZV91dWlkcy5hcHBlbmQodXVpZCkKCiAgICBk
ZWYgYWRkX3NvbGljaXRfdXVpZChzZWxmLCB1dWlkKToKICAgICAgICBpZiBub3Qgc2VsZi5zb2xp
Y2l0X3V1aWRzOgogICAgICAgICAgICBzZWxmLnNvbGljaXRfdXVpZHMgPSBbXQogICAgICAgIHNl
bGYuc29saWNpdF91dWlkcy5hcHBlbmQodXVpZCkKCiAgICBkZWYgYWRkX21hbnVmYWN0dXJlcl9k
YXRhKHNlbGYsIG1hbnVmX2NvZGUsIGRhdGEpOgogICAgICAgIGlmIG5vdCBzZWxmLm1hbnVmYWN0
dXJlcl9kYXRhOgogICAgICAgICAgICBzZWxmLm1hbnVmYWN0dXJlcl9kYXRhID0gZGJ1cy5EaWN0
aW9uYXJ5KHt9LCBzaWduYXR1cmU9J3F2JykKICAgICAgICBzZWxmLm1hbnVmYWN0dXJlcl9kYXRh
W21hbnVmX2NvZGVdID0gZGJ1cy5BcnJheShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIGRlZiBh
ZGRfc2VydmljZV9kYXRhKHNlbGYsIHV1aWQsIGRhdGEpOgogICAgICAgIGlmIG5vdCBzZWxmLnNl
cnZpY2VfZGF0YToKICAgICAgICAgICAgc2VsZi5zZXJ2aWNlX2RhdGEgPSBkYnVzLkRpY3Rpb25h
cnkoe30sIHNpZ25hdHVyZT0nc3YnKQogICAgICAgIHNlbGYuc2VydmljZV9kYXRhW3V1aWRdID0g
ZGJ1cy5BcnJheShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIGRlZiBhZGRfbG9jYWxfbmFtZShz
ZWxmLCBuYW1lKToKICAgICAgICBpZiBub3Qgc2VsZi5sb2NhbF9uYW1lOgogICAgICAgICAgICBz
ZWxmLmxvY2FsX25hbWUgPSAiIgogICAgICAgIHNlbGYubG9jYWxfbmFtZSA9IGRidXMuU3RyaW5n
KG5hbWUpCgogICAgZGVmIGFkZF9kYXRhKHNlbGYsIGFkX3R5cGUsIGRhdGEpOgogICAgICAgIGlm
IG5vdCBzZWxmLmRhdGE6CiAgICAgICAgICAgIHNlbGYuZGF0YSA9IGRidXMuRGljdGlvbmFyeSh7
fSwgc2lnbmF0dXJlPSd5dicpCiAgICAgICAgc2VsZi5kYXRhW2FkX3R5cGVdID0gZGJ1cy5BcnJh
eShkYXRhLCBzaWduYXR1cmU9J3knKQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKERCVVNfUFJP
UF9JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgIGluX3NpZ25hdHVyZT0ncycsCiAgICAg
ICAgICAgICAgICAgICAgICAgICBvdXRfc2lnbmF0dXJlPSdhe3N2fScpCiAgICBkZWYgR2V0QWxs
KHNlbGYsIGludGVyZmFjZSk6CiAgICAgICAgcHJpbnQoICdHZXRBbGwnKQogICAgICAgIGlmIGlu
dGVyZmFjZSAhPSBMRV9BRFZFUlRJU0VNRU5UX0lGQUNFOgogICAgICAgICAgICByYWlzZSBJbnZh
bGlkQXJnc0V4Y2VwdGlvbigpCiAgICAgICAgcHJpbnQoICdyZXR1cm5pbmcgcHJvcHMnKQogICAg
ICAgIHJldHVybiBzZWxmLmdldF9wcm9wZXJ0aWVzKClbTEVfQURWRVJUSVNFTUVOVF9JRkFDRV0K
CiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChMRV9BRFZFUlRJU0VNRU5UX0lGQUNFLAogICAgICAg
ICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPScnLAogICAgICAgICAgICAgICAgICAgICAg
ICAgb3V0X3NpZ25hdHVyZT0nJykKICAgIGRlZiBSZWxlYXNlKHNlbGYpOgogICAgICAgIHByaW50
KCAnJXM6IFJlbGVhc2VkIScgJSBzZWxmLnBhdGgpCgpjbGFzcyBUZXN0QWR2ZXJ0aXNlbWVudChB
ZHZlcnRpc2VtZW50KToKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCk6CiAgICAg
ICAgQWR2ZXJ0aXNlbWVudC5fX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCAncGVyaXBoZXJhbCcp
CiAgICAgICAgc2VsZi5hZGRfc2VydmljZV91dWlkKCcxODBEJykKICAgICAgICBzZWxmLmFkZF9z
ZXJ2aWNlX3V1aWQoJzE4MEYnKQogICAgICAgIHNlbGYuYWRkX21hbnVmYWN0dXJlcl9kYXRhKDB4
ZmZmZiwgWzB4MDAsIDB4MDEsIDB4MDIsIDB4MDMsIDB4MDRdKQogICAgICAgIHNlbGYuYWRkX3Nl
cnZpY2VfZGF0YSgnOTk5OScsIFsweDAwLCAweDAxLCAweDAyLCAweDAzLCAweDA0XSkKICAgICAg
ICBzZWxmLmFkZF9sb2NhbF9uYW1lKCdUZXN0QWR2ZXJ0aXNlbWVudCcpCiAgICAgICAgc2VsZi5p
bmNsdWRlX3R4X3Bvd2VyID0gVHJ1ZQogICAgICAgIHNlbGYuYWRkX2RhdGEoMHgyNiwgWzB4MDEs
IDB4MDEsIDB4MDBdKQoKCmRlZiByZWdpc3Rlcl9hZF9jYigpOgogICAgcHJpbnQoICdBZHZlcnRp
c2VtZW50IHJlZ2lzdGVyZWQnKQoKCmRlZiByZWdpc3Rlcl9hZF9lcnJvcl9jYihlcnJvcik6CiAg
ICBwcmludCggJ0ZhaWxlZCB0byByZWdpc3RlciBhZHZlcnRpc2VtZW50OiAnICsgc3RyKGVycm9y
KSkKICAgIG1haW5sb29wLnF1aXQoKQoKCgoKCmNsYXNzIEludmFsaWRBcmdzRXhjZXB0aW9uKGRi
dXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vycm9yX25hbWUgPSAnb3Jn
LmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuSW52YWxpZEFyZ3MnCgpjbGFzcyBOb3RTdXBwb3J0ZWRF
eGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAgX2RidXNfZXJyb3Jf
bmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuTm90U3VwcG9ydGVkJwoKY2xhc3MgTm90UGVybWl0dGVk
RXhjZXB0aW9uKGRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uKToKICAgIF9kYnVzX2Vycm9y
X25hbWUgPSAnb3JnLmJsdWV6LkVycm9yLk5vdFBlcm1pdHRlZCcKCmNsYXNzIEludmFsaWRWYWx1
ZUxlbmd0aEV4Y2VwdGlvbihkYnVzLmV4Y2VwdGlvbnMuREJ1c0V4Y2VwdGlvbik6CiAgICBfZGJ1
c19lcnJvcl9uYW1lID0gJ29yZy5ibHVlei5FcnJvci5JbnZhbGlkVmFsdWVMZW5ndGgnCgpjbGFz
cyBGYWlsZWRFeGNlcHRpb24oZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb24pOgogICAgX2Ri
dXNfZXJyb3JfbmFtZSA9ICdvcmcuYmx1ZXouRXJyb3IuRmFpbGVkJwoKCmNsYXNzIEFwcGxpY2F0
aW9uKGRidXMuc2VydmljZS5PYmplY3QpOgogICAgIiIiCiAgICBvcmcuYmx1ZXouR2F0dEFwcGxp
Y2F0aW9uMSBpbnRlcmZhY2UgaW1wbGVtZW50YXRpb24KICAgICIiIgogICAgZGVmIF9faW5pdF9f
KHNlbGYsIGJ1cyk6CiAgICAgICAgc2VsZi5wYXRoID0gJy8nCiAgICAgICAgc2VsZi5zZXJ2aWNl
cyA9IFtdCiAgICAgICAgZGJ1cy5zZXJ2aWNlLk9iamVjdC5fX2luaXRfXyhzZWxmLCBidXMsIHNl
bGYucGF0aCkKICAgICAgICBzZWxmLmFkZF9zZXJ2aWNlKEhlYXJ0UmF0ZVNlcnZpY2UoYnVzLCAw
KSkKICAgICAgICBzZWxmLmFkZF9zZXJ2aWNlKEJhdHRlcnlTZXJ2aWNlKGJ1cywgMSkpCiAgICAg
ICAgc2VsZi5hZGRfc2VydmljZShUZXN0U2VydmljZShidXMsIDIpKQoKICAgIGRlZiBnZXRfcGF0
aChzZWxmKToKICAgICAgICByZXR1cm4gZGJ1cy5PYmplY3RQYXRoKHNlbGYucGF0aCkKCiAgICBk
ZWYgYWRkX3NlcnZpY2Uoc2VsZiwgc2VydmljZSk6CiAgICAgICAgc2VsZi5zZXJ2aWNlcy5hcHBl
bmQoc2VydmljZSkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChEQlVTX09NX0lGQUNFLCBvdXRf
c2lnbmF0dXJlPSdhe29he3Nhe3N2fX19JykKICAgIGRlZiBHZXRNYW5hZ2VkT2JqZWN0cyhzZWxm
KToKICAgICAgICByZXNwb25zZSA9IHt9CiAgICAgICAgcHJpbnQoJ0dldE1hbmFnZWRPYmplY3Rz
JykKCiAgICAgICAgZm9yIHNlcnZpY2UgaW4gc2VsZi5zZXJ2aWNlczoKICAgICAgICAgICAgcmVz
cG9uc2Vbc2VydmljZS5nZXRfcGF0aCgpXSA9IHNlcnZpY2UuZ2V0X3Byb3BlcnRpZXMoKQogICAg
ICAgICAgICBjaHJjcyA9IHNlcnZpY2UuZ2V0X2NoYXJhY3RlcmlzdGljcygpCiAgICAgICAgICAg
IGZvciBjaHJjIGluIGNocmNzOgogICAgICAgICAgICAgICAgcmVzcG9uc2VbY2hyYy5nZXRfcGF0
aCgpXSA9IGNocmMuZ2V0X3Byb3BlcnRpZXMoKQogICAgICAgICAgICAgICAgZGVzY3MgPSBjaHJj
LmdldF9kZXNjcmlwdG9ycygpCiAgICAgICAgICAgICAgICBmb3IgZGVzYyBpbiBkZXNjczoKICAg
ICAgICAgICAgICAgICAgICByZXNwb25zZVtkZXNjLmdldF9wYXRoKCldID0gZGVzYy5nZXRfcHJv
cGVydGllcygpCgogICAgICAgIHJldHVybiByZXNwb25zZQoKCmNsYXNzIFNlcnZpY2UoZGJ1cy5z
ZXJ2aWNlLk9iamVjdCk6CiAgICAiIiIKICAgIG9yZy5ibHVlei5HYXR0U2VydmljZTEgaW50ZXJm
YWNlIGltcGxlbWVudGF0aW9uCiAgICAiIiIKICAgIFBBVEhfQkFTRSA9ICcvb3JnL2JsdWV6L2V4
YW1wbGUvc2VydmljZScKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgdXVpZCwg
cHJpbWFyeSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VsZi5QQVRIX0JBU0UgKyBzdHIoaW5kZXgp
CiAgICAgICAgc2VsZi5idXMgPSBidXMKICAgICAgICBzZWxmLnV1aWQgPSB1dWlkCiAgICAgICAg
c2VsZi5wcmltYXJ5ID0gcHJpbWFyeQogICAgICAgIHNlbGYuY2hhcmFjdGVyaXN0aWNzID0gW10K
ICAgICAgICBkYnVzLnNlcnZpY2UuT2JqZWN0Ll9faW5pdF9fKHNlbGYsIGJ1cywgc2VsZi5wYXRo
KQoKICAgIGRlZiBnZXRfcHJvcGVydGllcyhzZWxmKToKICAgICAgICByZXR1cm4gewogICAgICAg
ICAgICAgICAgR0FUVF9TRVJWSUNFX0lGQUNFOiB7CiAgICAgICAgICAgICAgICAgICAgICAgICdV
VUlEJzogc2VsZi51dWlkLAogICAgICAgICAgICAgICAgICAgICAgICAnUHJpbWFyeSc6IHNlbGYu
cHJpbWFyeSwKICAgICAgICAgICAgICAgICAgICAgICAgJ0NoYXJhY3RlcmlzdGljcyc6IGRidXMu
QXJyYXkoCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VsZi5nZXRfY2hhcmFjdGVy
aXN0aWNfcGF0aHMoKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaWduYXR1cmU9
J28nKQogICAgICAgICAgICAgICAgfQogICAgICAgIH0KCiAgICBkZWYgZ2V0X3BhdGgoc2VsZik6
CiAgICAgICAgcmV0dXJuIGRidXMuT2JqZWN0UGF0aChzZWxmLnBhdGgpCgogICAgZGVmIGFkZF9j
aGFyYWN0ZXJpc3RpYyhzZWxmLCBjaGFyYWN0ZXJpc3RpYyk6CiAgICAgICAgc2VsZi5jaGFyYWN0
ZXJpc3RpY3MuYXBwZW5kKGNoYXJhY3RlcmlzdGljKQoKICAgIGRlZiBnZXRfY2hhcmFjdGVyaXN0
aWNfcGF0aHMoc2VsZik6CiAgICAgICAgcmVzdWx0ID0gW10KICAgICAgICBmb3IgY2hyYyBpbiBz
ZWxmLmNoYXJhY3RlcmlzdGljczoKICAgICAgICAgICAgcmVzdWx0LmFwcGVuZChjaHJjLmdldF9w
YXRoKCkpCiAgICAgICAgcmV0dXJuIHJlc3VsdAoKICAgIGRlZiBnZXRfY2hhcmFjdGVyaXN0aWNz
KHNlbGYpOgogICAgICAgIHJldHVybiBzZWxmLmNoYXJhY3RlcmlzdGljcwoKICAgIEBkYnVzLnNl
cnZpY2UubWV0aG9kKERCVVNfUFJPUF9JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgIGlu
X3NpZ25hdHVyZT0ncycsCiAgICAgICAgICAgICAgICAgICAgICAgICBvdXRfc2lnbmF0dXJlPSdh
e3N2fScpCiAgICBkZWYgR2V0QWxsKHNlbGYsIGludGVyZmFjZSk6CiAgICAgICAgaWYgaW50ZXJm
YWNlICE9IEdBVFRfU0VSVklDRV9JRkFDRToKICAgICAgICAgICAgcmFpc2UgSW52YWxpZEFyZ3NF
eGNlcHRpb24oKQoKICAgICAgICByZXR1cm4gc2VsZi5nZXRfcHJvcGVydGllcygpW0dBVFRfU0VS
VklDRV9JRkFDRV0KCgpjbGFzcyBDaGFyYWN0ZXJpc3RpYyhkYnVzLnNlcnZpY2UuT2JqZWN0KToK
ICAgICIiIgogICAgb3JnLmJsdWV6LkdhdHRDaGFyYWN0ZXJpc3RpYzEgaW50ZXJmYWNlIGltcGxl
bWVudGF0aW9uCiAgICAiIiIKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCB1dWlk
LCBmbGFncywgc2VydmljZSk6CiAgICAgICAgc2VsZi5wYXRoID0gc2VydmljZS5wYXRoICsgJy9j
aGFyJyArIHN0cihpbmRleCkKICAgICAgICBzZWxmLmJ1cyA9IGJ1cwogICAgICAgIHNlbGYudXVp
ZCA9IHV1aWQKICAgICAgICBzZWxmLnNlcnZpY2UgPSBzZXJ2aWNlCiAgICAgICAgc2VsZi5mbGFn
cyA9IGZsYWdzCiAgICAgICAgc2VsZi5kZXNjcmlwdG9ycyA9IFtdCiAgICAgICAgZGJ1cy5zZXJ2
aWNlLk9iamVjdC5fX2luaXRfXyhzZWxmLCBidXMsIHNlbGYucGF0aCkKCiAgICBkZWYgZ2V0X3By
b3BlcnRpZXMoc2VsZik6CiAgICAgICAgcmV0dXJuIHsKICAgICAgICAgICAgICAgIEdBVFRfQ0hS
Q19JRkFDRTogewogICAgICAgICAgICAgICAgICAgICAgICAnU2VydmljZSc6IHNlbGYuc2Vydmlj
ZS5nZXRfcGF0aCgpLAogICAgICAgICAgICAgICAgICAgICAgICAnVVVJRCc6IHNlbGYudXVpZCwK
ICAgICAgICAgICAgICAgICAgICAgICAgJ0ZsYWdzJzogc2VsZi5mbGFncywKICAgICAgICAgICAg
ICAgICAgICAgICAgJ0Rlc2NyaXB0b3JzJzogZGJ1cy5BcnJheSgKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzZWxmLmdldF9kZXNjcmlwdG9yX3BhdGhzKCksCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2lnbmF0dXJlPSdvJykKICAgICAgICAgICAgICAgIH0KICAgICAg
ICB9CgogICAgZGVmIGdldF9wYXRoKHNlbGYpOgogICAgICAgIHJldHVybiBkYnVzLk9iamVjdFBh
dGgoc2VsZi5wYXRoKQoKICAgIGRlZiBhZGRfZGVzY3JpcHRvcihzZWxmLCBkZXNjcmlwdG9yKToK
ICAgICAgICBzZWxmLmRlc2NyaXB0b3JzLmFwcGVuZChkZXNjcmlwdG9yKQoKICAgIGRlZiBnZXRf
ZGVzY3JpcHRvcl9wYXRocyhzZWxmKToKICAgICAgICByZXN1bHQgPSBbXQogICAgICAgIGZvciBk
ZXNjIGluIHNlbGYuZGVzY3JpcHRvcnM6CiAgICAgICAgICAgIHJlc3VsdC5hcHBlbmQoZGVzYy5n
ZXRfcGF0aCgpKQogICAgICAgIHJldHVybiByZXN1bHQKCiAgICBkZWYgZ2V0X2Rlc2NyaXB0b3Jz
KHNlbGYpOgogICAgICAgIHJldHVybiBzZWxmLmRlc2NyaXB0b3JzCgogICAgQGRidXMuc2Vydmlj
ZS5tZXRob2QoREJVU19QUk9QX0lGQUNFLAogICAgICAgICAgICAgICAgICAgICAgICAgaW5fc2ln
bmF0dXJlPSdzJywKICAgICAgICAgICAgICAgICAgICAgICAgIG91dF9zaWduYXR1cmU9J2F7c3Z9
JykKICAgIGRlZiBHZXRBbGwoc2VsZiwgaW50ZXJmYWNlKToKICAgICAgICBpZiBpbnRlcmZhY2Ug
IT0gR0FUVF9DSFJDX0lGQUNFOgogICAgICAgICAgICByYWlzZSBJbnZhbGlkQXJnc0V4Y2VwdGlv
bigpCgogICAgICAgIHJldHVybiBzZWxmLmdldF9wcm9wZXJ0aWVzKClbR0FUVF9DSFJDX0lGQUNF
XQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRfQ0hSQ19JRkFDRSwKICAgICAgICAgICAg
ICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdhe3N2fScsCiAgICAgICAgICAgICAgICAgICAgICAg
IG91dF9zaWduYXR1cmU9J2F5JykKICAgIGRlZiBSZWFkVmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAg
ICAgICAgcHJpbnQoJ0RlZmF1bHQgUmVhZFZhbHVlIGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykK
ICAgICAgICByYWlzZSBOb3RTdXBwb3J0ZWRFeGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2Uu
bWV0aG9kKEdBVFRfQ0hSQ19JRkFDRSwgaW5fc2lnbmF0dXJlPSdheWF7c3Z9JykKICAgIGRlZiBX
cml0ZVZhbHVlKHNlbGYsIHZhbHVlLCBvcHRpb25zKToKICAgICAgICBwcmludCgnRGVmYXVsdCBX
cml0ZVZhbHVlIGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykKICAgICAgICByYWlzZSBOb3RTdXBw
b3J0ZWRFeGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRfQ0hSQ19JRkFD
RSkKICAgIGRlZiBTdGFydE5vdGlmeShzZWxmKToKICAgICAgICBwcmludCgnRGVmYXVsdCBTdGFy
dE5vdGlmeSBjYWxsZWQsIHJldHVybmluZyBlcnJvcicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9y
dGVkRXhjZXB0aW9uKCkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChHQVRUX0NIUkNfSUZBQ0Up
CiAgICBkZWYgU3RvcE5vdGlmeShzZWxmKToKICAgICAgICBwcmludCgnRGVmYXVsdCBTdG9wTm90
aWZ5IGNhbGxlZCwgcmV0dXJuaW5nIGVycm9yJykKICAgICAgICByYWlzZSBOb3RTdXBwb3J0ZWRF
eGNlcHRpb24oKQoKICAgIEBkYnVzLnNlcnZpY2Uuc2lnbmFsKERCVVNfUFJPUF9JRkFDRSwKICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpZ25hdHVyZT0nc2F7c3Z9YXMnKQogICAgZGVmIFByb3Bl
cnRpZXNDaGFuZ2VkKHNlbGYsIGludGVyZmFjZSwgY2hhbmdlZCwgaW52YWxpZGF0ZWQpOgogICAg
ICAgIHBhc3MKCgpjbGFzcyBEZXNjcmlwdG9yKGRidXMuc2VydmljZS5PYmplY3QpOgogICAgIiIi
CiAgICBvcmcuYmx1ZXouR2F0dERlc2NyaXB0b3IxIGludGVyZmFjZSBpbXBsZW1lbnRhdGlvbgog
ICAgIiIiCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgdXVpZCwgZmxhZ3MsIGNo
YXJhY3RlcmlzdGljKToKICAgICAgICBzZWxmLnBhdGggPSBjaGFyYWN0ZXJpc3RpYy5wYXRoICsg
Jy9kZXNjJyArIHN0cihpbmRleCkKICAgICAgICBzZWxmLmJ1cyA9IGJ1cwogICAgICAgIHNlbGYu
dXVpZCA9IHV1aWQKICAgICAgICBzZWxmLmZsYWdzID0gZmxhZ3MKICAgICAgICBzZWxmLmNocmMg
PSBjaGFyYWN0ZXJpc3RpYwogICAgICAgIGRidXMuc2VydmljZS5PYmplY3QuX19pbml0X18oc2Vs
ZiwgYnVzLCBzZWxmLnBhdGgpCgogICAgZGVmIGdldF9wcm9wZXJ0aWVzKHNlbGYpOgogICAgICAg
IHJldHVybiB7CiAgICAgICAgICAgICAgICBHQVRUX0RFU0NfSUZBQ0U6IHsKICAgICAgICAgICAg
ICAgICAgICAgICAgJ0NoYXJhY3RlcmlzdGljJzogc2VsZi5jaHJjLmdldF9wYXRoKCksCiAgICAg
ICAgICAgICAgICAgICAgICAgICdVVUlEJzogc2VsZi51dWlkLAogICAgICAgICAgICAgICAgICAg
ICAgICAnRmxhZ3MnOiBzZWxmLmZsYWdzLAogICAgICAgICAgICAgICAgfQogICAgICAgIH0KCiAg
ICBkZWYgZ2V0X3BhdGgoc2VsZik6CiAgICAgICAgcmV0dXJuIGRidXMuT2JqZWN0UGF0aChzZWxm
LnBhdGgpCgogICAgQGRidXMuc2VydmljZS5tZXRob2QoREJVU19QUk9QX0lGQUNFLAogICAgICAg
ICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdzJywKICAgICAgICAgICAgICAgICAgICAg
ICAgIG91dF9zaWduYXR1cmU9J2F7c3Z9JykKICAgIGRlZiBHZXRBbGwoc2VsZiwgaW50ZXJmYWNl
KToKICAgICAgICBpZiBpbnRlcmZhY2UgIT0gR0FUVF9ERVNDX0lGQUNFOgogICAgICAgICAgICBy
YWlzZSBJbnZhbGlkQXJnc0V4Y2VwdGlvbigpCgogICAgICAgIHJldHVybiBzZWxmLmdldF9wcm9w
ZXJ0aWVzKClbR0FUVF9ERVNDX0lGQUNFXQoKICAgIEBkYnVzLnNlcnZpY2UubWV0aG9kKEdBVFRf
REVTQ19JRkFDRSwKICAgICAgICAgICAgICAgICAgICAgICAgaW5fc2lnbmF0dXJlPSdhe3N2fScs
CiAgICAgICAgICAgICAgICAgICAgICAgIG91dF9zaWduYXR1cmU9J2F5JykKICAgIGRlZiBSZWFk
VmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQgKCdEZWZhdWx0IFJlYWRWYWx1ZSBj
YWxsZWQsIHJldHVybmluZyBlcnJvcicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9ydGVkRXhjZXB0
aW9uKCkKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhvZChHQVRUX0RFU0NfSUZBQ0UsIGluX3NpZ25h
dHVyZT0nYXlhe3N2fScpCiAgICBkZWYgV3JpdGVWYWx1ZShzZWxmLCB2YWx1ZSwgb3B0aW9ucyk6
CiAgICAgICAgcHJpbnQoJ0RlZmF1bHQgV3JpdGVWYWx1ZSBjYWxsZWQsIHJldHVybmluZyBlcnJv
cicpCiAgICAgICAgcmFpc2UgTm90U3VwcG9ydGVkRXhjZXB0aW9uKCkKCgpjbGFzcyBIZWFydFJh
dGVTZXJ2aWNlKFNlcnZpY2UpOgogICAgIiIiCiAgICBGYWtlIEhlYXJ0IFJhdGUgU2VydmljZSB0
aGF0IHNpbXVsYXRlcyBhIGZha2UgaGVhcnQgYmVhdCBhbmQgY29udHJvbCBwb2ludAogICAgYmVo
YXZpb3IuCgogICAgIiIiCiAgICBIUl9VVUlEID0gJzAwMDAxODBkLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYicKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCk6CiAgICAgICAg
U2VydmljZS5fX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBzZWxmLkhSX1VVSUQsIFRydWUpCiAg
ICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoSGVhcnRSYXRlTWVhc3VyZW1lbnRDaHJjKGJ1
cywgMCwgc2VsZikpCiAgICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoQm9keVNlbnNvckxv
Y2F0aW9uQ2hyYyhidXMsIDEsIHNlbGYpKQogICAgICAgIHNlbGYuYWRkX2NoYXJhY3RlcmlzdGlj
KEhlYXJ0UmF0ZUNvbnRyb2xQb2ludENocmMoYnVzLCAyLCBzZWxmKSkKICAgICAgICBzZWxmLmVu
ZXJneV9leHBlbmRlZCA9IDAKCgpjbGFzcyBIZWFydFJhdGVNZWFzdXJlbWVudENocmMoQ2hhcmFj
dGVyaXN0aWMpOgogICAgSFJfTVNSTVRfVVVJRCA9ICcwMDAwMmEzNy0wMDAwLTEwMDAtODAwMC0w
MDgwNWY5YjM0ZmInCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgsIHNlcnZpY2Up
OgogICAgICAgIENoYXJhY3RlcmlzdGljLl9faW5pdF9fKAogICAgICAgICAgICAgICAgc2VsZiwg
YnVzLCBpbmRleCwKICAgICAgICAgICAgICAgIHNlbGYuSFJfTVNSTVRfVVVJRCwKICAgICAgICAg
ICAgICAgIFsncmVhZCcsICdub3RpZnknXSwKICAgICAgICAgICAgICAgIHNlcnZpY2UpCiAgICAg
ICAgc2VsZi5ub3RpZnlpbmcgPSBGYWxzZQogICAgICAgIHNlbGYuaHJfZWVfY291bnQgPSAwCiAg
ICAgICAgCgogICAgZGVmIFJlYWRWYWx1ZShzZWxmLCBvcHRpb25zKToKICAgICAgICBwcmludCgn
SGVhcnRSYXRlTWVhc3VyZW1lbnRDaHJjIFJlYWQnKQogICAgICAgIHJldHVybiBbZGJ1cy5CeXRl
KDYpLCBkYnVzLkJ5dGUoOTkpXQoKCiAgICBkZWYgaHJfbXNybXRfY2Ioc2VsZik6CiAgICAgICAg
dmFsdWUgPSBbXQogICAgICAgIHZhbHVlLmFwcGVuZChkYnVzLkJ5dGUoMHgwNikpCgogICAgICAg
IHZhbHVlLmFwcGVuZChkYnVzLkJ5dGUocmFuZGludCg5MCwgMTMwKSkpCgogICAgICAgIGlmIHNl
bGYuaHJfZWVfY291bnQgJSAxMCA9PSAwOgogICAgICAgICAgICB2YWx1ZVswXSA9IGRidXMuQnl0
ZSh2YWx1ZVswXSB8IDB4MDgpCiAgICAgICAgICAgIHZhbHVlLmFwcGVuZChkYnVzLkJ5dGUoc2Vs
Zi5zZXJ2aWNlLmVuZXJneV9leHBlbmRlZCAmIDB4ZmYpKQogICAgICAgICAgICB2YWx1ZS5hcHBl
bmQoZGJ1cy5CeXRlKChzZWxmLnNlcnZpY2UuZW5lcmd5X2V4cGVuZGVkID4+IDgpICYgMHhmZikp
CgogICAgICAgIHNlbGYuc2VydmljZS5lbmVyZ3lfZXhwZW5kZWQgPSBcCiAgICAgICAgICAgICAg
ICBtaW4oMHhmZmZmLCBzZWxmLnNlcnZpY2UuZW5lcmd5X2V4cGVuZGVkICsgMSkKICAgICAgICBz
ZWxmLmhyX2VlX2NvdW50ICs9IDEKCiAgICAgICAgcHJpbnQoJ1VwZGF0aW5nIHZhbHVlOiAnICsg
cmVwcih2YWx1ZSkpCgogICAgICAgIHNlbGYuUHJvcGVydGllc0NoYW5nZWQoR0FUVF9DSFJDX0lG
QUNFLCB7ICdWYWx1ZSc6IHZhbHVlIH0sIFtdKQoKICAgICAgICByZXR1cm4gc2VsZi5ub3RpZnlp
bmcKCiAgICBkZWYgX3VwZGF0ZV9ocl9tc3JtdF9zaW11bGF0aW9uKHNlbGYpOgogICAgICAgIHBy
aW50KCdVcGRhdGUgSFIgTWVhc3VyZW1lbnQgU2ltdWxhdGlvbicpCgogICAgICAgIGlmIG5vdCBz
ZWxmLm5vdGlmeWluZzoKICAgICAgICAgICAgcmV0dXJuCgogICAgICAgIEdPYmplY3QudGltZW91
dF9hZGQoMTAwMCwgc2VsZi5ocl9tc3JtdF9jYikKCiAgICBkZWYgU3RhcnROb3RpZnkoc2VsZik6
CiAgICAgICAgaWYgc2VsZi5ub3RpZnlpbmc6CiAgICAgICAgICAgIHByaW50KCdBbHJlYWR5IG5v
dGlmeWluZywgbm90aGluZyB0byBkbycpCiAgICAgICAgICAgIHJldHVybgoKICAgICAgICBzZWxm
Lm5vdGlmeWluZyA9IFRydWUKICAgICAgICBzZWxmLl91cGRhdGVfaHJfbXNybXRfc2ltdWxhdGlv
bigpCgogICAgZGVmIFN0b3BOb3RpZnkoc2VsZik6CiAgICAgICAgaWYgbm90IHNlbGYubm90aWZ5
aW5nOgogICAgICAgICAgICBwcmludCgnTm90IG5vdGlmeWluZywgbm90aGluZyB0byBkbycpCiAg
ICAgICAgICAgIHJldHVybgoKICAgICAgICBzZWxmLm5vdGlmeWluZyA9IEZhbHNlCiAgICAgICAg
c2VsZi5fdXBkYXRlX2hyX21zcm10X3NpbXVsYXRpb24oKQoKCmNsYXNzIEJvZHlTZW5zb3JMb2Nh
dGlvbkNocmMoQ2hhcmFjdGVyaXN0aWMpOgogICAgQk9EWV9TTlNSX0xPQ19VVUlEID0gJzAwMDAy
YTM4LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYicKCiAgICBkZWYgX19pbml0X18oc2VsZiwg
YnVzLCBpbmRleCwgc2VydmljZSk6CiAgICAgICAgQ2hhcmFjdGVyaXN0aWMuX19pbml0X18oCiAg
ICAgICAgICAgICAgICBzZWxmLCBidXMsIGluZGV4LAogICAgICAgICAgICAgICAgc2VsZi5CT0RZ
X1NOU1JfTE9DX1VVSUQsCiAgICAgICAgICAgICAgICBbJ3JlYWQnLCAnbm90aWZ5J10sCiAgICAg
ICAgICAgICAgICBzZXJ2aWNlKQogICAgICAgIHNlbGYubm90aWZ5aW5nID0gRmFsc2UKICAgICAg
ICBzZWxmLnZhbHVlID0gWzB4MDFdCgogICAgZGVmIFJlYWRWYWx1ZShzZWxmLCBvcHRpb25zKToK
ICAgICAgICAjIFJldHVybiAnQ2hlc3QnIGFzIHRoZSBzZW5zb3IgbG9jYXRpb24uCiAgICAgICAg
cmV0dXJuIFsgMHgwMiBdCgoKICAgIGRlZiBfY2Ioc2VsZik6CiAgICAgICAgdmFsdWUgPSBbXQoK
ICAgICAgICB2YWx1ZS5hcHBlbmQoZGJ1cy5CeXRlKHJhbmRpbnQoMSwgMykpKQoKICAgICAgICBw
cmludCgnVXBkYXRpbmcgdmFsdWU6ICcgKyByZXByKHZhbHVlKSkKCiAgICAgICAgc2VsZi5Qcm9w
ZXJ0aWVzQ2hhbmdlZChHQVRUX0NIUkNfSUZBQ0UsIHsgJ1ZhbHVlJzogdmFsdWUgfSwgW10pCgog
ICAgICAgIHJldHVybiBzZWxmLm5vdGlmeWluZwoKICAgIGRlZiBfdXBkYXRlX3NpbXVsYXRpb24o
c2VsZik6CiAgICAgICAgcHJpbnQoJ1VwZGF0ZSBTaW11bGF0aW9uJykKCiAgICAgICAgaWYgbm90
IHNlbGYubm90aWZ5aW5nOgogICAgICAgICAgICByZXR1cm4KCiAgICAgICAgR09iamVjdC50aW1l
b3V0X2FkZCgxMDAwLCBzZWxmLl9jYikKCiAgICBkZWYgU3RhcnROb3RpZnkoc2VsZik6CiAgICAg
ICAgaWYgc2VsZi5ub3RpZnlpbmc6CiAgICAgICAgICAgIHByaW50KCdBbHJlYWR5IG5vdGlmeWlu
Zywgbm90aGluZyB0byBkbycpCiAgICAgICAgICAgIHJldHVybgoKICAgICAgICBzZWxmLm5vdGlm
eWluZyA9IFRydWUKICAgICAgICBzZWxmLl91cGRhdGVfc2ltdWxhdGlvbigpCgogICAgZGVmIFN0
b3BOb3RpZnkoc2VsZik6CiAgICAgICAgaWYgbm90IHNlbGYubm90aWZ5aW5nOgogICAgICAgICAg
ICBwcmludCgnTm90IG5vdGlmeWluZywgbm90aGluZyB0byBkbycpCiAgICAgICAgICAgIHJldHVy
bgoKICAgICAgICBzZWxmLm5vdGlmeWluZyA9IEZhbHNlCiAgICAgICAgc2VsZi5fdXBkYXRlX3Np
bXVsYXRpb24oKQoKCmNsYXNzIEhlYXJ0UmF0ZUNvbnRyb2xQb2ludENocmMoQ2hhcmFjdGVyaXN0
aWMpOgogICAgSFJfQ1RSTF9QVF9VVUlEID0gJzAwMDAyYTM5LTAwMDAtMTAwMC04MDAwLTAwODA1
ZjliMzRmYicKCiAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgc2VydmljZSk6CiAg
ICAgICAgQ2hhcmFjdGVyaXN0aWMuX19pbml0X18oCiAgICAgICAgICAgICAgICBzZWxmLCBidXMs
IGluZGV4LAogICAgICAgICAgICAgICAgc2VsZi5IUl9DVFJMX1BUX1VVSUQsCiAgICAgICAgICAg
ICAgICBbJ3dyaXRlJ10sCiAgICAgICAgICAgICAgICBzZXJ2aWNlKQoKICAgIGRlZiBXcml0ZVZh
bHVlKHNlbGYsIHZhbHVlLCBvcHRpb25zKToKICAgICAgICBwcmludCgnSGVhcnQgUmF0ZSBDb250
cm9sIFBvaW50IFdyaXRlVmFsdWUgY2FsbGVkJykKCiAgICAgICAgaWYgbGVuKHZhbHVlKSAhPSAx
OgogICAgICAgICAgICByYWlzZSBJbnZhbGlkVmFsdWVMZW5ndGhFeGNlcHRpb24oKQoKICAgICAg
ICBieXRlID0gdmFsdWVbMF0KICAgICAgICBwcmludCgnQ29udHJvbCBQb2ludCB2YWx1ZTogJyAr
IHJlcHIoYnl0ZSkpCgogICAgICAgIGlmIGJ5dGUgIT0gMToKICAgICAgICAgICAgcmFpc2UgRmFp
bGVkRXhjZXB0aW9uKCIweDgwIikKCiAgICAgICAgcHJpbnQoJ0VuZXJneSBFeHBlbmRlZCBmaWVs
ZCByZXNldCEnKQogICAgICAgIHNlbGYuc2VydmljZS5lbmVyZ3lfZXhwZW5kZWQgPSAwCgoKY2xh
c3MgQmF0dGVyeVNlcnZpY2UoU2VydmljZSk6CiAgICAiIiIKICAgIEZha2UgQmF0dGVyeSBzZXJ2
aWNlIHRoYXQgZW11bGF0ZXMgYSBkcmFpbmluZyBiYXR0ZXJ5LgoKICAgICIiIgogICAgQkFUVEVS
WV9VVUlEID0gJzE4MGYnCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgpOgogICAg
ICAgIFNlcnZpY2UuX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgc2VsZi5CQVRURVJZX1VVSUQs
IFRydWUpCiAgICAgICAgc2VsZi5hZGRfY2hhcmFjdGVyaXN0aWMoQmF0dGVyeUxldmVsQ2hhcmFj
dGVyaXN0aWMoYnVzLCAwLCBzZWxmKSkKCgpjbGFzcyBCYXR0ZXJ5TGV2ZWxDaGFyYWN0ZXJpc3Rp
YyhDaGFyYWN0ZXJpc3RpYyk6CiAgICAiIiIKICAgIEZha2UgQmF0dGVyeSBMZXZlbCBjaGFyYWN0
ZXJpc3RpYy4gVGhlIGJhdHRlcnkgbGV2ZWwgaXMgZHJhaW5lZCBieSAyIHBvaW50cwogICAgZXZl
cnkgNSBzZWNvbmRzLgoKICAgICIiIgogICAgQkFUVEVSWV9MVkxfVVVJRCA9ICcyYTE5JwoKICAg
IGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBzZXJ2aWNlKToKICAgICAgICBDaGFyYWN0
ZXJpc3RpYy5fX2luaXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAgICAg
ICAgICAgICAgICBzZWxmLkJBVFRFUllfTFZMX1VVSUQsCiAgICAgICAgICAgICAgICBbJ3JlYWQn
LCAnbm90aWZ5J10sCiAgICAgICAgICAgICAgICBzZXJ2aWNlKQogICAgICAgIHNlbGYubm90aWZ5
aW5nID0gRmFsc2UKICAgICAgICBzZWxmLmJhdHRlcnlfbHZsID0gMTAwCiAgICAgICAgR09iamVj
dC50aW1lb3V0X2FkZCg1MDAwLCBzZWxmLmRyYWluX2JhdHRlcnkpCgogICAgZGVmIG5vdGlmeV9i
YXR0ZXJ5X2xldmVsKHNlbGYpOgogICAgICAgIGlmIG5vdCBzZWxmLm5vdGlmeWluZzoKICAgICAg
ICAgICAgcmV0dXJuCiAgICAgICAgc2VsZi5Qcm9wZXJ0aWVzQ2hhbmdlZCgKICAgICAgICAgICAg
ICAgIEdBVFRfQ0hSQ19JRkFDRSwKICAgICAgICAgICAgICAgIHsgJ1ZhbHVlJzogW2RidXMuQnl0
ZShzZWxmLmJhdHRlcnlfbHZsKV0gfSwgW10pCgogICAgZGVmIGRyYWluX2JhdHRlcnkoc2VsZik6
CiAgICAgICAgaWYgbm90IHNlbGYubm90aWZ5aW5nOgogICAgICAgICAgICByZXR1cm4gVHJ1ZQog
ICAgICAgIGlmIHNlbGYuYmF0dGVyeV9sdmwgPiAwOgogICAgICAgICAgICBzZWxmLmJhdHRlcnlf
bHZsIC09IDIKICAgICAgICAgICAgaWYgc2VsZi5iYXR0ZXJ5X2x2bCA8IDA6CiAgICAgICAgICAg
ICAgICBzZWxmLmJhdHRlcnlfbHZsID0gMAogICAgICAgIHByaW50KCdCYXR0ZXJ5IExldmVsIGRy
YWluZWQ6ICcgKyByZXByKHNlbGYuYmF0dGVyeV9sdmwpKQogICAgICAgIHNlbGYubm90aWZ5X2Jh
dHRlcnlfbGV2ZWwoKQogICAgICAgIHJldHVybiBUcnVlCgogICAgZGVmIFJlYWRWYWx1ZShzZWxm
LCBvcHRpb25zKToKICAgICAgICBwcmludCgnQmF0dGVyeSBMZXZlbCByZWFkOiAnICsgcmVwcihz
ZWxmLmJhdHRlcnlfbHZsKSkKICAgICAgICByZXR1cm4gW2RidXMuQnl0ZShzZWxmLmJhdHRlcnlf
bHZsKV0KCiAgICBkZWYgU3RhcnROb3RpZnkoc2VsZik6CiAgICAgICAgaWYgc2VsZi5ub3RpZnlp
bmc6CiAgICAgICAgICAgIHByaW50KCdBbHJlYWR5IG5vdGlmeWluZywgbm90aGluZyB0byBkbycp
CiAgICAgICAgICAgIHJldHVybgoKICAgICAgICBzZWxmLm5vdGlmeWluZyA9IFRydWUKICAgICAg
ICBzZWxmLm5vdGlmeV9iYXR0ZXJ5X2xldmVsKCkKCiAgICBkZWYgU3RvcE5vdGlmeShzZWxmKToK
ICAgICAgICBpZiBub3Qgc2VsZi5ub3RpZnlpbmc6CiAgICAgICAgICAgIHByaW50KCdOb3Qgbm90
aWZ5aW5nLCBub3RoaW5nIHRvIGRvJykKICAgICAgICAgICAgcmV0dXJuCgogICAgICAgIHNlbGYu
bm90aWZ5aW5nID0gRmFsc2UKCgpjbGFzcyBUZXN0U2VydmljZShTZXJ2aWNlKToKICAgICIiIgog
ICAgRHVtbXkgdGVzdCBzZXJ2aWNlIHRoYXQgcHJvdmlkZXMgY2hhcmFjdGVyaXN0aWNzIGFuZCBk
ZXNjcmlwdG9ycyB0aGF0CiAgICBleGVyY2lzZSB2YXJpb3VzIEFQSSBmdW5jdGlvbmFsaXR5LgoK
ICAgICIiIgogICAgVEVTVF9TVkNfVVVJRCA9ICcxMjM0NTY3OC0xMjM0LTU2NzgtMTIzNC01Njc4
OWFiY2RlZjAnCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgpOgogICAgICAgIFNl
cnZpY2UuX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCwgc2VsZi5URVNUX1NWQ19VVUlELCBUcnVl
KQogICAgICAgIHNlbGYuYWRkX2NoYXJhY3RlcmlzdGljKFRlc3RDaGFyYWN0ZXJpc3RpYyhidXMs
IDAsIHNlbGYpKQogICAgICAgIHNlbGYuYWRkX2NoYXJhY3RlcmlzdGljKFRlc3RFbmNyeXB0Q2hh
cmFjdGVyaXN0aWMoYnVzLCAxLCBzZWxmKSkKICAgICAgICBzZWxmLmFkZF9jaGFyYWN0ZXJpc3Rp
YyhUZXN0U2VjdXJlQ2hhcmFjdGVyaXN0aWMoYnVzLCAyLCBzZWxmKSkKCmNsYXNzIFRlc3RDaGFy
YWN0ZXJpc3RpYyhDaGFyYWN0ZXJpc3RpYyk6CiAgICAiIiIKICAgIER1bW15IHRlc3QgY2hhcmFj
dGVyaXN0aWMuIEFsbG93cyB3cml0aW5nIGFyYml0cmFyeSBieXRlcyB0byBpdHMgdmFsdWUsIGFu
ZAogICAgY29udGFpbnMgImV4dGVuZGVkIHByb3BlcnRpZXMiLCBhcyB3ZWxsIGFzIGEgdGVzdCBk
ZXNjcmlwdG9yLgoKICAgICIiIgogICAgVEVTVF9DSFJDX1VVSUQgPSAnMTIzNDU2NzgtMTIzNC01
Njc4LTEyMzQtNTY3ODlhYmNkZWYxJwoKICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4
LCBzZXJ2aWNlKToKICAgICAgICBDaGFyYWN0ZXJpc3RpYy5fX2luaXRfXygKICAgICAgICAgICAg
ICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAgICAgICAgICAgICAgICBzZWxmLlRFU1RfQ0hSQ19VVUlE
LAogICAgICAgICAgICAgICAgWydyZWFkJywgJ3dyaXRlJywgJ3dyaXRhYmxlLWF1eGlsaWFyaWVz
J10sCiAgICAgICAgICAgICAgICBzZXJ2aWNlKQogICAgICAgIHNlbGYudmFsdWUgPSBbXQogICAg
ICAgIHNlbGYuYWRkX2Rlc2NyaXB0b3IoVGVzdERlc2NyaXB0b3IoYnVzLCAwLCBzZWxmKSkKICAg
ICAgICBzZWxmLmFkZF9kZXNjcmlwdG9yKAogICAgICAgICAgICAgICAgQ2hhcmFjdGVyaXN0aWNV
c2VyRGVzY3JpcHRpb25EZXNjcmlwdG9yKGJ1cywgMSwgc2VsZikpCgogICAgZGVmIFJlYWRWYWx1
ZShzZWxmLCBvcHRpb25zKToKICAgICAgICBwcmludCgnVGVzdENoYXJhY3RlcmlzdGljIFJlYWQ6
ICcgKyByZXByKHNlbGYudmFsdWUpKQogICAgICAgIHJldHVybiBzZWxmLnZhbHVlCgogICAgZGVm
IFdyaXRlVmFsdWUoc2VsZiwgdmFsdWUsIG9wdGlvbnMpOgogICAgICAgIHByaW50KCdUZXN0Q2hh
cmFjdGVyaXN0aWMgV3JpdGU6ICcgKyByZXByKHZhbHVlKSkKICAgICAgICBzZWxmLnZhbHVlID0g
dmFsdWUKCgpjbGFzcyBUZXN0RGVzY3JpcHRvcihEZXNjcmlwdG9yKToKICAgICIiIgogICAgRHVt
bXkgdGVzdCBkZXNjcmlwdG9yLiBSZXR1cm5zIGEgc3RhdGljIHZhbHVlLgoKICAgICIiIgogICAg
VEVTVF9ERVNDX1VVSUQgPSAnMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWYyJwoK
ICAgIGRlZiBfX2luaXRfXyhzZWxmLCBidXMsIGluZGV4LCBjaGFyYWN0ZXJpc3RpYyk6CiAgICAg
ICAgRGVzY3JpcHRvci5fX2luaXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgs
CiAgICAgICAgICAgICAgICBzZWxmLlRFU1RfREVTQ19VVUlELAogICAgICAgICAgICAgICAgWydy
ZWFkJywgJ3dyaXRlJ10sCiAgICAgICAgICAgICAgICBjaGFyYWN0ZXJpc3RpYykKCiAgICBkZWYg
UmVhZFZhbHVlKHNlbGYsIG9wdGlvbnMpOgogICAgICAgIHJldHVybiBbCiAgICAgICAgICAgICAg
ICBkYnVzLkJ5dGUoJ1QnKSwgZGJ1cy5CeXRlKCdlJyksIGRidXMuQnl0ZSgncycpLCBkYnVzLkJ5
dGUoJ3QnKQogICAgICAgIF0KCgpjbGFzcyBDaGFyYWN0ZXJpc3RpY1VzZXJEZXNjcmlwdGlvbkRl
c2NyaXB0b3IoRGVzY3JpcHRvcik6CiAgICAiIiIKICAgIFdyaXRhYmxlIENVRCBkZXNjcmlwdG9y
LgoKICAgICIiIgogICAgQ1VEX1VVSUQgPSAnMjkwMScKCiAgICBkZWYgX19pbml0X18oc2VsZiwg
YnVzLCBpbmRleCwgY2hhcmFjdGVyaXN0aWMpOgogICAgICAgIHNlbGYud3JpdGFibGUgPSAnd3Jp
dGFibGUtYXV4aWxpYXJpZXMnIGluIGNoYXJhY3RlcmlzdGljLmZsYWdzCiAgICAgICAgc2VsZi52
YWx1ZSA9IGFycmF5LmFycmF5KCdCJywgYidUaGlzIGlzIGEgY2hhcmFjdGVyaXN0aWMgZm9yIHRl
c3RpbmcnKQogICAgICAgIHNlbGYudmFsdWUgPSBzZWxmLnZhbHVlLnRvbGlzdCgpCiAgICAgICAg
RGVzY3JpcHRvci5fX2luaXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAg
ICAgICAgICAgICAgICBzZWxmLkNVRF9VVUlELAogICAgICAgICAgICAgICAgWydyZWFkJywgJ3dy
aXRlJ10sCiAgICAgICAgICAgICAgICBjaGFyYWN0ZXJpc3RpYykKCiAgICBkZWYgUmVhZFZhbHVl
KHNlbGYsIG9wdGlvbnMpOgogICAgICAgIHJldHVybiBzZWxmLnZhbHVlCgogICAgZGVmIFdyaXRl
VmFsdWUoc2VsZiwgdmFsdWUsIG9wdGlvbnMpOgogICAgICAgIGlmIG5vdCBzZWxmLndyaXRhYmxl
OgogICAgICAgICAgICByYWlzZSBOb3RQZXJtaXR0ZWRFeGNlcHRpb24oKQogICAgICAgIHNlbGYu
dmFsdWUgPSB2YWx1ZQoKY2xhc3MgVGVzdEVuY3J5cHRDaGFyYWN0ZXJpc3RpYyhDaGFyYWN0ZXJp
c3RpYyk6CiAgICAiIiIKICAgIER1bW15IHRlc3QgY2hhcmFjdGVyaXN0aWMgcmVxdWlyaW5nIGVu
Y3J5cHRpb24uCgogICAgIiIiCiAgICBURVNUX0NIUkNfVVVJRCA9ICcxMjM0NTY3OC0xMjM0LTU2
NzgtMTIzNC01Njc4OWFiY2RlZjMnCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgs
IHNlcnZpY2UpOgogICAgICAgIENoYXJhY3RlcmlzdGljLl9faW5pdF9fKAogICAgICAgICAgICAg
ICAgc2VsZiwgYnVzLCBpbmRleCwKICAgICAgICAgICAgICAgIHNlbGYuVEVTVF9DSFJDX1VVSUQs
CiAgICAgICAgICAgICAgICBbJ2VuY3J5cHQtcmVhZCcsICdlbmNyeXB0LXdyaXRlJ10sCiAgICAg
ICAgICAgICAgICBzZXJ2aWNlKQogICAgICAgIHNlbGYudmFsdWUgPSBbXQogICAgICAgIHNlbGYu
YWRkX2Rlc2NyaXB0b3IoVGVzdEVuY3J5cHREZXNjcmlwdG9yKGJ1cywgMiwgc2VsZikpCiAgICAg
ICAgc2VsZi5hZGRfZGVzY3JpcHRvcigKICAgICAgICAgICAgICAgIENoYXJhY3RlcmlzdGljVXNl
ckRlc2NyaXB0aW9uRGVzY3JpcHRvcihidXMsIDMsIHNlbGYpKQoKICAgIGRlZiBSZWFkVmFsdWUo
c2VsZiwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQoJ1Rlc3RFbmNyeXB0Q2hhcmFjdGVyaXN0aWMg
UmVhZDogJyArIHJlcHIoc2VsZi52YWx1ZSkpCiAgICAgICAgcmV0dXJuIHNlbGYudmFsdWUKCiAg
ICBkZWYgV3JpdGVWYWx1ZShzZWxmLCB2YWx1ZSwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQoJ1Rl
c3RFbmNyeXB0Q2hhcmFjdGVyaXN0aWMgV3JpdGU6ICcgKyByZXByKHZhbHVlKSkKICAgICAgICBz
ZWxmLnZhbHVlID0gdmFsdWUKCmNsYXNzIFRlc3RFbmNyeXB0RGVzY3JpcHRvcihEZXNjcmlwdG9y
KToKICAgICIiIgogICAgRHVtbXkgdGVzdCBkZXNjcmlwdG9yIHJlcXVpcmluZyBlbmNyeXB0aW9u
LiBSZXR1cm5zIGEgc3RhdGljIHZhbHVlLgoKICAgICIiIgogICAgVEVTVF9ERVNDX1VVSUQgPSAn
MTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY0JwoKICAgIGRlZiBfX2luaXRfXyhz
ZWxmLCBidXMsIGluZGV4LCBjaGFyYWN0ZXJpc3RpYyk6CiAgICAgICAgRGVzY3JpcHRvci5fX2lu
aXRfXygKICAgICAgICAgICAgICAgIHNlbGYsIGJ1cywgaW5kZXgsCiAgICAgICAgICAgICAgICBz
ZWxmLlRFU1RfREVTQ19VVUlELAogICAgICAgICAgICAgICAgWydlbmNyeXB0LXJlYWQnLCAnZW5j
cnlwdC13cml0ZSddLAogICAgICAgICAgICAgICAgY2hhcmFjdGVyaXN0aWMpCgogICAgZGVmIFJl
YWRWYWx1ZShzZWxmLCBvcHRpb25zKToKICAgICAgICByZXR1cm4gWwogICAgICAgICAgICAgICAg
ZGJ1cy5CeXRlKCdUJyksIGRidXMuQnl0ZSgnZScpLCBkYnVzLkJ5dGUoJ3MnKSwgZGJ1cy5CeXRl
KCd0JykKICAgICAgICBdCgoKY2xhc3MgVGVzdFNlY3VyZUNoYXJhY3RlcmlzdGljKENoYXJhY3Rl
cmlzdGljKToKICAgICIiIgogICAgRHVtbXkgdGVzdCBjaGFyYWN0ZXJpc3RpYyByZXF1aXJpbmcg
c2VjdXJlIGNvbm5lY3Rpb24uCgogICAgIiIiCiAgICBURVNUX0NIUkNfVVVJRCA9ICcxMjM0NTY3
OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjUnCgogICAgZGVmIF9faW5pdF9fKHNlbGYsIGJ1
cywgaW5kZXgsIHNlcnZpY2UpOgogICAgICAgIENoYXJhY3RlcmlzdGljLl9faW5pdF9fKAogICAg
ICAgICAgICAgICAgc2VsZiwgYnVzLCBpbmRleCwKICAgICAgICAgICAgICAgIHNlbGYuVEVTVF9D
SFJDX1VVSUQsCiAgICAgICAgICAgICAgICBbJ3NlY3VyZS1yZWFkJywgJ3NlY3VyZS13cml0ZSdd
LAogICAgICAgICAgICAgICAgc2VydmljZSkKICAgICAgICBzZWxmLnZhbHVlID0gW10KICAgICAg
ICBzZWxmLmFkZF9kZXNjcmlwdG9yKFRlc3RTZWN1cmVEZXNjcmlwdG9yKGJ1cywgMiwgc2VsZikp
CiAgICAgICAgc2VsZi5hZGRfZGVzY3JpcHRvcigKICAgICAgICAgICAgICAgIENoYXJhY3Rlcmlz
dGljVXNlckRlc2NyaXB0aW9uRGVzY3JpcHRvcihidXMsIDMsIHNlbGYpKQoKICAgIGRlZiBSZWFk
VmFsdWUoc2VsZiwgb3B0aW9ucyk6CiAgICAgICAgcHJpbnQoJ1Rlc3RTZWN1cmVDaGFyYWN0ZXJp
c3RpYyBSZWFkOiAnICsgcmVwcihzZWxmLnZhbHVlKSkKICAgICAgICByZXR1cm4gc2VsZi52YWx1
ZQoKICAgIGRlZiBXcml0ZVZhbHVlKHNlbGYsIHZhbHVlLCBvcHRpb25zKToKICAgICAgICBwcmlu
dCgnVGVzdFNlY3VyZUNoYXJhY3RlcmlzdGljIFdyaXRlOiAnICsgcmVwcih2YWx1ZSkpCiAgICAg
ICAgc2VsZi52YWx1ZSA9IHZhbHVlCgoKY2xhc3MgVGVzdFNlY3VyZURlc2NyaXB0b3IoRGVzY3Jp
cHRvcik6CiAgICAiIiIKICAgIER1bW15IHRlc3QgZGVzY3JpcHRvciByZXF1aXJpbmcgc2VjdXJl
IGNvbm5lY3Rpb24uIFJldHVybnMgYSBzdGF0aWMgdmFsdWUuCgogICAgIiIiCiAgICBURVNUX0RF
U0NfVVVJRCA9ICcxMjM0NTY3OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjYnCgogICAgZGVm
IF9faW5pdF9fKHNlbGYsIGJ1cywgaW5kZXgsIGNoYXJhY3RlcmlzdGljKToKICAgICAgICBEZXNj
cmlwdG9yLl9faW5pdF9fKAogICAgICAgICAgICAgICAgc2VsZiwgYnVzLCBpbmRleCwKICAgICAg
ICAgICAgICAgIHNlbGYuVEVTVF9ERVNDX1VVSUQsCiAgICAgICAgICAgICAgICBbJ3NlY3VyZS1y
ZWFkJywgJ3NlY3VyZS13cml0ZSddLAogICAgICAgICAgICAgICAgY2hhcmFjdGVyaXN0aWMpCgog
ICAgZGVmIFJlYWRWYWx1ZShzZWxmLCBvcHRpb25zKToKICAgICAgICByZXR1cm4gWwogICAgICAg
ICAgICAgICAgZGJ1cy5CeXRlKCdUJyksIGRidXMuQnl0ZSgnZScpLCBkYnVzLkJ5dGUoJ3MnKSwg
ZGJ1cy5CeXRlKCd0JykKICAgICAgICBdCgpkZWYgcmVnaXN0ZXJfYXBwX2NiKCk6CiAgICBwcmlu
dCgnR0FUVCBhcHBsaWNhdGlvbiByZWdpc3RlcmVkJykKCgpkZWYgcmVnaXN0ZXJfYXBwX2Vycm9y
X2NiKGVycm9yKToKICAgIHByaW50KCdGYWlsZWQgdG8gcmVnaXN0ZXIgYXBwbGljYXRpb246ICcg
KyBzdHIoZXJyb3IpKQogICAgbWFpbmxvb3AucXVpdCgpCgoKZGVmIGZpbmRfYWRhcHRlcihidXMp
OgogICAgcmVtb3RlX29tID0gZGJ1cy5JbnRlcmZhY2UoYnVzLmdldF9vYmplY3QoQkxVRVpfU0VS
VklDRV9OQU1FLCAnLycpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgREJVU19PTV9J
RkFDRSkKICAgIG9iamVjdHMgPSByZW1vdGVfb20uR2V0TWFuYWdlZE9iamVjdHMoKQoKICAgIGZv
ciBvLCBwcm9wcyBpbiBvYmplY3RzLml0ZW1zKCk6CiAgICAgICAgaWYgR0FUVF9NQU5BR0VSX0lG
QUNFIGluIHByb3BzLmtleXMoKToKICAgICAgICAgICAgcmV0dXJuIG8KCiAgICByZXR1cm4gTm9u
ZQoKZGVmIG1haW4oKToKICAgIGdsb2JhbCBtYWlubG9vcAoKICAgIGRidXMubWFpbmxvb3AuZ2xp
Yi5EQnVzR01haW5Mb29wKHNldF9hc19kZWZhdWx0PVRydWUpCgogICAgYnVzID0gZGJ1cy5TeXN0
ZW1CdXMoKQoKICAgIGFkYXB0ZXIgPSBmaW5kX2FkYXB0ZXIoYnVzKQogICAgaWYgbm90IGFkYXB0
ZXI6CiAgICAgICAgcHJpbnQoJ0dhdHRNYW5hZ2VyMSBpbnRlcmZhY2Ugbm90IGZvdW5kJykKICAg
ICAgICByZXR1cm4KCiAgICBzZXJ2aWNlX21hbmFnZXIgPSBkYnVzLkludGVyZmFjZSgKICAgICAg
ICAgICAgYnVzLmdldF9vYmplY3QoQkxVRVpfU0VSVklDRV9OQU1FLCBhZGFwdGVyKSwKICAgICAg
ICAgICAgR0FUVF9NQU5BR0VSX0lGQUNFKQoKICAgIGFwcCA9IEFwcGxpY2F0aW9uKGJ1cykKCiAg
ICBtYWlubG9vcCA9IEdPYmplY3QuTWFpbkxvb3AoKQoKICAgIHByaW50KCdSZWdpc3RlcmluZyBH
QVRUIGFwcGxpY2F0aW9uLi4uJykKCiAgICBzZXJ2aWNlX21hbmFnZXIuUmVnaXN0ZXJBcHBsaWNh
dGlvbihhcHAuZ2V0X3BhdGgoKSwge30sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlcGx5X2hhbmRsZXI9cmVnaXN0ZXJfYXBwX2NiLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJvcl9oYW5kbGVyPXJlZ2lzdGVyX2FwcF9lcnJvcl9jYikKCgogICAg
IyBBZHZlcnQKICAgIGlmIG5vdCBhZGFwdGVyOgogICAgICAgIHByaW50KCAnTEVBZHZlcnRpc2lu
Z01hbmFnZXIxIGludGVyZmFjZSBub3QgZm91bmQnKQogICAgICAgIHJldHVybgoKICAgIGFkYXB0
ZXJfcHJvcHMgPSBkYnVzLkludGVyZmFjZShidXMuZ2V0X29iamVjdChCTFVFWl9TRVJWSUNFX05B
TUUsIGFkYXB0ZXIpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJvcmcuZnJl
ZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzIik7CgogICAgYWRhcHRlcl9wcm9wcy5TZXQoIm9yZy5i
bHVlei5BZGFwdGVyMSIsICJQb3dlcmVkIiwgZGJ1cy5Cb29sZWFuKDEpKQoKICAgIGFkX21hbmFn
ZXIgPSBkYnVzLkludGVyZmFjZShidXMuZ2V0X29iamVjdChCTFVFWl9TRVJWSUNFX05BTUUsIGFk
YXB0ZXIpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIExFX0FEVkVSVElTSU5HX01B
TkFHRVJfSUZBQ0UpCgogICAgdGVzdF9hZHZlcnRpc2VtZW50ID0gVGVzdEFkdmVydGlzZW1lbnQo
YnVzLCAwKQoKICAgIGFkX21hbmFnZXIuUmVnaXN0ZXJBZHZlcnRpc2VtZW50KHRlc3RfYWR2ZXJ0
aXNlbWVudC5nZXRfcGF0aCgpLCB7fSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlcGx5X2hhbmRsZXI9cmVnaXN0ZXJfYWRfY2IsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJvcl9oYW5kbGVyPXJlZ2lzdGVyX2FkX2Vycm9yX2NiKQoKICAgIG1h
aW5sb29wLnJ1bigpCgppZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgogICAgbWFpbigpCgo=
--00000000000024a89405b9dddda4
Content-Type: application/octet-stream; name="btmon_notify.log"
Content-Disposition: attachment; filename="btmon_notify.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kkf6ucqn2>
X-Attachment-Id: f_kkf6ucqn2

Qmx1ZXRvb3RoIG1vbml0b3IgdmVyIDUuNDgKPSBOb3RlOiBMaW51eCB2ZXJzaW9uIDQuMTkuMzUt
ZzkyZTE4ZmVmYzc3IChhcm12N2wpICAgICAgICAgICAgICAgICAgICAwLjgwOTE2OQo9IE5vdGU6
IEJsdWV0b290aCBzdWJzeXN0ZW0gdmVyc2lvbiAyLjIyICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAuODA5MTgyCj0gTmV3IEluZGV4OiAwMDoxNjpBNDo0QToyRDoyNyAoUHJpbWFyeSxV
QVJULGhjaTApICAgICAgICAgICAgICBbaGNpMF0gMC44MDkxODcKPSBPcGVuIEluZGV4OiAwMDox
NjpBNDo0QToyRDoyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAwLjgw
OTE5MAo9IEluZGV4IEluZm86IDAwOjE2OkE0OjQuLiAoQ3lwcmVzcyBTZW1pY29uZHVjdG9yIENv
cnBvcmF0aW9uKSAgW2hjaTBdIDAuODA5MTk0CkAgTUdNVCBPcGVuOiBibHVldG9vdGhkIChwcml2
aWxlZ2VkKSB2ZXJzaW9uIDEuMTQgICAgICAgICAgICAgezB4MDAwMn0gMC44MDkyMDAKQCBNR01U
IE9wZW46IGJsdWV0b290aGQgKHByaXZpbGVnZWQpIHZlcnNpb24gMS4xNCAgICAgICAgICAgICB7
MHgwMDAxfSAwLjgwOTIwMwpAIE1HTVQgT3BlbjogYnRtb24gKHByaXZpbGVnZWQpIHZlcnNpb24g
MS4xNCAgICAgICAgICAgICAgICAgIHsweDAwMDN9IDAuODA5Mjc2Cj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gOCAgICAgICAgICAgICAgICAgICAjMSBbaGNpMF0gNC41
NDM3MjEKICAgICAgQVRUOiBIYW5kbGUgVmFsdWUgTm90aWZpY2F0aW9uICgweDFiKSBsZW4gMwog
ICAgICAgIEhhbmRsZTogMHgwMDE2CiAgICAgICAgICBEYXRhOiA2NAo+IEFDTCBEYXRhIFJYOiBI
YW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAgICAgICAgIzIgW2hjaTBdIDYu
ODgzNzUzCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApIGxlbiA2
CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIGdy
b3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUg
NjUgZmxhZ3MgMHgwMCBkbGVuIDMwICAgICAgICAgICAgICAgICAgIzMgW2hjaTBdIDYuODg0NDEy
CiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlc3BvbnNlICgweDExKSBsZW4gMjUKICAg
ICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDYKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgbGlz
dDogNCBlbnRyaWVzCiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHgwMDA1CiAgICAgICAg
VVVJRDogR2VuZXJpYyBBY2Nlc3MgUHJvZmlsZSAoMHgxODAwKQogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMDA2LTB4MDAwOQogICAgICAgIFVVSUQ6IEdlbmVyaWMgQXR0cmlidXRlIFByb2ZpbGUg
KDB4MTgwMSkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIzNC0weDAyM2MKICAgICAgICBVVUlE
OiBIZWFydCBSYXRlICgweDE4MGQpCiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyM2QtMHgwMjQw
CiAgICAgICAgVVVJRDogQmF0dGVyeSBTZXJ2aWNlICgweDE4MGYpCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAjNCBbaGNpMF0gNi45
NDQ2MzgKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVxdWVzdCAoMHgxMCkgbGVuIDYK
ICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0MS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgZ3Jv
dXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDApCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2
NSBmbGFncyAweDAwIGRsZW4gMjYgICAgICAgICAgICAgICAgICAjNSBbaGNpMF0gNi45NDUyOTMK
ICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVzcG9uc2UgKDB4MTEpIGxlbiAyMQogICAg
ICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogMjAKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgbGlz
dDogMSBlbnRyeQogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjQxLTB4MDI1MAogICAgICAgIFVV
SUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWYw
KQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAg
ICAgICAgIzYgW2hjaTBdIDcuMDA0NzIzCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJl
cXVlc3QgKDB4MTApIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyNTEtMHhmZmZmCiAg
ICAgICAgQXR0cmlidXRlIGdyb3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAg
IzcgW2hjaTBdIDcuMDA1MzY5CiAgICAgIEFUVDogRXJyb3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0
CiAgICAgICAgUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApCiAgICAgICAgSGFuZGxl
OiAweDAyNTEKICAgICAgICBFcnJvcjogQXR0cmlidXRlIE5vdCBGb3VuZCAoMHgwYSkKPiBIQ0kg
RXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICM4
IFtoY2kwXSA3LjAwNTU0OQogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2
NQogICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRs
ZW4gMTEgICAgICAgICAgICAgICAgICAjOSBbaGNpMF0gNy4wNjQ0NTAKICAgICAgQVRUOiBSZWFk
IEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIz
NC0weDAyM2MKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAyNyAgICAgICAgICAgICAg
ICAgIzEwIFtoY2kwXSA3LjA2NTExMgogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAo
MHgwOSkgbGVuIDIyCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiA3CiAgICAgICAgQXR0
cmlidXRlIGRhdGEgbGlzdDogMyBlbnRyaWVzCiAgICAgICAgSGFuZGxlOiAweDAyMzUKICAgICAg
ICBWYWx1ZTogMTIzNjAyMzcyYQogICAgICAgIEhhbmRsZTogMHgwMjM4CiAgICAgICAgVmFsdWU6
IDEyMzkwMjM4MmEKICAgICAgICBIYW5kbGU6IDB4MDIzYgogICAgICAgIFZhbHVlOiAwODNjMDIz
OTJhCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAg
ICAgICAgICMxMSBbaGNpMF0gNy4xMjQ0MjgKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVz
dCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIzZC0weDAyNDAKICAgICAg
ICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDog
SGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMyAgICAgICAgICAgICAgICAgIzEyIFtoY2kwXSA3
LjEyNTIyNgogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAoMHgwOSkgbGVuIDgKICAg
ICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0
OiAxIGVudHJ5CiAgICAgICAgSGFuZGxlOiAweDAyM2UKICAgICAgICBWYWx1ZTogMTIzZjAyMTky
YQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUg
ICAgICAjMTMgW2hjaTBdIDcuMTI1Mzc2CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBI
YW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdz
IDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgIzE0IFtoY2kwXSA3LjE4NDQxNgogICAgICBB
VFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMjQxLTB4MDI1MAogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAo
MHgyODAzKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDY5ICAgICAg
ICAgICAgICAgICAjMTUgW2hjaTBdIDcuMTg1MTAxCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJl
c3BvbnNlICgweDA5KSBsZW4gNjQKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDIxCiAg
ICAgICAgQXR0cmlidXRlIGRhdGEgbGlzdDogMyBlbnRyaWVzCiAgICAgICAgSGFuZGxlOiAweDAy
NDIKICAgICAgICBWYWx1ZTogOGE0MzAyZjFkZWJjOWE3ODU2MzQxMjc4NTYzNDEyNzg1NjM0MTIK
ICAgICAgICBIYW5kbGU6IDB4MDI0NwogICAgICAgIFZhbHVlOiA4YTQ4MDJmM2RlYmM5YTc4NTYz
NDEyNzg1NjM0MTI3ODU2MzQxMgogICAgICAgIEhhbmRsZTogMHgwMjRjCiAgICAgICAgVmFsdWU6
IDhhNGQwMmY1ZGViYzlhNzg1NjM0MTI3ODU2MzQxMjc4NTYzNDEyCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICMxNiBbaGNpMF0gNy4y
NDQ1MjYKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAg
ICBIYW5kbGUgcmFuZ2U6IDB4MDI0ZS0weDAyNTAKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hh
cmFjdGVyaXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAg
ZGxlbiA5ICAgICAgICAgICAgICAgICAgIzE3IFtoY2kwXSA3LjI0NjE0NAogICAgICBBVFQ6IEVy
cm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgw
eDA4KQogICAgICAgIEhhbmRsZTogMHgwMjRlCiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3Qg
Rm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4
MTMpIHBsZW4gNSAgICAgICMxOCBbaGNpMF0gNy4yNDY1NjQKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjMTkgW2hjaTBdIDcuMzA0
NTAwCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAg
ICAgIEhhbmRsZSByYW5nZTogMHgwMjM3LTB4MDIzNwo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUg
ZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAjMjAgW2hjaTBdIDcuMzA1OTUxCiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUKICAgICAgICBG
b3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAyMzcKICAgICAgICBVVUlE
OiBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbiAoMHgyOTAyKQo+IEFDTCBEYXRh
IFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjMjEgW2hj
aTBdIDcuMzY0NTQwCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBs
ZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjNhLTB4MDIzYQo8IEFDTCBEYXRhIFRYOiBI
YW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAjMjIgW2hjaTBdIDcu
MzY2MjQyCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUK
ICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAyM2EKICAg
ICAgICBVVUlEOiBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbiAoMHgyOTAyKQo+
IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAg
ICAjMjMgW2hjaTBdIDcuMzY2NjYwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5k
bGU6IDY1CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4
MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzI0IFtoY2kwXSA3LjQyNDYxNwogICAgICBBVFQ6
IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFu
Z2U6IDB4MDI0MC0weDAyNDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxl
biAxMCAgICAgICAgICAgICAgICAgIzI1IFtoY2kwXSA3LjQyNjA4NQogICAgICBBVFQ6IEZpbmQg
SW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2
ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQwCiAgICAgICAgVVVJRDogQ2xpZW50IENoYXJh
Y3RlcmlzdGljIENvbmZpZ3VyYXRpb24gKDB4MjkwMikKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1
IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzI2IFtoY2kwXSA3LjQ4NDUyMwog
ICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBI
YW5kbGUgcmFuZ2U6IDB4MDI0NC0weDAyNDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdz
IDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzI3IFtoY2kwXSA3LjQ4NjEwNAogICAgICBB
VFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0
OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQ0CiAgICAgICAgVVVJRDogQ2hh
cmFjdGVyaXN0aWMgRXh0ZW5kZWQgUHJvcGVydGllcyAoMHgyOTAwKQo+IEhDSSBFdmVudDogTnVt
YmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMjggW2hjaTBdIDcu
NDg2NTIwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAg
Q291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAg
ICAgICAgICAgICAgIzI5IFtoY2kwXSA3LjU0NDU0NgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRp
b24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0NS0weDAy
NDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAyNCAgICAgICAgICAg
ICAgICAgIzMwIFtoY2kwXSA3LjU0NjAxMQogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVz
cG9uc2UgKDB4MDUpIGxlbiAxOQogICAgICAgIEZvcm1hdDogVVVJRC0xMjggKDB4MDIpCiAgICAg
ICAgSGFuZGxlOiAweDAyNDUKICAgICAgICBVVUlEOiBWZW5kb3Igc3BlY2lmaWMgKDEyMzQ1Njc4
LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVmMikKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZs
YWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzMxIFtoY2kwXSA3LjYwNDcxMwogICAg
ICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5k
bGUgcmFuZ2U6IDB4MDI0Ni0weDAyNDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4
MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzMyIFtoY2kwXSA3LjYwNjMyMwogICAgICBBVFQ6
IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBV
VUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQ2CiAgICAgICAgVVVJRDogQ2hhcmFj
dGVyaXN0aWMgVXNlciBEZXNjcmlwdGlvbiAoMHgyOTAxKQo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMzMgW2hjaTBdIDcuNjA2NzQ3
CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6
IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAg
ICAgICAgIzM0IFtoY2kwXSA3LjY2NDI0MwogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVx
dWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0OS0weDAyNGIKPCBB
Q0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAg
IzM1IFtoY2kwXSA3LjY2NTg2MgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2Ug
KDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRs
ZTogMHgwMjQ5CiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMgRXh0ZW5kZWQgUHJvcGVydGll
cyAoMHgyOTAwKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAg
ICAgICAgICAgICAgICAjMzYgW2hjaTBdIDcuNzI0NjAzCiAgICAgIEFUVDogRmluZCBJbmZvcm1h
dGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjRhLTB4
MDI0Ygo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDI0ICAgICAgICAg
ICAgICAgICAjMzcgW2hjaTBdIDcuNzI2MzE1CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBS
ZXNwb25zZSAoMHgwNSkgbGVuIDE5CiAgICAgICAgRm9ybWF0OiBVVUlELTEyOCAoMHgwMikKICAg
ICAgICBIYW5kbGU6IDB4MDI0YQogICAgICAgIFVVSUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2
NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY0KQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMzggW2hjaTBdIDcuNzI2NjI1CiAg
ICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDIK
PiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAg
ICAgIzM5IFtoY2kwXSA3Ljc4NDU0NQogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVz
dCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0Yi0weDAyNGIKPCBBQ0wg
RGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzQw
IFtoY2kwXSA3Ljc4NTk5NgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4
MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTog
MHgwMjRiCiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMgVXNlciBEZXNjcmlwdGlvbiAoMHgy
OTAxKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAg
ICAgICAgICAjNDEgW2hjaTBdIDcuODQ0MTg3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBS
ZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjRlLTB4MDI1MAo8
IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAg
ICAjNDIgW2hjaTBdIDcuODQ1Nzc3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25z
ZSAoMHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFu
ZGxlOiAweDAyNGUKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3RpYyBFeHRlbmRlZCBQcm9wZXJ0
aWVzICgweDI5MDApCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4
MTMpIHBsZW4gNSAgICAgICM0MyBbaGNpMF0gNy44NDYyMTUKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjNDQgW2hjaTBdIDcuOTA0
NDY2CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAg
ICAgIEhhbmRsZSByYW5nZTogMHgwMjRmLTB4MDI1MAo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUg
ZmxhZ3MgMHgwMCBkbGVuIDI0ICAgICAgICAgICAgICAgICAjNDUgW2hjaTBdIDcuOTA2MTYwCiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDE5CiAgICAgICAg
Rm9ybWF0OiBVVUlELTEyOCAoMHgwMikKICAgICAgICBIYW5kbGU6IDB4MDI0ZgogICAgICAgIFVV
SUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY2
KQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAg
ICAgICAjNDYgW2hjaTBdIDcuOTY0NDkzCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1
ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjUwLTB4MDI1MAo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAj
NDcgW2hjaTBdIDcuOTY2MDY3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAo
MHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxl
OiAweDAyNTAKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3RpYyBVc2VyIERlc2NyaXB0aW9uICgw
eDI5MDEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBs
ZW4gNSAgICAgICM0OCBbaGNpMF0gNy45NjY0ODkKICAgICAgICBOdW0gaGFuZGxlczogMQogICAg
ICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjNDkgW2hjaTBdIDguMjAzNTU5CiAg
ICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDEK
PiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAg
ICAjNTAgW2hjaTBdIDExLjgzMzY3NAogICAgICBBVFQ6IFJlYWQgUmVxdWVzdCAoMHgwYSkgbGVu
IDIKICAgICAgICBIYW5kbGU6IDB4MDIzNgo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3Mg
MHgwMCBkbGVuIDcgICAgICAgICAgICAgICAgICM1MSBbaGNpMF0gMTEuODQwNzcwCiAgICAgIEFU
VDogUmVhZCBSZXNwb25zZSAoMHgwYikgbGVuIDIKICAgICAgICBWYWx1ZTogMDY2Mwo+IEhDSSBF
dmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICM1MiBb
aGNpMF0gMTIuMDc4Njg3CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1
CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxl
biA5ICAgICAgICAgICAgICAgICAjNTMgW2hjaTBdIDE0LjA1NTIxMgogICAgICBBVFQ6IFdyaXRl
IFJlcXVlc3QgKDB4MTIpIGxlbiA0CiAgICAgICAgSGFuZGxlOiAweDAyMzcKICAgICAgICAgIERh
dGE6IDAxMDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiA1ICAgICAg
ICAgICAgICAgICAjNTQgW2hjaTBdIDE0LjA1NjIzMAogICAgICBBVFQ6IFdyaXRlIFJlc3BvbnNl
ICgweDEzKSBsZW4gMAo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgw
eDEzKSBwbGVuIDUgICAgICM1NSBbaGNpMF0gMTQuMzI5MDQ1CiAgICAgICAgTnVtIGhhbmRsZXM6
IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDEKPCBBQ0wgRGF0YSBUWDogSGFu
ZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMSAgICAgICAgICAgICAgICAjNTYgW2hjaTBdIDE1LjA3
ODY3MQogICAgICBBVFQ6IEhhbmRsZSBWYWx1ZSBOb3RpZmljYXRpb24gKDB4MWIpIGxlbiA2CiAg
ICAgICAgSGFuZGxlOiAweDAyMzYKICAgICAgICAgIERhdGE6IDBlNzUwMDAwCj4gSENJIEV2ZW50
OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgIzU3IFtoY2kw
XSAxNS4zMzAzNTMKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjUKICAg
ICAgICBDb3VudDogMQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDkg
ICAgICAgICAgICAgICAgICM1OCBbaGNpMF0gMTYuMDcxODM5CiAgICAgIEFUVDogSGFuZGxlIFZh
bHVlIE5vdGlmaWNhdGlvbiAoMHgxYikgbGVuIDQKICAgICAgICBIYW5kbGU6IDB4MDIzNgogICAg
ICAgICAgRGF0YTogMDY2ZQo+IEFDTCBEYXRhIFJYOiBI
--00000000000024a89405b9dddda4
Content-Type: application/octet-stream; name="btmon_read.log"
Content-Disposition: attachment; filename="btmon_read.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kkf6ucqo3>
X-Attachment-Id: f_kkf6ucqo3

Qmx1ZXRvb3RoIG1vbml0b3IgdmVyIDUuNDgKPSBOb3RlOiBMaW51eCB2ZXJzaW9uIDQuMTkuMzUt
ZzkyZTE4ZmVmYzc3IChhcm12N2wpICAgICAgICAgICAgICAgICAgICAwLjEyMDQzOQo9IE5vdGU6
IEJsdWV0b290aCBzdWJzeXN0ZW0gdmVyc2lvbiAyLjIyICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAuMTIwNDUzCj0gTmV3IEluZGV4OiAwMDoxNjpBNDo0QToyRDoyNyAoUHJpbWFyeSxV
QVJULGhjaTApICAgICAgICAgICAgICBbaGNpMF0gMC4xMjA0NTgKPSBPcGVuIEluZGV4OiAwMDox
NjpBNDo0QToyRDoyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAwLjEy
MDQ2MQo9IEluZGV4IEluZm86IDAwOjE2OkE0OjQuLiAoQ3lwcmVzcyBTZW1pY29uZHVjdG9yIENv
cnBvcmF0aW9uKSAgW2hjaTBdIDAuMTIwNDY0CkAgTUdNVCBPcGVuOiBibHVldG9vdGhkIChwcml2
aWxlZ2VkKSB2ZXJzaW9uIDEuMTQgICAgICAgICAgICAgezB4MDAwMn0gMC4xMjA0NzAKQCBNR01U
IE9wZW46IGJsdWV0b290aGQgKHByaXZpbGVnZWQpIHZlcnNpb24gMS4xNCAgICAgICAgICAgICB7
MHgwMDAxfSAwLjEyMDQ3MwpAIE1HTVQgT3BlbjogYnRtb24gKHByaXZpbGVnZWQpIHZlcnNpb24g
MS4xNCAgICAgICAgICAgICAgICAgIHsweDAwMDN9IDAuMTIwNjAwCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICMxIFtoY2kwXSAxOC4y
MjE5NjAKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVxdWVzdCAoMHgxMCkgbGVuIDYK
ICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwMS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgZ3Jv
dXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDApCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2
NSBmbGFncyAweDAwIGRsZW4gMzAgICAgICAgICAgICAgICAgICMyIFtoY2kwXSAxOC4yMjM3NzgK
ICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVzcG9uc2UgKDB4MTEpIGxlbiAyNQogICAg
ICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogNgogICAgICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0
OiA0IGVudHJpZXMKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwMS0weDAwMDUKICAgICAgICBV
VUlEOiBHZW5lcmljIEFjY2VzcyBQcm9maWxlICgweDE4MDApCiAgICAgICAgSGFuZGxlIHJhbmdl
OiAweDAwMDYtMHgwMDA5CiAgICAgICAgVVVJRDogR2VuZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZSAo
MHgxODAxKQogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjE5LTB4MDIxZgogICAgICAgIFVVSUQ6
IEhlYXJ0IFJhdGUgKDB4MTgwZCkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIyMC0weDAyMjMK
ICAgICAgICBVVUlEOiBCYXR0ZXJ5IFNlcnZpY2UgKDB4MTgwZikKPiBBQ0wgRGF0YSBSWDogSGFu
ZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgIzMgW2hjaTBdIDE4LjI4
MjY1MwogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlwZSBSZXF1ZXN0ICgweDEwKSBsZW4gNgog
ICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjI0LTB4ZmZmZgogICAgICAgIEF0dHJpYnV0ZSBncm91
cCB0eXBlOiBQcmltYXJ5IFNlcnZpY2UgKDB4MjgwMCkKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1
IGZsYWdzIDB4MDAgZGxlbiAyNiAgICAgICAgICAgICAgICAgIzQgW2hjaTBdIDE4LjI4NDE2MAog
ICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlwZSBSZXNwb25zZSAoMHgxMSkgbGVuIDIxCiAgICAg
ICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiAyMAogICAgICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0
OiAxIGVudHJ5CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyMjQtMHgwMjMzCiAgICAgICAgVVVJ
RDogVmVuZG9yIHNwZWNpZmljICgxMjM0NTY3OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjAp
Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAg
ICAgICM1IFtoY2kwXSAxOC4zNDI3MzgKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVx
dWVzdCAoMHgxMCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIzNC0weGZmZmYKICAg
ICAgICBBdHRyaWJ1dGUgZ3JvdXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDApCjwgQUNM
IERhdGEgVFg6IEhhbmRsZSA2NSBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAgICAgICM2
IFtoY2kwXSAxOC4zNDQzODAKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQK
ICAgICAgICBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVxdWVzdCAoMHgxMCkKICAgICAgICBIYW5kbGU6
IDB4MDIzNAogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo+IEhDSSBF
dmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjNyBb
aGNpMF0gMTguMzQ0ODAwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1
CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxl
biAxMSAgICAgICAgICAgICAgICAgIzggW2hjaTBdIDE4LjQwMjcyNgogICAgICBBVFQ6IFJlYWQg
QnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjE5
LTB4MDIxZgogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8
IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDI3ICAgICAgICAgICAgICAg
ICAjOSBbaGNpMF0gMTguNDA0MjUyCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlc3BvbnNlICgw
eDA5KSBsZW4gMjIKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDcKICAgICAgICBBdHRy
aWJ1dGUgZGF0YSBsaXN0OiAzIGVudHJpZXMKICAgICAgICBIYW5kbGU6IDB4MDIxYQogICAgICAg
IFZhbHVlOiAwMjFiMDIzNzJhCiAgICAgICAgSGFuZGxlOiAweDAyMWMKICAgICAgICBWYWx1ZTog
MDIxZDAyMzgyYQogICAgICAgIEhhbmRsZTogMHgwMjFlCiAgICAgICAgVmFsdWU6IDA4MWYwMjM5
MmEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAg
ICAgICAjMTAgW2hjaTBdIDE4LjQ2MjkzMwogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0
ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjIwLTB4MDIyMwogICAgICAg
IEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8IEFDTCBEYXRhIFRYOiBI
YW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEzICAgICAgICAgICAgICAgICMxMSBbaGNpMF0gMTgu
NDY0NDMwCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlc3BvbnNlICgweDA5KSBsZW4gOAogICAg
ICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6
IDEgZW50cnkKICAgICAgICBIYW5kbGU6IDB4MDIyMQogICAgICAgIFZhbHVlOiAxMjIyMDIxOTJh
Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAg
ICAgIzEyIFtoY2kwXSAxOC40NjQ3MjcKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhh
bmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3Mg
MHgwMiBkbGVuIDExICAgICAgICAgICAgICAgICMxMyBbaGNpMF0gMTguNTIyNjYyCiAgICAgIEFU
VDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdl
OiAweDAyMjQtMHgwMjMzCiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgw
eDI4MDMpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NSBmbGFncyAweDAwIGRsZW4gNjkgICAgICAg
ICAgICAgICAgIzE0IFtoY2kwXSAxOC41MjQxOTcKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVz
cG9uc2UgKDB4MDkpIGxlbiA2NAogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogMjEKICAg
ICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAzIGVudHJpZXMKICAgICAgICBIYW5kbGU6IDB4MDIy
NQogICAgICAgIFZhbHVlOiA4YTI2MDJmMWRlYmM5YTc4NTYzNDEyNzg1NjM0MTI3ODU2MzQxMgog
ICAgICAgIEhhbmRsZTogMHgwMjJhCiAgICAgICAgVmFsdWU6IDhhMmIwMmYzZGViYzlhNzg1NjM0
MTI3ODU2MzQxMjc4NTYzNDEyCiAgICAgICAgSGFuZGxlOiAweDAyMmYKICAgICAgICBWYWx1ZTog
OGEzMDAyZjVkZWJjOWE3ODU2MzQxMjc4NTYzNDEyNzg1NjM0MTIKPiBBQ0wgRGF0YSBSWDogSGFu
ZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAjMTUgW2hjaTBdIDE4LjU4
MjcxMAogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAg
IEhhbmRsZSByYW5nZTogMHgwMjMxLTB4MDIzMwogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFy
YWN0ZXJpc3RpYyAoMHgyODAzKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBk
bGVuIDkgICAgICAgICAgICAgICAgICMxNiBbaGNpMF0gMTguNTg0NDgxCiAgICAgIEFUVDogRXJy
b3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0CiAgICAgICAgUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4
MDgpCiAgICAgICAgSGFuZGxlOiAweDAyMzEKICAgICAgICBFcnJvcjogQXR0cmlidXRlIE5vdCBG
b3VuZCAoMHgwYSkKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgx
MykgcGxlbiA1ICAgICAjMTcgW2hjaTBdIDE4LjU4NDkwNgogICAgICAgIE51bSBoYW5kbGVzOiAx
CiAgICAgICAgSGFuZGxlOiA2NQogICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRs
ZSA2NSBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgIzE4IFtoY2kwXSAxOC42NDIx
NjMKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAg
ICAgSGFuZGxlIHJhbmdlOiAweDAyMjMtMHgwMjIzCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NSBm
bGFncyAweDAwIGRsZW4gMTAgICAgICAgICAgICAgICAgIzE5IFtoY2kwXSAxOC42NDM2NTMKICAg
ICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAgICAgIEZv
cm1hdDogVVVJRC0xNiAoMHgwMSkKICAgICAgICBIYW5kbGU6IDB4MDIyMwogICAgICAgIFVVSUQ6
IENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uICgweDI5MDIpCj4gQUNMIERhdGEg
Ulg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgIzIwIFtoY2kw
XSAxOC43MDI2NzkKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxl
biA0CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyMjctMHgwMjI5CjwgQUNMIERhdGEgVFg6IEhh
bmRsZSA2NSBmbGFncyAweDAwIGRsZW4gMTAgICAgICAgICAgICAgICAgIzIxIFtoY2kwXSAxOC43
MDQyNDcKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQog
ICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgwMSkKICAgICAgICBIYW5kbGU6IDB4MDIyNwogICAg
ICAgIFVVSUQ6IENoYXJhY3RlcmlzdGljIEV4dGVuZGVkIFByb3BlcnRpZXMgKDB4MjkwMCkKPiBI
Q0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAj
MjIgW2hjaTBdIDE4LjcwNDY2NAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxl
OiA2NQogICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAy
IGRsZW4gOSAgICAgICAgICAgICAgICAgIzIzIFtoY2kwXSAxOC43NjI1MzYKICAgICAgQVRUOiBG
aW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJhbmdl
OiAweDAyMjgtMHgwMjI5CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NSBmbGFncyAweDAwIGRsZW4g
MjQgICAgICAgICAgICAgICAgIzI0IFtoY2kwXSAxOC43NjMzOTUKICAgICAgQVRUOiBGaW5kIElu
Zm9ybWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gMTkKICAgICAgICBGb3JtYXQ6IFVVSUQtMTI4
ICgweDAyKQogICAgICAgIEhhbmRsZTogMHgwMjI4CiAgICAgICAgVVVJRDogVmVuZG9yIHNwZWNp
ZmljICgxMjM0NTY3OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjIpCj4gQUNMIERhdGEgUlg6
IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgIzI1IFtoY2kwXSAx
OC44MjI2MTIKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0
CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyMjktMHgwMjI5CjwgQUNMIERhdGEgVFg6IEhhbmRs
ZSA2NSBmbGFncyAweDAwIGRsZW4gMTAgICAgICAgICAgICAgICAgIzI2IFtoY2kwXSAxOC44MjMy
OTUKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAg
ICAgIEZvcm1hdDogVVVJRC0xNiAoMHgwMSkKICAgICAgICBIYW5kbGU6IDB4MDIyOQogICAgICAg
IFVVSUQ6IENoYXJhY3RlcmlzdGljIFVzZXIgRGVzY3JpcHRpb24gKDB4MjkwMSkKPiBIQ0kgRXZl
bnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAjMjcgW2hj
aTBdIDE4LjgyMzQ5NwogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NQog
ICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4g
OSAgICAgICAgICAgICAgICAgIzI4IFtoY2kwXSAxOC44ODI1NDYKICAgICAgQVRUOiBGaW5kIElu
Zm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAy
MmMtMHgwMjJlCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NSBmbGFncyAweDAwIGRsZW4gMTAgICAg
ICAgICAgICAgICAgIzI5IFtoY2kwXSAxOC44ODMxNzUKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0
aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgwMSkK
ICAgICAgICBIYW5kbGU6IDB4MDIyYwogICAgICAgIFVVSUQ6IENoYXJhY3RlcmlzdGljIEV4dGVu
ZGVkIFByb3BlcnRpZXMgKDB4MjkwMCkKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4
MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAjMzAgW2hjaTBdIDE4Ljk0MjY0MgogICAgICBBVFQ6
IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFu
Z2U6IDB4MDIyZC0weDAyMmUKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxl
biAyNCAgICAgICAgICAgICAgICAjMzEgW2hjaTBdIDE4Ljk0MzMyMgogICAgICBBVFQ6IEZpbmQg
SW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiAxOQogICAgICAgIEZvcm1hdDogVVVJRC0x
MjggKDB4MDIpCiAgICAgICAgSGFuZGxlOiAweDAyMmQKICAgICAgICBVVUlEOiBWZW5kb3Igc3Bl
Y2lmaWMgKDEyMzQ1Njc4LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVmNCkKPiBIQ0kgRXZlbnQ6
IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAjMzIgW2hjaTBd
IDE4Ljk0MzQ2NwogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NQogICAg
ICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gOSAg
ICAgICAgICAgICAgICAgIzMzIFtoY2kwXSAxOS4wMDI3MzgKICAgICAgQVRUOiBGaW5kIEluZm9y
bWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyMmUt
MHgwMjJlCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NSBmbGFncyAweDAwIGRsZW4gMTAgICAgICAg
ICAgICAgICAgIzM0IFtoY2kwXSAxOS4wMDM3NjgKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9u
IFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgwMSkKICAg
ICAgICBIYW5kbGU6IDB4MDIyZQogICAgICAgIFVVSUQ6IENoYXJhY3RlcmlzdGljIFVzZXIgRGVz
Y3JpcHRpb24gKDB4MjkwMSkKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY=
--00000000000024a89405b9dddda4--
