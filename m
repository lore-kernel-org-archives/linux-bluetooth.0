Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C42E62CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628937; cv=none; b=loTMvqU3FqeuW7z6ArrjmgcFBnOPBS0SUgrMacn8ylHeauwDQkBMtCOvYy2vguj3E4sbuloZgNm8nQibYsSjekndDG++Dve0BJNkfGTtodlMbnI6CNId6D1ZnJojp/NwjLkGYLTkCjGjeckEDQ/djh9uZmMPr7BrTfh7CV6fO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628937; c=relaxed/simple;
	bh=1gGIuJtRyKRsycME9bjSRrbil0usjgs36aHxiXzm0RU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AMDMmdlx0TUY9ubMl4jjqUhllTMs1YEqvb0wcS8tOdfL1xm78IsM4jO7aqWtbRAGycUhuirB/ZHGl56Dvs4/kl2UzrvTnjtqRdFVHY6Zq3lWA6FKIJw0ctsKkojChhxLklViC9gj+FkjVVD6pBysXKkN7nG3y/atOCk8UQBOjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f8824b65fso24697725ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 08:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628935; x=1761233735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHuQVk8Kqi5ZrSYbC6H1u1h4LVBxc0HEQR6WAKWX1cg=;
        b=TVyWeqPhK4N74iuhlKwjebKlWkJddP4xsoH1wdXVqJrYItvEdrAUo0ghFE3itNM9fR
         48n8kjTKmV3omtfxTGZ6VKsNG8LFmdBON9yQxBMX3g/TnPeFouIqcoB/c9GUO0Hkx4jz
         tufM3hWh4yNpHOba6jd+Ghi13x4mWuoEeORRxcykHav9UeGCaOq/sb3vJsQt6LghSvLf
         yJAwM8j8WY9lG4Jr9XklsHKnoTZLa9WBHr9kON7vIIg1p4gVTXyZfNXqfXYM4HGD8dmp
         syz5xedRnqTNKMQ5EOcrRWh5CpqERdaDmidk/r8KMXlRsV5Hshbw1Z58vA2tFP22Ow6Z
         ZDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS4dYavQRo1V14xPsKWwjppQtY/VLgmKAEuWsyKOjTMR+Zb9EJRzbYiVYAKBzLugVfOSXJ5RX4/dvtzNBWk+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Dw9xWHirnQMKWvQ2cikCnJM/ybDx4DT4dNasrUGDo8BxD4VO
	qzRWOQueW/PMyVXhgAJp9RV5S9d3KQFazg6nbWIq/B3mZwTGAhhFebMh1CYW0QhHrH2x2OfYchJ
	Hm079Xmrp7h6KdyuE/ahOJRfBj00IObgXqMeXBY7Lf22397WSl8yNK460PYs=
X-Google-Smtp-Source: AGHT+IFgZ45sgALAAQfeHYt321ZOtIGEA9C8lac/VFA+nuXt47y8YlJqQlHi/64Fuh/sbtK6tGtrjsDk5fakzSNEQae38ZlW/m75
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:42f:946f:8eb4 with SMTP id
 e9e14a558f8ab-430c527bca5mr9919585ab.21.1760628935190; Thu, 16 Oct 2025
 08:35:35 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:35:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f110c7.050a0220.1186a4.03ce.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: trying to register non-static key in l2cap_unregister_user
From: syzbot <syzbot+cdba6d325676d9602f21@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67029a49db6c Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141b3304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=cdba6d325676d9602f21
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9f00d3dfd46/disk-67029a49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f1d7b8b8e95/vmlinux-67029a49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c60cf4f7bc26/bzImage-67029a49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdba6d325676d9602f21@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 6046 Comm: khidpd_04580058 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
 rt_mutex_slowlock_block+0x5c2/0x6d0 kernel/locking/rtmutex.c:1650
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 l2cap_unregister_user+0x6a/0x1b0 net/bluetooth/l2cap_core.c:1728
 hidp_session_thread+0x3c9/0x410 net/bluetooth/hidp/core.c:1304
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6046 Comm: khidpd_04580058 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:rt_waiter_node_less kernel/locking/rtmutex.c:397 [inline]
RIP: 0010:rt_mutex_steal kernel/locking/rtmutex.c:433 [inline]
RIP: 0010:try_to_take_rt_mutex+0x179/0xac0 kernel/locking/rtmutex.c:1129
Code: dc 74 3d 4d 8d 6c 24 18 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 f1 07 00 00 45 8b 75 00 4c 8d 6b 18 4c 89 e8 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 fe 07 00 00 45 3b 75 00 0f 8d 85 05 00 00
RSP: 0018:ffffc90005e7f8c0 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff8ac83bc4
RDX: dffffc0000000000 RSI: ffff8880257ebc00 RDI: ffff8880328f4050
RBP: 0000000000000000 R08: ffff8880257ebc1b R09: 1ffff11004afd783
R10: dffffc0000000000 R11: ffffed1004afd784 R12: ffffc90005e7fa80
R13: 0000000000000018 R14: 0000000000000078 R15: ffff8880257ebc00
FS:  0000000000000000(0000) GS:ffff888126bc8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c37013a CR3: 0000000036ca4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rt_mutex_slowlock_block+0x61d/0x6d0 kernel/locking/rtmutex.c:1619
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 l2cap_unregister_user+0x6a/0x1b0 net/bluetooth/l2cap_core.c:1728
 hidp_session_thread+0x3c9/0x410 net/bluetooth/hidp/core.c:1304
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rt_waiter_node_less kernel/locking/rtmutex.c:397 [inline]
RIP: 0010:rt_mutex_steal kernel/locking/rtmutex.c:433 [inline]
RIP: 0010:try_to_take_rt_mutex+0x179/0xac0 kernel/locking/rtmutex.c:1129
Code: dc 74 3d 4d 8d 6c 24 18 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 f1 07 00 00 45 8b 75 00 4c 8d 6b 18 4c 89 e8 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 fe 07 00 00 45 3b 75 00 0f 8d 85 05 00 00
RSP: 0018:ffffc90005e7f8c0 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff8ac83bc4
RDX: dffffc0000000000 RSI: ffff8880257ebc00 RDI: ffff8880328f4050
RBP: 0000000000000000 R08: ffff8880257ebc1b R09: 1ffff11004afd783
R10: dffffc0000000000 R11: ffffed1004afd784 R12: ffffc90005e7fa80
R13: 0000000000000018 R14: 0000000000000078 R15: ffff8880257ebc00
FS:  0000000000000000(0000) GS:ffff888126bc8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c37013a CR3: 0000000036ca4000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	dc 74 3d 4d          	fdivl  0x4d(%rbp,%rdi,1)
   4:	8d 6c 24 18          	lea    0x18(%rsp),%ebp
   8:	4c 89 e8             	mov    %r13,%rax
   b:	48 c1 e8 03          	shr    $0x3,%rax
   f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
  13:	84 c0                	test   %al,%al
  15:	0f 85 f1 07 00 00    	jne    0x80c
  1b:	45 8b 75 00          	mov    0x0(%r13),%r14d
  1f:	4c 8d 6b 18          	lea    0x18(%rbx),%r13
  23:	4c 89 e8             	mov    %r13,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 fe 07 00 00    	jne    0x834
  36:	45 3b 75 00          	cmp    0x0(%r13),%r14d
  3a:	0f 8d 85 05 00 00    	jge    0x5c5


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
