Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44049315783
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118347; cv=none; b=NVQOPMZxlIwOilmujar6DhJHgaWVZubpmiF4U+sS6WOclGjvaI+/MusMWLNpHGqxXIn593/3DuVZl5IVRm4yhTArlvSsoH+ojh3h28TAQhoPQIIzsCzN8LPDkpPelBCtUbZj/D1FQ0C4KTWvGqRt9WXBgpBj3CrXL1cmJufislg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118347; c=relaxed/simple;
	bh=/l08/eBtnMMY1PDOKuWE6QYOR2lZwwdFH+pt6kh5Wtc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rFhRU9E8EJ3cVf8RzbkzvWseOWzEkF/gnr64SJxShcSQqFFV8Vj8VSb+jz1xhxkHboq1KMOCBOmwf9I+ozi2raDdC1+wOprmlL9KxPMk7OiTIZzu8b7kg3CENSzurONOmc4/PeDu15C+Vs2FViL3Vb5HLv5dU8yu1p6LL7aP8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d11b35e8acso2993507a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 13:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118334; x=1769723134;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUz4w2XSoiDJcbw0kN7Y2hnHB1eefdsFLJG5wdIfAvY=;
        b=J/UXqwZtAfAXMyrMNh+WV7TSA8Q+ZJQ1Oe3oqe9Vgnxokzu2EXpUhmXVABkQmey68Q
         NT2se2WVfZ9YTkYUHCInhR1I/XFYnUvpchPh3LqksHlQmwPXAWqW1rFu63J6sRhY6/hm
         ze1Ft/WIrJuQ67FBDHFrCyTOdCmkGRVqafjt1saO+0FzW+DPnjy7jBsETXxtia++T/n1
         PytfN4W5n7EHb8GG7lNaokqF5tT9kFTKKe7mdwVY4+/re0Fh58SBPJZMBm7PEiV5kvHW
         5Q69Bc5DbDMUTllfOE+npFzTPCBZOktfRp+KByIjJApCdMo9bgvByLnrEPAPPFUt1uNd
         UizQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAXoF1C+VwfihjRKJv3uY6dn7oc4zNLMmBtBq2hve7GQ1V9rYZUMKPyEg5RI8O8ZiLfRcn3xZdZP8Zytu1DMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJhnSVDLYfvXmJd/twN55PzrbrbaKHVGALT8SZ3WlO4YtgQO7
	3C0ZrEGcbudHA2eQhoGMSJIOlAkwBa2Z/rVGhEFKmJFBvFJKBzOEHTHcSyW2rGeIZwS/RyolS6C
	9rjXXlXClGQ4yH9pwlreS+JQ9ZCPiqSxyJJmmbl9OY63OMFhmGDyjj8aE16o=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:222a:b0:659:9a49:9044 with SMTP id
 006d021491bc7-662caad7444mr698534eaf.15.1769118334655; Thu, 22 Jan 2026
 13:45:34 -0800 (PST)
Date: Thu, 22 Jan 2026 13:45:34 -0800
In-Reply-To: <66fbcbc0.050a0220.6bad9.0058.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69729a7e.a00a0220.2cf64e.0003.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_sock_ready_cb (2)
From: syzbot <syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a66191c590b3 Merge tag 'hyperv-fixes-signed-20260121' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b467fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
dashboard link: https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143e7f9a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a66191c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a89b38a5520d/vmlinux-a66191c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33e1cf1326b6/bzImage-a66191c5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_sock_ready_cb+0x191/0x1a0 net/bluetooth/l2cap_sock.c:1687
Read of size 8 at addr ffff888036cc8188 by task kworker/1:7/6201

CPU: 1 UID: 0 PID: 6201 Comm: kworker/1:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
 l2cap_sock_ready_cb+0x191/0x1a0 net/bluetooth/l2cap_sock.c:1687
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1247 [inline]
 l2cap_conn_start+0x123/0xb20 net/bluetooth/l2cap_core.c:1513
 l2cap_info_timeout+0x81/0xa0 net/bluetooth/l2cap_core.c:1670
 process_one_work+0x9c2/0x1840 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3421
 kthread+0x3b3/0x730 kernel/kthread.c:463
 ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 28378:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_noprof+0x347/0x9c0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 sk_prot_alloc+0x10b/0x2a0 net/core/sock.c:2245
 sk_alloc+0x36/0xe80 net/core/sock.c:2301
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:626
 netlink_create+0x293/0x610 net/netlink/af_netlink.c:684
 __sock_create+0x339/0x860 net/socket.c:1605
 sock_create net/socket.c:1663 [inline]
 __sys_socket_create net/socket.c:1700 [inline]
 __sys_socket+0x14d/0x260 net/socket.c:1747
 __do_sys_socket net/socket.c:1761 [inline]
 __se_sys_socket net/socket.c:1759 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1759
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1c7/0x690 mm/slub.c:6882
 sk_prot_free net/core/sock.c:2284 [inline]
 __sk_destruct+0x8ab/0xbb0 net/core/sock.c:2384
 sk_destruct+0xc8/0xf0 net/core/sock.c:2412
 __sk_free+0xf4/0x3e0 net/core/sock.c:2423
 sk_free+0x61/0x90 net/core/sock.c:2434
 deferred_put_nlk_sk+0xbe/0x110 net/netlink/af_netlink.c:714
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x7c0/0x15c0 kernel/rcu/tree.c:2857
 handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x381/0x410 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1775
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1886
 add_grec+0x1380/0x1920 net/ipv6/mcast.c:2025
 mld_send_cr net/ipv6/mcast.c:2148 [inline]
 mld_ifc_work+0x3c5/0xc10 net/ipv6/mcast.c:2693
 process_one_work+0x9c2/0x1840 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3421
 kthread+0x3b3/0x730 kernel/kthread.c:463
 ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3119
 netlink_release+0xb28/0x1ff0 net/netlink/af_netlink.c:796
 __sock_release+0xb3/0x260 net/socket.c:662
 sock_close+0x1c/0x30 net/socket.c:1455
 __fput+0x3ff/0xb40 fs/file_table.c:468
 fput_close_sync+0x118/0x250 fs/file_table.c:573
 __do_sys_close fs/open.c:1573 [inline]
 __se_sys_close fs/open.c:1558 [inline]
 __x64_sys_close+0x8b/0x120 fs/open.c:1558
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888036cc8000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 392 bytes inside of
 freed 2048-byte region [ffff888036cc8000, ffff888036cc8800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36cc8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842f00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842f00 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000db3201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6062, tgid 6062 (syz-executor), ts 78835027953, free_ts 78732062892
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1e1/0x250 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0xe3d/0x2e10 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x26c/0x2410 mm/page_alloc.c:5240
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab mm/slub.c:3248 [inline]
 new_slab+0x2c4/0x440 mm/slub.c:3302
 ___slab_alloc+0xda3/0x1ca0 mm/slub.c:4656
 __slab_alloc.isra.0+0x63/0x110 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0x618/0x9c0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 sk_prot_alloc+0x10b/0x2a0 net/core/sock.c:2245
 sk_alloc+0x36/0xe80 net/core/sock.c:2301
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:626
 __netlink_kernel_create+0xed/0x750 net/netlink/af_netlink.c:2018
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 xfrm_user_net_init+0xc6/0x190 net/xfrm/xfrm_user.c:4216
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:581
page last free pid 6061 tgid 6061 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x822/0x1130 mm/page_alloc.c:2973
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x127/0x160 mm/slub.c:3886
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kvmalloc_node_noprof+0x306/0xac0 mm/slub.c:7140
 proc_sys_call_handler+0x2c7/0x5a0 fs/proc/proc_sysctl.c:583
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888036cc8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036cc8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888036cc8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888036cc8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036cc8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
