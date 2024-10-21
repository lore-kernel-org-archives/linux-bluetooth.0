Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5E1DF99C
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499733; cv=none; b=ZDS5TWeVqdfAFFaTsb8QWQDJSQaEFnsP02+UFbW5JVXN/hFwM45F8gnjMFX16AA6cgReKXqoSuRXNqopOfRgynOvNIiA8edvvNPogPCGsERM7LMrNvRy95ZkMSnRYD0DXqqB0OcLK1Wxc4x+tvOy5VuluvTpiNZ/tTkN2eNTTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499733; c=relaxed/simple;
	bh=oKtfZT0TVhzLOwWCOxbWEKAi9d4FOOdggJDyQ/yzs1A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YxGrkC7ndr1zLAg+RSO8wXRsrYIUjvW+JMJc8/vb5MNtmiHc0gZxzyJ4XBRVTd/xcMH8FaHlQwRn2B74o/JK2JcPh55FdhJ+Cp5xbYcP0+aZ0gS9VXTkQj/KeMqc0uAVmEqN6lIdZkOlTobGyqcWKGYxUDGaueqYD5mbjiHrXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so30544415ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499731; x=1730104531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/A2PBL/dJFQGgDl1Vj0KugDcKhnaM6kgtCfOG3ZvoWg=;
        b=JEj19BLl9ta6ct1QiAhyhrgXESZsq5J3mJBrN4ioPCHRjDgX5Wamc0T3/M1YYc+TH9
         hDZ0ZDeYnQzWbdCzLmBcCAPiBmmK5QiiFetcDQoYgiZHuFoWy0lTrOh+CvD1HCXS3Eoz
         9UGyiscTGx2qN1SKFyJZdXZFwidKLNpaki2d1EhvczBhiRsYr0pw+CmjenpIrhuld9xn
         WBepshKJnYjEc8Ydnivq90Z92igDuQonEjg2UPzhuWqltINVrSC2T9O1SpFjSOBUO7T7
         74SIZpY2bX6DQG13x0HBXJduGKokPyygDGMQPwLFIHFYb4yDDs66LMGDEXCHDZw7qu8a
         U7qw==
X-Forwarded-Encrypted: i=1; AJvYcCUi0MzFdhaR9cAlNPpNJZMCbZSX30d4YMCXMteXQrI61+HGp5f9khtYrXZC/orGC/aOaY9hO32TeeTTdzoVPp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY04Te8bHm6DqFLSlUY9Zh2c3TBWFTUV+AyCxEoaDQIQvLASIk
	BqlQdeRY9MCwb3tMDSZdhZRUclDzYnUTuRWHOULeU4xI5MrDwhRZpgHkWjU016tYrBYyv/vpocM
	rAWGi+3bmrICnwinrqKh6dscxoV0fRicdddgNYckYiFAqVfcynlGddLY=
X-Google-Smtp-Source: AGHT+IEiZQFu2WeP/eC5IAwLlwTu7dpN9N7Htpc8t68+7E3+wVqpkR08+4To7oUH+w9hFVhXnZJG6pY3K/X9kHs09ix7MpBAqlFE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:3a3:a639:a594 with SMTP id
 e9e14a558f8ab-3a3f418908cmr78926235ab.4.1729499730775; Mon, 21 Oct 2024
 01:35:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67161252.050a0220.1e4b4d.0052.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in cmd_complete_rsp
From: syzbot <syzbot+1a89de7b76e603a5c5fb@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    db87114dcf13 Merge tag 'x86_urgent_for_v6.12_rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161d2a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32b00a87124c18b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1a89de7b76e603a5c5fb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-db87114d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a1e6237c364/vmlinux-db87114d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fc6ee2adb43/bzImage-db87114d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a89de7b76e603a5c5fb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in cmd_complete_rsp+0x1b3/0x1e0 net/bluetooth/mgmt.c:1463
Read of size 8 at addr ffff88802e045c40 by task syz.0.61/5584

CPU: 2 UID: 0 PID: 5584 Comm: syz.0.61 Not tainted 6.12.0-rc3-syzkaller-00454-gdb87114dcf13 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 cmd_complete_rsp+0x1b3/0x1e0 net/bluetooth/mgmt.c:1463
 mgmt_pending_foreach+0xdf/0x140 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x12a/0x2c0 net/bluetooth/mgmt.c:9474
 hci_dev_close_sync+0xc33/0x1110 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_dev_close+0x183/0x1e0 net/bluetooth/hci_core.c:508
 hci_sock_ioctl+0x28c/0x880 net/bluetooth/hci_sock.c:1128
 sock_do_ioctl+0x116/0x280 net/socket.c:1227
 sock_ioctl+0x228/0x6c0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc90f77dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc910494038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc90f935f80 RCX: 00007fc90f77dff9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007fc90f7f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc90f935f80 R15: 00007ffe69fe13d8
 </TASK>

Allocated by task 5549:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 mgmt_pending_new+0x5b/0x290 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x160 net/bluetooth/mgmt_util.c:296
 start_discovery_internal+0x4a1/0x800 net/bluetooth/mgmt.c:5922
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1712 [inline]
 hci_sock_sendmsg+0x1528/0x25e0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 sock_write_iter+0x4fe/0x5b0 net/socket.c:1165
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0x6b5/0x1140 fs/read_write.c:683
 ksys_write+0x1fa/0x260 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5584:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 start_discovery_complete+0x146/0x220 net/bluetooth/mgmt.c:5860
 _hci_cmd_sync_cancel_entry.constprop.0+0x6c/0x1d0 net/bluetooth/hci_sync.c:641
 hci_cmd_sync_dequeue+0x178/0x1f0 net/bluetooth/hci_sync.c:886
 cmd_complete_rsp+0x46/0x1e0 net/bluetooth/mgmt.c:1461
 mgmt_pending_foreach+0xdf/0x140 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x12a/0x2c0 net/bluetooth/mgmt.c:9474
 hci_dev_close_sync+0xc33/0x1110 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_dev_close+0x183/0x1e0 net/bluetooth/hci_core.c:508
 hci_sock_ioctl+0x28c/0x880 net/bluetooth/hci_sock.c:1128
 sock_do_ioctl+0x116/0x280 net/socket.c:1227
 sock_ioctl+0x228/0x6c0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e045c00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 64 bytes inside of
 freed 96-byte region [ffff88802e045c00, ffff88802e045c60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802e045280 pfn:0x2e045
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801b042280 ffffea0000ce3590 ffffea000093fb50
raw: ffff88802e045280 0000000000200019 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5376, tgid 5376 (kworker/2:4), ts 38557960430, free_ts 38507952405
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
 dst_cow_metrics_generic+0x4c/0x1e0 net/core/dst.c:185
 dst_metrics_write_ptr include/net/dst.h:133 [inline]
 dst_metric_set include/net/dst.h:194 [inline]
 icmp6_dst_alloc+0x370/0x490 net/ipv6/route.c:3288
 mld_sendpack+0x5a9/0x11d0 net/ipv6/mcast.c:1808
 mld_send_cr net/ipv6/mcast.c:2120 [inline]
 mld_ifc_work+0x740/0xca0 net/ipv6/mcast.c:2651
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free pid 24 tgid 24 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 __folio_put+0x30d/0x3d0 mm/swap.c:126
 folio_put include/linux/mm.h:1478 [inline]
 free_page_and_swap_cache+0x249/0x2c0 mm/swap_state.c:308
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:282
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:927 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:919
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88802e045b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802e045b80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff88802e045c00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff88802e045c80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88802e045d00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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
