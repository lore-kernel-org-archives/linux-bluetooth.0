Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88C1A01D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260611; cv=none; b=E5C5Egmm4kfg12LqdS7kxBPSjz25xS0hZSkK8F3SYno0ILPUG+Va8dyNE3vl76PXw/GCzKiqz332LUsc3XoStruv92atuw+8aFdtt6S5Qj4Msce1XWlRZCx7VaDaE0uDQPQVcJE9OAGSypripikiiDWP19/qWtwXTtwx1wYJE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260611; c=relaxed/simple;
	bh=8+v1Y5nj/TyenY29qaOLTtab5bDmwyGUXE0b3+iIStM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c1YN84tOay14c56UzRxe759lBLNQqQ6tJzD8SgwZiGfOZezSRBFmfLOMLQbEJ61nm58gYbdG/m4+WKg0U0zmh3KNS6e06kPgn26cqjxZaj+Yi3fnvwntRDCxjT5BKLeiQ30MfUpcTTggAJqYf8G5dnOSkrB2a+blK5cfdtz16rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso644015539f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 13:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260608; x=1719865408;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7unrV/WSI4lMifh7WAaGQQb1pPdycO238wPueRJy7U=;
        b=GSeV7r0E8A494Xssgo1IK3Vj5fDbOktKfPSRw/9DV+ST+4zMJZrlpJNEeEqY7Id7xX
         FX6ImvYtr/KE0MwhLupWJH8Zumj+ABvF6xx3PNX1qCayCXx0lpA6gfiYsESYJgMnGS59
         XfSysLIlrDbUGEfok4JKPGh7dJuQbCNFbBOyB6fan05gFBlH2vidDlVNZR1tczGq2g9e
         tDi2aT5/iYWseGFBPzLLRHqFfLGUxflBo0zJUzsYsIg4ycj+MY+77tg25meWgHCQcHr0
         c/o1WRw+W9U+DACvPDMZaI8kEd5nQ/J38lQ5KDXRRrbC9CMKTE8+DMYEg0ru2i/VUX/o
         QxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7y9aa/El7uP9AOjwIV/3tG5wqABzELi00He5snPmKsKOGEllwLWYMGtW4BNUgIBf5x9mRgLsuRANO0DlnPywrP5nxbQGT3UvPIHWqay94
X-Gm-Message-State: AOJu0Yy3DwgwZEVMlvA17LfMn9NaMowABwYAPvkMHrInufWFVnVOb4xR
	FtyXDF9vXjKlCMmAlhSVhDEdl1Y2DoSNiyCoTuWQWMVofOI11iE3wjK215HDWt8TD/ID+JPIirI
	Ma6IdCbVgKDVVJxaDU6Qa0JZIcuWQdFlJ0U7cFKCAYxn9l8p6xQsT9YM=
X-Google-Smtp-Source: AGHT+IH+CiUeVEzJbzyh6dkVTfbYbFlJ89KY42n0dmQrpOkGH6Byf8zwriUW7Yc4uReK3zFuhjZL3GNUVgC5ETNOkS3DIOhvTq+3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-3763f5f1db8mr6376555ab.2.1719260608521; Mon, 24 Jun 2024
 13:23:28 -0700 (PDT)
Date: Mon, 24 Jun 2024 13:23:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8f51a061ba88d22@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f583a3162ff Merge tag 'rust-fixes-6.10' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11170741980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f413acf5b1eb4093
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f530c7950839/disk-5f583a31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4f810bbc13e/vmlinux-5f583a31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a49ec6dadbad/bzImage-5f583a31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff88802af53000 by task kworker/u9:4/5114

CPU: 1 PID: 5114 Comm: kworker/u9:4 Not tainted 6.10.0-rc4-syzkaller-00301-g5f583a3162ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf07/0x8e50 net/bluetooth/l2cap_core.c:6821
 l2cap_recv_acldata+0x9ac/0xb60 net/bluetooth/l2cap_core.c:7510
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4079
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 4480:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2cap_conn_add.part.0+0x60/0xa60 net/bluetooth/l2cap_core.c:6864
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7417 [inline]
 hci_event_packet+0x9e3/0x1170 net/bluetooth/hci_event.c:7469
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4074
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5112:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4558
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x740 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7237
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1257
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5450
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2909
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:310
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2207
 __queue_work+0x944/0x1020 kernel/workqueue.c:2359
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1838 [inline]
 __run_timers+0x567/0xaf0 kernel/time/timer.c:2417
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2207
 __queue_work+0x525/0x1020 kernel/workqueue.c:2363
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2410
 queue_work include/linux/workqueue.h:621 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0x9c9/0xf80 net/bluetooth/l2cap_core.c:7282
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7417 [inline]
 hci_event_packet+0x9e3/0x1170 net/bluetooth/hci_event.c:7469
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4074
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802af53000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88802af53000, ffff88802af53400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2af50
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000abd401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4752, tgid 4752 (dhcpcd), ts 66098690934, free_ts 66038999175
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4142
 kmemdup_noprof+0x29/0x60 mm/util.c:131
 kmemdup_noprof include/linux/fortify-string.h:757 [inline]
 bpf_migrate_filter+0xc6/0x390 net/core/filter.c:1268
 bpf_prepare_filter+0x183/0x380 net/core/filter.c:1354
 bpf_prog_create_from_user+0x1e4/0x2d0 net/core/filter.c:1448
 seccomp_prepare_filter kernel/seccomp.c:680 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:717 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1935 [inline]
 do_seccomp+0x7b6/0x2580 kernel/seccomp.c:2055
 prctl_set_seccomp+0x4b/0x70 kernel/seccomp.c:2108
 __do_sys_prctl+0xc83/0x1e40 kernel/sys.c:2539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 4747 tgid 4747 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 __put_partials+0x14c/0x170 mm/slub.c:2995
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_lru_noprof+0x121/0x2f0 mm/slub.c:4020
 shmem_alloc_inode+0x25/0x50 mm/shmem.c:4468
 alloc_inode+0x5d/0x230 fs/inode.c:261
 new_inode_pseudo fs/inode.c:1007 [inline]
 new_inode+0x22/0x270 fs/inode.c:1033
 __shmem_get_inode mm/shmem.c:2503 [inline]
 shmem_get_inode+0x194/0xe80 mm/shmem.c:2574
 shmem_mknod+0x66/0x240 mm/shmem.c:3268
 shmem_mkdir+0x31/0x60 mm/shmem.c:3329
 vfs_mkdir+0x57d/0x860 fs/namei.c:4131
 do_mkdirat+0x301/0x3a0 fs/namei.c:4154
 __do_sys_mkdir fs/namei.c:4174 [inline]
 __se_sys_mkdir fs/namei.c:4172 [inline]
 __x64_sys_mkdir+0xf1/0x140 fs/namei.c:4172
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff88802af52f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802af52f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802af53000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802af53080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802af53100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
