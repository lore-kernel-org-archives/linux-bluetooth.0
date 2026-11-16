Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825002;
	b=vVfvKWvVjGVFvVWNxRtHo6kc6WdLouc1QnFKNuWC5kNw5hr8UZJ3lZcM54ytdnnae3/s
	 QyEyMeENYaDn28NK7lLeh+GfLmYNqsKB+BwkSdpk8Df3Nz4+QEsMv4Z6YLW2MJGv4Kqgf
	 f7pHP4eLPsNN/EKVg85/0bp2ir71HTL46p1NT5ryAHyfHdUDTS/uL8OMalnEskyPjj/Bl
	 GTB+37It5oFES2LhoZIYDCtPq0Bm0LZMaDZbNqJwexx10nQgv2D/HtngLpCGfFzMHzYyT
	 ft1DndGpOzu2M6DaMOv+OjwDmA6NtP0GBTUU7KTGmqqourXQW84VbwU5pIidxdBVC1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825002;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=/1cdmyABstoM351Jd9SchcWWY1DQ8/OQeZxf5NBIclE=;
	b=yab52xSR3wdWCJBzgFS2xxprLu57zTXj08kVD/YfRn09NMe+3Dm1AfQ5JBlJminojrMa
	 dBF6AvYdUSzbLNDXGi+/SjFJJfkrU5+P7awBCjxMkJ2mc/YNqNmAV7rxmgImpADTqS11T
	 ZDDASOaZaFvnzW2K2yeqhx+O1bn/ooksOxFOcOkDklOYu8IJneKpFps0YRQtr4Tykz8eJ
	 jAzJ6w+nYxI7vwVvNRNSn7mvq53vqrvpXogGmEVeJEyYsLRH02DMWlbNjQc62AGGerz+a
	 LHP8knWnfJYX98cixZ36PCs/AYSacB0i9zX7gxKkif6ftDDRh5yCNhXeBqIrlVsnXNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02D606A330
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 10:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F02D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b26d8d2498so3985362b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 02:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825000; x=1795429800;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1cdmyABstoM351Jd9SchcWWY1DQ8/OQeZxf5NBIclE=;
        b=dE04LJR5MQjSJlIGy3QSXQ389r4w1xD0vPMS4z19AYAwJmIYeIRYIlnyHSIVpraXkl
         1BE8GMQU5VIkGTpIuh5oKj6fngwgGyB9x4J/mn0UiGh9MPafIHG57AWDepCm9xmiiGSq
         xOoTnahXTCoh2S/eZ0NP840495aiz25vd6CSO/dv5SY26v3kKxbWobyrhjB0NLklU7s3
         c278gG512iwWwDxgq8JAjeypN4SlKA+TNjkifbudEKH9S5NW32BoPfZoWtLo04QLDbGy
         g/H5sOxvUPbt8KvA30ocN+9E0IhPRjoJlnUoIUUrVlA20O0Sp4EWqhXrFqbdMrYsMjPj
         oHNg==
X-Gm-Message-State: APuU4Z8zYgMM6/duqt6ggfN3WLZ9/tmV2/gQhqNbVLTQR4LANE4Qwf6U
	RXFpygh1dAzbNSY/O9jI5+Xs8mqpSKDhoWH83053iO2SqfYHVn/UwmVTi+toNSi8pM+i2y0Na9p
	kW3uE4Ba+uDS+9JdcIT95tAA8ktP2IgFUmn+bWaazqxE7mnxixY8m5+0AT3Y=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fce:b0:572:f1d1:d6b3 with SMTP id
 5614622812f47-572f1d1e88amr4083111b6e.21.1794825000699; Mon, 16 Nov 2026
 02:30:00 -0800 (PST)
Date: Mon, 16 Nov 2026 02:30:00 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afadb28.371d364b.254eb1.0017.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in add_ext_adv_params_complete
From: syzbot <syzbot+fc55a609cd9deea4ea37@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6964ff21c5d8 net: mana: Allocate queue MSI-X vectors on de..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142d103d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fbc480f13a2deb8
dashboard link: https://syzkaller.appspot.com/bug?extid=fc55a609cd9deea4ea37
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10448f4c9816/disk-6964ff21.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd950eb7eaec/vmlinux-6964ff21.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90c2418ba3c7/bzImage-6964ff21.xz

AI-generated root cause summary:
An ABBA circular locking dependency exists between hdev->lock and
hdev->cmd_sync_work_lock in the Bluetooth subsystem. Callers holding
hci_dev_lock(hdev) (such as MGMT command handlers and HCI event handlers)
acquire hdev->cmd_sync_work_lock when enqueuing or looking up cmd_sync work via
hci_cmd_sync_queue()/hci_cmd_sync_queue_once(). Conversely, hci_cmd_sync_clear()
(and related cancellation paths in net/bluetooth/hci_sync.c) acquires
hdev->cmd_sync_work_lock and calls _hci_cmd_sync_cancel_entry(), which invokes
entry->destroy (e.g. add_ext_adv_params_complete) while still holding
hdev->cmd_sync_work_lock. Because entry->destroy attempts to acquire
hci_dev_lock(hdev), this inverts the lock hierarchy and causes a deadlock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=fc55a609cd9deea4ea37

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc55a609cd9deea4ea37@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor/5634 is trying to acquire lock:
ffff8880298c40b8 (&hdev->lock){+.+.}-{4:4}, at: add_ext_adv_params_complete+0xd5/0x890 net/bluetooth/mgmt.c:9253

but task is already holding lock:
ffff8880298c47c0 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0xfb/0x3f0 net/bluetooth/hci_sync.c:682

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       hci_cmd_sync_lookup_entry net/bluetooth/hci_sync.c:869 [inline]
       hci_cmd_sync_queue_once+0x42/0x250 net/bluetooth/hci_sync.c:806
       hci_update_passive_scan+0x1bf/0x210 net/bluetooth/hci_sync.c:3518
       le_conn_complete_evt+0xee9/0x18d0 net/bluetooth/hci_event.c:6106
       hci_le_conn_complete_evt+0x187/0x470 net/bluetooth/hci_event.c:6117
       hci_event_func net/bluetooth/hci_event.c:8084 [inline]
       hci_event_packet+0x67a/0xf10 net/bluetooth/hci_event.c:8138
       hci_rx_work+0x2b4/0x1110 net/bluetooth/hci_core.c:4150
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&hdev->lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       add_ext_adv_params_complete+0xd5/0x890 net/bluetooth/mgmt.c:9253
       _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:667 [inline]
       hci_cmd_sync_clear+0x1b4/0x3f0 net/bluetooth/hci_sync.c:684
       hci_unregister_dev+0x1b4/0x5c0 net/bluetooth/hci_core.c:2697
       vhci_release+0x16d/0x1c0 drivers/bluetooth/hci_vhci.c:704
       __fput+0x408/0xa40 fs/file_table.c:512
       fput_close_sync+0x11f/0x240 fs/file_table.c:618
       filp_close_sync+0x6e/0xa0 fs/open.c:1574
       close_files fs/file.c:572 [inline]
       put_files_struct+0x230/0x3c0 fs/file.c:584
       do_exit+0x6f0/0x2360 kernel/exit.c:977
       do_group_exit+0x22d/0x2f0 kernel/exit.c:1123
       get_signal+0x136a/0x1430 kernel/signal.c:3113
       arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
       __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
       exit_to_user_mode_loop+0x10e/0x770 kernel/entry/common.c:101
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
       do_syscall_64+0x32c/0x530 arch/x86/entry/syscall_64.c:107
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

locks held by syz-executor/5634: 1, on CPU#1:
 #0: ffff8880298c47c0 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0xfb/0x3f0 net/bluetooth/hci_sync.c:682

stack backtrace:
CPU: 1 UID: 0 PID: 5634 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 add_ext_adv_params_complete+0xd5/0x890 net/bluetooth/mgmt.c:9253
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:667 [inline]
 hci_cmd_sync_clear+0x1b4/0x3f0 net/bluetooth/hci_sync.c:684
 hci_unregister_dev+0x1b4/0x5c0 net/bluetooth/hci_core.c:2697
 vhci_release+0x16d/0x1c0 drivers/bluetooth/hci_vhci.c:704
 __fput+0x408/0xa40 fs/file_table.c:512
 fput_close_sync+0x11f/0x240 fs/file_table.c:618
 filp_close_sync+0x6e/0xa0 fs/open.c:1574
 close_files fs/file.c:572 [inline]
 put_files_struct+0x230/0x3c0 fs/file.c:584
 do_exit+0x6f0/0x2360 kernel/exit.c:977
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1123
 get_signal+0x136a/0x1430 kernel/signal.c:3113
 arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x10e/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x32c/0x530 arch/x86/entry/syscall_64.c:107
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35a9f69d0e
Code: Unable to access opcode bytes at 0x7f35a9f69ce4.
RSP: 002b:00007ffe3a7895f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00005555922b8500 RCX: 00007f35a9f69d0e
RDX: 0000000000000030 RSI: 00007ffe3a7896f0 RDI: 00000000000000f9
RBP: 00007ffe3a78969c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000258
R13: 000000000000002b R14: 000000000006526d R15: 00007ffe3a7896f0
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
