Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49615D1
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731132034; cv=none; b=EbZg1Lvi/evWJqwhZDLGJZxHoKx8HW6V/bAyTF/eTotyfr73FKeizH7DlurKHdnV7cszhK1jZAuRZjr/LKP5ErVtkei6jjDFIe9T6/tDjfknonIrvHfLjsRsWwCe+nS7DjAbwCXiHCZYwr6EAcso7rVbXLNWNWU4zUrVSPakuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731132034; c=relaxed/simple;
	bh=IG/6C4gsS4wee3PVvpSm2oK5w3GWvG6ucR/+/vYBVu0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rdqzehEWmuW8NDCBhul7fhhL/kibxdABJ4egm68wmiDdXgL9XyPxoFZiPCTDOxtpXs37nad3llIOgYAeLlCC9ikTbsfBYH5wE1UxtLhYRbR+Itbx65eMBtIrxjnKaHCrEkJ1St8wE5v0PZh0+AEpSoPbrxt9tchPRWH2uW31chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ae0af926dso309355439f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Nov 2024 22:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731132030; x=1731736830;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3K1xS83ZlLdzA/cKg0DTLGxWTLEjYRX91V31tZoz868=;
        b=Nx+EnWTsK436grvLmXSxNcm8mbE/C012+s3U25vQVv/hw1KU2LMdBkPY8cu1uFjo14
         D5L1euFLNwtX0M4w+78+iggFCtGtVWK1su/firJMGtkwUFifxhjEXRyUSGw875rJSN1o
         GAYnIeqI35JGGYW1rb8ilhLpteP9v1Gi3ZvkxUYnVc2HpRZgVbhnvotczuSdQcQHe/Dz
         dZkSKHtv1FwemkFOjW2GdvYRT241sNHuEDNJr/kRyik934IJIZqSHjJMhKXeyAsAHPuN
         WSWNorYl5oVGr/KilhvtD+VIREWOHFDbmHQD50jwM9tiUlviduXPH+W0bH9H6ansjpaq
         0KCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrAz9YRx+g/qj6oTzzb0Gw9Hsj85Ih7XVzyvj/TqcBYM1A3UUwXekp1un5V5EYK0D/KPwMr9hIWDL7JYPnJ64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDb3QkvZZVnDiKFL3iC+i/KKI3mflwf+vPNyLVtqIY+WaXROyi
	aMYYalMGC1LzhtK8lLewPn4MLQ3fMgNRDe1o2Rsiouc10X9jKxWdXBHsJOd4ctknXQ26lDAGN6G
	2P9d5MOTV20DKaOqe0r4+VTidcC9CQJmtH1UVJyH0tB6+4C3B6wpOCmA=
X-Google-Smtp-Source: AGHT+IGSi5xO+2TO0U0W8LbuWLJIW1v0fVd/dorYyeRDozBL2WOhBYb6SYD3M38NBybJntP0bBmBt5kl4U22VFQS4vMA1yAJgTBY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a6f19d0f2bmr71061895ab.14.1731132030471; Fri, 08 Nov 2024
 22:00:30 -0800 (PST)
Date: Fri, 08 Nov 2024 22:00:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672efa7e.050a0220.138bd5.0039.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in hci_cmd_sync_clear (3)
From: syzbot <syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    557329bcecc2 Merge tag 'mmc-v6.12-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100f16a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=217e3f1283cafe80586e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1031f740580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b567e19c5e31/disk-557329bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/607066f86874/vmlinux-557329bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/311931a8e552/bzImage-557329bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com

INFO: task syz-executor:5929 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23392 pid:5929  tgid:5929  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 __flush_work+0x776/0xc30 kernel/workqueue.c:4217
 __cancel_work_sync+0x10c/0x130 kernel/workqueue.c:4337
 hci_cmd_sync_clear+0x33/0x100 net/bluetooth/hci_sync.c:655
 hci_unregister_dev+0x1b8/0x620 net/bluetooth/hci_core.c:2694
 vhci_release+0x79/0xf0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb2097d3aa
RSP: 002b:00007fff23634220 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fcb2097d3aa
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fff2363426c R08: 00007fff23633b9c R09: 00007fff23633f87
R10: 00007fff23633bf0 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000001ae34 R14: 000000000001ae34 R15: 00007fff236342c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
3 locks held by kworker/u9:1/5151:
 #0: ffff888058c0a148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90010537d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88807adb0d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
2 locks held by getty/5605:
 #0: ffff88814ca9e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
4 locks held by syz.0.7463/14113:
 #0: ffff8880b873ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
 #1: ffff8880b8728a48 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2c1/0x8e0 kernel/sched/psi.c:987
 #2: ffff888031c5a0b8 (&sig->wait_chldexit){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
 #2: ffff888031c5a0b8 (&sig->wait_chldexit){....}-{2:2}, at: __wake_up_sync_key+0x1c/0x50 kernel/sched/wait.c:173
 #3: ffff8880b873ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 80 Comm: kworker/u8:4 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_acquire+0x145f/0x3ce0 kernel/locking/lockdep.c:5198
Code: e9 73 fa ff ff 49 8d 7d d8 e8 ad 46 ff ff 48 8d 78 40 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85 5a 28 00 00 48 83 7d 40 00 0f 85 65 f7 ff ff 90 0f 0b 90 e9
RSP: 0018:ffffc900020af958 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 43f32cd72a07e41e RCX: ffffffff8169b5ce
RDX: 1ffffffff2dd14bf RSI: 0000000000000008 RDI: ffffffff96e8a5f8
RBP: ffffffff96e8a5b8 R08: 0000000000000000 R09: fffffbfff2dc5ba5
R10: ffffffff96e2dd2f R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88801d33d3b0 R14: 0000000000000004 R15: ffff88801d33c880
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3395ffff CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x16a/0x1060 net/batman-adv/network-coding.c:719
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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
