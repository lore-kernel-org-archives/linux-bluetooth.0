Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76219F13F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094304; cv=none; b=c3540UNs4eyTQL0TqVIFHQxfxojfH/XxCzZr0Uny4gkMPD6Zz1oo86nAcjSjXdUIKfSkBJthhfnRK1ChnTLFeB4o6tyo15LlSvIB1g9nVoRGG59byGDlVaeSmh/fMZRzWFJPJHvC5LOCAgM1WbJF6H+HZDhiTb8Ith4tzgmuVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094304; c=relaxed/simple;
	bh=6va+wkhwIco1QHZj1VVk17XoJmd99G2rmtvlnGTPN10=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gfIvHi/sjGnApkJ6N3+gQ2uzGXbceor6p2A90M5tTMxYUewWpMiWktKwj3bdTx6k4/KSmnBbtkpjrfuboyQHpTGfYrJymzqaWUYk09VmL+5kEF6XgKagpFeqdHRMwtflLyU8N7uCdVSqGr9mWfMP3DNhsxeDrO9DU9tsTwFUHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77fad574cso12696825ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 01:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094302; x=1732699102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj/krNA+0xga5ye0XvZq56f6vcX0jsGHLzgJT6onnAE=;
        b=rCiBVOIXn7bwJnLni2gYb81IVrwPU8clQzUhY8v7o1mr7fAiWLiehNUh6BbPiqFT0d
         DE7RhYuxJxeKviBFtb0IKcV7LCkVzZ7bDI9sGMNrSQX2lN1X7FiNANmJqy947IsDtuZE
         lHJESqrTq6KewK4uU/LRi3KQ+wBP0Q3Di4J4P6G5g36suX8SqEgluLyrnNgf6sfyTBKB
         5iL5cLJOFq68+KaKOwsU4zdXOeU+yeHtvPqqCu071Xr9Gr1MZ7v+KSuwnU+YbWBLUwYp
         Fs3nO1DVbf5LlJ81afaUrNDSTnGbdxklXW/77ldira2KgKdRt+AbUyWqtz73wedVXG3t
         M3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRciWZLbMUHTThiZVA7gHfkqC2HD7xB7KC9IwXjEnIa6g6IknnMZjx6XUE75wG1nx1F3zjsa2a3NcKEGli6iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqqzIh5wKzRonYjQ9GqBOzsiNXXQXiko84LXnQ5SdK8xIv7v9
	bnZ+VMbjUqVVVptGr1LjbxatmsLpm4hLafc+YPcgUA9/y/1c6dtw2ZBDgDN9fwuc+vwAe9YL2VD
	yZ4AaasfF/c0XWfE5kvr4ppwCuPMkV74NRolkBZ771kso2CRIGvOPx4o=
X-Google-Smtp-Source: AGHT+IFGhL+ZaHQjREBSS6Jq8cwAZgxvMuYLqCBTqKdlETCFNLJh9e6y7Os79E0cHEpNWDnujcHSwBSfpdhvKatD13T+9obGvNe1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a7:4826:b947 with SMTP id
 e9e14a558f8ab-3a78656fd09mr22144355ab.17.1732094302052; Wed, 20 Nov 2024
 01:18:22 -0800 (PST)
Date: Wed, 20 Nov 2024 01:18:22 -0800
In-Reply-To: <00000000000052c1d00616feca15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673da95e.050a0220.363a1b.0009.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame
From: syzbot <syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a5c93bfec0be Merge tag 'x86-mm-2024-11-18' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1378475f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b5cb37a5a4eda10
dashboard link: https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12694ae8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70daf24cbd5f/disk-a5c93bfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/43d73b55bde3/vmlinux-a5c93bfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1742639611a8/bzImage-a5c93bfe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com

Bluetooth: hci0: Opcode 0x0c03 failed: -112
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11474 at kernel/workqueue.c:2257 __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 11474 Comm: syz.3.1469 Not tainted 6.12.0-syzkaller-01518-ga5c93bfec0be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 8f 55 98 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 70 79 36 00 85 db 75 60 e8 27 77 36 00 90 <0f> 0b 90 e9 f9 f7 ff ff e8 19 77 36 00 90 0f 0b 90 e9 a8 f7 ff ff
RSP: 0018:ffffc9000b2b7bf8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff815719b0
RDX: ffff88802b422440 RSI: ffffffff815719b9 RDI: 0000000000000005
RBP: ffff8880360a8a80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8880123d3000 R15: ffff8880123d3000
FS:  00007f22bc8606c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38a17baf98 CR3: 000000006114e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 hci_recv_frame+0x23f/0x7e0 net/bluetooth/hci_core.c:2946
 vhci_get_user drivers/bluetooth/hci_vhci.c:511 [inline]
 vhci_write+0x385/0x470 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22bb97d23f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 8d 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 1c 8e 02 00 48
RSP: 002b:00007f22bc860000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f22bbb35f80 RCX: 00007f22bb97d23f
RDX: 0000000000000007 RSI: 0000000020000000 RDI: 00000000000000ca
RBP: 00007f22bb9f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f22bbb35f80 R15: 00007ffc1b246d58
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
