Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFA1F0E36
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638183; cv=none; b=akeluGd3oc3T/ji3W/DwEd5lpAgCd46X4vjsmEqf4Yc3dtsvzPbPI1kna5aJ9n2ZrO6PEwdtGE2KPq0ynbD74B0TsAacaRJ0uS0QkR+xneMEcb7c07NXvHGufyR5mwB3iHhM7MmAv1cv8eZX35ZgbDi50VeVfHN0SteXIAq99DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638183; c=relaxed/simple;
	bh=DZI4WVcPWwh117K1jxc1+XXyZiuYmcpYQU4PuNS7e2o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PYSu345rR5PjSQ2q1I4Dy1BNfJN1F8azJV8Za2ZSOaOCsc4p/lMHBNoono8eBjfmC24DfkipeRFMO3AVDVCv8cfzPXn58RctOFNbmn7n8i0vhx7LE+DLQ4Fk933P0jFe/i54D/egta/aWA6ZeRABrmvyuREoC9AQRJvTSGyTxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d443811ed2so6806105ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 16:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638180; x=1744242980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14lZsOVV1x2OFnnS7998RygganwT5MPN9qdhJWT34r4=;
        b=MBs1Vlf9oL/eL1hUV8mrlRooo27ypA+DC8WlRB5Ty7puCqyuMPlXQvN4f+ONclG8WF
         gEhG3N9z8KcGlkfd4kOrH+wNPAjbr29jDk4gR0xro16dxH0xB5U2Pd7QwsGTsXj4I+Nc
         6zI9+P/aixSf0Effpx/SsVi4+0o4KhHuiy5fJn1udVoDCI6F79SwL4Jsbo4tDU9c2t2l
         3/5DPXv0ccQbWgE4scdw/zy7ZaZJwpIKZ+uBIDcF9X5sRnPMhSgRknRrtNg3i19nG3KU
         p01OTZVFWiNqAs0dzACq68uzbINruPJW/HxiH08KZuTPxOqergfhi9NtfAZw4ETDhTGo
         ARFQ==
X-Gm-Message-State: AOJu0YxRnaDyP+iIpyVrUnj7jGJqCbXEgGBI7yLtqvd5XjA7jPkZlfOJ
	1YbEBzSrSWOzsMIW+vN5xleS8l0uCKffE/t1tKETiOy04m4bkt4qIuaHC0DV5enqGoJSxZPuWZg
	u0ZbDkxVb8MldyLihqZvchHCgR221cGGxnrUrRcFIAn8O5pWkHV7To68ikw==
X-Google-Smtp-Source: AGHT+IFGHm2zgRUwLTKtsMO24K3IDhw/15Kv/1vZgB8hnM73J5ACYieBaXioS2220k60tgw6ouo4VHGdqjQmCqVCokRsARuAUd92
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:3d4:6dcf:d8f5 with SMTP id
 e9e14a558f8ab-3d6d547d087mr46330905ab.1.1743638180710; Wed, 02 Apr 2025
 16:56:20 -0700 (PDT)
Date: Wed, 02 Apr 2025 16:56:20 -0700
In-Reply-To: <67b0cc5b.050a0220.6f0b7.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67edcea4.050a0220.297a31.0022.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    acc4d5ff0b61 Merge tag 'net-6.15-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135a6178580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=410c49aba9aeb859
dashboard link: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ec7cf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13315274580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-acc4d5ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aad60517b1c2/vmlinux-acc4d5ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27bf64833684/bzImage-acc4d5ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 1 UID: 0 PID: 5945 Comm: syz-executor103 Not tainted 6.14.0-syzkaller-12456-gacc4d5ff0b61 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bcsp_recv+0x10a/0x17f0 drivers/bluetooth/hci_bcsp.c:590
Code: 18 48 c1 e8 03 48 01 e8 48 89 04 24 48 8d 83 78 01 00 00 48 89 44 24 28 48 c1 e8 03 48 89 44 24 08 e8 aa ca 5c f9 48 8b 04 24 <80> 38 00 0f 85 d1 12 00 00 4c 8b ab 08 01 00 00 31 ff 4c 89 ee e8
RSP: 0018:ffffc90003467bf0 EFLAGS: 00010293
RAX: dffffc0000000021 RBX: 0000000000000000 RCX: ffffffff885e756a
RDX: ffff888024910000 RSI: ffffffff885e75b6 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc90003467d88
R13: ffffc90003467d88 R14: 0000000000000001 R15: ffff88810735a800
FS:  00007ffb5ce256c0(0000) GS:ffff8880d6abb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc59fa2f98 CR3: 0000000024ec0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_uart_tty_receive+0x251/0x7e0 drivers/bluetooth/hci_ldisc.c:627
 tiocsti drivers/tty/tty_io.c:2299 [inline]
 tty_ioctl+0x57b/0x15f0 drivers/tty/tty_io.c:2716
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb5ce97899
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb5ce25168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffb5cf1b418 RCX: 00007ffb5ce97899
RDX: 0000200000000140 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007ffb5cf1b410 R08: 00007ffcd6d4fb07 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffb5cf1b41c
R13: 0000000000000010 R14: 00007ffcd6d4fa20 R15: 00007ffcd6d4fb08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bcsp_recv+0x10a/0x17f0 drivers/bluetooth/hci_bcsp.c:590
Code: 18 48 c1 e8 03 48 01 e8 48 89 04 24 48 8d 83 78 01 00 00 48 89 44 24 28 48 c1 e8 03 48 89 44 24 08 e8 aa ca 5c f9 48 8b 04 24 <80> 38 00 0f 85 d1 12 00 00 4c 8b ab 08 01 00 00 31 ff 4c 89 ee e8
RSP: 0018:ffffc90003467bf0 EFLAGS: 00010293
RAX: dffffc0000000021 RBX: 0000000000000000 RCX: ffffffff885e756a
RDX: ffff888024910000 RSI: ffffffff885e75b6 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc90003467d88
R13: ffffc90003467d88 R14: 0000000000000001 R15: ffff88810735a800
FS:  00007ffb5ce256c0(0000) GS:ffff8880d6abb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc59fa2f98 CR3: 0000000024ec0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	18 48 c1             	sbb    %cl,-0x3f(%rax)
   3:	e8 03 48 01 e8       	call   0xe801480b
   8:	48 89 04 24          	mov    %rax,(%rsp)
   c:	48 8d 83 78 01 00 00 	lea    0x178(%rbx),%rax
  13:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  21:	e8 aa ca 5c f9       	call   0xf95ccad0
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	80 38 00             	cmpb   $0x0,(%rax) <-- trapping instruction
  2d:	0f 85 d1 12 00 00    	jne    0x1304
  33:	4c 8b ab 08 01 00 00 	mov    0x108(%rbx),%r13
  3a:	31 ff                	xor    %edi,%edi
  3c:	4c 89 ee             	mov    %r13,%rsi
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
