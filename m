Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69852DFA3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562748; cv=none; b=T4LaLWyf5SAVAJHAr7dA8Is5LtmiZWkEM12cK+86idzWW9gccWCesXQZPNj+odYkt+G4qP3HpFLa7FbgTMZQr52KQq4/UV0zss8vCiZmURHkszAwamEYNXJ6bLMaVxRtKyXgdqbj8znlaVsiKBbp9xxAhHgLFFH/3y8+7hYItnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562748; c=relaxed/simple;
	bh=t01LfuAVULG91tMirrMjjfRdnVShcrFuHJ32NoxDbt4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bKGc+zSreiCq7Ig9EpTKiziLvi12y7B05h5N8RYHlcJLxQ0ovVBbE1ZrqpQau92xHpcoOla8m4xv28ONZDxMTYAchCF7n7kYF/QIsC3QJfm2sGVkQ/7+Cyy9azIw8nE3Fjr6fP05uenvCtw8Tidt5Tje1LR9EVyNehRamlY682I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6966db8db16so1327564eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562746; x=1778167546;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi7+nHyxNMMyBqWBoFrP86Vq+RgfFCkXSUrvnF7snhI=;
        b=YAfz91VkdgVx6om/xYcNRuZdfSzCtZEzhNSDvjzIFGTKdxFWt50HPpCzc4cUIs+4mY
         +IJqmPTWsB2l03Y+b5t6JU5sYElFaSSHG3vCH0ruhbUpxhy5gEHAtIE7ozmWO6z8ts7p
         eaEaYcwtyWsxNmih/OUW0NexD+b3x1wzplDyx4p5x/WJOwTxX9FOHyEUmAZ7iBjQpSXN
         xEm0R62Hc5mudSQlqSNr/8BXHKASZogW6OwgskeCBxKFf+H6dc3tBwKEUSRxl3oXPbfy
         nWIOVNY/XHlPrUd/ypEvJzVtvRZF2zfk+TFH5XptBc2c9VgLP9zrp0wJhFTEii4ln0Yg
         KcrA==
X-Gm-Message-State: AOJu0YxHqPcLGjLaRTInKlFklyT0tmdwGvnZxdO0joq9Xo/VyMuPj3Er
	R8ND3ztNSQ7laGpD2AD5qK3Xr72NXR2tcT1K9eygHXJf9xITKuK9TP+0QlSA1fzfaQDackBmw49
	A/kxncYbzWkvnnsqZoDlyn9SKezOP28DH/VPGtjyoaHLCxI1hBdiF2P/VBaByNg==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f02e:b0:694:99b7:1a2 with SMTP id
 006d021491bc7-6967a4e24ebmr1563140eaf.22.1777562745780; Thu, 30 Apr 2026
 08:25:45 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:25:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f37479.170a0220.5f1b.0004.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_pull (2)
From: syzbot <syzbot+da2717d5c64bf7975268@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0787c45ea08a Add linux-next specific files for 20260429
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e219ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc6dd31c8eef55aa
dashboard link: https://syzkaller.appspot.com/bug?extid=da2717d5c64bf7975268
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2eccbc923d17/disk-0787c45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68b90b45c92d/vmlinux-0787c45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b9de0f776c/bzImage-0787c45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da2717d5c64bf7975268@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in skb_pull_inline include/linux/skbuff.h:2853 [inline]
BUG: KASAN: slab-use-after-free in skb_pull+0x133/0x1d0 net/core/skbuff.c:2664
Read of size 4 at addr ffff888040ca5e30 by task kworker/0:8/5871

CPU: 0 UID: 0 PID: 5871 Comm: kworker/0:8 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Comput[  699.645251][ T5871] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events hci_uart_write_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 skb_pull_inline include/linux/skbuff.h:2853 [inline]
 skb_pull+0x133/0x1d0 net/core/skbuff.c:2664
 hci_uart_write_work+0x44d/0x720 drivers/bluetooth/hci_ldisc.c:168
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 9:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4577 [inline]
 slab_alloc_node mm/slub.c:4906 [inline]
 kmem_cache_alloc_node_noprof+0x22a/0x6e0 mm/slub.c:4958
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 h5_prepare_pkt+0x1b3/0xc40 drivers/bluetooth/hci_h5.c:728
 h5_dequeue+0x1ba/0x840 drivers/bluetooth/hci_h5.c:797
 hci_uart_dequeue drivers/bluetooth/hci_ldisc.c:107 [inline]
 hci_uart_write_work+0x29b/0x720 drivers/bluetooth/hci_ldisc.c:161
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 15008:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6258 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6385
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 hci_uart_flush+0x9d/0x360 drivers/bluetooth/hci_ldisc.c:235
 hci_uart_close drivers/bluetooth/hci_ldisc.c:268 [inline]
 hci_uart_tty_close+0x99/0x2d0 drivers/bluetooth/hci_ldisc.c:545
 tty_ldisc_kill drivers/tty/tty_ldisc.c:613 [inline]
 tty_ldisc_hangup+0x444/0x630 drivers/tty/tty_ldisc.c:729
 __tty_hangup+0x3eb/0x660 drivers/tty/tty_io.c:621
 tty_vhangup drivers/tty/tty_io.c:691 [inline]
 tty_ioctl+0x75d/0xde0 drivers/tty/tty_io.c:2732
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888040ca5dc0
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 112 bytes inside of
 freed 240-byte region [ffff888040ca5dc0, ffff888040ca5eb0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40ca5
memcg:ffff888040e64101
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88801dac5a00 dead000000000100 dead000000000122
raw: 0000000000000000 00000008000c000c 00000000f5000000 ffff888040e64101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1182, tgid 1182 (kworker/u8:10), ts 217707286874, free_ts 217702375992
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x27d6/0x2850 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5249
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab+0x74/0x5e0 mm/slub.c:3404
 new_slab mm/slub.c:3447 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7263
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4659
 alloc_from_pcs mm/slub.c:4757 [inline]
 slab_alloc_node mm/slub.c:4891 [inline]
 kmem_cache_alloc_node_noprof+0x4f4/0x6e0 mm/slub.c:4958
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:819 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:876 [inline]
 nsim_dev_trap_report_work+0x29f/0xbd0 drivers/net/netdevsim/dev.c:922
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 29 tgid 29 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0x1075/0x11b0 mm/page_alloc.c:2938
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core kernel/rcu/tree.c:2869 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888040ca5d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888040ca5d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888040ca5e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888040ca5e80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888040ca5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
