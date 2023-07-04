Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C60EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 08:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGDIKv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGDIKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 04:10:49 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9BBD
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 01:10:48 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262f7a3bc80so7129083a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jul 2023 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458247; x=1691050247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7xwhrlzcysPZgD7raFUrW5vjIVCVs0H5URIJbA37uU=;
        b=SPx11MXl5qsfo6mbvmk3KGuexlydLsI+Q3LLEKd3Tw+o9Y6QsVMgjk35sYMZsEmBtk
         Xtmiz75K/vemdcb/1qsN9MTgIKi2nLzDxW50vxw2w3nhfmE+FYhBOkAgCb+wWSfe4VzA
         NPPjqRzV0nkAbG41zOaEjvO31+JHspKjcLRBtWyLs+rIE5js7lO0eJkCkX79hwPYIVEf
         ewFEt8Qi+fwWDtT5zYFLd78FZVDbso7LcPa5nJ5VcgV+Gv8Ea5ATfSyAcuZk7HGhb/D+
         slLpKVtFiy8h1BJWorlp7LUmblF4KDVPnt50Eppgveflng3R4eTBJiJUR0pyc6tvvtQ5
         QIww==
X-Gm-Message-State: ABy/qLbGr6Eu+NvAymRW9y9tL49M7OZ6vWanMj9BCbetMD95ashkkwVj
        3YJIRJq2Ds0UKourVth5PPj6BtQJwTiya2pT7WPFdc23+WWv
X-Google-Smtp-Source: APBJJlF614BsBKSxk9mPoRcakWxeYZ7WHS+xp5jhGmJU5TV7o4+jcZEV5f0oXUJsx+7U5fnOKazTAJi2RqTP5tzo/673IeePeoDr
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c7d8:b0:262:fc7f:7d95 with SMTP id
 gf24-20020a17090ac7d800b00262fc7f7d95mr9087523pjb.0.1688458247656; Tue, 04
 Jul 2023 01:10:47 -0700 (PDT)
Date:   Tue, 04 Jul 2023 01:10:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011da7605ffa4d289@google.com>
Subject: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From:   syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6352a698ca5b Add linux-next specific files for 20230630
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bce02ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ae0334a93bf3848
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161dadc7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158449fb280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/938bb9b98868/disk-6352a698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4468e2b2789e/vmlinux-6352a698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16555dd478fa/bzImage-6352a698.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com

Bluetooth: hci0: link tx timeout
Bluetooth: hci0: killing stalled connection 11:aa:aa:aa:aa:aa
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4431, name: kworker/u5:1
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:1/4431:
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x8fd/0x16f0 kernel/workqueue.c:2567
 #1: ffffc900070efdb0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: process_one_work+0x930/0x16f0 kernel/workqueue.c:2571
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: hci_link_tx_to net/bluetooth/hci_core.c:3406 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout+0x171/0x480 net/bluetooth/hci_core.c:3541
CPU: 1 PID: 4431 Comm: kworker/u5:1 Not tainted 6.4.0-next-20230630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: hci0 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10188
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
 hci_cmd_sync_queue+0x7b/0xb0 net/bluetooth/hci_sync.c:739
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2906
 hci_disconnect+0xc3/0x220 net/bluetooth/hci_conn.c:258
 hci_link_tx_to net/bluetooth/hci_core.c:3415 [inline]
 __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 __check_timeout+0x2cc/0x480 net/bluetooth/hci_core.c:3541
 hci_sched_le net/bluetooth/hci_core.c:3744 [inline]
 hci_tx_work+0x82b/0x1bb0 net/bluetooth/hci_core.c:3822
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.4.0-next-20230630-syzkaller #0 Tainted: G        W         
-----------------------------
kworker/u5:1/4431 is trying to lock:
ffff888021b149b0 (&hdev->unregister_lock){+.+.}-{3:3}, at: hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u5:1/4431:
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x8fd/0x16f0 kernel/workqueue.c:2567
 #1: ffffc900070efdb0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: process_one_work+0x930/0x16f0 kernel/workqueue.c:2571
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: hci_link_tx_to net/bluetooth/hci_core.c:3406 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout+0x171/0x480 net/bluetooth/hci_core.c:3541
stack backtrace:
CPU: 1 PID: 4431 Comm: kworker/u5:1 Tainted: G        W          6.4.0-next-20230630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: hci0 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4758 [inline]
 check_wait_context kernel/locking/lockdep.c:4828 [inline]
 __lock_acquire+0x15e8/0x5e20 kernel/locking/lockdep.c:5094
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
 hci_cmd_sync_queue+0x7b/0xb0 net/bluetooth/hci_sync.c:739
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2906
 hci_disconnect+0xc3/0x220 net/bluetooth/hci_conn.c:258
 hci_link_tx_to net/bluetooth/hci_core.c:3415 [inline]
 __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 __check_timeout+0x2cc/0x480 net/bluetooth/hci_core.c:3541
 hci_sched_le net/bluetooth/hci_core.c:3744 [inline]
 hci_tx_work+0x82b/0x1bb0 net/bluetooth/hci_core.c:3822
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Bluetooth: hci0: command 0x0406 tx timeout


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
