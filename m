Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B52356D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826872; cv=none; b=Hwo2kHih8jAa8BPMmeKyEUD/kq2+tHJsXkqJKEdst/GZ1GjMwQ89QRz5RcR4QdADV95uVUYhNtVRA7JMhBNi2MWzt5XH3mjrcRy6oyG9OgC19trDH5WzSDKTNu7I2W4SFm0PbskRcVzaHAOKv2H2rmd3n6PnABadWA9NBCJ7PYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826872; c=relaxed/simple;
	bh=DASDes5bpohEJznWIExqDXqo50KwF0BSfFpQXCBLbFU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TuT8PL+q0rnPeI1geEKNImZIzv0RPlK9EkClpAip0poQSJfl5DlXUjPFe+E/YVfpU7bJmNplzN6TPetaB7fPoQfIu6T7kixmvXp+yV1ziJE3II88hg2r6fX8r1kBOv4i3Z8x7z8mJqIPhwjY+uVVelqzzdvsgHJG23Ks6kRZe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b3888569bso390607439f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826870; x=1746431670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqrtjl6UpIhLKHaCVSToGWdop2c+mUeiS2eSY8g70MI=;
        b=GE116RXYqP2EvO9YHMeXf+oph8IS0NVln73Cr/sc46AG3KqOLq+abbHJhXB9ZzW4fU
         UNpsaS9edOFmV8OkOOmT2vKDw3a7LSh9y6Cjn22ykHL9N6VTM5pomZy7yADR3LjYXvE6
         DxZ4QYjwNC5A0RUGIS7vg+4u4nIGicYJukhTKq8a91XlOHI4T4mcgNMa2svW5c2EHchN
         LdtfQn+dXe65BRRBaGE+XjA5KCJ1ni+yFAcZLkXaHxzsJYbRO+pCWjV6TddtH4KTOAHp
         MBA9dcQ3Olc61YcIsYDKORD5FrC5/ksb6ynNeg5D8ZR5E3rqA/EX3KesSia1Pin0OfC4
         d5OA==
X-Forwarded-Encrypted: i=1; AJvYcCV27aDwyPG+JeExjDZOObUHw7mqeI7NRyxRWmgVBFFfZb6RpBuySDmbV3JcBWju/6sf23mCNWjf9IE031WT4kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtj7YdYYDpLRYo+/B3ufv0h8JDUxRYFRwAWC7C1NfWnLZdTiGu
	Yc4Q56ppRg3VWoYD27pKwkYYSRmomf75A9ezrcBd5mG4c5+K0f8umzP4nZYovAc/xaigyB8YbzM
	m+fE0KxiwCepKRpy6g3vjhFpnDueeKlOAS6p11UGcPQxnzKfEi2mgb/c=
X-Google-Smtp-Source: AGHT+IFgNy+qjUOw1J6r19hP/bTOTSw45XV5kdf/UfCArA2UQ2ZY4DfQWOfDVOUaYXMybdvik1XVvfmjHrZx2rifFfb/IocyC+co
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:480c:b0:85b:4d78:cfe7 with SMTP id
 ca18e2360f4ac-8645da7d05amr1073361339f.4.1745826869746; Mon, 28 Apr 2025
 00:54:29 -0700 (PDT)
Date: Mon, 28 Apr 2025 00:54:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680f3435.a70a0220.23e4d2.002c.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 bt_accept_dequeue (2)
From: syzbot <syzbot+3ea095a3db5d3f5576d0@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc3372351d0c Merge tag 'for-6.15-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16384574580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f65c1740d8e72188
dashboard link: https://syzkaller.appspot.com/bug?extid=3ea095a3db5d3f5576d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bc337235.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6812d20f308/vmlinux-bc337235.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73775fc2378f/bzImage-bc337235.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ea095a3db5d3f5576d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bt_accept_dequeue+0x582/0x600 net/bluetooth/af_bluetooth.c:271
Read of size 8 at addr ffff888025fdb558 by task krfcommd/3535

CPU: 1 UID: 0 PID: 3535 Comm: krfcommd Not tainted 6.15.0-rc3-syzkaller-00019-gbc3372351d0c #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 bt_accept_dequeue+0x582/0x600 net/bluetooth/af_bluetooth.c:271
 l2cap_sock_accept+0x2c7/0x650 net/bluetooth/l2cap_sock.c:351
 kernel_accept+0x1cf/0x380 net/socket.c:3573
 rfcomm_accept_connection net/bluetooth/rfcomm/core.c:1971 [inline]
 rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2030 [inline]
 rfcomm_run+0x3a7/0x5220 net/bluetooth/rfcomm/core.c:2126
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5958:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4341 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2198
 sk_alloc+0x36/0xc20 net/core/sock.c:2254
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x33/0x1d0 net/bluetooth/l2cap_sock.c:1891
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1482
 l2cap_connect.constprop.0+0x78a/0x1240 net/bluetooth/l2cap_core.c:4015
 l2cap_connect_req net/bluetooth/l2cap_core.c:4106 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5532 [inline]
 l2cap_recv_frame+0xe24/0x9510 net/bluetooth/l2cap_core.c:6814
 l2cap_recv_acldata+0xae4/0xd30 net/bluetooth/l2cap_core.c:7533
 hci_acldata_packet net/bluetooth/hci_core.c:3782 [inline]
 hci_rx_work+0xa80/0x16b0 net/bluetooth/hci_core.c:4025
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 7103:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4855
 sk_prot_free net/core/sock.c:2237 [inline]
 __sk_destruct+0x740/0x980 net/core/sock.c:2332
 sk_destruct+0xc2/0xf0 net/core/sock.c:2360
 __sk_free+0xf4/0x3e0 net/core/sock.c:2371
 sk_free+0x6a/0x90 net/core/sock.c:2382
 sock_put include/net/sock.h:1944 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1265 [inline]
 l2cap_sock_kill+0x171/0x2d0 net/bluetooth/l2cap_sock.c:1250
 l2cap_sock_close_cb+0x44/0x60 net/bluetooth/l2cap_sock.c:1571
 l2cap_conn_del+0x3b9/0x730 net/bluetooth/l2cap_core.c:1788
 l2cap_connect_cfm+0x9e1/0xf80 net/bluetooth/l2cap_core.c:7234
 hci_connect_cfm include/net/bluetooth/hci_core.h:2054 [inline]
 hci_conn_failed+0x1ba/0x330 net/bluetooth/hci_conn.c:1269
 hci_abort_conn_sync+0x740/0xb40 net/bluetooth/hci_sync.c:5616
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5639
 hci_suspend_sync+0x770/0xab0 net/bluetooth/hci_sync.c:6116
 hci_suspend_dev+0x308/0x500 net/bluetooth/hci_core.c:2812
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2392
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
 blocking_notifier_call_chain_robust+0xc8/0x160 kernel/notifier.c:333
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x189/0x2b0 kernel/power/user.c:77
 misc_open+0x35a/0x420 drivers/char/misc.c:179
 chrdev_open+0x231/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x741/0x1c10 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x1e5e/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_compat_sys_openat fs/open.c:1506 [inline]
 __se_compat_sys_openat fs/open.c:1504 [inline]
 __ia32_compat_sys_openat+0x16d/0x210 fs/open.c:1504
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888025fdb000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1368 bytes inside of
 freed 2048-byte region [ffff888025fdb000, ffff888025fdb800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25fd8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea000097f601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 15307516071, free_ts 15256767393
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab mm/slub.c:2632 [inline]
 new_slab+0x244/0x340 mm/slub.c:2686
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3872
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3962
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __do_kmalloc_node mm/slub.c:4340 [inline]
 __kvmalloc_node_noprof+0x3a6/0x600 mm/slub.c:5026
 v4l2_ctrl_new+0x17f4/0x2180 drivers/media/v4l2-core/v4l2-ctrls-core.c:2067
 v4l2_ctrl_new_custom+0x413/0xaa0 drivers/media/v4l2-core/v4l2-ctrls-core.c:2153
 vivid_create_controls+0x926/0x3df0 drivers/media/test-drivers/vivid/vivid-ctrls.c:1726
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1933 [inline]
 vivid_probe drivers/media/test-drivers/vivid/vivid-core.c:2095 [inline]
 vivid_probe+0x515f/0xb890 drivers/media/test-drivers/vivid/vivid-core.c:2080
 platform_probe+0xff/0x1f0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
page last free pid 36 tgid 36 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 discard_slab mm/slub.c:2730 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3199
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_lru_noprof+0x1d0/0x3b0 mm/slub.c:4229
 shmem_alloc_inode+0x25/0x50 mm/shmem.c:5147
 alloc_inode+0x61/0x240 fs/inode.c:346
 new_inode+0x22/0x1c0 fs/inode.c:1145
 __shmem_get_inode mm/shmem.c:3046 [inline]
 shmem_get_inode+0x19a/0xfb0 mm/shmem.c:3120
 shmem_mknod+0x1a8/0x450 mm/shmem.c:3841
 vfs_mknod+0x5d7/0x8e0 fs/namei.c:4228
 handle_create drivers/base/devtmpfs.c:233 [inline]
 handle drivers/base/devtmpfs.c:393 [inline]
 devtmpfs_work_loop+0x1c8/0x900 drivers/base/devtmpfs.c:408
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:450
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153

Memory state around the buggy address:
 ffff888025fdb400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025fdb480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888025fdb500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888025fdb580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025fdb600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
