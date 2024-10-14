Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27068262A8
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885386; cv=none; b=A6Ao9er0ngUEMcQRQS74tJEjwVjZEEqAJ6XZyuSEf0ATlMvuTcSBCu2kFAdkgT9m5C7sGRis0IdD3bKZtq5YBwLv6UsyDYKYQniYd3Y18oT1GvSuCwXLt9MvARfdHz3O8ypnFpGan1L0kutnMu2xrcKimfaIuD0FL+GAKn35pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885386; c=relaxed/simple;
	bh=mvl4ZnYXDWhQmrQyeUhDDsCUyFyTP9Mm7qXAWThIgC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c7bEbCMXngjAf2dJNqL68XWPyFbciNTU+WcstwjYtogslf/S9KHX+BK4m1TB/DZeX+S2NSLdpOMvbPfV8XS7rEJBEuP7JEjbadFPgvHki/zx8FjbCWmZTV/blX2IaNtMse+7ffnzQwuE+HYQw8ZR7Q9gR9hDChJx8WTkLkF1fBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c8853d76so12940185ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 22:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728885384; x=1729490184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNQ5Icc0pPnDsYDF1WhtyPA2BmgHbzYGMR6KurhTyYo=;
        b=H5SiqvXesu5FWCKznooXnzMTJq6iwqeyVqlOiQ7Eg1nI/kk372YVUzYVwAe7j9CANr
         T2pbXWkUJruBBVc/F3R9/yqS84nkZiAMjYhyAAEsqNFftRRWk8jGcbAEwfsi7lhIznJ3
         13L97x0CmqyntBRIl7pTiC6qNZqyx+bYQUhjlZk104muF1/O+icfcstd/TNDlkUSaNN/
         pkVOGrpmlBlG6SKRjTST1mRUNSYCG3VNzrp4k2x1dnaRyLmU+WB8Hu0cctizBxSk1vbn
         vrAF5IiR1ZhIXMeR1EUNYMLm8qnF2KFAsu6CwQfFtmT76Tjm/W9oLPSIJM34323MNlsd
         tiTw==
X-Forwarded-Encrypted: i=1; AJvYcCVNA7F4WH/R8IxyWd3qgeuyqZr6D4jJaQA8MLrR6+wh9Rc4v8pILh+gcfBoeDS6GRhVOLrcyR2l53QOrESS8HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEYFDdH0Vlg+b41C0FT2lkaOTp3PvHU5tvMBOQrLFqMLIJtaV
	0d49sGDUTpbk7IMbOAxE4HyVWNvYvgE6sRboFLUqwb7ItsroBUJCELVp+fhismkd9eSdfqR6c52
	NEDxThH9QAvWTBfi2Blrk2kz8QHOu272hYA7y3PVxinm68outaL4oe9w=
X-Google-Smtp-Source: AGHT+IEA+biJ1VLyFzNWcvc10DQj6L3yA2V+D3+cf+AavL0GFVJk1mBRa1UUS4aXU9EDWQN4gE06ZAaD2mfPys3B+Xj97OomJO9p
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1385:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a3bcdc6befmr47408365ab.12.1728885384290; Sun, 13 Oct 2024
 22:56:24 -0700 (PDT)
Date: Sun, 13 Oct 2024 22:56:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb288.050a0220.4cbc0.003f.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_complete
From: syzbot <syzbot+4f5eb317dfc1c7e8b003@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b7275670032 Add linux-next specific files for 20240925
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a332a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441f6022e7a2db73
dashboard link: https://syzkaller.appspot.com/bug?extid=4f5eb317dfc1c7e8b003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de8e955e430e/disk-2b727567.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cdc30f0c4010/vmlinux-2b727567.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bce68c83e37/bzImage-2b727567.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f5eb317dfc1c7e8b003@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0x3b6/0x550 net/bluetooth/mgmt.c:5456
Read of size 2 at addr ffff88801dad4820 by task kworker/u9:4/5243

CPU: 0 UID: 0 PID: 5243 Comm: kworker/u9:4 Not tainted 6.11.0-next-20240925-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 mgmt_remove_adv_monitor_complete+0x3b6/0x550 net/bluetooth/mgmt.c:5456
 hci_cmd_sync_work+0x280/0x400 net/bluetooth/hci_sync.c:330
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 7589:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4284
 kmemdup_noprof+0x2a/0x60 mm/util.c:133
 mgmt_pending_new+0xf0/0x250 net/bluetooth/mgmt_util.c:276
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5498
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1166
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7594:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 mgmt_pending_free net/bluetooth/mgmt_util.c:308 [inline]
 mgmt_pending_remove+0x175/0x1a0 net/bluetooth/mgmt_util.c:315
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9407
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1839 [inline]
 __sys_bind+0x22d/0x2d0 net/socket.c:1863
 __do_sys_bind net/socket.c:1871 [inline]
 __se_sys_bind net/socket.c:1869 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1869
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801dad4820
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff88801dad4820, ffff88801dad4828)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1dad4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3431344829, free_ts 0
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
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 acpi_ns_internalize_name+0x419/0x610 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked drivers/acpi/acpica/nsutils.c:666 [inline]
 acpi_ns_get_node+0x1b7/0x3c0 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0x19b/0x2a0 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x9e/0xf0 drivers/acpi/utils.c:673
 acpi_is_video_device+0x10f/0x2a0 drivers/acpi/scan.c:1306
 acpi_set_pnp_ids drivers/acpi/scan.c:1441 [inline]
 acpi_init_device_object+0x1e33/0x34e0 drivers/acpi/scan.c:1829
 acpi_add_single_object+0x106/0x1e00 drivers/acpi/scan.c:1880
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801dad4700: 02 fc fc fc fa fc fc fc 02 fc fc fc fa fc fc fc
 ffff88801dad4780: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
>ffff88801dad4800: 00 fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
                               ^
 ffff88801dad4880: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
 ffff88801dad4900: fa fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
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
