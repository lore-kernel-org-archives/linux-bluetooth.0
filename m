Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB31C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CB64E14
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 17:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhA1RKB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 12:10:01 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45430 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhA1RJF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 12:09:05 -0500
Received: by mail-il1-f197.google.com with SMTP id h17so5259600ila.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 09:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iMgiKRg70Lra0mXCP8D8J7CuBwTc7mN0HC1eg964rfM=;
        b=C7hzWWzHYuVlh6OoheU94GPUWdc2Bv0qsMA2utCaqz1SuCTNs7qJ/vZp3vy/r5Y+sL
         skqrd1QntpOTG/E7m2xBDsECbHMh3pBgAAIqcdo08VcbP4BnD7vYSMQt2Gwtl2uaqT68
         SsRKKiV3Edw5pp7obIOB9OwT7CAA5A14/2wj+lzgKFBrgOKHW9j2mXsh5pIT/pCOCQYI
         6v29Bs/j/tiD6luAjE1DUOnoT/C+n5eN7NhA/oHiKsPYJ5A2GhTZGmk5hQJmCCZDSQyP
         6OztVYULsYYOJA6w5Pz3ZKA2y9lL4teK3soD9c5LdHxlMmsd/F3bYhJOCOC5a0FKUVyX
         0EIQ==
X-Gm-Message-State: AOAM533ssX4/JDmuSA7+NH9MxaYkP77ZDyMN5PV0CZXX1taVNaVcw1TC
        OYQjUfrFps1V++l+a8gS2O27X/Qt3cmghX/xw+LNeG/hzbLY
X-Google-Smtp-Source: ABdhPJyiCvEMLhyd4shG27KcjlKed0JOuIyzGEKC8RgNeJt4kNEMTQBd1FwXL06gMOjDe8qbxMuhM9g1x33o3JGzEsAg84wlBJ1d
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:: with SMTP id p7mr994ilo.93.1611853704127;
 Thu, 28 Jan 2021 09:08:24 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:08:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ecf305b9f8efb1@google.com>
Subject: KASAN: slab-out-of-bounds Read in add_adv_patterns_monitor
From:   syzbot <syzbot+3ed6361bf59830ca9138@syzkaller.appspotmail.com>
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

HEAD commit:    b491e6a7 net: lapb: Add locking to the lapb module
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17ba0f2cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be33d8015c9de024
dashboard link: https://syzkaller.appspot.com/bug?extid=3ed6361bf59830ca9138
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10628ae8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12964b80d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ed6361bf59830ca9138@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: slab-out-of-bounds in add_adv_patterns_monitor+0x91f/0xa90 net/bluetooth/mgmt.c:4266
Read of size 1 at addr ffff888013251b29 by task syz-executor387/8480

CPU: 1 PID: 8480 Comm: syz-executor387 Not tainted 5.11.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 add_adv_patterns_monitor+0x91f/0xa90 net/bluetooth/mgmt.c:4266
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1603 [inline]
 hci_sock_sendmsg+0x1b98/0x21d0 net/bluetooth/hci_sock.c:1738
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 sock_write_iter+0x289/0x3c0 net/socket.c:999
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447579
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe0f4194b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000447579
RDX: 0000000000000009 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000018e1914 R08: 00000000018e1914 R09: 00007ffe0f4194a0
R10: 00007ffe0f4194c0 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000072 R14: 00000000018e1914 R15: 0000000000000000

Allocated by task 8480:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
 kmalloc include/linux/slab.h:557 [inline]
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1508 [inline]
 hci_sock_sendmsg+0x9b8/0x21d0 net/bluetooth/hci_sock.c:1738
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 sock_write_iter+0x289/0x3c0 net/socket.c:999
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888013251b20
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 9 bytes inside of
 16-byte region [ffff888013251b20, ffff888013251b30)
The buggy address belongs to the page:
page:00000000a4467645 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13251
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea00004ed440 0000000300000003 ffff888010041b40
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888013251a00: fb fb fc fc fb fb fc fc 00 00 fc fc fb fb fc fc
 ffff888013251a80: 00 00 fc fc 00 00 fc fc fb fb fc fc 00 00 fc fc
>ffff888013251b00: 00 00 fc fc 00 01 fc fc fb fb fc fc fa fb fc fc
                                  ^
 ffff888013251b80: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff888013251c00: fa fb fc fc fa fb fc fc 00 00 fc fc fa fb fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
