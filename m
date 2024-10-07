Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CA1DE4EE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335704; cv=none; b=pYHx5oco80qJYW92QmAerKXzDrj7tSKpbDzTHsJh7En24sSQ7LyvtSMZVI2GbiEzL+6zOcD4QfTH5/sNRHRP6dG6uFbTadtsd3/6iV0/IwIwQsoFKfS8EydsoESgvqR7TyV9Ott+v2D+iiXe1ZS4N6qPqh1l7PFe/5AQRSNLfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335704; c=relaxed/simple;
	bh=nIvYttVqS1dOGuvWGlnq00OeE0ZYeJ+HP1nuKeqIn/8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bWBEyC8YP38s+5u/W9ZLZkZKZO3RfVDI06NtRnkvx94Hz5ZMPX6KLT5dJ482onQSQdiRVYv+HptbBnVJyog+R0anPRtleJju9eyS9JgMj7NfWDC3sFaEIOMwYdGuGUTlUYxXbb6+vvJZDjWoKKLAqXLGU2so3Cmq8oOOeo0Q85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cedb7a183so406872139f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 14:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728335702; x=1728940502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ0iP6dFGATX9FKowoPimLODmBORYDHFhrEwVX0Tn+0=;
        b=xTCusAmQ9ytH2h+rS5kwPXHH5JuvMn8RFu204JdINTGdZ00Z2U/tmpO6e7UeVtrhuU
         2ae8aRUusqxADakYkr9Jnl717W/nID5g0AkG0qOfSorv9HklQJmYJhbKeQjvOvid5s+J
         M45biJNmRatYyJasdWt641/cUrmxIYsmwzL6pQZNE4/TO5waaLURUwOvXlQ4ZZX0skEw
         EJqPqtH0vc4BQDUZTasTCdsj3XqRUftkRGdLJU5gqWmg0ahRfeCjD9CzOQqFGj4T8R4B
         ElDoYH32IC8OWl2fNLg405vzjalQLpMyN3i5PnuQpWFvVsOws8ME7CXLzCFK9RJME5sq
         gSYA==
X-Gm-Message-State: AOJu0YxAg6/FMpOYir/rLigPYd4php1P52VBq45a1OpO1Yl/Ux085g18
	9nSMmjPXehqYk3wyGXW+ZfhAAwKicC7UraHdZ06vOc+5JqDYRk2bAK9dZ1hO+R90vWrofHPkD/L
	mu2tR/Fj+enKvExUnTqIDjlqQcrbMSJrxXo4WCOiN5w829dgRnbiifEM=
X-Google-Smtp-Source: AGHT+IGn0uZ8j06w8UJktLxQCF9dLPij8b6emhd824p7l3XnvmAavNJtSAPJ5pLv1HJ19AQSlKAmwskbTZs0ieWc+nRv2+TcgkZj
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d2:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-834f7d62631mr1471835839f.11.1728335701913; Mon, 07 Oct 2024
 14:15:01 -0700 (PDT)
Date: Mon, 07 Oct 2024 14:15:01 -0700
In-Reply-To: <CABBYNZKc5UFjYL5XxX0qy7vdOEENT1Pj7u6U4Pk+_cdJE+zAsg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67044f55.050a0220.20acde.1ecd.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_sock_timeout

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0xa2/0x2d0 net/bluetooth/sco.c:140
Write of size 4 at addr ffff888140eac080 by task kworker/0:2/921

CPU: 0 UID: 0 PID: 921 Comm: kworker/0:2 Not tainted 6.12.0-rc2-syzkaller-g87d6aab2389e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:781 [inline]
 sco_sock_timeout+0xa2/0x2d0 net/bluetooth/sco.c:140
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5764:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2164
 sk_alloc+0x38/0x370 net/core/sock.c:2217
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:543 [inline]
 sco_sock_create+0xbb/0x390 net/bluetooth/sco.c:574
 bt_sock_create+0x163/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x492/0x920 net/socket.c:1576
 sock_create net/socket.c:1627 [inline]
 __sys_socket_create net/socket.c:1664 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1711
 __do_sys_socket net/socket.c:1725 [inline]
 __se_sys_socket net/socket.c:1723 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5765:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x479/0x5f0 net/core/sock.c:2292
 sco_sock_release+0x25e/0x320 net/bluetooth/sco.c:1302
 __sock_release net/socket.c:658 [inline]
 sock_close+0xbe/0x240 net/socket.c:1426
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 get_signal+0x15e8/0x1740 kernel/signal.c:2690
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888140eac000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff888140eac000, ffff888140eac800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888140eab000 pfn:0x140ea8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000240(workingset|head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000240 ffff888015442000 ffffea000515b410 ffffea000510e610
raw: ffff888140eab000 0000000000080006 00000001f5000000 0000000000000000
head: 057ff00000000240 ffff888015442000 ffffea000515b410 ffffea000510e610
head: ffff888140eab000 0000000000080006 00000001f5000000 0000000000000000
head: 057ff00000000003 ffffea000503aa01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2263006817, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 acpi_ds_create_walk_state+0x103/0x2a0 drivers/acpi/acpica/dswstate.c:518
 acpi_ds_auto_serialize_method+0xe7/0x240 drivers/acpi/acpica/dsmethod.c:81
 acpi_ds_init_one_object+0x1bb/0x370 drivers/acpi/acpica/dsinit.c:110
 acpi_ns_walk_namespace+0x296/0x4f0
 acpi_ds_initialize_objects+0x199/0x2b0 drivers/acpi/acpica/dsinit.c:189
 acpi_ns_load_table+0xfd/0x120 drivers/acpi/acpica/nsload.c:106
 acpi_tb_load_namespace+0x291/0x6d0 drivers/acpi/acpica/tbxfload.c:158
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888140eabf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888140eac000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888140eac080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888140eac100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888140eac180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101aa707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5119ec8290b5433
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124a3b80580000

