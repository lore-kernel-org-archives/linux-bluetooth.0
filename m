Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBE45945
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515825; cv=none; b=iVFVN2ZD/HpgHf4kgQ5dCsSQ+AMicceSpyegZ/Bq7oe07RJj+W2m3iD1gUHVqlQuLoBy71WLrLK3YEy+v2Q4HLcybYcMxfC4p5jvynwytzC/GIsvwJsxbWyJcknl29RDirOkfNox2pVat7hDDa134aK+xdNQ0Kl/lZXqE7LUPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515825; c=relaxed/simple;
	bh=XBvnJvP2D/qIAb5q+anWob26WCtElDdbHaUxAs9sz3c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OtDdNWQZqmUfY3cyQL2XNYGKE+HoVu/eqbfatPC2LggXU2fxKhbxKti9bszHt+KG6ESjQjR96RpRD7Jw4rJRIvwejm0GxpHcVtgj/01Ul/cqtB8Dw1fUFmOmMfq762QEYqAAEACW/pDLqtb5TwB9gIHrTkxfb+30ee3vfZVEy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso43981835ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 19:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515823; x=1738120623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1ujlKDVEz/3pMCXCXN1UQyyUoIUGYGvU0x5qYzN+4Y=;
        b=i8FysVlSm6Omvm8lKdmKzTt79+akmsI0U7lO8pp58cc1B4rbpU+NYnpti21XYoAfS3
         0JYAQFcbFqS0/zYDWCPz1gCSocfsl3VUxnG5uEkLmXVEDUkyZDb1pu13FbdN6scWnnOU
         aBvzR2MyzsLTMrbsDhNSVrJV1l1ck+cgiVNOG2mNB9VIv+E1cypss3A40RGf0GIW6zLM
         7ptQL1kdZl40FQ6ryTwZLqANexRQxh6iFdOBPrDiTKRSihGLjFWeV8cNFy5w8ulrCDkx
         ep1SEF1e4W/2jQ+qGRFaUyzoxfwvXn5Q5A1BX5y/wxmRkdvDh3PGIkTwN2qJODDyv1qt
         MSOw==
X-Gm-Message-State: AOJu0YycI71fATB9FXNciGJB71obeHF/UlZAwsswADUli+MyU6pp0UoS
	XQEGkVWa0f0FapkykgIR9r0xwpbMWbIilli6bL68k/MYIRc1qTRX6C739uJEr4TBQtpKnYP8lIM
	pddVrGIYLSt4jF4xkRQMNWQYj5So5XifWqkZBu649kF/IzIvux2q2wjs=
X-Google-Smtp-Source: AGHT+IFdKO8b+ro28hZDwcauUbJpYQGjFB4bEcm6iR/xTYnAIimoycFR2peUCxAvCQB4irGaGAogxVHszktCzwKGSyKJeNPUwdOE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4810:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3cfb3ab58famr6652755ab.13.1737515823089; Tue, 21 Jan 2025
 19:17:03 -0800 (PST)
Date: Tue, 21 Jan 2025 19:17:03 -0800
In-Reply-To: <CABBYNZKX0GKVwEEmf6XhnL-RJKqzLvt0izVC152Lzc8MjWWo7A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6790632f.050a0220.15cac.0165.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_send_acl

Bluetooth: Unknown BR/EDR signaling command 0x10
Bluetooth: Wrong link type (-22)
==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0x4d/0xd00 net/bluetooth/hci_core.c:3232
Read of size 8 at addr ffff88802f536f18 by task kworker/u9:5/6557

CPU: 0 UID: 0 PID: 6557 Comm: kworker/u9:5 Not tainted 6.13.0-syzkaller-02469-gd0f93ac2c384-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: hci4 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 hci_send_acl+0x4d/0xd00 net/bluetooth/hci_core.c:3232
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5500 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5536 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6815
 l2cap_recv_acldata+0x700/0x1a70 net/bluetooth/l2cap_core.c:7522
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 hci_chan_create+0xc8/0x310 net/bluetooth/hci_conn.c:2838
 l2cap_conn_add+0x69/0x8e0 net/bluetooth/l2cap_core.c:6854
 l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7237
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6554:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 hci_chan_list_flush net/bluetooth/hci_conn.c:2878 [inline]
 hci_conn_cleanup net/bluetooth/hci_conn.c:149 [inline]
 hci_conn_del+0x4b5/0xc40 net/bluetooth/hci_conn.c:1164
 hci_conn_failed+0x319/0x400 net/bluetooth/hci_conn.c:1267
 hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5604
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802f536f00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff88802f536f00, ffff88802f536f80)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802f536d00 pfn:0x2f536
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801ac41a00 ffffea000187a110 ffffea0001882ad0
raw: ffff88802f536d00 0000000000100005 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6482, tgid 6482 (udevd), ts 109120173001, free_ts 109113912385
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 kernfs_get_open_node fs/kernfs/file.c:525 [inline]
 kernfs_fop_open+0x826/0xd10 fs/kernfs/file.c:700
 do_dentry_open+0xbe1/0x1b70 fs/open.c:938
 vfs_open+0x3e/0x330 fs/open.c:1068
 do_open fs/namei.c:3828 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1395
 do_sys_open fs/open.c:1410 [inline]
 __do_sys_openat fs/open.c:1426 [inline]
 __se_sys_openat fs/open.c:1421 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1421
page last free pid 6511 tgid 6511 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xe39/0x18b0 mm/page_alloc.c:2706
 folios_put_refs+0x76c/0x860 mm/swap.c:962
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x4d5/0xca0 mm/mmap.c:1685
 __mmput+0x115/0x3c0 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9ad/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3036
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802f536e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff88802f536e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802f536f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802f536f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802f537000: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         d0f93ac2 Merge tag 'docs-6.14' of git://git.lwn.net/li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112b8ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11ecbacf9de73733
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e82238580000

