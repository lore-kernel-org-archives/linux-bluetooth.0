Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FECC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 09:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiHVJbS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiHVJac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 05:30:32 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB962F64F
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 02:30:29 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h8-20020a92c268000000b002e95299cff0so5237394ild.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 02:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+GeY2Z9JkjROxefibd/WKD8kc2gQfMs0/5C3Ccicj1g=;
        b=vKZeyweK6JNG79rg26VThcztE469xEbMH4XO/IlWmLH5M6KVzAllnjEhpvzACethcl
         4ezBtDY+WKcmbDc2MlaXby0TzbchIKZ+X1wp7/V1ne+xx7KJh1iLtlNgxRUkumiFxhkT
         hegUBlNMUziDkxHUXGWemcpGnxEFvBxQFgoKb4VNlyKDSFinEomdu1rphiBnJh7fPtoM
         oB6yEw3TcU1ST8mvYst219RxdzApEBCiJmxQyyDc7lgRjUwb1/on7o0XCeLsEDacNkwk
         r9RB4Rs3In7yQwoZoLXvMxpwHPQl2YPnwxd4Ea07EXg4ykOPzgSN/X7CEWGKPDoQRkhS
         exMw==
X-Gm-Message-State: ACgBeo0PB4xxvjDOLQuUKxdmTiCY/FbO+tWpF98/xKubqq/d/w96XC56
        PECvc015FjyBKfyBqccm9VfSqr9nLLDYI38JMMJvYMk/GZoa
X-Google-Smtp-Source: AA6agR7BlTUJA81FGaMlPyefzNhku1rXRyfjGXIwkXKYzpl8hRcHebJdo5wW8ROs3I8GzbIctgJmFBIp5SwOLI1unVPskDOqZDwF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1074:b0:2e9:5068:9dd0 with SMTP id
 q20-20020a056e02107400b002e950689dd0mr6255315ilj.57.1661160629247; Mon, 22
 Aug 2022 02:30:29 -0700 (PDT)
Date:   Mon, 22 Aug 2022 02:30:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038a5d805e6d119e4@google.com>
Subject: [syzbot] possible deadlock in hci_unregister_dev
From:   syzbot <syzbot+c933391d8e4089f1f53e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5b6a4bf680d6 Add linux-next specific files for 20220818
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea94b5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c933391d8e4089f1f53e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc1-next-20220818-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/21304 is trying to acquire lock:
ffff8880751049a8 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}, at: __flush_work+0xdd/0xae0 kernel/workqueue.c:3066

but task is already holding lock:
ffff888075104078 (&hdev->lock){+.+.}-{3:3}, at: hci_unregister_dev+0x347/0x4e0 net/bluetooth/hci_core.c:2687

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       discov_off+0x88/0x1a0 net/bluetooth/mgmt.c:1033
       process_one_work+0x991/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e4/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

-> #0 ((work_completion)(&(&hdev->discov_off)->work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       __flush_work+0x105/0xae0 kernel/workqueue.c:3069
       __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3160
       mgmt_index_removed+0x218/0x340 net/bluetooth/mgmt.c:8951
       hci_unregister_dev+0x34f/0x4e0 net/bluetooth/hci_core.c:2688
       vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
       __fput+0x27c/0xa90 fs/file_table.c:320
       task_work_run+0xdd/0x1a0 kernel/task_work.c:177
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xc39/0x2b60 kernel/exit.c:814
       do_group_exit+0xd0/0x2a0 kernel/exit.c:944
       get_signal+0x238c/0x2610 kernel/signal.c:2858
       arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
       exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
       exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
       __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
       syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->lock);
                               lock((work_completion)(&(&hdev->discov_off)->work));
                               lock(&hdev->lock);
  lock((work_completion)(&(&hdev->discov_off)->work));

 *** DEADLOCK ***

1 lock held by syz-executor.5/21304:
 #0: ffff888075104078 (&hdev->lock){+.+.}-{3:3}, at: hci_unregister_dev+0x347/0x4e0 net/bluetooth/hci_core.c:2687

stack backtrace:
CPU: 1 PID: 21304 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220818-syzkaller #0
syz-executor.5[21304] cmdline: ��a�����
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __flush_work+0x105/0xae0 kernel/workqueue.c:3069
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3160
 mgmt_index_removed+0x218/0x340 net/bluetooth/mgmt.c:8951
 hci_unregister_dev+0x34f/0x4e0 net/bluetooth/hci_core.c:2688
 vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xc39/0x2b60 kernel/exit.c:814
 do_group_exit+0xd0/0x2a0 kernel/exit.c:944
 get_signal+0x238c/0x2610 kernel/signal.c:2858
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce942adfa1
Code: Unable to access opcode bytes at RIP 0x7fce942adf77.
RSP: 002b:00007fce954540b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007fce9439bf80 RCX: 00007fce942adfa1
RDX: 00007fce954540f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fce942e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fff7d48034f R14: 00007fce95454300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
