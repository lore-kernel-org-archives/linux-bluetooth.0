Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91C15442D
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737197008; cv=none; b=Q5/lFeS2edkZR0+wvDoT0zy5z/nJBUB/G0jvJBfVlfaHFe7DbGDU0omGDO0sakb47BJeeEADh9ElUOoXh0vRl9nVNivnEjFo11WPiVzXIyez1j0Er7PMVWHH7cC4JM8jmRCfv47XBtOHQazHkkrH+POYEh0qS7KOknqZQwjJAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737197008; c=relaxed/simple;
	bh=yKzozZ/wbMHJbCSFKeWDaJlejQT9nfbuJSlEhzyA8p8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oV5vKRAgfb7ex1U7afQ7TDaseH5L9Kt3OiMvnZjZz+vFicWvLvKinttwphDnEQYy9dtFQyuzV+ydE1pBzjQzSUQCg72pT+UZOTDcKJWaGKQbnI7YK7A/EeVfy6ONXEABxkgrOm20GSPX2fAcI7bM5HJiN7YJfmWDtU+pCjAYNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo21256235ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2025 02:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737197006; x=1737801806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDO/25xXF5wKEw4HQRnR7+XKMXlW8UlgaPgVUyuG1Ok=;
        b=nZMTdg4LR3Odo/0wbBbU0ZJpgi5fPSv0yWmE6I6t5Ktj1sBo1mMwjApi793ueHqZGt
         Svxm6DyR4/1a19Tn0DNay8O8wfrWzPMKU8FCyRq+2M72Xwn01+7Oeb15ECgVp+U4PNeD
         8BKosQ7O8cSgMEo5AMLkjNE81kqHZ9mGFOCyvg/0okZGcwGGBYoUi9KFP2MN2rRHKaW8
         WGa44TX8XGuAQYlPSWVH1OobeccE0MD1QcOgE8jtPX1iI0spAcA1vUimOUfA6IF8PNvC
         u1mDYy/xsafNlirCQCMDX7D3bG1iRf06phbQouwzChc9mAWCmZS/CB2sstyp1LUHNaYn
         JGvQ==
X-Gm-Message-State: AOJu0YyozCQaa9EIvkWsbBY4eNzz405tRrgSJND3HvtYWeA2SiUWN62b
	B6W1J4h1/hrcf9s645r3ECQPr9q4P2mFqUsW7KfbPMpURlDfXM4CL2VNS8/jEG2lYMN+ak1fHQX
	lyCd1VsUi0egCMZO1pi76PXm+cIhYTRDMMFyxhBEHBjW/EkseJFY14N9LEQ==
X-Google-Smtp-Source: AGHT+IGDRl0rZjE8qzH+2gfgO5Jqkl5PYx/zsaYdG/ckpHwveNL73ACzsCOJ+iRvXy4qJpjmJEYexLYgoSGKC7N9gAmSk8hbDuHS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3ce:8b1b:2f with SMTP id
 e9e14a558f8ab-3cf7447bd09mr40949585ab.17.1737197006081; Sat, 18 Jan 2025
 02:43:26 -0800 (PST)
Date: Sat, 18 Jan 2025 02:43:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678b85ce.050a0220.303755.0020.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in force_suspend_read
From: syzbot <syzbot+ab87589efe0b67f5fa32@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad26fc09dabf Merge tag 'mm-hotfixes-stable-2025-01-16-21-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1665ba18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e182416a4b418f
dashboard link: https://syzkaller.appspot.com/bug?extid=ab87589efe0b67f5fa32
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3b08aaffb71/disk-ad26fc09.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6acc360315d5/vmlinux-ad26fc09.xz
kernel image: https://storage.googleapis.com/syzbot-assets/511986c933e3/bzImage-ad26fc09.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab87589efe0b67f5fa32@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in force_suspend_read+0x12e/0x150 drivers/bluetooth/hci_vhci.c:118
Read of size 1 at addr ffff888028144230 by task syz.5.7304/9155

CPU: 0 UID: 0 PID: 9155 Comm: syz.5.7304 Not tainted 6.13.0-rc7-syzkaller-00160-gad26fc09dabf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 force_suspend_read+0x12e/0x150 drivers/bluetooth/hci_vhci.c:118
 full_proxy_read+0xfd/0x1b0 fs/debugfs/file.c:364
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f868db85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f868e8ef038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f868dd75fa0 RCX: 00007f868db85d29
RDX: 0000000000000054 RSI: 00000000200009c0 RDI: 0000000000000005
RBP: 00007f868dc01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f868dd75fa0 R15: 00007ffd08717638
 </TASK>

Allocated by task 5720:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xe6/0x1630 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1576 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xc54/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5720:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1581 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1ae3/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888028144000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 560 bytes inside of
 freed 1024-byte region [ffff888028144000, ffff888028144400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888028146800 pfn:0x28140
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801ac41dc0 ffffea0001ef1610 ffffea0001820c10
raw: ffff888028146800 000000000010000f 00000001f5000000 0000000000000000
head: 00fff00000000240 ffff88801ac41dc0 ffffea0001ef1610 ffffea0001820c10
head: ffff888028146800 000000000010000f 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a05001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 3558, tgid 3558 (kworker/u8:10), ts 74874455836, free_ts 74481983934
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2de/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xe6/0x1630 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_inform_bss+0xf1/0x10f0 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x8b1/0x1e40 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x254/0x3e40 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x252/0x8a0 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1956/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
page last free pid 5911 tgid 5907 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xa7b/0x14f0 mm/page_alloc.c:2706
 folios_put_refs+0x587/0x7b0 mm/swap.c:962
 folio_batch_release include/linux/pagevec.h:101 [inline]
 invalidate_inode_pages2_range+0xed6/0x1320 mm/truncate.c:653
 filemap_invalidate_pages mm/filemap.c:2748 [inline]
 kiocb_invalidate_pages+0x108/0x180 mm/filemap.c:2756
 blkdev_direct_write block/fops.c:645 [inline]
 blkdev_write_iter+0x4a3/0xd40 block/fops.c:719
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888028144100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028144180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028144200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888028144280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028144300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
