Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793FEED6
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2024 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716092065; cv=none; b=tVOvNvmsZHckVzohPWEIKvFChf+XC1O9RYSNRxh6IG9g7fhjW6l4imcDfa0lyhtfJhWMi9wmSxGouOE23xL74+M+jHy18cbOXGbVLDuvxAPfKkjzSw8ug3Vde+zIHUWdDsDNq81VNRCYuTY3QXsr1Yy1WYObR8+ZqBlhpPNsNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716092065; c=relaxed/simple;
	bh=Fqw7zNfvJEqFUJr2YhJXcQskDwMqGE7icYpXEfvUDyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m6FhdRgVw842cb882vReoKG8nDHl311aDnsXGDHjNhFISFP8rwVwNHXx34uMTIBveywMHV44A1jAEaw+GBL6XImUH4AwAyfNt0GUY/RqcGZq/WfMNBRscI1ghLvgthKBtIFn0RdTFxE2yYvbzbIKzq5l30fbrFm1Lkydgv40NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e21af40435so124065439f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2024 21:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716092063; x=1716696863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8sg3ZFgmIcFPGkvh2vCAviLNH5rF7USv84IZ8NnudM=;
        b=W/FzQbsaZ7pkErlGHxkll/LEb65rxQG0wPJGLWGbOoIuPOHcnEaz0piHbb4NRFRiCl
         rwCLyzxU9Xjwz4MfmYTijbrwClYs2wkEXAI99wZGQMwNW1TtEb3JZHPNprMteEgbI789
         vyrV/HHZE6LG+UzUwQ8MlbVxxfJZJumv5dR+dZId9M33/Pbdz3EtXscLjY3VLQOhgwWY
         3zfipAYJ+AlzRxpc/OfGX+ZNk4VmLlvDmzPunL7on/Oto+Rjfr3TwNIu4EWrW30NZ56I
         d25gZrvFB8d4+PD8NscqIuDHfA9gbZDLDZYIUWfFwjF2df0vme/qKbyTWahgKcJCCC2m
         JQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt/xvONujA9l2zwyIEXqLaYVODgAn+CfFE9kCCo/lBtpoMyyw09QOPUPb4E53JU8rAzmLwWnL6Sq6Q9ZYAIPDTKXu1xgmCF0u+HABnRf5t
X-Gm-Message-State: AOJu0YxgWOhN0obU9S2WPzlfcyJr80wMRpFVPlJaZCRqZySRwDr5Qrht
	MYDHfZJ9ZW+1XBOCMqrw+e8b7BKKphgtdiTRil8tZVNis6ZfkFW7TprylVwg6dyrZkjtl87vqKJ
	uyVJ2rBWHruV8R2jEPDyG5cxOiBe50XsiiergNfCcstBW0EvUq5s18Z0=
X-Google-Smtp-Source: AGHT+IGqYPB1t2dfkdB6c1aDZsroSImTn60C29oHRGx356nacyYpga/9/72ybzDjTmThW3tR1tVWkG2xhWhCJlZX7DprJiKYzDRH
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b08:b0:7da:bb15:56fd with SMTP id
 ca18e2360f4ac-7e2306966e0mr19112339f.1.1716092062910; Sat, 18 May 2024
 21:14:22 -0700 (PDT)
Date: Sat, 18 May 2024 21:14:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfe4e90618c6d17c@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in mgmt_set_connectable_complete
From: syzbot <syzbot+b1752fcfa8658bb8984a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b10b390d945 Merge tag 'efi-next-for-v6.10' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15946b5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91e885703cf9a258
dashboard link: https://syzkaller.appspot.com/bug?extid=b1752fcfa8658bb8984a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efb231af2518/disk-1b10b390.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c4d92714ec/vmlinux-1b10b390.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73a37b1f8fbc/bzImage-1b10b390.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1752fcfa8658bb8984a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-02713-g1b10b390d945 #0 Not tainted
------------------------------------------------------
syz-executor.0/5103 is trying to acquire lock:
ffff88805ec6c078 (&hdev->lock){+.+.}-{3:3}, at: mgmt_set_connectable_complete+0xaf/0x500 net/bluetooth/mgmt.c:1698

but task is already holding lock:
ffff88805ec6c970 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at: hci_cmd_sync_clear+0x4e/0x220 net/bluetooth/hci_sync.c:591

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hci_cmd_sync_lookup_entry net/bluetooth/hci_sync.c:733 [inline]
       hci_cmd_sync_queue_once+0x43/0x240 net/bluetooth/hci_sync.c:715
       le_conn_complete_evt+0xa16/0x12f0 net/bluetooth/hci_event.c:5911
       hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5922
       hci_event_func net/bluetooth/hci_event.c:7544 [inline]
       hci_event_packet+0xa55/0x1540 net/bluetooth/hci_event.c:7599
       hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4170
       process_one_work kernel/workqueue.c:3267 [inline]
       process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&hdev->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       mgmt_set_connectable_complete+0xaf/0x500 net/bluetooth/mgmt.c:1698
       _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:578 [inline]
       hci_cmd_sync_clear+0x109/0x220 net/bluetooth/hci_sync.c:593
       hci_unregister_dev+0x151/0x4e0 net/bluetooth/hci_core.c:2767
       vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
       __fput+0x42b/0x8a0 fs/file_table.c:422
       task_work_run+0x251/0x310 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa1b/0x27e0 kernel/exit.c:878
       do_group_exit+0x207/0x2c0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->cmd_sync_work_lock);
                               lock(&hdev->lock);
                               lock(&hdev->cmd_sync_work_lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5103:
 #0: ffff88805ec6c970 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at: hci_cmd_sync_clear+0x4e/0x220 net/bluetooth/hci_sync.c:591

stack backtrace:
CPU: 0 PID: 5103 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 mgmt_set_connectable_complete+0xaf/0x500 net/bluetooth/mgmt.c:1698
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:578 [inline]
 hci_cmd_sync_clear+0x109/0x220 net/bluetooth/hci_sync.c:593
 hci_unregister_dev+0x151/0x4e0 net/bluetooth/hci_core.c:2767
 vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
 __fput+0x42b/0x8a0 fs/file_table.c:422
 task_work_run+0x251/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a13e7dd69
Code: Unable to access opcode bytes at 0x7f1a13e7dd3f.
RSP: 002b:00007fff56cde9a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1a13ec935b RCX: 00007f1a13e7dd69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 00007fff56cdc747 R09: 00007fff56cdfc60
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff56cdfc60
R13: 00007f1a13ec9336 R14: 000000000001dab1 R15: 0000000000000005
 </TASK>
syz-executor.0 (5103) used greatest stack depth: 18064 bytes left


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
