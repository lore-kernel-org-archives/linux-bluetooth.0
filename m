Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C619FA93
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746428739; cv=none; b=M0pN2UqC4O2LhMZ42hQu9C/fJCm2sx30GSD4terz6tlKil/VcANkOQStHHHrXp1oKTRzh/h/je4vSAqrS/+dwYvD1jdGTUmmdSubR2VBKstxzMHaFuybJHw/Vi/1GwuqjrLbOildteZPQ9fArxT6WbrFcHPF6BpJNPQICOPReGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746428739; c=relaxed/simple;
	bh=k4X3Nv021dW8jfuf/JCzY3IEXEVO82prEbX9vWVvZoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JzFHfloJ8UXWb6NQTThWQ3nzuad5oPKy7OtjU781Lz1lEvioZwb7NqFaFu5sPtQMJmNUpAYWdcbgiLWss1ERV5EMcWV3KLliW54XFWHXFSPP6iL91TOui9eNZTEgyO6q1NOEfrSFFVz01oycWpjSfWQato0zEOORXQ+5cOFI72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e7f5129d5so354061839f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 00:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746428736; x=1747033536;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLWP2zVJ6fOZqqq1heDqtffHuRpKeSsgJdPsgVovfB8=;
        b=ucyvjF6q/RjRij0yQi5ymoILCn3AhKnSiDrIXjwaWd9gawVTZxRtYI/U4sDpxwuIVf
         /1xckT95f819uEtKBSABnRq2M+T9suLt0rb4bCG2lP6ofBI6n2JVWt+zs8FJNYFTMPUI
         ETrj4apC7FjZeAbDRlehbt1hjfsveV9dGV5aAeUnKyKwY4VRyAj/63VHrIlKbSmQN17l
         t62KNS5EoSfGZleGRiN0kbF5brQYvnelUQKyOSGfc3bXP3N9UPo8CN50zquL2/rPlCot
         b22NUguIT/siMvc3nGCvrRFOHELaUGxNDiMtVqCHu3affs+9Hyn6HNHI43iaV6vW2btv
         70zQ==
X-Gm-Message-State: AOJu0YxBQu8H/aN/1yHSH3TiFwB48rL7ocFNTlOszh/PdQATQpsR+bi1
	1UX34qnw5t1SzO1qZBReXQZ93fsIwBcPbtpgHWissUjO9F4NIVF8AyME3KbT1ZRvbpOggNEXja0
	ZPG5Mra4W6xZeR1JZWcoTcJiUhN+hDISKmr47NqZNtQBftlNSYne/FEZD3g==
X-Google-Smtp-Source: AGHT+IHyfS0v1j5nW12pwutZMnVxePBGV8nWsNpeKPp52ke6dPrmo2UnIsK2qNh+kDMZrEd0wrsgUgot9MOUQ4xA1GJItwEPzSrF
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:3d6:d162:be12 with SMTP id
 e9e14a558f8ab-3da5b3437e9mr59371665ab.21.1746428736480; Mon, 05 May 2025
 00:05:36 -0700 (PDT)
Date: Mon, 05 May 2025 00:05:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68186340.a70a0220.254cdc.0047.GAE@google.com>
Subject: [syzbot] [bluetooth?] [usb?] general protection fault in lookup_or_create_module_kobject
From: syzbot <syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a13c14ee59d Merge tag 'for-6.15-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117ddf74580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=7fb8a372e1f6add936dd
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107a139b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1788302f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7a13c14e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/723f1b9e0adc/vmlinux-7a13c14e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e75e39192fa8/bzImage-7a13c14e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007fc431fa0100 R08: 0000000000000000 R09: 00302e6364755f79
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc43289e520 R14: 00007fc431f9f0d0 R15: 00007ffd3ac3bac8
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 UID: 0 PID: 5424 Comm: syz-executor428 Not tainted 6.15.0-rc4-syzkaller-00051-g7a13c14ee59d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000da77840 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffffffff8b585807 RCX: 92d5a11e0ccfe200
RDX: 0000000000000000 RSI: ffffffff8b585807 RDI: 0000000000000004
RBP: ffffffff819b39d8 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000020 R15: 0000000000000001
FS:  00007fc431fa16c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc431f9eff8 CR3: 0000000052ad3000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:556
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5840
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 complete_with_flags kernel/sched/completion.c:20 [inline]
 complete+0x28/0x1b0 kernel/sched/completion.c:47
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x480 lib/kobject.c:737
 lookup_or_create_module_kobject+0x150/0x170 kernel/params.c:783
 module_add_driver+0xb9/0x310 drivers/base/module.c:46
 bus_add_driver+0x391/0x640 drivers/base/bus.c:682
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 usb_gadget_register_driver_owner+0xf9/0x270 drivers/usb/gadget/udc/core.c:1700
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x149a/0x3c90 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc43281c58b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007fc431f9f020 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fc43281c58b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007fc431fa0100 R08: 0000000000000000 R09: 00302e6364755f79
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc43289e520 R14: 00007fc431f9f0d0 R15: 00007ffd3ac3bac8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000da77840 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffffffff8b585807 RCX: 92d5a11e0ccfe200
RDX: 0000000000000000 RSI: ffffffff8b585807 RDI: 0000000000000004
RBP: ffffffff819b39d8 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000020 R15: 0000000000000001
FS:  00007fc431fa16c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc431f9eff8 CR3: 0000000052ad3000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	66 0f 1f 00          	nopw   (%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	c3                   	ret
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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
