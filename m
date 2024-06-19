Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8E135A6D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796206; cv=none; b=MNRWxveIFGo1VPQlE5usbDxNI0LjpPoIQQq9pKg6/fVxWLeSUsThC8XXwCOgkW6jwnKxzKoHZUacPeITDi2tceYKESKyQvamXgAtSm58sUFlCeFET7dGQGzhCYRJkxNVoWetIwnXY9Jwqtu5+WVXNl6f4JJSB95SiB20NGEvw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796206; c=relaxed/simple;
	bh=NoxsAJFZgAA7YyUpfT9FrwfryJ9In0syuuErb0Xxuyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K8E61GJUNQJ8KM5Dxofoz1ixDtPWIsa4FLOhDIDDFCbOcw1ezYI1h+j0Qz4Njqw7qS85Dh7gRivO7w+AmwdUEa5lPR89HgmIljKAsgikcyAwTg4S/OxgiDjAQDYUzD+V+OxmveKE7GcDYMApm7TRh9ne8YlqnQWlMNud76x6xOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7eb846f49adso800890239f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 04:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796204; x=1719401004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbEA/BB59SSn3pEUYX6Qz+Ptd80c7I43WCP9OJ44Jtg=;
        b=tYwHFKsZLZn/J4OA+t689GdG0E2QeZeIcMeSTg+rYo7cz1pQtmpGtlQE415/EU2L/0
         ditpL5WZDlMjmLUB9PXwcpQAIj3Smg03RWTpfAF2rux9gBBmppzbg/8PxH7LtRSJr1U5
         gm6jowXQVZqs9e4nfsMOEOjlP9ROa/4aHeSJV7+QQLIPPO5i+owzXx1m1lxNK/J2kgbW
         XppeLsiu2/ay1WcMrp7LtXmRicCyglw9uypncX7oLVlsA7UiUeqyFpr/gFRSwuJVsPfp
         aBsEWZDhXfD3wHr8VO+AWOUdw6wG/CTdIZIXvfQYSD3XpnT9qazzocyGE7NsimBxG5nW
         s0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVYgPfgsVrCt30PR/blJOFNgXfjfL1/LIaRa5PsvBT4dkHvin2Ub84VxLhkp5vqxu/lgt6crkrp+lcW9r4lRxLtwb+oUUOKyF2Qk5tyGou
X-Gm-Message-State: AOJu0YxBQpvYb9qVjctLKme106fcanrtLX5HcLzl9IkbkCRlh3LQVSC8
	1DLRKdlNFjCdtdI/K7I5/KVajh7GX3aHc4wSKYtK5e7UQFjNl+/oeBd3vpCJsVKdt7f1WZxJ/nd
	oA/is8Lv67ZSkLW8RLWg08Kwv3lBIk+IVFcxWvOHPKVS1uBaDdGXqR1M=
X-Google-Smtp-Source: AGHT+IGP9XPnocK/A6V3/9jcrSvDOXSfKC/NMErxRiWKHrm+7vONEzlMLtTswHif4TBleu5MjrPaNQQsk19xwsAzH9OmVCA+MyIN
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40ac:b0:4b9:685d:7f2a with SMTP id
 8926c6da1cb9f-4b9abf98653mr65755173.4.1718796204347; Wed, 19 Jun 2024
 04:23:24 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:23:24 -0700
In-Reply-To: <000000000000a380400616a9cfa2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033a6e8061b3c6d4a@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d61bca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125874ea980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1131
Free of addr ffff888025dce280 by task kworker/u33:6/5317

CPU: 2 PID: 5317 Comm: kworker/u33:6 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x135/0x160 mm/kasan/common.c:232
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1131
 __kfree_skb net/core/skbuff.c:1188 [inline]
 kfree_skb_reason+0x138/0x210 net/core/skbuff.c:1223
 kfree_skb include/linux/skbuff.h:1257 [inline]
 hci_req_sync_complete+0x16c/0x270 net/bluetooth/hci_request.c:109
 hci_event_packet+0x963/0x1170 net/bluetooth/hci_event.c:7479
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4074
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5317:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4008
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2052
 hci_send_cmd_sync net/bluetooth/hci_core.c:4123 [inline]
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4143
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5306:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1131
 __kfree_skb net/core/skbuff.c:1188 [inline]
 kfree_skb_reason+0x138/0x210 net/core/skbuff.c:1223
 kfree_skb include/linux/skbuff.h:1257 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x634/0x960 net/bluetooth/hci_core.c:787
 hci_sock_ioctl+0x4f3/0x880 net/bluetooth/hci_sock.c:1150
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025dce280
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 0 bytes inside of
 240-byte region [ffff888025dce280, ffff888025dce370)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25dce
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888018ed8780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080190019 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888018ed8780 dead000000000122 0000000000000000
head: 0000000000000000 0000000080190019 00000001ffffefff 0000000000000000
head: 00fff00000000001 ffffea0000977381 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5306, tgid 5306 (syz-executor.3), ts 70131626595, free_ts 69503653671
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_node_noprof+0xed/0x310 mm/slub.c:4044
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:489 [inline]
 hci_prepare_cmd+0x32/0x2b0 net/bluetooth/hci_request.c:221
 hci_req_add_ev+0x11b/0x2b0 net/bluetooth/hci_request.c:255
 hci_scan_req+0x87/0x150 net/bluetooth/hci_core.c:73
 __hci_req_sync+0x142/0x980 net/bluetooth/hci_request.c:130
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x634/0x960 net/bluetooth/hci_core.c:787
 hci_sock_ioctl+0x4f3/0x880 net/bluetooth/hci_sock.c:1150
page last free pid 4688 tgid 4688 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 __put_partials+0x14c/0x170 mm/slub.c:2995
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4008
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9b/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x9a/0x150 fs/stat.c:303
 __do_sys_newfstatat+0xa6/0x130 fs/stat.c:468
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888025dce180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888025dce200: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff888025dce280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888025dce300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888025dce380: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
