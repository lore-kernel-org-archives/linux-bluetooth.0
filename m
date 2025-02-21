Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABE205AA6
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130825; cv=none; b=nk1gicqpWIaddmBX00QAqoUg+11KnhesyFztzHsXta0GiX4ucpq1W1sBrHDvppZL2w0nyQgcCCaPGpqhjJibJhjxRzf3Fz2CF5iUymQ2h5d9zYzEawpWOyiMvx5l/n6TmJNa/4mUAO5oYyzVT6kbb4eDFcsakOxGeP/+8FtFBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130825; c=relaxed/simple;
	bh=ZBDThzcyA02mLIplyOeGkZaDv0L4W2PMTNqzaKLhqNE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MdN+L0b/vS3KUnQDka6mjmQYOa3GDivZYHXii266zdaXa2HGEPR69jGaHsSTz9+UcUQZrieO7hheeN4KUKlM45LDj32I2wMiYLk4QQ2baEMBijyWA15HXcSQXdPKZBhHUYKIIcyksrKf3JWOIqcjQcV0i36zIVSL/epecVHsuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso15104505ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 01:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130822; x=1740735622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVknRPnd/nGxFjcj860Df0ohRN3x9uCn5KBPlIJ1liM=;
        b=lywm2HSgDugiGGzwZDZ3/s1FC3r01C/AsMl1QNathg2FmLcT1SBoMIcR/tP0xWQZUK
         tGg/NoQboeLaJiKIhdAIFL7RGmelmRYVsUUdZ/pCvGuxphyxTtjTCqbCPtVDn4Z2DacE
         uurdS2/c/W1+9xYwmd3T3X3PHhMKz1p1rl9Ru7hrLB41YlLdeN8/YVnYOoJBQBVFRRcC
         o514wO4Tv6BcFKY+CmNB3VHOSA9UklwLBdcYyIpfoU48dIjd8rDfJpucm3qnZGiTDokw
         TtRQAfet+utYK8LybUrJQMlTONPmmbycMwGRWfl4LwMf5NOnIm9p70benNMvNZ9F584Q
         /wjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNA1wtBJnMrmGQJjcPJlv/vp2F37wcYhXJxFXoFXiOmG4CWIxZe5ygkAHc7OyzCGkO6wIG8jSpIPPX2No8lrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD3XTOWOdj18WPyP2aZjWgfFvIrX885WCUeN7ItnxfPfbMa6V+
	Ex0TOcV3Zu+U0VyQImQnIdCk0UxyRpqU3pcw3DfE9Ln97D0Udtr7+ng8ZdLOJ2fbA8WXDy5O1Ap
	IcWBBUh+Smdf0irh3z1Gwu8blUVGYtzzrmLJ92H/QwyLAnUVe5D5Oerk=
X-Google-Smtp-Source: AGHT+IFFs3GNJdXiapr0KYT7urHO86bl7kyBsW6jRlLK7fj5eIupICINtzAm2GO7PWq50dDolt5yftQ62gal8cX4GfGqtv/GtI/B
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0f:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d2cb429ef3mr20742445ab.2.1740130822270; Fri, 21 Feb 2025
 01:40:22 -0800 (PST)
Date: Fri, 21 Feb 2025 01:40:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b84a06.050a0220.14d86d.0356.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING: refcount bug in sco_conn_put
From: syzbot <syzbot+81d70446f786c253e1b1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba643b6d8440 Merge tag 'irq_urgent_for_v6.14_rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ac6898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40c8b8384bc47ab0
dashboard link: https://syzkaller.appspot.com/bug?extid=81d70446f786c253e1b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ba643b6d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f81490db045/vmlinux-ba643b6d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ca8bab9c8a7/bzImage-ba643b6d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81d70446f786c253e1b1@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 21153 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 21153 Comm: syz.3.12815 Not tainted 6.14.0-rc2-syzkaller-00346-gba643b6d8440 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 08 71 f7 fc 84 db 0f 85 66 ff ff ff e8 5b 76 f7 fc c6 05 ef 92 88 0b 01 90 48 c7 c7 80 f0 d2 8b e8 37 b0 b7 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 38 76 f7 fc 0f b6 1d ca 92 88 0b 31
RSP: 0018:ffffc90004e97ac8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90031b18000
RDX: 0000000000080000 RSI: ffffffff817a1236 RDI: 0000000000000001
RBP: ffff88806a5878fc R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: ffff88806a5878fc
R13: ffff88806a587808 R14: 0000000000000000 R15: ffff88802b1292c0
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5064b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000031cf2ffc CR3: 000000005e816000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000000f0102 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 kref_put include/linux/kref.h:64 [inline]
 sco_conn_put+0x2ea/0x4c0 net/bluetooth/sco.c:107
 sco_chan_del+0x9c/0x1b0 net/bluetooth/sco.c:236
 __sco_sock_close+0xab/0x210 net/bluetooth/sco.c:511
 sco_sock_close net/bluetooth/sco.c:526 [inline]
 sco_sock_release+0x6f/0x2d0 net/bluetooth/sco.c:1300
 __sock_release+0xb0/0x270 net/socket.c:647
 sock_close+0x1c/0x30 net/socket.c:1398
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 get_signal+0x1d3/0x26c0 kernel/signal.c:2809
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f83579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f506455c EFLAGS: 00000296 ORIG_RAX: 000000000000016a
RAX: fffffffffffffffc RBX: 000000000000000a RCX: 0000000080000040
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
