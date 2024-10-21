Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E21E04AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500576; cv=none; b=i2gyGOpqlqOB+OVDtpJUZd0iEOhfrpKhn4ZC2FIvl69e6NCmJMQu+ktPyawUFDeIU/6uXWLBUdeWJvO776jS7S03mCKb2M8Ii7v30pOvC83eWmDrusqEm6JCinps87dBpW8YbgvbpV3gs6gXWomyXvWAzUm+N0R0f4MibNSJFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500576; c=relaxed/simple;
	bh=cj4+eWGaf4AWJY6bhxZF1zS/CppU4T/ol0N0JggXKOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iWG6o/aEyPuv+VOjfxzy4UM+obBoFewBcFKDn5IHFHPBGcCqAYIFDRSTMPvM95ZGx5fnMzVteRmSZpfyJnvN0oHx5PIaD4gHQYDEH+rdiU2UVq62qlLi1bKGO06r64qsTV3XC8yul7I6wa43BzLVdWHkH39zvtJuZbDpgnR/B4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so36571875ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729500573; x=1730105373;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ5tw/YgxAu5aYmq2gd/Rik0dh7sm0ViAPSG+l+6mCo=;
        b=IemQiKUv6USEkhoS8ypfeqVu4yNMRsK2EUwZBa/R2GsVnQPO2UgkMMiS6dOQn88gAh
         01bCglOmz+40mItiWIWr/T8JnSgr+saB7KQ+x7V3qrFeGytk+sXi+rNT1al7jlB/aV4v
         3NW+BJ/lmOA5WKKh2U6PReqO4L4zATamyqD2ctjMK5QZJYmURDUj2hkXaR2UFK5cWJyh
         zEs8GHdAbSL9sZl8uH6YLGurSEzbm7jKXcur6XAe6BHFjtcyq3GeC6i6LXmdZ85Is+2D
         2T++zK0NSeeolESah9lpetbcwMY32Zx4WRgpmNkPuc5kZF/X+NAAaM7hcYtPPG1kLvV1
         nrAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9OruvYZ2n3uWYtGrUWsyU2msLlCck9Pw+sueztRdlzjDwV0+m89cMnlRRmKofFym9KuJuNaB9aV0Nexzpgrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjoy+CYSm/CuYcsGfynO4WzHWpsCbd68ZDPiCZN42zHMR/HSew
	lYP0pxY5mn0HR0LX4mkFfqi5Ekl+ZecFeYuPa/boO7vvt3/KhK9U1mIYBXHrWqheenSAYDJ8SIV
	8sg18elDs+z1wPfsWywlpoIKKS6SOc80l/6LrJtWdQBzO+K9wtjsOK3A=
X-Google-Smtp-Source: AGHT+IEGb5KZu+kqSDF4KEkCsnRFYEmcysjRi/V3K5UDAWHk7K2jPM9CaSObTNqs7nQmqK0QjuyZfNRHuFLBMockqnDzPqlYxuYH
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3f40b531fmr103170275ab.21.1729500573042; Mon, 21 Oct 2024
 01:49:33 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:49:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716159d.050a0220.10f4f4.0043.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in bt_accept_dequeue
From: syzbot <syzbot+086fa22d07b56091fd1e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a2189f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6217aa8bbaeb1577
dashboard link: https://syzkaller.appspot.com/bug?extid=086fa22d07b56091fd1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f72c76601a03/disk-788220ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89cddc06c675/vmlinux-788220ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22a1d1d497f6/bzImage-788220ee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+086fa22d07b56091fd1e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bt_accept_dequeue+0x582/0x600 net/bluetooth/af_bluetooth.c:249
Read of size 8 at addr ffff8880336f0500 by task krfcommd/2839

CPU: 0 UID: 0 PID: 2839 Comm: krfcommd Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 bt_accept_dequeue+0x582/0x600 net/bluetooth/af_bluetooth.c:249
 l2cap_sock_accept+0x2c8/0x650 net/bluetooth/l2cap_sock.c:351
 kernel_accept+0x1d3/0x380 net/socket.c:3607
 rfcomm_accept_connection net/bluetooth/rfcomm/core.c:1971 [inline]
 rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2030 [inline]
 rfcomm_run+0x3a7/0x5220 net/bluetooth/rfcomm/core.c:2126
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9307:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2096
 sk_alloc+0x36/0xb90 net/core/sock.c:2149
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x35/0x180 net/bluetooth/l2cap_sock.c:1877
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1468
 l2cap_connect.constprop.0+0x765/0x1270 net/bluetooth/l2cap_core.c:3980
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 11681:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 sk_prot_free net/core/sock.c:2132 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2224
 sk_destruct+0xc2/0xf0 net/core/sock.c:2239
 __sk_free+0xf4/0x3e0 net/core/sock.c:2250
 sk_free+0x6a/0x90 net/core/sock.c:2261
 sock_put include/net/sock.h:1884 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1250 [inline]
 l2cap_sock_kill+0x171/0x2d0 net/bluetooth/l2cap_sock.c:1235
 l2cap_sock_close_cb+0x44/0x60 net/bluetooth/l2cap_sock.c:1557
 l2cap_conn_del+0x3be/0x730 net/bluetooth/l2cap_core.c:1787
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c6/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5606
 hci_suspend_sync+0x772/0xab0 net/bluetooth/hci_sync.c:6083
 hci_suspend_dev+0x2ac/0x480 net/bluetooth/hci_core.c:2826
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2412
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:353 [inline]
 blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:341
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x198/0x2b0 kernel/power/user.c:77
 misc_open+0x3dd/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x270/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x922/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880336f0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1280 bytes inside of
 freed 2048-byte region [ffff8880336f0000, ffff8880336f0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880336f6000 pfn:0x336f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000240 ffff88801ac42000 ffffea0000a01810 ffffea00015e7810
raw: ffff8880336f6000 0000000000080001 00000001fdffffff 0000000000000000
head: 00fff00000000240 ffff88801ac42000 ffffea0000a01810 ffffea00015e7810
head: ffff8880336f6000 0000000000080001 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0000cdbc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5518, tgid 5518 (kworker/0:7), ts 1161965798443, free_ts 1161930025325
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4181
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 mld_newpack.isra.0+0x1ed/0x790 net/ipv6/mcast.c:1746
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1849
 add_grec+0x111e/0x1670 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2650
page last free pid 11267 tgid 11267 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 call_modprobe kernel/module/kmod.c:84 [inline]
 __request_module+0x2c6/0x6c0 kernel/module/kmod.c:173
 dev_load+0x1ff/0x240 net/core/dev_ioctl.c:646
 dev_ioctl+0x473/0x10c0 net/core/dev_ioctl.c:710
 sock_do_ioctl+0x19e/0x280 net/socket.c:1236
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880336f0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880336f0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880336f0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880336f0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880336f0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:779 [inline]
BUG: KASAN: slab-use-after-free in bt_accept_dequeue+0x1f6/0x600 net/bluetooth/af_bluetooth.c:253
Write of size 4 at addr ffff8880336f0080 by task krfcommd/2839

CPU: 1 UID: 0 PID: 2839 Comm: krfcommd Tainted: G    B              6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:779 [inline]
 bt_accept_dequeue+0x1f6/0x600 net/bluetooth/af_bluetooth.c:253
 l2cap_sock_accept+0x2c8/0x650 net/bluetooth/l2cap_sock.c:351
 kernel_accept+0x1d3/0x380 net/socket.c:3607
 rfcomm_accept_connection net/bluetooth/rfcomm/core.c:1971 [inline]
 rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2030 [inline]
 rfcomm_run+0x3a7/0x5220 net/bluetooth/rfcomm/core.c:2126
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9307:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2096
 sk_alloc+0x36/0xb90 net/core/sock.c:2149
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc.constprop.0+0x35/0x180 net/bluetooth/l2cap_sock.c:1877
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1468
 l2cap_connect.constprop.0+0x765/0x1270 net/bluetooth/l2cap_core.c:3980
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 11681:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 sk_prot_free net/core/sock.c:2132 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2224
 sk_destruct+0xc2/0xf0 net/core/sock.c:2239
 __sk_free+0xf4/0x3e0 net/core/sock.c:2250
 sk_free+0x6a/0x90 net/core/sock.c:2261
 sock_put include/net/sock.h:1884 [inline]
 l2cap_sock_kill net/bluetooth/l2cap_sock.c:1250 [inline]
 l2cap_sock_kill+0x171/0x2d0 net/bluetooth/l2cap_sock.c:1235
 l2cap_sock_close_cb+0x44/0x60 net/bluetooth/l2cap_sock.c:1557
 l2cap_conn_del+0x3be/0x730 net/bluetooth/l2cap_core.c:1787
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c6/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 hci_disconnect_all_sync.constprop.0+0x104/0x3c0 net/bluetooth/hci_sync.c:5606
 hci_suspend_sync+0x772/0xab0 net/bluetooth/hci_sync.c:6083
 hci_suspend_dev+0x2ac/0x480 net/bluetooth/hci_core.c:2826
 hci_suspend_notifier+0x28d/0x2f0 net/bluetooth/hci_core.c:2412
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:353 [inline]
 blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:341
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x198/0x2b0 kernel/power/user.c:77
 misc_open+0x3dd/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x270/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x922/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880336f0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff8880336f0000, ffff8880336f0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880336f6000 pfn:0x336f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000240 ffff88801ac42000 ffffea0000a01810 ffffea00015e7810
raw: ffff8880336f6000 0000000000080001 00000001fdffffff 0000000000000000
head: 00fff00000000240 ffff88801ac42000 ffffea0000a01810 ffffea00015e7810
head: ffff8880336f6000 0000000000080001 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0000cdbc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5518, tgid 5518 (kworker/0:7), ts 1161965798443, free_ts 1161930025325
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4181
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 mld_newpack.isra.0+0x1ed/0x790 net/ipv6/mcast.c:1746
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1849
 add_grec+0x111e/0x1670 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2650
page last free pid 11267 tgid 11267 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 call_modprobe kernel/module/kmod.c:84 [inline]
 __request_module+0x2c6/0x6c0 kernel/module/kmod.c:173
 dev_load+0x1ff/0x240 net/core/dev_ioctl.c:646
 dev_ioctl+0x473/0x10c0 net/core/dev_ioctl.c:710
 sock_do_ioctl+0x19e/0x280 net/socket.c:1236
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880336eff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880336f0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880336f0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880336f0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880336f0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
