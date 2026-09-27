Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7438737B
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790475998; cv=none; b=cnh3jpuQourexFOXWNtocR/MYQFPslOsYob3KVzLGQBa1Bb5YVyvQadVF/qjS4CvLu/O3Q2vjf2N/45HvPH06vykMurWjFBaUffZ7LFQD6TXmXV6hNUxUdkfowGDXB3djUt5ZS9w1oHsPaBqvJbmjZ3U73euoKgBIYAK0BiBRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790475998; c=relaxed/simple;
	bh=sM3I7HXgiOIdNuyuDnWMoIyfqq4c3XTbfWLpp5l2CpI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ijop/zNmLkgV8EVJoDNZba3n9+HQ9fcpDm7877hPonMY3BT51HFl2zGrlkLU4Cg0px3X/HHTgaXuNUJaQuSWZjZFlYXwc/vlG/q3hxp9JC8ikLW7zX6Tn44HZwoTMn8YfYP/mWtQKfbL+mQSbfP0TSc41vcqEi0YxA3xacHOpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b28dbf4197so4205071b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 19:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790475996; x=1791080796;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKewelgkNnmdKAI6PeTB74kxr7p78AqxXxxeKV6ck4c=;
        b=gGWhcRdsfVek8Z2prjJ2XIj9mSq4ChBGgTcrqvlBWQMWrzKiyIEtWm9WMFOFBfILBS
         yIVfR17RrtBb6YFkgoDVePYkQbtOIkxzuPXxBZ6d8e0cB6pOJI77y7g0AWgUKZKdhFAA
         ODD+LO3zBKgijTDmpfWAM0nVnKT8qd/HZ3jpppgwmt/YTden39sOBHl4Cd40HSYWdS7t
         twv+olOQMP3cyf5LdOGOKKumRNzplyHKxti2WYNFlsmikD/c0DmuekrVEvU48cfHIT/i
         +eSHxv1dVXURVLN46BRM4eqSZRjOnIadL0pNiA3w8TlH52VLBT6aglDK67j9KrfYkBRz
         YoOg==
X-Gm-Message-State: AFuF++kCGj/5JhTAQ/4EJZuyvN5+DGvjyEgCcPVKS1QVbFXwNvQDSJB8
	EL6V9ugkvURawK06NCQFqID93p5fTVXOSENtDhjrwRN+wwKWICogsAIbX51nx2Ahc+8UyiQJjnB
	7Cih6opM6WXSvrWKyzK2rlQolKeGdijoo1qzP8KYiujrNzkMz072IubPgbxE=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe0:b0:4d6:90d3:e187 with SMTP id
 5614622812f47-4d72ea5cc31mr10976484b6e.48.1790475996002; Sat, 26 Sep 2026
 19:26:36 -0700 (PDT)
Date: Sat, 26 Sep 2026 19:26:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab87edb.dc2998a4.2261f5.005e.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_le_flowctl_send
From: syzbot <syzbot+fd83abd5dea6cfbdfd79@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c4e9f74da438 Merge tag 'v7.3-p5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104c8405580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=718e346eb0b8f38
dashboard link: https://syzkaller.appspot.com/bug?extid=fd83abd5dea6cfbdfd79
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fbdba12c475e/disk-c4e9f74d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/440df4639120/vmlinux-c4e9f74d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55edb7f0e94e/bzImage-c4e9f74d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd83abd5dea6cfbdfd79@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_le_flowctl_send+0xce/0x230 net/bluetooth/l2cap_core.c:2560
Read of size 2 at addr ffff88802b7a9086 by task kworker/1:6/5786

CPU: 1 UID: 0 PID: 5786 Comm: kworker/1:6 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events do_notify_peers
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 l2cap_le_flowctl_send+0xce/0x230 net/bluetooth/l2cap_core.c:2560
 l2cap_chan_send+0x1d14/0x2310 net/bluetooth/l2cap_core.c:2638
 send_pkt net/bluetooth/6lowpan.c:455 [inline]
 send_mcast_pkt net/bluetooth/6lowpan.c:496 [inline]
 bt_xmit+0x18a9/0x2250 net/bluetooth/6lowpan.c:546
 __netdev_start_xmit include/linux/netdevice.h:5429 [inline]
 netdev_start_xmit include/linux/netdevice.h:5438 [inline]
 xmit_one net/core/dev.c:3937 [inline]
 dev_hard_start_xmit+0x2df/0x870 net/core/dev.c:3953
 sch_direct_xmit+0x257/0x4c0 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4262 [inline]
 __dev_queue_xmit+0x16ce/0x3880 net/core/dev.c:4884
 NF_HOOK_COND include/linux/netfilter.h:314 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:248
 dst_output include/net/dst.h:471 [inline]
 NF_HOOK+0x177/0x4f0 include/linux/netfilter.h:325
 mld_sendpack+0x890/0xe10 net/ipv6/mcast.c:1890
 ipv6_mc_rejoin_groups net/ipv6/mcast.c:2914 [inline]
 ipv6_mc_netdev_event+0x1b7/0x5a0 net/ipv6/mcast.c:2929
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
 call_netdevice_notifiers net/core/dev.c:2327 [inline]
 __netdev_notify_peers net/core/dev.c:1646 [inline]
 netdev_notify_peers+0xed/0x160 net/core/dev.c:1663
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 4907:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 l2cap_chan_create+0x51/0x7a0 net/bluetooth/l2cap_core.c:447
 l2cap_new_connection+0x1b/0x150 net/bluetooth/l2cap_core.c:4086
 l2cap_le_connect_req net/bluetooth/l2cap_core.c:5057 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5653 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5719 [inline]
 l2cap_recv_frame+0xc8b2/0x10830 net/bluetooth/l2cap_core.c:7146
 l2cap_recv_acldata+0x7a1/0x1460 net/bluetooth/l2cap_core.c:7889
 hci_acldata_packet net/bluetooth/hci_core.c:3831 [inline]
 hci_rx_work+0x4f9/0x1020 net/bluetooth/hci_core.c:4058
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5603:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6801
 l2cap_conn_del+0x35b/0x550 net/bluetooth/l2cap_core.c:1838
 l2cap_connect_cfm+0x12b/0x1620 net/bluetooth/l2cap_core.c:7567
 hci_connect_cfm include/net/bluetooth/hci_core.h:2166 [inline]
 hci_conn_failed+0x1e8/0x370 net/bluetooth/hci_conn.c:1434
 hci_abort_conn_sync+0xdd0/0x1190 net/bluetooth/hci_sync.c:6014
 hci_cmd_sync_work+0x20b/0x3f0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802b7a9000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 134 bytes inside of
 freed 2048-byte region [ffff88802b7a9000, ffff88802b7a9800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802b7ad000 pfn:0x2b7a8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88813ffbe000 ffffea0001011610 ffffea0001025610
raw: ffff88802b7ad000 0000000000080004 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88813ffbe000 ffffea0001011610 ffffea0001025610
head: ffff88802b7ad000 0000000000080004 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5601, tgid 5601 (syz-executor), ts 138679625517
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_node_track_caller_noprof+0x61e/0x7b0 mm/slub.c:5545
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 pskb_expand_head+0x22c/0x13a0 net/core/skbuff.c:2315
 netlink_trim+0x1b3/0x2c0 net/netlink/af_netlink.c:1319
 netlink_broadcast_filtered+0x6d/0xea0 net/netlink/af_netlink.c:1537
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xe3/0x1a0 net/netlink/af_netlink.c:2618
 rtnl_notify net/core/rtnetlink.c:994 [inline]
 rtmsg_ifinfo_send net/core/rtnetlink.c:4614 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4630 [inline]
 rtnetlink_event+0x224/0x270 net/core/rtnetlink.c:7197
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
 call_netdevice_notifiers net/core/dev.c:2327 [inline]
 netif_set_mac_address+0x393/0x4d0 net/core/dev.c:10056
 do_setlink+0x9ad/0x4670 net/core/rtnetlink.c:3223
 rtnl_changelink net/core/rtnetlink.c:3910 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4081 [inline]
 rtnl_newlink+0x15a3/0x1c30 net/core/rtnetlink.c:4220
page last free pid 5764 tgid 5764 ts 138308242891 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x250/0x2a0 mm/slub.c:5823
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x360/0x690 mm/slub.c:5010
 vm_area_dup+0x28/0x750 mm/vma_init.c:128
 __split_vma+0x1d7/0xa00 mm/vma.c:560
 vms_gather_munmap_vmas+0x4e3/0x1370 mm/vma.c:1528
 __mmap_setup mm/vma.c:2546 [inline]
 __mmap_region mm/vma.c:2869 [inline]
 mmap_region+0x949/0x2220 mm/vma.c:2974
 do_mmap+0xe0e/0x1310 mm/mmap.c:573
 vm_mmap_pgoff+0x275/0x4e0 mm/util.c:581
 ksys_mmap_pgoff+0x4a6/0x720 mm/mmap.c:619
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802b7a8f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b7a9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b7a9080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802b7a9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b7a9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
