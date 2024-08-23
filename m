Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F43188001
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426062; cv=none; b=bLLl9NOUq/S86nHsdGl8LytzFvehhHN3ztp6w9qIoMl2ho0yAXY/XxEsZthYl/J90vjCvD6tsxTbzaFtL+ZoGNk6CJlamotPavVcGdmCqvn2jkEFTSi8TRt6am+UNQ6xcyUzVQHGNezIiA8SHtS1OPBP7mLkEgdu5PZXRF8+R2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426062; c=relaxed/simple;
	bh=vsGCjAmyrORdFS+M/BqShUh+s8JLxLFT1BL33SU6QJs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GS0ZPr4WbtI02Kd9Ql0vwRg/YirPh28/gB6yyEqLVXW+dXldZ9kEZcDmlqayfXAuuesOzTCwbQXmK+oJJXirVcwQUnX8EcFW7ngzar//ffxbDfmrUF2P6o234YxZ/wLss5KX12EkcGU3+lMWdHfdsLMWqUN2riw3Oqq0Dvvd+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso28330625ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426060; x=1725030860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MUKuratFLj7ZGrfVajeIHCxMGnODgSDCJIfymWzxNY=;
        b=vS40Y6cS57zAsbzK0BhJUsE2DCCy3inatsw2YEzOszKO8gwQx37JaJ7XhI+KJTjt5U
         +tIQCIzD+R1ijdbUvSA6Kn9XySlnuTqnwu+a/SMFPWf+DnXxFY4yFzj8xOq2n/wwvj8o
         ofpBkf0w2M+KA3PeKA2YcI/vnL/+Xhnq6cSy5I7HDZ02uDBsBhX4aQRuyPA81FymsjEH
         vDkk41tMKkO6Yu/8EsMK6k1S6/KtiwSAcOKep4nw+wlZjSFSpafO8A1kzTAcgimYWu6V
         bfbOrfwsi4uzQJfv9iox3O6kaBjWz5NLjUoRJXb++faPRjzIId575NC8sSArS20yTy4m
         j4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpyJbYzndkeTcZ7gNHZPSp9+L789ge/dG2t1qiwFwiuTWpOW0hLEZpHHgZQeDRIxK4SQk8sm2Kyjk7VtOrvek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLfFGFZEUjw/ZXMKTW/waeVyok1enTG79xGrkR7wIYfi2r7dm
	0scB4YpK1H9J5zkKANJXW/qwP7z/gI4vJ9JjWOYD+EbStRVaMQVa+Rk4yYXeLg0oxknLwzNnnhA
	IapgCrxGG0sqnLwY1AUW/NQv+x9bND1jkcKA/pB4gIUMNAeAwt7iHims=
X-Google-Smtp-Source: AGHT+IH51A8idB+2kxFairZBfVtETX3DiUSSmC6OnR1n6qpQO6MovqZfBFd1j87lr5wgOu4VGTzG5GjEekak+vXy2BjuT1JcMUQa
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:376:417e:c2ab with SMTP id
 e9e14a558f8ab-39e3c9fe575mr850885ab.5.1724426059885; Fri, 23 Aug 2024
 08:14:19 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:14:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdb8fd06205b3ae5@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_conn_unreliable
From: syzbot <syzbot+fceada3b822ff218d04c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f546873149 minmax: improve macro expansion and type chec..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1342c1c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=fceada3b822ff218d04c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e475c4ebb27/disk-22f54687.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/333e92710b31/vmlinux-22f54687.xz
kernel image: https://storage.googleapis.com/syzbot-assets/830d57b60fec/bzImage-22f54687.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fceada3b822ff218d04c@syzkaller.appspotmail.com

Bluetooth: Frame is too long (len 10, expected len 9)
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff88806545bb30 by task kworker/u9:7/5242

CPU: 1 UID: 0 PID: 5242 Comm: kworker/u9:7 Not tainted 6.11.0-rc1-syzkaller-00044-g22f546873149 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 l2cap_conn_unreliable+0x39/0x1a0 net/bluetooth/l2cap_core.c:1650
 l2cap_recv_acldata+0x50f/0x1560
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4034
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 13048:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6867
 l2cap_connect_cfm+0x136/0x1220 net/bluetooth/l2cap_core.c:7244
 hci_connect_cfm include/net/bluetooth/hci_core.h:1965 [inline]
 hci_remote_features_evt+0x538/0xaf0 net/bluetooth/hci_event.c:3720
 hci_event_func net/bluetooth/hci_event.c:7445 [inline]
 hci_event_packet+0xac4/0x1540 net/bluetooth/hci_event.c:7497
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4029
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 13048:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 l2cap_connect_cfm+0x11f/0x1220 net/bluetooth/l2cap_core.c:7240
 hci_connect_cfm include/net/bluetooth/hci_core.h:1965 [inline]
 hci_conn_failed+0x1f8/0x340 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5510
 hci_cmd_sync_work+0x22d/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2185
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2341
 call_timer_fn+0x190/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1838 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2185
 __queue_work+0xb66/0xf50 kernel/workqueue.c:2345
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:621 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0xec2/0x1220 net/bluetooth/l2cap_core.c:7285
 hci_connect_cfm include/net/bluetooth/hci_core.h:1965 [inline]
 hci_remote_features_evt+0x538/0xaf0 net/bluetooth/hci_event.c:3720
 hci_event_func net/bluetooth/hci_event.c:7445 [inline]
 hci_event_packet+0xac4/0x1540 net/bluetooth/hci_event.c:7497
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4029
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88806545b800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 816 bytes inside of
 freed 1024-byte region [ffff88806545b800, ffff88806545bc00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65458
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff888015841dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff888015841dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0001951601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 15065, tgid 15054 (syz.1.2483), ts 1176364619320, free_ts 1175156684888
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 ieee802_11_parse_elems_full+0xdb/0x2880 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2361 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2368 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xe95/0x2030 net/wireless/scan.c:2335
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3249
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
page last free pid 15058 tgid 15057 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 discard_slab mm/slub.c:2583 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3051
 put_cpu_partial+0x17c/0x250 mm/slub.c:3126
 __slab_free+0x2ea/0x3d0 mm/slub.c:4343
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_track_caller_noprof+0x1cd/0x440 mm/slub.c:4177
 memdup_user+0x2b/0xc0 mm/util.c:226
 raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:673 [inline]
 raw_ioctl_ep0_write drivers/usb/gadget/legacy/raw_gadget.c:763 [inline]
 raw_ioctl+0x1f03/0x3cd0 drivers/usb/gadget/legacy/raw_gadget.c:1312
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806545ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806545ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806545bb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88806545bb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806545bc00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
