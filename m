Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B86391E59
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056577; cv=none; b=fyXfhfcHLCvPLWaWfWAyf3j3pME3Zj6oAy+9Y/rdmGsQRagWwhPZsaA6nx/Dg2q5INJDjQrCjecD4TYNhmhuvcQkAA3BHMbfl+ILSzwZ9DhHTrvC2yAYfkJ61GLbD7cJ1fTjvg1zUoK+bWMZnr2fzru6nTu/0PLIBC1wEy0rq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056577; c=relaxed/simple;
	bh=2e3L0H683hDjd0GrUF5XICElxaBuw5v4BC2yDef3aXE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lROj8xiIZ3dqTeRF0xdSYk312sPORBcMDUFnYiqmeLY7glAOS0CKStn1MZ/DzFEGZ/Bted97NhQqYEk3nfyICjiEakJMgrMMYAUVuGKI+xsubTOp/gh3ZtFi/VzW8IFKxnVyOsLqV78UH+3DE18Cj+CAqMcr4GTIJWG/B30Hcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4b388697b03so962882b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 09:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056574; x=1789661374;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H71bxvxYKoFv59ri60MFSnW6MrPgym86hxTl65YUMdQ=;
        b=A+TmpAQ7TO6e5MhPfbA+cpxnUFiCyTL2uXlyANUiFErWZOwBLlcgFCLm3QjYiciVw7
         ReCPgr7M/36loegz0UmLt5isj01zsO3NCembGCyv1EszvzG9IdY31tZwaWP5gIW9bmqi
         86i5LJ7wr6/b2evJ+zn7Y6IC5OZURWr1U9lJfoHY+OCPWe+cy3nYDLeLB6wYdAp1YFas
         CzfvyLJWC7ZgGVxI1Affvk6oOiP1wFxRg1aw9z+oUJlEoPvbihNHN7m/8/VlIy0Q0XWk
         9yanVG4VJFUYyWbxQY8UIzQHc0Qy/+yaNCjli5bVOOrFZzMmv4qhPaXl6l2RHWk4FP/+
         hUqA==
X-Gm-Message-State: AFuF++kMyhIrqhSwo3somOymk5ccuCxxvBx/lVp9tP3LUWv7WlTbciLm
	Lh0Ro+S6HaYxesOsriwufwmRNSyN63VnfeC85k5oRCUm6QWPNDJ8MHJtPKcHCMsqeQ3kCirOVGD
	p3nohUEgHVHV6KGOdxMadsmTH6/OCTAFhNEMq52+bw6EnAv+DOepdNwRx/FmI2g==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6807:b0:4b9:e5fa:8a1d with SMTP id
 5614622812f47-4b9e5fa8f23mr25474168b6e.34.1789056574511; Thu, 10 Sep 2026
 09:09:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:09:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa2d63e.6e6c5f9e.28f11f.0036.GAE@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_close
From: syzbot <syzbot+0cece8fa7d83523f47a3@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad0905580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=0cece8fa7d83523f47a3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ad0905580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12752c8e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f77d29903f3/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23b2961d9c5d/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cece8fa7d83523f47a3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.67/5982 is trying to acquire lock:
ffffffff90f80f40 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_close+0x33/0x240 net/bluetooth/rfcomm/core.c:508

but task is already holding lock:
ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sock_close net/bluetooth/rfcomm/sock.c:245 [inline]
ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sock_cleanup_listen net/bluetooth/rfcomm/sock.c:190 [inline]
ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: __rfcomm_sock_close+0x1c3/0x300 net/bluetooth/rfcomm/sock.c:224

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3830
       lock_sock include/net/sock.h:1713 [inline]
       rfcomm_connect_ind+0x327/0x9e0 net/bluetooth/rfcomm/sock.c:968
       rfcomm_recv_pn net/bluetooth/rfcomm/core.c:1509 [inline]
       rfcomm_recv_mcc net/bluetooth/rfcomm/core.c:1727 [inline]
       rfcomm_recv_frame net/bluetooth/rfcomm/core.c:1868 [inline]
       rfcomm_process_rx net/bluetooth/rfcomm/core.c:2020 [inline]
       rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2114 [inline]
       rfcomm_run+0x438b/0x54c0 net/bluetooth/rfcomm/core.c:2204
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (rfcomm_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       rfcomm_dlc_close+0x33/0x240 net/bluetooth/rfcomm/core.c:508
       __rfcomm_sock_close+0x181/0x300 net/bluetooth/rfcomm/sock.c:231
       rfcomm_sock_close net/bluetooth/rfcomm/sock.c:246 [inline]
       rfcomm_sock_cleanup_listen net/bluetooth/rfcomm/sock.c:190 [inline]
       __rfcomm_sock_close+0x1d2/0x300 net/bluetooth/rfcomm/sock.c:224
       rfcomm_sock_shutdown+0x111/0x250 net/bluetooth/rfcomm/sock.c:920
       rfcomm_sock_release+0x61/0x1a0 net/bluetooth/rfcomm/sock.c:941
       __sock_release+0xb3/0x260 net/socket.c:735
       sock_close+0x1c/0x30 net/socket.c:1526
       __fput+0x3ff/0xb50 fs/file_table.c:512
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
       exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
       do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
                               lock(rfcomm_mutex);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
  lock(rfcomm_mutex);

 *** DEADLOCK ***

locks held by syz.0.67/5982: 2, last CPU#0:
 #0: ffff88805501bbc0 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #0: ffff88805501bbc0 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x86/0x260 net/socket.c:734
 #1: ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #1: ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sock_close net/bluetooth/rfcomm/sock.c:245 [inline]
 #1: ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sock_cleanup_listen net/bluetooth/rfcomm/sock.c:190 [inline]
 #1: ffff8880234b9260 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: __rfcomm_sock_close+0x1c3/0x300 net/bluetooth/rfcomm/sock.c:224

stack backtrace:
CPU: 0 UID: 0 PID: 5982 Comm: syz.0.67 Not tainted syzkaller #0 PREEMPT(full) 
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
 rfcomm_dlc_close+0x33/0x240 net/bluetooth/rfcomm/core.c:508
 __rfcomm_sock_close+0x181/0x300 net/bluetooth/rfcomm/sock.c:231
 rfcomm_sock_close net/bluetooth/rfcomm/sock.c:246 [inline]
 rfcomm_sock_cleanup_listen net/bluetooth/rfcomm/sock.c:190 [inline]
 __rfcomm_sock_close+0x1d2/0x300 net/bluetooth/rfcomm/sock.c:224
 rfcomm_sock_shutdown+0x111/0x250 net/bluetooth/rfcomm/sock.c:920
 rfcomm_sock_release+0x61/0x1a0 net/bluetooth/rfcomm/sock.c:941
 __sock_release+0xb3/0x260 net/socket.c:735
 sock_close+0x1c/0x30 net/socket.c:1526
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd18819e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0b172838 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffe0b172920 RCX: 00007fd18819e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000000e138 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b32a20000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd188425fac R14: 00007fd188425fa8 R15: 00007fd188425fa0
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
