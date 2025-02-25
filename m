Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586964414
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512667; cv=none; b=B3PwoSXCXWSULj9+2AEFBJbhePpe0yRaPdzcfMgbdzUD0viNz0mdRjBqaXb/266+cjBJoqRjdej1DNP/3UHLj7BTa7dzGFlGGTvWlfHjNj+zdOCn8Es3mlWIWAdfIGpPz6no1Ayb7WCZIV7jriJGPvTqw2VWZrhTU0njygDXSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512667; c=relaxed/simple;
	bh=Z2fFK85mzRgcR7RW7ufzAyzQ8Q7Chtjm54Vmco841ZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iwV9NqOnbFu9AeGguS/2GcBtXRSWaCxESwLuEQVk4kjrQfR2XQc/Uzq3T/TrseyYLkc6iMKmfHHdPUdvDefwYpl0039pM6ElDIlBXWEgKXHPR2PGPWF/s3dOiZ/5Qb5qWdOs0uEyP8MjW6Vgjkc6CJaknMRjVXA/NZWBwrxEQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2aba48f44so1498035ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 11:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740512664; x=1741117464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76x+UPV5MX91QGzIZEkWwMxGpj5DzJVSb7MVwzvstts=;
        b=K3ZPTt9dR7wBmfakdv5Ib7yoZ0mjlhUsnhVLHxzFHsM1kMb9PrMHED++Cc86E2oET/
         Zi8xzBD8rLLMDPHam9zXrHrDUwHa4843webFi2YKc67aC0ExMEM3ZBIIdI73XM9c3Q+o
         DfeCwI6f524pwoCzbuXnoKmRamrQIjYzI6J5MqSbHcjJZly+bTqXFqdtWSWXwJAUxhu9
         s7+vecnpBC2r9m280vOiNTnGXY1lW8tORD/SudrxH4Osbs5MHEJ/yYD8UymgP0RT+8hR
         N1mdydafkJiXkt79TGYToWEphKqhxb69lEPh5BUiSOv2FMoiXrYkf4s9ajeUlkJ5Tdbo
         9W5A==
X-Forwarded-Encrypted: i=1; AJvYcCW/lWwZCCthh5TxG9EfbMrE1/RBfbHSditNT4Wyr010Zggas3LjEV4XnN1YpsyBvaKKZUct+hWCvdj3NHbL3nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6b3boah6kSuFcVXY3mhzYZtRUmdM7jkneRXdBA/hsMoluFWX
	3iOfAu3C+aHPKGokA9gsOle+lJyirLdHn3rOzSI/SId9gAUa985T8YehNPLVPUkGQ5rnjV8R6tB
	yfBIeNUjB2O5qVmCoU8QCe6+kNr3O1MjY5YYEIzvTVTFNJUXHOLc+YYM=
X-Google-Smtp-Source: AGHT+IG4MLCKeVgpdvui/NNSnjP81MVT3zXXfY2Km1qdmyJCOO453G2qxPE1zHlajevDs6hE442++KBrTozK6a2ekmHDhvQioWHS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3cf:fd62:e39c with SMTP id
 e9e14a558f8ab-3d2cacde097mr161618245ab.5.1740512664445; Tue, 25 Feb 2025
 11:44:24 -0800 (PST)
Date: Tue, 25 Feb 2025 11:44:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67be1d98.050a0220.bbfd1.00b0.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in l2cap_info_timeout
From: syzbot <syzbot+d8bca25877c7eda36f5b@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a61cb6e150e Merge tag 'block-6.14-20250221' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17261fdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d8bca25877c7eda36f5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8a61cb6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/420db9e4c0d8/vmlinux-8a61cb6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ce6feff857d/bzImage-8a61cb6e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8bca25877c7eda36f5b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-00213-g8a61cb6e150e #0 Not tainted
------------------------------------------------------
kworker/0:2/56 is trying to acquire lock:
ffff888042bae338 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_info_timeout+0x60/0xa0 net/bluetooth/l2cap_core.c:1666

but task is already holding lock:
ffffc9000103fc60 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
ffffc9000103fc60 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       touch_work_lockdep_map kernel/workqueue.c:3920 [inline]
       start_flush_work kernel/workqueue.c:4174 [inline]
       __flush_work+0x739/0xc60 kernel/workqueue.c:4206
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4362
       l2cap_conn_del+0x507/0x690 net/bluetooth/l2cap_core.c:1794
       hci_disconn_cfm include/net/bluetooth/hci_core.h:2069 [inline]
       hci_conn_hash_flush+0x1be/0x350 net/bluetooth/hci_conn.c:2698
       hci_dev_do_reset net/bluetooth/hci_core.c:547 [inline]
       hci_dev_reset+0x3ed/0x5d0 net/bluetooth/hci_core.c:591
       sock_do_ioctl+0x158/0x460 net/socket.c:1199
       sock_ioctl+0x626/0x8e0 net/socket.c:1318
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&conn->lock#2){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
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

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&conn->info_timer)->work));
                               lock(&conn->lock#2);
                               lock((work_completion)(&(&conn->info_timer)->work));
  lock(&conn->lock#2);

 *** DEADLOCK ***

2 locks held by kworker/0:2/56:
 #0: ffff88801b074d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801b074d48 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc9000103fc60 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000103fc60 ((work_completion)(&(&conn->info_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317

stack backtrace:
CPU: 0 UID: 0 PID: 56 Comm: kworker/0:2 Not tainted 6.14.0-rc3-syzkaller-00213-g8a61cb6e150e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events l2cap_info_timeout
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
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 l2cap_info_timeout+0x60/0xa0 net/bluetooth/l2cap_core.c:1666
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
