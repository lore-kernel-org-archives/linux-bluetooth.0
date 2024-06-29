Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B623BB25
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719649643; cv=none; b=TujlbS1Nf3HUO+RHK+RPkGNmkkUv3aJES8Lp9zV9LZ/pM3e9tDmuUtBwU6xrzDJwPKIMjny7I1D238kDky8fs4AmUURUn1gXgRspnsoY+mFCOBsZK+jnvS5NIqWorA/g46y/vKexfk9Rpp3Jz4hHWsMSk/SCPvwuW/vMuF/zkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719649643; c=relaxed/simple;
	bh=Kv6rOQeTQjJm+eHSsClam0ELHABLKhQmLp1/gLbP8Q8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jPHM1rxEWLaBlJ85GW/UWzPdloSN2clgJ/Za57sEf3CO3AwjM9k6sigHKGpNHIq5qoW7aanFsPFCmB27Ro/dUPP5W53lQnAcCLqu17MIrEItNpJy+CltjN5iWjoqCkKfaF+Gbj3mBcVA5gcX2isQNHVS454CGi4VHZySZQ2cR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3d5b154f5so146657739f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719649641; x=1720254441;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leRQjW/M2GuG9bawnTwlFU+Rk/x3WUlL9uuTK+K5PXg=;
        b=Z5BW6AJFIW2BjxCceKRQpcz7NIZRrsqLlv4FcjqeiLTgmjUH5Ddb6TGB5ePMZh+GTS
         WLQgSJFpX9km0K4O9y+tGspEPBRv93CLZYQPMDOyxRwR5RxVTFaXyQmwpNutoswg1zK0
         Aqf9eaRTYIQirpDa3cls2OegBRqluxPlWPEZQzwvF6Gqh0EJrUGUXEABP7Rriyr5iLsq
         QxpSr7XMFhry8DCEiHU4YyngeEhajmSBebj4zeo5Aia8vQEgBfSHW/vnbFw47In/jg1S
         aN8OpDX6m3htMm0rb0lHOup7GF3jvNZ8nb68Y9lxBg3NUOgNTshXp+Fn+usmRDO7d3wi
         bKVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWmaqAhsJJdsaqCkUlVM/JxLFneoIGmrHeEiv8WNRKM2LnCDoK/YkmPGHVcK5AObDUTBbTt62ArMazdxAlW4UcWWsF/8STBkgYO4hbMiPs
X-Gm-Message-State: AOJu0YyRMhfAvMERPFz6+4K6Xfjj5XZA5L1VtE8oUohl0+UwPN4qQv8Q
	3JAsr7xjC9Sps6zx3sIyfMnMb4Nl54nmNJXMv6scXe94NMqRnyysnra28jpuSpfYrClNrc5utHD
	bYPFj1xmcbs4ok4Y/qu5Li8u6lSXnb91auEtsWZwCK1TArJJIobzz2g0=
X-Google-Smtp-Source: AGHT+IHT/eZkVTgPmvSeNCLwxLK9x0jZymt+lL8Z9WtwY2ROW8PktaEjXhfW7EnKtAwZTJzn0sqogj+/dD5qokihBFOYOiVliigg
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8519:b0:4b9:685d:7f2a with SMTP id
 8926c6da1cb9f-4bbb6f94a33mr29448173.4.1719649641234; Sat, 29 Jun 2024
 01:27:21 -0700 (PDT)
Date: Sat, 29 Jun 2024 01:27:21 -0700
In-Reply-To: <0000000000009f2fe006185570d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001140f061c0322d0@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in lock_sock_nested (3)
From: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
To: hdanton@sina.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	nstange@suse.de, syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6c0483dbfe72 Merge tag 'nfsd-6.10-3' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166dd081980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134b8f89980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15373b8e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c089ba9c9453/disk-6c0483db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a8f5c77bdcc/vmlinux-6c0483db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfd6a6716dea/bzImage-6c0483db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/sock.c:3536
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5090, name: kworker/u9:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by kworker/u9:2/5090:
 #0: ffff88802e05a148 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88802e05a148 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000351fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000351fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff8880214bc078 (&hdev->lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0xb1/0xaa0 net/bluetooth/hci_event.c:4926
 #3: ffffffff8f73f388 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1967 [inline]
 #3: ffffffff8f73f388 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0x532/0xaa0 net/bluetooth/hci_event.c:5009
 #4: ffff8880122c1220 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff8880122c1220 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1277 [inline]
 #4: ffff8880122c1220 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x28a/0xb40 net/bluetooth/sco.c:1362
 #5: ffff88802bc87258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
 #5: ffff88802bc87258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 #5: ffff88802bc87258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5090 Comm: kworker/u9:2 Not tainted 6.10.0-rc5-syzkaller-00243-g6c0483dbfe72 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
 lock_sock_nested+0x5d/0x100 net/core/sock.c:3536
 lock_sock include/net/sock.h:1602 [inline]
 sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
 hci_event_func net/bluetooth/hci_event.c:7417 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7469
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4074
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
