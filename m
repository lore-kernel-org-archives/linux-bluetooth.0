Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355E276059
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393273; cv=none; b=je0jgxykzV1N4JprFi3dRjrXjMM8zKaX/rFo9vc8MVt8H+gRtILCJzcRIz46Qm9z+ROiTFNoF+iOOYImjz5PaFAZtRgZixXJQoKF079p5E2sswsIaQgvTO7xFwUSldxkRZR6z0FfbfUt/YjRhNQHfyIlRSSpUCVYeZANkXJvuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393273; c=relaxed/simple;
	bh=+MC0BbaujLTNCI+9g6A211Gc6CWoxc37DpZNoLnuvTM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OW8+pfnHd630z32wgwAH/XGC+EcW7J3yYB72tBcdv/HU6ynP2ZXNH2BWWbsu8zqp+TcyqLOMyKkiJZgAi+XxxckHKQ2nzawS+KIJmbTJd7HU50P5mplqx5Og3v9bNOHKRFnkqLLPP1aexDGqrlox4LWaSzFwUcKKpHE+erPy18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-889b8d95367so317349639f.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 11:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393271; x=1758998071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HT2WO9yLqEIDzyZD4l1i5kDCmIQ1Iacxdz1mEKeBnRw=;
        b=CqJfeHJ6qaQ/ag9wWyxuDbKKnlH3ZGoiVg5+ue8zCCZ4gxUVu0RlzKmyiVXWfKXtdZ
         NBtxN1TMnTX4xXLYUkOLInj5nNtdvRRM2lMdt7xUzJHthP/B35plJ0X6nyQ+DTckRbUD
         r0cP8HVpXiCtn9NaEwDam7iyjRosZONnVSuxR3TQ7qF1SGx/V5bjaBZWCKBZ1W8Ap6k3
         Hy/tUoLigvIxn2F1PIRDcTV85qKh9evTmHQvstR9AIy4ThT0BB4LjKtWxD2QtprE7A89
         Ci04d39Vr0fz26Ze0oq+QDhdSwIMdxRasIWzwgUJq6jnZDHk92e/qlYkSEs1q1NErJUr
         EpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRP1oir7pT3ycowPeN7BE1R5JfHfk1CPXZPU54Lp8NjQ+gAPOayIXw81b44PvE7tQWqntTknzUWX+wUccTSvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHevNcAnY9WXBQzlft9isTfCNI/spWVgrqQl/bHJPWY2cMAaTk
	leZ77wA7ioYQKaw50FToZ0zvjhuimkaM9V2snJFHDqOFFnx13qg0J41e5FfVjO5zQY+HpM6QlSh
	Hkro7bweLIIra7eF450g6jdjwH2R3W36UjnFoLYRAmPIEGTxMRyXUM4Ghuw8=
X-Google-Smtp-Source: AGHT+IGq9dmvKlA7D4VU0wfO8SRukJrjCcYUebFfx+hqTK2RgM3lGPEk3H8AoaKb7uq60OXYbx2UnBB+XoPraLbJ1NaKdPeOnQAd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13e4:b0:424:8d44:a267 with SMTP id
 e9e14a558f8ab-4248d44a36cmr33889415ab.29.1758393271311; Sat, 20 Sep 2025
 11:34:31 -0700 (PDT)
Date: Sat, 20 Sep 2025 11:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cef3b7.050a0220.13cd81.001e.GAE@google.com>
Subject: [syzbot] [bluetooth?] BUG: unable to handle kernel paging request in l2cap_conn_del
From: syzbot <syzbot+d1bfe010cdd19081abd8@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8736259279a3 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c58534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ed0a6d7c80843e9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1bfe010cdd19081abd8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/025c082a7762/disk-87362592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/606f903fe4d2/vmlinux-87362592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23ea2634f398/Image-87362592.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1bfe010cdd19081abd8@syzkaller.appspotmail.com

Unable to handle kerne
Unable to handle kernel paging request at virtual address fbd5200000000020
KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[fbd5200000000020] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 7191 Comm: syz.4.84 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : l2cap_conn_del+0x260/0x5f0 net/bluetooth/l2cap_core.c:1783
lr : l2cap_conn_del+0x354/0x5f0 net/bluetooth/l2cap_core.c:1783
sp : ffff80009d6674b0
x29: ffff80009d6674d0 x28: 0000000000000001 x27: ffff80008dcedca0
x26: ffff0000d5e18000 x25: dead000000000100 x24: 000000007ffffffe
x23: 0000000000000001 x22: ffff0000c88c1ac0 x21: dead000000000100
x20: dfff800000000000 x19: ffff0000c88c1800 x18: 00000000ffffffff
x17: ffff800093524000 x16: ffff80008b0156e8 x15: 0000000000000001
x14: 1fffe0001abc3001 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001abc3002 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 1bd5a00000000020 x7 : ffff80008312a368 x6 : 0000000000000000
x5 : 0000000000000020 x4 : ffff80009d666fb0 x3 : ffff80008a29deb8
x2 : 0000000000000001 x1 : 0000000000000002 x0 : 0000000000000001
Call trace:
 l2cap_conn_del+0x260/0x5f0 net/bluetooth/l2cap_core.c:1783 (P)
 l2cap_disconn_cfm+0x90/0xe0 net/bluetooth/l2cap_core.c:7325
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2097 [inline]
 hci_conn_hash_flush+0x108/0x218 net/bluetooth/hci_conn.c:2599
 hci_dev_close_sync+0x89c/0x1154 net/bluetooth/hci_sync.c:5294
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_unregister_dev+0x204/0x4c0 net/bluetooth/hci_core.c:2715
 vhci_release+0x12c/0x17c drivers/bluetooth/hci_vhci.c:690
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:961
 do_group_exit+0x194/0x22c kernel/exit.c:1102
 get_signal+0x11dc/0x12f8 kernel/signal.c:3034
 arch_do_signal_or_restart+0x274/0x4434 arch/arm64/kernel/signal.c:1619
 exit_to_user_mode_loop+0x7c/0x168 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: 54000e80 52800037 321f77f8 d343ff28 (38746908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000e80 	b.eq	0x1d0  // b.none
   4:	52800037 	mov	w23, #0x1                   	// #1
   8:	321f77f8 	mov	w24, #0x7ffffffe            	// #2147483646
   c:	d343ff28 	lsr	x8, x25, #3
* 10:	38746908 	ldrb	w8, [x8, x20] <-- trapping instruction


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
