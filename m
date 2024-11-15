Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242C16631C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713526; cv=none; b=kaf1BDtPpzwYK+O0yr/kinmQp6LeP4EzxDga8px1t/Vwnx38KvZNP9d2Xp0xkgOY6UIHqV1j9HI7yl2CoiidifytqHakiXjJ1NPwTu8Np+PpFC5o77D+CJTnXJhLRP0qXV+Hs7+3GTS2+TASqRAVfaG3Yv3gIp5fQ7GsHixUo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713526; c=relaxed/simple;
	bh=QaY1+eOShqdZYsJt1gBTHrSsu/twfRY16Xo6KXA70hA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jg0iTL2V9voQK/pr7YStCkBdH7s0IScZS2E1rD58DtSoAhnhhyHBEavP/zgLbZy1XkIbPWKsjYrQ2kzc67FTNkTjdJmygKuY7rZHJ1qakxhFSwzOFkx0ppavP5fnKj8j2NPHfr8d5wR93VurBZFM8SzQPNjuBaqqXqatAMKiwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83acb657f91so145070939f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 15:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731713523; x=1732318323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvnrS+/ZIKsu3TcsmUpnsL4BnZ/QK1VFYhp71xUYT7w=;
        b=qw6IFDkx/wPx2zuh/e/nr/siFH0Teo58YeDyH+JU+9DoyZa6yCfDiwu2y19TK1WLjN
         yW5w/SkdGF4EPqDWvrqgbBYPdLu31vzVi4gOTmwAUQ8wCucfOIdiUBcQmwqvZbdy7c6Q
         /wst2l7eH4H8DeIIFPsdjK+gKzqUq+ZbwYt4NS1AF6WOwh0Neg8BVms7BZ3u8jKIcFYI
         syVSsi98A5XerloD2S0UOGMVqhI9EZ2Mvx/4JRMa2TtT6IAxaHGHu9vFsdHIiFqG5asz
         jJfRo86LPVSnP+0K3pnO/Pv4jOwOj3LQJw8x0pfISbE0nK5aOsVEvMP2cDq94sWETllu
         4n6A==
X-Gm-Message-State: AOJu0YwcERaqUNbakdhdGDRfIMMsb9aNBQKNFnWBQMliA498OIsHF82g
	M17TWGLq2bbnze47p9WRtSX5SIlU16xK4yxxvcTQrQsqHPDqqFw2Pg4NqN3cFGZM0nZz7Jt29Q2
	hSGowaTzAUKu2IdCk/IqdjeW/NtHa6dag/zFjPaJWW2FBW4zPcaIduFU=
X-Google-Smtp-Source: AGHT+IFa8xBYjj6+ddkwtVrbrdCXfH9nmyILlda4MQJuVlOsh/+LQIbRBqn8outzyVyj4K8dJoq5+/GgvjuSN5qOfZEhyWdljXNg
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a748084dcdmr51746305ab.23.1731713523674; Fri, 15 Nov 2024
 15:32:03 -0800 (PST)
Date: Fri, 15 Nov 2024 15:32:03 -0800
In-Reply-To: <CABBYNZLatZOTP3B68PPdm0E7y-t4qAzCDmaB8vxKZu-o3ncmgQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737d9f3.050a0220.57553.0042.GAE@google.com>
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
Read of size 8 at addr ffff8880791bd518 by task kworker/u9:0/54

CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.12.0-rc7-syzkaller-01627-g6bbdb903db08 #0
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

Allocated by task 6105:
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

Freed by task 6099:
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

The buggy address belongs to the object at ffff8880791bd500
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff8880791bd500, ffff8880791bd560)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x791bd
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41280 ffffea0001eb13c0 dead000000000003
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5386, tgid 5386 (kworker/0:5), ts 68941935893, free_ts 68939759623
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
 mld_send_cr net/ipv6/mcast.c:2120 [inline]
 mld_ifc_work+0x7d9/0xd90 net/ipv6/mcast.c:2651
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
page last free pid 5386 tgid 5386 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 ipv6_get_lladdr+0x295/0x3d0 net/ipv6/addrconf.c:1936
 mld_newpack+0x337/0xaf0 net/ipv6/mcast.c:1755
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_cr net/ipv6/mcast.c:2114 [inline]
 mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880791bd400: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880791bd480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880791bd500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff8880791bd580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880791bd600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         6bbdb903 dt-bindings: net: dsa: microchip,ksz: Drop un..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178b3cc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
