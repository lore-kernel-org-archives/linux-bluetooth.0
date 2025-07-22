Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62946BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167097; cv=none; b=c23Meu1gC8OTlP0onfoGPW9OsMAwaOTYACYmkj2en/fMNwLygoYBR59+0roxWGy9qlL0/8CF0VZdhRcVKhPGmhrLpAHp5AnaqLtdPXNlLjbDRBjwtk8an+9irxk0XIv0/2qbBix5uOhy3JROYAI86tT5Hf0bTETrQhPuyeeSxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167097; c=relaxed/simple;
	bh=xgAxZl7DfvG5g/XMl3zZFUxkLl4c5i98gywUlj5oQIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PQria6AliOJiXMmqDG/nktNYtaWtMOyuyO/OEzq40g879WM8TIs1c65psY44O8SsaAE/aHBHpmseGBXoXXm0j+DRGMRSIRdxp30KLlu+IwqFYbIJo51vdDNE2RA8ah0BR4ruOju1dpQpJN02eAog/1YS9okEZZ5WZSo8P0Srq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c2f667915so242421939f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 23:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167095; x=1753771895;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLCMiMflMwhmmOFOL4my4sXggFIoJnCaYfB3eLK/f8g=;
        b=LoblhfhPj80qwVbd3QM6/qwNHKd47H8hU1v2MG9jV0TZ6Xoq1S/nQaD4jhY9PN2saj
         XeDf+AjS0EbuMAeN++htXC6CbGLhAvyJSjHo5fAs0xJaK63nWz4OBYejDB9JaA/BBJd6
         e7VtjHPhymId7P+cRF4KJFMR1r6Hf5B27pSrnVgYiwzUyKshJArVbf+DFbqXALuUBeJz
         Dmc/81sTORYxDRHFvUBMJkkBdEH912Iek3UjIWUT8LQIsxzRixPBBwNiIjvUvbLpYihk
         lcrdJSZZ2/51KcKynWRT7akR5PdnHYU95qrVg6AgkCZUm1zmirZ9lD9Fm60nlPLYfIO5
         wddQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX1OQlq7kEz3vmiC3z+KVx/cl5Q+j/gx3RSlDidN+9GJuNCPAv+M4mo64uOlBqx7dlx3tg0S9HXiPcxmB/Osg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwssqSoeP7G8diXJE0E4h8oZ4fJhDtsnMZbZW7Rq/AEYWU/vc6Z
	1ozYIqPMN8O0AGeeGUgBU+jzRJb0nc4Zol4mtrgzxP+F4dbkWyg/6sxT5b4OhSW/dgmJq5RMm08
	/qpv4ppwltRvpGOy8+/6YYnw84w5MBjipPJ85KlBAF/ONMXSHTQPfifQa2lM=
X-Google-Smtp-Source: AGHT+IGuO7YQ+xpFIsRZkxlIQH2UzSSEfl4bOcYqr2nqhAAogyEz0uOFpmmiP7cnjcK0DgiW7o+jfq3aggYa9hDP/yn5t/SQCjJg
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7403:b0:867:6c90:4867 with SMTP id
 ca18e2360f4ac-879c2a90d96mr3289162939f.14.1753167095211; Mon, 21 Jul 2025
 23:51:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 23:51:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687f34f7.a70a0220.21b99c.0008.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_send_disconn_req (2)
From: syzbot <syzbot+e487b7a18d6f21a9811c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6832a9317eee Merge tag 'net-6.16-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127117d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bff2df4655c5f44
dashboard link: https://syzkaller.appspot.com/bug?extid=e487b7a18d6f21a9811c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/818bd549a31a/disk-6832a931.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f971d7bc88e2/vmlinux-6832a931.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f637a5f4829c/bzImage-6832a931.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e487b7a18d6f21a9811c@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci2
WARNING: CPU: 0 PID: 981 at kernel/workqueue.c:2258 __queue_work+0xd62/0xfe0 kernel/workqueue.c:2256
Modules linked in:
CPU: 0 UID: 0 PID: 981 Comm: kworker/0:3 Not tainted 6.16.0-rc6-syzkaller-00121-g6832a9317eee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xd62/0xfe0 kernel/workqueue.c:2256
Code: 42 80 3c 20 00 74 08 4c 89 ef e8 a9 2d 95 00 49 8b 75 00 49 81 c7 78 01 00 00 48 c7 c7 00 e9 89 8b 4c 89 fa e8 5f 34 f9 ff 90 <0f> 0b 90 90 e9 f1 f4 ff ff e8 c0 46 35 00 90 0f 0b 90 e9 dd fc ff
RSP: 0018:ffffc90003a4f728 EFLAGS: 00010046
RAX: 2e4141edcce3d000 RBX: 0000000000000020 RCX: ffff8880256a8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff11028876538 R08: ffff8880b8624293 R09: 1ffff110170c4852
R10: dffffc0000000000 R11: ffffed10170c4853 R12: dffffc0000000000
R13: ffff88806c564b68 R14: ffff88801a494008 R15: ffff8881443b2978
FS:  0000000000000000(0000) GS:ffff888125c59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c25779d CR3: 000000003202e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x181/0x270 kernel/workqueue.c:2392
 l2cap_send_disconn_req+0x255/0x3c0 net/bluetooth/l2cap_core.c:1495
 l2cap_chan_close+0x3ad/0x980 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x158/0x390 net/bluetooth/l2cap_core.c:431
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
