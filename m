Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3F158DC4
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739639902; cv=none; b=Ctc/dFi6PNMbVlQx3jEF8GnaQCQsCgXZZ5w15oeT0anv81YW5Q3EBbKIMd4Elc1Nx/OuFU5xoGkSWTxoojx+ApD0wIscqQ6Ja0oSJfNziFLBkf5mbPB2ri2sZ1crEkQyyP336ijAogMaYSgo4fTVZBqlcg0JGAZ+FRjIwlaVRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739639902; c=relaxed/simple;
	bh=RFEWrCUShwgVdNPvnxVDnheZEPFUwyM6zeN8VlOW014=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rEDC709vukXu1Mn6IMwhbWUcG6kmqR8ZeOQR0eVUG31wAT6qHhG7nDKJofcpeM9bm5p3Vt/RbTELldK4HtLnqRQ6jRVtj3Z5JLxQD+9ByBQLtFn4ENylLCH5PMVY6x6YEMMYJaJ3BjES+ZcXBzPlx82zCargeRRFU7Wb88KTwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2858ce843so3265465ab.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 09:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739639900; x=1740244700;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsLhZ191vrYU5fujgkATG9kXKEFSnPg2S3s9On+hOXo=;
        b=oEjuIhHkiPVc/bulrzJ31Mu2hpZDong5WNuNf0q+SlhhyO9w1tTtJYzBdH3pvo3s6l
         jZDjahIqMLaJh3xIh07UwbRdZlt1woO+FVplU7vLnjuyc82aLcP/HZ4aL5m37WNU5haJ
         OpS8jFKR6S9wVumm2PUDiLvYRPSRWa0fqx2Boo4SlB4mif1h9O3kBLahGEBmio0wnckO
         2NdlwP/BjQlzPPOVmXKhvcu8g81iXG5kRV4iTzehqTLcjSG3FhMEOjtWpP3d4HWbMZNe
         cs8oujvgXkfPWUbnAZ9hQzQ0lkN2eTK+e4zVNZwSrO+exGOeBPcY/gjD1+WKoc7T0Oh5
         hVLA==
X-Gm-Message-State: AOJu0YxkgEluSUOJdKyLoGFjB3r7UL1EqvckhnkE4hZjwzE6yLMDP/aQ
	joVGDJ6yaoju2FkH11Ypoh1wbZbxjTjdDR+FagKPUwis+4VPIyQ1jT836Y41w5ppNYPBiDhBh7Y
	cYaTyMIz3i7ZeAf9i/Ip1NqrHJVd8wvlmmc3z6EqnJwe+lCQKz7cPQI9QMA==
X-Google-Smtp-Source: AGHT+IENTpBl/uZ96gO6h5GkDtGD5eg14FMjs/IUzqfR6iyPa2dkI5XD1VDdg3O4kpD0oqOmCfd+O0qLcV7SVY44luZTiyOLfzfD
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148b:b0:3d0:24c0:bd4d with SMTP id
 e9e14a558f8ab-3d280946e67mr28198605ab.18.1739639899820; Sat, 15 Feb 2025
 09:18:19 -0800 (PST)
Date: Sat, 15 Feb 2025 09:18:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0cc5b.050a0220.6f0b7.0014.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df5d6180169a Add linux-next specific files for 20250210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17be8718580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1480a3f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92495cf20271/disk-df5d6180.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3656161842/vmlinux-df5d6180.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fbc4e7a0f5d/bzImage-df5d6180.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 UID: 0 PID: 6167 Comm: syz.3.45 Not tainted 6.14.0-rc2-next-20250210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:bcsp_recv+0xcd/0x16d0 drivers/bluetooth/hci_bcsp.c:590
Code: 38 4c 89 e8 48 c1 e8 03 48 89 44 24 28 48 89 4c 24 20 48 89 6c 24 18 4c 89 6c 24 10 4c 89 7c 24 08 89 5c 24 04 48 8b 44 24 38 <42> 80 3c 30 00 74 08 48 89 ef e8 94 d5 5c f9 48 8b 5d 00 31 ff 48
RSP: 0018:ffffc900034d7cd0 EFLAGS: 00010202
RAX: 0000000000000021 RBX: 0000000000000001 RCX: 0000000000000182
RDX: ffff888035fc8000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000108 R08: ffffffff88c9aef5 R09: 1ffff1100ade3c03
R10: dffffc0000000000 R11: ffffffff88c9ae90 R12: ffffc900034d7e00
R13: 0000000000000178 R14: dffffc0000000000 R15: 0000000000000110
FS:  00007f0fbdf626c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000348be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_uart_tty_receive+0x141/0x1c0 drivers/bluetooth/hci_ldisc.c:622
 tiocsti+0x24d/0x300 drivers/tty/tty_io.c:2299
 tty_ioctl+0x518/0xdc0 drivers/tty/tty_io.c:2716
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fbd18cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0fbdf62038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0fbd3a6160 RCX: 00007f0fbd18cde9
RDX: 0000400000000240 RSI: 0000000000005412 RDI: 0000000000000007
RBP: 00007f0fbd20e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0fbd3a6160 R15: 00007fffe8c957b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bcsp_recv+0xcd/0x16d0 drivers/bluetooth/hci_bcsp.c:590
Code: 38 4c 89 e8 48 c1 e8 03 48 89 44 24 28 48 89 4c 24 20 48 89 6c 24 18 4c 89 6c 24 10 4c 89 7c 24 08 89 5c 24 04 48 8b 44 24 38 <42> 80 3c 30 00 74 08 48 89 ef e8 94 d5 5c f9 48 8b 5d 00 31 ff 48
RSP: 0018:ffffc900034d7cd0 EFLAGS: 00010202
RAX: 0000000000000021 RBX: 0000000000000001 RCX: 0000000000000182
RDX: ffff888035fc8000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000108 R08: ffffffff88c9aef5 R09: 1ffff1100ade3c03
R10: dffffc0000000000 R11: ffffffff88c9ae90 R12: ffffc900034d7e00
R13: 0000000000000178 R14: dffffc0000000000 R15: 0000000000000110
FS:  00007f0fbdf626c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0fbdf40f98 CR3: 00000000348be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	38 4c 89 e8          	cmp    %cl,-0x18(%rcx,%rcx,4)
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   d:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  12:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  17:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
  1c:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
  21:	89 5c 24 04          	mov    %ebx,0x4(%rsp)
  25:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 94 d5 5c f9       	call   0xf95cd5cd
  39:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  3d:	31 ff                	xor    %edi,%edi
  3f:	48                   	rex.W


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
