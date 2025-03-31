Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AD15E97
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448591; cv=none; b=mn9/TZhjnL13VkbGjg5JTrEr2Yecxe8T+5sVKPl1HSiC0/6yk2h50H/KH377GP6yH0YwNhLKjDQzZGjgoT2xcx09H+IggGaDQaVUBWAns4ezzwdx3LDE+QVcn5w4RNFKi/jxmutUuqxU6peMwz+XEAszxRQNLrnubQjnXi6s4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448591; c=relaxed/simple;
	bh=18Pw0mgUTZPK6P3rxpC6vM29vU41Kw7fYKYXkuisqMc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kR1BRNYFnNtyvrmA7y6CIEgA/4BPtOGnMSkzoiWTen3qId97vmBRLgRU1aJ7biU0/dvb/2LVLEPcus/IsRE56vDi/qLLFC6K8EwbabZIQ7GP/LwFI1aaZkB4etN5ShKHMMtz8Ic3lyouyD3tsAqCeU55lrlqr04HzzTGHtlGLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85dd46b20bfso456914439f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448588; x=1744053388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esh/XtQtyGPq1g1MswoyRQBQUBrrz1SRiJehCq4juCg=;
        b=NrsLpY0xTqEkNX3xruVYPhj8x+V/vycm1Z0vny10phkJA2sQuFwYwX33FMRwjiedYm
         9DSqL7ZNvBbdxA41cCRdJZCYW/iHu4sSms2csLDEgZBQWq945Us2klVPN3P1hI1g19hv
         BTL1q3yJr+s0qhrISiwtBPaaBKt1BONZogLQfYQSKGF7AnezRHQwKUYHt/O1IhXLtm59
         6f8E0rx3K0NBQWlS16bDGNqhWHOE0B4K1mXaiaAxiL2gs8gaZU3RZWdpAFlwQzqrK5n8
         67jWMgypQx0AJh8rnceRttd5+963PhvAnFGVwgIoOSCX1bcdgvAWFKlSuhpGkrW4kZEK
         h3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVNc1Q90tBlFfRXiK5iFS+xG3NOpDoo3jWyaaQLrmun6f/Pn5aIL+ZTQQeAnj/b7mFXBvetV1GVOMKZ1/balbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+MOLajt8Cm7wmgRutqKpgBLESh7HtcejGHYKMzaha9CtEcfa
	S9aCGcvf/XaAZDA6gKbURsmpUi2kNJzIFTlb2yZ3FVp/IiwNO52RimseIHbXdx88ALZzjWX+QWB
	M7cCQq8XkTVW4cmUPde6K/wK8zWsrWGp50jpj2gOBIip5s4JA+jLd9xY=
X-Google-Smtp-Source: AGHT+IEbgHgnETiMVNyl6WIXU+Hf6kIrwoytDIPpcB5qnXjh0TKIEkGAZ57DjxqmDQ70TQhiF+15zv8Y993ejzn4suF+C3R3d9gT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3183:b0:3d5:e002:b8ac with SMTP id
 e9e14a558f8ab-3d5e0908e3emr98854025ab.9.1743448588540; Mon, 31 Mar 2025
 12:16:28 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eaea0c.050a0220.1547ec.016b.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in l2cap_conn_del
From: syzbot <syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160183a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179c6498580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/742bdd7166fc/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c22363533ce/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2197dde515b2/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0 Not tainted
------------------------------------------------------
kworker/u9:0/53 is trying to acquire lock:
ffff888035a42840 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
ffff888035a42840 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ffff888035a42840 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4148 [inline]
ffff888035a42840 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: __flush_work+0xe9/0xc60 kernel/workqueue.c:4206

but task is already holding lock:
ffff888035a42b38 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x71/0x690 net/bluetooth/l2cap_core.c:1760

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock#2){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       l2cap_info_timeout+0x60/0xa0 net/bluetooth/l2cap_core.c:1666
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
       worker_thread+0x870/0xd30 kernel/workqueue.c:3398
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       touch_work_lockdep_map kernel/workqueue.c:3920 [inline]
       start_flush_work kernel/workqueue.c:4174 [inline]
       __flush_work+0x739/0xc60 kernel/workqueue.c:4206
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4362
       l2cap_conn_del+0x507/0x690 net/bluetooth/l2cap_core.c:1794
       l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7195
       hci_connect_cfm include/net/bluetooth/hci_core.h:2051 [inline]
       hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
       hci_abort_conn_sync+0xd27/0x1340 net/bluetooth/hci_sync.c:5588
       hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
       worker_thread+0x870/0xd30 kernel/workqueue.c:3398
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->lock#2);
                               lock((work_completion)(&(&conn->info_timer)->work));
                               lock(&conn->lock#2);
  lock((work_completion)(&(&conn->info_timer)->work));

 *** DEADLOCK ***

6 locks held by kworker/u9:0/53:
 #0: ffff888024bc9148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888024bc9148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc90000bd7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000bd7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317
 #2: ffff88805cf6cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88805cf6c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x9ee/0x1340 net/bluetooth/hci_sync.c:5569
 #4: ffff888035a42b38 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x71/0x690 net/bluetooth/l2cap_core.c:1760
 #5: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #5: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #5: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4148 [inline]
 #5: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe9/0xc60 kernel/workqueue.c:4206

stack backtrace:
CPU: 1 UID: 0 PID: 53 Comm: kworker/u9:0 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 touch_work_lockdep_map kernel/workqueue.c:3920 [inline]
 start_flush_work kernel/workqueue.c:4174 [inline]
 __flush_work+0x739/0xc60 kernel/workqueue.c:4206
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4362
 l2cap_conn_del+0x507/0x690 net/bluetooth/l2cap_core.c:1794
 l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7195
 hci_connect_cfm include/net/bluetooth/hci_core.h:2051 [inline]
 hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0xd27/0x1340 net/bluetooth/hci_sync.c:5588
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
