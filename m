Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D44CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 08:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659086113B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 08:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHSIU5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:20:57 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42996 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhHSIUy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 04:20:54 -0400
Received: by mail-il1-f199.google.com with SMTP id z14-20020a92d18e0000b029022418b34bc9so2838787ilz.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 01:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oaWnN+7gs3kNFPGP192wJn3YOjuZ3/Mij5Ig6GsqNic=;
        b=ug1zH4W/taLhT/Jw5qgVX5CyHNC4jwOzQRZ+GujbiFPYjBRhkd0ePbtYXzrvUrZCEX
         FurOAghUE0utc8XYn6hyV0LVcQNyn1HMtXj5u/JQl1Cmt2zAyhC+089nAEwbXu9NEI6t
         wkxBpCZybZOh1jTB/1iFpKs7Gz6+tqnCNT2C6AjQZG3otksDXHFE9BbRARYJHGOehXIL
         EW3YXGIO5jKt9DR87n8HC4vzVltf40toWuv1I25iXjr1xb+JQgrmmDdxaRzbV9Uy+8cv
         Ity4Gx3B2cvE17bBGSYl89B+CV6sYc/0a0KgIlhKmFCDteQeaOU59mxgsK3Nt3wckFG8
         VSDw==
X-Gm-Message-State: AOAM531EK+BABZmJntARmUy1CBpyGCv1T4RzdfqKVnS8sj5isa6fI0EQ
        P9rvgUMWHqEemBlY0ldZ1yKnfXw+3acWVNE2wT5RzhihdlVK
X-Google-Smtp-Source: ABdhPJyBPe4hMt9C+eRtkL7ptD76ylZErwT2Lt0Z6LTH3yzMwkTaieO9Ivb20V/hf5A4q29c0zcHnzAuIdMJbXSXhKYtZNf/cW/5
MIME-Version: 1.0
X-Received: by 2002:a5d:9855:: with SMTP id p21mr10692705ios.206.1629361218596;
 Thu, 19 Aug 2021 01:20:18 -0700 (PDT)
Date:   Thu, 19 Aug 2021 01:20:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5339205c9e53883@google.com>
Subject: [syzbot] KASAN: use-after-free Read in h4_recv_buf
From:   syzbot <syzbot+a06c3db558cbb33d7ff9@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c60610d4767 Linux 5.14-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1222cb45300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=a06c3db558cbb33d7ff9
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f96ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b3629300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14278745300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16278745300000
console output: https://syzkaller.appspot.com/x/log.txt?x=12278745300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a06c3db558cbb33d7ff9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in h4_recv_buf+0x946/0xd50 drivers/bluetooth/hci_h4.c:199
Read of size 2 at addr ffff8880359e3b6a by task kworker/u4:7/8608

CPU: 0 PID: 8608 Comm: kworker/u4:7 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 h4_recv_buf+0x946/0xd50 drivers/bluetooth/hci_h4.c:199
 h4_recv+0xf4/0x1b0 drivers/bluetooth/hci_h4.c:115
 hci_uart_tty_receive+0x1d2/0x4a0 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x128/0x170 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x6a/0x90 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x2f2/0x510 drivers/tty/tty_buffer.c:543
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 8616:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x96/0xd0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:2959 [inline]
 kmem_cache_alloc_node+0x200/0x370 mm/slub.c:2995
 __alloc_skb+0xd8/0x580 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1112 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:389 [inline]
 h4_recv_buf+0x274/0xd50 drivers/bluetooth/hci_h4.c:181
 h4_recv+0xf4/0x1b0 drivers/bluetooth/hci_h4.c:115
 hci_uart_tty_receive+0x1d2/0x4a0 drivers/bluetooth/hci_ldisc.c:613
 tiocsti drivers/tty/tty_io.c:2311 [inline]
 tty_ioctl+0xde5/0x1720 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8460:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
 ____kasan_slab_free+0x109/0x150 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1628 [inline]
 slab_free_freelist_hook+0x1d8/0x290 mm/slub.c:1653
 slab_free mm/slub.c:3213 [inline]
 kmem_cache_free+0x85/0x170 mm/slub.c:3229
 hci_event_packet+0x1238/0x1bd0 net/bluetooth/hci_event.c:6400
 hci_rx_work+0x229/0x410 net/bluetooth/hci_core.c:5120
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff8880359e3b40
 which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 42 bytes inside of
 232-byte region [ffff8880359e3b40, ffff8880359e3c28)
The buggy address belongs to the page:
page:ffffea0000d678c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x359e3
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000df2c80 0000000200000002 ffff8881445f9140
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6468, ts 40643694449, free_ts 40631410813
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4169
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5391
 alloc_slab_page mm/slub.c:1691 [inline]
 allocate_slab+0xf1/0x540 mm/slub.c:1831
 new_slab mm/slub.c:1894 [inline]
 new_slab_objects mm/slub.c:2640 [inline]
 ___slab_alloc+0x1cf/0x350 mm/slub.c:2803
 __slab_alloc mm/slub.c:2843 [inline]
 slab_alloc_node mm/slub.c:2925 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc+0x299/0x340 mm/slub.c:2972
 skb_clone+0x1b4/0x360 net/core/skbuff.c:1516
 do_one_broadcast net/netlink/af_netlink.c:1447 [inline]
 netlink_broadcast_filtered+0x63f/0x1110 net/netlink/af_netlink.c:1522
 netlink_broadcast net/netlink/af_netlink.c:1546 [inline]
 netlink_sendmsg+0x953/0xe00 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg net/socket.c:723 [inline]
 ____sys_sendmsg+0x5a2/0x900 net/socket.c:2392
 ___sys_sendmsg net/socket.c:2446 [inline]
 __sys_sendmsg+0x319/0x400 net/socket.c:2475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page+0x7e/0x550 mm/page_alloc.c:3411
 free_slab mm/slub.c:1934 [inline]
 discard_slab mm/slub.c:1940 [inline]
 __slab_free+0x5c0/0x6b0 mm/slub.c:3143
 do_slab_free mm/slub.c:3201 [inline]
 ___cache_free+0xfc/0x120 mm/slub.c:3220
 qlist_free_all mm/kasan/quarantine.c:165 [inline]
 kasan_quarantine_reduce+0x151/0x1c0 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:2959 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 __kmalloc+0x229/0x390 mm/slub.c:4111
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_realpath_from_path+0xd8/0x610 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x2d1/0xb30 security/tomoyo/file.c:922
 tomoyo_path_rename+0x148/0x190 security/tomoyo/tomoyo.c:278
 security_path_rename+0x21b/0x2e0 security/security.c:1190
 do_renameat2+0x779/0x1440 fs/namei.c:4693
 __do_sys_rename fs/namei.c:4755 [inline]
 __se_sys_rename fs/namei.c:4753 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4753
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff8880359e3a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880359e3a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>ffff8880359e3b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff8880359e3b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880359e3c00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
