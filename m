Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9A13AD26
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735238730; cv=none; b=Kb5gxuDRhjMkmskWa80WoQbEUGepw4sy8Ddv3D/SyTr0YGrXVLJhcURsWx/0AWZX72ZcdcY9QfTJuhBT3424FO/VrrZrGgwY5alWFXCT66lN5mWW6nQrbC4679cb9761tTMU4FS2CG3O39e1kcKjFk+3ie6YESOFJBA5iQVap+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735238730; c=relaxed/simple;
	bh=3Sqb1NtS05/65tKpFjZLlumOdeZwYQCnI6rupGmxCSQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q4rI0geGTm6PhjzQAsGwnqlFaPgp0c1+vrEmk1Lw8uL6yBGKfkvisKQcYj0FnK36oee5wBNMWgTUIQYF8Vp/vlLmTCcRWazzM/eCN+gASuZJhfsvd5rzTWH08lOhN/uYTQHEadmDyjmrCMLWyKzcNZkTpzoh5jAbDOGSJKtMKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844e619a122so584327239f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 10:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735238728; x=1735843528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3OvxQgpDk7nSI+HOqJBfQqCrgD+0n3JjMpc5VJpHL8=;
        b=CX88wv1ufFzt44BVY5qdHv3xvFrmYohigEr7v0gEEjI9o0sQsOeqaTMC9cgDCJWyvZ
         Q35duHtaaE52sFLWMbcdL6b7WVchtE0/MoIFlvRg6Xno8Ah7xuAWrF/oUXpYW3I45BeP
         Y1LYdwil5juZp09fqyC03erGPyGvS4V49ygbHuWkuEZOre9uUDLr9LKzFZmGDEKb8CIm
         8+Uj9kCdOs6nq86MDzP6ai7pR+h9y/nj2Lgh+j9e+fbc0s5k1nciJ3qaVistupp3umGp
         f7K1lZ90kVmXjEBMrgGTExc//oVMWqOxMKU5iMMoo1MO3mdNzqWp2IY8E47Ow+WpDfIy
         4HTg==
X-Gm-Message-State: AOJu0YytZhxa6S1wjKQ7wZbwaheBjdEvG09E1nr/m7W0i8Ycyk9OMO7c
	VcJ1apB+L/7/YiUmcuEjxShrxnr2B/R+/Y+JCQeckEOF7Mo4ZW1llWckMQTQGOcSzgUOYhkDpJB
	B3qg2mpGRKTV+ChHPPQH22iKgx3jCM3e19I38bfFUx2Ed9A4vBAXcRSx0lg==
X-Google-Smtp-Source: AGHT+IG6F+sgYJa/Vf2nE1u++1AEpe4pQgy3f/lQ6Rcy/A1o7XtosmGOsLZn5hIRF9wOVG4NnXbzSvDxJv5DPzY2+31hDQNJGm9p
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3c2d2783632mr180098155ab.12.1735238728020; Thu, 26 Dec 2024
 10:45:28 -0800 (PST)
Date: Thu, 26 Dec 2024 10:45:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676da447.050a0220.2f3838.0470.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in msft_opcode_get
From: syzbot <syzbot+8def80b4fcd383be0e59@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139ec0b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=8def80b4fcd383be0e59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d66e09941d/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa24ea0a81d/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9c0b1e880a/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8def80b4fcd383be0e59@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in msft_opcode_get+0x6d/0x80 drivers/bluetooth/hci_vhci.c:222
Read of size 2 at addr ffff88802b5f7232 by task syz.2.1805/13856

CPU: 1 UID: 0 PID: 13856 Comm: syz.2.1805 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 msft_opcode_get+0x6d/0x80 drivers/bluetooth/hci_vhci.c:222
 simple_attr_read+0x169/0x300 fs/libfs.c:1341
 debugfs_attr_read+0x74/0xa0 fs/debugfs/file.c:507
 full_proxy_read+0xfb/0x1b0 fs/debugfs/file.c:351
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df7585d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4df845f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f4df7775fa0 RCX: 00007f4df7585d29
RDX: 00000000000000e1 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007f4df7601aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4df7775fa0 R15: 00007fff18a8d4b8
 </TASK>

Allocated by task 3447:
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
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 3447:
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
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802b5f7000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 562 bytes inside of
 freed 1024-byte region [ffff88802b5f7000, ffff88802b5f7400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b5f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000ad7c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11884013488, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
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
 kmalloc_array_noprof include/linux/slab.h:946 [inline]
 vivid_init_dv_timings drivers/media/test-drivers/vivid/vivid-core.c:1301 [inline]
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1869 [inline]
 vivid_probe drivers/media/test-drivers/vivid/vivid-core.c:2093 [inline]
 vivid_probe+0x1cce/0xba20 drivers/media/test-drivers/vivid/vivid-core.c:2078
 platform_probe+0xff/0x1f0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __driver_attach+0x283/0x580 drivers/base/dd.c:1216
 bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:370
 bus_add_driver+0x2e9/0x690 drivers/base/bus.c:675
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802b5f7100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b5f7180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b5f7200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802b5f7280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b5f7300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
