Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90613D638
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045467; cv=none; b=I7pX+2fEWQf0laPOOHVsEe5r+d7HY90YyLg+QbkC2t9arPvPYFqtDXt8VS6ANxdx+HoyJLaKBpQWPaMNW0FGcGTscS2l7ezPnaLAnvcoGZT/oGY9buI2f3uA7SaQ+zDlAG635YbRD/Ikd0R/GVQBT7KyQ72Y69ueNRmiz67dd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045467; c=relaxed/simple;
	bh=vDFFEJ5UrPksxq7P3nBDfLeKfEp4RcuFJoPe2qypK/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GPVCn0qw7fyn2Z2RdD6bl4W3mKgqo5WE1Fj189pv2cuM69BlizU/uEG/J8PaB9JF3jt8mIqMDqTLFc4IFeqBByd0925VZaZeduY5wc/VXASeYrbiY7CzzRxBfH5op59acIpyJXg7q0xCOCqFeaIffG2wQyhvu87bFqLgOzdl29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so3534739f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 15:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720045465; x=1720650265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwzMINZ9r9k5Pzr++ieVcxIwrVNBF38IRi8v+Yww6oI=;
        b=dNHMV0Dfnk9qiUwMhrcdd6iCL2ycq4kgsPyX3u+0VgZwK1ZW9r2/t5SWmRJGnBlxGl
         moMVSNd65p4Cyla/c+81twkrKyUXRQ4OFqGYLcFR+C/hgTjg7KkdKMVvM51AxxGb+lde
         f4hl2+RVeobvvzVVn5Dre5W9+zuJJYeAThcW8IbjkD4b7/3YtPamRvvXTD0put5T6MoQ
         JVHNH/vnTCkdRZsGAAyqg8h2fHToZN+WU/JCz650EYO1qp1aJHD1V0jdlUd9IiwGk4lB
         oYdA2kwO8bX5muUWO7qooSSWSebLA1rkRGXXpCASNtqX7zwfK6ZabO6PuV+yTNgdL321
         6s0g==
X-Forwarded-Encrypted: i=1; AJvYcCWyRN4n7ksS8iLph0WgCqntMtWUaF1lUe8ZECQwx1fPlEUcKP15tCZxWE4h2eN1yQzZFKLfK9hIjC9dgJ4XY6uboZ8USUOz8m+RStjcY3ep
X-Gm-Message-State: AOJu0YyWdrv/bCQrDfCvWAUOLSKacL1iYHG/GglEkOWLux5sK6XczrcW
	BYZS0DXHNqIV8v6uY1UI0Qd+SLgNNk55C807c7hm3jbVTHPo7UKbLoWIAWW36s69/b2wkZrE0px
	XHLKix4cncuI47D8attkC8JU61OaH5OP05MP2UxSuax6leOnkmw6+L6U=
X-Google-Smtp-Source: AGHT+IF4ZER0gWWbEdXbkCRaZ7/21/5hXaLlHZKiyJfPy9b6W8bzcbMPju4k5x9pBcSSai42l0CkM6Crn7RzHOcIUVWM7fT9nwo+
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ab:b0:4bb:624c:5a7f with SMTP id
 8926c6da1cb9f-4bbb6b8000dmr851056173.1.1720045465195; Wed, 03 Jul 2024
 15:24:25 -0700 (PDT)
Date: Wed, 03 Jul 2024 15:24:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f368c9061c5f4a28@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_acldata
From: syzbot <syzbot+165ba199a4fe7118b2de@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de0a9f448633 Merge tag 'riscv-for-linus-6.10-rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1161e12a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=165ba199a4fe7118b2de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be1f2c9340c9/disk-de0a9f44.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4c96e2040e3/vmlinux-de0a9f44.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb52b0488fbe/bzImage-de0a9f44.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+165ba199a4fe7118b2de@syzkaller.appspotmail.com

Bluetooth: Unexpected start frame (len 7)
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_recv_reset net/bluetooth/l2cap_core.c:7469 [inline]
BUG: KASAN: slab-use-after-free in l2cap_recv_acldata+0x325/0x1550 net/bluetooth/l2cap_core.c:7493
Read of size 8 at addr ffff8880202c10c8 by task kworker/u9:5/5096

CPU: 1 PID: 5096 Comm: kworker/u9:5 Not tainted 6.10.0-rc5-syzkaller-00253-gde0a9f448633 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2cap_recv_reset net/bluetooth/l2cap_core.c:7469 [inline]
 l2cap_recv_acldata+0x325/0x1550 net/bluetooth/l2cap_core.c:7493
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5089:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4154
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6864
 l2cap_connect_cfm+0x136/0x1220 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm+0xa2/0x150 include/net/bluetooth/hci_core.h:1970
 le_conn_complete_evt+0xd3e/0x12e0 net/bluetooth/hci_event.c:5761
 hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5787
 hci_event_func net/bluetooth/hci_event.c:7414 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7469
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4074
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 4477:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x149/0x360 mm/slub.c:4559
 l2cap_connect_cfm+0x11f/0x1220 net/bluetooth/l2cap_core.c:7237
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_conn_failed+0x1f6/0x340 net/bluetooth/hci_conn.c:1257
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5450
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:310
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2208
 __queue_work+0xaf2/0xee0 kernel/workqueue.c:2364
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2411
 queue_work include/linux/workqueue.h:621 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0xec2/0x1220 net/bluetooth/l2cap_core.c:7282
 hci_connect_cfm+0xa2/0x150 include/net/bluetooth/hci_core.h:1970
 le_conn_complete_evt+0xd3e/0x12e0 net/bluetooth/hci_event.c:5761
 hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5787
 hci_event_func net/bluetooth/hci_event.c:7414 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7469
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4074
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880202c1000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 200 bytes inside of
 freed 1024-byte region [ffff8880202c1000, ffff8880202c1400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x202c0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015041dc0 ffffea0001de3000 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015041dc0 ffffea0001de3000 dead000000000002
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea000080b001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 2480, tgid 2480 (kworker/u8:7), ts 97857353301, free_ts 95178990419
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x257/0x400 mm/slub.c:4136
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xd5/0x2870 net/mac80211/parse.c:880
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2332 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2339 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1574 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x4c8/0x2d70 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page last free pid 9 tgid 9 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
 __slab_free+0x31b/0x3d0 mm/slub.c:4349
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmalloc_trace_noprof+0x132/0x2c0 mm/slub.c:4149
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x19c2/0x4130 drivers/net/netdevsim/fib.c:1492
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880202c0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880202c1000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880202c1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880202c1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880202c1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
