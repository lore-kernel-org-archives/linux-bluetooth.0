Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A4273F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629100; cv=none; b=UCZaZO6fpQr3Acy+NmdUc+SwOLU4WnJxoy0z0ScvXYWlIrv6wJFEUao5rm4OM6uikcC8VnZvCSWBacyrmvmiyfOhPJS96fXh4Q/hc+RyaV9jSYfRAEHjL/7seVB3aAqlwlZeiPlbf5L2tbI+ENFRdTJ91sQslhiOZsoJQJELVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629100; c=relaxed/simple;
	bh=Yo6hGYy6yQXRjpuNhdxm0QuGJ2+ODHo+Xw7bxn8SIC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iMnRTQs1zwL8ItU2CBgxvl64gQ5fZuHvSmd4PhIYfGnVHcBw/SSrwLBGLAcG3EYDOhq18r61nlO8xtLsrCiZsYj8ddXnATIV6Rj1Ox7TDWLXYjaZF8NWkbkmbMOahrX4TZUykdxG7dCQj/9DIHoMWtRw2aGCQa6DUpUfnhjaccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65747f4376bso11012933eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 18:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766629097; x=1767233897;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hR/sLhAAYEYOBEdG63XFmTVs5K9f3NhsRspN7ogHs0k=;
        b=b9DLkT3I3Bh5OLGJ7FXAdpjH3TPuozhQDmZrt0aoUJFN+ZChV8Gwr3pjJPcEaEob/A
         yFZiCSixG+mC/6GQ57xaNCeNQ1jCf/wT+LsVjHOKW6AopvHdF7XjIJMzpgBsFvUDu4XD
         GzR3t47eYoctr4kG3cDb5VkIOJT/XhjpRWcrLfnUWcLANMyBvIY4WJIMZU44ypJQMR3F
         MaA5TnAmQ7FpEGY2MpHKZLLjedU3bJdDjYIwwa2yfVMeAT4CyXBSGPf9tNkb0RNm+EVY
         1kg7hTu2e1O5oBFkHSNbDZN4gwhN8c0Rig2iviFkjryp2mBO9rKOJcGAKb023zKsydI3
         /zLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjH6+65sJhxFzOtycBsgIk86snejFs1Fvm4kAZ+4kn+0F7QkIpGGYRL2l+N0pAqFcpOt8AUBb4BFfVE0iLSn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRPEeWjNW5OfhX/dTWPVKHbL7lBBBNyE3fjRjTIvvBx76fQnl
	7S1AS5CTZXzij77zhAESuKJ+3JC9l2huO5TWdXMzV6G1W4gqYW6ukRir+6DxFzJ6BwaWPxgM7uQ
	m72PBBPWQouQ1FOuuXxjfD7jG5i3GVHZgvHI3gnuXYnpTnyoWlQW66yTRkro=
X-Google-Smtp-Source: AGHT+IECKwbp9f0L6KhBNNKVbTA5fGCAC0S/t5p2IcVIMclN5E9RoGDp9QVOgoqparaPMDqI5UOM2II9D34rv+gtfckiXd0r2BNT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:827:b0:65b:32b4:83e7 with SMTP id
 006d021491bc7-65d0ea341dcmr8140386eaf.19.1766629097460; Wed, 24 Dec 2025
 18:18:17 -0800 (PST)
Date: Wed, 24 Dec 2025 18:18:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694c9ee9.050a0220.35954c.0030.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_connect_sco
From: syzbot <syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d8ba32c5a460 Merge tag 'block-6.19-20251218' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179a83c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=5897b3c764f5989ea942
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d8ba32c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce9be55c4ca6/vmlinux-d8ba32c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a47a6667df3/bzImage-d8ba32c5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci0
WARNING: kernel/workqueue.c:2252 at __queue_work+0xd20/0xf90 kernel/workqueue.c:2250, CPU#0: syz.0.0/5341
Modules linked in:
CPU: 0 UID: 0 PID: 5341 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__queue_work+0xd4b/0xf90 kernel/workqueue.c:2250
Code: 83 c5 18 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 86 f8 9e 00 49 8b 75 00 49 81 c7 78 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8d fb
RSP: 0018:ffffc9000bd4fb10 EFLAGS: 00010086
RAX: 1ffff11006c5114b RBX: 0000000000000008 RCX: 0000000000100000
RDX: ffff88801168a178 RSI: ffffffff8a596e20 RDI: ffffffff8fa52910
RBP: 0000000000000000 R08: ffff888036288a47 R09: 1ffff11006c51148
R10: dffffc0000000000 R11: ffffed1006c51149 R12: dffffc0000000000
R13: ffff888036288a58 R14: ffffffff8fa52910 R15: ffff88801168a178
FS:  00007f3f80e366c0(0000) GS:ffff88808d22a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff38bb2f52 CR3: 00000000419d7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2555
 hci_connect_sco+0xe9/0x3a0 net/bluetooth/hci_conn.c:1767
 sco_connect net/bluetooth/sco.c:339 [inline]
 sco_sock_connect+0x308/0xad0 net/bluetooth/sco.c:665
 __sys_connect_file net/socket.c:2089 [inline]
 __sys_connect+0x316/0x440 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2111
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f7ff8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f80e36038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3f801e6090 RCX: 00007f3f7ff8f7c9
RDX: 0000000000000008 RSI: 0000200000000100 RDI: 0000000000000006
RBP: 00007f3f80013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3f801e6128 R14: 00007f3f801e6090 R15: 00007ffdb2852538
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 c5 18             	add    $0x18,%ebp
   3:	4c 89 e8             	mov    %r13,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   f:	74 08                	je     0x19
  11:	4c 89 ef             	mov    %r13,%rdi
  14:	e8 86 f8 9e 00       	call   0x9ef89f
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
  3d:	e9                   	.byte 0xe9
  3e:	8d                   	(bad)
  3f:	fb                   	sti


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
