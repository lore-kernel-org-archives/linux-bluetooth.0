Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126361F4C90
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664010; cv=none; b=ip1T2s2uHbk6q5hUDctQgTHlRWqLdm/RWrB11mDFmGAScGhL4uOJ91eU37UGz1zboFXZfJxh2LzWpGZ3NnwGaM7caURzK93Phdj8myLsQup1UGW3BD5DaBqWydunuI5+zltCHOCcPCpYMsjepReZNGl9FRwqsmPvL2zq5GB+Ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664010; c=relaxed/simple;
	bh=jxZnIwji03DzpLtxPB3Ci5Y7Xiwnnj7TlcPTA6Em4LA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MgX2veV1bfmfNF80bsgT+iZ15noJv/mCgCZH+1z4lA43jpnQ2+GOkcGn32IAKU9mUotgoXMANuj7hjyv6fEknOlFkY5w9LLhjmC0fKEVm4QWLfwOEe/qWHBilHY3ek++1uFIl9yxaHzx6jPPwJ/FsZLk1fPq1lMFBr+cIHdOf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so39239085ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 00:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750664007; x=1751268807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42zE3RBeArhal+twX+lm6xC7IxM2KI3lnkpszBoa0Sc=;
        b=prhcZcaGt7ypKG+DdwtEV3EmpodlA/4AM1FDjxnqQRDrzZ6s6/kbsE8YkPQ7pxqAqB
         yTM2ngu3w9ozAV/bJNkA825ypRTtl3JtAGrwr9H00b62etHt+WRF5uvpAFUlsxv2IiFJ
         IVojAxbwnH8lBBmAIbEWvoRyp6wiI//W0NPeH8x2i0juHU47GNXhDrqIUberQRVZFxr6
         ZUfOYj7AeKXP0Y46rafAOoczp+FCto14IMXOvFCFRZkvSCXpZ1/mJxBJPCq6ZfEL7UZr
         Ptd1feSATJsq9ypRhmL/dWf7z/MkhE69+eGGu8g8psZ3+x1Z628YJzw5Mn248epB+eCj
         a6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUt6vRpD3Oq487kwVJvhF1jtYKSA7RENEyrZi16LqsREnQ2PGQWyoS7Nh90bmiQEs+cG/QkGpACde9KZGZrW1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHtWZn3P+OZO+dhtCfQFq+al2D83dbR8CMrRKQOERV3KqUAJxh
	rxtpSKmSPxFK2a8IYrJ//4tfs04CWF1uEVBtOPuMbzi7DTfAivJxGt8u549du8HVrbxvDwkv6SO
	Wd7N9fgaGfgFaJsRV9FUEzS3mAMKEPrlkiwj0KQvFgqEWNmxuDD0wDE2ENzI=
X-Google-Smtp-Source: AGHT+IGF58Y9drH0iEqaWNTuvvHYq35zVjuteVQfa8pZcIfLwkv8NRYqAefYF+brpN29li9xQaam5BLckHzlGDcS6UfEFNDjvlxY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3091:b0:3de:2a57:b422 with SMTP id
 e9e14a558f8ab-3de38c97efdmr111407255ab.13.1750664007248; Mon, 23 Jun 2025
 00:33:27 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:33:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68590347.a00a0220.2e5631.0012.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Write in enqueue_timer
From: syzbot <syzbot+9a208975a1c11c5b08ba@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1478f50c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6f01a06a8393850
dashboard link: https://syzkaller.appspot.com/bug?extid=9a208975a1c11c5b08ba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/930148c1caee/disk-52da431b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9a6a572fb57/vmlinux-52da431b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63f7fba6adb/bzImage-52da431b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a208975a1c11c5b08ba@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hlist_add_head include/linux/list.h:1026 [inline]
BUG: KASAN: slab-out-of-bounds in enqueue_timer+0x515/0x540 kernel/time/timer.c:616
Write of size 8 at addr ffff8880343592e0 by task kworker/u9:0/3781

CPU: 0 UID: 0 PID: 3781 Comm: kworker/u9:0 Tainted: G     U    I         6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full) 
Tainted: [U]=USER, [I]=FIRMWARE_WORKAROUND
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_devcd_rx
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 hlist_add_head include/linux/list.h:1026 [inline]
 enqueue_timer+0x515/0x540 kernel/time/timer.c:616
 internal_add_timer kernel/time/timer.c:645 [inline]
 __mod_timer+0x8ce/0xd30 kernel/time/timer.c:1136
 add_timer_global+0x8a/0xc0 kernel/time/timer.c:1283
 __queue_delayed_work+0x33a/0x460 kernel/workqueue.c:2526
 queue_delayed_work_on+0x1b5/0x200 kernel/workqueue.c:2561
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 hci_devcd_handle_pkt_init net/bluetooth/coredump.c:207 [inline]
 hci_devcd_rx+0x1202/0x1780 net/bluetooth/coredump.c:351
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 13:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4347
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:601
 __alloc_skb+0x166/0x380 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2b1/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 13:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 skb_kfree_head net/core/skbuff.c:1048 [inline]
 skb_free_head+0x114/0x210 net/core/skbuff.c:1060
 skb_release_data+0x776/0x9c0 net/core/skbuff.c:1087
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb net/core/skbuff.c:1166 [inline]
 consume_skb net/core/skbuff.c:1398 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1392
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x8bd/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888034358000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 736 bytes to the right of
 allocated 4096-byte region [ffff888034358000, ffff888034359000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34358
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000d0d601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 13, tgid 13 (kworker/u8:1), ts 1469294891901, free_ts 1469154874477
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4347
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:601
 __alloc_skb+0x166/0x380 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2b1/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5828 tgid 5828 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 __folio_put+0x329/0x450 mm/swap.c:112
 folio_put include/linux/mm.h:1356 [inline]
 put_page include/linux/mm.h:1425 [inline]
 put_netmem net/core/skbuff.c:7375 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x7fb/0x9c0 net/core/skbuff.c:1081
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb+0x4f/0x70 net/core/skbuff.c:1166
 tcp_wmem_free_skb include/net/tcp.h:309 [inline]
 tcp_rtx_queue_unlink_and_free include/net/tcp.h:2164 [inline]
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3441 [inline]
 tcp_ack+0x19b2/0x5c90 net/ipv4/tcp_input.c:4049
 tcp_rcv_established+0xda1/0x22e0 net/ipv4/tcp_input.c:6216
 tcp_v4_do_rcv+0x5ca/0xa90 net/ipv4/tcp_ipv4.c:1925
 sk_backlog_rcv include/net/sock.h:1148 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:3213
 release_sock+0x5a/0x220 net/core/sock.c:3767
 tcp_sendmsg+0x38/0x50 net/ipv4/tcp.c:1397
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x4aa/0x5b0 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c7/0x1150 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888034359180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888034359200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888034359280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff888034359300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888034359380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
