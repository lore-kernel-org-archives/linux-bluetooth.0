Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA31CEAC0
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485764; cv=none; b=jt3xEYdtnfJ8D0XSRAqO2UakO70SrlT0g6AOedk8Mp5Re/REWhI4SVvS/Oh+FXGnz6rhwooLp9ytlMSce/GG4ybZiY+fz3YfbvRnfkBh3D6O+mSffU/ohF38s2pG5rEco1+lH50l3NEehKU094AZ//wv+v2VK4EsxwKdrRVgtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485764; c=relaxed/simple;
	bh=FxfuFdobJQn8ovIQ3jDckZqEHHF1fe105Z+z6PsD758=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SAdVWgleDZf79haIB+qevYWOBQFawpoGE3ZQVnHHb13RsochM0wlHURv+UHgyjQnODq7ghUOpXuKgFtAY1XXwnfBtfcS+FR6jH8xwGpEvio+n0qDdaqk48FUQh6bQaZy7QO+AyrZD/jpPaJWnZMYi0c1AbDGuai3UqBtRkDWD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e94ac5e9so20234645ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 11:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485762; x=1731090562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDFxSsZov5OeixCTkX1Gr7vg2uUEDx3zfD25pjSGsnA=;
        b=CIdjynu0AAMd6mIAwgX8eNrlrCrShOl6vfhcD9CeC0w1K4XLW+VgF+FRi+/V17HGal
         uvD5Qlyl/PpNf/wjkwryFsrIZZ1xGny74XcK62Su6uoioI4Cyx+oKvEaLaiS+Q/T9ZJx
         GIB4E1IsuVO8/EL5/aTHrJcJhqoANEzejet02s/+ezbsjiH360w9J02PLofSfqVdzbCw
         JDeel6ExX8n+Dq1N+Ht3nYqLla1qDJbbaaymD5hlDwcixeYmJ0Xz8a1khqu0c5OHMoIk
         YXvxtNQ1KYR/FBmXy7+WfShKFqST+ePgYs2R4S/utqmoy3gqXdCb5eFMI0tvkQMsWxhx
         3UtA==
X-Forwarded-Encrypted: i=1; AJvYcCUWtzhAtsVRGSRonPY2uOGjXbO5jl+HNP1fqazePvcKyW1g8PyOTP4yE6EoYMVSh5ynQBvZoZI6TB7UGda8XkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKxd+gGsxk6eDbBOoJY7b2qsqR/I4s8HqKvNc5mFaCPqOIvji
	4rsWL4YanPpuVlZyyHc64CbpwTByEt0N3Qs/kktH601S/nnN5+JrFz0YQ1AZk8CVBGtJ2tug+eV
	PIcd4qSgZ5hTAEetsnsl5LyAvKB7mLfi9AtOgr/qU7N//K7W73JfT6Xg=
X-Google-Smtp-Source: AGHT+IHlpMraFjl27e5hb99Ic+KHR8N2mXMq2NQadex+u82C00nSBUp1nizVfNBYjd8/q6rXAP7fjONXlew0AAIdTOkUd/EGh11a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3a3:b3f4:af4c with SMTP id
 e9e14a558f8ab-3a4ed3100e6mr217883575ab.25.1730485761977; Fri, 01 Nov 2024
 11:29:21 -0700 (PDT)
Date: Fri, 01 Nov 2024 11:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251e01.050a0220.529b6.0162.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90602c251cda Merge tag 'net-6.12-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10076630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd9340580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-90602c25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a2daa3dcb25/vmlinux-90602c25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4488ee6eec29/bzImage-90602c25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:686 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x8e6/0x9c0 kernel/locking/mutex.c:752
Read of size 8 at addr ffff888021760060 by task khidpd_0007fff9/6116

CPU: 3 UID: 0 PID: 6116 Comm: khidpd_0007fff9 Not tainted 6.12.0-rc5-syzkaller-00161-g90602c251cda #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
 __mutex_lock_common kernel/locking/mutex.c:686 [inline]
 __mutex_lock+0x8e6/0x9c0 kernel/locking/mutex.c:752
 l2cap_unregister_user+0x71/0x240 net/bluetooth/l2cap_core.c:1726
 hidp_session_thread+0x462/0x650 net/bluetooth/hidp/core.c:1304
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6062:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 hci_alloc_dev_priv+0x1d/0x2820 net/bluetooth/hci_core.c:2440
 hci_alloc_dev include/net/bluetooth/hci_core.h:1621 [inline]
 __vhci_create_device+0xef/0x7d0 drivers/bluetooth/hci_vhci.c:399
 vhci_create_device drivers/bluetooth/hci_vhci.c:470 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:527 [inline]
 vhci_write+0x2c3/0x470 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:683
 ksys_write+0x12f/0x260 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6062:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 hci_release_dev+0x4d9/0x600 net/bluetooth/hci_core.c:2759
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:94
 device_release+0xa1/0x240 drivers/base/core.c:2575
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3783
 vhci_release+0x81/0xf0 drivers/bluetooth/hci_vhci.c:665
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x3f8/0x1080 kernel/workqueue.c:2343
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers+0x56a/0x930 kernel/time/timer.c:2419
 __run_timer_base kernel/time/timer.c:2430 [inline]
 __run_timer_base kernel/time/timer.c:2423 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2439
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff888021760000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 96 bytes inside of
 freed 8192-byte region [ffff888021760000, ffff888021762000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21760
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b043180 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b043180 dead000000000100 dead000000000122
head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000085d801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5654, tgid 5654 (sh), ts 21301582122, free_ts 21285906849
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0xcb3/0x2170 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_execute_permission+0x38e/0x4b0 security/tomoyo/file.c:619
 tomoyo_find_next_domain+0x361/0x2070 security/tomoyo/domain.c:755
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12b/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x1b9/0x1e0 security/security.c:1297
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve fs/exec.c:1845 [inline]
 bprm_execve+0x642/0x1960 fs/exec.c:1821
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:1952
page last free pid 5653 tgid 5653 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 __put_partials+0x14c/0x170 mm/slub.c:3145
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x195/0x2170 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x35e/0x450 security/tomoyo/file.c:838
 security_inode_getattr+0x116/0x290 security/security.c:2373
 vfs_getattr+0x36/0xb0 fs/stat.c:204
 vfs_statx_path+0x36/0x390 fs/stat.c:251
 vfs_statx+0x145/0x1e0 fs/stat.c:315
 vfs_fstatat+0x9f/0x160 fs/stat.c:341
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505

Memory state around the buggy address:
 ffff88802175ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802175ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888021760000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888021760080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021760100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
