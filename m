Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7D18AF4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740156; cv=none; b=Y5pdDzOE3Y+APIvBMUXmtWt8GttzZw3icX0u/1sB9L5SMOnyLd/P12XBS4OBoI/ZKMcfhOyAFd8gTBwR2QxOHC0AF0Z9pmhj7iw/1eSmfr4vO5Jzuw9fo+Tre27tE0fNK2XsLJUcxcVBM8XHoZRZENGC2ggsYqH10+oIhndNShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740156; c=relaxed/simple;
	bh=xnzkJqvF9SS7OCh6gpHQik2oYxD3jpKbA2lZngE0s94=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vAvqN7Gito3pGDYmkqQdLVLVU2dUbObDdmWBkRNMk49Mmi7AjSTNA0YVmSPiRTYVARPrLVs/BkbxpNp6sCrVZ/LDN81iSNH+der78JRpi3RwO3XXckzppjwNvEy8VfwzcGll5qhzhyHWGbmUE0fNKEpDIpYHpGpWlhTPtdigoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eb3db8593cso193653839f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 23:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740154; x=1718344954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym5veEx5AbPUlkkdBwadMLhZYHUPGziKKf3EnNwHgkg=;
        b=rp2ud4KuitbhFwtjQZQgn+vlhF/aBR2rs2UZH3hdzp99AkTU5Lu0cuh49lj4Hqu0Y/
         AjG0d4cvnKTMSiBxvI2hsIyEbzB6onUvXmWYg3DRhV/GwAnE+zZfV5Bcwmpd57jMtKgr
         ADAGyQc+DjDrps3fgS78ZWj65cDZRIkTRR624iDK9xaytlPQeiB18oOi+KFdq9XeuQNv
         Brw5KV6eB3JCHIHTKbLwJgw2cNqKC+JU4qwVpXykZlr/yDQubI3uBhVOvGpVDHOx2GvY
         444EaqQEt8f4ov4f640bHudqEoJ7FQ3hCDs6g/HIddHx4Ht0/GVFi/sMh9oan5fVER+D
         6+5w==
X-Forwarded-Encrypted: i=1; AJvYcCX+1S5n3vlhDhA2DmXWjGLIRwn9Yr0LCT1iRKEIFIbrykuf4Tm+h9rG5qa0KLzQG1i3qgY5IcQEL54cbIbIkCsP3dSwsFzCgIBNUdA7barc
X-Gm-Message-State: AOJu0YykaWHOWeLxV1iBo4/0gg+LJeRyQ3cEklDIlKO+QD4dI5jGEHJi
	MmqOOju03oLb6VRdB+pKZsweakZp9Sya2DMf4H5hMgkvv4WcLjAxHZlKMS+hj1LIk8iRsQWsuid
	yb0KVt9akTrE5OfKYWR+b5vjBMwcL4EirOWM5yn28mV0V+OgZ7YrBTCY=
X-Google-Smtp-Source: AGHT+IGHBVsv9Dz2Z/gK9xwPg1kuhfJK/UtcoDbP1/CMXnGenTAMkT/INK5C78l/BSa/rdhCPKtYXg9zvKNYxAAJoRnQoikCAzEY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a7:b0:4b7:b3fc:6bdb with SMTP id
 8926c6da1cb9f-4b7b3fc7f03mr41571173.4.1717740153895; Thu, 06 Jun 2024
 23:02:33 -0700 (PDT)
Date: Thu, 06 Jun 2024 23:02:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0906d061a468b93@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc8ed4d0a848 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158b9cf2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15236f14980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1200d314980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4cc470367bc/disk-cc8ed4d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/614492e3b597/vmlinux-cc8ed4d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fde890f9e46d/bzImage-cc8ed4d0.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113ad9ba980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133ad9ba980000
console output: https://syzkaller.appspot.com/x/log.txt?x=153ad9ba980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002e: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000170-0x0000000000000177]
CPU: 1 PID: 53 Comm: kworker/u9:0 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_publish_rx_avail net/bluetooth/l2cap_sock.c:1137 [inline]
RIP: 0010:l2cap_sock_recv_cb+0x1af/0x4f0 net/bluetooth/l2cap_sock.c:1509
Code: 80 3c 07 00 74 08 4c 89 ef e8 dd dd 7b f7 4d 8b 7d 00 49 8d bf 74 01 00 00 48 89 f8 48 c1 e8 03 49 bd 00 00 00 00 00 fc ff df <42> 0f b6 04 28 84 c0 0f 85 b5 02 00 00 41 8b 9f 74 01 00 00 49 81
RSP: 0018:ffffc90000bd7468 EFLAGS: 00010207
RAX: 000000000000002e RBX: ffff88801f6cc000 RCX: ffff888016398000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000174
RBP: ffff88801f6cd000 R08: ffffffff89459100 R09: 1ffff11003ed980c
R10: dffffc0000000000 R11: ffffed1003ed980d R12: 1ffff11003ed9a05
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557f1dd6c8 CR3: 000000006f77c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_publish_rx_avail net/bluetooth/l2cap_sock.c:1137 [inline]
RIP: 0010:l2cap_sock_recv_cb+0x1af/0x4f0 net/bluetooth/l2cap_sock.c:1509
Code: 80 3c 07 00 74 08 4c 89 ef e8 dd dd 7b f7 4d 8b 7d 00 49 8d bf 74 01 00 00 48 89 f8 48 c1 e8 03 49 bd 00 00 00 00 00 fc ff df <42> 0f b6 04 28 84 c0 0f 85 b5 02 00 00 41 8b 9f 74 01 00 00 49 81
RSP: 0018:ffffc90000bd7468 EFLAGS: 00010207
RAX: 000000000000002e RBX: ffff88801f6cc000 RCX: ffff888016398000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000174
RBP: ffff88801f6cd000 R08: ffffffff89459100 R09: 1ffff11003ed980c
R10: dffffc0000000000 R11: ffffed1003ed980d R12: 1ffff11003ed9a05
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557f1dd6c8 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   4:	74 08                	je     0xe
   6:	4c 89 ef             	mov    %r13,%rdi
   9:	e8 dd dd 7b f7       	call   0xf77bddeb
   e:	4d 8b 7d 00          	mov    0x0(%r13),%r15
  12:	49 8d bf 74 01 00 00 	lea    0x174(%r15),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  27:	fc ff df
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 b5 02 00 00    	jne    0x2ec
  37:	41 8b 9f 74 01 00 00 	mov    0x174(%r15),%ebx
  3e:	49                   	rex.WB
  3f:	81                   	.byte 0x81


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
