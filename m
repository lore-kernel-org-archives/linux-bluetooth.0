Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17492C6A3
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972524; cv=none; b=cQWAEHKFGJYHtcoZjuhVdO0zFKFFvELyZlWajvOmuHPpQcTOIeM98v3O3frgo0Esyfv403BTKpqnwQ5d0Gp8aSBFPV4FRvCAfjdWoM9Ie9olu7agGdSwhGSmPyFHbKqFvxirWxpTtrjnPH5AtGk7sq/8lrmNdcW+S4XVunDvEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972524; c=relaxed/simple;
	bh=7x369vTCTaMsu0hdakW+N+LKgl1LXQ1/SFxAzzHAVvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmv/CLx8MCdrCaRHOEjMVawH3Z3ttzfoSA5anBxzBqebEfGxHHI7JsHlKh3WWTx3YYKll+W6TilVxRfk/MF6sq3WdET2rwiUgipbQetCsUfirMQDX5U5y5yFcGE+aKk1C+BU3uQESHlZCLnEbSjIzMQx8IOCqGh/TP0rrtK8XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso14180285ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 09:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972522; x=1728577322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/etNbvzPqgReKkh2C9SZiflIN/a9y79xRWO4b751IwE=;
        b=a2uyudBs0Cdwcks3bqWKvBaLIeyU7SCPH9yTAD85lYcK5BZwBfQZXYVFgqTfyE4tQf
         BSBEUMkHbQvw5MF+6SlriMMDGwDXL0AoPFMG13s2mvyIO3ydqbjZ2xnx+k/lJvc2AfkX
         WmslTy/Lmb8b9ZXy6mO9e+BH8pdr06wXWyZG5dhjUkPguAr6hWz2VNWfuh2+vGE+oyz1
         zsOGA9jRZj91a2kSubqJQNoAEFx8e8JMQM1ztwa10rRh2/BAMJQK120N13U8izdOe1Vn
         VFGBWVEleYT/XyzuaZCCsDJ+4uhFO42ys6SAMqwQS4wp1F7bawF7t5/cKsxMTsN19RDW
         kZUA==
X-Forwarded-Encrypted: i=1; AJvYcCVT7pk8s5BqyVDvPjn4R8TxvdpHu7Ah9GVwFmZXTxUtPZ2ahAj7WHNP62VE/kxZ557rzijLiV34BGWjjKsGaNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ67TZDCJDjF1rRZ85kJ+fEGoCQTMsnBXf4h0/wrzOUMskdRHT
	+6jFUrKES4cg5+7RrrnAFPPCkSwfdlYyARw3aruY/J80VsiyzoaPTShCneOn7oG5oGbbBRp/dtE
	mDzLkOKb6PGUjqM03DPTfsmsHjkio1vMTTEymMDk6Bbc2GIOzH9ItIPs=
X-Google-Smtp-Source: AGHT+IHmjvNyNbg2hixEkgsvpribDMIcrk+QnM8lf9S31dpUGGYetz23T6bV8psOIE7lJkNEAhahry1RV6iGQ19Adjr9LREVD0lh
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3a0:9b56:a69 with SMTP id
 e9e14a558f8ab-3a36591c6b2mr76413705ab.7.1727972522064; Thu, 03 Oct 2024
 09:22:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:22:02 -0700
In-Reply-To: <Zv67JUPfzgQp7Kgf@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in set_powered_sync

==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
Read of size 8 at addr ffff888025cf9198 by task kworker/u9:0/55

CPU: 0 UID: 0 PID: 55 Comm: kworker/u9:0 Not tainted 6.11.0-syzkaller-11519-gc30a3f54e661-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
 hci_cmd_sync_work+0x21b/0x3c0 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6099:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4296
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
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

Freed by task 6096:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1228
 sock_ioctl+0x626/0x8e0 net/socket.c:1347
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025cf9180
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888025cf9180, ffff888025cf91e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25cf9
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000a092c0 dead000000000003
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 53, tgid 53 (kworker/u8:3), ts 7343210726, free_ts 7330995796
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
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 blk_alloc_queue_stats+0x4c/0x100 block/blk-stat.c:210
 blk_alloc_queue+0xc1/0x580 block/blk-core.c:403
 blk_mq_alloc_queue+0x19e/0x2f0 block/blk-mq.c:4154
 scsi_alloc_sdev+0x772/0xb90 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x1db/0x4be0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x205/0x1080 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_host_selected+0x37e/0x690 drivers/scsi/scsi_scan.c:1874
page last free pid 938 tgid 938 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888025cf9080: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888025cf9100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888025cf9180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888025cf9200: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff888025cf9280: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================


Tested on:

commit:         c30a3f54 net: mana: Add get_link and get_link_ksetting..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171c6307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ce7580580000

