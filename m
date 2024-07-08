Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3A14900B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462948; cv=none; b=vAc5gHPPkj/dUrigLVH25lK/tvsKdoDNub5kJJvQ00lNlzR3tgh1+/QkwnBSTruspbg8QbRRewo3KwbDlnRRJ+iJUZRfArDH7KzTl8li8NZKGsm8UAGzOPpkBJlXluvx2PRtLOaifJNOSIG8s6NVMV/zKfDjLQ2P41tA8BwE2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462948; c=relaxed/simple;
	bh=aRGDC6gmTgQfGpcwiYAT3srhL18Ir47s2Glp7oGqeFA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RV8iAeV6AP/yANAkMBYZ5rkp2vA7ViJ8++RSqdEXHCQwjd9dp/19UrJLaKH4GO1z03hTcZ11NcX/ivDgfSkItMuiyDXQdsEQmuSKp5hbbbv21sJCXBsQTewqZ9rKaJbAsc7mpHmmtxgWQQwjTnW8FQccxC/41Z0eiObRFAKtW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-382612d363dso42626925ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 11:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462945; x=1721067745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVplHr4x3Pa02WuXA0IeXUifs8VKkHRpgLGdCbMIJPU=;
        b=Q8Y518paVydn1cJpfz+Tkk1BzCKC3Omqrpge3zGTSVj8zqvYpotEY27eGcdmGOVqy/
         /uA6uR4+W8sHOFL1m7viAXumftPxTTTume/G8vfw8TvgGHUza2u4Ong1kzcsKD/Z1WcW
         nABs6PyHtQqq5esdbJ+pyP1jw9FrWKw0I91aKZ/vawqxpWdgUXhKw7R4mDQl4MWZWw91
         5TNC7/lQd4vZAI7kYAytAU/MB5XyDVQSp2fV3qcoV4m+UahfvEyNFN9s/Ust0Md2ciuR
         0ZdNrmgSRBwyT4hBKrsqPAmwMnVayy5t5OQEl9Pr1DEER8se7EEwZ7iZZ/uWnCaUWW5G
         CbTw==
X-Forwarded-Encrypted: i=1; AJvYcCWFh83j+Pr85aV+0ZI3mSI1znzueQ2fYYHIIO4Hxe1+gbmTuhb7RBBWsbNP2f42E2/SdxrJ0/k8zysuB///ziDTF7nqaAPMYwQ2SGJKeiGJ
X-Gm-Message-State: AOJu0Yw7TcGYRZCv7TflZkPslkT7zvVWZsAO2GlJ5erDZkM75+PUtDqQ
	1N2F1/day0R+9iI1YNI7wQ80r+NxALQ5ojcXk1IeJv6c3JLfPUg+ClPf35oetG5ApgVyL01WutN
	B8m6dmd6mcDbstyL8lavrK9G8a8E3ruodo3tiToW3rHD0leEgdjDcjrI=
X-Google-Smtp-Source: AGHT+IF39g0hBFHd7X+jwRYDyZL6ruwP3QAzOIRZhd7W/PuSIMV1ZtlecqyqLtPEmN2SCAQtp/CzJNqBeKOqiYLwyPsJAcZAZJA9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6a11:0:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-38a5901530dmr63835ab.3.1720462944940; Mon, 08 Jul 2024 11:22:24
 -0700 (PDT)
Date: Mon, 08 Jul 2024 11:22:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aecb64061cc07e9b@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in sco_connect_cfm
From: syzbot <syzbot+0068c4f72ae17f8a1605@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d270dd21bee0 Merge tag 'pci-v6.10-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1009bb81980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=0068c4f72ae17f8a1605
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/119d89656b6c/disk-d270dd21.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a5dce1ccbf0/vmlinux-d270dd21.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7b7e333da4e/bzImage-d270dd21.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0068c4f72ae17f8a1605@syzkaller.appspotmail.com

Bluetooth: hci6: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci6: unexpected cc 0x1003 length: 249 > 9
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0 Not tainted
------------------------------------------------------
kworker/u9:2/5087 is trying to acquire lock:
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_conn_ready net/bluetooth/sco.c:1290 [inline]
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362

but task is already holding lock:
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1277 [inline]
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x28a/0xb40 net/bluetooth/sco.c:1362

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock#2){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       sco_chan_add net/bluetooth/sco.c:234 [inline]
       sco_connect net/bluetooth/sco.c:287 [inline]
       sco_sock_connect+0x347/0x990 net/bluetooth/sco.c:596
       io_connect+0xa4/0x4f0 io_uring/net.c:1687
       io_issue_sqe+0x3cf/0x14f0 io_uring/io_uring.c:1751
       io_queue_sqe io_uring/io_uring.c:1965 [inline]
       io_submit_sqe io_uring/io_uring.c:2221 [inline]
       io_submit_sqes+0xaff/0x1bf0 io_uring/io_uring.c:2336
       __do_sys_io_uring_enter io_uring/io_uring.c:3245 [inline]
       __se_sys_io_uring_enter+0x2d4/0x2670 io_uring/io_uring.c:3182
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3534
       lock_sock include/net/sock.h:1602 [inline]
       sco_conn_ready net/bluetooth/sco.c:1290 [inline]
       sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
       hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
       hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
       hci_event_func net/bluetooth/hci_event.c:7444 [inline]
       hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
       hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
       process_one_work kernel/workqueue.c:3248 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
       worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->lock#2);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);
                               lock(&conn->lock#2);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);

 *** DEADLOCK ***

5 locks held by kworker/u9:2/5087:
 #0: ffff8880764d1948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff8880764d1948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000377fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000377fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff88802d30c078 (&hdev->lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0xb1/0xaa0 net/bluetooth/hci_event.c:4926
 #3: ffffffff8f73f008 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1967 [inline]
 #3: ffffffff8f73f008 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0x532/0xaa0 net/bluetooth/hci_event.c:5009
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1277 [inline]
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x28a/0xb40 net/bluetooth/sco.c:1362

stack backtrace:
CPU: 1 PID: 5087 Comm: kworker/u9:2 Not tainted 6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 lock_sock_nested+0x48/0x100 net/core/sock.c:3534
 lock_sock include/net/sock.h:1602 [inline]
 sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
 hci_event_func net/bluetooth/hci_event.c:7444 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3536
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5087, name: kworker/u9:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5087 Comm: kworker/u9:2 Not tainted 6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
 lock_sock_nested+0x5d/0x100 net/core/sock.c:3536
 lock_sock include/net/sock.h:1602 [inline]
 sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
 hci_event_func net/bluetooth/hci_event.c:7444 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: hci6: unexpected cc 0x0c23 length: 249 > 4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
