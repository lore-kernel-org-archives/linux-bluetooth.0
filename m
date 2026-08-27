Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1140099C
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856762; cv=none; b=TJAg/iiqWPKMOE3vD8jyQQxJHrTbFBtxHczqOFrcq2S1245hcZMkB0qzz4pV2gjVSGNM7giDijqB0fUjef5XMb82dKDJcmv07lYHToFt8C24algeuZWN4E9oXgzihXg8E9tYmMolNxpLbq7D8Tp5gS430hMOQPm7tIX3nNE4cVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856762; c=relaxed/simple;
	bh=hncabP7aPdHnuobTgSgk9fapXLnpLfx/uBL89CqOutI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FiJaEpHsFZUdgbH7cnEr0TgocKWCXiR+ZJpgyBMe9t57yrY5dBGoOVO8JB6YPc3TdkoJbJior2ZFKNmGCynYak5FZSNA2VmGNt7oLM2PaUfglLPDW2Y58Fn/huUoShcWaeXQme+PlfH+SLlrLrJxae90yqpZPKLedYgL0G3qxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso134440b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 11:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856760; x=1788461560;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1iWycX4pkHURg1o4GzvWHnwxlT8370uqudXNgMPEzI=;
        b=MH6KN7XixyAUgCIG0HRr8ge5+zQtOw4hs/rFrUA1Uon9HlVZQQXG5ksUkRlCvByFK6
         1oTgdtKXRgNJzjoXvbbiGkrMTAUmRGshe53U475sQsgq9WM51QcgLtCZ+Sr9B3k5tGVB
         jZAjm9Rl9Ig8HQa1fCy4QhvA2pA8+DhEZ3m5rA0Y89lumsiqHH6vkqWOkGjOaHZdLjTH
         N5pyTU91GUNKEqBT5RYfSaR1CdYzSMkaBe/IjJ1LhDmvcvYc0EiUhD0gFr1GXk326yd0
         1C67ftoJGbugN9DWv0Uz1YzpJgOXUG+visGhY4YiOaTaMfQUdYbOZqHclb1y6lAh2Qcl
         2EWg==
X-Gm-Message-State: AFuF++lmzRQeFVPbGtvziJ2QMeIJ0HkeTlO63OzAN/IfH1/pbPXSnXfA
	JJH7tEi6+SnB+lRB0H/fgJyrzuaAX82Cr6ehvLOIjiykp2VKPQuMgucf0XiLurtAG//AG95hSY4
	hOC9Har6J34eNZxUzJBnIIkNffVNu4AYRQJU4PTI7eWUbnru9ruhlH7b53Pavlw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1918:b0:4b3:8ae8:7a47 with SMTP id
 5614622812f47-4b398340b93mr1111506b6e.16.1787856760208; Thu, 27 Aug 2026
 11:52:40 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:52:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a908778.1d9ded08.62e62.00db.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in msft_do_close (2)
From: syzbot <syzbot+14ce1b05b7d5a989abbe@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bde979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=14ce1b05b7d5a989abbe
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111a3979580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f88579580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e4100526b12/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/723c4783ee96/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14ce1b05b7d5a989abbe@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#1: kworker/u34:2/5890
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x944/0x1bc0 kernel/locking/mutex.c:821, CPU#1: kworker/u34:2/5890
Modules linked in:
CPU: 1 UID: 0 PID: 5890 Comm: kworker/u34:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: hci0 hci_power_on
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x94b/0x1bc0 kernel/locking/mutex.c:821
Code: 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 b4 10 00 00 44 8b 05 d8 d5 7a 05 45 85 c0 75 13 48 8d 3d ac da 7d 05 48 c7 c6 a0 d2 ef 8b <67> 48 0f b9 3a 90 e9 1b f8 ff ff 4d 8d a7 f0 0a 00 00 4c 89 e7 e8
RSP: 0018:ffffc90002937890 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff88803c0a4440 RCX: 1ffffffff2287150
RDX: 0000000000000000 RSI: ffffffff8befd2a0 RDI: ffffffff91468f60
RBP: ffffc90002937a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000075eb R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888056a15980
FS:  0000000000000000(0000) GS:ffff8880d5ca2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8ddaddcff8 CR3: 000000002b956000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 msft_do_close+0x32e/0x6a0 net/bluetooth/msft.c:698
 hci_dev_close_sync+0x1020/0x13c0 net/bluetooth/hci_sync.c:5596
 hci_dev_do_close+0x2e/0xb0 net/bluetooth/hci_core.c:502
 hci_power_on+0x1be/0x630 net/bluetooth/hci_core.c:940
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	38 d0                	cmp    %dl,%al
   6:	7c 08                	jl     0x10
   8:	84 d2                	test   %dl,%dl
   a:	0f 85 b4 10 00 00    	jne    0x10c4
  10:	44 8b 05 d8 d5 7a 05 	mov    0x57ad5d8(%rip),%r8d        # 0x57ad5ef
  17:	45 85 c0             	test   %r8d,%r8d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d ac da 7d 05 	lea    0x57ddaac(%rip),%rdi        # 0x57ddacf
  23:	48 c7 c6 a0 d2 ef 8b 	mov    $0xffffffff8befd2a0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1b f8 ff ff       	jmp    0xfffff850
  35:	4d 8d a7 f0 0a 00 00 	lea    0xaf0(%r15),%r12
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8


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
