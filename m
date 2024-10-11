Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E720C471
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637590; cv=none; b=jYxvS+bwUIEgWzzZrJcNMiGAiGZnduT5YP2A7Cy/w9JMWw2pWcqjAqL21nCeGgotD1bmD/xO7KJgnT12DJl0teHnzI1unasJZ46hw0+PwZQ2de/g9w7ygm0wVEpQe5k15B0qBmBy6xALkmgcHegyWAdYqQrewL/zIMdPkUzUMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637590; c=relaxed/simple;
	bh=D4tQlJrxIt8JE3Brlv7FNBlcByS3WOpRjp6AMALX7Ss=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NcBYCyvQZ05arPqPbc0pgxu8Y43gq36aKehIU87R+xKMkV3k7v73tyDoiO/ghXTJlQvDDKqSU09Ed/irWp8sLdM+oBB2HuKAHhSIX+a9aatfJzJbEx6n1kQRSPNGNNecHDqiabo5ivZC3Zx05XlFVsiyeEqAAD3+8od6pTwAge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so13063395ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637587; x=1729242387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIiVSdutQo15lTZycG8yedUYHgfynuVIWO/qrN1n35o=;
        b=vT3S+fLhjPynTKOgv+jrVLWYhe+54tLURscL6AvXt6VPq6GJ6WeRI8Kgrk4JNd64Ll
         jko7ed9XmGIc5ewsoO0WMAnInyfOUvNAMKvjQ3KCQCXN84wJotgnzFgWmZ56Ih+Ra0kR
         VH4sqJbMtBjtL3yB9lnfm+fg+rff6l3W5me6PgOum074IoCvbE/i+LJVsoe6iXj2kMR+
         2G4p30iteQd/vx8I8rDv0N5vPFyPLwlIEPiweOTbmLTJqL/pytHCEiW2mFewtUxXzqrk
         Q/jyZKgIYMz70r53DWI71rb2/NJo4pSYLm3wshVeV/MOhxv7bi+1Rmt7iozIUnwdKsri
         JyDA==
X-Forwarded-Encrypted: i=1; AJvYcCXjT2eaBfMTWBg/Sjnos75+jWW+h1h7tqBH3kTFH8VfJXZ/ZReR+K3xZ14FNLW4xBq+saX0cM+HJS4AvWI/yBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymo6XIOvF3cYEGLoiKctHoka8LhxTqIYsTc8RjYnXOSLQXAhci
	ySXxEf36UIP0LI7ey6pTsy5JnbP8UK97cYJltPYk8Fd/1nDc1ajFKmUtClO/I61DuP2znaXANhz
	VqP1YDZzsHk8wJiKX3XinnKXvvRBfK1+jMRUSrY32ibOx/59PiViNezc=
X-Google-Smtp-Source: AGHT+IHNmDxvd5ZHgwdTyKHe+5+EfOz816CA0aYN19ccznaQHUNgQYfxhbUU3voWaLTNFed44KwFoFYiHi4rD2b42LhtvJ5zD/Ms
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2e:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a3b5f20906mr10187795ab.3.1728637586776; Fri, 11 Oct 2024
 02:06:26 -0700 (PDT)
Date: Fri, 11 Oct 2024 02:06:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6708ea92.050a0220.4cbc0.0000.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map (2)
From: syzbot <syzbot+7386bb3da86fa8113f70@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75b607fab38d Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1494b7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=7386bb3da86fa8113f70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/001d5437d70d/disk-75b607fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c93454dd9e4/vmlinux-75b607fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc2a448f02b5/bzImage-75b607fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7386bb3da86fa8113f70@syzkaller.appspotmail.com

Bluetooth: hci1: Controller not accepting commands anymore: ncmd = 0
Bluetooth: hci1: Injecting HCI hardware error event
Bluetooth: hci1: hardware error 0x00
============================================
WARNING: possible recursive locking detected
6.12.0-rc2-syzkaller-00058-g75b607fab38d #0 Not tainted
--------------------------------------------
kworker/u9:1/9530 is trying to acquire lock:
ffff888037f87148 ((wq_completion)hci1){+.+.}-{0:0}, at: touch_wq_lockdep_map+0xb1/0x170 kernel/workqueue.c:3880

but task is already holding lock:
ffff888037f87148 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
ffff888037f87148 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)hci1);
  lock((wq_completion)hci1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u9:1/9530:
 #0: ffff888037f87148 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888037f87148 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900043e7d00 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900043e7d00 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310

stack backtrace:
CPU: 0 UID: 0 PID: 9530 Comm: kworker/u9:1 Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci1 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 touch_wq_lockdep_map+0xc7/0x170 kernel/workqueue.c:3880
 __flush_workqueue+0x14f/0x1600 kernel/workqueue.c:3922
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4086
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5830
 hci_release_dev+0x169/0x16b0 net/bluetooth/hci_core.c:2733
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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
