Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155E199EB2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950766; cv=none; b=PwlTORt6ZkT9pjvkHveQ0zfd49c2Jce/oIvLnclMf4dyFA/XkINRXAo8V6LkbioVOA0LmPaOTAK3Zn6mc6cT2X0aplm6i9LZjeNb8rYCyfAXQoJbxrE87S4sWAh3XXQ97ikOHH6IEOx9tQ0TkaUvT6Se+PN5j8IvkRHuBFfQpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950766; c=relaxed/simple;
	bh=lyWqLBBReYhxA5zuT4mRVoVncJsM5iVPnkDnxe8obhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BEyBsY3Pq7PhhVsLOyVOKnVSFO5rPl/lEY1UeoJ6ISty2PL/lZWeU6N55XJPzLhP1gAlWooWFGA69//GOSdoDpy7w378ynL46TESyZBOn4gFywmZC/AH6OipEtVLpHFw+LXLqy44dRb1o+jlTQWu/dQBtGngyzGwZ7KaBSMKBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso24095465ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950763; x=1732555563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DoJ/HF1D8S3CzoPu5IJj2gmUmIpGzKo3JDfUM5HOOQ=;
        b=YOp+sqCJI2L8kQ4ulS04VMLaC2RVa9R96BvR6z4YgcLkwS25d+ntCvudsm65Petx2H
         by+ZipSS55iYAhr/OkOXeyCpq8n5WwaYCbQ5pHZ0jEr3Hs69lSbkpcwdGFkY4DCIP+30
         ThUE1VjMAmzhGwJy+fk1bYEeiE99LqrJuWEBFe/GPQCKT2uuU1o3knt8/LdKl8gFP6aA
         oi2Qywu2yRkSXD+xtjnL5nRzszGrUHHXQvX/lyIMMiVtIsYXJvLFIx72yBR4CBTLcBVe
         zgfkhAGno6vwAX6XXT7d8ctyIdk6ywBdX+Qy5m9nBxBYpiKq7LGdLoA34IH2xgdyl5Fg
         qpOw==
X-Gm-Message-State: AOJu0Yzu5cernRfQvtucU4Uwrfw4yIja4hVPeb7xUwVlFOxAl4MkrdAM
	arx59hjov5cCuEFx/QqPvysE9jJdm37A2iWO8yio6+3pK4EqLO9A8h/Qowc6gqrskbYdy0DPHMw
	ocF+jqkmL+KoSvo7ZK/eO13vWzdEjpt2PfL6XlrGP1SUGBulH2oU2NH4=
X-Google-Smtp-Source: AGHT+IGn6Ql/rSf/wppVWYqH5r82dtbFl+kcqXuLuGv417jh1dRzxt0PTJ0wmkhRIoHhKzvS9sH3Mz7P1FGo/jgDtth0X/dHmxzd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:b0:3a7:635e:d36f with SMTP id
 e9e14a558f8ab-3a7635ed416mr50270875ab.2.1731950763490; Mon, 18 Nov 2024
 09:26:03 -0800 (PST)
Date: Mon, 18 Nov 2024 09:26:03 -0800
In-Reply-To: <CABBYNZKUmL=xekhLMfF9vza3agxtAX5qh1NTJVuRD9R9hwHmQg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b78ab.050a0220.87769.0050.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in settings_rsp

==================================================================
BUG: KASAN: slab-use-after-free in settings_rsp+0xd0/0x3c0 net/bluetooth/mgmt.c:1446
Read of size 8 at addr ffff888026bff128 by task syz.0.615/7359

CPU: 0 UID: 0 PID: 7359 Comm: syz.0.615 Not tainted 6.12.0-rc7-syzkaller-01702-gd7ef9eeef072-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 settings_rsp+0xd0/0x3c0 net/bluetooth/mgmt.c:1446
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x106/0x430 net/bluetooth/mgmt.c:9531
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
RIP: 0033:0x7fa2e757cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2e8325038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa2e7736058 RCX: 00007fa2e757cef9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000008
RBP: 00007fa2e75ef046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa2e7736058 R15: 00007ffd79fe2218
 </TASK>

Allocated by task 7360:
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
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1401
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

Freed by task 7359:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 mgmt_set_powered_complete+0x4c5/0x6c0 net/bluetooth/mgmt.c:1348
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
 settings_rsp+0xa8/0x3c0 net/bluetooth/mgmt.c:1444
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x106/0x430 net/bluetooth/mgmt.c:9531
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

The buggy address belongs to the object at ffff888026bff100
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 40 bytes inside of
 freed 96-byte region [ffff888026bff100, ffff888026bff160)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26bff
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0001ea6140 dead000000000003
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 8941535213, free_ts 7525892719
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
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 usb_hub_create_port_device+0xc8/0xc10 drivers/usb/core/port.c:743
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x2503/0x3640 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888026bff000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888026bff080: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888026bff100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                  ^
 ffff888026bff180: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888026bff200: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         d7ef9eee Merge branch 'am65-cpsw-rx-dscp-prio-map'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=102db378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ce72e8580000

