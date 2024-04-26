Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59401482FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138772; cv=none; b=OAshoQn0iwAvS91cNUWVKjKfLzhflHXY4tjpeZN1NgMqb3O6G6M63DDoslXSq10GEf+JA9dUOeGaqINBoNlZeEis07stWRnFGXW5LZivSCoG0FA1/zaPXPA9N/91fUHGIiyIVWpcI5TwW1SVZYlH7u5xxSJtKMkCwDwgucNxdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138772; c=relaxed/simple;
	bh=xQG636t56irLd7QlrLgCELtUTnbIs3dPNnISC3eJ3Ak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tv9Y1sEMv05fqkC9KHvTpEFCb9G/Bbnmo0PsCZA0eG7KoT6Co3ghd/nO/RgcYFICNxRbD800RHGY2mzqPnWKZJ65OyUA/imC7GOlJcOb/E9SDcAEtUBahhyPxQuRWXHTWJZP8HxymOyttTGU1mUescmwrYxTcUH55Dk3+vI20p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso227529939f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 06:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138770; x=1714743570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYcuiD61Y2aUE9kLnvAupz925R4UqfASkhNIIITFwDs=;
        b=gWuSXQhDb+lBO0Aej8YH4sfiGbfaTaWp3d55kmHKBYIlNx/f+uKfW+8I+7zmxHl+lm
         FVZNj8JA4lgqIDUvjqSAH7q7fbPhN2TxDQlRtXZ6C0bR9E5IP7CiPt4tALtULJUq3gOj
         aWma+hOHC7tx8V07/0eIxGZ8mm+ZZyRpLSAVg0FVQGS/WspAYLAxv8QWG3dwIYbNNcIN
         q6fpdE+J3Ons0HGz+GMsfe+w+nyNc7UBi+hrNZ9rGbJdEh+WZeBhRfAJ7VidQ+QXdhfR
         0gZM91RErYI3uUxJf4AuK7z/a0ppFX7dVy6ra+x3roufPHypP200CGadefglqUS3O2Ry
         cBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeRsQwYfmDsG2OEi56gLEXd4AGXlgRKe6KpTf3P2hQkFQREKacA43BY0ufT2EpFjNBYHN3Rsv95w0hQrsqbeQqRZYVNkXAHe/pf0hIA7Kj
X-Gm-Message-State: AOJu0YyAaEkppsmcKrADtcAmqg8mmB0zqMNY1wlr6Av1cb490ZSfsq/5
	nvZQDm7TGUAAyR3iDBDpA/OnUBXazLLlCSEObUXJL56VCV90iOXDiRypcmVKA5/LgZBLiqAUh56
	NdhgDJciCVp6V3p4uTzJJrbSR7Z1+Gb4YV46sUQfZQXxoqEw+2q21zVQ=
X-Google-Smtp-Source: AGHT+IGC31garpHytpUAe7Z5+B6Ida6v6OoSp44YzCuqm7uwAQmpSOG8I+yAFDZOJkOZCIZvJFae6y50NUBmKQeNgpBf90JZA9pe
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:948b:b0:487:3dc3:c47f with SMTP id
 kz11-20020a056638948b00b004873dc3c47fmr146705jab.6.1714138770206; Fri, 26 Apr
 2024 06:39:30 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e812306170008d1@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
From: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1337aaa0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=c55f7bc8d4809b2bad59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5175af7dda64/disk-bb7a2467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70db0462e868/vmlinux-bb7a2467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3217fb825698/bzImage-bb7a2467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com

Bluetooth: hci6: Opcode 0x0c1a failed: -110
Bluetooth: hci6: Error when powering off device on rfkill (-110)
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-next-20240426-syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:3/5122 is trying to acquire lock:
ffff88805c0888d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
ffff88805c0888d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
ffff88805c0888d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4113 [inline]
ffff88805c0888d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

but task is already holding lock:
ffff88805c089060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x28/0x90 net/bluetooth/hci_core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->req_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:309
       process_one_work kernel/workqueue.c:3222 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3303
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3384
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
       start_flush_work kernel/workqueue.c:4139 [inline]
       __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
       hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
       hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
       hci_dev_do_close+0x30/0x90 net/bluetooth/hci_core.c:561
       hci_rfkill_set_block+0x232/0x300 net/bluetooth/hci_core.c:992
       rfkill_set_block+0x1f1/0x440 net/rfkill/core.c:346
       rfkill_epo+0x84/0x180 net/rfkill/core.c:466
       __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
       rfkill_op_handler+0x121/0x280 net/rfkill/input.c:108
       process_one_work kernel/workqueue.c:3222 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3303
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3384
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->cmd_sync_work));
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->cmd_sync_work));

 *** DEADLOCK ***

5 locks held by kworker/0:3/5122:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3197 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3303
 #1: ffffc9000387fd00 ((rfkill_op_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3198 [inline]
 #1: ffffc9000387fd00 ((rfkill_op_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3303
 #2: ffffffff8f8b13e8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_epo+0x4f/0x180 net/rfkill/core.c:462
 #3: ffff88805c089060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x28/0x90 net/bluetooth/hci_core.c:559
 #4: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4113 [inline]
 #4: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

stack backtrace:
CPU: 0 PID: 5122 Comm: kworker/0:3 Not tainted 6.9.0-rc5-next-20240426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events rfkill_op_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
 start_flush_work kernel/workqueue.c:4139 [inline]
 __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
 hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
 hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
 hci_dev_do_close+0x30/0x90 net/bluetooth/hci_core.c:561
 hci_rfkill_set_block+0x232/0x300 net/bluetooth/hci_core.c:992
 rfkill_set_block+0x1f1/0x440 net/rfkill/core.c:346
 rfkill_epo+0x84/0x180 net/rfkill/core.c:466
 __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
 rfkill_op_handler+0x121/0x280 net/rfkill/input.c:108
 process_one_work kernel/workqueue.c:3222 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3303
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3384
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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
