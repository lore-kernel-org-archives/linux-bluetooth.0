Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC017D355
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227045; cv=none; b=MmO+joejf9M0OFIiwzVb8OZW+Hb2kpWeymFcvQmrnNjFS2k2hu+4cU+4vsKrpIbunegQJxDWyqgPXRVeBSpnJ8/qNyirCsLy/4i99ukTj84k1U9Z7vKQTw/bW/9vdiwQzy3tMkzbmNYsrr+DahBUtZFi3hU39NrG+NaoG5k4+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227045; c=relaxed/simple;
	bh=bQS/Z8hSCNa+UUBPm5Eq+ej84POnMjt56pV8bkoB5Hs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BjIoTuxXBPXPQsdYVznXcYsJTkPUgwTqWjfFfRrVnovNz+U/dJdyP+0sDBJY5Hd3TXwEfruf0ciVvCbYxx8hkL7wWR/s1kxiGh1C+wLMZykBQoomK8+n79XWNOWgSdE2OcDWHFMI8hHY0/sJJFfr6Zq2ufhH575xwevYWVeBciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so129335995ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 08:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227043; x=1742831843;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrSNfPkC4/dJSqogMc2C9zkXX5OF4FlmLIcj0/IqWpk=;
        b=ehXiK5cPayWGJMKYCqAjegapvMbuGwJRwgG7XVkQGFOujCn0zNJpA6zdCtAWofrCJF
         BtBwT4C4c1M7iHM+htFd5MKBpQ/WPvngidQTRX+5kyF6q+hEy4+zB6OD6zvGhaQzNlOm
         JR7YXPAAFNrQEh5HIoGpkFkCTtJVGI5WZy1MBaIWS+KOeq1w/QeB1gTzstVKQciAW6mH
         9wfVnZ3IDkDqS9t7Tx+27CVAsxWe0TXoMtMPS8cHROoZ6QYR+kBxxtQ4KRzjy/Bc2LuF
         5C7drbwO1pu2x5qx3lEOQXMoye947eCmYtTwIUK3FmSRZBBuFQAcGLnIuv9921aGfElU
         DbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSl7I91yztoweOiAsIDvk8s9iClq2edVXwzkCHT+HmEKNM9WK3N9AGTYrzm7NVqJvCyA+Z1NozmTJf+aB8Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1C2kBKbx0UL3FqH/qOg8uGdjfWI0svtWd6JSPvFG1a9ielDdx
	rmZx9N1FM5rT3UfGwiY1yhj0wJLFDH9IqT+TP0kkBv+tYag5qSg0dcEsBcX397HccQwF5+GzMAL
	4aTcw1LpivjJ8bUEAIykUKejPz/xYhWQaTEiJXehGfYwOHDUNRI9ZPlo=
X-Google-Smtp-Source: AGHT+IEK2YdpsCE23SJm/sdCC58aB+z+BP/BSb7MDUvAjVa1Oe9Bnrn+Ht7YD5EUiCVjjESpQGZe1vCiaBR7sWSFefqSYunEFo9Y
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:3d2:b72d:a502 with SMTP id
 e9e14a558f8ab-3d57ba14118mr5178855ab.22.1742227043117; Mon, 17 Mar 2025
 08:57:23 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:57:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d84663.050a0220.2ca2c6.0020.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
From: syzbot <syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78e3fd2b7e4b Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15b05874580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ddc962951c395b1d
dashboard link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f8d7598ad09/disk-78e3fd2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/493e8429a272/vmlinux-78e3fd2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c843736f7c02/Image-78e3fd2b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com

kobject: kobject_add_internal failed for hci1:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci1: failed to register connection device
==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: wild-memory-access in l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
BUG: KASAN: wild-memory-access in l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
BUG: KASAN: wild-memory-access in l2cap_connect_cfm+0x538/0xde4 net/bluetooth/l2cap_core.c:7245
Read of size 4 at addr deacfffffffffc8c by task kworker/u9:3/6449

CPU: 1 UID: 0 PID: 6449 Comm: kworker/u9:3 Not tainted 6.14.0-rc6-syzkaller-g78e3fd2b7e4b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: hci1 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_report+0xf8/0x550 mm/kasan/report.c:524
 kasan_report+0xd8/0x138 mm/kasan/report.c:634
 kasan_check_range+0x268/0x2a8 mm/kasan/generic.c:189
 __kasan_check_read+0x20/0x30 mm/kasan/shadow.c:31
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
 l2cap_connect_cfm+0x538/0xde4 net/bluetooth/l2cap_core.c:7245
 hci_connect_cfm+0x120/0x1d4 include/net/bluetooth/hci_core.h:2051
 le_conn_complete_evt+0xa70/0xf80 net/bluetooth/hci_event.c:5763
 hci_le_conn_complete_evt+0x114/0x404 net/bluetooth/hci_event.c:5789
 hci_le_meta_evt+0x2a4/0x478 net/bluetooth/hci_event.c:7162
 hci_event_func net/bluetooth/hci_event.c:7470 [inline]
 hci_event_packet+0x884/0x1060 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x31c/0xb04 net/bluetooth/hci_core.c:4015
 process_one_work+0x810/0x1638 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3400
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
==================================================================
Unable to handle kernel paging request at virtual address fbd51fffffffff91
KASAN: maybe wild-memory-access in range [0xdeacfffffffffc88-0xdeacfffffffffc8f]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[fbd51fffffffff91] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6449 Comm: kworker/u9:3 Tainted: G    B              6.14.0-rc6-syzkaller-g78e3fd2b7e4b #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: hci1 hci_rx_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
pc : atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
pc : l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
pc : l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
pc : l2cap_connect_cfm+0x53c/0xde4 net/bluetooth/l2cap_core.c:7245
lr : instrument_atomic_read include/linux/instrumented.h:68 [inline]
lr : atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
lr : l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
lr : l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
lr : l2cap_connect_cfm+0x538/0xde4 net/bluetooth/l2cap_core.c:7245
sp : ffff8000a1577460
x29: ffff8000a1577500 x28: ffff0000d4756000 x27: 1fffe0001afe1a03
x26: dfff800000000000 x25: ffff0000d47564b0 x24: ffff0000d7f0d01a
x23: dead000000000100 x22: ffff0000d7f0d2c0 x21: 1fffe0001b467007
x20: ffff0000da33803d x19: deacfffffffffc8c x18: 1fffe000366f6086
x17: ffff80008fbbd000 x16: ffff80008b7cba1c x15: 0000000000000001
x14: 1ffff0001262eaf8 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000100000 x10: 00000000000596ee x9 : 0000000000000000
x8 : 1bd59fffffffff91 x7 : 1fffe000366f6087 x6 : ffff8000803d4bfc
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000802f88ec
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline] (P)
 atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline] (P)
 l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline] (P)
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline] (P)
 l2cap_connect_cfm+0x53c/0xde4 net/bluetooth/l2cap_core.c:7245 (P)
 hci_connect_cfm+0x120/0x1d4 include/net/bluetooth/hci_core.h:2051
 le_conn_complete_evt+0xa70/0xf80 net/bluetooth/hci_event.c:5763
 hci_le_conn_complete_evt+0x114/0x404 net/bluetooth/hci_event.c:5789
 hci_le_meta_evt+0x2a4/0x478 net/bluetooth/hci_event.c:7162
 hci_event_func net/bluetooth/hci_event.c:7470 [inline]
 hci_event_packet+0x884/0x1060 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x31c/0xb04 net/bluetooth/hci_core.c:4015
 process_one_work+0x810/0x1638 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3400
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 52800081 aa1303e0 97568921 d343fe68 (38fa6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	52800081 	mov	w1, #0x4                   	// #4
   4:	aa1303e0 	mov	x0, x19
   8:	97568921 	bl	0xfffffffffd5a248c
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38fa6908 	ldrsb	w8, [x8, x26] <-- trapping instruction


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
