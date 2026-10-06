Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37264A0912
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303569; cv=none; b=YMTSN6oHe50Jn1dtXKIyM5vb6382eKWwET6/CHDMhL7Jk1LAYMV0AfJ76rP4OFkkkN7W6t28ybbP3LjGc2MCKF5hVLh0FpCvRhq32Cj2iB42QlFruVbonKByw0AwBFqdn8dTDn0/75hlm3W9PgPP/LAWu/uydssEuN6Z8IIccwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303569; c=relaxed/simple;
	bh=+L3nCM1/8BFjJDb5NR94sLtLbi4PV1zhhq4rjnZKcsU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rPb1O1kK/RWyFKGTxXxPiboOs1N+AIQCq6y8kHyKyz+quZETl4t5NE0Vqd5GIPugaKLxCmdHo6pu7jgwEGWj0l3DjMOIXZeF6RqFbi4anSZySvq3EZfkPV6TvXJp9USEzXDrp51oHSH2cXQe9gq5E3MhrBhf+nqaeYc6zM29Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e9eso4435148b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 09:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303566; x=1791908366;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nph5pTCt6D8BOiYO8V4HZw16r0IFAYn4xJK1YC3f8Bg=;
        b=ZGaxNSzr1tfviuH1OnuxHzMTBe8ic0cHTGSp7k7hWqQDAlbeSnunfAKpRC5RIEVvPj
         V46FrCQRz+RnFTZ8g7yJW88JzTKFg987wlZjeHagw45Y27CMZY5dAcDBmSfM4+j4BjeB
         ut8dplN4VfiR5Dyj1UhNQbNhEMzg6fsY5Reg8yd2WQ6c0iw6hQBvAqRUSvt0TT94ceau
         tA+K6sWrYyfyTYP0epC48PeAn/7BKjfqhyWxBGrqKoS8yTnxkTMhLu91FPjxVeCkUTI5
         jkS0zczZ/0COGAs+yB103wc8bapxmkxxS5NDWKoT2UWxs7copEqSjz6jXBfc6xmDLava
         JBgQ==
X-Gm-Message-State: AFuF++lfKM7or0Yp7FcecAkV1RDQOnWfliXqrtYxIcZu1gpIJcBcyREE
	rjusIF0Du0y02Uv4VzNcgTCf10z27jtf7OeMEZ7aujvNU5v6kwgo9WGH2jPSbguwFtmqPM/g+Fg
	XTUFNJbtiSxRo/TUxf1PoEZTJHYWaqE8UPAfbFP/jCPqsUezsNaWnyO2hbdg=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2384:b0:4e5:c2b4:33a3 with SMTP id
 5614622812f47-4fb415d61e1mr1585684b6e.45.1791303565794; Tue, 06 Oct 2026
 09:19:25 -0700 (PDT)
Date: Tue, 06 Oct 2026 09:19:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac51f8d.353c8d8e.177895.0006.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in l2cap_chan_connect (2)
From: syzbot <syzbot+1fed874be1d7e459b5a3@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c3418fffa9d Merge tag 'keys-v7.3-rc7' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca6ff5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929e4854a828f434
dashboard link: https://syzkaller.appspot.com/bug?extid=1fed874be1d7e459b5a3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e6f25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cfbff5580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2c3418ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1818dc9d2f44/vmlinux-2c3418ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ad1b5b053d/bzImage-2c3418ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fed874be1d7e459b5a3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/5921 is trying to acquire lock:
ffff88802d8700b8 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0xac/0x2110 net/bluetooth/l2cap_core.c:7289

but task is already holding lock:
ffffffff90f83f60 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open+0x92/0xac0 net/bluetooth/rfcomm/core.c:426

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rfcomm_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2223
       hci_auth_cfm include/net/bluetooth/hci_core.h:2203 [inline]
       hci_auth_complete_evt+0x811/0x1180 net/bluetooth/hci_event.c:3554
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4087
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (hci_cb_list_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       hci_connect_cfm include/net/bluetooth/hci_core.h:2164 [inline]
       hci_remote_features_evt+0x485/0x9b0 net/bluetooth/hci_event.c:3786
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4087
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&hdev->lock){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       l2cap_chan_connect+0xac/0x2110 net/bluetooth/l2cap_core.c:7289
       l2cap_sock_connect+0x37a/0x770 net/bluetooth/l2cap_sock.c:255
       kernel_connect+0x107/0x160 net/socket.c:3755
       rfcomm_session_create net/bluetooth/rfcomm/core.c:808 [inline]
       __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:385 [inline]
       rfcomm_dlc_open+0x838/0xac0 net/bluetooth/rfcomm/core.c:428
       rfcomm_sock_connect+0x42c/0x690 net/bluetooth/rfcomm/sock.c:419
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

other info that might help us debug this:

Chain exists of:
  &hdev->lock --> hci_cb_list_lock --> rfcomm_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfcomm_mutex);
                               lock(hci_cb_list_lock);
                               lock(rfcomm_mutex);
  lock(&hdev->lock);

 *** DEADLOCK ***

locks held by syz.0.17/5921: 1, last CPU#3:
 #0: ffffffff90f83f60 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open+0x92/0xac0 net/bluetooth/rfcomm/core.c:426

stack backtrace:
CPU: 3 UID: 0 PID: 5921 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 l2cap_chan_connect+0xac/0x2110 net/bluetooth/l2cap_core.c:7289
 l2cap_sock_connect+0x37a/0x770 net/bluetooth/l2cap_sock.c:255
 kernel_connect+0x107/0x160 net/socket.c:3755
 rfcomm_session_create net/bluetooth/rfcomm/core.c:808 [inline]
 __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:385 [inline]
 rfcomm_dlc_open+0x838/0xac0 net/bluetooth/rfcomm/core.c:428
 rfcomm_sock_connect+0x42c/0x690 net/bluetooth/rfcomm/sock.c:419
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
RIP: 0033:0x7fa5d1b9e199
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc664cdb68 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fa5d1e25fa0 RCX: 00007fa5d1b9e199
RDX: 000000000000000a RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007fa5d1c358e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa5d1e25fac R14: 00007fa5d1e25fa0 R15: 00007fa5d1e25fa0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
