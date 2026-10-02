Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC0361DCB
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921737; cv=none; b=caJ1LAFeVYGrit20D5SLtIm5kZ2Q/CJgudJG+7+SqEahbtaTkaawrmfrtimTBcpc21yKiSIPDXfFsGf7oj1n6lY3uo2laVAXm0pyGlmPJJ7oEAeh3AyvWkHvMt9fSYYFSF/cGdp22mCX0vTEfG46cwKOlq2wvtum5nmSxqirhss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921737; c=relaxed/simple;
	bh=cCWTomR+IxE8n110azN/buoa+QOBIeOrS7DImRQP20I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q0Q/mtsFvmGhrRtrw6i+KlyIfE1n5z3s++iUzMe41RgtTEIXaEJUGpYc0XtYOBcFCMf/0ZYVeMFXc/Fk2PndXR63Rhb6IeqKO8XXMl8XbGz0W5jumwz/lA8UtVDrwHxmNwhdGFgp727ElwdNglOMdTmueDckIFCtJqhVjCn9RLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab4f652f9bso7310664b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790921734; x=1791526534;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHl164KF9QmUiHMYC+0V/c2CfiNGjgIdO8kbSXlbTVs=;
        b=RUS9v5/FXCmPFqskPtBDAH9UPFk33dQoKncAEPCq1BXj2gP1A9KNt9OtJ2Vk0QQlTc
         Th3tg9sCTfmazFbcoRTJC+DiTv7K7VbU5io+1GdJfmVFSobTVyswyxE19NIXkRtjapXq
         dmwzoNtFpbTR927jN0ZTCk+7OYnUKFQkDzAtDpFu9oYDYuiU4XCzvkOE3881FII3BGf3
         SAJkmama6FiVy3DmlLa4jVqlTi4VEmCsoACfhGLN8sVCNy5+Khu4fyR5YGi0ntekUabP
         1UI3jvXns/jS9x+o04lLVafeuH7/w/tgghU7r+UwBL9l0K+wE13SXrDO7kU24Kml9BfY
         KEBw==
X-Gm-Message-State: AFuF++nyjq/aMhttVlZ/SLv/X1SG3tuLzRPPxBJ98KciqCVfISLh3P84
	UNrB0FCXPC5MZPmz38sHws03WpAB6yFPC3MOcVrUWqA4Wgog//E9obi8+T8VTbG1xWlrKppWog3
	NSuUfeydMxF//sOqiW0iWy9zD5FSvXIWG28YPW+uO5/kbMqP96/TEIA6Mdx0=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1315:b0:4e6:76eb:b997 with SMTP id
 5614622812f47-4f52a5776f4mr1201120b6e.62.1790921734140; Thu, 01 Oct 2026
 23:15:34 -0700 (PDT)
Date: Thu, 01 Oct 2026 23:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abf4c06.9b478af7.e8d7a.0007.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in rfcomm_run
From: syzbot <syzbot+0adf2aef8ca78b84c4df@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d266640c6c76 Merge tag 'driver-core-7.3-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1586b315580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=0adf2aef8ca78b84c4df
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d266640c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8d2ccf5a23e/vmlinux-d266640c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b1dbd9ea9d5/bzImage-d266640c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0adf2aef8ca78b84c4df@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
krfcommd/3367 is trying to acquire lock:
ffff888062feb940 ((wq_completion)hci3){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x9c/0x1c0 kernel/workqueue.c:4111

but task is already holding lock:
ffffffff90f83cc0 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2096 [inline]
ffffffff90f83cc0 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_run+0x30b/0x5550 net/bluetooth/rfcomm/core.c:2205

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (rfcomm_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       rfcomm_dlc_open+0x92/0xac0 net/bluetooth/rfcomm/core.c:426
       rfcomm_dev_activate+0x83/0x110 net/bluetooth/rfcomm/tty.c:112
       tty_port_open+0x156/0x1f0 drivers/tty/tty_port.c:769
       rfcomm_tty_open+0xad/0x490 net/bluetooth/rfcomm/tty.c:745
       tty_open+0x2cc/0xe20 drivers/tty/tty_io.c:2110
       chrdev_open+0x234/0x6a0 fs/char_dev.c:411
       do_dentry_open+0x6ab/0x14d0 fs/open.c:996
       vfs_open+0x82/0x3f0 fs/open.c:1101
       do_open fs/namei.c:4837 [inline]
       path_openat+0x19fa/0x2440 fs/namei.c:5000
       do_file_open+0x20e/0x430 fs/namei.c:5029
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_open fs/open.c:1431 [inline]
       __se_sys_open fs/open.c:1427 [inline]
       __x64_sys_open+0xfe/0x1d0 fs/open.c:1427
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&port->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       class_mutex_constructor include/linux/mutex.h:253 [inline]
       uart_set_termios+0x8e/0x690 drivers/tty/serial/serial_core.c:1646
       tty_set_termios+0x64d/0x980 drivers/tty/tty_ioctl.c:341
       set_termios+0x5c8/0x880 drivers/tty/tty_ioctl.c:516
       tty_mode_ioctl+0x17e/0xd40 drivers/tty/tty_ioctl.c:803
       n_tty_ioctl_helper+0x47/0x2b0 drivers/tty/tty_ioctl.c:982
       n_tty_ioctl+0x53/0x340 drivers/tty/n_tty.c:2496
       tty_ioctl+0x11b4/0x1640 drivers/tty/tty_io.c:2774
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&tty->termios_rwsem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       class_rwsem_write_constructor include/linux/rwsem.h:270 [inline]
       n_tty_flush_buffer+0x25/0x1b0 drivers/tty/n_tty.c:349
       tty_buffer_flush+0x239/0x310 drivers/tty/tty_buffer.c:248
       tty_ldisc_flush+0x68/0xf0 drivers/tty/tty_ldisc.c:388
       tty_port_close_start+0x306/0x500 drivers/tty/tty_port.c:648
       tty_port_close+0x26/0x170 drivers/tty/tty_port.c:703
       tty_release+0x40e/0x1300 drivers/tty/tty_io.c:1718
       __fput+0x3ff/0xb50 fs/file_table.c:512
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
       exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
       do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&buf->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:236
       tty_ldisc_flush+0xad/0xf0 drivers/tty/tty_ldisc.c:388
       hci_uart_flush+0xed/0x630 drivers/bluetooth/hci_ldisc.c:255
       hci_uart_close+0x1d/0x90 drivers/bluetooth/hci_ldisc.c:292
       hci_dev_open_sync+0x126f/0x25e0 net/bluetooth/hci_sync.c:5480
       hci_dev_do_open+0x2a/0xb0 net/bluetooth/hci_core.c:431
       hci_power_on+0x131/0x630 net/bluetooth/hci_core.c:923
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&hdev->req_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       hci_dev_do_open+0x22/0xb0 net/bluetooth/hci_core.c:429
       hci_power_on+0x131/0x630 net/bluetooth/hci_core.c:923
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 ((work_completion)(&hdev->power_on)){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       process_one_work+0xa32/0x1b10 kernel/workqueue.c:3372
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((wq_completion)hci3){+.+.}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       touch_wq_lockdep_map+0xad/0x1c0 kernel/workqueue.c:4111
       __flush_workqueue+0x131/0x1200 kernel/workqueue.c:4153
       drain_workqueue+0x175/0x3b0 kernel/workqueue.c:4317
       destroy_workqueue+0xc3/0xa30 kernel/workqueue.c:6155
       hci_release_dev+0x14d/0x630 net/bluetooth/hci_core.c:2717
       bt_host_release+0x6b/0xb0 net/bluetooth/hci_sysfs.c:100
       device_release+0xd2/0x270 drivers/base/core.c:2640
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x1f7/0x640 lib/kobject.c:737
       put_device+0x1f/0x30 drivers/base/core.c:3884
       device_release+0xd2/0x270 drivers/base/core.c:2640
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x1f7/0x640 lib/kobject.c:737
       put_device+0x1f/0x30 drivers/base/core.c:3884
       hci_conn_put include/net/bluetooth/hci_core.h:1689 [inline]
       l2cap_conn_free net/bluetooth/l2cap_core.c:1856 [inline]
       kref_put include/linux/kref.h:65 [inline]
       l2cap_conn_put net/bluetooth/l2cap_core.c:1869 [inline]
       l2cap_chan_destroy net/bluetooth/l2cap_core.c:494 [inline]
       kref_put include/linux/kref.h:65 [inline]
       l2cap_chan_put+0x352/0x3f0 net/bluetooth/l2cap_core.c:521
       l2cap_sock_release+0x1db/0x280 net/bluetooth/l2cap_sock.c:1533
       __sock_release net/socket.c:735 [inline]
       sock_release+0x91/0x1c0 net/socket.c:763
       rfcomm_session_del.isra.0+0x16b/0x250 net/bluetooth/rfcomm/core.c:718
       rfcomm_process_rx net/bluetooth/rfcomm/core.c:2030 [inline]
       rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2115 [inline]
       rfcomm_run+0x6f6/0x5550 net/bluetooth/rfcomm/core.c:2205
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  (wq_completion)hci3 --> &port->mutex --> rfcomm_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfcomm_mutex);
                               lock(&port->mutex);
                               lock(rfcomm_mutex);
  lock((wq_completion)hci3);

 *** DEADLOCK ***

locks held by krfcommd/3367: 1, last CPU#1:
 #0: ffffffff90f83cc0 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2096 [inline]
 #0: ffffffff90f83cc0 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_run+0x30b/0x5550 net/bluetooth/rfcomm/core.c:2205

stack backtrace:
CPU: 1 UID: 0 PID: 3367 Comm: krfcommd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 touch_wq_lockdep_map+0xad/0x1c0 kernel/workqueue.c:4111
 __flush_workqueue+0x131/0x1200 kernel/workqueue.c:4153
 drain_workqueue+0x175/0x3b0 kernel/workqueue.c:4317
 destroy_workqueue+0xc3/0xa30 kernel/workqueue.c:6155
 hci_release_dev+0x14d/0x630 net/bluetooth/hci_core.c:2717
 bt_host_release+0x6b/0xb0 net/bluetooth/hci_sysfs.c:100
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 hci_conn_put include/net/bluetooth/hci_core.h:1689 [inline]
 l2cap_conn_free net/bluetooth/l2cap_core.c:1856 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1869 [inline]
 l2cap_chan_destroy net/bluetooth/l2cap_core.c:494 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_chan_put+0x352/0x3f0 net/bluetooth/l2cap_core.c:521
 l2cap_sock_release+0x1db/0x280 net/bluetooth/l2cap_sock.c:1533
 __sock_release net/socket.c:735 [inline]
 sock_release+0x91/0x1c0 net/socket.c:763
 rfcomm_session_del.isra.0+0x16b/0x250 net/bluetooth/rfcomm/core.c:718
 rfcomm_process_rx net/bluetooth/rfcomm/core.c:2030 [inline]
 rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2115 [inline]
 rfcomm_run+0x6f6/0x5550 net/bluetooth/rfcomm/core.c:2205
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
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
