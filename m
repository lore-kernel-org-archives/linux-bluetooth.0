Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9C50A63
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063605; cv=none; b=N3baaRlyYKVNNA3Hbt/Qb3daONKgXQUz4kWGmb9JbxUX25Q3oLMYw5cMVLh25eIePJsUEBq9yGWgZWRG7q4MGB6S9m2tDKyfSAn/H/17zArnGktTrNf36OsKHhCMiNv9j4x3F+9Y9Pn76LSfCxAJ2kT7YAR8qoat8sLzYvOA9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063605; c=relaxed/simple;
	bh=3kV0fSGPNiRQeaoQXbquTTTiLyzQlsuyN+u3TeaQDlU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ovISyo3hu48CS8kyPgdKO8WhmDRub68bupQeR0RuoO557YKIi5C6QCP9A4vUdBvrJPKBsM0Vk20x8RI3tpZ070iTokjN86q0rtY27bgooONMN3pINfWE6yFp8nUnaAvezR8t3ZQlF1c96dWNXv/6Em3u3vVkcemTrbLDokDAHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82ad9fca614so327888839f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 10:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063603; x=1728668403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n17v6nT7UI4eOzWxYMKuVzWjH83E1jlAA5xgkEfc7Uw=;
        b=HO4BtNpu58HfRzfpC9lWp0xeKWTRTWFb4MpeMb9kuur1WJMsRtvgpwphF/mSYj/YwD
         Cab2zPXrGcdwbDzuJeNz5hD4zFLp6gxYc1IiQId8nHyr3y9Pe4wnZBGXZh9KyCyBpGB+
         VrbA21FIuPmgFPEK10Ld0fRxCKuv1/ANPPBEUnUPMn1ihFYAuYyl1WwYOgg1bW4C6VA5
         6VCK+vbD0P3yi92ltPsz0FcFv/KuAs34s/jz/Ckkqt2P3X6l5Zx0n7a1zYqTsWO3Q5u/
         XiitnnOFl0PEE3rm2oGlTVU9EOu3ZLl/OOJAdFlWZuVr68JWPBZNYs8EO+ywg2x/G3Qr
         dlHA==
X-Gm-Message-State: AOJu0Yw1CZyTP4gHPj/IogxiP7xBvArFb/JbKBjZfK2Tdl04UIC8TTg2
	B4hgXk1lTIR2olGKbO3E2pEHf0e5hzgFLiMMg+566RBoawEShNxa3ERKTz5SrvsgZ4zmzKcJycn
	mEJqJAxYxJBOea/HAkBG5guhGLeyOkx9G85t5YfiCP0i+1yVMTRMf7T8=
X-Google-Smtp-Source: AGHT+IG6DNOm3RAOtppbAJ8yHt6EWCAR7VB2udMsRITBrThZ+v1uFC+cpKbtGpY4aQWOcX0lz1A54SzY0jNdDbnr4ypz8ZbCqk5j
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:3a0:8f20:36e7 with SMTP id
 e9e14a558f8ab-3a375bb66f8mr41424695ab.19.1728063603348; Fri, 04 Oct 2024
 10:40:03 -0700 (PDT)
Date: Fri, 04 Oct 2024 10:40:03 -0700
In-Reply-To: <CABBYNZLfELHraPs15x1PYhBUQrd_OQTnef00Y+5nm0w7US2_Wg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67002873.050a0220.49194.0495.GAE@google.com>
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
Write of size 4 at addr ffff88802719a080 by task kworker/1:3/5509

CPU: 1 UID: 0 PID: 5509 Comm: kworker/1:3 Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa-dirty #0
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

Allocated by task 5115:
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

Freed by task 5115:
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

The buggy address belongs to the object at ffff88802719a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 128 bytes inside of
 freed 4096-byte region [ffff88802719a000, ffff88802719b000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27198
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00009c6601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5115, tgid 5115 (kworker/0:4), ts 122322399972, free_ts 122095257880
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
 __kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4284
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
page last free pid 5425 tgid 5425 stack trace:
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
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888027199f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802719a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802719a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802719a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802719a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         0c559323 Merge tag 'rust-fixes-6.12' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e9307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0ca089c3fc6b54e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d69307980000

