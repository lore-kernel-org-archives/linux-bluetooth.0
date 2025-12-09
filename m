Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9E1F12F8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290506; cv=none; b=k+7U6iwQPiT+qGYVgz4reB39ph12fqo5t6u9rOIhKmbryq7gz/e4/pDgJkFW1uldUFlWPYeNQt9VqHFi9kkUuXLdrNK49IYM6Qg3K4EDJR0/rXRO7lU1oppi7yC3TiXRa0UCgU3uOaR/3OYQa/uw07vnx2x7iP5QBeXl2NOJG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290506; c=relaxed/simple;
	bh=tF3x4xAXyXHdl+BhowAO/iO9liTtenk76VatcWGRhgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y1rMw2F5RBUSkZFE16TdDcEWDjHkn/1j5saHzkRy0d/GYkyjVDT6hGrWtuJ+jhNT7UTi0FAfmULSs/I/Ct6IIcTCA1l6CeXuPubkiUWjM7CckFx+rp6ciohEP8NE430U8s/zFa0vOf4fUXJaoRVBCDg9vbw1itKgPPgue78ncIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-3ec31d72794so12216836fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 06:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765290503; x=1765895303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0NTnosFMSh+SEq7ngC2o7cW/jV3+R33W89520u9yeA=;
        b=bI6CWC52gzwpsV7zNPhIQInfz3GGG1QLN0NyMXu5P7URct7eZJEjap88rpiSHlERQC
         N+NVdR8CtHCv258N6g55AW1Ztics0eP/q69Sit0pFh1tDQgHDfDB0rNGBGNgGGznXWug
         19n5XVwsR0pQdD8wrxrghu55RWPyw2p8yJcM2HBntrQsANJEhmWgWceZXS2KA7cuUIIl
         8lqkfeuoT6lh8nSLF2W3R7Z/PotpezMFyLtelZe1nRCD0HWts9dlJd3J90KKRfW6sChU
         KGH3aRvbYKOPZMTRS3KoI6/1510FFaf2BpM4p8IxTHPbZl+tqpk45Jjm1aky5WE9gRzL
         R4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVUvT+2koHz8g3Wjj1CVm1KRIoQROsJxt0wh0aN38y6FgUkonca6pGOStI+wcdHt8GwHlPSVgc1dGSb0bU29T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9VHs9MBvQjDY20ydT1s2ZXyv7aPk4+P93lHZa17k+7h5wm6/
	rgRkRQOao6fCUhTtmLUcw8NSczsDPdQsi8Do7gsiAmkByGUcZ8lAPisM7qtxnBumJoEZYxZ9OIF
	B4oioBMk39OPo2h2l4o+hDe/H61iPLAcuMzJYuP3xbxumi26FrlpsBm/h1co=
X-Google-Smtp-Source: AGHT+IFsMcY8TrEVYELtpsDVknVu0JMqZUrNmOL68Ka8+iIm5wP2y+0iND7QsJL/qcXBcoJIn1dkzRwbmz3HHw8lvjZ1bYh9Wpf1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:c20d:0:b0:659:9a49:8e27 with SMTP id
 006d021491bc7-65b2353b59fmr532154eaf.25.1765290503432; Tue, 09 Dec 2025
 06:28:23 -0800 (PST)
Date: Tue, 09 Dec 2025 06:28:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69383207.050a0220.1ff09b.0008.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in
 l2cap_sock_suspend_cb (3)
From: syzbot <syzbot+b47462dd9d3cf7eb9729@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1149701a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=b47462dd9d3cf7eb9729
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b47462dd9d3cf7eb9729@syzkaller.appspotmail.com

kobject: kobject_add_internal failed for hci1:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci1: failed to register connection device
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_suspend_cb+0x50/0xb4 net/bluetooth/l2cap_sock.c:1748
Write of size 8 at addr 0000000000000588 by task kworker/u9:1/6144

CPU: 1 UID: 0 PID: 6144 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Workqueue: hci1 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:485
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:200
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 l2cap_sock_suspend_cb+0x50/0xb4 net/bluetooth/l2cap_sock.c:1748
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1258 [inline]
 l2cap_le_start+0x900/0x10c0 net/bluetooth/l2cap_core.c:1376
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1629 [inline]
 l2cap_connect_cfm+0x558/0xd40 net/bluetooth/l2cap_core.c:7305
 hci_connect_cfm+0x98/0x134 include/net/bluetooth/hci_core.h:2107
 le_conn_complete_evt+0xcc0/0x1184 net/bluetooth/hci_event.c:5799
 hci_le_conn_complete_evt+0x114/0x3f8 net/bluetooth/hci_event.c:5825
 hci_le_meta_evt+0x2cc/0x4b0 net/bluetooth/hci_event.c:7278
 hci_event_func net/bluetooth/hci_event.c:7586 [inline]
 hci_event_packet+0x6bc/0xf04 net/bluetooth/hci_event.c:7643
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4099
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3427
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
==================================================================
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000588
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000139adc000
[0000000000000588] pgd=08000001310ec403, p4d=08000001310ec403, pud=0800000122921403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6144 Comm: kworker/u9:1 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Workqueue: hci1 hci_rx_work
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __lse_atomic64_or arch/arm64/include/asm/atomic_lse.h:132 [inline]
pc : arch_atomic64_or arch/arm64/include/asm/atomic.h:65 [inline]
pc : raw_atomic64_or include/linux/atomic/atomic-arch-fallback.h:3798 [inline]
pc : raw_atomic_long_or include/linux/atomic/atomic-long.h:1069 [inline]
pc : arch_set_bit include/asm-generic/bitops/atomic.h:18 [inline]
pc : set_bit include/asm-generic/bitops/instrumented-atomic.h:29 [inline]
pc : l2cap_sock_suspend_cb+0x5c/0xb4 net/bluetooth/l2cap_sock.c:1748
lr : __lse_atomic64_or arch/arm64/include/asm/atomic_lse.h:132 [inline]
lr : arch_atomic64_or arch/arm64/include/asm/atomic.h:65 [inline]
lr : raw_atomic64_or include/linux/atomic/atomic-arch-fallback.h:3798 [inline]
lr : raw_atomic_long_or include/linux/atomic/atomic-long.h:1069 [inline]
lr : arch_set_bit include/asm-generic/bitops/atomic.h:18 [inline]
lr : set_bit include/asm-generic/bitops/instrumented-atomic.h:29 [inline]
lr : l2cap_sock_suspend_cb+0x58/0xb4 net/bluetooth/l2cap_sock.c:1748
sp : ffff8000a27973b0
x29: ffff8000a27973b0 x28: ffff8000a2797420 x27: 1fffe00019c58004
x26: 1fffe00019c58002 x25: 1fffe00019c58000 x24: ffff7000144f2e84
x23: 0000000000000002 x22: dfff800000000000 x21: dfff800000000000
x20: 0000000000000588 x19: 0000000000000000 x18: 00000000ffffffff
x17: 3d3d3d3d3d3d3d3d x16: ffff800082defcc0 x15: 0000000000000001
x14: 1ffff000125d3514 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000100000 x10: 0000000000012831 x9 : ffff8000b19a7000
x8 : 0000000000000002 x7 : 0000000000000001 x6 : ffff800080565b88
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000803c104c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __lse_atomic64_or arch/arm64/include/asm/atomic_lse.h:-1 [inline] (P)
 arch_atomic64_or arch/arm64/include/asm/atomic.h:65 [inline] (P)
 raw_atomic64_or include/linux/atomic/atomic-arch-fallback.h:3798 [inline] (P)
 raw_atomic_long_or include/linux/atomic/atomic-long.h:1069 [inline] (P)
 arch_set_bit include/asm-generic/bitops/atomic.h:18 [inline] (P)
 set_bit include/asm-generic/bitops/instrumented-atomic.h:29 [inline] (P)
 l2cap_sock_suspend_cb+0x5c/0xb4 net/bluetooth/l2cap_sock.c:1748 (P)
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1258 [inline]
 l2cap_le_start+0x900/0x10c0 net/bluetooth/l2cap_core.c:1376
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1629 [inline]
 l2cap_connect_cfm+0x558/0xd40 net/bluetooth/l2cap_core.c:7305
 hci_connect_cfm+0x98/0x134 include/net/bluetooth/hci_core.h:2107
 le_conn_complete_evt+0xcc0/0x1184 net/bluetooth/hci_event.c:5799
 hci_le_conn_complete_evt+0x114/0x3f8 net/bluetooth/hci_event.c:5825
 hci_le_meta_evt+0x2cc/0x4b0 net/bluetooth/hci_event.c:7278
 hci_event_func net/bluetooth/hci_event.c:7586 [inline]
 hci_event_packet+0x6bc/0xf04 net/bluetooth/hci_event.c:7643
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4099
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3427
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: 97840524 d503201f 97840483 52800048 (f828329f) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97840524 	bl	0xfffffffffe101490
   4:	d503201f 	nop
   8:	97840483 	bl	0xfffffffffe101214
   c:	52800048 	mov	w8, #0x2                   	// #2
* 10:	f828329f 	stset	x8, [x20] <-- trapping instruction


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
