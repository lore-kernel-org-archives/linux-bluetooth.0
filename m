Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0E3E95A7
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057684; cv=none; b=R3hZx0LJEEbuUlb6Admj5ub6KPSmq79zPmLNb444iz4Ww+HOV2+k4rQUTyOuBZdVslmASSx3kpvXGZyz9WMIDMIff4XJoM9Ok7JgInd+v+H5lgG4oUo3GZPsaZFw1atj3xYGYVW00DxMhJz/smRoCScwvqJvwpoa39Awzk2NedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057684; c=relaxed/simple;
	bh=UwffaL0in/yiM8Mg9/Q/opAMhanWsMw1fj1BsGj46HE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BHm1eHZ7IDC7sB5EMqErEpIVtW6mLlWSA7E+d/FIOm7jyd4UCfkhZAp2VDsrPy9ceLqFa4g7ExUcAfAFEQBYn6Pd+V4IzkqjDnDO+ZSXIQ3lxYWX03axZ48JyTpRxkdKFpDampP9v4NPmM4YyI1O4SlNU750w82Jo7+J0UE77mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-415e1e9aa5dso9476708fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 01:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057673; x=1778662473;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTsZVz2pV9RYVRNxQ5n6ZUP3tcm13JKdEJPcy3nEyyw=;
        b=UYZUXEzDhpryuX+GY5CSvRSSf6Kc9XeoGXenKPtLC+XK9I1+CohGezLoAMTy7Yk7JH
         8y1Gfygu7zdAVbVfGiniJbe9Q7iUiY/1bDVAQ70iu118NWzWGjXDCkxyyf3Wvw4GZZXv
         DWbyA6YsOi4ciX3Sp4wTBdMfkCVlLg9Yqrywb8Mz+NKvZ2yOSOZzBpnswoe4nmArWW4N
         7SRHOkvkpv+IhRE6ywQ/SkqTRnj4gz2nAiT4wLmeptPRgjjoZOFLVCSLTcZvk1r3+sgv
         4veUgIuinHWeIyZw+MtjOhejj3lqjmCM5jVIzzej7q6yXjSyLI6+eER9mtH0yxKsBxeE
         b3ng==
X-Gm-Message-State: AOJu0YyAxk4vYPb7XH8TZarn9Jr9O0v5mr5ALJMVEJZc8roZr5JAU+HT
	EORRoumBugHchrmJ6Mr8bwfPHCDkM/+fGeyKFkzjunA2okq5AXsRmmbFlX010psnDIoNTewiZFh
	qwE4IhrNTpq5t/M4cKgGilQeRncSC4FDONjtg5VdTflwG69h3vWo4OEErY8dAXQ==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c84:b0:694:a02f:75ad with SMTP id
 006d021491bc7-69998d721a1mr1284462eaf.59.1778057673585; Wed, 06 May 2026
 01:54:33 -0700 (PDT)
Date: Wed, 06 May 2026 01:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fb01c9.170a0220.59368.0022.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_send_conn_req
From: syzbot <syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1a5e78a55eb Merge tag 'drm-fixes-2026-05-02' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117699ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f195f6be48c12ec
dashboard link: https://syzkaller.appspot.com/bug?extid=97721dd81f792e838ba0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f1a5e78a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c76a260376ef/vmlinux-f1a5e78a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31edd841d28f/bzImage-f1a5e78a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci0
WARNING: kernel/workqueue.c:2298 at __queue_work+0xd1f/0xfc0 kernel/workqueue.c:2296, CPU#0: kworker/0:5/5309
Modules linked in:
CPU: 0 UID: 0 PID: 5309 Comm: kworker/0:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events l2cap_info_timeout
RIP: 0010:__queue_work+0xd4a/0xfc0 kernel/workqueue.c:2296
Code: 83 c5 18 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 47 54 a5 00 49 8b 75 00 49 81 c7 70 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc
RSP: 0018:ffffc9000e42f778 EFLAGS: 00010082
RAX: 1ffff1100254618a RBX: 0000000000000008 RCX: ffff88800e470000
RDX: ffff888043643970 RSI: ffffffff8a9d8360 RDI: ffffffff9033c3b0
RBP: 0000000000000020 R08: ffff888012a30c3f R09: 1ffff11002546187
R10: dffffc0000000000 R11: ffffed1002546188 R12: dffffc0000000000
R13: ffff888012a30c50 R14: ffffffff9033c3b0 R15: ffff888043643970
FS:  0000000000000000(0000) GS:ffff88808c885000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba154bda50 CR3: 0000000012441000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2432
 l2cap_send_conn_req+0x243/0x370 net/bluetooth/l2cap_core.c:1253
 l2cap_start_connection net/bluetooth/l2cap_core.c:1408 [inline]
 l2cap_conn_start+0xb2b/0xf20 net/bluetooth/l2cap_core.c:1549
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
  14:	e8 47 54 a5 00       	call   0xa55460
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
