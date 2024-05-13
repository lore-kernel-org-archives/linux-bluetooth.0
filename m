Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249382488
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642837; cv=none; b=PtVN1B3T/AAgiicQXQfbcfcemgOEvvfurueICMz8Q222sXCm17/mRB3QxB8ghWLj13vOY/8n3lEyVFC6ue0mAP+AawJJRVMPadoU2VFhkgEKTMiSCTSnYqZWqvYqTC/QucqwyQ2ZN5u0Vz/WulKznMvpIcvZwVtHVZ66F/E+myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642837; c=relaxed/simple;
	bh=zMzkmfe/SImkrDD6F58Ahl/biyaLPosnlc2zhtCaLCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQwsXXZTT3AjZYpj4HnGeqCez+fVkbEuEeygG6H1lZw0K+F0iCGR9JjKkrAYuljD/N/LMZL+hf29RefEZAyogZLXGHMAcTTYehVKqKgaU1GOgSYFzMesw2vdvZdTBNgSXo4T554C+aXE0AjcVwskGp8zNlPMK5DXRgFXFGZy2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.104])
	by sina.com (172.16.235.25) with ESMTP
	id 6642A1C600000526; Mon, 14 May 2024 07:27:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 60530034210354
X-SMAIL-UIID: F7BD05331E194D2091A55FB4A3CBD377-20240514-072704-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Takashi Iwai <tiwai@suse.de>,
	Nicolai Stange <nstange@suse.de>,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in lock_sock_nested (3)
Date: Tue, 14 May 2024 07:26:52 +0800
Message-Id: <20240513232652.3080-1-hdanton@sina.com>
In-Reply-To: <0000000000009f2fe006185570d8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 05:58:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    1c9135d29e9e Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10df1ea8980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2d53e64c7e6a4f
> dashboard link: https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/52dd1b4921ab/disk-1c9135d2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a4f1788dc25/vmlinux-1c9135d2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b8d8ebd42a80/Image-1c9135d2.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at net/core/sock.c:3537
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6274, name: kworker/u9:3
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 6 locks held by kworker/u9:3/6274:
>  #0: ffff0000d8c79948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x668/0x15d4 kernel/workqueue.c:3241
>  #1: ffff8000a9cb7c20 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x6b4/0x15d4 kernel/workqueue.c:3241
>  #2: ffff0000e8294078 (&hdev->lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0xa4/0x870 net/bluetooth/hci_event.c:5061
>  #3: ffff800091d51708 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2010 [inline]
>  #3: ffff800091d51708 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0x3d4/0x870 net/bluetooth/hci_event.c:5144
>  #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1273 [inline]
>  #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x260/0x94c net/bluetooth/sco.c:1358
>  #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1673 [inline]
>  #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_conn_ready net/bluetooth/sco.c:1286 [inline]
>  #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x3e8/0x94c net/bluetooth/sco.c:1358
> Preemption disabled at:
> [<ffff80008a0d70d4>] spin_lock include/linux/spinlock.h:351 [inline]
> [<ffff80008a0d70d4>] sco_conn_ready net/bluetooth/sco.c:1273 [inline]
> [<ffff80008a0d70d4>] sco_connect_cfm+0x260/0x94c net/bluetooth/sco.c:1358

A known issue in 2021 [1]

[1] Subject: Possible sleep-in-atomic in BT SCO code
https://lore.kernel.org/lkml/s5hilz8n1an.wl-tiwai@suse.de/

> CPU: 0 PID: 6274 Comm: kworker/u9:3 Not tainted 6.9.0-rc7-syzkaller-g1c9135d29e9e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: hci0 hci_rx_work
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
>  dump_stack+0x1c/0x28 lib/dump_stack.c:123
>  __might_resched+0x374/0x4d0 kernel/sched/core.c:10197
>  __might_sleep+0x90/0xe4 kernel/sched/core.c:10126
>  lock_sock_nested+0x6c/0x11c net/core/sock.c:3537
>  lock_sock include/net/sock.h:1673 [inline]
>  sco_conn_ready net/bluetooth/sco.c:1286 [inline]
>  sco_connect_cfm+0x3e8/0x94c net/bluetooth/sco.c:1358
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2013 [inline]
>  hci_sync_conn_complete_evt+0x438/0x870 net/bluetooth/hci_event.c:5144
>  hci_event_func net/bluetooth/hci_event.c:7545 [inline]
>  hci_event_packet+0x740/0x1098 net/bluetooth/hci_event.c:7597
>  hci_rx_work+0x318/0xa78 net/bluetooth/hci_core.c:4171
>  process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
>  process_scheduled_works kernel/workqueue.c:3348 [inline]
>  worker_thread+0x938/0xef4 kernel/workqueue.c:3429
>  kthread+0x288/0x310 kernel/kthread.c:388
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Bluetooth: hci0: command tx timeout
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
