Return-Path: <SRS0=ukjF=ZX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC2EC432C3
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 01:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBF12084D
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 01:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLABPL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:15:11 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:46849 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLABPL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 20:15:11 -0500
Received: by mail-io1-f69.google.com with SMTP id b186so10558963iof.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2019 17:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vdA+Pl+l1f6sCTYEO0wEzF5xZZ/NEuBoxJ/fDOritgw=;
        b=aVtgPntiA7KWouP36qA/yK16FR7sHy1frsmTK48JXV7gX7lz6bKr71IlH9O/j9UDql
         VsIyBKLGTejXkwoWvgIEZhCuEhx+bJgmSzBGj5OmB7KvCONrJ40kWwbtpOY32y+602H4
         P/YuupeVHVKaQz+ZluueuQM5Yg6P8GrFs5gqP46Hn1dgzaTAWKnfHKSQX6mp1P5+eNOD
         gbS1wNAQ2A0nHNmjYk5IRC4Oxmm6T3Tpdi/0AqNbU9GCoVc+Q/D6kx98I2yOdXEQ52x8
         z9IdAtfYGCfuPaHvLVhGYeJswUOOnFIV1duqjW4jbrbp8Dqsx9OMDhAE0Jsd4Ce51+/L
         XznQ==
X-Gm-Message-State: APjAAAWaXXbM+CdBURJTZdQVmDgto9gdZu0spK2nKZfAF3bLFc4VGUY5
        5kQS1+rX91ohQepk59thsmZV/CwWlqyep5AsgXe16TSPiKGN
X-Google-Smtp-Source: APXvYqxAhPSnP4G/gEEYfgHPhOC4baFmRSGw7Q/tzVwChglVkhh0i0Dii8mLZun0KGQjJ1DD0rsLTzIQOONdpJ9N55bQy8SZ9Z9t
MIME-Version: 1.0
X-Received: by 2002:a6b:ca41:: with SMTP id a62mr40117949iog.217.1575162909157;
 Sat, 30 Nov 2019 17:15:09 -0800 (PST)
Date:   Sat, 30 Nov 2019 17:15:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9f2eb05989a31cf@google.com>
Subject: INFO: trying to register non-static key in hci_uart_tty_receive (2)
From:   syzbot <syzbot+633817d309aae1e0cfce@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    be2eca94 Merge tag 'for-linus-5.5-1' of git://github.com/c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bdb5eee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a7e892e3a014d76
dashboard link: https://syzkaller.appspot.com/bug?extid=633817d309aae1e0cfce
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+633817d309aae1e0cfce@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 26945 Comm: syz-executor.1 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
  hci_uart_tty_receive+0xcf/0x6e0 drivers/bluetooth/hci_ldisc.c:603
  tiocsti drivers/tty/tty_io.c:2197 [inline]
  tty_ioctl+0x949/0x14f0 drivers/tty/tty_io.c:2573
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a649
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa162c03c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a649
RDX: 00000000200001c0 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa162c046d4
R13: 00000000004c52f0 R14: 00000000004da410 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
