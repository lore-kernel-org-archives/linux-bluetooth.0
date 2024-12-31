Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8E2A1BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Dec 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735662864; cv=none; b=B0EiRNimCSmhqigO1PArN3gJCsaY4qFQdCSdqZcl7Cyc9tQhxueprqwYAsNMZ3aKSe8D99zkjvEigdKt7Mo58mIcIjGaaM9IzgRWSr+OKSOe3ge2HwcJlKaLwPvGXZ6RzbibmiXFQeGHg9e6xWQ/K6nKM+44vPPMWEuMSk18MJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735662864; c=relaxed/simple;
	bh=q034Ft6XgYrHayngpj9wiGksmxcV5qvfR8xrQ6CXIXg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OOOcpBDwy3nCMvF6fN9r29bBo4D1R2vIhfPFN/kFt9NffaeEifK+zA6tnk96bTEMFnDYCPc/LNtAFPtwrSy2tkDvUG0E8hJwlWpFX7jhNoFkgqX1tIRBYHED9nmMd8db7dg/zFhRd0aroRDXPL6QZYOwWJivKCwxUw/CZiTzwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so204756685ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Dec 2024 08:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735662862; x=1736267662;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUqc60wkmW9huzVcTXr/oWHiaZ7P96lfYSrjifsWBvM=;
        b=r13eLrsaBj2YGzfVFn+26/8pDB9g1r+T5yIz3voAhRA599l1nfWC9wtI5vGdGNFFPG
         eTWoic+zincdMxI1oklEyj8r1FY0btSDzD2+HiMA3RW4B6WpkceQO6UxZKtVt2Etti8h
         cVbIOC2Xu7MWi8eU1Nr/nMPCEOHhQr7OwrnpO5mUGOia/5PqtDAQO4ZUh+lEr/Zx1LMN
         6ZEQXJBeyQsUHxA/VIYRLiAJJf8kmKeE551haI5dUa2/tQHB98a03WyS2zoeC2JVMgnu
         8UwM5gkoh+gfsMR3RgU3F+Sb8Emz/QArEoUm3OHQywWjB42zFgKMj6NrFgpGz4JYTJNj
         SQig==
X-Forwarded-Encrypted: i=1; AJvYcCU/fDMytBYbWkbznfaHlAwZpKDuKtnBjGf5ayjuBLrthO4kONRBsvHGY0qybh54W+eou+MrwnVLpbW45LkdG20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDqGYrSzkPmf7LovBTjuSj8eX6akul0yNAUTPIl+RDYXc7ZK+
	7y1OV/Dta5Nz9d0fvqSPHt6vyK7ZOUsX/UkBDsPUM62+sl4qE0fplOrnHF1CeI0MXnCDLJx8p7L
	emnVObg3QrnnYyAiMzOhLHMWGj4vbdIudrn3OB9JjX+bUlq4PBlJf9Q8=
X-Google-Smtp-Source: AGHT+IF/gxXMEeYmwaaPAu2zKiRsTmnSEzXum/R6XKj995omrCW8QGVsCSsx2ksh7t3diuLH9LePxOB4DPiFQ/LAdg3uMN9n75n+
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c1:b0:3a7:e3e3:bd57 with SMTP id
 e9e14a558f8ab-3c2d533e943mr315743115ab.15.1735662862325; Tue, 31 Dec 2024
 08:34:22 -0800 (PST)
Date: Tue, 31 Dec 2024 08:34:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67741d0e.050a0220.25abdd.0918.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_drop
From: syzbot <syzbot+afa1843ff020b481e6b5@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10f7e0b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=afa1843ff020b481e6b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d3b5c855aa0/disk-573067a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c06fc1ead83/vmlinux-573067a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390e59b9e4b/Image-573067a5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afa1843ff020b481e6b5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6472 at kernel/workqueue.c:2257 __queue_work+0xe80/0x1308 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 6472 Comm: kworker/1:3 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events l2cap_chan_timeout
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe80/0x1308 kernel/workqueue.c:2256
lr : __queue_work+0xe80/0x1308 kernel/workqueue.c:2256
sp : ffff8000a5fc7820
x29: ffff8000a5fc7870 x28: 1fffe0001b107c00 x27: 001fffffffc00001
x26: dfff800000000000 x25: ffff0000ec829800 x24: 0000000000000008
x23: 1fffe00018dfc001 x22: ffff0000ec8299c0 x21: 0000000004208060
x20: ffff0000c1080408 x19: ffff0000f131c8e8 x18: ffff8000a5fc75a0
x17: 0000000000048c2a x16: ffff800083275834 x15: 0000000000000001
x14: 1fffe0001e26391d x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e26391e x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c6fe0000 x7 : ffff800083277784 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000f131c8e8 x1 : 0000000000200000 x0 : ffff0000d4acdd00
Call trace:
 __queue_work+0xe80/0x1308 kernel/workqueue.c:2256 (P)
 __queue_delayed_work+0x184/0x23c kernel/workqueue.c:2507
 queue_delayed_work_on+0xec/0x1b0 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 hci_conn_drop+0x178/0x280 include/net/bluetooth/hci_core.h:1642
 l2cap_chan_del+0x228/0x470 net/bluetooth/l2cap_core.c:674
 l2cap_chan_close+0x4c8/0x82c
 l2cap_chan_timeout+0x128/0x288 net/bluetooth/l2cap_core.c:435
 process_one_work+0x7a8/0x15cc kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 163642
hardirqs last  enabled at (163641): [<ffff800080365520>] __cancel_work+0x1c4/0x29c kernel/workqueue.c:4331
hardirqs last disabled at (163642): [<ffff80008036074c>] queue_delayed_work_on+0x58/0x1b0 kernel/workqueue.c:2548
softirqs last  enabled at (163636): [<ffff80008976e8b0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (163636): [<ffff80008976e8b0>] release_sock+0x154/0x1b8 net/core/sock.c:3646
softirqs last disabled at (163634): [<ffff80008976e798>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (163634): [<ffff80008976e798>] release_sock+0x3c/0x1b8 net/core/sock.c:3635
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
