Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148FFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 00:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB47261038
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 00:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhHYAcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:32:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39846 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhHYAcI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 20:32:08 -0400
Received: by mail-io1-f72.google.com with SMTP id u22-20020a5d9f560000b02905058dc6c376so9766803iot.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 17:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vmWstVnnb830DoJmVbDhGcXaqdb96d+LhOSkNAujwuU=;
        b=bnZLGIeYjk1o2/KrJKBhZ5JFN/B88F/4ZfcW8qW0qEjE/92HOX8OrDCKHdo9CsbYDQ
         Y+u3Pz4uhbdxCrtEadPQRY6c/VCTgprxfNzwNhJIh3eMHt4m79xxjGgv4dXAYl6x5VFH
         qSLhzWBipZ8zB8hjVkch8IHkx78hD8w6lMBdbYkVVkfJ5vPYuSNFAyLrcPnMk0TayIrv
         yrUg8J3anQDqanfrVnweXaX5s6bOLlEnYMITZ2FvkLdPCASOhx3RgsHkrlexJzXIwbob
         bH3+oyskdoVQhl2md+uiANNwr2ufbwcVBOyF2rKjWe0+8PIkOsXqdQfUmwP2TnP7phB5
         rLng==
X-Gm-Message-State: AOAM532tG/yUIgYUHMROEt5QiAH01D7twLnZe218KNs7oJ+sr3b8rRVa
        NqyXKSCXNcQwJMLm4SqJt+klKMpqjBAfWfBMSKAErZt9MEhK
X-Google-Smtp-Source: ABdhPJxT4wQRRiP5lkaHhBuxDJTHTz91hHXUA4+ybJWwz26CUCPKUbk99Hk7WuQcKftqx0oHzfWz1oif8it4eqm9fLsnxrXn3qWD
MIME-Version: 1.0
X-Received: by 2002:a92:7304:: with SMTP id o4mr27933562ilc.75.1629851482954;
 Tue, 24 Aug 2021 17:31:22 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:31:22 -0700
In-Reply-To: <00000000000065b14e05c282fd15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ada11305ca575e1e@google.com>
Subject: Re: [syzbot] memory leak in mgmt_cmd_complete
From:   syzbot <syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6e764bcd1cf7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174af485300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a938918bd15e088e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c4ffd1e1094dae61035
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355278d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150997c5300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.730s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.730s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.780s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.780s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.840s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.840s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.900s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.900s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.950s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.950s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.010s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.010s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.060s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.070s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.120s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.120s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


