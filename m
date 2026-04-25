Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D82F0680
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158446; cv=none; b=TGuDBCM77ZwGeQGvhQSrPTMlfAcoaGF1rHfYEo/LfNdRDCMu+bTjdKflxl+CiQkEX8duqE63z3KEZFD7hLOmlC+Fh2zhM6aS9prAZlUIK+aZfwA9Vj74LskPfQCylnx3jPjF6UJL/8AVKndZgJ0wEIMOybY2gX/kM6FVCHncUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158446; c=relaxed/simple;
	bh=NihHdFvjEKHD1k1Qq10Pf5w4TrwxQWx5oHmrMylywko=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=obvkJ7KjIhsc/lKgTxUVB8RwWYfftuF9xuQwHY6yXAAFQmIAOz0UQKbQ6kadUbfpYg4Ebb8VISdlW3BM1M1qX2+E6H/isviUKbVY91bVZ+QFLB/JWoUQwtpj1RfS7PbZfUCH5aSb8lh2B8NyyDR2bapW8sjA+1bCK0cZ02c8FVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6961bda4505so3295427eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 16:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777158444; x=1777763244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtQkIP8h6UGR3WAAAFlNk4hi2ZVDq2Utyswte4x7nlY=;
        b=Fzf/lox55/RImzJCXwEtqctnAUokaQu4Vj371dzFPn8tgmcBoeQHQecHh9C3f7Zm3K
         63rWLBm+wdET/KQADJrOBwnGelHZjrTLJ0V5baCZQEIZVx4EAA98ugZ16H3xwi7GqbGr
         Pm2hRRIu9uYu1OyJwqWyfuRhjtAbuOGp/CmN13Tm9grs3vrNpcuZ1XlaRPDgzaS1AoCY
         PzPAvJ7AFlkIJKydPSbuO9t5mGKiBYDpc91bjH+BGSoQC3LoD7gO/+FpxfuNCsWBPFcG
         m5ZxHBhMMDfTe6KrWJ+/QUlL4GXVbuKhlDMHGb56PMlUUi+nncdWXtlY7403ZplIJoVZ
         aUSQ==
X-Gm-Message-State: AOJu0Yyhcn0/warpASpq8XqWB5sta0QUcxtgLJyYEzt8BgCua7MYSxnf
	ULLQu+THfDBUJIiZlvIIkC8pbD45ULzUETmuOe5LX2xfaATC/QG83G6+e7wSThwe6nqfVoDgaMh
	rjpYFJBvwsWTIvxu7IsQPhy78GNRSPU1MMXaOcZLMUAzhbr4VLhNdBY5s/I3fcA==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f023:b0:696:2cb1:a008 with SMTP id
 006d021491bc7-6962cb1b44bmr3867723eaf.53.1777158444553; Sat, 25 Apr 2026
 16:07:24 -0700 (PDT)
Date: Sat, 25 Apr 2026 16:07:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ed492c.050a0220.e51af.0005.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_cmd (4)
From: syzbot <syzbot+00f5a866124dc44cce14@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4e07588e743 tracing: tell git to ignore the generated 'un..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1768ac36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f17ac3d4b47ac43a
dashboard link: https://syzkaller.appspot.com/bug?extid=00f5a866124dc44cce14
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b4e07588.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3832abcd2f7/vmlinux-b4e07588.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b5d6e6e9cbd/bzImage-b4e07588.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00f5a866124dc44cce14@syzkaller.appspotmail.com

workqueue: cannot queue hci_cmd_work on wq hci0
WARNING: kernel/workqueue.c:2298 at __queue_work+0xd1f/0xfc0 kernel/workqueue.c:2296, CPU#0: kworker/0:3/1378
Modules linked in:
CPU: 0 UID: 0 PID: 1378 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events l2cap_info_timeout
RIP: 0010:__queue_work+0xd4a/0xfc0 kernel/workqueue.c:2296
Code: 83 c5 18 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 17 4d a5 00 49 8b 75 00 49 81 c7 70 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc
RSP: 0018:ffffc9000257f720 EFLAGS: 00010082
RAX: 1ffff110081cc181 RBX: 0000000000000008 RCX: ffff888000260000
RDX: ffff888040182170 RSI: ffffffff8aa9ccd0 RDI: ffffffff90368d70
RBP: 0000000000000020 R08: ffff888040e60bf7 R09: 1ffff110081cc17e
R10: dffffc0000000000 R11: ffffed10081cc17f R12: dffffc0000000000
R13: ffff888040e60c08 R14: ffffffff90368d70 R15: ffff888040182170
FS:  0000000000000000(0000) GS:ffff88808c80c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000005dc0 CR3: 0000000012a31000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2432
 queue_work include/linux/workqueue.h:696 [inline]
 hci_send_cmd+0xb7/0x1a0 net/bluetooth/hci_core.c:3111
 hci_conn_auth net/bluetooth/hci_conn.c:2459 [inline]
 hci_conn_security+0x599/0xa80 net/bluetooth/hci_conn.c:2551
 l2cap_conn_start+0x3bc/0xf20 net/bluetooth/l2cap_core.c:1534
 l2cap_info_timeout+0x68/0xa0 net/bluetooth/l2cap_core.c:1685
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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
  14:	e8 17 4d a5 00       	call   0xa54d30
  19:	49 8b 75 00          	mov    0x0(%r13),%rsi
  1d:	49 81 c7 70 01 00 00 	add    $0x170,%r15
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
