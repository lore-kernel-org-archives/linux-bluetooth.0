Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007891FB8BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867178; cv=none; b=bGtezixbLWNvJANlJaS5rm8ol8qJdZQ+8bgFbY9GZeQ1EqxWjWLSpkTsG4SJButyEU5YMpMI43v6TU3yyaKWTXqdlH1l4SgsSkEI8GRzZuqH6z46BZVwZ38rbSy4iJI8cDfvH3l1abEJqcrTWfLiLAATNtq2O7jXiPT/9lBVMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867178; c=relaxed/simple;
	bh=qyoNb4gFNWAKzMfRXUhVvi8eghxxKxX5bRlKKiDfpTs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JngN3hN12GB30Kj9CtGVUqfsSsp1yJf3PDOjHeD062zb6nnCUxosi5eylT6Qzt3VyWi9h7XmPhqpKesxUQsgUmipStbGlQo2GVmn9/mEb/KV26sSknY3fokdEs6Qr9MPCJkmqMzr27Gec1UDcsrokpRpqvM2xw6rBjv4mHPFma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e52b6577so8959695ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 07:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867174; x=1730471974;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKl93ItWUSNrBvfWKQMOqbQF7/2yw2Cr9mseQ1DUXyU=;
        b=JThdbzFtf8WiGmwaqQHHZY7fvbMgsQXgagDL1Pgq3qtJSLAsi1D2oe8ok5I8uUdWvb
         b1Hkj/5mKbuGlXqVOcB2DkJpDUd9li3+9T45MZEbjCjFxozQGimG29BMb0cNdI4w9Ze/
         zus+0ONGSRPz9wolmXHi+PtVjPzXVjKyVYGLvnIwSFLJsbEVKIWicClJy6UE0z+D20f+
         gd8XkrV64wTVbV3T0wBci04Jo0/qcMFAt7HAYTRms+69zZK2xtU8p90myaEGZFOqruod
         qqK1p6LhhKjKc8UdpyuXnax8+pzGIVyNkL8Bx4CKWuoUw7gD9R+w1h8KO80iQWwbHwcl
         nspg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5HO9Fm5eCXjVXqGGZWWTIq0yIHy3xYiVzMXjMlF1czGxLEFFEaeweNMk9bK0lcW7AgsnTTWPHvS/846bnTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNN3kkHKt5/75uTpCe2RR/lqceFenvR3a5YFfjsYFr7wXmUZU
	aa17IsJ3IoPCsagFllTtqRK3WUPKlJDq10nXzU0UEE4XyFJDHvMpF6ogJBEnPyZpLoc+q+qdxIY
	HrC9mkNAfOzVXV2jBxv5L2xd9OunsYCaw9Jb/HzperEjdiVxxy7LQ3Go=
X-Google-Smtp-Source: AGHT+IF5X01qRaytUlYxWlPuPfkPH7I6f9pfWsBOQ8fw82TWis59znWK9kYgR6tC62F/EalL5FCBW769pgdsfIG5z8JCRhFzKTpG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3a3:b4ec:b3ea with SMTP id
 e9e14a558f8ab-3a4de80b5dbmr67873115ab.16.1729867174092; Fri, 25 Oct 2024
 07:39:34 -0700 (PDT)
Date: Fri, 25 Oct 2024 07:39:34 -0700
In-Reply-To: <000000000000cfe4e90618c6d17c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bada6.050a0220.2e773.0007.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in mgmt_set_connectable_complete
From: syzbot <syzbot+b1752fcfa8658bb8984a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ae90f6a6170d Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc8230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=b1752fcfa8658bb8984a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fab287980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ae90f6a6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c242e171fdc8/vmlinux-ae90f6a6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a180678c27b3/bzImage-ae90f6a6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fbc68333ee1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1752fcfa8658bb8984a@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.12.0-rc4-syzkaller-00161-gae90f6a6170d #0 Not tainted
--------------------------------------------
syz.4.19/5588 is trying to acquire lock:
ffff888058a28078 (&hdev->lock){+.+.}-{3:3}, at: mgmt_set_connectable_complete+0xaf/0x500 net/bluetooth/mgmt.c:1690

but task is already holding lock:
ffff888058a28078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x5c8/0x11c0 net/bluetooth/hci_sync.c:5189

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.4.19/5588:
 #0: ffff888058a28d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff888058a28d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffff888058a28078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x5c8/0x11c0 net/bluetooth/hci_sync.c:5189
 #2: ffff888058a28690 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at: hci_cmd_sync_dequeue+0x44/0x3d0 net/bluetooth/hci_sync.c:883

stack backtrace:
CPU: 0 UID: 0 PID: 5588 Comm: syz.4.19 Not tainted 6.12.0-rc4-syzkaller-00161-gae90f6a6170d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 mgmt_set_connectable_complete+0xaf/0x500 net/bluetooth/mgmt.c:1690
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:641 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:886
 cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1461
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9474
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5197
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1227
 sock_ioctl+0x626/0x8e0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f404e97e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f404e3ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f404eb35f80 RCX: 00007f404e97e719
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000005
RBP: 00007f404e9f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f404eb35f80 R15: 00007ffde86e4688
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
