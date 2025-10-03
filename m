Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AB2D29CF
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510412; cv=none; b=jujSL+VKFuNn1OUbPTzAbnEUBP4FzdCXlegC0oN75lfB8d6F4zjjh/XM5Ooc3hK4gq/dhcedgbzkwhmIURezcvFBlVJ6J6P6TsjfJQ1rXcyigWI4V4yRAQWVGqEp6SZs7nfLZ3+qMt87DspPR46g9d2Ea7FBYsVsl5Qgt2WL6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510412; c=relaxed/simple;
	bh=mRYirQtw3MyImmsDuhjY99bgdQ0XAhgTiyO/SCMpQc8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PTnqHfv1bxmxAxm0VraZKQkHnZpEl3E1g87BuRLp/luN+Ojaenl2XHyOGuEgEFeEUnukVxkCoUBxO1SCRK+RtlcrU8m4DlDVw+dphfwLGpkp23SRqPXkWMHObGikIZKUnU+JaJ8JJw0TDrEKEePhFv1tmR1cJf9GTPF+9v8Ze7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42575c5c876so29529325ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 09:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510409; x=1760115209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h98gklf+DoNEeI80Onk4YnlRuMg8M923I2rCscH72jQ=;
        b=i3vLoSkVFDHY6B22Qq8scYSNgBNjM+jTeSGNttiZ3knAxZdyp7XkOhqUBQ0dA7Vrne
         fqihS6S441M3EChotn4MNJiZ1ZwXRTHIK29aSn/2YHhDV8aBY7p32iymSQB7fqmdqaUz
         IYx9XLA8Fd/25KpA30xe55eJe4CP8F5UTGuKtyU+B8i7ANyb3guuUK9TtbDOK/GphZZn
         hjZVwH6TATz60I0qxYfyCI5lstxR4B6CjQhI7it/JDpB8OEe35p8Q2zfW0s4Pdux6YxG
         8yt0Io/1rSJ/fahIezb0IPOOwLklBEh3etLvdu93dx225MsxYWevq2totkZPvm71huBC
         BE6g==
X-Forwarded-Encrypted: i=1; AJvYcCVIB5CxoHZXIGB3mbMvhetXXDMXX7ofwF77zMlhNBMIS4uY6OeLkI90LjkGL8Y6JeIO6Y5/UecGfvusQypVa3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFLWF9At+eUQFt08TMuD5anTgdTpjjJUP/zjulAJiyjhte0mV
	g1xOtTo2j1CLwqpjYa84nF3ZcRLLaI/kgn1nM4RaCz91iX37J1VSMnoNUyDaMr7wrI5T4d9QNBL
	6PQcnxyEfAWEEIF9Dbqq1IIbknzbQZ6V1uvkUKOj20Jzg8l7RPM0H4lEeGuA=
X-Google-Smtp-Source: AGHT+IEhuw75pmpCsyZ0HKaEpYfv5plJnYtNDIfGXhbweUNBGOq7s+U+nmni+xgpvxRMSuffWIjNdSW99WuUPtPikQQtNR0qF3nu
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:42d:86fb:d871 with SMTP id
 e9e14a558f8ab-42e7ad961f1mr46652975ab.21.1759510409360; Fri, 03 Oct 2025
 09:53:29 -0700 (PDT)
Date: Fri, 03 Oct 2025 09:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dfff89.050a0220.2c17c1.0026.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_drop (3)
From: syzbot <syzbot+bf427d0e03a779974eee@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2213e57a69f0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12e2ff12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=bf427d0e03a779974eee
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf4625d47a8f/disk-2213e57a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/270abffcbf3c/vmlinux-2213e57a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f0f6eb3e385/Image-2213e57a.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf427d0e03a779974eee@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci4
WARNING: CPU: 1 PID: 6638 at kernel/workqueue.c:2256 __queue_work+0xe10/0x1210 kernel/workqueue.c:2254
Modules linked in:
CPU: 1 UID: 0 PID: 6638 Comm: kworker/1:6 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Workqueue: events l2cap_chan_timeout
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __queue_work+0xe10/0x1210 kernel/workqueue.c:2254
lr : __queue_work+0xe10/0x1210 kernel/workqueue.c:2254
sp : ffff80009d4e77e0
x29: ffff80009d4e7830 x28: 1fffe0001b418c00 x27: ffff0000d493dac0
x26: 0000000000000008 x25: dfff800000000000 x24: ffff0000c9ffa800
x23: ffff0000c9ffa9c0 x22: 0000000004208060 x21: 1fffe000193ff538
x20: ffff800092e27000 x19: ffff0000d9fe0960 x18: 00000000ffffffff
x17: ffff80009353a000 x16: ffff80008b021030 x15: 0000000000000001
x14: 1fffe000337938f2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337938f3 x10: 0000000000ff0100 x9 : 1a6f38d4427b3b00
x8 : 1a6f38d4427b3b00 x7 : ffff800080565b6c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000807e0688
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __queue_work+0xe10/0x1210 kernel/workqueue.c:2254 (P)
 __queue_delayed_work+0xfc/0x2c8 kernel/workqueue.c:2507
 queue_delayed_work_on+0xe4/0x194 kernel/workqueue.c:2559
 queue_delayed_work include/linux/workqueue.h:684 [inline]
 hci_conn_drop+0x174/0x280 include/net/bluetooth/hci_core.h:1675
 l2cap_chan_del+0x228/0x470 net/bluetooth/l2cap_core.c:671
 l2cap_chan_close+0x424/0x684 net/bluetooth/l2cap_core.c:-1
 l2cap_chan_timeout+0x120/0x280 net/bluetooth/l2cap_core.c:431
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
irq event stamp: 105130
hardirqs last  enabled at (105129): [<ffff800080429388>] __cancel_work+0x158/0x218 kernel/workqueue.c:4344
hardirqs last disabled at (105130): [<ffff8000804249b8>] queue_delayed_work_on+0x54/0x194 kernel/workqueue.c:2555
softirqs last  enabled at (105122): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (105122): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (104025): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
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
