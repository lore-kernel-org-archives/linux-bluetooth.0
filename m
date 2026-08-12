Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB237188B
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505376; cv=none; b=eInX+QLyIevzEmLtQ1Fx2ktubAeKTQbT+Kd28CZjAsLPaMsMwf2kg5DoTiZoWkwuskcVJAXCu1GhrdJVTwpzfEtqe/3CVb/WgKzj5SAL2/SN+haf+KAM63lBAxqoS+/dET+5JGI/wC/YBmz6nOIcgCW9nWHdnHfxHClpSHV+S+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505376; c=relaxed/simple;
	bh=2lX6r5IilJwO9HQd96gp772kRqVaC12xLoOYA05tuOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YQbmVLuZHUoYSfFY+KxTeGAvizg3wcDhuQeZ7spJpIKjZVdipdSpZyWtVBP52A4SkCfGnjNX3mBJJQZbHvufxR7IVF1UFo1nxhlvqH3cdDlBzCuPKnJy1hA4Xc6YZpB6pFtcvu4UZC9+JqTbgNdk/ptcimC3aawwTEJfBCePdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49d4cb3ca23so715840b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505373; x=1787110173;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzDciPQAdq5hpVaCTomf89CIolXJ8IMqzPIn0CGxceE=;
        b=dpbaqMQ6iKnoqORAIKmm94ObdAmiA7EecsA/yBynKhhfmYdF+KgT4njdqTREy1GLln
         WC1GFScUhSQiAZmkPS4yr8237xceTAo0UgHkGo5CR6czdP2TieeBLF6MmW9ZprlVJAyf
         6J8W45gT4VBrg/YXr4ciS/ro+RSKWgAzyE2+s/FBC8m6LONX22w/mq2U5K1xbON+IMTn
         XMmUbD6oh/MPOxJBkSOHQfcjdUsxwmRgbkuuXXZhZNmO+UmdwlXS0kmm3FsMuYrZ42it
         tbTxJ5eDZeEMl6X5AEes30F2RIQEqiT7xxkeIF+gbzCQMHCnn+AMqezUUl1CJwluqcVD
         VPCQ==
X-Gm-Message-State: AOJu0Yw3B8N3cBKZ7X9lKWDrO6ECSYbqL3SS1z9hwZdG8sYwDnYSsihP
	MPVwZzLhQb0VfO7eHLR2NZ2sC8FahZ0vXUooZCDud2H75m5Lix/BLX/VxM1u2WVC1oYV6aubjgx
	UMgEVh8v6z06tBNm+Ky65/dFoQD17fRpaSe+ivVmzs8n6CXjTAdJlI2S2j8kGTQ==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1303:b0:495:f74a:b572 with SMTP id
 5614622812f47-4b210a01b1amr1759130b6e.5.1786505373675; Tue, 11 Aug 2026
 20:29:33 -0700 (PDT)
Date: Tue, 11 Aug 2026 20:29:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7be89d.3668565d.e8814.000d.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_sent_cmd_data
From: syzbot <syzbot+5456069b73569089f7e8@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117f8132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30772517ee66ef58
dashboard link: https://syzkaller.appspot.com/bug?extid=5456069b73569089f7e8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cacf03defdd/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c376f093c1c8/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/396434a79317/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5456069b73569089f7e8@syzkaller.appspotmail.com

Bluetooth: hci5: unexpected cc 0x0c03 length: 249 > 1
==================================================================
BUG: KASAN: slab-use-after-free in hci_cmd_data net/bluetooth/hci_core.c:3119 [inline]
BUG: KASAN: slab-use-after-free in hci_sent_cmd_data net/bluetooth/hci_core.c:3134 [inline]
BUG: KASAN: slab-use-after-free in hci_sent_cmd_data+0x2c2/0x2d0 net/bluetooth/hci_core.c:3126
Read of size 2 at addr ffff8880657f8d08 by task kworker/u9:3/18543

CPU: 0 UID: 0 PID: 18543 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 hci_cmd_data net/bluetooth/hci_core.c:3119 [inline]
 hci_sent_cmd_data net/bluetooth/hci_core.c:3134 [inline]
 hci_sent_cmd_data+0x2c2/0x2d0 net/bluetooth/hci_core.c:3126
 hci_req_cmd_complete+0x4c/0x7f0 net/bluetooth/hci_core.c:3934
 hci_cmd_complete_evt+0x433/0xa20 net/bluetooth/hci_event.c:4297
 hci_event_func net/bluetooth/hci_event.c:7781 [inline]
 hci_event_packet+0x51c/0xcd0 net/bluetooth/hci_event.c:7835
 hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4039
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 18491:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_node_noprof+0x27d/0x6b0 mm/slub.c:4989
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:517 [inline]
 hci_cmd_sync_alloc+0x39/0x3d0 net/bluetooth/hci_sync.c:58
 hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
 __hci_cmd_sync_sk+0x151/0xcf0 net/bluetooth/hci_sync.c:168
 __hci_cmd_sync_status_sk+0x48/0x190 net/bluetooth/hci_sync.c:263
 __hci_cmd_sync_status net/bluetooth/hci_sync.c:287 [inline]
 hci_reset_sync net/bluetooth/hci_sync.c:3787 [inline]
 hci_init1_sync net/bluetooth/hci_sync.c:3873 [inline]
 hci_init_sync net/bluetooth/hci_sync.c:5065 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:5257 [inline]
 hci_dev_open_sync+0xce9/0x25c0 net/bluetooth/hci_sync.c:5335
 hci_dev_do_open+0x2a/0xb0 net/bluetooth/hci_core.c:428
 hci_power_on+0x131/0x630 net/bluetooth/hci_core.c:920
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880657f8d00
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 8 bytes inside of
 freed 704-byte region [ffff8880657f8d00, ffff8880657f8fc0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x657f8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140487b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888140487b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 18482, tgid 18482 (syz-executor), ts 853476511834, free_ts 851474883257
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 kmem_cache_alloc_node_noprof+0x52c/0x6b0 mm/slub.c:4989
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 skb_copy+0x1ca/0x3a0 net/core/skbuff.c:2191
 mac80211_hwsim_tx_frame_no_nl+0xc7f/0x1830 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2020
 mac80211_hwsim_tx_frame+0x1b7/0x250 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2417
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim_main.c:2430 [inline]
 mac80211_hwsim_beacon_tx+0x56c/0xa00 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2493
 __iterate_interfaces+0x2e6/0x650 net/mac80211/util.c:775
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:811
 mac80211_hwsim_beacon+0xe5/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:2525
page last free pid 190 tgid 190 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 kasan_depopulate_vmalloc_pte+0x5d/0x80 mm/kasan/shadow.c:484
 apply_to_pte_range mm/memory.c:3338 [inline]
 apply_to_pmd_range mm/memory.c:3382 [inline]
 apply_to_pud_range mm/memory.c:3418 [inline]
 apply_to_p4d_range mm/memory.c:3454 [inline]
 __apply_to_page_range+0xb1d/0x1520 mm/memory.c:3490
 __kasan_release_vmalloc+0xd7/0xe0 mm/kasan/shadow.c:602
 kasan_release_vmalloc include/linux/kasan.h:593 [inline]
 kasan_release_vmalloc_node mm/vmalloc.c:2284 [inline]
 purge_vmap_node+0x210/0xb40 mm/vmalloc.c:2306
 __purge_vmap_area_lazy+0x90a/0xc00 mm/vmalloc.c:2396
 drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2430
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880657f8c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880657f8c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880657f8d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880657f8d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880657f8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Bluetooth: hci5: unexpected event for opcode 0x0c03
Bluetooth: hci5: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci7: command 0x0406 tx timeout


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
