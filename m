Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B485684
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b71b4b179aso308883139f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 14:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703631267; x=1704236067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/49tPwndT0MjBlfvIRwPEDmfil03+0jhTGku1dMJu0=;
        b=MYqoeDM/k0sSqx0OTKOe/s8Hq5TY003PFWf1ogvQ9wxU1C58Bd6VoMHncwcwou6toq
         PqdCMHzj5vnMu/+ISDbz1aNaoY9+y7nqLzblGRTxmYCyfs91nrgO0wyhJlh08XausyHv
         yxB3ncM/XZYEe/tVqCY7NoMxyc74Zana8toO18JFjYB0EV4/m39Tk31odaSXXn0nqqU9
         OehXwT0uOl7wWMvfknkwFYbza9d4vMHoKBN6ya/eO4IpAXNA7BVflq7UYaSfv1ZtIcgb
         9zp6IPYpxv0mNp0pP4Z+aVasDfCgvt4bMXitIF814LhNcOl7j4Fiu1CxpHNi+TF+jSgl
         tjPg==
X-Gm-Message-State: AOJu0YxvClCiY8VDWGl76K3jc5d3gexwYPd7TN7g+1mJBFyQxnH/WXii
	z001RuBP6hw/Wp+jKjD3PgFHu5j2MbcQ5de2J2YicEAZhOhQ
X-Google-Smtp-Source: AGHT+IGzMJDzPanOQOpl7sFEgQNjDsGW0Cw+M0op3qzqY2mdozbtaxFyL3a8jndaXZrXzuUcGqJF9bFr+uYer7YKzZvnh6BXYc9/
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:360:134:535e with SMTP id
 w12-20020a056e021a6c00b003600134535emr627956ilv.1.1703631267141; Tue, 26 Dec
 2023 14:54:27 -0800 (PST)
Date: Tue, 26 Dec 2023 14:54:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081a088060d7190cb@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
From: syzbot <syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15557616e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d6cd076b385aefcb6b16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14125c81e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7e8a358761e/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd1f54334d87/bzImage-fbafc3e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 6232 at kernel/workqueue.c:1722 __queue_work+0xdc6/0x11d0 kernel/workqueue.c:1721
Modules linked in:
CPU: 2 PID: 6232 Comm: syz-executor.2 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__queue_work+0xdc6/0x11d0 kernel/workqueue.c:1721
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 a3 92 87 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 e4 a6 31 00 85 db 75 56 e8 6b ab 31 00 90 <0f> 0b 90 e9 ac f8 ff ff e8 5d ab 31 00 90 0f 0b 90 e9 5b f8 ff ff
RSP: 0018:ffffc90003bf7748 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8154b90c
RDX: ffff88801bf21280 RSI: ffffffff8154b915 RDI: 0000000000000005
RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88803fe4cdf0
R13: 0000000000000000 R14: ffff8880374f3000 R15: ffff8880374f3000
FS:  000055555556e480(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000400 CR3: 000000001d1ad000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0xed/0x110 kernel/workqueue.c:1831
 l2cap_do_send+0x318/0x470 net/bluetooth/l2cap_core.c:1015
 l2cap_chan_send+0xb7d/0x2ae0 net/bluetooth/l2cap_core.c:2726
 l2cap_sock_sendmsg+0x218/0x2e0 net/bluetooth/l2cap_sock.c:1154
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x2ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa77e47cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc101fb238 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fa77e59bf80 RCX: 00007fa77e47cce9
RDX: 0000000000000735 RSI: 0000000020000b80 RDI: 0000000000000004
RBP: 00007fa77e4c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000024044840 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000bf7 R14: 00007fa77e59bf80 R15: 00007fa77e59bf80
 </TASK>


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
