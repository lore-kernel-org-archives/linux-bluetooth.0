Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC522D790
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913152; cv=none; b=W59XuNrtI8BkYKcn4fNv3mGLNz+Sfz2JYnJqCTF9/oLzqcW9JhWN91coHksK1izSg4O4sh3DODZ55siV2F058fYLVbNs2l4vVRpewm+Zf4XImqGW7Zn+woSOmGrt11SPyj64T/Jj2GLQIP9rne1gSBdGGwg6fycK+VyxIxv4ALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913152; c=relaxed/simple;
	bh=8GiBBHQtfHOqzVmO7ETkwvN+twiPkofVYk2vF8hzh38=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bBBU7eV/vT57qG+ossyT/21gBFlA7743cLNDXKlbr2WIivMMogTGD2Qds7FeXzWnse2IlIinPYQYBn/WPaN/iSPa8j85j/+Er5OGcbb6UhNAPwL5agx3u5jUeZaLUI8rLcC3UAPVgVWvyg65/kH9qTf7zI9fUbuf4eJfx5UER+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d126265baso321976439f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 11:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913149; x=1752517949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlY8XzQoFKoWs7qfmY3eXvDw2cI1dpWN0OkxWj1+lnw=;
        b=sNlVXa40kSCwYtBHkxFnXCLS+SrrJ5Q7MlKwUhHKzPCkihqa91CWCYU+auuKFg4/J/
         BAYXbnJaFv1wrB9+AneFJUZ00ltt/A7RG8vSG37CjaJq3sQszX7jpKY3bh9S3WHXL7Dp
         Dd03s8njrSW1hoaUSF8E0YuKasJ14V6dcsi8JXep/raWu+ALNhXDmetkAec5CqTLfHyh
         3U42FfGIuslJ9HRaTYY8n8Yi33ogSdQyHDuiaAcIlKizMsB9nb+/i4nMbsve+aFahawy
         fD8IzeK9xmN+4Jf8pjuZpzk7tTZ5zb4E5KmMPQ05m1+IgULUW6o1XtDTuvjiomLJGqRJ
         m8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUWiL0THF3jJ71t/BdcY0LvHDaSSfdxfmYCcm9z/cOmZOoH83Otp5mr1mE7MOP43LC/ZHeiyNJTfkKLghwE0u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjN2NDUwmjr43nE0ylqpVkBbSyIY1RoaCPLyGU4FNx/nN5yV9J
	8209PC+IgU47V4EDHudHQhp6Q8HirNtICidDf/lZErF7F0DTiSRCDb5sUVE1w9gTcQa4s0D75v+
	hhRJPYSbv7h2wssW8+2j3a6QbaiX3+1QW4xa0ZJ4jKbelz07XhOGcbwRt2qw=
X-Google-Smtp-Source: AGHT+IG6yNnQ72xHq9NTlfxRXNyfzdNtSpzEJBPqaM6dD/lmZSg1jnqnnTf+VrJfGijBrgADT2S8rw8fC1g1TOPJdzRi1uKPNDgY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1587:b0:861:7d39:d4d3 with SMTP id
 ca18e2360f4ac-8794b431a8amr17982739f.3.1751913149022; Mon, 07 Jul 2025
 11:32:29 -0700 (PDT)
Date: Mon, 07 Jul 2025 11:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c12bd.a70a0220.29fe6c.0b13.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in
 l2cap_sock_resume_cb (4)
From: syzbot <syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1597828c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=e2df3a66f7d16fa6ec55
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c4cbd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d11f70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com

Bluetooth: hci0: unexpected event 0x06 length: 4 > 3
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
Write of size 8 at addr 0000000000000570 by task kworker/u9:0/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:524
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
==================================================================
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000570
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
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000121d3b000
[0000000000000570] pgd=0800000121d58403, p4d=0800000121d58403, pud=0800000121d81403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Tainted: G    B               6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:131 [inline]
pc : arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
pc : raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
pc : raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
pc : arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
pc : clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
pc : l2cap_sock_resume_cb+0xc0/0x17c net/bluetooth/l2cap_sock.c:1711
lr : __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:131 [inline]
lr : arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
lr : raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
lr : raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
lr : arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
lr : clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
lr : l2cap_sock_resume_cb+0xbc/0x17c net/bluetooth/l2cap_sock.c:1711
sp : ffff8000991975b0
x29: ffff8000991975b0 x28: ffff0000d89f6000 x27: dfff800000000000
x26: ffff700013232ec8 x25: 0000000000000001 x24: ffff80008db6f6c0
x23: ffff0000d89f6480 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000570 x19: 0000000000000000 x18: 1fffe000337d8876
x17: 0000000000000000 x16: ffff80008ae642c8 x15: 0000000000000001
x14: 1ffff000125d90f8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000125d90f9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099196e18 x4 : ffff80008f766c20 x3 : ffff8000803b80e0
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:-1 [inline] (P)
 arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline] (P)
 raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline] (P)
 raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline] (P)
 arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline] (P)
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline] (P)
 l2cap_sock_resume_cb+0xc0/0x17c net/bluetooth/l2cap_sock.c:1711 (P)
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
Code: 977fc1f2 d503201f 977fc0f7 52800048 (f828129f) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	977fc1f2 	bl	0xfffffffffdff07c8
   4:	d503201f 	nop
   8:	977fc0f7 	bl	0xfffffffffdff03e4
   c:	52800048 	mov	w8, #0x2                   	// #2
* 10:	f828129f 	stclr	x8, [x20] <-- trapping instruction


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
