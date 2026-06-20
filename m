Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128321A92F
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954497; cv=none; b=A0Aayk66MLt9vFml2cfTCQvlg8uaJweDcHf/TzD+cZ4HFb56n8HBP9OGiYFBD2HHP1Vj8K8QVOAJQgDYeRh6kJTsg9a7vXiZKlirQm6SOHiJ+0KfmF3q1Nsp3QY4rcvacxaPSRXbhXG3P/LFFWQQPzSiEHRFDYhgjswrsAOtthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954497; c=relaxed/simple;
	bh=p0nAU1XbqHm6KaWCSJfair7wRbE8v3zDIK+mqVIdXj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSdsvyjDcSF8s3N9i1y5vmBysweWY5bd81q3tN9s1Le3ppZwXuFpz0AVppjH1aPZau1QUTNghXpDz3huz+z9ho+OZiQgotOdwrT7oFesm+MRgDQIrdPYLdr0TLDE50cTC6gfTZW1qxeaB91ZEDZpn4zQaa1Q6MVX/UJId48Yvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uQ5VV1Ss; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uQ5VV1Ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1781954492;
	bh=IIwH0sh+gMsNHDLU5JAlplgMjvQSpTaUy7naREahOuM=;
	h=From:Subject:Date:Message-ID;
	b=uQ5VV1SsBe7ebyB91J631POxqTvus1NPMNlX/M6CVJn7wI6q92CDXFJsK0PQJTKBh
	 jAJjKMk+BadCLyjRc3MgYUe0a/hS4crS3Onf6+J+5CY1xz7jSKnbO7iYWviQccesBr
	 EnpsCurxzdJ5uSGOhU1GGyS7J1QotSEDoaJMMaqE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A36779100000AC5; Sat, 20 Jun 2026 19:20:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7519896291969
X-SMAIL-UIID: 0D695E472D764220B13A5F012F61CE24-20260620-192050-1
From: Hillf Danton <hdanton@sina.com>
To: =?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
Cc: syzbot <syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in bt_accept_dequeue
Date: Sat, 20 Jun 2026 19:20:36 +0800
Message-ID: <20260620112038.1900-1-hdanton@sina.com>
In-Reply-To: <6a35e17e.6813c476.3c3d96.0001.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 19 Jun 2026 17:40:30 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8c13415c8a43 Merge tag 'media/v7.2-1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12f94d56580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a86d80fdec25236
> dashboard link: https://syzkaller.appspot.com/bug?extid=674ff7e4d7fdfd572afc
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3ecc105c1b32/disk-8c13415c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cda6390db722/vmlinux-8c13415c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5f3d326d7d36/bzImage-8c13415c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:283 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:366 [inline]
> BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:383 [inline]
> BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:839 [inline]
> BUG: KASAN: slab-use-after-free in bt_accept_dequeue+0x6bd/0x920 net/bluetooth/af_bluetooth.c:348
> Write of size 4 at addr ffff888036a17080 by task syz.2.3018/19569
> 
> CPU: 0 UID: 0 PID: 19569 Comm: syz.2.3018 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x13d/0x4b0 mm/kasan/report.c:482
>  kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:186 [inline]
>  kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
>  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
>  atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>  __refcount_add include/linux/refcount.h:283 [inline]
>  __refcount_inc include/linux/refcount.h:366 [inline]
>  refcount_inc include/linux/refcount.h:383 [inline]
>  sock_hold include/net/sock.h:839 [inline]
>  bt_accept_dequeue+0x6bd/0x920 net/bluetooth/af_bluetooth.c:348

Sounds like ab1513597c6c ("Bluetooth: fix UAF in l2cap_sock_cleanup_listen()
vs l2cap_conn_del()") fails to fix the root cause.

>  l2cap_sock_cleanup_listen+0x47/0x4d0 net/bluetooth/l2cap_sock.c:1517
>  l2cap_sock_release+0x69/0x280 net/bluetooth/l2cap_sock.c:1466
>  __sock_release+0xb3/0x260 net/socket.c:710
>  sock_close+0x1c/0x30 net/socket.c:1501
>  __fput+0x3ff/0xb50 fs/file_table.c:512
>  task_work_run+0x150/0x240 kernel/task_work.c:233
>  get_signal+0x1bd/0x21e0 kernel/signal.c:2810
>  arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
>  exit_to_user_mode_loop+0x139/0x6f0 kernel/entry/common.c:101
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>  do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc6feb9ce59
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc6ff9a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000120
> RAX: fffffffffffffe00 RBX: 00007fc6fee15fa0 RCX: 00007fc6feb9ce59
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 00007fc6fec32e6f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000800 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc6fee16038 R14: 00007fc6fee15fa0 R15: 00007ffdf85f63a8
>  </TASK>
> 
> Allocated by task 19587:
>  kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5334 [inline]
>  __kmalloc_noprof+0x302/0x840 mm/slub.c:5347
>  _kmalloc_noprof include/linux/slab.h:973 [inline]
>  sk_prot_alloc+0x10b/0x2a0 net/core/sock.c:2252
>  sk_alloc+0x36/0xe80 net/core/sock.c:2308
>  bt_sock_alloc+0x3b/0x3c0 net/bluetooth/af_bluetooth.c:148
>  l2cap_sock_alloc.constprop.0+0x33/0x1e0 net/bluetooth/l2cap_sock.c:1983
>  l2cap_sock_new_connection_cb+0x10f/0x260 net/bluetooth/l2cap_sock.c:1562
>  l2cap_connect_cfm+0x4e2/0xf80 net/bluetooth/l2cap_core.c:7481
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2136 [inline]
>  hci_remote_features_evt+0x4f4/0x9b0 net/bluetooth/hci_event.c:3764
>  hci_event_func net/bluetooth/hci_event.c:7800 [inline]
>  hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7851
>  hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4039
>  process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
>  process_scheduled_works kernel/workqueue.c:3405 [inline]
>  worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
>  kthread+0x370/0x450 kernel/kthread.c:436
>  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> Freed by task 19569:
>  kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2700 [inline]
>  slab_free mm/slub.c:6310 [inline]
>  kfree+0x22b/0x6c0 mm/slub.c:6625
>  sk_prot_free net/core/sock.c:2291 [inline]
>  __sk_destruct+0x88c/0xab0 net/core/sock.c:2391
>  sk_destruct+0xc8/0xf0 net/core/sock.c:2419
>  __sk_free+0xf4/0x3e0 net/core/sock.c:2430
>  sk_free+0x61/0x90 net/core/sock.c:2441
>  sock_put include/net/sock.h:2020 [inline]
>  bt_accept_unlink+0x22a/0x370 net/bluetooth/af_bluetooth.c:267
>  bt_accept_dequeue+0x791/0x920 net/bluetooth/af_bluetooth.c:336
>  l2cap_sock_cleanup_listen+0x47/0x4d0 net/bluetooth/l2cap_sock.c:1517
>  l2cap_sock_release+0x69/0x280 net/bluetooth/l2cap_sock.c:1466
>  __sock_release+0xb3/0x260 net/socket.c:710
>  sock_close+0x1c/0x30 net/socket.c:1501
>  __fput+0x3ff/0xb50 fs/file_table.c:512
>  task_work_run+0x150/0x240 kernel/task_work.c:233
>  get_signal+0x1bd/0x21e0 kernel/signal.c:2810
>  arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
>  exit_to_user_mode_loop+0x139/0x6f0 kernel/entry/common.c:101
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>  do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888036a17000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 128 bytes inside of
>  freed 2048-byte region [ffff888036a17000, ffff888036a17800)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888036a16000 pfn:0x36a10
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000240 ffff88813fe3b000 ffffea000132c210 ffffea00009e2810
> raw: ffff888036a16000 0000000800080005 00000000f5000000 0000000000000000
> head: 00fff00000000240 ffff88813fe3b000 ffffea000132c210 ffffea00009e2810
> head: ffff888036a16000 0000000800080005 00000000f5000000 0000000000000000
> head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10, tgid 10 (kworker/0:1), ts 48507424327, free_ts 27518573283
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1853
>  prep_new_page mm/page_alloc.c:1861 [inline]
>  get_page_from_freelist+0x812/0x3d20 mm/page_alloc.c:3941
>  __alloc_frozen_pages_noprof+0x27c/0x2b60 mm/page_alloc.c:5221
>  alloc_slab_page mm/slub.c:3289 [inline]
>  allocate_slab mm/slub.c:3404 [inline]
>  new_slab+0xa2/0x670 mm/slub.c:3447
>  refill_objects+0xe3/0x430 mm/slub.c:7241
>  refill_sheaf mm/slub.c:2827 [inline]
>  __pcs_replace_empty_main+0x375/0x660 mm/slub.c:4692
>  alloc_from_pcs mm/slub.c:4790 [inline]
>  slab_alloc_node mm/slub.c:4924 [inline]
>  __do_kmalloc_node mm/slub.c:5333 [inline]
>  __kmalloc_node_track_caller_noprof+0x6b5/0x890 mm/slub.c:5438
>  kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
>  __alloc_skb+0x185/0x710 net/core/skbuff.c:715
>  alloc_skb include/linux/skbuff.h:1386 [inline]
>  mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1773
>  add_grhead+0x299/0x340 net/ipv6/mcast.c:1884
>  add_grec+0x1389/0x1930 net/ipv6/mcast.c:2023
>  mld_send_cr net/ipv6/mcast.c:2148 [inline]
>  mld_ifc_work+0x3c5/0xc10 net/ipv6/mcast.c:2694
>  process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
>  process_scheduled_works kernel/workqueue.c:3405 [inline]
>  worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
>  kthread+0x370/0x450 kernel/kthread.c:436
> page last free pid 5380 tgid 5380 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  __free_pages_prepare mm/page_alloc.c:1397 [inline]
>  __free_frozen_pages+0x794/0x10a0 mm/page_alloc.c:2938
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
>  kasan_slab_alloc include/linux/kasan.h:253 [inline]
>  slab_post_alloc_hook mm/slub.c:4610 [inline]
>  slab_alloc_node mm/slub.c:4939 [inline]
>  kmem_cache_alloc_noprof+0x241/0x6d0 mm/slub.c:4946
>  vm_area_alloc+0x1f/0x160 mm/vma_init.c:32
>  __mmap_new_vma mm/vma.c:2547 [inline]
>  __mmap_region+0x104d/0x2dd0 mm/vma.c:2771
>  mmap_region+0x35d/0x620 mm/vma.c:2857
>  do_mmap+0xc63/0x12f0 mm/mmap.c:560
>  vm_mmap_pgoff+0x29e/0x470 mm/util.c:581
>  ksys_mmap_pgoff+0xe4/0x610 mm/mmap.c:606
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>  ffff888036a16f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888036a17000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888036a17080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff888036a17100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888036a17180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
