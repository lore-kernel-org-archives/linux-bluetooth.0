Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D21CACF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480227; cv=none; b=RXGtKJkR2yNfx4ssrBsiJ8F8Fe1rtYBfru6ujhr3vz/40R0W53glMwvV4aDPXP/USS53908FOPobURJ6U3LEw1AckQ4N0JjCnTyf5RnoBrKvLjQb0jNM0ZzkcDZaOBzBu4Gpuv9om7vDyRBleDdTP6HbUWlQsv2og6GpvLS3SSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480227; c=relaxed/simple;
	bh=E2aMEhObp0Ugg1HOb713gf8y4zQ5YowVwtSkyTp8W0c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i53imiwATnhvJBRXyjkabUdptqjNaoggweGo5sjbypaLxqsentLk4UuQhLPlWVzoh+yYI72lDAt3DmcKC7lUxLgiGADbsahXMmqMlSFe5QN9dfpFff2GDy3hRnbynK95ao6aqjCevU/rEeUuFWQVvjuSNdz0/9DPkh8PbinRrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aecd993faso193958939f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 09:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480223; x=1731085023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3+faLBnTzjy2s0KCBBpJl/yrj+ppesP40+085rlOE=;
        b=RZfWjRxD5dOQIPKVmKsw9kB9sxLvBAxk56UfU0hG/uKzfzZWbAZwI5P2CK60cClPRp
         JpXmK6Z8qEqGMdkNtGoHVG7hJzPobaa2POr/kaWHcMIlym46CY/dn4yR5H5/ILP3kAfQ
         bAs6BDS5qU2kU1z30sj7bW+qJP4/lv/PSJ8GXlUcixX6yg13n/Sn42j8YjsalRk6AZow
         unnVVatX8rVDfBXXCl2yh/b1JwBUnv63d9/gYu4JHg/A+Wa4Sg1FcHkuO7jrWmxbWBOw
         dEjqpXJ8dhpsBs/Lr5Hc2Li0kGu7p7jOgNf92Q5MQMO0Z4MACq28mlfGTAaWbOL8vL7L
         hXDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHbCzG8bLEuzMrjBG8pdL0FYAc0P/EYjhcsbdEE+/0peVz6c2rUq9h6A0TfxMYdi+clBiMK3+qLQVD1OuHUBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnHNbmlkVEXWqSPivaYatvxJ7FsFB21pcjL4QGWeZANw1Ljkg
	jYa1wCRCW+BuV8VjIQUyJMTVRx8/kBAE3MJAUAbaHpFvN/REk23kq6g0gTQ5TMTN3kVxSh9riVA
	jxJ6GGQ5i3bQ8V7+COR2bokqx3HouEcPhgh7y3xN5SOdzgfmxdJrGLz8=
X-Google-Smtp-Source: AGHT+IESed0yMKUBfmnR8ruLVbzsdhxZW5o9OeE4LhDK75Kr9k6kJBohiEhoOtPnsJE6OlYA/dTSMcN8i4xmTDq8tJu3pOyOmUZT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:111:b0:3a3:637f:1012 with SMTP id
 e9e14a558f8ab-3a6aff71b31mr30782005ab.12.1730480223572; Fri, 01 Nov 2024
 09:57:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 09:57:03 -0700
In-Reply-To: <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725085f.050a0220.529b6.0145.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, lvc-project@linuxtesting.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in netdev_unregister_kobject

==================================================================
BUG: KASAN: slab-use-after-free in device_for_each_child+0xbb/0x1b0 drivers/base/core.c:3999
Read of size 8 at addr ffff888021c81308 by task kbnepd bnep0/5597

CPU: 0 UID: 0 PID: 5597 Comm: kbnepd bnep0 Not tainted 6.12.0-rc5-syzkaller-00181-g6c52d4da1c74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 device_for_each_child+0xbb/0x1b0 drivers/base/core.c:3999
 pm_runtime_set_memalloc_noio+0x114/0x260 drivers/base/power/runtime.c:248
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2109
 unregister_netdevice_many_notify+0x1851/0x1da0 net/core/dev.c:11441
 unregister_netdevice_many net/core/dev.c:11469 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11343
 unregister_netdevice include/linux/netdevice.h:3118 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11487
 bnep_session+0x2e0e/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5425:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 hci_alloc_dev_priv+0x27/0x2030 net/bluetooth/hci_core.c:2440
 hci_alloc_dev include/net/bluetooth/hci_core.h:1621 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:399 [inline]
 vhci_create_device+0x116/0x6a0 drivers/bluetooth/hci_vhci.c:470
 vhci_get_user drivers/bluetooth/hci_vhci.c:527 [inline]
 vhci_write+0x3cf/0x490 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaed/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5425:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 hci_release_dev+0x1525/0x16b0 net/bluetooth/hci_core.c:2759
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 vhci_release+0x88/0xd0 drivers/bluetooth/hci_vhci.c:665
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2343
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 call_timer_fn+0x190/0x650 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2419 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff888021c80000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4872 bytes inside of
 freed 8192-byte region [ffff888021c80000, ffff888021c82000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21c80
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442280 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442280 0000000000000000 0000000000000001
head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000872001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4752, tgid 4752 (S40network), ts 32094841667, free_ts 32026397912
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
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
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x11cd/0x2050 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x146e/0x1d40 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security+0x114/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x86/0x250 security/security.c:1297
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1845
page last free pid 4751 tgid 4751 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:472
 mmap_region+0x1134/0x2940 mm/mmap.c:1436
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888021c81200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021c81280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021c81300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888021c81380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021c81400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e81630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf68159adbdf217
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
