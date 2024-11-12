Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08D2309AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409650; cv=none; b=l33tC0bAN+lFQfJyfuEKwjCM3rjpnLycTil9HbyWnGNs6Fs5dIUiJ//kqpOiHG4vSNMQMc2+G+Vh2ZAQ74/bkRHMSjfhSfhWOKHO13li+5Y0ttRqSTL2lgtni31seatT5PFcIIhBBjXwcVX/ytw1FzQ/J1sarrClrmy5v5753lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409650; c=relaxed/simple;
	bh=RFZzXqoHJBrRDQJjiavpi4dM8wfBthHXlqsFXx1CzFs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dM8lo+i83DIfHGX9tEugVyDcPx+c6NomOM2RrSfUSeglOXflj71NQ2GJknlGADZl28aAz+Tnup2W/6FYHO9xqrU5FBe4VNS+oct3aCY5VA4PNrcBScFg4ZL/qjD3c7LD248fyYQvV07q0jcQJ4fh5J2OmWTRQGpw/ptwa2NEYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so72137835ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 03:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409647; x=1732014447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w71F2J8vMNvo3Ek2tm/lYKr31zIi+UKebGsl9EWIncQ=;
        b=tmf/jJoZY+w8zPp4LlKfG4ZxMpyFxPEugy2uAI8Wze3Wg9QWDYm4MXvTvJ3yW4wqPz
         Cm5kwSYhyX9PtG7MS8jIA5TjI4s7/NVmm/uukjWsJ7fMktqdYLjvuL5k550xMB6C3lql
         siaG+L4K7pJuvfxGsTx1bT1bgea0RVKstj41SSRmBryovr02XxdMNpZ4TX/Kdp5pk0Rq
         JTFMeYnzcPRBmIU15XMQExdETj2defqRrieHOYeCP6X1AifEBFUAO/RIjd3W1yTNWdJz
         0IdsvR4a/wpN0PpZ7M17nTOSCyHxOD9sKoQ3daZIvOaEJzofgQ+aIn8a/C2NjOgN4mK/
         Z2pw==
X-Forwarded-Encrypted: i=1; AJvYcCUGPsjHV29WWElq3gXtTnjvnTnWTQQ/y8F6bXy2FQsDKLAVpw1CNn+UzWB4aTbbHM68MJcUzz0zpaR0oyNAxLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZIDjsPqtNgkzcfnMkDmFboLSVWshLkYW5ywPkIs3FQTDxOqv
	shzWh1TXaFATAcJ4Lgwx30LqxQ7l16Pi1CewgBdj5lK++zaC9c9VXkDWaU2JukXw1+Jce7NRSxT
	pfq6LbCedSNTMXtAZtJz9TYzWErloCB/f3Wp4mvdx5Y9vC1ZIPLNLU3E=
X-Google-Smtp-Source: AGHT+IEfgsgjXOkhRoFIkhOM217U6CY/5f1hoxqVenSQP/u0mgXDpHP5VOR87F1b9fCK4bGpCZH0yVrLlh3l0e/Ok8Rr4MK1xPMj
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cb:b0:3a6:c493:7396 with SMTP id
 e9e14a558f8ab-3a6f19a00bbmr166241545ab.3.1731409647561; Tue, 12 Nov 2024
 03:07:27 -0800 (PST)
Date: Tue, 12 Nov 2024 03:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673336ef.050a0220.a0661.0411.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in emon
From: syzbot <syzbot+179a0c842142690ca7cb@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    906bd684e4b1 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bacea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20d60fe605153ebe
dashboard link: https://syzkaller.appspot.com/bug?extid=179a0c842142690ca7cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-906bd684.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34d4b570061f/vmlinux-906bd684.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08ae18992ed1/bzImage-906bd684.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+179a0c842142690ca7cb@syzkaller.appspotmail.com

Nov  8 11:01:11 syzkNov  8 11:01:11 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL device
Nov  8 11:01:11 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL device
Nov  8 11:01:11 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL device
Nov  8 11:01:11 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL device
Nov  8 11:01:11 syzkaller daemon.err dhc[  112.611200][   T35] ------------[ cut here ]------------
pcd[5661]: libud[  112.612841][   T35] WARNING: CPU: 3 PID: 35 at kernel/workqueue.c:2257 __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
ev: received NUL[  112.616635][   T35] CPU: 3 UID: 0 PID: 35 Comm: kworker/3:0 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Nov  8 11:01:11 [  112.619771][   T35] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
syzkaller daemon[  112.622998][   T35] Workqueue: events l2cap_chan_timeout
.err dhcpcd[5661[  112.626360][   T35] Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 2f e7 97 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 80 5f 36 00 85 db 75 60 e8 37 5d 36 00 90 <0f> 0b 90 e9 f9 f7 ff ff e8 29 5d 36 00 90 0f 0b 90 e9 a8 f7 ff ff
]: libudev: rece[  112.631694][   T35] RSP: 0018:ffffc900008efab8 EFLAGS: 00010093
ived NULL device[  112.633897][   T35] RAX: 0000000000000000 RBX: ffff88801b0a0c00 RCX: ffffffff8159028a

Nov  8 11:01:1[  112.633927][   T35] RBP: ffff88804b5b48c8 R08: 0000000000000005 R09: 0000000000000000
1 syzkaller daem[  112.633934][   T35] R10: 0000000000200000 R11: 0000000000000000 R12: ffff888028731800
on.err dhcpcd[56[  112.633941][   T35] R13: 0000000000000008 R14: ffff88804b5b48d0 R15: ffff888028731800
61]: libudev: re[  112.648173][   T35] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
ceived NULL devi[  112.650334][   T35] CR2: 00005633f9eb8300 CR3: 00000000245a0000 CR4: 0000000000352ef0
ce
Nov  8 11:01[  112.655004][   T35] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
:11 syzkaller da[  112.655013][   T35] Call Trace:
emon.err dhcpcd[[  112.655023][   T35]  ? __warn+0xea/0x3d0 kernel/panic.c:746
Nov  8 11:01:11 syzkaller daemon[  112.655042][   T35]  ? __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
.err dhcpcd[5661[  112.663447][   T35]  ? __report_bug lib/bug.c:199 [inline]
.err dhcpcd[5661[  112.663447][   T35]  ? report_bug+0x3c0/0x580 lib/bug.c:219
]: libudev: rece[  112.665186][   T35]  ? handle_bug+0x54/0xa0 arch/x86/kernel/traps.c:285
ived NULL device[  112.665198][   T35]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309

Nov  8 11:01:1[  112.665209][   T35]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
1 syzkaller daem[  112.665227][   T35]  ? to_kthread kernel/kthread.c:76 [inline]
1 syzkaller daem[  112.665227][   T35]  ? kthread_data+0x4a/0xc0 kernel/kthread.c:244
on.err dhcpcd[56[  112.672090][   T35]  ? __queue_work+0xc39/0x1080 kernel/workqueue.c:2256
61]: libudev: re[  112.673920][   T35]  ? __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
ceived NULL devi[  112.675676][   T35]  ? __queue_work+0xc39/0x1080 kernel/workqueue.c:2256
ce
Nov  8 11:01[  112.677419][   T35]  ? clear_pending_if_disabled+0xa9/0x210 kernel/workqueue.c:2358
:11 syzkaller da[  112.679306][   T35]  ? __pfx_clear_pending_if_disabled+0x10/0x10 arch/x86/include/asm/atomic.h:23
emon.err dhcpcd[[  112.681308][   T35]  __queue_delayed_work+0x21b/0x2e0 kernel/workqueue.c:2507
5661]: libudev: [  112.683075][   T35]  queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2552
received NULL de[  112.684835][   T35]  queue_delayed_work include/linux/workqueue.h:677 [inline]
received NULL de[  112.684835][   T35]  hci_conn_drop include/net/bluetooth/hci_core.h:1570 [inline]
received NULL de[  112.684835][   T35]  hci_conn_drop include/net/bluetooth/hci_core.h:1544 [inline]
received NULL de[  112.684835][   T35]  l2cap_chan_del+0x5a0/0x900 net/bluetooth/l2cap_core.c:674
vice
Nov  8 11:[  112.686467][   T35]  l2cap_chan_close+0xff/0xa30 net/bluetooth/l2cap_core.c:847
01:11 syzkaller [  112.688470][   T35]  ? __pfx_l2cap_chan_close+0x10/0x10 net/bluetooth/l2cap_core.c:3787
daemon.err dhcpc[  112.690727][   T35]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
daemon.err dhcpc[  112.690727][   T35]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov  8 11:01:11 [  112.692741][   T35]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
syzkaller daemon[  112.696630][   T35]  l2cap_chan_timeout+0x196/0x310 net/bluetooth/l2cap_core.c:435
.err dhcpcd[5661[  112.698753][   T35]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
]: libudev: rece[  112.700904][   T35]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
ived NULL device[  112.703198][   T35]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153

Nov  8 11:01:1[  112.705413][   T35]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
1 syzkaller daem[  112.707453][   T35]  process_scheduled_works kernel/workqueue.c:3310 [inline]
1 syzkaller daem[  112.707453][   T35]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
on.err dhcpcd[56[  112.709488][   T35]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
61]: libudev: re[  112.711618][   T35]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
ceived NULL devi[  112.713380][   T35]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
ceived NULL devi[  112.713380][   T35]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
ce
Nov  8 11:01[  112.715597][   T35]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
:11 syzkaller da[  112.717559][   T35]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
emon.err dhcpcd[[  112.719468][   T35]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
5661]: libudev: [  112.721437][   T35]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
received NULL de[  112.723473][   T35]  </TASK>
vic[e 


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
