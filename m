Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5814AD2D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511526; cv=none; b=byBJYqVAsrmUC+IvK+Z6tqxiPT4biyifVgDYlfbNggRGX4pFwNUD5ML2opV/vzI+11XeeZRw3zsLMLuLsF92LcIPccp0HMp1UqejkZfrm6aqzH60fpUqpK3GpNU0zXQ4oRhk7KCHY9O3iPrXd1+J4r4MtS5TgIL7wNcNCeCEdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511526; c=relaxed/simple;
	bh=gnfUhO4Vvq74SHY9XxTgYu279jiAgzUW6kHYAEDXbbc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FoVsHIwjHnplOdoINtJSV6QMTfszcYJu1sU5xF+Vi3mJMhtVF4e0HIdkeu+Zz6z+i/BvEr+e4buyUVGQ/mzLoe4XcBafTrU8gLmJzw333n9jPMenDjiRU0DrEU/oxG/1loKYPSqyfk7bhA+DAYCUiFJd4IYxyAZVPCQggkrN/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so78117605ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 07:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511523; x=1732116323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19ANk8VKOOq6GN4Sn746baBjjGMnhreBxx5wFifrNfE=;
        b=SlpZviVBwEVV7NMyqb8wWyKyJd3xzwzG5DsQXdMrezMdvqjd0jDJoms4C/KU0uKnWe
         8OGcz5uQgVwr6jlIxJWiyEvHN0+VRAcxa7dP1usm4+je8N7k8FQGsmnKX/uXNVJvkEGF
         1OAfszNn0uhwv2uGnGZUoEeub7c+lZ7LEu/Z1DE1C2X8agP/E5UeRtP2kexTp2JNklNm
         2B90ZL7vws+aabMJdaJYJKqqZIbEvXs++EBtkt29VcKqgaF9qsQCF8tX2DmnSXO3So2i
         GtJoyVzhpD+EqT4RfhxoKv3JY9UuKtiXN18BZzDsytm+NbzZFA1DEEvNNJ9J458IDQ1B
         tkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQH3QavuuOuCUijLQgOqq/IA/+FSWLUo2UfOb16dS/F1d/THTaE/gxhUZPTi+CXZ7UrHQ2Xgc9U/zSQWz/2EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuinShkV76WK4kFiJP4wC6tpjGL1JcuiacVTIe41Cw3dV0liE
	gHvbNBzzMY5HvleZ4+Y4ZsTBgp22a47a/ko/e5dn/5LlNb8J8Hfr851+BEJvRd//ob6p2POLv6a
	SBXh3gW6rs8ComybYEuVJbOxrJGqe+Nlyz2ZIPNYBcp3/fI2DcAsS+Kc=
X-Google-Smtp-Source: AGHT+IEHssUwIj5BOYphqN6QFQMvOmxnZqQRJnleNwqAvyLZd4E+VtaK3EqbkBG21wYYKaEyHavBfiXmeSxal0cdisE6pgezqVCh
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a7:1729:11c with SMTP id
 e9e14a558f8ab-3a7172902e3mr21667155ab.0.1731511523208; Wed, 13 Nov 2024
 07:25:23 -0800 (PST)
Date: Wed, 13 Nov 2024 07:25:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734c4e3.050a0220.2a2fcc.0025.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sk_skb_reason_drop
From: syzbot <syzbot+0fd4135ebd713ba973dc@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    da4373fbcf00 Merge tag 'thermal-6.12-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10679e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20d60fe605153ebe
dashboard link: https://syzkaller.appspot.com/bug?extid=0fd4135ebd713ba973dc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c048ef220197/disk-da4373fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72888da151fb/vmlinux-da4373fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b8d553e33fe/bzImage-da4373fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fd4135ebd713ba973dc@syzkaller.appspotmail.com

Bluetooth: Unexpected start frame (len 30)
Bluetooth: hci0: ACL packet for unknown connection handle 201
Bluetooth: Unexpected start frame (len 30)
Bluetooth: Unexpected start frame (len 30)
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:264 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:307 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:325 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1232 [inline]
BUG: KASAN: slab-use-after-free in __sk_skb_reason_drop net/core/skbuff.c:1213 [inline]
BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x3d/0x1a0 net/core/skbuff.c:1241
Write of size 4 at addr ffff888061a885e4 by task kworker/u9:3/5829

CPU: 0 UID: 0 PID: 5829 Comm: kworker/u9:3 Not tainted 6.12.0-rc6-syzkaller-00272-gda4373fbcf00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 skb_unref include/linux/skbuff.h:1232 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1213 [inline]
 sk_skb_reason_drop+0x3d/0x1a0 net/core/skbuff.c:1241
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 l2cap_recv_reset net/bluetooth/l2cap_core.c:7465 [inline]
 l2cap_recv_acldata+0x129/0xb70 net/bluetooth/l2cap_core.c:7489
 hci_acldata_packet net/bluetooth/hci_core.c:3799 [inline]
 hci_rx_work+0xb1c/0x16c0 net/bluetooth/hci_core.c:4036
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5829:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4186
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:494 [inline]
 l2cap_recv_frag+0x13d/0x2b0 net/bluetooth/l2cap_core.c:7412
 l2cap_recv_acldata+0x2a1/0xb70 net/bluetooth/l2cap_core.c:7520
 hci_acldata_packet net/bluetooth/hci_core.c:3799 [inline]
 hci_rx_work+0xb1c/0x16c0 net/bluetooth/hci_core.c:4036
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 10810:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x152/0x4b0 mm/slub.c:4681
 kfree_skbmem+0x1a4/0x1f0 net/core/skbuff.c:1148
 __kfree_skb net/core/skbuff.c:1205 [inline]
 sk_skb_reason_drop+0x136/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 l2cap_conn_del+0xa5/0x730 net/bluetooth/l2cap_core.c:1760
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7233
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x340 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5596
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5619
 hci_suspend_sync+0x772/0xab0 net/bluetooth/hci_sync.c:6096
 hci_suspend_dev+0x30a/0x510 net/bluetooth/hci_core.c:2832
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2412
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:353 [inline]
 blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:341
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x189/0x2b0 kernel/power/user.c:77
 misc_open+0x35a/0x420 drivers/char/misc.c:165
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6ca/0x1530 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888061a88500
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff888061a88500, ffff888061a885f0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61a88
memcg:ffff888032bbc881
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ea91780 dead000000000100 dead000000000122
raw: 0000000000000000 00000000000c000c 00000001f5000000 ffff888032bbc881
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 8566, tgid 8562 (syz.0.484), ts 331157518755, free_ts 327767117142
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_node_noprof+0xed/0x310 mm/slub.c:4186
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 skb_copy+0x1c9/0x3a0 net/core/skbuff.c:2159
 mac80211_hwsim_tx_frame_no_nl.isra.0+0xb7f/0x12f0 drivers/net/wireless/virtual/mac80211_hwsim.c:1866
 mac80211_hwsim_tx_frame+0x1eb/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim.c:2215
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim.c:2232 [inline]
 mac80211_hwsim_beacon_tx+0x592/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2315
 __iterate_interfaces+0x2d0/0x5d0 net/mac80211/util.c:774
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:810
 mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
page last free pid 5200 tgid 5200 stack trace:
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
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x86/0x160 fs/stat.c:340
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888061a88480: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888061a88500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888061a88580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff888061a88600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888061a88680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
