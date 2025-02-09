Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEA1DC9A8
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739115921; cv=none; b=ZneF8V89X/hlAiv4L0jBI6YrH9TBLZDutG9P1QwURzYcloDUAQkLvnkcfhp3hreqGzM5oFUKtdB3AucNSauiaiWXxOhhnoGdE4SmLd1V7Kv0SNGM8sYxctbQOVI5n5Wu7z+B/ayxx/megsQ7nyfoP8sdG30fZS15BCQvyM91b8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739115921; c=relaxed/simple;
	bh=+SH0U04r0tpMMW8rQnkJLNcxI7jq3YbVkyqic8W6Mws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lAnHSegiFUZX5ucQ3wzNvhM3GKKUe/GdC6XP7H1KGXbZoCTZTBLuOCUL79bZOu51HQOzex0XGzTMqKeRRtMSTBneGha5Phx+28JxYPQ7uC/g0TWpC3n6Lz2gjnX5p4hpVkpk7oTxAas8VRYiU1scEOaGbWgjuSFt3fEN516wjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso74203775ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2025 07:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739115919; x=1739720719;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLzOMWLy/MOLX9VEUQNUbF89kIoT+fmm9AVwG76J8UA=;
        b=ZfAsqD+Oj+qkkpo2bmjBjLnVaSEwnYX16qvZ+Rrg4/oxmnzBgWYWH+ybZVPAwNonvk
         HCptVs6jneaEBAiWdCp5fCWhsG4nakBHjh9Jh7Q7Iv7t3LRw1kz0D4cE3UDrdu3XHP0p
         F2YrSUmfPrwGZ/MrR8zc/y4xF3qAIkvIp/gdNTZCY7p3JyyFp/7zCBmt/uOfowQaChQU
         GvOGcVH1wrTZjwxE6DkccGWkXG4AuO1/1QR0v2FMVskV6ht6bz7hW87bBJQbGX266xwF
         1Kv/nSo3t9Q0Jle1GZ1wL83dU+nkfajLYaHce65NyuxY3FjyufPXMnuJauf5BkzJAd15
         NiFw==
X-Gm-Message-State: AOJu0YzvpGiTxtldZfuh68EnfIp96ALAvP951asDlTxR7zpU8v6RzswI
	WIcWePfMwLUqi+GBbPpplLL0poWAD+fdbOhDH8ZFiVneGRV4sPMkqCYUqFus7Z5c3sIr3hj+HYl
	SRII+wa0W11Pe3VVgxUy2LyIcGBVnlR53AbUlkMRFufFSwAeKrg2vTv4Y5A==
X-Google-Smtp-Source: AGHT+IHHHgELAIyLEEZ3lVkCutpyk8siwMTX3DyIpioxphCJVRcq5t91FAg7VxfGFkTsnRnsv5W+SOm03IGRSP2eyzDDWEqhuKI8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:3d0:11ff:a782 with SMTP id
 e9e14a558f8ab-3d13dd447d5mr79163175ab.9.1739115919335; Sun, 09 Feb 2025
 07:45:19 -0800 (PST)
Date: Sun, 09 Feb 2025 07:45:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a8cd8f.050a0220.3d72c.003f.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in h5_recv
From: syzbot <syzbot+b5691bb559396b262064@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed58d103e6da Add linux-next specific files for 20250207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d782a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=244a34ec1429746
dashboard link: https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f2bdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce459b7174dd/disk-ed58d103.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60699733c0c8/vmlinux-ed58d103.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f589bce7c898/bzImage-ed58d103.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5691bb559396b262064@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000005f: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000002f8-0x00000000000002ff]
CPU: 1 UID: 0 PID: 9956 Comm: syz.2.1414 Not tainted 6.14.0-rc1-next-20250207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:h5_recv+0x153/0x940 drivers/bluetooth/hci_h5.c:572
Code: 08 01 44 8b 64 24 04 48 8b 5c 24 08 4c 8b 74 24 18 49 ff c7 41 ff cc 45 85 e4 0f 8e 55 06 00 00 e8 e2 f5 f5 f8 48 8b 44 24 30 <42> 80 3c 28 00 74 08 48 89 df e8 be d1 5c f9 48 8b 1b 31 ff 48 89
RSP: 0000:ffffc90004cafc60 EFLAGS: 00010202
RAX: 000000000000005f RBX: 00000000000002f8 RCX: 0000000000000061
RDX: ffff888033690000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004cafd70 R08: ffffffff88c9927e R09: 1ffff110048c0403
R10: dffffc0000000000 R11: ffffffff88c991c0 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888024602000 R15: ffffc90004cafe00
FS:  00007f50a01cf6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000040000001f000 CR3: 0000000028c32000 CR4: 00000000003526f0
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
RIP: 0033:0x7f509f38cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50a01cf038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f509f5a6080 RCX: 00007f509f38cde9
RDX: 0000400000000180 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 00007f509f40e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f509f5a6080 R15: 00007ffed807d2a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:h5_recv+0x153/0x940 drivers/bluetooth/hci_h5.c:572
Code: 08 01 44 8b 64 24 04 48 8b 5c 24 08 4c 8b 74 24 18 49 ff c7 41 ff cc 45 85 e4 0f 8e 55 06 00 00 e8 e2 f5 f5 f8 48 8b 44 24 30 <42> 80 3c 28 00 74 08 48 89 df e8 be d1 5c f9 48 8b 1b 31 ff 48 89
RSP: 0000:ffffc90004cafc60 EFLAGS: 00010202
RAX: 000000000000005f RBX: 00000000000002f8 RCX: 0000000000000061
RDX: ffff888033690000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004cafd70 R08: ffffffff88c9927e R09: 1ffff110048c0403
R10: dffffc0000000000 R11: ffffffff88c991c0 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888024602000 R15: ffffc90004cafe00
FS:  00007f50a01cf6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000028c32000 CR4: 00000000003526f0
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
  20:	e8 e2 f5 f5 f8       	call   0xf8f5f607
  25:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 be d1 5c f9       	call   0xf95cd1f7
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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
