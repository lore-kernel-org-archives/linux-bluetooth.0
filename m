Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B94C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 06:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AFD61166
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 06:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJ2Ghw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:37:52 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37761 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhJ2Ghs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 02:37:48 -0400
Received: by mail-il1-f199.google.com with SMTP id x5-20020a056e021bc500b0025a9bf89937so5425319ilv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 23:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J5Iak1jbzsXlXScJo28fGKWHSz8PYkl1htafvPcEf8I=;
        b=KF2XE1xdi8L51WnAoYRpSwONwtdaiSKS9iXREpxYh6e2tGCQo4FKMZJcZQm/E060jZ
         qjGw1rWW+Gyoh7qpXz6na2Moa0m2cJe4lCkcPbpLO+t+2YUoSxoqvMjf4oyNJhVNxxQW
         vhF3/kUh2gfuDURwNRXVn7nn/5pIdSKdMdq7gEIXmFmGxfftIqpH1yAIaOjQAl6OSUnL
         zbVdjU53mRwuaz3G45tre7HziCSeMAznLLp9DUd09oINFckYE5CKRsokAgOFg9SpPvxs
         HZWAnVXBBi2I48ErHlNpMSzUsVDn369nvf+/29EeNaS2dfqbw278rS5nKrYEdFMNpc3t
         9GMg==
X-Gm-Message-State: AOAM5302Ww/DRdp7cI8YjkE3MjDATIx23vyz1b/Ywk/QfZTDJTBUXZgV
        df7gulCrPywlpEt5Jzhjd7Qq0OW3XvS+3tmYolD4D0fzhn83
X-Google-Smtp-Source: ABdhPJwzYUNIF+88XIaTqHIhDJWNunmOteoFoXYLDu2GKr0U5jX/3QDj8NPfXuUrl/5cxz0sS4nqjr/7x0IzsCXdyOoNSnO14VCV
MIME-Version: 1.0
X-Received: by 2002:a92:d752:: with SMTP id e18mr6445635ilq.31.1635489320130;
 Thu, 28 Oct 2021 23:35:20 -0700 (PDT)
Date:   Thu, 28 Oct 2021 23:35:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5dc0805cf7807a7@google.com>
Subject: [syzbot] KMSAN: uninit-value in hci_conn_request_evt
From:   syzbot <syzbot+8f84cf3ec5c288e779ef@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    82e66ad2e586 kmsan: core: better comment
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=157ae0e2b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ea742e10a5398fb
dashboard link: https://syzkaller.appspot.com/bug?extid=8f84cf3ec5c288e779ef
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f84cf3ec5c288e779ef@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_proto_connect_ind include/net/bluetooth/hci_core.h:1460 [inline]
BUG: KMSAN: uninit-value in hci_conn_request_evt+0x220/0x1290 net/bluetooth/hci_event.c:2783
 hci_proto_connect_ind include/net/bluetooth/hci_core.h:1460 [inline]
 hci_conn_request_evt+0x220/0x1290 net/bluetooth/hci_event.c:2783
 hci_event_packet+0x1489/0x22e0 net/bluetooth/hci_event.c:6315
 hci_rx_work+0x6ae/0xd10 net/bluetooth/hci_core.c:5136
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_alloc_node mm/slub.c:3221 [inline]
 __kmalloc_node_track_caller+0x8d2/0x1340 mm/slub.c:4955
 kmalloc_reserve net/core/skbuff.c:355 [inline]
 __alloc_skb+0x4db/0xe40 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1116 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:389 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:165 [inline]
 vhci_write+0x182/0x8f0 drivers/bluetooth/hci_vhci.c:285
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write fs/read_write.c:507 [inline]
 vfs_write+0x1295/0x1f20 fs/read_write.c:594
 ksys_write+0x28c/0x520 fs/read_write.c:647
 __do_sys_write fs/read_write.c:659 [inline]
 __se_sys_write fs/read_write.c:656 [inline]
 __x64_sys_write+0xdb/0x120 fs/read_write.c:656
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================
Kernel panic - not syncing: panic_on_kmsan set ...
CPU: 1 PID: 6390 Comm: kworker/u5:1 Tainted: G    B             5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ff/0x28e lib/dump_stack.c:106
 dump_stack+0x25/0x28 lib/dump_stack.c:113
 panic+0x44f/0xdeb kernel/panic.c:232
 kmsan_report+0x2ee/0x300 mm/kmsan/report.c:168
 __msan_warning+0xb4/0x100 mm/kmsan/instrumentation.c:199
 hci_proto_connect_ind include/net/bluetooth/hci_core.h:1460 [inline]
 hci_conn_request_evt+0x220/0x1290 net/bluetooth/hci_event.c:2783
 hci_event_packet+0x1489/0x22e0 net/bluetooth/hci_event.c:6315
 hci_rx_work+0x6ae/0xd10 net/bluetooth/hci_core.c:5136
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
