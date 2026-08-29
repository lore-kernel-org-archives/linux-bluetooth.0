Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA53955C9
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788017374; cv=none; b=rh2Syqvcel8/dFkYCQY/vA+Z05UaFsIkekgzLmKXve5FU6bI7bhEx+WfwNZtsHYSieWs3ehIWOUAk8KniqFsHAsPYhPUoqjJo/d5sAc2NWjHEzNyxa7PlhJP8CSj4KllWRUXR4TOgCZROkIYeyHpriDkMZOe4zLFeN3G93bDchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788017374; c=relaxed/simple;
	bh=CMjiRMXOFhOQJ3t7mMhYPWlT9GWHNsHC2vJnmo61tCk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tSNa/Jgu8b96kCCkwaMRI19ZhM2BCoWnPaw6wG69/1Mc97SfW/r2yMB8+N+6Sh11Cu0c87lT3llYY7zjDK+NMqlAyncDPOCNqOXXmrlojrG+andIiB+a2ua/D/09aXrZVizyJbZ5rQQXnTHl+4X8bzdSdwDpvjzqaL3lMlkJ1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so684747b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788017372; x=1788622172;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzsG6loT0ZKDWeUwY7zsbCAw31VaYMQZw7KvYQB7hbk=;
        b=JVScBK59UlNCkkC6QmS8sRKkAmr/UPYP2vzukz7vCPR5DPTrT2JSF257TvYD77KThG
         2F0v3IU9QilxvDtxkMKRXueici3EpGbDWiEItF8DAhyHOuAvaGJ/McfL3iTtakT5jiEF
         kB036yBrvUXJhy5xJUp1ZLpdWeSbs0qGbz/pD9NA2J9WAsakm3yWDyE33JhuwzKOrXgs
         +KeVSEXshe0cXi5T8hbwPMMR3XqHVWBlOpBJjkkQ1BeS/hzFV9dTHDRsPsr1SrSA1Xwj
         Iz23oH6WGKekr/fLQb1WQ/I4leaDOWDgmPIc3r4zPWAZwTZ9Dtmf0IYDysLXZXsfzhPu
         HmHA==
X-Gm-Message-State: AFuF++lnuDAznk0/qbxvpKjri4MdyQCRrE/xBUl3ggc3G9XKoP7FKkz+
	NFDHM74M29Ifwsmf63osp366tSHvWs7VqYtoX3m0S0kebRLjDfNRSpYAH832Vq5U7SpvoBrrzHv
	u5fwwRPYYSaH8tyAJxnDTtFoWl/tGj1InuE3W1eOXqa5/WXzRXUfctUXj3OQ6cg==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2388:b0:4b3:1e40:640b with SMTP id
 5614622812f47-4b39800d0ecmr15540866b6e.6.1788017372140; Sat, 29 Aug 2026
 08:29:32 -0700 (PDT)
Date: Sat, 29 Aug 2026 08:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a92fadc.08e933ee.dbf97.008f.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in rfcomm_security_cfm
From: syzbot <syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf72cbb39da8 Merge tag 'io_uring-7.3-20260828' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8ae25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=74071deb72339c215b2e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7684a30c51dd/disk-cf72cbb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f401bdb1bb3/vmlinux-cf72cbb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4379cea44543/bzImage-cf72cbb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
kworker/u9:2/5598 is trying to acquire lock:
ffffffff90f7e040 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222

but task is already holding lock:
ffffffff90f51500 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_encrypt_cfm+0x11b/0x740 include/net/bluetooth/hci_core.h:2239

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       hci_connect_cfm include/net/bluetooth/hci_core.h:2163 [inline]
       hci_remote_features_evt+0x485/0x9b0 net/bluetooth/hci_event.c:3786
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4041
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
       process_scheduled_works kernel/workqueue.c:3470 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&hdev->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       l2cap_chan_connect+0xac/0x2050 net/bluetooth/l2cap_core.c:7266
       l2cap_sock_connect+0x37a/0x770 net/bluetooth/l2cap_sock.c:255
       kernel_connect+0x107/0x160 net/socket.c:3755
       rfcomm_session_create net/bluetooth/rfcomm/core.c:808 [inline]
       __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:385 [inline]
       rfcomm_dlc_open+0x838/0xac0 net/bluetooth/rfcomm/core.c:428
       rfcomm_sock_connect+0x42c/0x690 net/bluetooth/rfcomm/sock.c:421
       connect_socket net/socket.c:2141 [inline]
       connect_socket net/socket.c:2131 [inline]
       __sys_connect_file+0x146/0x1a0 net/socket.c:2166
       __sys_connect+0x141/0x170 net/socket.c:2183
       __do_sys_connect net/socket.c:2189 [inline]
       __se_sys_connect net/socket.c:2186 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2186
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rfcomm_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222
       hci_encrypt_cfm+0x18e/0x740 include/net/bluetooth/hci_core.h:2242
       hci_encrypt_change_evt+0x3e1/0xfb0 net/bluetooth/hci_event.c:3715
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4041
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
       process_scheduled_works kernel/workqueue.c:3470 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(rfcomm_mutex);

 *** DEADLOCK ***

locks held by kworker/u9:2/5598: 4, last CPU#0:
 #0: ffff88802e39e940 ((wq_completion)hci3#2){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3362
 #1: ffffc9000250fd08 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3363
 #2: ffff88807d7b80b8 (&hdev->lock){+.+.}-{4:4}, at: hci_encrypt_change_evt+0x83/0xfb0 net/bluetooth/hci_event.c:3627
 #3: ffffffff90f51500 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_encrypt_cfm+0x11b/0x740 include/net/bluetooth/hci_core.h:2239

stack backtrace:
CPU: 0 UID: 0 PID: 5598 Comm: kworker/u9:2 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
 lock_acquire kernel/locking/lockdep.c:5908 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
 rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222
 hci_encrypt_cfm+0x18e/0x740 include/net/bluetooth/hci_core.h:2242
 hci_encrypt_change_evt+0x3e1/0xfb0 net/bluetooth/hci_event.c:3715
 hci_event_func net/bluetooth/hci_event.c:7887 [inline]
 hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
 hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4041
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
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
