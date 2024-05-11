Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FD12E6D
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391034; cv=none; b=P5vkOL1sYVIsCo24ZzvCGUs/if4vCWCX8ddzZBIdMWiznWdDnCoRNttqu6i84O3zorOac5BzToV4MpFeKy4xjOugoE/JNzS+iBD2nnL+vmzNOZ34w6sMboEdbFOaQOE/gNAoV6Uu0tU6///BJMNCdb/3LY+C0c5ZrngCcdrSVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391034; c=relaxed/simple;
	bh=/NzO4UlNFsjUHtR7jv4ftpKn0qIqx6mFKxkUp1R4yUY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tAQ54ha5WldLM3ofBj5V6gApumeXFA53MKo6WvGmJQqZCf6PVxe7a1I25L+NghbToqpKqYDoPxROYJIjPr5nCO0sWXH/BSueJ8754z+0bdPK6/DyTKXrqyd9cCdOmZ5/9bPb7iUo+7BRSQ9Oxb2IPht6aZrgnnc2O08glNZp9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1b80d4004so144705739f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 18:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715391032; x=1715995832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rO41aFDTMkky0tLm4R2rtubdXnkNc+OLIH0Zd0ZRJ28=;
        b=vOckWT2A/GbwXi/Y9+ymJ2SbVqzlb5sdpi5RgXdxFjfpaJhoLTOlOrh0HpjMvizJsw
         T5fs+BqjMCAqthL56jtPKihRLesCpnMTZE0uGfnXVsDRcq9KdBhiXyHPhic24YGqyF5Q
         XGKZvdzNfR1gYefX9iWWhYsFejNoeDhOCGz0sZsbNKjXk0CtvwV2n9hs1DdmTUtdQlv0
         tKR9VE06QGks1qojYe6YqpxG1TF5Sej9sMDBkoIKXBLsfgtXC3+iR38Hb5ti5irFgPyJ
         P92vQ9mDaOpq8j7twRTYuoOp0awlqWviQYFN8kUk90bLIc8fxD0H29KgUIazcwgZGq8n
         iapQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhew0p923qzz2rpqD0Eq4WoFJlSVgO0LtaQD4JVRKHV1MTI1rZV0EJCWLQ4jmUYnV6JISbESO+4nr4Qr9JwWVO6zYyEGvE7VYITvnGKy3H
X-Gm-Message-State: AOJu0YwVghw2kUEpoVc8lvaipLLMnyHDsGoQOjakomSoKgiQp/xnbfVY
	eDsj4+8w5DqI/Dfp6/pSGyQZwrQNAnZ6zNHERuQGYbgTly5dsjR85foCoW5PmZB21bXz6Dp7tz5
	4dzJqqbA6Kw/YA9Z6uIQhhqOi4b9aFUthV+TUOngGLbZz4AH5Ffn1vA0=
X-Google-Smtp-Source: AGHT+IHd5uc9NH9sDg2gbbjWb+wc7G5tZ/rMrcZyrdK/tQfw3//ErVdE41NAEr5MM6IiUPE6brE+KqSKkqF4q1FAofaVUycOA1Ed
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr283597173.3.1715391030481; Fri, 10 May 2024
 18:30:30 -0700 (PDT)
Date: Fri, 10 May 2024 18:30:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005ea3206182399ea@google.com>
Subject: [syzbot] [bluetooth?] WARNING in sco_chan_del
From: syzbot <syzbot+85e9ce7008aa4afb189e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16caf2d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=85e9ce7008aa4afb189e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ee5b455b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96e27f6a83fe/vmlinux-ee5b455b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49d89ce985f7/bzImage-ee5b455b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85e9ce7008aa4afb189e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 8103 at kernel/workqueue.c:2335 __queue_work+0xc13/0x1020 kernel/workqueue.c:2334
Modules linked in:
CPU: 2 PID: 8103 Comm: syz-executor.0 Not tainted 6.9.0-rc7-syzkaller-00008-gee5b455b0ada #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__queue_work+0xc13/0x1020 kernel/workqueue.c:2334
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 46 4b 90 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 47 f9 34 00 85 db 75 2a e8 5e fe 34 00 90 <0f> 0b 90 e9 4d f9 ff ff e8 50 fe 34 00 90 0f 0b 90 e9 fc f8 ff ff
RSP: 0018:ffffc90003d37a20 EFLAGS: 00010087
RAX: 0000000000004b93 RBX: 0000000000000000 RCX: ffffc90004461000
RDX: 0000000000040000 RSI: ffffffff8158ce92 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88802c7788c8
R13: 0000000000000008 R14: ffff88802c7788d0 R15: ffff8880291bc800
FS:  00007efff9b636c0(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5739842d58 CR3: 00000000524fc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __queue_delayed_work+0x21b/0x2e0 kernel/workqueue.c:2564
 queue_delayed_work_on+0x10e/0x130 kernel/workqueue.c:2608
 queue_delayed_work include/linux/workqueue.h:620 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1623 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1593 [inline]
 sco_chan_del+0x1f8/0x500 net/bluetooth/sco.c:171
 __sco_sock_close+0xf2/0x690 net/bluetooth/sco.c:455
 sco_sock_close net/bluetooth/sco.c:470 [inline]
 sco_sock_release+0x6f/0x2d0 net/bluetooth/sco.c:1245
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1421
 __fput+0x270/0xb80 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 get_signal+0x1ca/0x2710 kernel/signal.c:2683
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efff8e7dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efff9b630c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007efff8fabf80 RCX: 00007efff8e7dca9
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007efff8ec947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efff8fabf80 R15: 00007ffe83d40458
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
