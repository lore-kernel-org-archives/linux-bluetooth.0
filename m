Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0199C83014
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06302084C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 10:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgLAKbB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:31:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:49841 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLAKa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 05:30:58 -0500
Received: by mail-io1-f72.google.com with SMTP id v15so950927ioq.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 02:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LnGh/kj+vjT8bBp6zIAdmGeuUMdRP3zSK+My+D46Z4Q=;
        b=LWuGg879XZsGxhm67eN095zouHwxwbrUWyoyVoVd80fqV7oGc4Ee0dwNAvqwuJTQcx
         SSnQVu8gJTYZK+9CPiQpS0ix3R1dN4pzvRIUe9fY1+rM2ETDSPqmtN/rvk0ADq9n202X
         6pIHLy2D2Wm+9lCb28658/n2bgvgJF7ffW9lFVUIxJ8bgfk0IkmsWhUbWvE8/bx80TeV
         SyKpImfDKdpjFXwXbt2u6PHW060/R4u1EI4GSCsv4AHMS5YM9zAGWjDfgD+npugz74U+
         zKte1s0DxypOjpLThLaUVbotGkmRDSppnTaJ2znWlZ5Sw54vIkW0Gy23iGYCp/iJYuqS
         QVyA==
X-Gm-Message-State: AOAM532vZtZtIMLG9A59AEKS7GXCI/MWA2o437J/t71ajZpFhd0jU+QF
        HpLIennlPGvnzBcHHqIO20GCr4on7ej6lbhMXtzQNO3Lh8Od
X-Google-Smtp-Source: ABdhPJxM0XF90tKHRpoDQ7KGp3XQzHr8nrDlkeKx9eaEUgmXCymcKnpJeIfNMMFwNR4BQ4KCtjyldDA5iq5F5qn/y0RYvfwQ1EGH
MIME-Version: 1.0
X-Received: by 2002:a5e:841a:: with SMTP id h26mr282071ioj.54.1606818617777;
 Tue, 01 Dec 2020 02:30:17 -0800 (PST)
Date:   Tue, 01 Dec 2020 02:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee624105b5649cc7@google.com>
Subject: KASAN: global-out-of-bounds Read in lock_sock_nested
From:   syzbot <syzbot+92de81bbc21385b15723@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e6bca3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=92de81bbc21385b15723
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92de81bbc21385b15723@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in instrument_atomic_read include/linux/instrumented.h:56 [inline]
BUG: KASAN: global-out-of-bounds in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: global-out-of-bounds in __lock_acquire+0xfa0/0x5780 kernel/locking/lockdep.c:4411
Read of size 8 at addr ffffffff890f9b18 by task kworker/1:0/17

CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 __lock_acquire+0xfa0/0x5780 kernel/locking/lockdep.c:4411
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3048
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the variable:
 rtl8150_table+0x9f8/0x26e0

Memory state around the buggy address:
 ffffffff890f9a00: 00 05 f9 f9 f9 f9 f9 f9 00 00 00 06 f9 f9 f9 f9
 ffffffff890f9a80: 00 00 05 f9 f9 f9 f9 f9 00 00 00 f9 f9 f9 f9 f9
>ffffffff890f9b00: 00 00 07 f9 f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9
                            ^
 ffffffff890f9b80: 00 00 07 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
 ffffffff890f9c00: 07 f9 f9 f9 f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
