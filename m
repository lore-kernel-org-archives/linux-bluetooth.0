Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B3F9D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069208; cv=none; b=Yh/BqlINa/2gNVnkKmZGVZz82Pdo2kY3ljnvPblffI4k/GX/VUGOxapal10kIOK8ww4cVAel/bzTtKjqSb+PSsw/y/E7dV7L6b1vprl9ABajpIdARpB3r9Ny3KiwpdWhEsyAqVEVUCmBE1ZAZvYYg/Yt93OxseAiSyw7l4GVWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069208; c=relaxed/simple;
	bh=VP4JUAwJefTJfM9r5M6cdNzlV8QuuFPk98gofKrzK0Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d6ZOn5NUqVVoWZt8ykAKDMLjStj/Fp/OGJZcxnCpTjTFIFfbFdaPxZmJPgEZtl381tHUdTnTUMDXX/ndR8BjGV9GF87h+sYRDJ5iEcWHGiG52gZwFXaWCQKRVfq+d4Tkv00rgZgDXhFiQ8oUjU4GFKgXvrPazI4dstYfuvLNbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso21168695ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069205; x=1740674005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KplVHQ9ANKONXhap56K0RGH2ulhxcqZv4C2WriTI4CI=;
        b=CVJK8CD1V4YX1VwBTpM8rYeU9Rs4s/7jxPh85qoNOsIKefBqwZOaFHjOEcM6F3egsR
         xFxqoWQOikPlN5rUSYm1LYzT8YUIczlqD96P7Feyq9m2BBo3E9gdzclE57VvDu26qp+C
         s/Rcgo5g1JylujCCFZXaKy8jzGVlyXUXk0NKAT9UJXsBG1VbZEXhfaZj37GTGdqMY+RV
         2M19nJv7ruqPScpSqvEICS/i+4LGAJ/LKYNLIpN1Wg9TfzOHPsHV/sxT4Y++AxEIf4gL
         VBjnfpt0aSkjgZPCwHy+h9bzjMshx05SxBLz87mQO8ArL8LtCLMO6JWQfwWh+YoKb50r
         4ThA==
X-Gm-Message-State: AOJu0YwGjzNXjn9XeB40XSUv5oyHonfW3pRr7WC4Q0Et1aEixbY2Pq52
	lPCKEsv93pmhSBbBn2xgUbRqCMu2JHP4vNVVN6sGUI7Scw+fEAWuD5GL7cbHGuxOpBUWggjMYhj
	GwisJgUwbNHdKNcZ3aWUSlKZXiGwJUETEkWvg+GFDCHWBV8xnsH3EdbSBGQ==
X-Google-Smtp-Source: AGHT+IENzconClywrTBBzfZpCIqcXEU0ZCKkvOr528yBUsVHrOFSe34rQoIoMP/6Vk8yZI82RVe1iJa38pyWEb3l2/73OpfB2Gf4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3d28093b8a7mr249533905ab.21.1740069205383; Thu, 20 Feb 2025
 08:33:25 -0800 (PST)
Date: Thu, 20 Feb 2025 08:33:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b75955.050a0220.14d86d.02e5.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in h5_close
From: syzbot <syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147adae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=ce27f6f75880d7fe265c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f2ba4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123375b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00007ffe25b998c7 R09: 00007fba95c371a8
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe25b99b4c
R13: 00007ffe25b99b90 R14: 00007ffe25b99b70 R15: 0000000000000009
 </TASK>
Bluetooth: Can't allocate HCI device
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000067: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000338-0x000000000000033f]
CPU: 1 UID: 0 PID: 5846 Comm: syz-executor747 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b c3 a0 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 58 6c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003f9f6d0 EFLAGS: 00010002
RAX: 0000000000000067 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000338
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffff888032a68000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000338
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba95cee1d0 CR3: 000000000e938000 CR4: 00000000003526f0
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
 do_exit+0xa2a/0x28e0 kernel/exit.c:952
 do_group_exit+0x207/0x2c0 kernel/exit.c:1101
 __do_sys_exit_group kernel/exit.c:1112 [inline]
 __se_sys_exit_group kernel/exit.c:1110 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1110
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba95c79b79
Code: Unable to access opcode bytes at 0x7fba95c79b4f.
RSP: 002b:00007ffe25b99ac8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fba95c79b79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fba95ced370 R08: ffffffffffffffb8 R09: 00007fba95c371a8
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fba95ced370
R13: 0000000000000000 R14: 00007fba95ceddc0 R15: 00007fba95c43240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5091
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d 2b c3 a0 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 58 6c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003f9f6d0 EFLAGS: 00010002
RAX: 0000000000000067 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000338
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffff888032a68000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000338
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba95cee1d0 CR3: 000000000e938000 CR4: 00000000003526f0
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
