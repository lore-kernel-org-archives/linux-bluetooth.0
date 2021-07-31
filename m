Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25560C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 01:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0149B60F48
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 01:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhGaBP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 21:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhGaBP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 21:15:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8EC06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jul 2021 18:15:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso7480456wmp.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jul 2021 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZpYuqzxKZ0T7nUKiqQ9YUGrGOHZlSOlBXaT3o95q9LQ=;
        b=pGvC+vOCrhjKTapj7HbAdJU2Pdb28fB0iXeFwiRAXAkm7x/b6KYiC5Pw35rxMJxDoC
         1nVvWuGK9KbKi9ElY49V4YwRnET23bVJ6aHegL+q35aSenQlOnqAHQkz/N75ts57sm4u
         SabyWiztSVeeKucb9KviOqR2OcHjkZh70htFOX+2UQBSlNIO9gsxda6SrJeFUqpqRMNF
         2HA/nDm4omQ0WySxR1ou5m2wvPNrntD6vaOE0ZZdtmeSqmRqqDpTVinXz49AHzHCG9o7
         NFfGBchakqTAfH/Oh4kgjxii4Ec1U9DfZ8IXPU3zX5NglWM05EUjmCLVvWfCeAndi5EU
         wU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZpYuqzxKZ0T7nUKiqQ9YUGrGOHZlSOlBXaT3o95q9LQ=;
        b=uG23/piaZdPYQDxIuJNbB7Vp0XhyTEGsrsm/6H5ka3E3o/pI3y7F7SUiZ4JcquIAd6
         A0tzuOo+QlNYUSrct4dPT9VPzZrmU02u+1E7Ftcdey5FE5e3TQogpw7RHrFAH8zx+nmh
         xxCaoeneZPAUqx3/LyfUO2t1mTW6Zz0EMfDXYGRmIQ1lyTenntJeybuYEV2OusK/KpzZ
         pSMtBzHzMkTzHl+3ZfI5EP2w3BbiBpwwMdMxik1c6XTwSxfkqVRb7rnZI5aU9j7+VLOX
         ICubYKtXMOGRJdbR4Lp3ZowkpK+bo6gyjd0NIaJA29xixeaw35EF+Zskr66tU8SpQ6KE
         vyDg==
X-Gm-Message-State: AOAM531pfmrKIb9GRNBB2BUAlAgd1UYjjFXnb7RarEo18l4B0biEKkGY
        SlFIojNxOQ4xU9H7bKRQSODpVCahoh7zfrSx8Z8T5znlZhJCqU1a
X-Google-Smtp-Source: ABdhPJyj2Vx6f/QNxtxvD9uxa+u6tkgtmZkT/nwqmvIaULXC5R7AqK6b7Lg2BpJw3U7b0+91sSJoy0j4b+WjicuhEE4=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr5864925wmj.128.1627694148341;
 Fri, 30 Jul 2021 18:15:48 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 30 Jul 2021 19:15:32 -0600
Message-ID: <CAJCQCtS7=tv_18JFjGPNRj02LmYe47N2NUYErd7jPObJf4SzyQ@mail.gmail.com>
Subject: 5.14-rc3: bluetooth lockdep warning, Jefferson Peak (JfP)
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
Jefferson Peak (JfP)

[    0.000000] Linux version 5.14.0-0.rc3.29.fc35.x86_64+debug
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.1.1
20210623 (Red Hat 11.1.1-6), GNU ld version 2.36.1-15.fc35) #1 SMP Mo
n Jul 26 14:44:37 UTC 2021

Excerpts:

[    8.457218] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
...
[   10.874942] Bluetooth: hci0: command 0xfc09 tx timeout
...
[   18.873443] Bluetooth: hci0: Failed to send firmware data (-110)
[   18.879399] Bluetooth: hci0: sending frame failed (-19)
[   18.879454] Bluetooth: hci0: Intel reset sent to retry FW download

[   19.038113] BUG: sleeping function called from invalid context at
net/core/sock.c:3161
[   19.038150] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
445, name: kworker/3:2
[   19.038161] 6 locks held by kworker/3:2/445:
[   19.038169]  #0: ffff91d4010d4748
((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[   19.038226]  #1: ffffa618c0b07e70
((work_completion)(&hub->events)){+.+.}-{0:0}, at:
process_one_work+0x21a/0x5c0
[   19.038395]  #2: ffff91d40699ba38 (&dev->mutex){....}-{3:3}, at:
hub_event+0x99/0x1790
[   19.038462]  #3: ffff91d406f89238 (&dev->mutex){....}-{3:3}, at:
usb_disconnect+0x81/0x90
[   19.038501]  #4: ffff91d40b8e01c0 (&dev->mutex){....}-{3:3}, at:
device_release_driver+0x1c/0x40
[   19.038540]  #5: ffffffffc0be8400 (hci_sk_list.lock){++++}-{2:2},
at: hci_sock_dev_event+0x141/0x1f0 [bluetooth]

Full dmesg:
https://drive.google.com/file/d/1A-fdCdhaVJZL3T3_UhSY5DkBfaPZ2tR8/view?usp=sharing

This was also in rc1.

-- 
Chris Murphy
