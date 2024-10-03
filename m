Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E954437A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975585; cv=none; b=ADk8Rs/BnJrag/TIPZCCOKsyOwdyzVlcvDC/F7dFIH9ztgkkZ/QIUjbRiAF9QgfNPA0bh+Z8+wkUm8OdvNuwsYZZmOEFzBFqNdtZvNlSLGyYJwmn/CMXEcCItlDZCPxaGcX7dM+K1QEHCtS0Xs0ZHpM2A1RaIXBa6DImwWYCWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975585; c=relaxed/simple;
	bh=jQDemFxxGygJyrc1AAYi9i2UwArYWursZSFiAX0uzGM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p7oo696DCQBCiuZsA0zdxHCsOnR70or0h4FJrv1idrJMZHfrJbM30eMbISHhEkC26X8V0xLGWyQVnwYT3AlqEW2ElirW0j7zMn9WhlyJEdvnOhnaFkcW5y7VZBTIBzZoFt+lRk5bQA9HsvBCMKX3YKABmZKqJ+1SJnatDMQnkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so12722965ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 10:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975583; x=1728580383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXuR1lwHneeCLiarHzgMyodxOrzw2gGu15DFYrzEOMA=;
        b=RE4I8OW9pdVFlMnYdy2zUHog2Pm1Pk2zqO417virqYRbR0ta+dofwfLKasv3F4+NDX
         Va2LsSb9hVYtYykwR3ecFEi3JpKG0Ow0YhBQPH1Scn/1pAXBn+mZGy1qV4ypDUBpOPy/
         Xt3+5V/cpO8ljeVj5BcNdB3Apc4OF/Ta5aqgHaARgixfVwJTE0hjrjdKzAnVe4UUTYzM
         9GybdeXoVIy2DezdCAjxgDPLi5UV0RC8LOkIVsATQfwP4WzAja7fEb6NmaJwVfe555cm
         5M1lK/59Gmu7qatmCyjGS6m3b6gnYEJ67NOpSk+zrxN/qA9BF3yc4yazoBexuwklK42T
         H6ew==
X-Forwarded-Encrypted: i=1; AJvYcCUuniCfuYGDRmsnqlgiki9W23gYcgnZ8ly/50Ujk2pM1MyAx/yHNhVdIUIkNOM3jTUzX2upLcLcuPJnjzmjQoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aJGKGraSi6DKBHZyp5SB3PYmEylC0kCnwdhXj89L5jTjr1yP
	vl9Vq6PGyPQyNevTuqJFaNzwmNtffKYanukgUMqimiNQ1PUtqK91XoIFZwaQEKjSGz9PBiFrXzV
	McjfaM+fyycbiuP0mlefCbwPYVyOrqcC5zK9lV1Ino4MZwF+Hu8XTrxY=
X-Google-Smtp-Source: AGHT+IGWiLNQfjoAd9gfpalj/NB6qwHTPWhGnhu/Dv8waa9kc7glvyUJl4VTLgHzX5Gt/ZPt4dZLxSB8+8U8S0LHjGn+IfCoMPFv
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:8744:0:b0:3a0:aac2:a0a4 with SMTP id
 e9e14a558f8ab-3a36591c41cmr47978945ab.9.1727975582966; Thu, 03 Oct 2024
 10:13:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 10:13:02 -0700
In-Reply-To: <Zv7KOuMKKHrLTvfw@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fed09e.050a0220.9ec68.004f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in set_powered_sync

Bluetooth: hci0: command tx timeout
==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
Read of size 8 at addr ffff88802d879298 by task kworker/u9:1/4622

CPU: 0 UID: 0 PID: 4622 Comm: kworker/u9:1 Not tainted 6.11.0-syzkaller-11519-gc30a3f54e661-dirty #0
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
 hci_cmd_sync_work+0x220/0x3f0 net/bluetooth/hci_sync.c:329
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6093:
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

Freed by task 6087:
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
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5193
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

The buggy address belongs to the object at ffff88802d879280
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff88802d879280, ffff88802d8792e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d879
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0000bf4c00 dead000000000004
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4690, tgid 4690 (udevd), ts 19144464989, free_ts 19132945155
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
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0x130/0x330 security/security.c:2371
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_fstat fs/stat.c:229 [inline]
 vfs_fstatat+0xe4/0x190 fs/stat.c:338
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
page last free pid 4686 tgid 4686 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 kernfs_fop_open+0x3e0/0xd10 fs/kernfs/file.c:623
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff88802d879180: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88802d879200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88802d879280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff88802d879300: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88802d879380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         c30a3f54 net: mana: Add get_link and get_link_ksetting..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=146a6307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cecb9f980000

