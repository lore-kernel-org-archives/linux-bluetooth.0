Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302020B216
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519139; cv=none; b=YW0tISXn8H02OjID64se/HD99e0zNDIOyMVeeMuM8d6c1Jc+/I0LpGu+bz1nnah9GGoRr3IzEa1qiwbkHot4D72IBSOElBslkL+scDUIyATzdUEv5k/8r2P+OMUiP0OU1DRqCRHwc5xJtMBI7npiQU64foXmhbTHp+wagVnCkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519139; c=relaxed/simple;
	bh=sEj6gblOz8esU/WyI/AqE8+Bg0ZQdGvM1K3COmNDe2I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PybKD+T1ZuBMRuCIKZonXciOcXwlUu35eh3PAQSivjsKR0MNB26dvuaeIrwjKAGZPa7+ZanAdNi5UhSVoy7Cu72oHy1Y7wPSW/Qvto82UCkfpN4rFZZxECOdvmcCFVimD40cXrczU/9HqLJv9n/fRV5y+9+796RaKL61aSoZAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cca581135dso35650005ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519136; x=1737123936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTwRwTNpgJG1aRc4eqYZ9p/bEHt7DYsXYJnRTsZuKFQ=;
        b=HWWs8vSKnN83GSst41R5fefx+RlLZ+LIWat0zYv17pTodG8nzhflXnMVHYX59GgAN1
         J9YdCh3C3/bJLZ3pn6z9zhxgsO0/BXiPnaOdko+8ptC8/DJ83137QGSol2rDGAhvtYHN
         B1odD1jMx+jJdFQVXGxgifq7ZNW8f1KZPURARXoCkZ+riPnxRoc10j/qDLB/k2Lz2mXk
         h6nWQMujku/lghX+VnUZnXjXmeLW1kJuqD1uxpDAh9qnkIUG+Qbb0dTkJwsHzAcjAl+I
         2ezsHA1m6gE9pbfKWbzvxoXGISJaM6oHEx+X3Aoda7KuTOBpxlHfiyjmpqeVHuygDjec
         BslA==
X-Forwarded-Encrypted: i=1; AJvYcCXM5IhEapaWjL00GZOLBULGw1X5nvPGImjE+eOgU4Wk9hWZcZpZwiU5viUwbyp7lSeMmVftooMDprK+2Nh1Kyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQkZtVhwbTCvkrG3smrUfauFYSfVDrtvLjePb936+zAcB6WWw
	fHBjltJNW0c01PsUB4Gv69kghtV0SzSvNHqRCL9oeSvd82mzCOZw9PVD2BnsZK7Id+tWyC3luEh
	UgVrWSJEzv4U2y4dRJ9GONlCXvmR7A/MX1lZ/wHwGhbQ4BP40BL+Q9x4=
X-Google-Smtp-Source: AGHT+IGEkIpEumt9C4AF9Z7y6OTY6Xh0D8JFwO588FcOu1maTKlVPMUedeWY0MP4hjxIIsb5sTejhBZD0V4DUPgj4SC+N7zSFgo9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3891:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3ce3a9669c8mr95431055ab.21.1736519136558; Fri, 10 Jan 2025
 06:25:36 -0800 (PST)
Date: Fri, 10 Jan 2025 06:25:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812de0.050a0220.d0267.002f.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in hci_devcd_register
From: syzbot <syzbot+8f07eb2fda9f5d7721f6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56e6a3499e14 Merge tag 'trace-v6.13-rc5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153a68b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=8f07eb2fda9f5d7721f6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/565d8b4108b2/disk-56e6a349.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e85ad690a360/vmlinux-56e6a349.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6c6b9944a99/bzImage-56e6a349.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f07eb2fda9f5d7721f6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 1 UID: 0 PID: 13691 Comm: syz.8.2770 Not tainted 6.13.0-rc5-syzkaller-00006-g56e6a3499e14 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0x151/0xa60 kernel/locking/mutex.c:735
Code: d0 7c 08 84 d2 0f 85 d5 06 00 00 8b 35 b8 51 1f 0f 85 f6 75 29 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 bd 06 00 00 48 3b 5b 60 0f 85 ad 01 00 00 bf 01
RSP: 0018:ffffc90003187a80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 1ffffffff3476314
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000070
RBP: ffffc90003187bc0 R08: ffffffff8a2adaa7 R09: 0000000000000006
R10: ffffc90003187bd8 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffffc90003187b00
FS:  00007fb831e4b6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f4eeff8 CR3: 000000006a8c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_devcd_register+0x47/0x170 net/bluetooth/coredump.c:415
 force_devcd_write+0x175/0x350 drivers/bluetooth/hci_vhci.c:346
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb830f85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb831e4b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb831175fa0 RCX: 00007fb830f85d29
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb831001b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb831175fa0 R15: 00007fffe9a97e58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0x151/0xa60 kernel/locking/mutex.c:735
Code: d0 7c 08 84 d2 0f 85 d5 06 00 00 8b 35 b8 51 1f 0f 85 f6 75 29 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 bd 06 00 00 48 3b 5b 60 0f 85 ad 01 00 00 bf 01
RSP: 0018:ffffc90003187a80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 1ffffffff3476314
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000070
RBP: ffffc90003187bc0 R08: ffffffff8a2adaa7 R09: 0000000000000006
R10: ffffc90003187bd8 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffffc90003187b00
FS:  00007fb831e4b6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f4eeff8 CR3: 000000006a8c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	7c 08                	jl     0xa
   2:	84 d2                	test   %dl,%dl
   4:	0f 85 d5 06 00 00    	jne    0x6df
   a:	8b 35 b8 51 1f 0f    	mov    0xf1f51b8(%rip),%esi        # 0xf1f51c8
  10:	85 f6                	test   %esi,%esi
  12:	75 29                	jne    0x3d
  14:	48 8d 7b 60          	lea    0x60(%rbx),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 bd 06 00 00    	jne    0x6f0
  33:	48 3b 5b 60          	cmp    0x60(%rbx),%rbx
  37:	0f 85 ad 01 00 00    	jne    0x1ea
  3d:	bf                   	.byte 0xbf
  3e:	01                   	.byte 0x1


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
