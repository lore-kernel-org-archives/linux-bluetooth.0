Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A341E9B06
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257531; cv=none; b=iytuiXDD+OEalhEk+aPHLs/nx0N1duVSm3fOAYeU9UpO5qwW+XwR0rlB17u+rCOzsJ2GfeERc1ZLl+syy88SZMs18ycuSFZTtqTB54ZBClhyonDf627zvlqg+WKPSRV4qR4ptvyFmw8X+SwGfJmb2HrWh9YtQWq0VMlDKlHHP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257531; c=relaxed/simple;
	bh=oaAaNX/QxmUMbeZs9fPg2tPMIurhFhVqYkQIbFmbTRM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+Wv219AJ1d6zE0TkMujgGUjXgS3km6WMq/wPM9m2XD3t5+ZDLs+q6/Dk3ZGuXJzmXcv5wd4jjocsxMDkg84CjjYpwaLlAO4QFsxEtR/xtzhYkhbVOOTtrcM7mjon21l4Q97/dvUxcCQ6IZ1Va+JXSWR3wZzkXPUJvunmFKfFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d1466cbaddso26534435ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 23:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739257529; x=1739862329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUX72q2tBzhNGgAjcGhqVuvMWdHoUisryHtNBvrmTx0=;
        b=w0J0H6FbM2/gUp5bd/x+jSKk79RiOx7tLFoLgNt5Yrqze+M9xfdD0m9BIDYMh+T1FF
         hNYSDTF0f6e0Fm4c56IqsXGx/Vdp8ZSCOsdz7tBaxRKhtm+rvZvc1//ouswn8HdvV6wz
         ht8gS9RKpSY0eBiQbThFD5O1KXDiaTqsQId5UuYf5TxRqGLf9LgZ2R11OCPhC3G7ok6P
         e2sIhrKXQOqwJ1IfF4WaNWaZAUJOIyDA1bkVY2hSW2tRDQvhy7DehRPOdtiiBlhk4szV
         2uOAV2hqytOmJB32ZRSwpX22acJgwADoVTetCzFVT3oLjqC7SpRvkJdsNuF4KEEERbaW
         YxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvFvFSq80zfhCXkUtdcWx2SBwmFZ4Ylrod4op8aC7gb6J3wY01Fj7pVI0nXZ04IM6RXuuigbfobniIdRFHUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcW0O0D+mI/hbd6Fg+K70PClpPY8rm//+p/YhebCgxpyC/o3/8
	obT5WYQoEosmh1wpu3b2ehGdQFY4rguKlfx1CIVwjpRF5G+J4Ve4lutp8Hw/nhaajz+0S93347g
	klKOjWc5eYjXAuD3JysfeTjvT2WgQZx1RGExcP4Og41Fg+uDYZZcGUtQ=
X-Google-Smtp-Source: AGHT+IGnQ5EmH4VvTsLPowsxr/DMZLw5btUfg0zpp1vsVeoLP0DzSeWvURLXfamuZ4ai9GB/4nwE1VH6qOwAUya5WfXWIhXPOFXH
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3d1:5037:c97a with SMTP id
 e9e14a558f8ab-3d16f405ca1mr17852615ab.3.1739257529333; Mon, 10 Feb 2025
 23:05:29 -0800 (PST)
Date: Mon, 10 Feb 2025 23:05:29 -0800
In-Reply-To: <67a8cd8f.050a0220.3d72c.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aaf6b9.050a0220.3d72c.005d.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in h5_recv
From: syzbot <syzbot+b5691bb559396b262064@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    df5d6180169a Add linux-next specific files for 20250210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a9c3f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c78e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129c78e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92495cf20271/disk-df5d6180.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3656161842/vmlinux-df5d6180.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fbc4e7a0f5d/bzImage-df5d6180.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5691bb559396b262064@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000005f: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000002f8-0x00000000000002ff]
CPU: 1 UID: 0 PID: 5834 Comm: syz-executor200 Not tainted 6.14.0-rc2-next-20250210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:h5_recv+0x153/0x940 drivers/bluetooth/hci_h5.c:572
Code: 08 01 44 8b 64 24 04 48 8b 5c 24 08 4c 8b 74 24 18 49 ff c7 41 ff cc 45 85 e4 0f 8e 55 06 00 00 e8 a2 58 f5 f8 48 8b 44 24 30 <42> 80 3c 28 00 74 08 48 89 df e8 ce 53 5c f9 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90003e8fc60 EFLAGS: 00010202
RAX: 000000000000005f RBX: 00000000000002f8 RCX: 0000000000000061
RDX: ffff8880350dda00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003e8fd70 R08: ffffffff88ca308e R09: 1ffff110062cdb03
R10: dffffc0000000000 R11: ffffffff88ca2fd0 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88803166d800 R15: ffffc90003e8fe00
FS:  00007f38f1dd06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38f1d8ed58 CR3: 000000007b704000 CR4: 00000000003526f0
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
RIP: 0033:0x7f38f1e183d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38f1dd0218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f38f1e9f328 RCX: 00007f38f1e183d9
RDX: 0000400000000040 RSI: 0000000000005412 RDI: 0000000000000006
RBP: 00007f38f1e9f320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f38f1e6c074
R13: 0000400000000300 R14: 00004000000000c0 R15: 0000400000000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:h5_recv+0x153/0x940 drivers/bluetooth/hci_h5.c:572
Code: 08 01 44 8b 64 24 04 48 8b 5c 24 08 4c 8b 74 24 18 49 ff c7 41 ff cc 45 85 e4 0f 8e 55 06 00 00 e8 a2 58 f5 f8 48 8b 44 24 30 <42> 80 3c 28 00 74 08 48 89 df e8 ce 53 5c f9 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90003e8fc60 EFLAGS: 00010202
RAX: 000000000000005f RBX: 00000000000002f8 RCX: 0000000000000061
RDX: ffff8880350dda00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003e8fd70 R08: ffffffff88ca308e R09: 1ffff110062cdb03
R10: dffffc0000000000 R11: ffffffff88ca2fd0 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88803166d800 R15: ffffc90003e8fe00
FS:  00007f38f1dd06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000040000000f000 CR3: 000000007b704000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 01                	or     %al,(%rcx)
   2:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
   7:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   c:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
  11:	49 ff c7             	inc    %r15
  14:	41 ff cc             	dec    %r12d
  17:	45 85 e4             	test   %r12d,%r12d
  1a:	0f 8e 55 06 00 00    	jle    0x675
  20:	e8 a2 58 f5 f8       	call   0xf8f558c7
  25:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ce 53 5c f9       	call   0xf95c5407
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
