Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9C1C691
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688528; cv=none; b=HWF4d5BwqxX4uGNzd4yVXljP7A08TU+dsElR4a+cmUsd6D3w60rxny1OiUsDiDRIdrIETKqvs8cgXjj+oYezsH4NEwVgJXnpk2TzXG17KigYWUvtyYJ7QGwtRw/OsgM+yiO5IiTdAbpf507oq26+R9GTr0ZaaPKZmP22pms0ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688528; c=relaxed/simple;
	bh=JNMyT6Pp9T/AN28IGslHtW/8uUWOtjEo+0vtv76E6ok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R/ScU77aNA3XD+ud6u/Ckfq8PGDBgFwXzAsqhjS3+90uHn9kKNLJT67F3O4KY9zG/iuOm5v6jM8bPBXYHo5BMfxjFWEZ0b2hMhOjVieNGe6yBRFgmePGC/o3Si+pwpTvDpm496J/z8DkmEdf743j+YJ0ox0rJoyY6KQITWjn4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso186330239f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 08:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688525; x=1711293325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4MegSmNgbP67cM4Eg9+6Ly/Lj6iOzU/s39gtIU5YNA=;
        b=oPa5IrYuEBE1gPMbn47C3mQdORsbyfvW3xMWlSWxiPejQfUgZpSA0WjJwq9HxSIr2S
         krszPJzbMtel9+KF7JIPSBOfpSYa9gruEAn91bkZuEbpfdVTPNJT0ZCtGqcQyUxjX/Pr
         M8oBRDj7v2Kp7BiMkmknlc+D9C5PgmxBIHl0GE+D7gq15ekHrOGzCNot8yNk6PKmLtYr
         ZQQMbAi6l4jHaCtlNjEZSFE2TQ0iydUpDUA6SrSI+xCC0Z/6GNQEJf8yBKrfePfKn09P
         +9QAFCRfYGmAA2ntD0+S+1ivmMEgkOihsdzZCtKWcRYOnI0aBO0w8M6MeO9B4HlscnKq
         0nFg==
X-Forwarded-Encrypted: i=1; AJvYcCXH5VXEni8vCDKqxvZCG50P6O7ltAFEemXfXQsj3pjOvwnc9s1wNYbEKdZ87am8HJAqPy4JF+LrnVIilPimHiEcBbpVBKrQ58gzE8RQ9/Ag
X-Gm-Message-State: AOJu0Yxu9iJLkpOMI6gN2+f35VAYHlOudHL2vrtMcJKSeXtCam4PFhhG
	AywMyDwmF3zUiRT2O9pmLreknaBTOfMG3x/t57GW3mQ0WTyDGWROTgOGt5A2INLG2MdxFqH2tVy
	zx0/XlWpvr/VxI0nA9iuEC89q4VjFRbNmaF5rL3K52Ao3qyn4BiZDs+E=
X-Google-Smtp-Source: AGHT+IGOI7cZzAMSL6yMplFa5y6AX80e1XSk0w8sadvRzZ0r+OU3OxUW29wdtXGii0ZbuxRyGaN5AC7dkymb2ah/cEDBUYSS2t8i
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:502:b0:366:b7c0:9c72 with SMTP id
 d2-20020a056e02050200b00366b7c09c72mr89508ils.3.1710688525553; Sun, 17 Mar
 2024 08:15:25 -0700 (PDT)
Date: Sun, 17 Mar 2024 08:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e327b00613dcb50d@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_chan_del
From: syzbot <syzbot+3272785b7a1fc9b510f6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b0546776ad3f Merge tag 'printk-for-6.9' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf5b99180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ae24324b37fdefe
dashboard link: https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b0546776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a07801fab32c/vmlinux-b0546776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0696c91a7e74/bzImage-b0546776.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3272785b7a1fc9b510f6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/workqueue.c:2322 __queue_work+0xc44/0x1170 kernel/workqueue.c:2321
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-syzkaller-05292-gb0546776ad3f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xc44/0x1170 kernel/workqueue.c:2321
Code: 38 d0 7c 09 84 d2 74 05 e8 89 f6 8f 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 5a 64 34 00 85 db 0f 85 fe 00 00 00 e8 6d 69 34 00 90 <0f> 0b 90 e9 1c f9 ff ff e8 5f 69 34 00 90 0f 0b 90 e9 cb f8 ff ff
RSP: 0018:ffffc900003b7ab8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff888014c94000 RCX: ffffffff815ae3ea
RDX: ffff888015704880 RSI: ffffffff815928d3 RDI: ffff888014c94008
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000004 R12: ffff88801f8648c0
R13: 0000000000000008 R14: ffff88801f8648c8 R15: ffff88804bf9e000
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000030e25000 CR3: 00000000277b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __queue_delayed_work+0x21b/0x2e0 kernel/workqueue.c:2551
 queue_delayed_work_on+0x10e/0x130 kernel/workqueue.c:2595
 queue_delayed_work include/linux/workqueue.h:620 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1621 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1591 [inline]
 l2cap_chan_del+0x5a3/0x930 net/bluetooth/l2cap_core.c:647
 l2cap_chan_close+0xff/0xa30 net/bluetooth/l2cap_core.c:820
 l2cap_chan_timeout+0x17d/0x2f0 net/bluetooth/l2cap_core.c:432
 process_one_work+0x902/0x19d0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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
