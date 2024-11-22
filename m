Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3B148FF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295248; cv=none; b=e4Y3eaN6Y7kNigt8B9NhtGTjCnW7nct9BJ4W6Vtzp6CKX5KVthT8tjKeuNltELD8Ih9qNq8IihNtNZ5WAJUQ+f4zBGj1oXhHm4aQ4qoo1fIPqtbV0novYQ3/IIFtd3DehV2wjco3F4jhGhKTNtW/PS2eHoq8O6uFIEW/ATBp044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295248; c=relaxed/simple;
	bh=wiisfid/sAxys2hN9FjrQ7oeWhDpvwgtJa37EyEL3E4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=paAFU9UtosrKCRHWHosc1sIpGzVog+YSCALq/gCiWUTKCUaeOA0OJKR3ESys/pAhJg5p7lFfTKrRMLXH6JzRzkDvYsunFH9mSdeBs/gSPCNxdVI5VMJz6BPxH1J4jW1olWoPqCUO79FI4y9WE27cLHm1I6jWemZkYO5C9Yol+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso23747665ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 09:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295244; x=1732900044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV7/Z96y1t6ErxUYybbcDtRoUyJd7oaTIAGkutVr/lI=;
        b=xCvBOWMfuXhfyQ1CBZKdTbMiURgXsfOeWyJvzXbhDGetFrLWCxBARDTIxVaJMvpUEU
         HkiMANwrG349rJR901sa6QL9HkwVY+sCG5e9eNpQ+y84GFuYs9Yijz5pCHCvnJEs49E+
         tJLN5KPsIuO5v9spp85X6stB1UY6wFAOr7e42hGzfG3FcNNd0uSTSem8/qsBE60phukZ
         czgXi7b7Ax9EJY342WTmlq89h++sRLB47xgS7lQYjxnh/Wjtqlol76GWsOX3AngKNDce
         bFkZpM1oiau/Gqij45xjgMI2dIPPq29ODQmzSiW8eivqqRkDtD9SaOVfZNO4R6Y3nRKj
         MvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhOCknbtBfcoU1sHz7mRFAfXcIXonvB4P5w3bw0q/fD+dotzGOcigxRbuCzVOQdX3C8uJ4rVrw2mKIWpRk3mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FAC79SQofly5DRx3908Ym1Z91Bsty/ALYAOBposHE4yDByED
	/+iEKgUtcx3DciFFVhGzluToijZYP7DplASOazvbwAujXYYy2u3Q8Bz+Si+VG+iRQFrJJ3LRQUa
	icpq184cXkJD/n77V/CNqHP1bpRChs26bDRb3lPjIsHqsonTKp1ZtWnU=
X-Google-Smtp-Source: AGHT+IEO2Qwpklw46E2RisBwxaxLX8+3w0q8X9eKHEyPRAgvIikBRH3uKvOG5LLFIj1iilDHGoD+rSpNy/ocYOzO5GmW0WSgo6aX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3a79ad1078dmr46608975ab.10.1732295244532; Fri, 22 Nov 2024
 09:07:24 -0800 (PST)
Date: Fri, 22 Nov 2024 09:07:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740ba4c.050a0220.3c9d61.0194.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_disconn_ind
From: syzbot <syzbot+ee903ccb508953ef5998@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f006e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=ee903ccb508953ef5998
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccf5d85f3d45/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad2e5fc1309d/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aa637b02b96/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee903ccb508953ef5998@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_disconn_ind+0x79/0xc0 net/bluetooth/l2cap_core.c:7289
Read of size 1 at addr ffff88804b259ab0 by task kworker/u9:3/5854

CPU: 1 UID: 0 PID: 5854 Comm: kworker/u9:3 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci2 hci_conn_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2cap_disconn_ind+0x79/0xc0 net/bluetooth/l2cap_core.c:7289
 hci_proto_disconn_ind include/net/bluetooth/hci_core.h:2011 [inline]
 hci_conn_timeout+0xd9/0x290 net/bluetooth/hci_conn.c:579
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9901:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_chan_connect+0x623/0xeb0 net/bluetooth/l2cap_core.c:7051
 bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
 lowpan_control_write+0x568/0x850 net/bluetooth/6lowpan.c:1129
 full_proxy_write+0x111/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x2a3/0xd30 fs/read_write.c:677
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9032:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2050 [inline]
 hci_conn_hash_flush+0xff/0x240 net/bluetooth/hci_conn.c:2698
 hci_dev_close_sync+0xa42/0x11c0 net/bluetooth/hci_sync.c:5212
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88804b259800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 688 bytes inside of
 freed 1024-byte region [ffff88804b259800, ffff88804b259c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4b258
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 ffffea000089c000 dead000000000003
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 ffffea000089c000 dead000000000003
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00012c9601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xf2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_MEMALLOC), pid 7745, tgid 7745 (kworker/u8:13), ts 138751649852, free_ts 138600893157
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4283
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 __netdev_alloc_skb+0x103/0xa00 net/core/skbuff.c:742
 __netdev_alloc_skb_ip_align include/linux/skbuff.h:3422 [inline]
 netdev_alloc_skb_ip_align include/linux/skbuff.h:3432 [inline]
 batadv_iv_ogm_aggregate_new net/batman-adv/bat_iv_ogm.c:558 [inline]
 batadv_iv_ogm_queue_add+0x6bc/0xc10 net/batman-adv/bat_iv_ogm.c:670
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:849 [inline]
 batadv_iv_ogm_schedule+0xc53/0x10a0 net/batman-adv/bat_iv_ogm.c:868
 batadv_iv_send_outstanding_bat_ogm_packet+0x6fe/0x810 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
page last free pid 9133 tgid 9133 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1392
 do_sys_open fs/open.c:1413 [inline]
 __do_sys_openat fs/open.c:1429 [inline]
 __se_sys_openat fs/open.c:1424 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804b259980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804b259a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804b259a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88804b259b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804b259b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
