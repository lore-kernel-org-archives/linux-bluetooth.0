Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A209C43466
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EADC221EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIUOvY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:51:24 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:47755 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgIUOvY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 10:51:24 -0400
Received: by mail-io1-f80.google.com with SMTP id a15so10062266ioc.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 07:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X82mpFSYNXw8KiQzwN46zmsn9KUcYuqFASM4Rm2vW3I=;
        b=Z2+MJSL7jos3B+UinvHmsTBJ3DDqPxNDFWNUViiEFi0fleJF36Aa5pzi8Y5LkGn4+a
         VzFt9WTmdJtPbd95Ip0fXps5Y+Idotz/ig116GU78OhFRFuji4AcYmLCrbb25PQFhr7S
         xvVuzqIinYZuY9DCdQymVISApJ8F2WlEPznX9CUxPGlR80kIVTzXH/6gxzxWT9Qp0clq
         HSU5a4TfRsvxQlAcrHL5kWgWDklwEDVkqbwqmnGgtvEmg5NEwuXcg0e0idEym3xkP2jo
         A42MZ6xUNmetm3nOF8ki0/IGihWSixH0kmPH+PnXe1FVmP1Q3n5HNVYesQTiiNvY9eq+
         jflA==
X-Gm-Message-State: AOAM532951m0Sv2eyxpgbcUzTcX+FxQx7ufNUxzIeOaFLMIrlJLyrAOw
        Qanf0hW679V6olBXH/pe+r4PKw7nlCewWuRHj5ae8t/sibUw
X-Google-Smtp-Source: ABdhPJx9GfnJQla92w2TYwa2GGE1k6o1j824dPE1UVO0QEVKZwifrmXxEYa0Fi95RKrtNmWIKJmwL7OJByfnvKHfqI3u2mZJEMmE
MIME-Version: 1.0
X-Received: by 2002:a92:1a03:: with SMTP id a3mr228720ila.105.1600699881989;
 Mon, 21 Sep 2020 07:51:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 07:51:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbab3a05afd3fb60@google.com>
Subject: KMSAN: uninit-value in hci_event_packet (2)
From:   syzbot <syzbot+54f68ac8e259a8af4f12@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5a13b33 kmsan: clang-format core
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1622db65900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
dashboard link: https://syzkaller.appspot.com/bug?extid=54f68ac8e259a8af4f12
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54f68ac8e259a8af4f12@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_conn_hash_lookup_ba include/net/bluetooth/hci_core.h:960 [inline]
BUG: KMSAN: uninit-value in hci_conn_complete_evt net/bluetooth/hci_event.c:2579 [inline]
BUG: KMSAN: uninit-value in hci_event_packet+0x1438/0x39e30 net/bluetooth/hci_event.c:6058
CPU: 1 PID: 8513 Comm: kworker/u5:1 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci4 hci_rx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 hci_conn_hash_lookup_ba include/net/bluetooth/hci_core.h:960 [inline]
 hci_conn_complete_evt net/bluetooth/hci_event.c:2579 [inline]
 hci_event_packet+0x1438/0x39e30 net/bluetooth/hci_event.c:6058
 hci_rx_work+0x745/0xd20 net/bluetooth/hci_core.c:4889
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:293
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:143 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:126
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2907 [inline]
 __kmalloc_node_track_caller+0x9aa/0x12f0 mm/slub.c:4511
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x35f/0xb30 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1094 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:389 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:165 [inline]
 vhci_write+0x18a/0x890 drivers/bluetooth/hci_vhci.c:285
 call_write_iter include/linux/fs.h:1882 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0xfa8/0x1860 fs/read_write.c:578
 ksys_write+0x275/0x500 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:640
 __ia32_sys_write+0x4a/0x70 fs/read_write.c:640
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
