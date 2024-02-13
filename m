Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262560863
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842183; cv=none; b=BxNx7xZ0TB+EcZ2F5dhMTkgSoalGuF6YxAlzdvh9V0xiNXj6DvqZHmUH5WFz4BdmMMJGXnKoYkhFmvqrPQP8wBwvrvD0lNAccnQrdkTGFZDeUx5yW21mB6QebmUSSXVE5CBmifvxsP3Ruc+Fn9lox6nUGdgrqEpySsreINBoDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842183; c=relaxed/simple;
	bh=2FDm3ttAF0cplLL3xuu7VVfpvDdVrElFHxLmSsDqqZI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fEXfXqmx3gD/eEvDf3hZwYy8P7g2we9rAg3fBbTeE2cxd1D+wP9M6l469eLF56XjKc+F92t8mz0ZEwKF2bY9UNIH2mQmdpffe+ua2TLX55vo4cowDm7KR01txWvh5FYr3pPPJDeJSrP8fqbEzKy3BVh2iF0kgdEPNKCmd+pUmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-364278061caso2680045ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 08:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842180; x=1708446980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vk7mpNCOBboHCDQYxJlsoWwjVXjMoh9NU/9wY7/dKk=;
        b=dT1mFf3iJ1poxxYgjmXaaqmjb5Lnj2OqCMxcnTNDV4tzE6beuHVo7T14CXEMWFLUE+
         O5Z4E2z7iw4M8GXPQJxe5x7GKq8JG8u9l3XgSq0yFimgvkPdxLslimO6/tX5ToFYlGMH
         Y3iQD6UEGUqMWJbVXAk8nq/U4CuXoqVNJF3fR8f0EF5k2uUnpj8Qm7Rmozag+1PtbLQk
         ckAis06WrdFj0DUr1/CZmVYfR1byS2sieWKDLlHolP989QoQ+5V7lzBkQXk5WWvRzoy7
         Hd354MKX8iteyYjghIhqTdC6+rxxZpCwd2RVuSbP3g2QMJypW3K31r+YV0K/8/vJnZzF
         JZvw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4biSEdinD4GmICDrfGagdW+tKNdEGpjdzQPwKRrtPeNk1GvevI3QNVhMsNmen3cikv4DQ26UwvBZ4ps2roYqptkYWEeNMUoYnnI0//0D
X-Gm-Message-State: AOJu0YzyaiodNcE0drzjA73gloDo4kcEOA2ZPSyFOjhWf63E2Cd15s4y
	AnXlqazDfOCPW+M23dPrb93EAdxk9E83wljcYm8TgUYB7pVbeQDPXxVHHBvj+xXaugHKOvBlv4r
	lNS4pq68UMYluyFkMsJOjtq1+oERc9a+4kWBGzLNYdiRFDNYVCBEbhSA=
X-Google-Smtp-Source: AGHT+IExRt3NPNZEA81vxIQyi9XfG2G8Xln8xogu3HtHAuKgzewyAotq1FLjb94OdUXTpaZlSiNjbcErGK6SONYK4joREAAjFPgy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8a:b0:363:b9d6:1261 with SMTP id
 h10-20020a056e021b8a00b00363b9d61261mr5257ili.0.1707842180788; Tue, 13 Feb
 2024 08:36:20 -0800 (PST)
Date: Tue, 13 Feb 2024 08:36:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084b931061145fe46@google.com>
Subject: [syzbot] [bluetooth?] WARNING in ida_free (2)
From: syzbot <syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ebd7f4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=dfab1425afcdae5ac970
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f832cc180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ee7970180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c664e16b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c838390fdb6c/vmlinux-c664e16b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d25123cb1896/bzImage-c664e16b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 0 PID: 5169 at lib/idr.c:525 ida_free+0x1fb/0x2f0 lib/idr.c:525
Modules linked in:
CPU: 0 PID: 5169 Comm: syz-executor420 Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ida_free+0x1fb/0x2f0 lib/idr.c:525
Code: dc f6 41 83 fe 3e 76 73 e8 82 95 dc f6 48 8b 7c 24 28 4c 89 ee e8 55 8f 18 00 90 48 c7 c7 00 7c 5b 8c 89 ee e8 46 ba a0 f6 90 <0f> 0b 90 90 e8 5c 95 dc f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90003007a48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92000600f4a RCX: ffffffff814f7499
RDX: ffff88801ccac800 RSI: ffffffff814f74a6 RDI: 0000000000000001
RBP: 0000000000002000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000293 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcad7713f08 CR3: 0000000027a24000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x795/0xe20 net/bluetooth/hci_conn.c:1188
 hci_conn_hash_flush+0x18f/0x260 net/bluetooth/hci_conn.c:2646
 hci_dev_close_sync+0x59b/0x1160 net/bluetooth/hci_sync.c:4954
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_unregister_dev+0x1eb/0x600 net/bluetooth/hci_core.c:2739
 vhci_release+0x7f/0x100 drivers/bluetooth/hci_vhci.c:674
 __fput+0x270/0xb80 fs/file_table.c:376
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fcad76bb449
Code: Unable to access opcode bytes at 0x7fcad76bb41f.
RSP: 002b:00007ffcea444888 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcad76bb449
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fcad77472b0 R08: ffffffffffffffb0 R09: 000000ff00ff3650
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcad77472b0
R13: 0000000000000000 R14: 00007fcad7747d00 R15: 00007fcad7689500
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
