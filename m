Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE980C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D912177B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 07:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQrx4+y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759887AbgJXHhW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Oct 2020 03:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759885AbgJXHhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Oct 2020 03:37:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B897C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 00:37:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k27so4874079oij.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OjhOTkWJKO9hyRMwpf6EIwKJnR0hTtTNZ1fi97cwihY=;
        b=HQrx4+y59MQPgsrdlYnj80Uz1FGayxPMAapY7ek3fPLSTNof+0jElFzFjgGt/e0O/N
         5DpT2wVHPHqUWMd6M34cWoVVWkv04hzMO383cpYRd6k1g+zhM4Ou4Aly2PGzPmECshxa
         8crQgFifHf88jl6v5WoPqN3ss301QMnRDA3G8NtbtjRklhpFc0LMoWP3NJmeLGs2xkFV
         jY34JaRs/OZstf79VZBDNR3v9P3RPbiDrSfRTqmZWGGNLKoCewwYXuXlDv70YxRpF3M7
         f8CZPXpXMTkZgEQFlPs8Yjwu+lFqBGVa9hEUobl6v03EkLy3CjCo30dQJbFtBF0x6lCn
         3QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OjhOTkWJKO9hyRMwpf6EIwKJnR0hTtTNZ1fi97cwihY=;
        b=OgaQyDAcWpq8DeVsGNNOEI91oeDz5A1DKQ/NvLphK7st0RYNelmpi+xkTCqO2YYJTx
         +aMJNDjANXFpZ1wVF1stfkEK+Vpq4csslrtUk1OlUkrXjl/Jce6PL6pCP+dCLVX93LBi
         GE++9NI3y8oTow3Zef+x0WT+r/Ekm3t8gbQYJWPpkIH2vtLwhCa/fkzHqxLhrvrTRdKD
         2VtPSZo/zEturB8X3YDOpYTAOw0dZCnr3d1lGULCNoWoN/dpDf8X9adxafhDQIv4joet
         rU8S5w0N5oKi9jL6reSY4L7wP3f5aFv5W74kq5LwUvLdKms1eAcPGMNOiBzREW3z8lep
         I3ag==
X-Gm-Message-State: AOAM531xiDWuZCjm3jbVP1cfpFU1c1fyhkxnTOR3R2ktOJLOvQS4kRhQ
        ZeKHFI6ydAjMBG1aDDlZZn7dPlH1blqw6Q9SpbN1EX/zd54=
X-Google-Smtp-Source: ABdhPJwmmQDfaN21uW2r2MYKxGuCdFTaRmpkkGejF9TU/fJC6SglwUxQAhgwG0yfPtIUXUGzTekWGtUVd3PPuM8cWac=
X-Received: by 2002:aca:e0c3:: with SMTP id x186mr4174655oig.140.1603525040929;
 Sat, 24 Oct 2020 00:37:20 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Barrett <vk6fun@gmail.com>
Date:   Sat, 24 Oct 2020 15:37:09 +0800
Message-ID: <CACUBSc-wspy_yNuV49he6nR7hi-WVquRNAcasfK7MEOs6EB6HA@mail.gmail.com>
Subject: ASHA
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi thanks for indulging me. Wondering if this hearing aid streaming
service can be implemented in the Linux bluetooth stack. So far only
found in iPhone and some Android phones
There is more information at https://source.android.com/devices/bluetooth/asha
I would be happy to help with testing if anyone is interested.
I have a Nucleus7 CochlearSpeech Processor and I can connect to it
with this RPi4B running 5.4.71-v7l+ with bluetoothd v5.5
bluetoothctl v5.49 gives the following output:

[bluetooth] [0m# list-attributes 84:77:XX:XX:XX:XX
Primary Service
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075
0000fdf0-0000-1000-8000-00805f9b34fb
Unknown
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007f
2d410339-82b6-42aa-b34e-e2e01df8cc1a
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007d
00e4ca9e-ab14-41e4-8823-f9e70c7e91df
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007a
38663f1a-e711-4cac-b641-326b56404837
Vendor specific
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char007a/desc007c
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char0078
f0d4de7e-4a88-476c-9d9f-1937b0996cc0
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0075/char0076
6333651e-c481-4a3e-9169-7c902aad37bb
Vendor specific
Primary Service
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064
3c3c6c6b-c9bc-4704-bb14-2ffd32b5aa31
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0073
18e77d96-c2a2-4da9-a848-436a8aea81ba
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0071
8e5abd16-d6e0-4efb-8881-4d9d257b017a
Vendor specific
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006e
962020af-7715-4f77-b8db-b2ea0e89415b
Vendor specific
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006e/desc0070
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006b
47c7e464-7bb4-4c8b-9515-3a2141b65300
Vendor specific
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char006b/desc006d
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0068
0472ca69-929b-44ad-9821-97078d06c362
Vendor specific
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0068/desc006a
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0065
31291857-6a7e-4b77-8655-feb603498758
Vendor specific
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0064/char0065/desc0067
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
Primary Service
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a
0000180a-0000-1000-8000-00805f9b34fb
Device Information
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0015
00002a50-0000-1000-8000-00805f9b34fb
PnP ID
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0013
00002a26-0000-1000-8000-00805f9b34fb
Firmware Revision String
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char0011
00002a27-0000-1000-8000-00805f9b34fb
Hardware Revision String
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000f
00002a25-0000-1000-8000-00805f9b34fb
Serial Number String
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000d
00002a24-0000-1000-8000-00805f9b34fb
Model Number String
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service000a/char000b
00002a29-0000-1000-8000-00805f9b34fb
Manufacturer Name String
Primary Service
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001
00001801-0000-1000-8000-00805f9b34fb
Generic Attribute Profile
Characteristic
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001/char0002
00002a05-0000-1000-8000-00805f9b34fb
Service Changed
Descriptor
/org/bluez/hci0/dev_84_77_XX_XX_XX_XX/service0001/char0002/desc0004
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration

Cheers

Peter Barrett
