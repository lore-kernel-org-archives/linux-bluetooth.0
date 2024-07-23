Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE213D538
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768843; cv=none; b=LCyeWkDOJIlBu7ATcXNIzLBATqmmC/1g3aoq1gQPd73Yc2N0pwFviXjx8h8LfQ44rpMLgCTjK4nL0HIY7I/RhIPOYZD6P3dlYPEZGVMC4rBT7dmboLMBBe/1qLTcgBsIQMYn/EHPeeoHi+TO5HrUQTVKvap1CfbNFoH1S788uNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768843; c=relaxed/simple;
	bh=685U6xRrk9Niks7TMgxDEgbUAvN4igfvtzi3ttrZAVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HOR10aLLXV2BRuHJtydO4ZTqxM1rB/O1nl6xzWHiLMIuZawVy+Ut2ZPAgxCqSc8aVS8Wylq56sIIt89icKQ00lzFGOUoAXTdQoYReBiFYrAkLNdAxd91qlRObBWiVOH6TRMQGUQ9nTuhy6MQNrXYDIphJ3P9/R8ujs4R3o1MP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39673758efeso89092065ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 14:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768841; x=1722373641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKV5entdyuyqCkhse82tfmI5Y8Iw8p8fgLMn5aF7LYY=;
        b=fMfHVcMzeLxQJKefa79RsG1jPyU/MM2hpmVrNtuaqA0SDtE1FSCY/G3tzDgnu2qFem
         IfGPKdJYSIR/kJsPtb2Sz2M3NHZ4ME7doEKmKNrQ5NYwhtw30Iyqd7FwkCEXmur9qbO0
         5WPxqG5SgbFvdSP/Wcrt+LFvfiMGZrVnNutahULV1ZhhoT0hZFK1ddCMpyQQrdAOzhiO
         dXEDtja8hsQeBo1anhGzjvJSKeuZK4B8QK1kpGX9ee1PFW+kEAAshB3F7WgslpU2g5No
         hGS7ig31QB3CGBTxm0ZkUJEBEyHM5iz4JcloQtNwQ07qhiKS1tB5DZXjRvoVk4MHQco+
         gQEg==
X-Forwarded-Encrypted: i=1; AJvYcCVBE51KDFwq9n1fT+qXtJJjhqee9/xeEwx8+80c/hdd3vcsrC1UgnFL7bAsK6RXtryJdpDvduUF+tQIEaFkBwoFMErGsDORah7VB6XjEgTb
X-Gm-Message-State: AOJu0YyKvpGDEaNidk4RTpxwL4+qIsIRWc+QOp11oERz005nJMCDt7e9
	kabxQfiW442liWqcA0mdFJPQoVqOmA0+U/5I+y4KS6GgVZ5g1pft87YCp+Meva+9qfG61r6bq9s
	aFKessgL8RwCN5/df+Xrb3iFB1QkQs+cdZ4ZshiXvgsNLfsp+SBi5IZU=
X-Google-Smtp-Source: AGHT+IGOq8EnuxF1rGOzUtWxHbKmi2JXzjtZG9okOXvtLB9HPN2u675AX7s7VarmG0LWlBdKGL89eD3FO0hynT/rZyGv80d7trby
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d82:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-398e8b665f5mr4955245ab.6.1721768841150; Tue, 23 Jul 2024
 14:07:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:07:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029981d061df08c8d@google.com>
Subject: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12628cad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9593db3ad921/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77c4ed0c2bb7/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1e492f9354b/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_scodata_packet net/bluetooth/hci_core.c:3835 [inline]
BUG: KMSAN: uninit-value in hci_rx_work+0x10a8/0x1130 net/bluetooth/hci_core.c:4039
 hci_scodata_packet net/bluetooth/hci_core.c:3835 [inline]
 hci_rx_work+0x10a8/0x1130 net/bluetooth/hci_core.c:4039
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3985 [inline]
 slab_alloc_node mm/slub.c:4028 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4071
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:489 [inline]
 vhci_write+0x128/0x910 drivers/bluetooth/hci_vhci.c:609
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0x91/0xe0 fs/read_write.c:652
 ia32_sys_call+0x2e34/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:5
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 1 PID: 5058 Comm: kworker/u9:6 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci3 hci_rx_work
=====================================================


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
