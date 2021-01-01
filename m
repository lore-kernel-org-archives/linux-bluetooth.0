Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jan 2021 10:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5427C221EC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jan 2021 10:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbhAAKuE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jan 2021 05:50:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44663 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbhAAKt7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jan 2021 05:49:59 -0500
Received: by mail-il1-f197.google.com with SMTP id c76so19641901ilf.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jan 2021 02:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XcnSZOGxYYohhsPHkjdKLGRKloNPa6y9W/QqGp/OJAY=;
        b=tkkk24fn8vwuaYgBIAqYFVgfFIk4zReoX9Xh9aGO9eBWIRkGm/UjdK8cmgfuRfa0rg
         QVlLPbQRM1Rdn29Vvcnwb5O8u0Uz9ZZwvRghRmVS1cDCe+MBzU1Efk9FhMDdoiPMdpYK
         /uZ3oCEMy0ISH5KGQQYFFf7Fr8chTDTsxmM9JepcX+hHPhq2NjKNwmT0O4KPGmwQkMbL
         19p+BHlwz8T4Tbz+MzwfZLPjPYgTL86eMM2MFTr+aoeXPGroeOM9mBcyTABssaqWEdze
         xzdZd6LsmShGwZjCgz8CuNmI+U2rwyLts4f3jBQvyiPdlnvfRZqunKb3qc2+NvCGRHQ3
         dGKQ==
X-Gm-Message-State: AOAM533TrxElRMJN3NevFR/i7LDFC8u4A+36FowEf6BvAEShTBSBtbdR
        S2PCuWSeDyxF833+Yv85OVk4qtS/4kCQOpJJ59WGWiPWsePg
X-Google-Smtp-Source: ABdhPJyZVAydEHO2VH6i/lKMQxoi05ZoJW4XjE4341O8YbFum77cj4zFrLSrFHoEc+Dp/lMe+4mYnTPeLAxqJzUUVWk+9N4rkuDu
MIME-Version: 1.0
X-Received: by 2002:a6b:ce12:: with SMTP id p18mr3190442iob.181.1609498157748;
 Fri, 01 Jan 2021 02:49:17 -0800 (PST)
Date:   Fri, 01 Jan 2021 02:49:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5964705b7d47d8c@google.com>
Subject: INFO: trying to register non-static key in l2cap_sock_teardown_cb
From:   syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3db1a3fa Merge tag 'staging-5.11-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15dccfb7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae878fbf640b72b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 11241 Comm: kworker/0:9 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:935 [inline]
 register_lock_class+0xf1b/0x10e0 kernel/locking/lockdep.c:1247
 __lock_acquire+0xfc/0x58e0 kernel/locking/lockdep.c:4711
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x780 kernel/locking/lockdep.c:5402
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3049
 l2cap_sock_teardown_cb+0xa1/0x660 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xbc/0xaa0 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x1bc/0xaf0 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x17e/0x2f0 net/bluetooth/l2cap_core.c:436
 process_one_work+0x868/0x15c0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
==================================================================
BUG: KASAN: slab-out-of-bounds in l2cap_sock_teardown_cb+0x5c9/0x660 net/bluetooth/l2cap_sock.c:1522
Read of size 8 at addr ffff8880688f04c8 by task kworker/0:9/11241

CPU: 0 PID: 11241 Comm: kworker/0:9 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 l2cap_sock_teardown_cb+0x5c9/0x660 net/bluetooth/l2cap_sock.c:1522
 l2cap_chan_del+0xbc/0xaa0 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x1bc/0xaf0 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x17e/0x2f0 net/bluetooth/l2cap_core.c:436
 process_one_work+0x868/0x15c0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 20015:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 ops_init+0xfb/0x4a0 net/core/net_namespace.c:142
 setup_net+0x2de/0x850 net/core/net_namespace.c:342
 copy_net_ns+0x376/0x7b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xbd/0x230 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x8e0 kernel/fork.c:2957
 __do_sys_unshare kernel/fork.c:3025 [inline]
 __se_sys_unshare kernel/fork.c:3023 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3023
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0xc0/0xf0 mm/kasan/generic.c:343
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x730 kernel/rcu/tree.c:3038
 netlink_release+0xe86/0x1e10 net/netlink/af_netlink.c:802
 __sock_release+0xcd/0x280 net/socket.c:597
 sock_close+0x18/0x20 net/socket.c:1256
 __fput+0x285/0x930 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:168
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xbbc/0x2c60 kernel/exit.c:823
 do_group_exit+0x125/0x310 kernel/exit.c:920
 __do_sys_exit_group kernel/exit.c:931 [inline]
 __se_sys_exit_group kernel/exit.c:929 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:929
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880688f0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1224 bytes inside of
 2048-byte region [ffff8880688f0000, ffff8880688f0800)
The buggy address belongs to the page:
page:000000000a58198a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x688f0
head:000000000a58198a order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888011042000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880688f0380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880688f0400: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880688f0480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                              ^
 ffff8880688f0500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880688f0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
