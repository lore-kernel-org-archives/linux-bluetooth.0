Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704261840
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EDFE1
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Nov 2023 19:34:26 -0800 (PST)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-280740f54b9so3136715a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Nov 2023 19:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699760066; x=1700364866;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2f5ScLJAEvnJMDm6oJ0ERRf2feGzJjFlJSgZ1oCFY7U=;
        b=RnJz+Y88ekFxBxjZUjACreuo5LRPboDtQJ7S3PRdA6btPkTYxgVOfX/1zrGJUkObKn
         4cLSh4a+ioHEbmKYMpIgM2aXqUQSoU0m5e5hqmnckSVh+laGa2p8D1mIThCz6K7AePar
         znMdyMS1pnKC8Hbz14+oHSNYnePN+PZnguOJJGNjS78xqoYAQhypk45RI1MkeKKZe4I3
         4WpQpzJ4OkXDD7PuMdNuJdZAA9YAio/9EejP8lUS8FVIb4sw6ZgG2QcwugIf4Yu92pZO
         WGKohAwmQZkjGlDaNjqg9ZAVxKBMLuEzARWNYS2cGmm0y6v6svroJ8qCz6DUv6xfVFKT
         mx1A==
X-Gm-Message-State: AOJu0YwlcU25LET/7chEJKPsIWJOym/EPQ0nFBZwEUKAPuXwkSmdvvc6
	TllKLNiej9nVvv3LdIDwYHpv90dmiiRp6VAVph87Kfb3Seyz
X-Google-Smtp-Source: AGHT+IHY0BX2h6aJBCjFb48TsaA6QAG3M4cXJlyiMrXYsKB5hwmybwLmJtbHp7g1TS3mE/q30Wa0wOqXyUtrSGaxxZ4e+5BIyhN5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4f06:b0:27d:d8a:a4d2 with SMTP id
 p6-20020a17090a4f0600b0027d0d8aa4d2mr832077pjh.7.1699760066320; Sat, 11 Nov
 2023 19:34:26 -0800 (PST)
Date: Sat, 11 Nov 2023 19:34:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4e4770609ec3a8f@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_acl (2)
From: syzbot <syzbot+298932bae5cf3522b729@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=100bd0df680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=298932bae5cf3522b729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+298932bae5cf3522b729@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15263 at kernel/workqueue.c:1725 current_wq_worker kernel/workqueue_internal.h:69 [inline]
WARNING: CPU: 0 PID: 15263 at kernel/workqueue.c:1725 is_chained_work kernel/workqueue.c:1663 [inline]
WARNING: CPU: 0 PID: 15263 at kernel/workqueue.c:1725 __queue_work+0xe14/0x1338 kernel/workqueue.c:1724
Modules linked in:
CPU: 0 PID: 15263 Comm: syz-executor.3 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe14/0x1338 kernel/workqueue_internal.h:69
lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
lr : is_chained_work kernel/workqueue.c:1663 [inline]
lr : __queue_work+0xe14/0x1338 kernel/workqueue.c:1724
sp : ffff8000998a7410
x29: ffff8000998a7450 x28: 1fffe0001a720c92 x27: ffff0000d459c9c0
x26: dfff800000000000 x25: ffff0000d459c800 x24: 0000000000000008
x23: 0000000000000000 x22: ffff0000ccde0000 x21: 0000000000000000
x20: 0000000000400140 x19: ffff0000d12e4da0 x18: ffff8000998a7400
x17: ffff800080a9cd40 x16: ffff80008a71b23c x15: 0000000000000001
x14: 1fffe0001a25c9b4 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 0000000000001a0a x9 : ffff80009880e000
x8 : 0000000000001a0b x7 : ffff800089878008 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008022056c
x2 : ffff0000d12e4da0 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 current_wq_worker kernel/workqueue_internal.h:69 [inline]
 is_chained_work kernel/workqueue.c:1663 [inline]
 __queue_work+0xe14/0x1338 kernel/workqueue.c:1724
 queue_work_on+0x9c/0x128 kernel/workqueue.c:1834
 queue_work include/linux/workqueue.h:554 [inline]
 hci_send_acl+0x904/0xc48 net/bluetooth/hci_core.c:3237
 l2cap_do_send+0x238/0x350
 l2cap_chan_send+0x190c/0x1e5c
 l2cap_sock_sendmsg+0x184/0x2a8 net/bluetooth/l2cap_sock.c:1154
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x2d8/0x448 net/socket.c:1158
 do_iter_write+0x65c/0xaa8 fs/read_write.c:860
 vfs_writev fs/read_write.c:933 [inline]
 do_writev+0x220/0x3ec fs/read_write.c:976
 __do_sys_writev fs/read_write.c:1049 [inline]
 __se_sys_writev fs/read_write.c:1046 [inline]
 __arm64_sys_writev+0x80/0x94 fs/read_write.c:1046
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 364
hardirqs last  enabled at (363): [<ffff8000801d1cd8>] __local_bh_enable_ip+0x24c/0x4ac kernel/softirq.c:386
hardirqs last disabled at (364): [<ffff800080220558>] queue_work_on+0x50/0x128 kernel/workqueue.c:1831
softirqs last  enabled at (362): [<ffff8000898784b4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (362): [<ffff8000898784b4>] hci_queue_acl net/bluetooth/hci_core.c:3225 [inline]
softirqs last  enabled at (362): [<ffff8000898784b4>] hci_send_acl+0x870/0xc48 net/bluetooth/hci_core.c:3235
softirqs last disabled at (360): [<ffff800089878008>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (360): [<ffff800089878008>] hci_queue_acl net/bluetooth/hci_core.c:3208 [inline]
softirqs last disabled at (360): [<ffff800089878008>] hci_send_acl+0x3c4/0xc48 net/bluetooth/hci_core.c:3235
---[ end trace 0000000000000000 ]---


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
