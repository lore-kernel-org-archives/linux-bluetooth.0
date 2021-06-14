Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42015C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 13:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2116D61153
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 13:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhFNNey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFNNex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 09:34:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51729C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 06:32:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a127so4732153pfa.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qmo6tlF/dPW9fjrNsgVU25tiasBkc/qRnQmwxbHXKwI=;
        b=gWX5hpy+XbXvcBzqEtqGk59jXsmyInU4a9fO9+pz9KgqtYdpbJDHAdUIlPrHj5Pvzj
         cPunUE/Dws8oLQw/9BkSwd9DJtNPCJlAVYGnbT6BDHqnEcO3h7zPC7fswxanPaAo7wgF
         ckH0usZUPAkyCw8vGOTGJzPz4yGsmNElPjXm8mTZyg/3+PWBboYIqg3ACspztmGwF7cZ
         EmwpOkRGo6k57eNDn66ZmE90D/56Dp/tFXdapSYVITKcd+q3bg/QXPldf1wzwzGf1xHm
         A3liL81YjEYXkWikW8HQfYH9aisbiTlf0m8OOGd1wZMPj12nkP8PdvEWSv0qnSEKMu4c
         2XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qmo6tlF/dPW9fjrNsgVU25tiasBkc/qRnQmwxbHXKwI=;
        b=k4N2q24AU+EH/FcJX19cX3AcG3sWLDbIxgpxgaoYo00TnHrbLs8dDZyEPnc1TRyb8S
         8CGjH+AnMOeBmBIymhUlW7YrTIkSo1Nsza9MZDoDF4ODm1i88ToAaMsL4LPO331vPriC
         izV2mQWxGw80cRTXtB4teD0sgUxLS8UPFSQzj54Lr3EMogRQDu7Vof9vjp/0DV8bDOlG
         VZXCrhhwH838jI/LSG34uXa7m5zTIAo1g9sesxGoOMlBkXi4hCZUYLOw8aBnV46xWgyW
         0HraWg/yU92R3N9y++rWIgvqHY8JJqtXpkJbiJFiWf7NaH0PB+KHtK8np4xPk4+fVuo6
         TJdg==
X-Gm-Message-State: AOAM5337+YsKZq9+BYjejGY9Btd/itwFP8kswyLmDZO8CVnBSshq9uE1
        PnCpc+C+7Z7OwDcaRWSsT8BRPjp/tJ3h1iBx0qxJNR4kGEJD4g==
X-Google-Smtp-Source: ABdhPJwDf4ety2UWY6cRlrv4fIcGYjnHXv/3t2ohcbjzlGFOFDu730Dpt0smBuRv8Ag4q+6Pg7TFihfZhgfDT/Q6xIk=
X-Received: by 2002:a62:77d0:0:b029:2e9:a7ca:9c50 with SMTP id
 s199-20020a6277d00000b02902e9a7ca9c50mr21896590pfc.5.1623677566697; Mon, 14
 Jun 2021 06:32:46 -0700 (PDT)
MIME-Version: 1.0
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Mon, 14 Jun 2021 15:32:35 +0200
Message-ID: <CAFJ_xbpkmBv4O8EPN0DRNYEzBEFcm1dj+ae765626nd+PPbo3Q@mail.gmail.com>
Subject: PROBLEM: Crash after Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
To:     luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     upstream@semihalf.com, linux-bluetooth@vger.kernel.org,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I was testing v5.13-rc5 and I have noticed it sometimes crashes giving
the following logs:

[   13.886255] Bluetooth: rfcomm_init() RFCOMM ver 1.11
[   14.654758] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   14.662562] #PF: supervisor read access in kernel mode
[   14.668319] #PF: error_code(0x0000) - not-present page
[   14.674080] PGD 0 P4D 0
[   14.676923] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   14.681802] CPU: 0 PID: 2647 Comm: kworker/u17:2 Tainted: G     U
         5.13.0-rc5 #2
[   14.691052] Hardware name: Google Delbin/Delbin, BIOS
Google_Delbin.13672.156.3 05/14/2021
[   14.700289] Workqueue: hci0 hci_rx_work [bluetooth]
[   14.705776] RIP: 0010:smp_new_conn_cb+0xd/0xb0 [bluetooth]
[   14.711920] Code: 47 c5 6b c0 48 89 d9 31 c0 e8 aa 31 00 00 48 8b
3b be 13 00 00 00 5b 5d e9 8d b4 fc ff 55 48 89 e5 41 56 53 49 89 fe
48 8b 07 <48> 8b 00 48 8b 90 c0 05 00 00 48 83 c2 48 48 c7 c7 53 c58
[   14.732905] RSP: 0018:ffffba9fc2a5bc88 EFLAGS: 00010246
[   14.738755] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9f373f23ad00
[   14.746748] RDX: 0000000000000000 RSI: ffffffff88df7c90 RDI: ffff9f3760e51c00
[   14.754718] RBP: ffffba9fc2a5bc98 R08: 0000000000000000 R09: fefefefefefefeff
[   14.762678] R10: 0000000000000018 R11: ffffffffc06a93d3 R12: ffff9f37344fe000
[   14.770657] R13: ffff9f3760e51f28 R14: ffff9f3760e51c00 R15: ffff9f3757aab540
[   14.778625] FS:  0000000000000000(0000) GS:ffff9f3878000000(0000)
knlGS:0000000000000000
[   14.787672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.794099] CR2: 0000000000000000 CR3: 000000012e6dc003 CR4: 0000000000770ef0
[   14.802070] PKRU: 55555554
[   14.805087] Call Trace:
[   14.807815]  l2cap_connect_cfm+0x15b/0x3b1 [bluetooth]
[   14.813574]  hci_le_meta_evt+0x8c2/0xb76 [bluetooth]
[   14.819136]  ? newidle_balance+0x200/0x36f
[   14.823724]  hci_event_packet+0x6f1/0x844 [bluetooth]
[   14.829383]  hci_rx_work+0x121/0x338 [bluetooth]
[   14.834557]  process_one_work+0x1b9/0x368
[   14.839038]  worker_thread+0x213/0x372
[   14.843222]  ? _raw_spin_unlock_irqrestore+0x12/0x2c
[   14.848782]  kthread+0x150/0x15f
[   14.852384]  ? pr_cont_work+0x58/0x58
[   14.856477]  ? kthread_blkcg+0x31/0x31
[   14.860663]  ret_from_fork+0x1f/0x30
[   14.864655] Modules linked in: rfcomm cmac algif_hash
algif_skcipher af_alg vhost_vsock vhost vhost_iotlb
vmw_vsock_virtio_transport_common vsock uinput mei_hdcp xt_cgroup
btusb cdc_ether usbnet btrtl s1
[   14.864691]  iwlwifi cfg80211 joydev
[   14.968673] gsmi: Log Shutdown Reason 0x03
[   14.973278] CR2: 0000000000000000
[   14.976991] ---[ end trace 9e1b3a2966a93e69 ]---
[   14.984499] RIP: 0010:smp_new_conn_cb+0xd/0xb0 [bluetooth]
[   14.990648] Code: 47 c5 6b c0 48 89 d9 31 c0 e8 aa 31 00 00 48 8b
3b be 13 00 00 00 5b 5d e9 8d b4 fc ff 55 48 89 e5 41 56 53 49 89 fe
48 8b 07 <48> 8b 00 48 8b 90 c0 05 00 00 48 83 c2 48 48 c7 c7 53 c58
[   15.011645] RSP: 0018:ffffba9fc2a5bc88 EFLAGS: 00010246
[   15.017481] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9f373f23ad00
[   15.025449] RDX: 0000000000000000 RSI: ffffffff88df7c90 RDI: ffff9f3760e51c00
[   15.033418] RBP: ffffba9fc2a5bc98 R08: 0000000000000000 R09: fefefefefefefeff
[   15.041387] R10: 0000000000000018 R11: ffffffffc06a93d3 R12: ffff9f37344fe000
[   15.049361] R13: ffff9f3760e51f28 R14: ffff9f3760e51c00 R15: ffff9f3757aab540
[   15.057336] FS:  0000000000000000(0000) GS:ffff9f3878000000(0000)
knlGS:0000000000000000
[   15.066380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.072797] CR2: 0000000000000000 CR3: 000000012e6dc003 CR4: 0000000000770ef0
[   15.080768] PKRU: 55555554
[   15.083775] Kernel panic - not syncing: Fatal exception
[   15.089661] Kernel Offset: 0x6a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   15.102110] gsmi: Log Shutdown Reason 0x02
[   15.108941] ACPI MEMORY or I/O RESET_REG.

After short debug it pointed to the commit:

commit 2e1614f7d61e407f1a8e7935a2903a6fa3cb0b11
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Mar 15 14:39:29 2021 -0700

    Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg

In my case it looks like "conn" appears to be NULL,
at the following call (function: smp_new_conn_cb, net/bluetooth/smp.c)
bt_dev_dbg(pchan->conn->hcon->hdev, "created chan %p", chan);

Best regards,
Lukasz
