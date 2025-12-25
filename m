Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684572610
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634022; cv=none; b=j/VALU1GfB0VVwK1tDR9B9baYktvJtg1wvhN2n7k9Co1Idbt16+/gwHPiH20wgPP+SV78u4UviU86aXZJKHqNcVWNXFvbVGoK+zk9JfmXuWEihu0pMH6kPiO8eGPzbAhxd4FjX9xlmMH9OFXnsJjkn6E+yPGeAP3Tjgw4GoTmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634022; c=relaxed/simple;
	bh=EFzdW8w0XlNqe++zmC5AcVtI3YG2HVUUaWMnMy7pUAY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kw893y5CL3D3170QH/K60/N9OoxkLEmEq6QqxCdklLSNIQIDdKCizHk2qQbvAj3xSslqEpqZamJ9W8zDhWXNlsSc+yEX5G5QEd6j75iJvQIzqhrzNojYtX5YDwnWlFIvumxLMtP+Q9hEY7NMth1kCs9wq3riKiRQZBc65YTnBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c702d1a4f7so13159844a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 19:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766634020; x=1767238820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z00/hGF5plhDKBS6C6S81tUggCKehsIVQ6gXVc72NmM=;
        b=Imzala18IF62L48XWEj1+apFEpZpJVgol2T7ULRGcdM9DSNdSkr3aqZnisa+vZDDUe
         F6df1JGI86oVRRMeB7GfVd6v9lnNLjmGAhy7wQFYjzJb73oADlUgLBlQQ3MGsnVIpNTn
         vBAUSE9Ri1pamlcKCRr2k8C+8n2DGFUngq4BmDFGrf6oiROlyKUlGX81Ee42J8zbbQj8
         21kCB/h973WO8Bx2avBbsVuDkJNjPa3XPmnjGmex65/Jh8Tuzezz0hN7N9eVEV9R+dUO
         lqE51OToYNhSh7+IcjFniGhEVQSY8nqlbVk6YudTE41Yvw97WTeMVnX39VmpLuxy+OUY
         qI6g==
X-Forwarded-Encrypted: i=1; AJvYcCUPmnLT4TKe2iiEOyiPc/lhm/678rGBI/uwd1KDP1gDrMIfHIP3l6WSZb3w+PrOZBm0o2aKBmK/qO4hKcJ5Ftk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsC6OdiOp5zmX3nJhQhNheW8wDQivfu/SivGCa1SV3MuQEB/B
	cMuGBn9Ww3EYFc2XV+2dgrh9NfrhByONWDv0TII8dEf9Mlo/Cengzl7czhYtqjbzceFQfFsU9zh
	jzFFOp3Gmjpu32iWL/FHDABPyMlz8mOQucqvWD2nTgsJOGATZ56eFd2nKc5Q=
X-Google-Smtp-Source: AGHT+IE3R72c/GHx0pMB+maM1dCvrpGFqMGxPRYN2lcneqX9Gx4CKNeocCtOKyMOROSyuHPlz0iYHlPr314s2DCykEl5EWVq1wj4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:827:b0:659:9a49:8ffc with SMTP id
 006d021491bc7-65d0ea7360cmr8282450eaf.41.1766634019779; Wed, 24 Dec 2025
 19:40:19 -0800 (PST)
Date: Wed, 24 Dec 2025 19:40:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694cb223.050a0220.35954c.0032.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING: locking bug in l2cap_unregister_user
From: syzbot <syzbot+a97711deac466a4afeac@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14520b1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a
dashboard link: https://syzkaller.appspot.com/bug?extid=a97711deac466a4afeac
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd4f5f43efc8/disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aafb35ac3a3c/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d221fae4ab17/Image-8f0b4cce.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a97711deac466a4afeac@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:-1 [inline], CPU#1: khidpd_10cf5502/6710
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4854 [inline], CPU#1: khidpd_10cf5502/6710
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x384/0x30a4 kernel/locking/lockdep.c:5187, CPU#1: khidpd_10cf5502/6710
Modules linked in:
CPU: 1 UID: 0 PID: 6710 Comm: khidpd_10cf5502 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : hlock_class kernel/locking/lockdep.c:-1 [inline]
pc : check_wait_context kernel/locking/lockdep.c:4854 [inline]
pc : __lock_acquire+0x384/0x30a4 kernel/locking/lockdep.c:5187
lr : hlock_class kernel/locking/lockdep.c:238 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4854 [inline]
lr : __lock_acquire+0x378/0x30a4 kernel/locking/lockdep.c:5187
sp : ffff80009f727820
x29: ffff80009f727900 x28: 0000000000000001 x27: ffff0000cfc46078
x26: ffff80008afa88d4 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000cfc45580
x20: ffff8000975d0000 x19: 0000000000000000 x18: 1fffe00033781890
x17: ffff80008f86e000 x16: ffff800082e5c71c x15: 0000000000000001
x14: 1fffe000337818fa x13: 0000000000000000 x12: 0000000000000000
x11: ffff800093397d48 x10: 0000000000ff0100 x9 : 910d7cd7a1feeb00
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800080575c38
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000807f0908
x2 : 0000000000000001 x1 : 0000000100000002 x0 : 0000000000000000
Call trace:
 hlock_class kernel/locking/lockdep.c:-1 [inline] (P)
 check_wait_context kernel/locking/lockdep.c:4854 [inline] (P)
 __lock_acquire+0x384/0x30a4 kernel/locking/lockdep.c:5187 (P)
 lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
 set_task_blocked_on include/linux/sched.h:2165 [inline]
 __mutex_lock_common+0xd24/0x2678 kernel/locking/mutex.c:701
 __mutex_lock kernel/locking/mutex.c:776 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:828
 l2cap_unregister_user+0x74/0x190 net/bluetooth/l2cap_core.c:1729
 hidp_session_thread+0x3d0/0x490 net/bluetooth/hidp/core.c:1304
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
irq event stamp: 60
hardirqs last  enabled at (59): [<ffff80008049e5a4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1570 [inline]
hardirqs last  enabled at (59): [<ffff80008049e5a4>] finish_lock_switch+0xb0/0x1c0 kernel/sched/core.c:4995
hardirqs last disabled at (60): [<ffff80008afb8d40>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (60): [<ffff80008afb8d40>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffff8000803bf2b4>] copy_process+0x10a8/0x32fc kernel/fork.c:2167
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c4
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000117997000
[00000000000000c4] pgd=08000001229a2403, p4d=08000001229a2403, pud=080000010828f403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6710 Comm: khidpd_10cf5502 Tainted: G        W    L      syzkaller #0 PREEMPT 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4854 [inline]
pc : __lock_acquire+0x398/0x30a4 kernel/locking/lockdep.c:5187
lr : hlock_class kernel/locking/lockdep.c:238 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4854 [inline]
lr : __lock_acquire+0x378/0x30a4 kernel/locking/lockdep.c:5187
sp : ffff80009f727820
x29: ffff80009f727900 x28: 0000000000000001 x27: ffff0000cfc46078
x26: ffff80008afa88d4 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000cfc45580
x20: ffff8000975d0000 x19: 0000000000000000 x18: 1fffe00033781890
x17: ffff80008f86e000 x16: ffff800082e5c71c x15: 0000000000000001
x14: 1fffe000337818fa x13: 0000000000000000 x12: 0000000000000000
x11: ffff800093397d48 x10: 0000000000ff0100 x9 : 00000000000c1e77
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800080575c38
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000807f0908
x2 : 0000000000000001 x1 : 0000000100000002 x0 : 0000000000000000
Call trace:
 hlock_class kernel/locking/lockdep.c:229 [inline] (P)
 check_wait_context kernel/locking/lockdep.c:4855 [inline] (P)
 __lock_acquire+0x398/0x30a4 kernel/locking/lockdep.c:5187 (P)
 lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
 set_task_blocked_on include/linux/sched.h:2165 [inline]
 __mutex_lock_common+0xd24/0x2678 kernel/locking/mutex.c:701
 __mutex_lock kernel/locking/mutex.c:776 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:828
 l2cap_unregister_user+0x74/0x190 net/bluetooth/l2cap_core.c:1729
 hidp_session_thread+0x3d0/0x490 net/bluetooth/hidp/core.c:1304
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: 14000003 d00972eb 9135216b b9402369 (39431113) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	14000003 	b	0xc
   4:	d00972eb 	adrp	x11, 0x12e5e000
   8:	9135216b 	add	x11, x11, #0xd48
   c:	b9402369 	ldr	w9, [x27, #32]
* 10:	39431113 	ldrb	w19, [x8, #196] <-- trapping instruction


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
