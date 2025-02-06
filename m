Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E022E3EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847430; cv=none; b=cLLidfIWr+8nTSlcHgG31eIu1Z33M5k7Cr3+jpQNLHHxxE/BC4/8vYj99GgXWD+Cae9KX2SKduDLgzI38CNBf6uAN2iV7OT/FMy5rRkn0y0q63hn4PVrEAv/c2wKGcj5CWfdtuOeGi9AJp4SZBygHIYaldvHAXk6n2OCZaO37do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847430; c=relaxed/simple;
	bh=eBMLHetqsP/jaYdt5DzfXKBdbfF5F/PUkmYnexxmY/0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hT0rtl6lK01bCSZX6Hqwiwd2oxSb2JPxMvUz5SrxTqyDFTJ8Bh4CCUoinbf03ZoPKcEYxfYlIqB7tWuWsHd7rSxFJcNMOnE+cpQmfAZ/0ARfTpYO9pwCoLnRoCDcvEaOOidxJDNf1TbYA0CpvWsvOiUCIjwYKeUWBKxOuV456OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d04f44a8eeso18176905ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 05:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738847427; x=1739452227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DAalFESHwrBs+reU1TNPkfzmjuomQItpWcCJ+WU0RU=;
        b=HrVUAJDMRG8ZXf1UBKdcL3BHVA96q000+oHYcHauT0LvSGYITeZAfi0D243cym4Gb+
         cQir7pW/iLMUPIdWRhEsbitfPq7YcJqg4FCvfM55X3OEVvc1UhC5VRHRy8txMFVjqZag
         tH/hScZXmmhPTpKVvLkvuJNL5BUOaZW7kffIt5m4XL04ZExRoQXvA7P6NwI/6EBKNQH2
         UXcw2i8qjps4YJfwebjor0XAJNjQAzP5C1j1FB44Dl5zoPg/rdfZPeYh5oxzIISHV/vk
         vO1DU6vUFeNDtrGMRuS96JpNAcAQUDvIBB78nbaifNUdbWXJ/k78H8MJ0wfrze15fgHM
         gM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8uyYLQD01YpNa9DKtIPA+N6uGyefAYIIdzThQeEuLAgxl8MP2CxvveiNxF8z24itcHCdZfddWoCtZARALz4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzFKprQRyKVGjVWTYPsTScSMiDMT5jUBr2ys0FyYm1iLAh4sz
	PEa+KFhS4+mMNra6yENC24EwR4kjVa+4hmYkiAiuhaylrdcY9YL/Q/PZViY4PRlAUatk058kxrZ
	BvSBNysjkTUpf1HRkn/UdYwO9cHirTaZ/+7xPD2ZS+8f/VCFaaqg6jLk=
X-Google-Smtp-Source: AGHT+IEv6pJ7GToM/qkMH+Vo72MZvHbwEXjffygY8JUT7RYQ+1It2dq97iHnwcMDe+TxvNWCXtLu1e1/S2OrrJbpXokh5NVoyDZ6
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2490:b0:3d0:17d2:a03e with SMTP id
 e9e14a558f8ab-3d04f924625mr75488395ab.21.1738847427432; Thu, 06 Feb 2025
 05:10:27 -0800 (PST)
Date: Thu, 06 Feb 2025 05:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4b4c3.050a0220.264083.0006.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in qca_close
From: syzbot <syzbot+b9cff96f1ca33356d180@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1102a3df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=b9cff96f1ca33356d180
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177d5d18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d078a4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccdfef06f59f/disk-40b8e93e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b339eaf8dcfd/vmlinux-40b8e93e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae1a0f1c3c80/bzImage-40b8e93e.xz

The issue was bisected to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b1c4a4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15b1c4a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1c4a4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9cff96f1ca33356d180@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000158-0x000000000000015f]
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor233 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:serial_clock_vote drivers/bluetooth/hci_qca.c:301 [inline]
RIP: 0010:qca_close+0x72/0x2e0 drivers/bluetooth/hci_qca.c:723
Code: 64 af f6 f8 48 89 2c 24 42 80 7c 2d 00 00 74 08 4c 89 f7 e8 20 28 5d f9 4d 8b 26 49 8d bc 24 5a 01 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 4c 89 eb 0f 85 de 01 00 00 45 0f b6 ac 24 5a
RSP: 0018:ffffc90003cb79f0 EFLAGS: 00010206
RAX: 000000000000002b RBX: ffff888012bb2400 RCX: ffff88802e269e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000015a
RBP: 1ffff110025764b7 R08: ffffffff8187d8b3 R09: 1ffffffff2860723
R10: dffffc0000000000 R11: ffffffff88c8a130 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888012bb25b8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb3e1c10d0 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_uart_tty_close+0x205/0x290 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1690
 tty_release+0xd06/0x12c0 drivers/tty/tty_io.c:1861
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2a/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb3e145c79
Code: Unable to access opcode bytes at 0x7fbb3e145c4f.
RSP: 002b:00007ffe5ba71518 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbb3e145c79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fbb3e1c0270 R08: ffffffffffffffb8 R09: 00007ffe5ba71738
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbb3e1c0270
R13: 0000000000000000 R14: 00007fbb3e1c0cc0 R15: 00007fbb3e117a60
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:serial_clock_vote drivers/bluetooth/hci_qca.c:301 [inline]
RIP: 0010:qca_close+0x72/0x2e0 drivers/bluetooth/hci_qca.c:723
Code: 64 af f6 f8 48 89 2c 24 42 80 7c 2d 00 00 74 08 4c 89 f7 e8 20 28 5d f9 4d 8b 26 49 8d bc 24 5a 01 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 4c 89 eb 0f 85 de 01 00 00 45 0f b6 ac 24 5a
RSP: 0018:ffffc90003cb79f0 EFLAGS: 00010206
RAX: 000000000000002b RBX: ffff888012bb2400 RCX: ffff88802e269e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000015a
RBP: 1ffff110025764b7 R08: ffffffff8187d8b3 R09: 1ffffffff2860723
R10: dffffc0000000000 R11: ffffffff88c8a130 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888012bb25b8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb3e1c10d0 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	64 af                	fs scas %es:(%rdi),%eax
   2:	f6 f8                	idiv   %al
   4:	48 89 2c 24          	mov    %rbp,(%rsp)
   8:	42 80 7c 2d 00 00    	cmpb   $0x0,0x0(%rbp,%r13,1)
   e:	74 08                	je     0x18
  10:	4c 89 f7             	mov    %r14,%rdi
  13:	e8 20 28 5d f9       	call   0xf95d2838
  18:	4d 8b 26             	mov    (%r14),%r12
  1b:	49 8d bc 24 5a 01 00 	lea    0x15a(%r12),%rdi
  22:	00
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	4c 89 eb             	mov    %r13,%rbx
  34:	0f 85 de 01 00 00    	jne    0x218
  3a:	45                   	rex.RB
  3b:	0f                   	.byte 0xf
  3c:	b6 ac                	mov    $0xac,%dh
  3e:	24 5a                	and    $0x5a,%al


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
