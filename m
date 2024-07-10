Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5714C583
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655122; cv=none; b=UNgEuXe/9aKq3UYZlKmit8/Y9ZTOX38uRUIDnVK5CFuQmVBTPoAoPRUHSyguXvqusPoNPtRCgW4Q7CNEQWuC0+S3CW5TfrNX8y2gP4MhrYsecyVsg2ylU6CkFFZ+yp7xgpznyIqzeGM2uy/P4dI+sW7eD8O/KHAn9oomJryzTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655122; c=relaxed/simple;
	bh=ppd6gWks0aUEmhroV6/A0palDKJ5Nb1FUPca03Afuqg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rHYwMkmAQZDpiznEVzyIMPbkiM1j9022xM52UNWLO3ofrPVWL4Z+Jhgf1E94GlrD7za8vGWV+KBVBviNruXlpMwsuyni61SGV3b+UykNEYME0AuI7aYNXvr5o1ElqPyKs2gMxyJ8aNP0dr7nRStha4YvUWFXh8oRHTg+edgPuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so32609639f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 16:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720655119; x=1721259919;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/dRzecO4TXDSgIVqu9c62mv7YdSRVfiDzRyV5wH5tw=;
        b=Sea03D9YCFkHTlteX59Fdzgb0S23d1TIBPjQNVBVM1sqwINyf3XNCsrHzWOMb7SI2Z
         lLee4A43Xf/aVxY1sdLfZO8n0DWqjToET8Aqhj0vby6qBtacEN/MeO7FjMTKPoTM1CVa
         69s3DKFX3/wU67EaIitp8QeL9dvmdtvcq+FqF7lwtg41lQkMFrHzn9HnL4LCJVOjUbC3
         nPOPNQl8OzniTBJorEeTY1oKWg3Gau/r+j2fYUSLBKv3C0kYa+lPCR4r2HcegiRaXBfd
         E689maIzUvvmSuryHw85j/xs1Gqd0g1SAE+5+xGRsuTYOdt2Mzs2lUYGaZgxGwHN5X2o
         Z2mw==
X-Forwarded-Encrypted: i=1; AJvYcCWoa1LhO0Zs/pSBeAmJRr45vCpclpgAEvLUCzqj6q/06wTW+yn3t/VuYJy6VKejIsIBR8N3ld3z+GgTRr+dPgGO6vRZ66mtYdFBnYThwziM
X-Gm-Message-State: AOJu0Yyhyqz0TTleufAoK6nzxSVaaaGK2MN28xXum/Lp0XGU7/z3ixdQ
	l5WMr/HjRG7p+6UNrQBJwDS2VUiaSst9cCofjkFYghF3uK1/LTltlWNHhmg6s/N7E7+rvEoI6a3
	C+Z9Is/iQmWMtDIhq+924xezLclUrLU0kSLCBl/DRC1/Y4Vw4Oh4ExwU=
X-Google-Smtp-Source: AGHT+IGwWFUwyrJeI0U0jvO8sayv9TBTSx9h3lH4d/F2Orezba9DpEgW1Z6mlwU8xCdMCdR4euTEyZF8+jG6uuDiBK7HkyBN/0m8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1693:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4c0b2b8f692mr504474173.5.1720655119626; Wed, 10 Jul 2024
 16:45:19 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:45:19 -0700
In-Reply-To: <00000000000031fb62061cc4c118@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fcc8d061ced3d52@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
From: syzbot <syzbot+733a96463546d3026b60@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ef445d1539dd Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1544df69980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
dashboard link: https://syzkaller.appspot.com/bug?extid=733a96463546d3026b60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13768021980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176e2c7e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76e73f830dca/disk-ef445d15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d54cbf6f6ee2/vmlinux-ef445d15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9240e4c79dfc/Image-ef445d15.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+733a96463546d3026b60@syzkaller.appspotmail.com

BUG: workqueue leaked atomic, lock or RCU: kworker/u9:0[52]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=hci_rx_work
1 lock held by kworker/u9:0/52:
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 process_one_work+0xdc0/0x15b8 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc7-syzkaller-gef445d1539dd #0 Not tainted
------------------------------------------------------
kworker/u9:0/52 is trying to acquire lock:
ffff0000d385e948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8 kernel/workqueue.c:3222

but task is already holding lock:
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&chan->lock/1){+.+.}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x334/0x9b8 kernel/locking/lockdep.c:5774
       process_one_work+0x8a0/0x15b8 kernel/workqueue.c:3255
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x938/0xecc kernel/workqueue.c:3409
       kthread+0x288/0x310 kernel/kthread.c:389
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #0 ((wq_completion)hci0#2){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5754
       process_one_work+0x668/0x15b8 kernel/workqueue.c:3223
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x938/0xecc kernel/workqueue.c:3409
       kthread+0x288/0x310 kernel/kthread.c:389
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&chan->lock/1);
                               lock((wq_completion)hci0#2);
                               lock(&chan->lock/1);
  lock((wq_completion)hci0#2);

 *** DEADLOCK ***

1 lock held by kworker/u9:0/52:
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830

stack backtrace:
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_cmd_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5754
 process_one_work+0x668/0x15b8 kernel/workqueue.c:3223
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Bluetooth: hci0: command tx timeout
BUG: workqueue leaked atomic, lock or RCU: kworker/u9:0[52]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=hci_cmd_timeout
INFO: lockdep is turned off.
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_cmd_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 process_one_work+0xdc0/0x15b8 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
