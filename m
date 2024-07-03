Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA9138E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971245; cv=none; b=lvJpbMVIiN4Gxsdjeat9QqmhHH7YNgrWBvo8D70tZ1DIg1NppnzsYa72REPCmPPAclxH8KY9NxnQQSoidZ2mGs7ricqY1dqi4osX0vUtoHSwzBPEeDR1pS8MOtH4j3Y3Yc3lF/Gga+uTH9VY5nAm+D8ddwQWMBhznwDAyQUdVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971245; c=relaxed/simple;
	bh=u61DftUVQz151WIDun9uwfuzS1FTADIk6nzI9CWYOCk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BYXo4YHn7kgV4l/IrbGz5YBJe3XO6uxFk42O4DBDu6iON8CAjUqKXYNz6fEwnGd5PRy8jkM0mjxrNk1mnJoaGDL3ea21UykOTBxf0xEB44NOE6wNDIURxslHgLNQoyDnZr/lg0E5hRQCR1UY/Z6YAyRcJB+jbVEhh7FyXikXRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so488924839f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 18:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719971243; x=1720576043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkeba/dbYPdpJ4NO4L1/wnos1F3m3o/DJjhyoISgjSQ=;
        b=pvRVsmnaPxgga7oqNM97fJHOD6vz2xTo+Rlam0GcZIuTeXUeeYsfK2LZIrxqdzQMt6
         cTiXSsM95b59IULHXIsh8GxPkGrPn8BJZSkKP3NXeK5hfGUFFF06qDJokNOIVERjKlyc
         t8ePRLc9KwRQrgxLQokotwZj69yMCjzu4ZCoo9HtTlkFH1oXEdlA+l8het2OCu2tRmG2
         ykiJ5b37llLQWQ6MsTvdyGkXMrHlNr2JsbOT4TQjpABYkGSUR+oOERzghz6E8g5K0R9a
         /8FV0Rsy77NNoqQeNnIyLeLEOpQ44ZdoBMg9l1sq0fBPuYnmRfCpdTyU1HjmRC64Ch5Z
         fRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTOGipArvMoT2XFvwDTCkfU9fTXa6mNHiKeuiwjUgreCSj7z7qnLce3GNWqHSRS9sMxSgYIZEi/NoaqLAzTUhWkgQhQNxL+4flItlKNWFK
X-Gm-Message-State: AOJu0YzHs1tuHR6yhcZGhP8Yj2vNkOC5uso0pi44yHezO7Ga+irTrr2M
	fW+73DswEePAfBuNhtN04upt+FshSlU5q2CwhNBS8EKLd0Fa8BDLBHBhEdYoGZKhVJahZ5aknVm
	aAqnJsanqs0F0lpDjqGTAiH8NVMt2iUKiU6tMfiWcJf6cXHwtSl9iSpY=
X-Google-Smtp-Source: AGHT+IGvAF21Ecy0r7MRL8sozef9gZaW+C1fiytyb0JJtI6NzIzJMNezSSTlDTSDgbzg605XJRi8lmC4cCYDAEh1ubvsjfClG7Aa
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2389:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4bbb6ec54d2mr581759173.1.1719971243327; Tue, 02 Jul 2024
 18:47:23 -0700 (PDT)
Date: Tue, 02 Jul 2024 18:47:23 -0700
In-Reply-To: <0000000000004a975c0613c7f382@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb901b061c4e0282@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
From: syzbot <syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    734610514cb0 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151ea512980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1424d281980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-73461051.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d390d5c7156f/vmlinux-73461051.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b56ef48ffa7e/bzImage-73461051.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com

Bluetooth: hci0: hardware error 0x20
Bluetooth: hci0: Opcode 0x0c03 failed: -110
============================================
WARNING: possible recursive locking detected
6.10.0-rc6-syzkaller-00055-g734610514cb0 #0 Not tainted
--------------------------------------------
kworker/u33:1/4633 is trying to acquire lock:
ffff88802b9cc148 ((wq_completion)hci0){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x6e/0x120 kernel/workqueue.c:3895

but task is already holding lock:
ffff88802b9cc148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)hci0);
  lock((wq_completion)hci0);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u33:1/4633:
 #0: ffff88802b9cc148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223
 #1: ffffc90025177d80 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3224

stack backtrace:
CPU: 2 PID: 4633 Comm: kworker/u33:1 Not tainted 6.10.0-rc6-syzkaller-00055-g734610514cb0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 touch_wq_lockdep_map+0x78/0x120 kernel/workqueue.c:3895
 __flush_workqueue+0x129/0x1200 kernel/workqueue.c:3937
 drain_workqueue+0x18f/0x3d0 kernel/workqueue.c:4101
 destroy_workqueue+0xc2/0xaa0 kernel/workqueue.c:5817
 hci_release_dev+0x14e/0x660 net/bluetooth/hci_core.c:2795
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:94
 device_release+0xa1/0x240 drivers/base/core.c:2581
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3787
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
