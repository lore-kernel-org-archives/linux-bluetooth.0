Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0B1FFC6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067228; cv=none; b=gS/Y0zMgGEMgrWPlcvfdmxOzMtMZ7c+/2kq4SVzaKqTTrHaVf6WGmyb8jQrVapIEEPuA1kFVC+hLjAtLMhoTWHepSCt0kNOljhsfei2nGNqof30bqDVqAqUXHp7CAFUOEA+8ee/viRUVOdDyovFGPnXoYH8MCFbxSIvd9dAcQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067228; c=relaxed/simple;
	bh=y2wgqN2EQtbjwMghktJw/Hblzfl4roeAfvRNSQsRFLE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=prf8hrstGh/9cK5t2XYC7nifzbx56dyLdNV2Spl7HcjF8gQ2HvMHEv/2htqRbCnr+6Gk1zRZ7/m3eQU+DgQ+jnBEkxP6tw67RQOxpKG39UvFMsGSTtuWjqD3gIyUM5KWsGvKyysuARx9fkqChtalYlILRWn6ymVuT46JsfHkhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d289bf6c39so15337795ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067225; x=1740672025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgFU6+keah3Z2bSV+dndazCrABzgsNUNjH418O2bSns=;
        b=OC2Fe/8QYh7luMenjgu1rMMvGY4XiVp6jOO4F73LYbpVfbsL/xIcVIYIgwUNgCKTvT
         6idRsb7Wwcmg+t7Q9iLDi2hyzuNOUirDUygYfmctW1r9YbtMIwU7QrT8Rnofznu7kwqx
         9SDOvNkaA8BJQ8734zgM272Ev2tqy0Rdr2+KCm+pOOyqootVW+gCrzfe7BVfY32Fju4m
         QwWYW4u9w4yYnhbmPw1946k9TjZvbKREkHPf2UcOp/lTNio/ayYgFNPx/dr6tKG0M1XC
         z/4njMT9+EoxhVIkfyqLPe7ojuQVkmpZcZACjbAyVMYIkxkGSxN3rZ+lFjDSkCJKlnid
         YxoA==
X-Forwarded-Encrypted: i=1; AJvYcCURoiqV0Nuh+Sm+SUElHQwSFIYlddsw4luvX15AeN7v3kgZ1c/X91yf1p0+ssHMSiqSoMbM5Rj8P5eCRE3X6w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8933EEpA/yUi8O0ySh2l+tF9RN5Ol15U3ajzDYVSs9IzrXYAn
	Z5Yl/Z4kQurVL136cZSq/QCtDchNJwl+uwp819VlBQB2lL8oBADFgONqa+OTkSs3htD5WdYxo25
	1ML/uTNVHJ2sNButMEsgqRDjkWhWtCzbwxandUBRmGH2Hv/qmZZ+Zf10=
X-Google-Smtp-Source: AGHT+IE/hrTD8EaxhVHVheEeiH+H7qVRVRfx45rLjU/ZFsYs9uoOMt4zNIcOFZMTtgcuSZOTwS5J6KPSU/HvxVsQpy6tKqaHuGr4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:3d0:353a:c97e with SMTP id
 e9e14a558f8ab-3d2c01ef408mr36782045ab.10.1740067224574; Thu, 20 Feb 2025
 08:00:24 -0800 (PST)
Date: Thu, 20 Feb 2025 08:00:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b75198.050a0220.14d86d.02e3.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in bcsp_close
From: syzbot <syzbot+9c957444e37d521b3b94@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152ae5b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=9c957444e37d521b3b94
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b0a498580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178577df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

The issue was bisected to:

commit 3ca66179e56d25f1e3ed1608241abb487c63e9b7
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164e1498580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=154e1498580000
console output: https://syzkaller.appspot.com/x/log.txt?x=114e1498580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c957444e37d521b3b94@syzkaller.appspotmail.com
Fixes: 3ca66179e56d ("Bluetooth: hci_uart: fix race during initialization")

RBP: 0000000000000001 R08: 00007ffc19740607 R09: 00007f7d8d9301a8
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffc1974088c
R13: 00007ffc197408d0 R14: 00007ffc197408b0 R15: 0000000000000006
 </TASK>
Bluetooth: Can't allocate HCI device
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000029: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
CPU: 1 UID: 0 PID: 5841 Comm: syz-executor246 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b c3 a0 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 58 6c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003e2f6d0 EFLAGS: 00010002
RAX: 0000000000000029 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000148
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffff88803482da00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000148
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7d8d9ca243 CR3: 000000000e938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1644
 bcsp_close+0x4c/0x130 drivers/bluetooth/hci_bcsp.c:740
 hci_uart_tty_close+0x205/0x290 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1690
 tty_release+0xd06/0x12c0 drivers/tty/tty_io.c:1861
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2a/0x28e0 kernel/exit.c:952
 do_group_exit+0x207/0x2c0 kernel/exit.c:1101
 __do_sys_exit_group kernel/exit.c:1112 [inline]
 __se_sys_exit_group kernel/exit.c:1110 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1110
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d8d972b79
Code: Unable to access opcode bytes at 0x7f7d8d972b4f.
RSP: 002b:00007ffc19740808 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7d8d972b79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f7d8d9e6350 R08: ffffffffffffffb8 R09: 00007f7d8d9301a8
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f7d8d9e6350
R13: 0000000000000000 R14: 00007f7d8d9e6da0 R15: 00007f7d8d93c220
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b c3 a0 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 58 6c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003e2f6d0 EFLAGS: 00010002
RAX: 0000000000000029 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000148
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffff88803482da00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000148
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7d8d9ca243 CR3: 000000000e938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 f8 16 	xor    %al,0x16f8850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d 2b c3 a0 0e 00 	cmpl   $0x0,0xea0c32b(%rip)        # 0xea0c340
  15:	0f 84 c8 13 00 00    	je     0x13e3
  1b:	89 54 24 60          	mov    %edx,0x60(%rsp)
  1f:	89 5c 24 38          	mov    %ebx,0x38(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 58 6c 8c 00       	call   0x8c6c90
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
