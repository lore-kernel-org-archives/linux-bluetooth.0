Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC335965
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Oct 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263348; cv=none; b=YxxIwhW/lHCNpM0zajFOK7M758/TRK4H1nDxWaU/5FCdQLc0t5iyP6YMCLmdrrb8TLNugq4rFl4K5u9hSntlwv24vgN/kFVja0Mrr7+/0EsXOIoR0jcXsD1i3X6Fk90BRCOU0nX9IC4anuLCg1/vigjuppQ/fj61CVeA1kIHIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263348; c=relaxed/simple;
	bh=OdkLd1I+EBYThmSe0I1aHv9HruomWel25clqWoCxYJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AF0Q7tzeFTeyJkN3Z2PoOx2V7+gZ4L4xZ58syhoohLxJafafAouFSNlgYL4BDENj9+aTVGPDEly9ZU5SRU1eaOuIlU73x/Eg4FAPmG92GgyMdrqq0upGMabFJLVelb3rx5yc0yARdW41AilOYrvIdc9nSlZFJ3ImbogeskdiulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so1020153539f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Oct 2025 03:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263346; x=1760868146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8inZ+mxfoQeGzYTANyypkKww5kkO+VORwCxx0cMU1Lo=;
        b=ulQuI8w81uGzEF3cVXM1l8d7ndlLwQ7Ws4H15pgT692F/QPO8v58JU7W0eRvgsndS1
         P+wx3lfzyqy9bDXrW2kg0ozs5gsr7nGQQBsTWz11Ct171BUL6N+PSuKrNoox1GjQpZGb
         fYZH2+KnA+TWtsALAIlM2a/0QV/jBEQ9c2FBXE5MINPCzcpzjMDYKV35mBizXqWx9Zaf
         nd/uPwEsId0o6Ub+0xXgoJyoeWC3kvi+FiSNzqw2a7tfElphkdtjuphX4jpLraIvMSzY
         M5rv6dv2+lFjhUrOFDHy0VRAFpyjUnzDsmrj/D54UzTkmiFa8ZSyPEAB7UFLWKnuOCua
         VcWA==
X-Forwarded-Encrypted: i=1; AJvYcCVYaH4Zs5grhYLaNOW+YyGjbFZriNoG3KIqWls8f5OWzJsWJ/lSviqT00BIeROysASKM4ijNmkjBHgAho+Q/2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8P1sR4/iYrZT6v5lEt1o3oAEwr9ZCWOMoyIWvMkgRKZxaJzz
	qCQdCo6Lr3d5dpUqIkwxrzuzeqDHAqnaUX/quZCC9wbQXAk73elZbEe7oWHJC8qWFip451oPlVr
	O+03+ddqP3NksRrSOgHnB2CdGG75jvpLt3X13Z3Xhk7yInZEY1qpWHOkY1/o=
X-Google-Smtp-Source: AGHT+IG6OWO1AhwSSuGVsjgfZ70l5VInCthpUN6b+ByBCk9KJNzIV5GopI2UlC8XR98YMxOrxln3Lo5boDABcE9IQKcPrrUGmqtK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:42f:a7ee:4930 with SMTP id
 e9e14a558f8ab-42fa7ee500bmr67166875ab.8.1760263345955; Sun, 12 Oct 2025
 03:02:25 -0700 (PDT)
Date: Sun, 12 Oct 2025 03:02:25 -0700
In-Reply-To: <67d84663.050a0220.2ca2c6.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68eb7cb1.050a0220.ac43.0009.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
From: syzbot <syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com>
To: hdanton@sina.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b763d465239 Add linux-next specific files for 20251010
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175829e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f63304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1384067c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a00344625c3/disk-2b763d46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd34c500f8eb/vmlinux-2b763d46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/660905c62cb2/bzImage-2b763d46.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com

 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
kobject: kobject_add_internal failed for hci0:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci0: failed to register connection device
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_conn_ready net/bluetooth/l2cap_core.c:1623 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect_cfm+0x6e4/0x1040 net/bluetooth/l2cap_core.c:7304
Read of size 8 at addr ffff888071324480 by task kworker/u9:1/5146

CPU: 1 UID: 0 PID: 5146 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1623 [inline]
 l2cap_connect_cfm+0x6e4/0x1040 net/bluetooth/l2cap_core.c:7304
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2106
 le_conn_complete_evt+0xfb8/0x1500 net/bluetooth/hci_event.c:5789
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5815
 hci_event_func net/bluetooth/hci_event.c:7560 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7617
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5146:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3d5/0x6f0 mm/slub.c:5725
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 l2cap_chan_create+0x50/0x760 net/bluetooth/l2cap_core.c:445
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1906 [inline]
 l2cap_sock_new_connection_cb+0x182/0x2b0 net/bluetooth/l2cap_sock.c:1485
 l2cap_connect_cfm+0x37a/0x1040 net/bluetooth/l2cap_core.c:7287
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2106
 le_conn_complete_evt+0xfb8/0x1500 net/bluetooth/hci_event.c:5789
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5815
 hci_event_func net/bluetooth/hci_event.c:7560 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7617
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6092:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2515 [inline]
 slab_free mm/slub.c:6574 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6781
 l2cap_sock_cleanup_listen+0xea/0x3e0 net/bluetooth/l2cap_sock.c:1468
 l2cap_sock_release+0x6a/0x210 net/bluetooth/l2cap_sock.c:1426
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888071324000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1152 bytes inside of
 freed 2048-byte region [ffff888071324000, ffff888071324800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x71320
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe27000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe27000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001c4c801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5935, tgid 5935 (kworker/1:4), ts 91888484672, free_ts 91755679836
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3031 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3204
 new_slab mm/slub.c:3258 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4628
 __slab_alloc+0x65/0x100 mm/slub.c:4747
 __slab_alloc_node mm/slub.c:4823 [inline]
 slab_alloc_node mm/slub.c:5234 [inline]
 __do_kmalloc_node mm/slub.c:5603 [inline]
 __kmalloc_node_track_caller_noprof+0x5c7/0x800 mm/slub.c:5713
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:601
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack+0x13c/0xc40 net/ipv6/mcast.c:1775
 add_grhead+0x5a/0x2a0 net/ipv6/mcast.c:1886
 add_grec+0x1452/0x1740 net/ipv6/mcast.c:2025
 mld_send_cr net/ipv6/mcast.c:2148 [inline]
 mld_ifc_work+0x6ed/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
page last free pid 6090 tgid 6090 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 __slab_free+0x2e7/0x390 mm/slub.c:5924
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4947 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5253
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2922 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888071324380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888071324400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888071324480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888071324500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888071324580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
