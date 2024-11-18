Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFF1B393F
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947464; cv=none; b=GtTvpQOS91cT+mVykwF/YGCkA8e58MD+/0sgPx+L6kMQ0z0ZdjVferzVwzWm3mD8wCDWa50Ye/h7M4Jq8iuH7pk/sFyzO4LXSZ9Ao73ijcuTAu+LutM0qEDGR5d0RgQw0Iq/+GcPRkeF0CDnXmbdayeiuQhxaw6BbcknfWMVG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947464; c=relaxed/simple;
	bh=tZmjDrURNdTH2bTrW/BrM3TEfahOpQOa/TxG12F4zsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N5AmGOEGKdtR/av+vySbgeOxHQMKS9xVirgGKD28mzBcQ7afJXLQIh28siKVyCCOI2lCgrrasL/bGkvsW/GLF9S4pW004r36ez2XdVljp4XoKosKpjVVCk12fI3/XMNczYSZ12jJUQUCWOLBuVABBOG08WKJ+dRGsPdCufYsgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a763f42b35so10239235ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 08:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947461; x=1732552261;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIiyjQEEjsraY4e0dqyGtIPz95gfNSw28i4CoUtfMkc=;
        b=WvE0bs3QoJ0DzE1GyySQnOZMABeVdHlBVy/uomfVbI2jIGixgldlGKWUKjB6W1Up7f
         4rvAUzex1ZMUsAg2C+D6gnuMFJuX2DEqH6E4ZG01FH4BmlNWlgVk2OGw9YDsZ5PH2QrL
         nb1v9EL8MR2SlgVfWGMMC7qcnrCGLTR1Yx1VrkaB50GBfGS6+juPp1DYNEFQ0I3J0bBv
         92W22k+bMoDh0qiFDj1l9HRgK4A/Qw3+MaAGIga/MFZsBXLxucfqSiqZXoQS3xELUHCM
         9iK8u7jq8Httfiu1TyeDFhDTfhppEwvtOqZTG5qGGlEm3VB2CoMeYcyp9zmtmFoatdzU
         t4WQ==
X-Gm-Message-State: AOJu0Yx4vVlSkC/hrorndDbmKT98GG7Z/A4m/+ncpJm1Tgyr9k7XTwCI
	NoVxKpl0PMsH2jMt7woYTRGEDLvf5PVEakaj5eixyXAKZlcaktDkkzqKMtMuMl+Sg+77NhgW6x5
	c4bwwgbf11pLp51xn/v5zIfDIxPCt0EnRAS8OflKog1vP02QJ/I+tOvY=
X-Google-Smtp-Source: AGHT+IECdyD6ZOBKHTjaN/Yfyh3CAFMwGi1tOK15j0a40HgE+uiw32RhG99wtP1hLRi8Z1AS66NHA5TYEgCTvkNmsc+SLeU1KLC4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3a7:afb:7b36 with SMTP id
 e9e14a558f8ab-3a748092cc8mr110023455ab.22.1731947461610; Mon, 18 Nov 2024
 08:31:01 -0800 (PST)
Date: Mon, 18 Nov 2024 08:31:01 -0800
In-Reply-To: <CABBYNZ+jcHzVhzLXeU9GYJuFO-PgT=vfYq1+RrGkgyRA9AeU1A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b6bc5.050a0220.87769.004b.GAE@google.com>
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
Read of size 8 at addr ffff888022f18818 by task kworker/u9:0/54

CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.12.0-rc7-syzkaller-01702-gd7ef9eeef072 #0
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

Allocated by task 5993:
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

Freed by task 5989:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1444
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x106/0x430 net/bluetooth/mgmt.c:9520
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

The buggy address belongs to the object at ffff888022f18800
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888022f18800, ffff888022f18860)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22f18
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea00009d9840 dead000000000003
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 58, tgid 58 (kworker/1:2), ts 69902458132, free_ts 69192164737
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
 dst_cow_metrics_generic+0x56/0x1c0 net/core/dst.c:185
 dst_metrics_write_ptr include/net/dst.h:133 [inline]
 dst_metric_set include/net/dst.h:194 [inline]
 icmp6_dst_alloc+0x270/0x420 net/ipv6/route.c:3288
 mld_sendpack+0x6a3/0xdb0 net/ipv6/mcast.c:1808
 mld_dad_work+0x44/0x500 net/ipv6/mcast.c:2260
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
page last free pid 25 tgid 25 stack trace:
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
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4186
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
 sock_alloc_send_skb include/net/sock.h:1797 [inline]
 mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
 mld_dad_work+0x44/0x500 net/ipv6/mcast.c:2260
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310

Memory state around the buggy address:
 ffff888022f18700: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff888022f18780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888022f18800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888022f18880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888022f18900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         d7ef9eee Merge branch 'am65-cpsw-rx-dscp-prio-map'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=117bbb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
