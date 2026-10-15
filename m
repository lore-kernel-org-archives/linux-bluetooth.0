Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40E32C942
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035951; cv=none; b=HrXWikthEX5m8pN9+DhpRiBCdXQUsqZBB1357clS9aVUJRVQnmMK6V9EH977CSGjCewyhE/q8Z1XHZ1oau47Spfwt93/RBFQIkxCDtkMK76f5knVD5N9aG5/zQwbCtEM8X/NIohJ/XsLRTc4P/D8cxXjmTr6b7hJIPIoSXhRkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035951; c=relaxed/simple;
	bh=iPTfV/w0bH2qLEAQognyuRqxiEnHwgSvJDziKn/eQ5c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VMANTJu0qdA0Lnj180XGrR588iNUoaIyDymLeza+kYiYeEeFm0CpwYGKka0ur8SWVgkIqjhZkTb5lFZXNUIyFSbNI9J3x2pcoHAWAghGW/wWxv04jwoflbvC+Q31S8tpRSpiQOp98liciBpuCl5n+FjuZcEnqYG1QxCIw3FJp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ea2c058e67so1569138b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 20:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035948; x=1792640748;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LDGSw/XVEaz9C8NJAHSXkAmYPuQKpJmpFf6V9pdZpA=;
        b=uiVJgbNpzj1d10noesDrjOIIITf2NmhEuOhxcg0S8Jmp/C8W0aMYFoLG4zcKWEjB/E
         2lolTKmq80y/cqMu10QXjI9/WUODp2GXOarZNq2UnILPS5tUX2/6gcgfV2MknVWxNR/q
         AFgFBiIp+WqJBEk/TS43k87CLbfeWyfiVJXO6LrfN+Vr4ErVfn6GU26bggHyYNOOWoJP
         nSmua8uyltK6HGlFKSfoPJT1EDePAs+WovNCfCJtU5UsEivJT6Q3exafVnDFSlpzxWmt
         z+oEQ7iVu0J1pMLODv+bIQAl+9sI7fHk93MRt5XInARFq1hORcTk3I80z8nMkgbKSqPk
         1Qng==
X-Gm-Message-State: AFq9FYJPFOW1T97vXomgCn3ILJnw5ZgMpZnolFeDXaVADj6JlI0IxK8H
	MlRa01ITDJiSkCoLNXSotA65NULqsQepIFJnA2sOUN7m/+HJIDyBNISyJqipD78Za2lJ2ZqpvHS
	/USUeOb8JEiT1sKBT3P7NoD9cR1wE6S6rS9Fmg8iU6iq3VLA5XtW2HjVe2MA=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3094:b0:4d6:90d3:e183 with SMTP id
 5614622812f47-50c57b67e0emr14242515b6e.44.1792035948521; Wed, 14 Oct 2026
 20:45:48 -0700 (PDT)
Date: Wed, 14 Oct 2026 20:45:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad04c6c.a150a118.27e199.006b.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in rfcomm_process_sessions
From: syzbot <syzbot+c8793045f4776ea20bc6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4eb2586bd40d Add linux-next specific files for 20261012
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1646563e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76b7c5acaea2288c
dashboard link: https://syzkaller.appspot.com/bug?extid=c8793045f4776ea20bc6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d38ae66aa67/disk-4eb2586b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/033558801021/vmlinux-4eb2586b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7219b4b1459d/bzImage-4eb2586b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8793045f4776ea20bc6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L      
------------------------------------------------------
krfcommd/3206 is trying to acquire lock:
ffff888037d3d948 ((wq_completion)hci2#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0xb5/0x180 kernel/workqueue.c:4272

but task is already holding lock:
ffffffff91825f00 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_process_sessions+0x2c6/0x9690 net/bluetooth/rfcomm/core.c:2150

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rfcomm_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       rfcomm_security_cfm+0x90/0x820 net/bluetooth/rfcomm/core.c:2277
       hci_auth_cfm include/net/bluetooth/hci_core.h:2250 [inline]
       hci_auth_complete_evt+0x39f/0xc80 net/bluetooth/hci_event.c:3635
       hci_event_func net/bluetooth/hci_event.c:8021 [inline]
       hci_event_packet+0x6cd/0xf10 net/bluetooth/hci_event.c:8072
       hci_rx_work+0x2b4/0x1110 net/bluetooth/hci_core.c:4124
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (hci_cb_list_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       hci_connect_cfm include/net/bluetooth/hci_core.h:2211 [inline]
       hci_remote_features_evt+0x53d/0x950 net/bluetooth/hci_event.c:3892
       hci_event_func net/bluetooth/hci_event.c:8021 [inline]
       hci_event_packet+0x6cd/0xf10 net/bluetooth/hci_event.c:8072
       hci_rx_work+0x2b4/0x1110 net/bluetooth/hci_core.c:4124
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&hdev->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       hci_send_cmd_sync net/bluetooth/hci_core.c:4163 [inline]
       hci_cmd_work+0xa0/0x850 net/bluetooth/hci_core.c:4212
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 ((work_completion)(&hdev->cmd_work)){+.+.}-{0:0}:
       process_one_work kernel/workqueue.c:3471 [inline]
       process_scheduled_works+0xc03/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((wq_completion)hci2#2){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:4272
       __flush_workqueue+0x148/0x10b0 kernel/workqueue.c:4314
       drain_workqueue+0xce/0x380 kernel/workqueue.c:4478
       destroy_workqueue+0xbe/0x7b0 kernel/workqueue.c:6372
       hci_release_dev+0xe3/0x1510 net/bluetooth/hci_core.c:2728
       bt_host_release+0x93/0xa0 net/bluetooth/hci_sysfs.c:100
       device_release+0xc4/0x1f0 drivers/base/core.c:-1
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x222/0x550 lib/kobject.c:737
       device_release+0xc4/0x1f0 drivers/base/core.c:-1
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x222/0x550 lib/kobject.c:737
       hci_conn_put include/net/bluetooth/hci_core.h:1737 [inline]
       l2cap_conn_free net/bluetooth/l2cap_core.c:1933 [inline]
       kref_put include/linux/kref.h:65 [inline]
       l2cap_conn_put net/bluetooth/l2cap_core.c:1946 [inline]
       l2cap_chan_destroy net/bluetooth/l2cap_core.c:495 [inline]
       kref_put include/linux/kref.h:65 [inline]
       l2cap_chan_put+0x1fd/0x350 net/bluetooth/l2cap_core.c:522
       l2cap_sock_release+0x1a2/0x230 net/bluetooth/l2cap_sock.c:1536
       __sock_release net/socket.c:735 [inline]
       sock_release+0x85/0x150 net/socket.c:763
       rfcomm_session_del+0x14b/0x270 net/bluetooth/rfcomm/core.c:782
       rfcomm_process_sessions+0x7456/0x9690 net/bluetooth/rfcomm/core.c:-1
       rfcomm_run+0x3f5/0x620 net/bluetooth/rfcomm/core.c:2259
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  (wq_completion)hci2#2 --> hci_cb_list_lock --> rfcomm_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfcomm_mutex);
                               lock(hci_cb_list_lock);
                               lock(rfcomm_mutex);
  lock((wq_completion)hci2#2);

 *** DEADLOCK ***

locks held by krfcommd/3206: 1, last CPU#1:
 #0: ffffffff91825f00 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_process_sessions+0x2c6/0x9690 net/bluetooth/rfcomm/core.c:2150

stack backtrace:
CPU: 1 UID: 0 PID: 3206 Comm: krfcommd Tainted: G             L       syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
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
 touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:4272
 __flush_workqueue+0x148/0x10b0 kernel/workqueue.c:4314
 drain_workqueue+0xce/0x380 kernel/workqueue.c:4478
 destroy_workqueue+0xbe/0x7b0 kernel/workqueue.c:6372
 hci_release_dev+0xe3/0x1510 net/bluetooth/hci_core.c:2728
 bt_host_release+0x93/0xa0 net/bluetooth/hci_sysfs.c:100
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 hci_conn_put include/net/bluetooth/hci_core.h:1737 [inline]
 l2cap_conn_free net/bluetooth/l2cap_core.c:1933 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1946 [inline]
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:495 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x1fd/0x350 net/bluetooth/l2cap_core.c:522
 l2cap_sock_release+0x1a2/0x230 net/bluetooth/l2cap_sock.c:1536
 __sock_release net/socket.c:735 [inline]
 sock_release+0x85/0x150 net/socket.c:763
 rfcomm_session_del+0x14b/0x270 net/bluetooth/rfcomm/core.c:782
 rfcomm_process_sessions+0x7456/0x9690 net/bluetooth/rfcomm/core.c:-1
 rfcomm_run+0x3f5/0x620 net/bluetooth/rfcomm/core.c:2259
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
