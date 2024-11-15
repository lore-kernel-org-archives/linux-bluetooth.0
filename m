Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1318FC65
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715031; cv=none; b=LV92DIxBQZheWdx8P2jtbPVWlV2wFal1ISd+OpBa81YDXWJ+i9SzUqtl8jNMaoQDkeYfQKdZBhhBFjkBrzfpGUj5PkcnOnYXvsTwhclYmIgH61x3p686sXIUg1QMWJtvL/k+TLe182ZcFBHdbd3hjec74xMcEBDDPLkMeGMhuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715031; c=relaxed/simple;
	bh=cev9eGU6pQQ49voVs8/iGLVfm1uGS+A5pjLqn/nPjWQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hQglyQJttc9AReW257Erjp17CViEXIBrAVBQBezfxN7SGdHGuCml/iWToZKtcGC6HEwWmby82eyKURsEIIEvEFDkNhPGPC0tqWaZK09cBac9YQgLvE+lbD4xxUJ4IBiiyXIYH5AEw8BWwDteJ/FaeR6afvzaeMl6HuwchOfgNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a5b2ec15a9so2140835ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 15:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715029; x=1732319829;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgG6u7pvy1Et4omn8CiHbA2Ery2cLQ5f3jm4XvkWjdI=;
        b=bEdWw2Q1YHmUOKEEgVE4Vam0ywM9WNBCba4UIfIdbyaYsDhTeh2k3Ny3WFDWv1OiqB
         QcjyTFauZi1AV8RUEsJ/4smVzii9tUcoK6E0S4oZha+LkrJMMUCxV3xbBLMyzYpLZjTi
         MhX3bZBF0LmSwQ4E9O8nQ8zKyPYUA7R0Itj9cZbbacjNNLV4sws169uiIHeJCxjNWnxR
         cs00j/uGNvnh2s8NF88BiDPGzjxnXrivE459APfxxgnml4rcNbFSkUOhjvw5wqutQuTi
         HCHqH3QAtUu4GDKgNZK36zmgecxsspeJoOqQgehW+s60UQtZxW7f1jrVsERnlOtV474s
         swhA==
X-Gm-Message-State: AOJu0YwIprzzE+GAbQ3cby8bPde0xnAmcjPhvci7EpDgRGgZWC9ZX48M
	4JAQ64wyNr7lNOn6poEhUDKAZyKVXfrzh5sVYgITZ9Q/jLOSQJQId5HLJNpeWq7UJO6tq+s+mkQ
	QVuNcwWc+1Ze0n6cT4e3x+A40NUB3cJC+lPxrEYMDbqYzE+fnd5mVv+s=
X-Google-Smtp-Source: AGHT+IE5n37TIKpfel2iIw6/b0C53waNLwGCb9UySI2UZAa1Ml3yq8Vq+HIWW0rls/pNfVniecWSae1OjN2MyeuHciFsuZC2Wcff
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a74800f3efmr56967895ab.3.1731715029409; Fri, 15 Nov 2024
 15:57:09 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:09 -0800
In-Reply-To: <CABBYNZJU6ctSeqC5f+EPqo6UJoVKwtjc_EWZa=-CEJNAi28Upw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737dfd5.050a0220.57553.0043.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in set_powered_sync

==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1354
Read of size 8 at addr ffff888026efb218 by task kworker/u9:2/5313

CPU: 1 UID: 0 PID: 5313 Comm: kworker/u9:2 Not tainted 6.12.0-rc7-syzkaller-01628-g025b2bbc5ab1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1354
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6078:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1395
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6075:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 settings_rsp+0x309/0x3e0 net/bluetooth/mgmt.c:1448
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x106/0x430 net/bluetooth/mgmt.c:9524
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1227
 sock_ioctl+0x626/0x8e0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888026efb200
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888026efb200, ffff888026efb260)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26efb
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea00009a43c0 dead000000000004
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 52, tgid 52 (kworker/u8:3), ts 7241169289, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 blk_alloc_queue_stats+0x4c/0x100 block/blk-stat.c:210
 blk_alloc_queue+0xc1/0x580 block/blk-core.c:403
 blk_mq_alloc_queue+0x19e/0x2f0 block/blk-mq.c:4154
 scsi_alloc_sdev+0x772/0xb90 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x1db/0x4be0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x205/0x1080 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_host_selected+0x37e/0x690 drivers/scsi/scsi_scan.c:1874
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888026efb100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888026efb180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888026efb200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888026efb280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888026efb300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         025b2bbc net: phy: microchip_t1: Clause-45 PHY loopbac..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16dc71a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10976b5f980000

