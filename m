Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870EA945
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763956890; cv=none; b=t7pBg6AuXtpMQbnMqNVk9IMw2x5k3foWSqPge1FurAtdKZnx6LSd9CJDze2gqdZgNY9Ip8GAKcV3i2f56vLjpAKKZNn3FaqdEpRG/81xumdQFy/Dmc0aMrtSTVl7YAI5KhQ9S7RjAlRF8hlNsPyVs/HAwVks/xYqOh5Cp1+XMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763956890; c=relaxed/simple;
	bh=JoG+R9vf2ItsJEMegpfRb2CF4rl8i6JVSpxyT3VV2Gg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h5uunoW6RuesY5Y1cLxS9FFzVnWXeOU5dr8OvnKlJrjFxuOJ84jwpuevoZJnGeDguM7m4VWiOwBCVJgzljn5E8/V2zGKLcfH/BVXYCGYAgLI2MVRn2sptBSM2jtVXg0qr+0wRaGWBAbYBrgyIKOaBLNMSerYvNEkx3CeH8pIpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-433795a17c1so36618435ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 20:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763956888; x=1764561688;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xR+5TrIlNe+ie5Zt6jWMtYH/1ynDaTu4iDvUWz8Zvak=;
        b=WedymIiVs6BpszzDXQidee2QIQpJOxPUj9z7IDpq2jw6RW0QSO74uI/x2qoF+pwHTt
         oo/W2s7SWGj/3CfRdf0VhWxqXzy7/ARbdjO0itMufj6aiXFHatLkE4BxGyG2KrbJ5iZO
         3E+VgkdCNVoHy7Jowi0DH1odINRgggudh8/LCCcc9qPhao2Fkzahlp1clyexV5OIc3O+
         DjWGl5J851v8qFGxdzXNmOb3xMKshGGRa92oP3Vn6Gp8+e+OFqPc9XzjazlwnU8EgQFp
         7VmuLhR9Zp1anHj1PtSy6zHp4wtBmJyV6Mnh2hDM/fkRYAKgVA5I6wKmVCLBSKCY00k8
         DA1w==
X-Forwarded-Encrypted: i=1; AJvYcCU7/5wr2d7mdXA7rXI8QiR9nTvkcHMB3C/WI0JLBe8/4qwICXZcz5TK2cEmD4tLa6vQxl/LpfmUiVAso4hzWy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzGxhbPHz6hGwGKPfBqxhW6l1EuH4knkaBCnPRzvE9SiHY3eQ
	z24rfNP7vGaGD5oE4uFx6rMYeowSn1Zkz0/1ypjd8d7a0xfzXtINM1o0fX2VKL31rfESPj9hI1M
	EYzB+oQ7aOBHcCgA3JdY1WHU1IDwo4sYFocrlKtUlP8jChWDb/w1guhjCLX0=
X-Google-Smtp-Source: AGHT+IFW1HbWCsPobMtyh/rHBNERm9rFwePy2+cQfYdJkC3DyuiVcR6dDj+2Z0MFXIMDZvKkBVB8kF0QAPIC16fArb1XXfmgEmrS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2504:b0:433:78b8:943a with SMTP id
 e9e14a558f8ab-435b9860e58mr68931715ab.10.1763956887792; Sun, 23 Nov 2025
 20:01:27 -0800 (PST)
Date: Sun, 23 Nov 2025 20:01:27 -0800
In-Reply-To: <671614e4.050a0220.1e4b4d.0055.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923d897.a70a0220.2ea503.0077.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
From: syzbot <syzbot+cdae834448ec8c3602fe@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d0e88704d96c Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1263ce92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
dashboard link: https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bc797c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/711231d3cfaf/disk-d0e88704.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d60243774d7d/vmlinux-d0e88704.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3604850a56dd/bzImage-d0e88704.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdae834448ec8c3602fe@syzkaller.appspotmail.com

 </TASK>
kobject: kobject_add_internal failed for hci3:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci3: failed to register connection device
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_sock_new_connection_cb+0x1f9/0x2b0 net/bluetooth/l2cap_sock.c:1500
Read of size 8 at addr ffff888034df07a8 by task kworker/u9:3/5924

CPU: 1 UID: 0 PID: 5924 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 l2cap_sock_new_connection_cb+0x1f9/0x2b0 net/bluetooth/l2cap_sock.c:1500
 l2cap_connect_cfm+0x37a/0x1040 net/bluetooth/l2cap_core.c:7288
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2107
 le_conn_complete_evt+0xfb8/0x1500 net/bluetooth/hci_event.c:5799
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5825
 hci_event_func net/bluetooth/hci_event.c:7586 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7643
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5924:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5650 [inline]
 __kmalloc_noprof+0x233/0x7d0 mm/slub.c:5662
 kmalloc_noprof include/linux/slab.h:961 [inline]
 sk_prot_alloc+0xe7/0x220 net/core/sock.c:2239
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 bt_sock_alloc+0x3b/0x310 net/bluetooth/af_bluetooth.c:151
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1897 [inline]
 l2cap_sock_new_connection_cb+0xe2/0x2b0 net/bluetooth/l2cap_sock.c:1485
 l2cap_connect_cfm+0x37a/0x1040 net/bluetooth/l2cap_core.c:7288
 hci_connect_cfm+0x95/0x140 include/net/bluetooth/hci_core.h:2107
 le_conn_complete_evt+0xfb8/0x1500 net/bluetooth/hci_event.c:5799
 hci_le_conn_complete_evt+0x187/0x450 net/bluetooth/hci_event.c:5825
 hci_event_func net/bluetooth/hci_event.c:7586 [inline]
 hci_event_packet+0x78f/0x1200 net/bluetooth/hci_event.c:7643
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4099
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6561:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kfree+0x197/0x950 mm/slub.c:6849
 sk_prot_free net/core/sock.c:2278 [inline]
 __sk_destruct+0x4e4/0x670 net/core/sock.c:2373
 l2cap_sock_cleanup_listen+0xda/0x3e0 net/bluetooth/l2cap_sock.c:1465
 l2cap_sock_release+0x6a/0x230 net/bluetooth/l2cap_sock.c:1426
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888034df0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1960 bytes inside of
 freed 2048-byte region [ffff888034df0000, ffff888034df0800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34df0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff27000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff27000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea0000d37c01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5829, tgid 5829 (syz-executor), ts 105983598332, free_ts 105930998295
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5178
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3232
 new_slab mm/slub.c:3286 [inline]
 ___slab_alloc+0xb10/0x1400 mm/slub.c:4655
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 __do_kmalloc_node mm/slub.c:5649 [inline]
 __kmalloc_node_track_caller_noprof+0x2a8/0x7e0 mm/slub.c:5759
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:601
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x84/0x260 net/core/rtnetlink.c:4400
 rtmsg_ifinfo_event net/core/rtnetlink.c:4442 [inline]
 rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4451
 register_netdevice+0x1746/0x1b10 net/core/dev.c:11346
 __ip_tunnel_create+0x3e7/0x560 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2ba/0x800 net/ipv4/ip_tunnel.c:1147
 vti_init_net+0x2f/0x100 net/ipv4/ip_vti.c:517
page last free pid 5832 tgid 5832 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2901
 discard_slab mm/slub.c:3330 [inline]
 __put_partials+0x149/0x170 mm/slub.c:3876
 __slab_free+0x29e/0x370 mm/slub.c:5929
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 __kmalloc_cache_noprof+0x181/0x6c0 mm/slub.c:5766
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x5a/0x180 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:2106 [inline]
 netdev_register_kobject+0x1a2/0x310 net/core/net-sysfs.c:2362
 register_netdevice+0x12a0/0x1b10 net/core/dev.c:11294
 __ip_tunnel_create+0x3e7/0x560 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2ba/0x800 net/ipv4/ip_tunnel.c:1147
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0xfe/0x320 net/core/net_namespace.c:445
 copy_net_ns+0x34e/0x4e0 net/core/net_namespace.c:580
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110

Memory state around the buggy address:
 ffff888034df0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034df0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888034df0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888034df0800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888034df0880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
