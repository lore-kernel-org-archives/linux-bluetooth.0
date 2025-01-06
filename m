Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDA1D5CE0
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154266; cv=none; b=jE6EhsKZDNYchtUiEy7BuP1Q0cFXdVtttcJjUc4x9fu52HkpagvsF8o3Ggx2I2O+WWsEYKlm1i9vqRbcszbPuU9Mr/K36rRdlCWFPNeR4D1975UvEaI2mT0czKBdjb7wiTWpJJtFxJLL9jLExX7UWSlwcbOJzDChodhTkz51LM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154266; c=relaxed/simple;
	bh=OC5uJUVv5HecBrIRg7dKFVIYiXiU2fHX7DWmPQ4Zxmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fkgxk1zE2V6CqqNTdRR3hFJUZFyrhzuCbLpMXO6uw2eGwVsVGZFvIfqZ1kXJrGe3NMKaYsulXV6eA+7ytVXSIX7njofbiVmzgaoKUkzEal0r84ENc/HqOfCJfg+4E7YXPsIgA9dORrVr022lCHiKuzNs8GEg4os50R5eMEWbWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844db0decffso1176713639f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2025 01:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736154263; x=1736759063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF5DwVyrc8nLjutE/sgYOeyTy/1TYgozboQLsDUNy2I=;
        b=xJSr6x6B8X9o9Lyz8sOTsZEKKdqyxpFh1ZlMZJJdVE1qz92GSQuakjuRgrNaIxRlxV
         7Xkzv6IWRvX1pIal0LI1TBkfVGHCYoIPt42bm49BABpgrg0BjexLcJUBDLUPkOQDDln/
         psxl05d+kSGwz4gKlT3Xi00gFPUnDBbZqNFOUfXLPga/QE3ttO/OuX0fbLU6NBeGHDcE
         eeB9m8t03I6an0Zn0aPa1GIagWFvztVOQPK4FFx3k6o/2d0GCIDjREcAPU3ZT5PzdNdV
         DR+RXpEs1ZE0GnX58gR54Zp3OWEJqdh4y8HggWtBQiYVewHStMScdRFbhnNS+yIn4rbS
         vD+g==
X-Forwarded-Encrypted: i=1; AJvYcCUICVQCOMlZ1LgroAxr4IqlBWO1KomBz59afOXLNYTlmO6pWy2d1VAWXG6RUsylb6MgrpyK8FAfFy1M6p/XaMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIxwjbmE84OeycJ9OV9tHLckRx+Y1hgwuopcyXZLumFxWrpGU
	xqAgOBEoz4ieS2TT9ofA6aQnlv9dS+hLgTQez56A0YQJ5P51czPL/T96PhKqBPEq9+7xrjAVlDn
	q07+2uQrWcWDN0ZFP6HByJeuQSa8J20Bf8bIrwLcITvclKP1Y43VinTQ=
X-Google-Smtp-Source: AGHT+IFaDocLbGl7jcgudXwWe2FYAvZ/lEM1I9n6J2h0bi3nsmEyxPTu/6qf8YMfyR4Blzda/34z6iWMdvkefvddoPR385zKgxqq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3202:b0:3a7:cce2:d349 with SMTP id
 e9e14a558f8ab-3c3018aaef4mr380423175ab.8.1736154263706; Mon, 06 Jan 2025
 01:04:23 -0800 (PST)
Date: Mon, 06 Jan 2025 01:04:23 -0800
In-Reply-To: <00000000000070784806124596ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b9c97.050a0220.a40f5.0003.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f4330f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11261edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa36f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1740fef78c43/disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a74d1ace549b/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/524d100d5187/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com

BUG: KASAN: slab-use-after-free in l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837

CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
 l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5837:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 call_timer_fn+0x187/0x650 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1839 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2343
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0xdd5/0x1090 net/bluetooth/l2cap_core.c:7280
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880271a4000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff8880271a4000, ffff8880271a4400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x271a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 ffffea0001c09800 dead000000000002
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 ffffea0001c09800 dead000000000002
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00009c6801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 12, tgid 12 (kworker/u8:1), ts 7179124429, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page+0x59/0x110 mm/slub.c:2425
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_node_noprof+0x294/0x3a0 mm/slub.c:4337
 kmalloc_node_noprof include/linux/slab.h:924 [inline]
 blk_mq_alloc_hctx block/blk-mq.c:3935 [inline]
 blk_mq_alloc_and_init_hctx+0x17f/0xd50 block/blk-mq.c:4443
 blk_mq_realloc_hw_ctxs+0x19c/0xb00 block/blk-mq.c:4476
 blk_mq_init_allocated_queue+0x3f6/0x14c0 block/blk-mq.c:4530
 blk_mq_alloc_queue+0x1d3/0x2f0 block/blk-mq.c:4343
 scsi_alloc_sdev+0x76c/0xb80 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x1d4/0x4bd0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x205/0x1080 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_host_selected+0x37e/0x690 drivers/scsi/scsi_scan.c:1874
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880271a3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880271a3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880271a4000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880271a4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880271a4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
