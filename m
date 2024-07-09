Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5284142E7C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510465; cv=none; b=uRLkeT2BWv+5+0DJvRxEiUw3zbre9Gm/zeGzJ6b6LB7ldXnCshLn0GGaDgJ4NYhc9G1FsiZvtIRVrKlWAHXwmX/jGeG4/NCsesHrVR+kLV6f+pXRr0gvuGqiq5nIveDo9scp2VSypsQrPu7jAmVCfTM67lLfzb7oF1xk98vNNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510465; c=relaxed/simple;
	bh=4hxmwXyCUESMlQ9wT1HjK4hk6LZ5RJQq4cZCuIXAh48=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OfEap8+gs54uC2HEDYbPg8UR7RIx9tRrBkgyZTEr+VCL6heN16Za3VyGphaDt3tFZxW9Nsd2hRC3tGD4Y9QHuepo0pnPpgbbdrJHfvu7c/H79Im9VPcEgWTQJXNn/TDN5Wl+IvxgU6LMtjrdhfTOM3KwEUmjotbFjg3mGf/oJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-381a6b62ab6so54599255ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 00:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510463; x=1721115263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALjQGdbNHVaPJ1ynC8GfH+CoSsrbpmUoa8b0ZipILqc=;
        b=ChoHWgrrj0blnQkyjt+yK+Wf9pqXJEd3EX8xegUo18B+ZYYXoUp1vPHVNpxqnD/Z2Y
         wEkqEqyI14Gl8CU4kBX9uU4mtZJB122R3/5OWI/54Ig/EhWOxhGDrhj882tlj2/W0/pR
         rP7ZI/c81WxmHft/1QPAlMOICwtQOPLotK0YRuliWJ0Llb1ufWfiSZ/hB9TpXX20EJ1o
         O0k7vaLQxyM7CPamZTGSqKDvxJhYnwRIcxRgr40gneJcCmhdfDkchxj7ReZQj6vkPFmT
         ZWpaIONn16IbuR3J/QV49iKd1sUNNmuw35E3rWtzGQ0uGpHtycGFjngVqPWCwnGNyjZi
         D7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVyieXMsMIfSsDoiSBWHD+HlwP856M7raAZt59LadLvNS2V28sFyAVsODXoTSxYFB4tNPCwm1OeYvSYrGtlLCmM7yffBGN8uz0m0H1KorXr
X-Gm-Message-State: AOJu0YyTf1YWeC2oXFUTwxK8MI3pWNhMhKq8xfAnSI9F3he14JxIAkEW
	+KVTsqI/95oMJBE4RIAncz6BIT4ec+QEuWXXZ18ksgXeYbQKqRWZBNAkShlStJP8mY1R/riI0lr
	OIU8B4zQqVI93iTX1neI037oXqSl/r14+eLJCcXW7fo8504ukOu6QcrM=
X-Google-Smtp-Source: AGHT+IFOzh4mDnzJn5EChuu9V2MaOZcz7A43/i/YlVSgfTsAD4DOI//cfxhgTWGsLI1puc/9Ewy/ntfDUmsqfvol+A2sz/7nYFgZ
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da4a:0:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-38a59aaf125mr208645ab.5.1720510462971; Tue, 09 Jul 2024
 00:34:22 -0700 (PDT)
Date: Tue, 09 Jul 2024 00:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa6583061ccb8e3d@google.com>
Subject: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    256abd8e550c Linux 6.10-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e81031980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=f52b6db1fe57bfb08d49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b52809e32ca/disk-256abd8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c71e8f0eab4/vmlinux-256abd8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdcc77cd0018/bzImage-256abd8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16659 at kernel/workqueue.c:2282 __queue_work+0xc5e/0xee0 kernel/workqueue.c:2281
Modules linked in:
CPU: 0 PID: 16659 Comm: syz-executor Not tainted 6.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__queue_work+0xc5e/0xee0 kernel/workqueue.c:2281
Code: ff e8 76 83 36 00 90 0f 0b 90 e9 20 fd ff ff e8 68 83 36 00 eb 13 e8 61 83 36 00 eb 0c e8 5a 83 36 00 eb 05 e8 53 83 36 00 90 <0f> 0b 90 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000ecef810 EFLAGS: 00010093
RAX: ffffffff815fa35f RBX: ffff888061d45a00 RCX: ffff888061d45a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815f9833 R09: 0000000000000000
R10: ffffc9000ecef8e0 R11: fffff52001d9df1d R12: ffff8880648631c0
R13: dffffc0000000000 R14: ffff888064863000 R15: 0000000000000008
FS:  000055555f45a500(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f755bb04030 CR3: 0000000052a18000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2411
 queue_work include/linux/workqueue.h:621 [inline]
 hci_cmd_sync_run net/bluetooth/hci_sync.c:145 [inline]
 __hci_cmd_sync_sk+0x7b1/0x1130 net/bluetooth/hci_sync.c:167
 __hci_cmd_sync_status_sk net/bluetooth/hci_sync.c:252 [inline]
 __hci_cmd_sync_status+0x37/0x130 net/bluetooth/hci_sync.c:278
 hci_dev_cmd+0x51c/0xa50 net/bluetooth/hci_core.c:747
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a54b757db
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffee9a9ba60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3a54b757db
RDX: 00007ffee9a9bad8 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 000055555f45a4a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000005 R15: 0000000000000009
 </TASK>


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
