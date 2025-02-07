Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E819C575
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959383; cv=none; b=RddBm5b9ArDsHPCtT04MBTXFWmicbawEctIyqBQxrHHRStRXq0V7HJV1jKxmUW8oPDQr7Xbh7C9n1oFsB06wHG/Z0yGGUIxB/+YI+Ugzt+jdOmk8b10LKyAywKN77fiqfQYB0i+0zud7JcpBPgKcMvnCe5Uc85qIAmFgblNSxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959383; c=relaxed/simple;
	bh=GIjvK8obr1EsIPH7YblNllgU+FxgUKI7x5puD9o3V+s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FtF6iZEDlud98z2UIch19CvmyWjlZEnEhtASW/FP5QJxT4zrvH0SLGA4mcdIELH2OeJwqpF6VHVtoyUKATdsZWTix+u6acmyPsZd6oyqQilIfDvkcZuzHkTuDzU1Zp0tpqV1pBp4NbSxVHcpXyRcViD/vXnxk9adcmyyDMCrJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d146e5d6c8so12030015ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 12:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738959381; x=1739564181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwtD7r/dnyvFQJRe81E8ceHYhoJmHqhqeFWJf+mogvI=;
        b=dL4lvQflYPW3U1UL61Iya5TTbv1uYuANTdmCzMFf4u6HaI4vBBguB0MdHfEUnBGx5Z
         TAfQAEEeHRgP5X6tYITThStqA045OCyiRea22sJTfQXV9yDeMRab0UKkt3PW7mhzSthK
         PniYSDWwdVQk93m2DuJhZQtCNL46qBQ9Q22UXxo4o9/c+UX9W2rcQz0hOt/W20LLVzkM
         QqAxBLqSK+/kYBhfD52iu767MmeCdkBQmIisKv9dkpGirQRXIMZmJaNrqO00ZOmMiod8
         F7dnJLOh2EMKhmrYpNzgn0zxM+5T0BMRyLut2DBkKvvzdSTbTEjNky6bn+Y5GeVmR/UF
         12zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc9dUNhXl5hzdZ66u25lyheBI+PIssGTf8E1p6khsAueLVZyU+SV5HVCf4mcCx7cuq06/QcMCWu5AnFhRGA98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYO9n0Wdico04G8KzAiodUu4j9RhePFKz+NfsEbEu6DPgRR8j
	xNvlMIqGYVYYe+wZelLAPe1S8I2D8f9bhXEOW7wJEMwZkji7MyUFCuT7qJSTL8RSFWxGE2nJEsz
	SPVR93TAdiKTWGR92N3t5AxsGxoXbkJkQc7wyMXUEV3Z/3zA4SQro3Lg=
X-Google-Smtp-Source: AGHT+IHnPEhdO26T5ea1Ewf1PBp2sLivTNHPXOVL7RZZxPG+E/H+qZvUb6d1pFsMHhnCdlfD76AZVF0uEZT5m04xCSnKMY7d5HqP
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3cf:b6c9:5fc9 with SMTP id
 e9e14a558f8ab-3d13deaa81dmr45812495ab.8.1738959380694; Fri, 07 Feb 2025
 12:16:20 -0800 (PST)
Date: Fri, 07 Feb 2025 12:16:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a66a14.050a0220.f64af.0005.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in __timer_delete_sync
From: syzbot <syzbot+1eaee1ec18b9d18ca3b8@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    808eb958781e Add linux-next specific files for 20250206
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106cb3df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88b25e5d30d576e4
dashboard link: https://syzkaller.appspot.com/bug?extid=1eaee1ec18b9d18ca3b8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12736df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1043a4a4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/493ef93f2e5f/disk-808eb958.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b41757cd41c9/vmlinux-808eb958.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24f456104aad/bzImage-808eb958.xz

The issue was bisected to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17aea1b0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146ea1b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=106ea1b0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1eaee1ec18b9d18ca3b8@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

RBP: 00007f95dbd414c0 R08: 00007fffc17488e7 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f95dbd415b0
R13: 00007fffc1748b60 R14: 00007f95dbd448e1 R15: 00007f95dbd41518
 </TASK>
Bluetooth: Can't allocate HCI device
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000067: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000338-0x000000000000033f]
CPU: 1 UID: 0 PID: 5832 Comm: syz-executor371 Not tainted 6.14.0-rc1-next-20250206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b ef 80 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 18 6e 8b 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003e2f6d0 EFLAGS: 00010002
RAX: 0000000000000067 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000338
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203744f R12: ffff88807b490000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000338
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95dbd12930 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1644
 del_timer_sync include/linux/timer.h:185 [inline]
 h5_close+0x4b/0x170 drivers/bluetooth/hci_h5.c:257
 hci_uart_tty_close+0x205/0x290 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1690
 tty_release+0xd06/0x12c0 drivers/tty/tty_io.c:1861
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2a/0x2860 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95dbcfdb69
Code: Unable to access opcode bytes at 0x7f95dbcfdb3f.
RSP: 002b:00007fffc1748ae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f95dbcfdb69
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f95dbd72370 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f95dbd72370
R13: 0000000000000000 R14: 00007f95dbd72dc0 R15: 00007f95dbcc7480
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b ef 80 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 18 6e 8b 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003e2f6d0 EFLAGS: 00010002
RAX: 0000000000000067 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000338
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203744f R12: ffff88807b490000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000338
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95dbd12930 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 f8 16 	xor    %al,0x16f8850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d 2b ef 80 0e 00 	cmpl   $0x0,0xe80ef2b(%rip)        # 0xe80ef40
  15:	0f 84 c8 13 00 00    	je     0x13e3
  1b:	89 54 24 60          	mov    %edx,0x60(%rsp)
  1f:	89 5c 24 38          	mov    %ebx,0x38(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 18 6e 8b 00       	call   0x8b6e50
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
