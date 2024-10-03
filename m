Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8E38DD1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984645; cv=none; b=tkh0gGfteX0SLUBaKz7jxqaafn43tSQ1t41PGM45TfH0xvbrz7v3U/3NMy03CkruyTMLpN1yzAtS2BWrSS1NcKW8XjjjPNN5iZ6DvrQtjAZEui1yCgPJSsDwYOGrJX4aZaeDM/6xwIYMDXePpxgbehoiXllpODWn1DhcS4BiA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984645; c=relaxed/simple;
	bh=CYHU1ccC0RfoI3xrSBT7e30h78GvQAh91w+NszNd4bA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qq2k0/AXBYDqr8fZ0Kh3xozh0K2j1fTFufIsSKRlQqsVDTRnYjv9WNZ0kj7vw3Im8mM1d13nK9daBZ28Zjo+UXrU7RVECiWzddb68d52g9zk6kHjLOmH5Zi3axuA9V1BGXeSFtSfNtw80Y6/UOlFj7Q1mISsolQX1iqGCoaEag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a19665ed40so12327945ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 12:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984643; x=1728589443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrC/w4kKmV68DSZCBTU3okxcjyHgmOqBH+qFM7ESZVc=;
        b=uIHrgR7m7H6iSCljQ1hfiMxUbI4XnapjpZOZ5ICTITPRBTQfhl7Ou8tXJ3DfkLVMCd
         hWcWGUq8fj5ic9j4KxsZOkICQZUGKCawuxSLYCGUHyaxWL61lVV3dMzSP1JaeJYqNZek
         mqEiPj9/AxK0KjtmcQGcZY0oM14IqSQ4JMEVGwKYuYPHIv8tInCXPhsamvaAYhzWAJwM
         hSh2S3x1hFrPZTTY+e2HfW85WgCruARKy0q1SemiCJnuxMD7YtP2w01e4FBYpkd5QfXo
         iHduAYO1+ijepXRiEHDubAkzrRgnRou/sSYPfPe1y9qdTXxqt+2msZV1rQocEqjd/Byk
         RMkA==
X-Gm-Message-State: AOJu0YyY8q+geAV3XRE1tzP8wb93/wsaN6M+JkIOP5bulSwAYIlDtKTN
	G4RFVrttKNvn0O+hhOmVi+R/Tdu0hcjytXODm04+FRNdvITZ0TJwhRrP/oN+sVmGnBZ/3ktOS9p
	VQujk/giP0x3ekdeByykRfzDd2h96M0y/1hZletbUWqSWXYWYANrXa5I=
X-Google-Smtp-Source: AGHT+IGHEB7MCJ4ZIuhBDpbmTTcUlea1BHZ3LRveT7Ovy7khOH5iJSMYU84X1MP7KxjNxXKaTuIo80zxVTtR59Zkp+lAR8CID754
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a375baaad3mr2698435ab.0.1727984642560; Thu, 03 Oct 2024
 12:44:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 12:44:02 -0700
In-Reply-To: <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fef402.050a0220.9ec68.005b.GAE@google.com>
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
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
Write of size 4 at addr ffff88802639a080 by task kworker/1:2/1808

CPU: 1 UID: 0 PID: 1808 Comm: kworker/1:2 Not tainted 6.12.0-rc1-syzkaller-00113-g8c245fe7dde3-dirty #0
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
 sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 25:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4284
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x254/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 25:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 skb_kfree_head net/core/skbuff.c:1086 [inline]
 skb_free_head net/core/skbuff.c:1098 [inline]
 skb_release_data+0x6a0/0x8a0 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 consume_skb+0x9f/0xf0 net/core/skbuff.c:1436
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x765/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802639a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 128 bytes inside of
 freed 4096-byte region [ffff88802639a000, ffff88802639b000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26398
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000098e601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5398, tgid 5398 (udevd), ts 123333990998, free_ts 123322335448
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x3eb/0xbb0 security/tomoyo/file.c:923
 tomoyo_path_rename+0x198/0x1e0 security/tomoyo/hooks.h:274
 security_path_rename+0x266/0x4e0 security/security.c:2020
 do_renameat2+0x94a/0x13f0 fs/namei.c:5157
 __do_sys_rename fs/namei.c:5217 [inline]
 __se_sys_rename fs/namei.c:5215 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5215
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
page last free pid 4548 tgid 4548 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4491
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0x130/0x330 security/security.c:2371
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_fstat fs/stat.c:229 [inline]
 vfs_fstatat+0xe4/0x190 fs/stat.c:338
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888026399f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802639a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802639a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802639a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802639a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8c245fe7 Merge tag 'net-6.12-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13156307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17377580580000

