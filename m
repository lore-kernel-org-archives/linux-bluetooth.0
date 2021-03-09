Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6416523F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 16:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhCIQHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:07:36 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40707 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhCIQHT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Mar 2021 11:07:19 -0500
Received: by mail-io1-f72.google.com with SMTP id x26so10616711ior.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Mar 2021 08:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jv4SOKympZI1lFbKbP+deVJG7+51oX2f6Ly05q3pAJI=;
        b=AiEziafG90lDoZ8SxqMJJK/lt+V3RCVRsqED2TckkUf6EG1j3ZwedZceMjWe9SZ8P3
         ykg8f9d0TTTnPDgMbaGsoBCe2MXlHBq7R/WseOH/JSenGtQfrgdp0mh+1vdj5A/qZJlZ
         YaZZxgviRQvtH7WiHVmSCf0Spc1goCMpyHsP0JhQcxVBDcmEFS/tqRLehZU9CtKL+Hea
         rS2LhMQDNZO2s5gLTWTJbvSsdJI5bQrZwUIjxNTfNFC7LF8eeAPKC+dKMkwKAmIyTgzE
         8hTAWo/m30LySzo0zWeXq3LQ9LlM3Mf1w+vP8N8H/bKJ64vLk75jfEkamvdkiO6IWWtD
         srjw==
X-Gm-Message-State: AOAM5300sZsEU0BB7Irac+d1nUJLaimXYqOCfVnrJVCuddA34WLZ7W19
        leKfOlDDnodkGqKWh6akGLf+NXMX24/nhSKInOwDV3bVSdAv
X-Google-Smtp-Source: ABdhPJywKroXgsWSrwDQGmJl/J5keQvxV4wq7iuLaLdKNKYTb8DKRtQNXIzR0Zoy6Ftv8+b8RhMgInyyPMVQvWvfzY1R0DLBzot6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ac:: with SMTP id f12mr24541349ilr.103.1615306038996;
 Tue, 09 Mar 2021 08:07:18 -0800 (PST)
Date:   Tue, 09 Mar 2021 08:07:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8733205bd1cbead@google.com>
Subject: [syzbot] KASAN: use-after-free Write in h4_recv_buf
From:   syzbot <syzbot+1e678fbc60167d46f2a5@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f818a2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d28ee81eb70698
dashboard link: https://syzkaller.appspot.com/bug?extid=1e678fbc60167d46f2a5
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e678fbc60167d46f2a5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in skb_put_data include/linux/skbuff.h:2293 [inline]
BUG: KASAN: use-after-free in h4_recv_buf+0x3d5/0xd00 drivers/bluetooth/hci_h4.c:200
Write of size 1 at addr ffff88806243d00c by task syz-executor.0/10259

CPU: 0 PID: 10259 Comm: syz-executor.0 Not tainted 5.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 print_address_description+0x5f/0x3a0 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report+0x15e/0x210 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:135 [inline]
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:186
 memcpy+0x3c/0x60 mm/kasan/shadow.c:66
 skb_put_data include/linux/skbuff.h:2293 [inline]
 h4_recv_buf+0x3d5/0xd00 drivers/bluetooth/hci_h4.c:200
 h4_recv+0xf4/0x1b0 drivers/bluetooth/hci_h4.c:115
 hci_uart_tty_receive+0x157/0x490 drivers/bluetooth/hci_ldisc.c:613
 tiocsti drivers/tty/tty_io.c:2317 [inline]
 tty_ioctl+0xc64/0x15f0 drivers/tty/tty_io.c:2718
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb4a52aa188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465f69
RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 00000000004bfa67 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffc4fc6b23f R14: 00007fb4a52aa300 R15: 0000000000022000

Allocated by task 0:
(stack is not available)

Freed by task 9934:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:357
 ____kasan_slab_free+0x100/0x140 mm/kasan/common.c:360
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x171/0x270 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xcf/0x2d0 mm/slub.c:4213
 skb_release_all net/core/skbuff.c:725 [inline]
 __kfree_skb+0x56/0x1d0 net/core/skbuff.c:739
 h4_recv_buf+0xcdb/0xd00 include/net/bluetooth/bluetooth.h:390
 h4_recv+0xf4/0x1b0 drivers/bluetooth/hci_h4.c:115
 hci_uart_tty_receive+0x157/0x490 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x12b/0x170 drivers/tty/tty_buffer.c:465
 tty_port_default_receive_buf+0x6a/0x90 drivers/tty/tty_port.c:38
 receive_buf drivers/tty/tty_buffer.c:481 [inline]
 flush_to_ldisc+0x2f2/0x510 drivers/tty/tty_buffer.c:533
 process_one_work+0x789/0xfd0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff88806243d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 12 bytes inside of
 2048-byte region [ffff88806243d000, ffff88806243d800)
The buggy address belongs to the page:
page:000000004c9987b8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x62438
head:000000004c9987b8 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010842000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88806243cf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806243cf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88806243d000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806243d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806243d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
