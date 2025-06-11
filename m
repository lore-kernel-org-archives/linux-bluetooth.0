Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCB2749E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645461; cv=none; b=q6ioynHglOqJHzhJ+oHKg64wzJxqmM+sNtejuQhr4jyLgktKZDPg9UpEpXcFUUb9V2julaJo7fq9HO0wk1D2tLzymRwkWqYc8R6zygfY613HBcM72HMKi8+TDyL+9Xnh8YshfMWm3ENKhIWtxnqMScilHCtHrCzWInEObq/2Zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645461; c=relaxed/simple;
	bh=2HLrDOPNZdq62ucQ+Y1DQnr/AJVuu/EHwUGnBo+PDyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CeTE9N0VEpj1e/fNXYhglR3vEmRcgke+VQ6c9Fd7cAnKVWD2tzeQsop/RXyGvwQVijhAZJD/CJ8f+TsKvPJDlpZs5vSlrP8FA72DO5JgeI0dZKGwsnP7gNs5OsGptbYxpk0P9HcIGHJAxDAODUPXwDM8VZ7hWUOBbBVUVlWgaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddbb34fc1cso77044405ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 05:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645457; x=1750250257;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXiKq8/RoTR7rMaHJR0kvL3hXyFSCdnBgFNfuKjvLE4=;
        b=wDn1UkwgcGiixNhF1bSibHIhNbwLktp/5OwuiYYuWAFjRS5uNW3ZiqfBrfbQWlk2+a
         Gv+aKl2U9dSfvxyEL84m3w9H3i1UYbYPaV4uVOCYw/CtrWV+VTMlZRMMLbaZ57p5aKIk
         so+ysvOCVxFDit+k1YEKXJvb1mRd1qCffFkvcxzsVvyXZ7L6epSmxIzc/eMSCc8a1YMl
         7JI1i7fj8pP66m6xMyv833AYS8n7EW/XZj/w0mMSQeOEPL067t/6vy0qRaK3jP50/b6r
         qocdX8GMT/1vjmgtuBNyVNCQkT8E3nkfedHQKP24rf3yXOAfIgFI46Qzzmo0zWe8dX/h
         37xA==
X-Forwarded-Encrypted: i=1; AJvYcCX4ajfSzSH85Wz3WXmmTU2Q/k/l4pIZokQVxqdyBczOsu/7YYIqlf1mBKMQ6lrDtrEHUwaXYkK98BVc6WrTjx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNxdjmHIUhH1RGxVZpjTbXeM5UQCkYG5LMIiucLcwqsPw/jLN
	OmuXf+G9tqvQ0c7r/DxOnBfcdtTv+pOSPUSFIwhdpwzQbodIAv9A3ziC/HBtuVkOIvMgBk1n5dk
	GKI2UgxtOpIB6LppssFUGC0/daWr7yCNTrxi1WNnAm/hs89CBxaQMsDvnd6Q=
X-Google-Smtp-Source: AGHT+IHMOigKajXwdHFiIom5SBGfHro+cI+OsEtKjDpxYftd4NyAq65+1wk2XnKnfG2wVEFnuAaNHrro7HSCMRkznXit6KMuipNs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3dc:8423:5440 with SMTP id
 e9e14a558f8ab-3ddf4147fbbmr30528415ab.0.1749645456921; Wed, 11 Jun 2025
 05:37:36 -0700 (PDT)
Date: Wed, 11 Jun 2025 05:37:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68497890.050a0220.33aa0e.036d.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed (4)
From: syzbot <syzbot+54284733aab8a9e6afcf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8630c59e9936 Merge tag 'kbuild-v6.16' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1301120c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd0cea6d0f67318f
dashboard link: https://syzkaller.appspot.com/bug?extid=54284733aab8a9e6afcf
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f53570580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8630c59e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79b02179fbaf/vmlinux-8630c59e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2abed662b9c4/bzImage-8630c59e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54284733aab8a9e6afcf@syzkaller.appspotmail.com

INFO: task kworker/u5:0:45 blocked for more than 175 seconds.
      Not tainted 6.15.0-syzkaller-13743-g8630c59e9936 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:0    state:D stack:26520 pid:45    tgid:45    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6935
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
 hci_abort_conn_sync+0x5d1/0xdf0 net/bluetooth/hci_sync.c:5620
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u5:4:5760 blocked for more than 175 seconds.
      Not tainted 6.15.0-syzkaller-13743-g8630c59e9936 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:4    state:D stack:27496 pid:5760  tgid:5760  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: hci1 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6935
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
 hci_abort_conn_sync+0x5d1/0xdf0 net/bluetooth/hci_sync.c:5620
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u5:5:5769 blocked for more than 175 seconds.
      Not tainted 6.15.0-syzkaller-13743-g8630c59e9936 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:5    state:D stack:27528 pid:5769  tgid:5769  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: hci2 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6935
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
 hci_abort_conn_sync+0x5d1/0xdf0 net/bluetooth/hci_sync.c:5620
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8e13f060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f060 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
5 locks held by kworker/u5:0/45:
 #0: ffff88803f230948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88803f230948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc90000a27bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000a27bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888055b48d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888055b48078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
5 locks held by kworker/u5:1/4680:
 #0: ffff888011ab1148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888011ab1148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000225fbc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000225fbc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888011b6cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888011b6c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8e144b78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:336 [inline]
 #4: ffffffff8e144b78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:998
2 locks held by getty/5120:
 #0: ffff8880384b90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000018e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by kworker/0:4/5428:
 #0: ffff88801a474d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a474d48 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc90002857bc0 (free_ipc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90002857bc0 (free_ipc_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffffffff8e144b78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:336 [inline]
 #2: ffffffff8e144b78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:998
6 locks held by kworker/u5:3/5441:
 #0: ffff888053f23148 ((wq_completion)hci3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888053f23148 ((wq_completion)hci3){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc90002a1fbc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90002a1fbc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888052104d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888052104078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
 #5: ffff8880559fa338 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x70/0x680 net/bluetooth/l2cap_core.c:1762
3 locks held by syz-executor/5452:
 #0: ffff888011fa4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff888011fa4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev+0x1fe/0x500 net/bluetooth/hci_core.c:2678
 #1: ffff888011fa4078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x66a/0x1330 net/bluetooth/hci_sync.c:5213
 #2: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:2062 [inline]
 #2: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xa1/0x230 net/bluetooth/hci_conn.c:2543
3 locks held by kworker/0:8/5706:
 #0: ffff88801a474d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a474d48 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d38fbc0 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d38fbc0 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by syz.0.31/5718:
2 locks held by syz.3.36/5728:
5 locks held by kworker/u5:4/5760:
 #0: ffff888055a1c948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888055a1c948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d7a7bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d7a7bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888055b4cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888055b4c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
5 locks held by kworker/u5:5/5769:
 #0: ffff888044202948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888044202948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d827bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d827bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888052108d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888052108078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
4 locks held by kworker/u5:6/5785:
 #0: ffff88805083e948 ((wq_completion)hci7#8){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88805083e948 ((wq_completion)hci7#8){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d8c7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d8c7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888047e64078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
4 locks held by kworker/u5:7/5786:
 #0: ffff88804f7c5948 ((wq_completion)hci10#8){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88804f7c5948 ((wq_completion)hci10#8){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d847bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d847bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff88805964c078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
4 locks held by kworker/u5:8/5790:
 #0: ffff8880599b8148 ((wq_completion)hci9#10){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff8880599b8148 ((wq_completion)hci9#10){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d777bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d777bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff8880339b0078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
5 locks held by kworker/u5:9/5797:
 #0: ffff888011f7c948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888011f7c948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d917bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d917bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888044048d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff888044048078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
4 locks held by kworker/u5:10/5804:
 #0: ffff8880337a1948 ((wq_completion)hci6#12){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff8880337a1948 ((wq_completion)hci6#12){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d957bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d957bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888050900078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
4 locks held by kworker/u5:11/5806:
 #0: ffff88805933b948 ((wq_completion)hci16#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88805933b948 ((wq_completion)hci16#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d8e7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d8e7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888059e18078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
2 locks held by syz-executor/5843:
 #0: ffffffff8f503c10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: ops_exit_rtnl_list net/core/net_namespace.c:174 [inline]
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: ops_undo_list+0x2a4/0x990 net/core/net_namespace.c:249
5 locks held by kworker/u5:12/5861:
 #0: ffff88805081a148 ((wq_completion)hci8#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88805081a148 ((wq_completion)hci8#3){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000da57bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000da57bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff88804404cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff88804404c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1eb/0xdf0 net/bluetooth/hci_sync.c:5601
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #4: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x165/0x310 net/bluetooth/hci_conn.c:1275
4 locks held by kworker/u5:13/5866:
 #0: ffff888052da7148 ((wq_completion)hci12#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888052da7148 ((wq_completion)hci12#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000d8b7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000d8b7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888059648078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
2 locks held by syz-executor/5893:
4 locks held by kworker/u5:14/5897:
 #0: ffff88801f51d148 ((wq_completion)hci14#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801f51d148 ((wq_completion)hci14#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000daf7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000daf7bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff88804f218078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
4 locks held by kworker/u5:15/5902:
 #0: ffff888056efe948 ((wq_completion)hci18#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888056efe948 ((wq_completion)hci18#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000da87bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000da87bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff88804f568078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
3 locks held by syz-executor/5909:
 #0: ffffffff8fa14ac8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa14ac8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa14ac8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffffffff8dfe5a68 (wq_pool_mutex){+.+.}-{4:4}, at: apply_wqattrs_lock kernel/workqueue.c:5181 [inline]
 #2: ffffffff8dfe5a68 (wq_pool_mutex){+.+.}-{4:4}, at: __alloc_workqueue+0x9eb/0x1b70 kernel/workqueue.c:5736
2 locks held by syz-executor/5914:
 #0: ffffffff8f503c10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x2ab/0x800 net/ipv4/ip_tunnel.c:1160
4 locks held by kworker/u5:16/5918:
 #0: ffff888000dbc148 ((wq_completion)hci15#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888000dbc148 ((wq_completion)hci15#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000db57bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000db57bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff8880593a4078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
4 locks held by kworker/u5:17/5920:
 #0: ffff888059687148 ((wq_completion)hci13#4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888059687148 ((wq_completion)hci13#4){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000db77bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000db77bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff88803f300078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
1 lock held by syz-executor/5931:
 #0: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979
4 locks held by kworker/u5:18/5936:
 #0: ffff888053d3f148 ((wq_completion)hci17#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888053d3f148 ((wq_completion)hci17#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000dc17bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000dc17bc0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffff888059e1c078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3713
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2047 [inline]
 #3: ffffffff8f678828 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3747
1 lock held by syz-executor/5953:
 #0: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f510808 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979
1 lock held by dhcpcd/5978:
 #0: ffff88804ff74258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88804ff74258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5979:
 #0: ffff88804ff70258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88804ff70258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5980:
 #0: ffff888011ccc258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff888011ccc258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5981:
 #0: ffff888011e66258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff888011e66258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5982:
 #0: ffff888011e60258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff888011e60258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5983:
 #0: ffff88801148e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88801148e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252
1 lock held by dhcpcd/5984:
 #0: ffff888000bfe258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff888000bfe258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3252

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.15.0-syzkaller-13743-g8630c59e9936 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
