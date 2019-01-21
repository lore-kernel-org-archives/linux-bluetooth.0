Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51623C67875
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0B12085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx4jKEb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfAULC3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:02:29 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42157 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAULC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 06:02:28 -0500
Received: by mail-pg1-f171.google.com with SMTP id d72so9327051pga.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 03:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HKFgLv/j3Z0mWZdAgD7A+A06DttgOLiIrXfeps43Wao=;
        b=Kx4jKEb+B68BML3ETwLVCgVGbZUTUWMqkI7tQZGjIz/WoDeBqRItWDonXwEHoMbvcg
         YlnjdFtRc9WQqll9CBJZWD4H+ndmgZt5clXcvW3nbmc7y/zNsEMBd8HgmqGEXXovuKqf
         id8noefqubpff4CH2sDbu7iiiKfLKsPm4ru0XP+q4NaBisNWqBU9EWm2g6LooB5YUEkZ
         U5SDtR8acOr8tE7JllNAmAEjfurDkiHrNbIwACWbBwfDqtO4cdKIQUzjl7qEmx3eapia
         lQAktTR5++sGjGd9tUhFkv0AmcT78Sv+AjCbp2EKX20CPiHiETWz3UuMybH6vk+nC+3O
         zCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HKFgLv/j3Z0mWZdAgD7A+A06DttgOLiIrXfeps43Wao=;
        b=HUSQA0w+9rgztlzJBaOJ4UcK3Y0cfaDTf6YBkxE4U2See0uKVYMguRXWTmvpkoelRl
         0lZkRsBYChpkz5EAWd8fLu1el/ut2Bp0rYv8IUb53R88DaowUVV28RWvI/6p+qslp/gX
         6e1glGBSh9tTgjS/kiVqHf79OlMkTGQ+oNKB/WO5maCnJe4V/MKeWO90dMFeRX8bnGnl
         38kos1nbCmyVglFd8J0n3cCZBarK4umkyv2eOsbs1Ojk0eB6TjKXpD7nHIgGiuipvxiq
         pBgAcDaNuIUoauY1FVmWJeEhYxV8Th9+BrKOmQrn8IqgAW+9dP0A3k9BIn2HqwWgc9MJ
         e/DA==
X-Gm-Message-State: AJcUukc5oUEYfkF/Oav7xGDX18+IwfoJ6M3+RuQSqosi2iHGn6Y7B8Oo
        LGW4FmbbCAkVf7RmTnjG/4JEAxphN94l6uWmrfIW6ugd
X-Google-Smtp-Source: ALg8bN7LZkaDPcHGxIu3sATduugk+Z8Aehj9Ll4yUb7BENoulQMoWqTdPEv/JapTVBtkIVD8edmYVbHBrhiWyNF9NIw=
X-Received: by 2002:a62:b15:: with SMTP id t21mr30273522pfi.136.1548068547749;
 Mon, 21 Jan 2019 03:02:27 -0800 (PST)
MIME-Version: 1.0
From:   Youssif Saeed <youssif.am.saeed@gmail.com>
Date:   Mon, 21 Jan 2019 11:02:16 +0000
Message-ID: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
Subject: BlueZ 5.50: Browsing local GATT table
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

Is there a tool/utility for browsing the local GATT table. I have so
far used "bluetoothctl info" as follows:-

[bluetooth]menu gatt
[bluetooth]register-service 0xFFFF
[bluetooth]register-characteristic 0xAAAA read,write
[bluetooth]register-application
[bluetooth]back
[bluetooth]info
Controller 00:16:A4:09:31:11 (public)
Name: linuxvm
Alias: linuxvm
Class: 0x000c0000
Powered: yes
Discoverable: no
Pairable: yes
UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
Modalias: usb:v1D6Bp0246d0532
Discovering: no

However, this does not show the list of characteristics/descriptors
and their handles which is what I am after.

I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.

Thanks
Youssif
