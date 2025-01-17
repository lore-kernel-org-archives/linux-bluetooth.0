Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D801A0728
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132846; cv=none; b=MOBviF/MeV6F02KosAYJCf1swsDzxkTLhqFr6QaxT8amtqDLGHE4VB8qWHy4Mm/xxQ9FeQH9vyAtO8izp4LV1XxHf1MaBsCYuG1FAUmpowH9DfJAxRCk9enXzQdhb93Bd5YjktEJyXxje+0YB9r2WfACoUdAea+dhE/vopYEj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132846; c=relaxed/simple;
	bh=WWZrW9ZD6catxCuVZpzCgttLujJR/e8saq64gEUbrgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BsWZSySFnbmI7yXEMRjccom02fAxY7ao6ccBNwA1WZ9GMyELiHK6+woj+ChRPmfqN9aqjKerXmdLFA/VaKuQm8hq5OV4BYZEM297R5xuntf4/GW49b6camqCJqmUNHar8CYW4UAHY9LbLE9i9bwYpDFFV0kgQN+D6W7nSjusqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84cb445557aso429582539f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 08:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132843; x=1737737643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1nritLiuEs0hxKVM0C8irS4pNQDYwP5BPyDC4W6F5A=;
        b=P9+FeFtANgq4ZJgoOR9ovHGRB6Gv6RV5cKybeVpUa2Tjkdr0HUz3zDDIZlFdjXC+fI
         m+29ReRc2AOe/fs4Knx10JKKCzAueeZV6evoLyL9IMQjO3CU/zbNx2T2SuoQBlkWt+8R
         KJ4GbwlvePvdGd0iTJYHgJUXD5A/07uKyUWtzKU9eTbohjmOoI4yQfxiNRjp92P36rWx
         C33Vjbo2M6clotqoaEiAvVu1osHEiANGjaHh/sqXxxkD0zoRt9j9kDHI4qknQ/xkAa0F
         7M8Y2FG7EUT6DnVGTFa9NiYXuEnXHARs1Dybz7zH+UCtcj2rWV4q8yHboLva1xyMp00q
         ss/g==
X-Gm-Message-State: AOJu0YwTjgvINrTKmFX78k4soK+OiZzXRex9E5HgSUm2orz/BMXTs649
	5MtR7JSAUg8nCMvSmGGdNpwy1JJ14qa1cGPK5WMF1olMw9WcgeFFIvfdcndDmz0OCkSI6V1Zlg/
	j2TOz5eBf690SIDwGA8s+q97xfS003cTL38muhXHFMTJAmzTpn6UpXN4=
X-Google-Smtp-Source: AGHT+IE2Yvr+bsE2qSgAghAXJTIdFj05I9mcmiZxiVf4efIaSRu5DiNCYDeZ9iv/0OWfKS2QY7576qqidcsDPG/MtgA8knTx4zCW
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c5:b0:3ce:64a4:4c52 with SMTP id
 e9e14a558f8ab-3cf7442a393mr21716065ab.13.1737132843475; Fri, 17 Jan 2025
 08:54:03 -0800 (PST)
Date: Fri, 17 Jan 2025 08:54:03 -0800
In-Reply-To: <CABBYNZ++2=0bfK328cVaFY3_94DL0v8W7aSWW7YgrKP+L8Ax1g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a8b2b.050a0220.303755.000d.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in l2cap_send_cmd

Bluetooth: Wrong link type (-22)
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000064: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000320-0x0000000000000327]
CPU: 0 UID: 0 PID: 8403 Comm: kworker/u9:10 Not tainted 6.13.0-rc7-syzkaller-g9bffa1ad25b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: hci4 hci_rx_work

RIP: 0010:l2cap_send_cmd+0x563/0x8d0 net/bluetooth/l2cap_core.c:964
Code: fc ff df 80 3c 08 00 74 08 48 89 df e8 f6 54 42 f7 bd 22 03 00 00 48 03 2b 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 11 01 00 00 0f b6 5d 00 89 de 83 e6 40 31
RSP: 0018:ffffc9000557f378 EFLAGS: 00010202

RAX: 0000000000000064 RBX: ffff88801eb23c78 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888034724000
RBP: 0000000000000322 R08: ffffffff8ac395c4 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100f588363 R12: ffff888034724000
R13: ffff888034724010 R14: ffff88801eb22c80 R15: ffff888063932140
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b7da5c8 CR3: 000000002974a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_send_cmd+0x563/0x8d0 net/bluetooth/l2cap_core.c:964
Code: fc ff df 80 3c 08 00 74 08 48 89 df e8 f6 54 42 f7 bd 22 03 00 00 48 03 2b 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 11 01 00 00 0f b6 5d 00 89 de 83 e6 40 31
RSP: 0018:ffffc9000557f378 EFLAGS: 00010202

RAX: 0000000000000064 RBX: ffff88801eb23c78 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888034724000
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df 80 3c 08 00 74    	filds  0x7400083c(%rax)
   6:	08 48 89             	or     %cl,-0x77(%rax)
   9:	df e8                	fucomip %st(0),%st
   b:	f6 54 42 f7          	notb   -0x9(%rdx,%rax,2)
   f:	bd 22 03 00 00       	mov    $0x322,%ebp
  14:	48 03 2b             	add    (%rbx),%rbp
  17:	48 89 e8             	mov    %rbp,%rax
  1a:	48 c1 e8 03          	shr    $0x3,%rax
  1e:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  25:	fc ff df
* 28:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2c:	84 c0                	test   %al,%al
  2e:	0f 85 11 01 00 00    	jne    0x145
  34:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
  38:	89 de                	mov    %ebx,%esi
  3a:	83 e6 40             	and    $0x40,%esi
  3d:	31                   	.byte 0x31


Tested on:

commit:         9bffa1ad Merge tag 'drm-fixes-2025-01-17' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16139fc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
