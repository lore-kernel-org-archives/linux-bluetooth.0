Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4122D4C8
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847429; cv=none; b=XLy/9RPlQJu7SKwCxvc/hZRdmZCFXwZaGVT5Dji7XHW8wZLcbF/MNQPxgHYJR02cnja7fsDR/vxBYW7VEGkMJ0DaQ+LY8VdMvdWAL/7iYXBQAtwl+iEapc9u+zTEjWvjJJ3/CD0McRqNJ4GShSUUPBbMsWmsBTjBlG0y+n6j7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847429; c=relaxed/simple;
	bh=q9EnXfvR2oauZazKdgMj89xrbBAhuBIwTcNOoiBs2UQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cxjb3NFsvYg4m1/syojRhKDzu5Iw/IVSNvc4N0Tx5LuS+Q/ms2iZKtP4N+chbwLLEMx2fceaX64dKczkbr4gDGRKkZeNjeKFocF84WjPOpYWCTpZufJ1Y7N9BFWBa9yeWERuGPQWf+OcH3T2VbcpsmbDdm6+SIeQUuOAq/gfEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cfba1ca53bso5391785ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 05:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738847427; x=1739452227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/W8tNmgi/szrWGKc3h7bvmc6tLRKZ9XN4uW3PM9I/eM=;
        b=Hi3XDnAjgPOo4EyAT7St7Ty5SPmCOp6r5EcNpX+rHQNSQEqwoGMXleI2Y9ajvTS4Fj
         6blC08jcO+zzitfJQt+vvBxJaBTw5F3S04BRVZd49nfgf9qT1Hw7YFZ7zIm2sP7NvYrR
         ubUYpSplK8TZNYVS28xmUzi3EkMSDzS3P0in4EX5X/WM2l2lfl4tPUay92Ss8hCQ/2wC
         LpZfaz+0OiGKTLn+Zt1HvYfMrHx6vbu9YbuSYYvNtfaYIndiIq8q0tnujPbcWFlIyZE8
         nx+15AxC+l5y9Kp1wmc6knhzv6kN5mjGEQPj6IA/lhV3Mf1aa5C+ecZtCahLUN/xq0SZ
         KETA==
X-Forwarded-Encrypted: i=1; AJvYcCVNxst8T6beFl+W/iN7LTzUI36uEnaNuMSU97EuQ8o0b0ghYVRP/A3foO1vLkAb3Gl2CZ8yeij4sHGP9a5gomo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy030CQjCXvufIf4PniwmHsYLzp0y6PkIvkHYmkStYRarvq7Hgi
	4z27LBD/Y03A3wQyR+JfjeyJiYGk6BI8op5JHAvkNl5Oiaj/h9FgVb76u0esVTuCBTMY0SaGgzD
	mY2/A8ymZAlm1IXv4AUOjHT0CRdSWZyv4+kEpLHRYKjj+j9TDGmYsQaw=
X-Google-Smtp-Source: AGHT+IGYxvKqYpQvvQLs24An7KO8YUZv6pssqTsv/XSVfaPtVC7hWFnfe/p/PIlAyU7ZWAychcqpKPgB7Ma6XpeEAeo++252e4lS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3cf:cac9:b02d with SMTP id
 e9e14a558f8ab-3d04f4282e9mr61859785ab.8.1738847427200; Thu, 06 Feb 2025
 05:10:27 -0800 (PST)
Date: Thu, 06 Feb 2025 05:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4b4c3.050a0220.264083.0005.GAE@google.com>
Subject: [syzbot] [bluetooth?] BUG: corrupted list in hci_chan_del (2)
From: syzbot <syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com>
To: eadavis@qq.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16241eb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=10bd8fe6741eedd2be2e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1078cf64580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138f5d18580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccdfef06f59f/disk-40b8e93e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b339eaf8dcfd/vmlinux-40b8e93e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae1a0f1c3c80/bzImage-40b8e93e.xz

The issue was bisected to:

commit 6ab54a7171894394fa07f28f835d714967b39797
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Jan 16 15:35:03 2025 +0000

    Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1273d3df980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1173d3df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1673d3df980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com
Fixes: 6ab54a717189 ("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd")

 non-paged memory
list_del corruption, ffff888021297e00->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5896 Comm: syz-executor213 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x190 lib/list_debug.c:59
Code: 8c 4c 89 fe 48 89 da e8 32 8c 37 fc 90 0f 0b 48 89 df e8 27 9f 14 fd 48 c7 c7 a0 c0 60 8c 4c 89 fe 48 89 da e8 15 8c 37 fc 90 <0f> 0b 4c 89 e7 e8 0a 9f 14 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 cb
RSP: 0018:ffffc90003f6f998 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 01454d423f7fbf00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff819f077c R09: 1ffff920007eded0
R10: dffffc0000000000 R11: fffff520007eded1 R12: dead000000000122
R13: dffffc0000000000 R14: ffff8880352248d8 R15: ffff888021297e00
FS:  00007f7ace6686c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7aceeeb1d0 CR3: 000000003527c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:168 [inline]
 hci_chan_del+0x70/0x1b0 net/bluetooth/hci_conn.c:2858
 l2cap_conn_free net/bluetooth/l2cap_core.c:1816 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put+0x70/0xe0 net/bluetooth/l2cap_core.c:1830
 l2cap_sock_shutdown+0xa8a/0x1020 net/bluetooth/l2cap_sock.c:1377
 l2cap_sock_release+0x79/0x1d0 net/bluetooth/l2cap_sock.c:1416
 __sock_release net/socket.c:642 [inline]
 sock_close+0xbc/0x240 net/socket.c:1393
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2522
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7aceeaf449
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7ace668218 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f7acef39328 RCX: 00007f7aceeaf449
RDX: 000000000000000e RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f7acef39320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000004 R14: 00007f7ace668670 R15: 000000000000000b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x190 lib/list_debug.c:59
Code: 8c 4c 89 fe 48 89 da e8 32 8c 37 fc 90 0f 0b 48 89 df e8 27 9f 14 fd 48 c7 c7 a0 c0 60 8c 4c 89 fe 48 89 da e8 15 8c 37 fc 90 <0f> 0b 4c 89 e7 e8 0a 9f 14 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 cb
RSP: 0018:ffffc90003f6f998 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 01454d423f7fbf00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff819f077c R09: 1ffff920007eded0
R10: dffffc0000000000 R11: fffff520007eded1 R12: dead000000000122
R13: dffffc0000000000 R14: ffff8880352248d8 R15: ffff888021297e00
FS:  00007f7ace6686c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7acef05b08 CR3: 000000003527c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
