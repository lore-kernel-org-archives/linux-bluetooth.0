Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44990320CAD
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281671; cv=none; b=d+hEPI97ccDunm6wt+3kdj/dRaaYAPJN04FO5tOfksZUuWbDSZpKVqokAX0bIbwoFgvc5xfzAnPe3zKRyroYgrjN2mTrKb68Knlkha8eMgIZjbJ0MdOqz0no9EMaLqmN6hYQRH/pPLnlqMcdJCDdJPBzSqDADi5R5YUvMbTF3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281671; c=relaxed/simple;
	bh=iBiLAC4oK/v6IvNt12XprCZuSZo8vQ/vzCm0xpABvxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=czH1WFtOhImceNo1/AYi/yREAELqgJhKSF9ATLzNtWtE/zjkgWroKJmbThT95iq6yPvw/9geZPMf+HpuFijZaYnpiFiF5zzwghmoiuKErnXscoeN/l8ma1tgEMYKGVdrbf/7WiC6Hf3ECCWQKqzpQnuZogXdjlm/JpEBqFf0FjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d74ab502b0so3924639a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 19:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773281669; x=1773886469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yUdTLorfMfl6e+pVf9RnpCNvkB22mXGi6n1wgyWYyE=;
        b=L7Iy0UW9s+QW44ASCgczfs6XDUO+EU3JmRIwp7qnYWvsVUjTPwFQshnxdvwTAfkSOf
         FayGUSWqWLhJxM/lmo0IUVmIsBvd9XyCSnL5uaQX6AwO/al5nc8RrnnLUVJBgynl/5mQ
         XX2TcwvY6eCh6wd+qjvGW9TmN7wUSqG+dCMI244p5WWudwRRxFnMqpVnLtsHL8CI/K0w
         KPRHuj55365YUKaAqpDCh/mbQ4y171xeMYJZR+04Z3sXff+Q6EImSHP25yLpCuVdWOIF
         dL4Jl/brR01F0dC3vhLmeVMgm/2zyw/tDV3avL9tY0VNfjmVaLP2DPvoX7ZfNXUXQYu6
         i6yA==
X-Gm-Message-State: AOJu0YxGKRwLyyM6ofhm2G542jVlKjM+TqRMjNKaUdwouaa6riOX0uub
	Xk9Jjcwr1+oE+cVzQ1E/bNpSSlgLK7bxnO2Cc/uhJGy6TRa1a4Fl00w5oTtlbZqKCm38U8tEbay
	dIIIsVFSlv7Ndg3cAHIB+C9lflT5FLdwNmEJbMZwavFXhZwAH3AJj1jFNo7k=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7083:10b0:67b:c8c4:43bd with SMTP id
 006d021491bc7-67bc8c44adamr2049838eaf.72.1773281669297; Wed, 11 Mar 2026
 19:14:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:14:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b22185.a00a0220.707e5.000c.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_conn_start
From: syzbot <syzbot+5a3ffe8f0bd0f1dead8e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b29fb8829bff Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12289806580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=5a3ffe8f0bd0f1dead8e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b29fb882.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fd392c86ab5/vmlinux-b29fb882.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32f95fb6f35f/bzImage-b29fb882.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a3ffe8f0bd0f1dead8e@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci0
WARNING: kernel/workqueue.c:2271 at __queue_work+0xd53/0x1020 kernel/workqueue.c:2269, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events l2cap_info_timeout
RIP: 0010:__queue_work+0xd7e/0x1020 kernel/workqueue.c:2269
Code: 83 c5 18 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 83 14 a4 00 49 8b 75 00 49 81 c7 78 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc
RSP: 0018:ffffc9000023f838 EFLAGS: 00010086
RAX: 1ffff1100244618d RBX: 0000000000000008 RCX: ffff88801b78a4c0
RDX: ffff888012691178 RSI: ffffffff8aa0db00 RDI: ffffffff9014a6c0
RBP: 0000000000000020 R08: ffff888012230c57 R09: 1ffff1100244618a
R10: dffffc0000000000 R11: ffffed100244618b R12: dffffc0000000000
R13: ffff888012230c68 R14: ffffffff9014a6c0 R15: ffff888012691178
FS:  0000000000000000(0000) GS:ffff88808ca58000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd708e5e80 CR3: 00000000420ff000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 l2cap_send_conn_req net/bluetooth/l2cap_core.c:1230 [inline]
 l2cap_start_connection net/bluetooth/l2cap_core.c:1385 [inline]
 l2cap_conn_start+0xc6a/0xff0 net/bluetooth/l2cap_core.c:1526
 l2cap_info_timeout+0x68/0xa0 net/bluetooth/l2cap_core.c:1662
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 c5 18             	add    $0x18,%ebp
   3:	4c 89 e8             	mov    %r13,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   f:	74 08                	je     0x19
  11:	4c 89 ef             	mov    %r13,%rdi
  14:	e8 83 14 a4 00       	call   0xa4149c
  19:	49 8b 75 00          	mov    0x0(%r13),%rsi
  1d:	49 81 c7 78 01 00 00 	add    $0x178,%r15
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 58          	add    $0x58,%rsp
  33:	5b                   	pop    %rbx
  34:	41 5c                	pop    %r12
  36:	41 5d                	pop    %r13
  38:	41 5e                	pop    %r14
  3a:	41 5f                	pop    %r15
  3c:	5d                   	pop    %rbp
  3d:	c3                   	ret
  3e:	cc                   	int3
  3f:	cc                   	int3


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
