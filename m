Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4541EB9E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461648; cv=none; b=Zy/8hmN7Pb9ponShPCrAFHdL2urZlYNxc08N4/KfzFx1fQXYx9vf/sWJrS0us0arxVkowpQwyZfxuet+cUQsHMgLTCk7O7CpOfmy6hXFibPLiNffZn5Nq7m++LNUYatPGq+JAGwfVxPLHUIWiz+n6F+sewPCrvV9VFQy/FYMNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461648; c=relaxed/simple;
	bh=tB0s+m6aFPYw2aUKhjQrnBmhGjg3R3H1qUca04bdGEs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YW6FoThIp1w20j/wzUgTdVt6o8fo26F9nFDJBhY1xBp+JdW19cRRTgqlid1dSVdFsPHWY0N40wwLx6ct/QZSdAmXL8NS4fYzFybsVj7kHh2M5F7t9R7ZOVd6YHDJAjp7pg1KkDtF7KEuncfMgEfWNj0x6CClaLQ8KVsaObSfVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so12741405ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 02:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461646; x=1743066446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJAGCcFQC5ruyciO77MttM2UXxm4c5ZthxU0/9v+U6I=;
        b=sg6xF7LQVxswaZTBzOhN0Ovzsb2iEYMw7uSU8ijMN71eP04/q2b2w7IulYAQgYqpUQ
         dk84VlsxHV/4oRIarhG9Oz526sDAzw5WZuIAgnOWH7Z1gOEleWCbEHPgaulgueDVO30R
         v5BJiozNwdqB9WBRfka8gvyyNosFm9AQwPnou4hcFD45kS5InE6IDnWUM0xD1oobx89z
         20YxJIVg46YIW+GpXN6xCrhNjvDOAfzWShPTAX234DnQj7bg6g0zn3diq3Dg91MDEixP
         7HkJx6hRTqoP57nlLoxrJTO4lx2OvFNEPglVnGuDxNDQ15boI7JTApHxsxeQir1sXY9N
         p5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwCFHzX0MxvoGRpA/fLiCNMZibt/M+BF5GoE6548A7j4ehNg4choOTPcLQkjQbhCg27irGc36Fo94AufJuWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFu3ZgN/1QZRJuh5hHFHVCf+xsz9712UtgwEgYGhfR4kia4Y3q
	L/cCxdLolVxgcQkbkTOr6khUYtXi+SHy0sA5imB7mfakQCYGgYD3I4Ht3O+pOe++6S16KKgeW7/
	mP/lHM1ynsNvyL+mGIypXAPHMoSrtsSSwZS1Gy2MVmSIPPcX06PmgZbk=
X-Google-Smtp-Source: AGHT+IHkd9aGmCSyxtOnJ9AZaC1LbCNax4fNstQBY5Acgd7vJs6VEfBK5wbWW4AK2HGnt+Ium+k8WqxbeCT9VqX/8PTVGPeRjhE2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:3d3:d07d:20a3 with SMTP id
 e9e14a558f8ab-3d58ebc2d70mr26103775ab.10.1742461646218; Thu, 20 Mar 2025
 02:07:26 -0700 (PDT)
Date: Thu, 20 Mar 2025 02:07:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dbdace.050a0220.31a16b.000b.GAE@google.com>
Subject: [syzbot] [bluetooth?] [usb?] BUG: soft lockup in hci_cmd_timeout (2)
From: syzbot <syzbot+7f3e9d90cb008752b863@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5618886fdab Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=101283b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29061e148cfaa3d3
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3e9d90cb008752b863
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138abff8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b90307e7f61/disk-a5618886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b5ea0300ee3/vmlinux-a5618886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47f59a45fc8c/Image-a5618886.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f3e9d90cb008752b863@syzkaller.appspotmail.com

yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u9:1:6013]
Modules linked in:
irq event stamp: 347894
hardirqs last  enabled at (347893): [<ffff8000804b08ac>] console_emit_next_record kernel/printk/printk.c:3130 [inline]
hardirqs last  enabled at (347893): [<ffff8000804b08ac>] console_flush_all+0x678/0xb90 kernel/printk/printk.c:3210
hardirqs last disabled at (347894): [<ffff80008b7cdd84>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
hardirqs last disabled at (347894): [<ffff80008b7cdd84>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:575
softirqs last  enabled at (347888): [<ffff8000803128a4>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (347888): [<ffff8000803128a4>] handle_softirqs+0xb44/0xd34 kernel/softirq.c:589
softirqs last disabled at (347877): [<ffff800080020dbc>] __do_softirq+0x14/0x20 kernel/softirq.c:595
CPU: 1 UID: 0 PID: 6013 Comm: kworker/u9:1 Not tainted 6.14.0-rc6-syzkaller-ga5618886fdab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: hci3 hci_cmd_timeout
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
pc : arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
pc : console_emit_next_record kernel/printk/printk.c:3130 [inline]
pc : console_flush_all+0x69c/0xb90 kernel/printk/printk.c:3210
lr : console_emit_next_record kernel/printk/printk.c:3130 [inline]
lr : console_flush_all+0x698/0xb90 kernel/printk/printk.c:3210
sp : ffff8000a4ad72c0
x29: ffff8000a4ad7400 x28: 1ffff0001495ae72 x27: 1fffe0001aec87a2
x26: dfff800000000000 x25: 1ffff000122bcaa7 x24: 0000000000000001
x23: ffff8000915e5538 x22: ffff8000915e54e0 x21: 0000000000000000
x20: 0000000000000000 x19: 00000000000000c0 x18: ffff8000a4ad7208
x17: 20627275202d206b x16: ffff80008046947c x15: 0000000000000001
x14: 1ffff00011f8fe70 x13: ffff8000a4ad8000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7643d00 x7 : ffff8000804aa598 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : 0000000000000000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 console_emit_next_record kernel/printk/printk.c:3130 [inline] (P)
 console_flush_all+0x69c/0xb90 kernel/printk/printk.c:3210 (P)
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x138/0x3ac kernel/printk/printk.c:3309
 vprintk_emit+0x308/0x55c kernel/printk/printk.c:2432
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2447
 vprintk+0x94/0x12c kernel/printk/printk_safe.c:82
 _printk+0xdc/0x128 kernel/printk/printk.c:2457
 bt_err+0xfc/0x144 net/bluetooth/lib.c:296
 hci_cmd_timeout+0x108/0x1cc net/bluetooth/hci_core.c:1452
 process_one_work+0x810/0x1638 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3400
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.14.0-rc6-syzkaller-ga5618886fdab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:50
lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:124
sp : ffff80008fb37cf0
x29: ffff80008fb37cf0 x28: dfff800000000000 x27: 1ffff00011f66fac
x26: ffff80008fbbd000 x25: 0000000000000000 x24: 0000000000000001
x23: 1ffff00011f77ac1 x22: ffff80008fbbd608 x21: 0000000000000000
x20: ffff80008fbe6780 x19: ffff800080410018 x18: 1fffe000366f1886
x17: ffff80008fbbd000 x16: ffff80008040f8f8 x15: 0000000000000001
x14: 1fffe000366f3537 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 000000000028a3a3 x7 : ffff8000805c3f98 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008b7d2680
x2 : 0000000000000000 x1 : ffff80008b87a760 x0 : ffff800123c84000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:48 (P)
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1ec/0x4e0 kernel/sched/idle.c:325
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:423
 rest_init+0x2dc/0x2f4 init/main.c:743
 start_kernel+0x3f8/0x4f8 init/main.c:1099
 __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246


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
