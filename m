Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41818E3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166033; cv=none; b=aU5NfOU9CtVI+AVGeApXaLG/AGBY6AdHYiPLVjxqyl+X8W71wS6GZsGqfwU7FmcVL4DP9i3MR5WflIZ+fKDwUidtUzea+2H7dqRhpPV4gkfLGwArl+tmeJuEqp+8EbJxMWZdFqPiz41/dXxX6Ni6ewDOjY7irmHW3bNN9TvPiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166033; c=relaxed/simple;
	bh=GctkiOdVRpfP7LUutwUwpfgSAb/wlxs4NY6m/Ij4VrI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oKBEkPdyeFkyO9Uf6/uFOmpexTnnjPaneDiSmkYj8XTnv+05QqAHtvpRs/7qen57GEOT1sSHfFUF5cIQGcj8JOarlw3r26w0zDA8E+Yh9wZt6XoZegThzDeP+WuL5nrbxFq98tjRYr9UUP3BYOQ3OnCKL+NPmbAm5r4O70Z1dsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso692099739f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 21:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166031; x=1718770831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnEcZQSlSSfWGLe3U4JPeUiGUJ9V4peTlbScVRNrxNs=;
        b=JOT+Q7YhO20vy6RC/sM/i0Uv3U/LatNSeN2uY9SFtkxSqCk/Rm2376trg/U4C4a9ro
         QGA3FeHLuv9SFbf4eBU9cKdFuNW9P69lc1Xs9/vDXSPkrlyU796O0r/kb3jWZukx1M81
         Qp0/V3nw25dLGjxwiT4syP6l/pPqh/DPNRZr127YuFH0l6mAdeQVV1uWPY4dr9kbTMHX
         cQJ2Um+7lMo2iDUE8Pn6dxkdd0aMCPs67NDvW4LuNO56Z3UEt55ULhHmQLJj8Gvo0jPE
         r2LtXsIvi1DS0hvimQvNKU7Ircq0Jjr+rUSQABKOP6VDB1GVppM6RmtVL3qopaCDDPs2
         W+hg==
X-Forwarded-Encrypted: i=1; AJvYcCV9364cdxpdLCXby24xJObzxt1h6Le0NXdC5utMiLXiv91K0t+Z0xc7DhYqdD8+h9Li7M2R0mwwhMSaG/JFBkH7GLg+7EsbeQ9egXR4yM85
X-Gm-Message-State: AOJu0YynvI+ro4RgUvcpoSy88P2ZII44iLDT7LzegYeDe20k8IwYCSLO
	4v4BHdl/Axsk3nNQB89OCuvACeroaHB+qFK/y4SSOdlrH9fPkGT8Bb6f+rzvqr8iBJRcHJrR3bi
	nGXSIy+KyA8mtUsJFu811k5IaZ5hAKxckVbQl4I/tg40mm1aEJiw4jUI=
X-Google-Smtp-Source: AGHT+IFkTHvhhUdoUr2ZTibKNN6lcj7J6RVdaWsARGNYjEPc/B+AzfjC6+2yOQ4dNQPTLPLLJ81bK6hiZ5Ht25sDs/lEC7M/Z4TX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8414:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4b93eef52camr57346173.5.1718166031186; Tue, 11 Jun 2024
 21:20:31 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:20:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f45085061aa9b37e@google.com>
Subject: [syzbot] [bluetooth?] [usb?] BUG: soft lockup in hci_cmd_timeout
From: syzbot <syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=112ad20a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2abad17596ad03dcff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1112d2ce980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c37286980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ea21f50498b/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2fed09364aa/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4860173c7a18/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com

cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u9:2:6293]
CPU#0 Utilization every 4s during lockup:
	#1:  97% system,	  1% softirq,	  4% hardirq,	  0% idle
	#2:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
	#3:  97% system,	  0% softirq,	  3% hardirq,	  0% idle
	#4:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
	#5:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
Modules linked in:
irq event stamp: 150196
hardirqs last  enabled at (150195): [<ffff80008037bc00>] console_emit_next_record kernel/printk/printk.c:2935 [inline]
hardirqs last  enabled at (150195): [<ffff80008037bc00>] console_flush_all+0x650/0xb74 kernel/printk/printk.c:2994
hardirqs last disabled at (150196): [<ffff80008af10b00>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (150196): [<ffff80008af10b00>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (150190): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (150190): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
softirqs last disabled at (150185): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
CPU: 0 PID: 6293 Comm: kworker/u9:2 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci0 hci_cmd_timeout
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
pc : arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
pc : console_emit_next_record kernel/printk/printk.c:2935 [inline]
pc : console_flush_all+0x67c/0xb74 kernel/printk/printk.c:2994
lr : console_emit_next_record kernel/printk/printk.c:2935 [inline]
lr : console_flush_all+0x678/0xb74 kernel/printk/printk.c:2994
sp : ffff8000993f7360
x29: ffff8000993f7460 x28: ffff8000993f7510 x27: 0000000000000001
x26: ffff80009090b530 x25: ffff80009090b520 x24: dfff800000000000
x23: 1ffff000121216af x22: dfff800000000000 x21: ffff80009090b578
x20: 0000000000000000 x19: 00000000000000c0 x18: ffff8000993f7298
x17: 6965636572207375 x16: ffff80008033878c x15: 0000000000000001
x14: 1ffff00011e379c8 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d3a39e40 x7 : ffff800080381d44 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : 0000000000000000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
 console_emit_next_record kernel/printk/printk.c:2935 [inline]
 console_flush_all+0x67c/0xb74 kernel/printk/printk.c:2994
 console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
 vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
 vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
 _printk+0xdc/0x128 kernel/printk/printk.c:2370
 bt_err+0xfc/0x144 net/bluetooth/lib.c:296
 hci_cmd_timeout+0xd8/0x1cc net/bluetooth/hci_core.c:1528
 process_one_work+0x7b0/0x15e8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3393
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:50
lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:124
sp : ffff800093e97d10
x29: ffff800093e97d10 x28: dfff800000000000 x27: 1ffff000127d2fb0
x26: ffff80008efed000 x25: 0000000000000000 x24: 0000000000000002
x23: 1ffff00011dfdaad x22: ffff80008efed568 x21: 0000000000000000
x20: ffff0000c1b70000 x19: ffff8000802e6e08 x18: 1fffe000367b6bde
x17: ffff80008efed000 x16: ffff8000802e66cc x15: 0000000000000001
x14: 1fffe000367b8941 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000b17a9 x7 : ffff80008047f238 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008af14fe8
x2 : 0000000000000000 x1 : ffff80008b0900a0 x0 : ffff800124e80000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
 arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:48
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1f0/0x4e4 kernel/sched/idle.c:332
 cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:430
 secondary_start_kernel+0x1bc/0x1e4 arch/arm64/kernel/smp.c:279
 __secondary_switched+0xb8/0xbc arch/arm64/kernel/head.S:417


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
