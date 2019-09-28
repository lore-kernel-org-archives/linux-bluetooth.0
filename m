Return-Path: <SRS0=kOdZ=XX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDEC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 08:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501852075C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 08:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN45x0IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfI1Iyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Sep 2019 04:54:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54930 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfI1Iyt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Sep 2019 04:54:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so8249326wmp.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Sep 2019 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hUwncMBFl5mApHdUqbMKfQqqKvQADbMsxbinJrLTd/8=;
        b=NN45x0IFkfIE0Cz5urrroYUv4EW+22Mek07QWKYcuYzx0+tbuwy56QjwWvyE5/OpAU
         +BwFBxe/HwgiARhNV9fjU3jC6KLFG0Li9hy79NV/hbO98jNz+ujVDeCnXRJo8gIUWJbz
         l4rzY7BxJnAIfDQH9HCKg5nu2e57TTyJqFTADvJWZznLQLGiU2cHDyPHY+QQE9q7h5dV
         TnhT3bvyn1hYTDXXqI9bXxWZUfi1tQnCdG040T6Fti73kCPGHyh6fskflVUZ1D0hyp4o
         N5phdN0ck2zfv9lTgoj2EKam7ROlIqKr0fDncICwoEKBvV5sncv0yV+/Tn/A9ZM3bsrP
         tMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hUwncMBFl5mApHdUqbMKfQqqKvQADbMsxbinJrLTd/8=;
        b=dKLV8DjR1MJlH1cj/pZWXa9AK2Q6vD9mIjBWKP4NqWFhfnurQJFyTljN0fw4A8wCaK
         lNu7xqabUkIcm3g0cuZa//aBQS0oWCgKfptnybzbEXDEoJ28ZjGkzMMmmVgZ3pobqSvJ
         lFbhn7ISGpC1W0KRH3okCzOFZP8HJ6j895eqrKRU2klrDkT0IOCWYEPlY1Ana/WsBRcW
         Op9NtnC/oDbAdAgnJuoSUzMM78Q6ApOcV0u+G53LmyrLClxLrFujea84lbDuIdgMRjX5
         I1fY3qN4vw8/lC9LkCbemk4ZImAVz/LJ95f0B4080BB20oCiiT6718n9nZ+S7i/8e+UJ
         v4kQ==
X-Gm-Message-State: APjAAAXWfy4Fvop/0OPcei1vcUIu3apWqvHyoO8uNoN5gGJWlY5qadMV
        t4Hwnk9ks6r37Vo6WsUrD7c=
X-Google-Smtp-Source: APXvYqy75rfh9ouE/dPescY7lI6/ETBP622yAE9hmLKCbyRwtnA3sog2RNR62FzfmqwG2JETFuM0FA==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr11026370wmk.150.1569660887583;
        Sat, 28 Sep 2019 01:54:47 -0700 (PDT)
Received: from localhost ([37.238.189.6])
        by smtp.gmail.com with ESMTPSA id i7sm10531617wrb.64.2019.09.28.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 01:54:46 -0700 (PDT)
Date:   Sat, 28 Sep 2019 11:54:44 +0300
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [BUG] command 0x1009 tx timeout error in BCM2070
Message-ID: <20190928085323.tfjiiyrktu3vscvk@manjaro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
This bug has been in the kernel for years and it was posted on kernel
bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=64671

My exact bluetooth module with IDS is:
0a5c:21b4 Broadcom Corp. BCM2070 Bluetooth 2.1 + EDR

on pc startup the bluetooth device is not ready and bluetoothctl doesn't
see the controller

looking at the dmesg errors I see this line:
```
[   11.618685] Bluetooth: hci0: command 0x1009 tx timeout
```

There are two ways to workaround this issue:
1- reload the btusb kernel modules:

rmmod btusb
modprobe btusb

This will reset the device and now the controller is up and recognised
by bluetoothctl

2- reset the device 
I used this python script to reset the device:

```
#!/usr/bin/python

from usb.core import find as finddev
dev = finddev(idVendor=0x0a5c, idProduct=0x21b4)
dev.reset()
```

after running this the controller is working and i can connect an pair
devices and i see this in the dmesg errors:

```
[   62.746083] Bluetooth: hci0: unexpected event for opcode 0x1009
```
Maybe this is a timing issue in which the btusb driver is trying to
probe the device before it's ready ?!

I hope this can be solved from within the kernel code, I can test
any patches and give my feedback.

Regards





