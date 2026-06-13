Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999533E346
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339061; cv=none; b=WPAKbpSD3DBzIVtrk1eQ20+1W7zOUWUiqUYPijVYGCus6tJBDjIRnPH1Og3xDqaPA2BfnWhLXC7TmtfiK/cVpJWh1TRCRqTgPBhVf8S0kEgUmc4ToEz0CInch6McOzge0IrQM0QZMH1kAZIWCIdtyK65vA3LIvdeJBB9FrcKEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339061; c=relaxed/simple;
	bh=XCWVabs23TBSua4SlsCxE3xPr6XcoOzmTmQMLwLkb9g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XyKStnGKybvycc4nz3Q6Hb0GAjXpD+GpQ8D4OSrrCZeaNJpz2UdD78J0S2DEhehV4oQm482xoA3imFXJ/oVj+63DnHV2MfS7YISBwOrpcA+PMFT4epNMzIpjgcq77D/wFbngQz0kb0iErut4+pLBJe+TCyHpFPDmdnIklaxoSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48661b2ef8eso1575413b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 01:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781339058; x=1781943858;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kErR5kmt4f7tu2hQl9EhHifxipTEaH8oT7UK99kSS4=;
        b=r4Q/0w6xyuj9vFDpTH+/3nM9XlxuDphP4blhfg/+uKMQC1EJ21oLueLkPMMedO04U6
         ZlgVvEirQ7eVc+nF0SGrRPJj2u0gRBkVuazGuA2v7tnppockSsANFzYTvhgeRU0rb8lV
         EI7vGlP/5TzBD7U5eh8Ck2jN5UDUKA/hcy6UKkKiYXHW+xxuupmdjYzVdE13EinBuQRD
         UaPdoSlbyco/BNS5A6Gff888+PuP4Yr2StdhUVBTxxSGigV+WDzsa7YRgYJAJht05qgu
         MYIkQudtzvsfSCNh4HeuW5J/3TtxYBEEbyt6nkt+YHq90G9otCe6X11CaVNY3OxozBRc
         15mQ==
X-Gm-Message-State: AOJu0YxwguECsmzylNKhbxaY7OHdN4CntWg8SCOyw88MkVFEa5foVPYQ
	AgN0v1Z3HbB9Qu3SSu/iKcaIcrcmJat90HieL5roD61euV8Exe1ne8PNi70dRH3F8EpTUPGzLbk
	+4QCaHJvTiSJVKdauuieIEiNDhCR9c83OjgQdABLbbQOZu9V9mkyc8Lz3REGeRA==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:d4a:b0:479:e96e:65aa with SMTP id
 5614622812f47-4872f5f4e0emr3965341b6e.42.1781339058561; Sat, 13 Jun 2026
 01:24:18 -0700 (PDT)
Date: Sat, 13 Jun 2026 01:24:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2d13b2.428ffe26.258b27.0164.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: trying to register non-static key in bt_accept_unlink
From: syzbot <syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d3090a8aeb5 Merge tag 'v7.1-p5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157291b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=534002670dd34a114fdc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90834e94de32/disk-2d3090a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e27c57900a9a/vmlinux-2d3090a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/210244c0b7d3/bzImage-2d3090a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com

Bluetooth: hci1: hardware error 0x00
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 5637 Comm: kworker/u9:3 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: hci1 hci_error_reset
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0xcc/0x2e0 kernel/locking/lockdep.c:1299
 __lock_acquire+0xad/0x2cf0 kernel/locking/lockdep.c:5112
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:182
 spin_lock_bh include/linux/spinlock.h:348 [inline]
 bt_accept_unlink+0x65/0x2c0 net/bluetooth/af_bluetooth.c:265
 l2cap_sock_teardown_cb+0x17e/0x490 net/bluetooth/l2cap_sock.c:1682
 l2cap_chan_del+0xb5/0x610 net/bluetooth/l2cap_core.c:658
 l2cap_conn_del+0x33d/0x570 net/bluetooth/l2cap_core.c:1804
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
 hci_conn_hash_flush+0x10d/0x260 net/bluetooth/hci_conn.c:2736
 hci_dev_close_sync+0x85d/0x1150 net/bluetooth/hci_sync.c:5383
 hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
 hci_error_reset+0x127/0x4c0 net/bluetooth/hci_core.c:998
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
 slab kmalloc-2k start ffff888029aaa000 pointer offset 1400 size 2048
list_del corruption. prev->next should be ffff8880682f5578, but was 0000000000000001. (prev=ffff888029aaa578)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5637 Comm: kworker/u9:3 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: hci1 hci_error_reset
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 6b e7 52 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 3c 8a 74 fd 49 8b 17 48 c7 c7 a0 be 28 8c 48 89 de 4c 89 f9 e8 e7 26 6b fc 90 <0f> 0b 4c 89 f7 e8 3c e7 52 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 0d
RSP: 0018:ffffc9000202f800 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff8880682f5578 RCX: 5386ffdc73148000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1cfd240 R12: 1ffff110053554af
R13: dffffc0000000000 R14: ffff888029aaa578 R15: ffff888029aaa578
FS:  0000000000000000(0000) GS:ffff8881253a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1552dd9062 CR3: 000000001f339000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:246 [inline]
 list_del_init include/linux/list.h:318 [inline]
 bt_accept_unlink+0x74/0x2c0 net/bluetooth/af_bluetooth.c:266
 l2cap_sock_teardown_cb+0x17e/0x490 net/bluetooth/l2cap_sock.c:1682
 l2cap_chan_del+0xb5/0x610 net/bluetooth/l2cap_core.c:658
 l2cap_conn_del+0x33d/0x570 net/bluetooth/l2cap_core.c:1804
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
 hci_conn_hash_flush+0x10d/0x260 net/bluetooth/hci_conn.c:2736
 hci_dev_close_sync+0x85d/0x1150 net/bluetooth/hci_sync.c:5383
 hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
 hci_error_reset+0x127/0x4c0 net/bluetooth/hci_core.c:998
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 6b e7 52 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 3c 8a 74 fd 49 8b 17 48 c7 c7 a0 be 28 8c 48 89 de 4c 89 f9 e8 e7 26 6b fc 90 <0f> 0b 4c 89 f7 e8 3c e7 52 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 0d
RSP: 0018:ffffc9000202f800 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff8880682f5578 RCX: 5386ffdc73148000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1cfd240 R12: 1ffff110053554af
R13: dffffc0000000000 R14: ffff888029aaa578 R15: ffff888029aaa578
FS:  0000000000000000(0000) GS:ffff8881253a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1552dd9062 CR3: 000000001f339000 CR4: 0000000000350ef0


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
