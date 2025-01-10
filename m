Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4F20B216
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518826; cv=none; b=eii1AxZrN4AxkBXF5727QQ0yRRnyHTELJ0YMfRzEJW1uPh7GJUJYbvC+BhILOlFOhhlBJu+1iwdXKxPZITwZZ8oqqivXbJIoO8e7XUGRIqDz3WdzqLY4O74pKJ8/GxMlgSnfupf3lNxpSyC2JcB4dUOdgYXwUVHe0zTw5lwFJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518826; c=relaxed/simple;
	bh=ajQEsSb1IQq6WExVT4NevFWsgP8xb2CyUL5PsTIdGo0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RAugC0YFJzaGXyYhVnt+iKcvqc4ROUM4zyVKHDDm++vrmwOpIaVUTSeqabfF1c1eZL/nt8JNJI5BCzHzLMipBx3wT9dF3WlnXGvYlryHE/MFShwR3ayCgQJb0McGMmyKa3r7oOWX+/ZfTsdvR/Jh+DF5aMASdZtYqtsxEp3ghfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce3a416d71so29294295ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518824; x=1737123624;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiMhw/ZKXlR6UuxS/YFCk87Gnqs8hJfT1XO+CscnUc0=;
        b=bWhzT6XusYHfoKI06RXuPEwhUQpiJS6cKdQEMvIEO794c0gKYiGEd8W0COVgjQWHR/
         NSGRnJF3qz/NvPsFYxPeaH5BFNwheWnvmfGKxk9Qi5+LbFmVP5CUlkEpGoXLv1BJNqNl
         VDvugMKt6gywehr2qUXIZZazCWkfr2js8xVFR0/Ap+r0ebIvY9p2U0jgSMdH4MeIovaE
         Ufkz0fEtcUYcIWT0MpeQn6BVuaKiiTCelMK8tQ+K4JR3k/ZQuxuudLBSgEtoeG5NpUkX
         xz6cZe1OSrLgj27UOFCNy49vPyZKAB3K7fNsc6UpUiUz6kgOUDO3CyEmbyH08cAgYSe4
         smzg==
X-Forwarded-Encrypted: i=1; AJvYcCW4D86gIqts1PFTJv7gS0UKL0yamD9rnR2TNjjs0dInyS48KvEeZ0C2ugpx83HX4Ly6FgOZXB4cbAqir76MtFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYUAf+XJ8V3CGwNLascnJg8k6cVVVYSqz7bLgW/WlU9XForM1
	4Dk1vJk9ryb4AkhbfLFnKpzX3r91n/EN3eC04rAgr6r4bsCn7iKPg5ew9qSypNF0ZrOV05b2PHC
	wW4lNRF7WffLc39GJXrKSsFf2x0gZ98Xkw/pp0sFB4otUAvfZUMo/zmw=
X-Google-Smtp-Source: AGHT+IGxaM3nRgV9d+K/jc8+GWe81awMVQMekE8tw2VxOvKvq0iPOlkdWObpAID1zL6u9cfsKl3aJscCT8KDvbwpqP8Vct/EY3/u
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f8a:b0:3cc:b7e4:6264 with SMTP id
 e9e14a558f8ab-3ce3a892c05mr86224125ab.0.1736518823966; Fri, 10 Jan 2025
 06:20:23 -0800 (PST)
Date: Fri, 10 Jan 2025 06:20:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812ca7.050a0220.216c54.0013.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in hci_abort_conn
From: syzbot <syzbot+fa8378fe580fb09ae553@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aef25be35d23 hexagon: Disable constant extender optimizati..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d80cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=fa8378fe580fb09ae553
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/450e0387636e/disk-aef25be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8912f33f56fc/vmlinux-aef25be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/293fd2e7560b/bzImage-aef25be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa8378fe580fb09ae553@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 1 UID: 0 PID: 5826 Comm: kworker/u9:2 Not tainted 6.13.0-rc3-syzkaller-00044-gaef25be35d23 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: hci6 hci_conn_timeout
RIP: 0010:hci_abort_conn+0x147/0x330 net/bluetooth/hci_conn.c:3048
Code: ae 08 0d 00 00 48 89 e8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 ef e8 38 08 4d f7 48 8b 6d 00 48 83 c5 3b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 22 01 00 00 0f b6 6d 00 48 89 ef 48 c7
RSP: 0018:ffffc9000307fb78 EFLAGS: 00010212
RAX: 0000000000000007 RBX: 0000000000000001 RCX: ffff888059fd5a00
RDX: ffff888059fd5a00 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 000000000000003b R08: ffffffff8ab8d446 R09: ffffffff8aba1f98
R10: 0000000000000002 R11: ffff888059fd5a00 R12: ffff8880669b4000
R13: dffffc0000000000 R14: ffff88802f4fc000 R15: 0000000000000013
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556cac811000 CR3: 0000000060eee000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hci_abort_conn+0x147/0x330 net/bluetooth/hci_conn.c:3048
Code: ae 08 0d 00 00 48 89 e8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 ef e8 38 08 4d f7 48 8b 6d 00 48 83 c5 3b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 22 01 00 00 0f b6 6d 00 48 89 ef 48 c7
RSP: 0018:ffffc9000307fb78 EFLAGS: 00010212
RAX: 0000000000000007 RBX: 0000000000000001 RCX: ffff888059fd5a00
RDX: ffff888059fd5a00 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 000000000000003b R08: ffffffff8ab8d446 R09: ffffffff8aba1f98
R10: 0000000000000002 R11: ffff888059fd5a00 R12: ffff8880669b4000
R13: dffffc0000000000 R14: ffff88802f4fc000 R15: 0000000000000013
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2c1521 CR3: 000000005bf38000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	ae                   	scas   %es:(%rdi),%al
   1:	08 0d 00 00 48 89    	or     %cl,-0x76b80000(%rip)        # 0x89480007
   7:	e8 48 c1 e8 03       	call   0x3e8c154
   c:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  11:	74 08                	je     0x1b
  13:	48 89 ef             	mov    %rbp,%rdi
  16:	e8 38 08 4d f7       	call   0xf74d0853
  1b:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  1f:	48 83 c5 3b          	add    $0x3b,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 22 01 00 00    	jne    0x159
  37:	0f b6 6d 00          	movzbl 0x0(%rbp),%ebp
  3b:	48 89 ef             	mov    %rbp,%rdi
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


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
