Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DD1E04AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500454; cv=none; b=G/dgXXk8SeeofYBl4DuoDN+75+7zSJcliM2EywKNrfii83vRMygDCPX/CDL3FxTYYQv9DMnvRnZoKkaFKlswczq2XM8+O0DKBMbtJlvzA2Emdb9e9eyEsAMOrVnUBX+iBnr0ZVdNZ9AGsm0K8hUc3bW6/7OE0hlht8EsXE73ZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500454; c=relaxed/simple;
	bh=X7faatACRXmsRnzCvoxzm3B82l1Lb+C0PJkvHPU5j+Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=siVNEX9I72xC8DDp8Z/QN5dTj0QQVyjrH5UM+WHCgDrTO3Lv2JROsGfXVJtL6m0WyO6aFYlu2yfe2mz/Ai1k3N4CkzYQmp4Tyv8uqCrNx07sV3hd340WpBRTnhWbNLtjjQIIRWSshM3HLQznxRUw1Hy7AL0le20o0/bdxpAmTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so30582405ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729500451; x=1730105251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puDkW1EAxsKRn3K0S4jktp4q7J5Kodw0sKvm9GDUJIs=;
        b=lDV9Ok05r/Z1NufPsyWf0zIRiTg/uZKLvej2YHdqu3KyqmgQyr7Axj7daSQyRV0I0F
         GCdJPXVCoC23jo9GGUMUgvC3BIX7sM0cKOCV9r/McjIMrEVuUa1MLiwIjkUSdsX3UzHn
         fmDU2lYC/Gajp3pZvpcXYksrMdAuWeRLjlhB8u9OBDN7YbcQ7qFyPWnOeTMvkx48NOLL
         WY595aj80o3/mrip90NQxU87rZIuwP9UjQb8SXxGMQYzT8agHwhl7ZSdwSsZ/Tfx20tY
         Wqsx5poDxF44eGWx/wgbWgP15hoWuoIvHu/Q2ZIaEqk+l+Mx7HWsF4lZgRAFua0QhPwa
         lh2g==
X-Forwarded-Encrypted: i=1; AJvYcCXmE3czFyW3c7YBhgfopwaZ2fI1wnXNMMtA6yYWaycP9UpNlp5IB60eckYsInDOlguzxLw0uZkd9ZHVNTKKKLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCpqc9GdbH9t69NZ2TZlW0yAv4j98QiMUwm+JJ2sCCku/n8jQ
	NgS53ozoG5Un2cGpboAETSYYJzEYBR6AlXBXVxnF+7rew6mUCHzBgUEri217esXpZZZh17vTwZ+
	CAxYsfy9ApFnVQmQvIUV3nLhY0YfpuQWssoOyVYC/63KhjXx4N8L2COg=
X-Google-Smtp-Source: AGHT+IG3RKTyQWVmtFyrCwujBikunGsUbpitcMQRFTM8EmP7a9DLVSBnuHEvKN421SxVMS7/n5sakQyFS/zjoZxfEIHxwCjm4C/b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:ce43:fb62 with SMTP id
 e9e14a558f8ab-3a3e531953amr101646105ab.11.1729500451308; Mon, 21 Oct 2024
 01:47:31 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:47:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67161523.050a0220.10f4f4.0041.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in bt_accept_unlink
From: syzbot <syzbot+a1595e656a83ea5b78eb@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1651a040580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=a1595e656a83ea5b78eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-d3d15566.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5087f167d7b8/vmlinux-d3d15566.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9f5c056e452/bzImage-d3d15566.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1595e656a83ea5b78eb@syzkaller.appspotmail.com

Bluetooth: hci2: Controller not accepting commands anymore: ncmd = 0
Bluetooth: hci2: Injecting HCI hardware error event
Bluetooth: hci2: hardware error 0x00
==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x1a6/0x1c0 lib/list_debug.c:62
Read of size 8 at addr ffff888048dd4550 by task kworker/u33:6/5358

CPU: 1 UID: 0 PID: 5358 Comm: kworker/u33:6 Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci2 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __list_del_entry_valid_or_report+0x1a6/0x1c0 lib/list_debug.c:62
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 bt_accept_unlink+0x34/0x2e0 net/bluetooth/af_bluetooth.c:234
 l2cap_sock_teardown_cb+0x1a3/0x3c0 net/bluetooth/l2cap_sock.c:1599
 l2cap_chan_del+0xba/0x900 net/bluetooth/l2cap_core.c:658
 l2cap_conn_del+0x37c/0x730 net/bluetooth/l2cap_core.c:1785
 l2cap_disconn_cfm net/bluetooth/l2cap_core.c:7299 [inline]
 l2cap_disconn_cfm+0x96/0xd0 net/bluetooth/l2cap_core.c:7292
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1975 [inline]
 hci_conn_hash_flush+0x114/0x260 net/bluetooth/hci_conn.c:2589
 hci_dev_close_sync+0x59e/0x1110 net/bluetooth/hci_sync.c:5195
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_error_reset+0xbf/0x320 net/bluetooth/hci_core.c:1016
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6177:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2164
 sk_alloc+0x36/0xb90 net/core/sock.c:2217
 __netlink_create+0x5e/0x2c0 net/netlink/af_netlink.c:646
 netlink_create+0x3a4/0x630 net/netlink/af_netlink.c:704
 __sock_create+0x32e/0x800 net/socket.c:1576
 sock_create net/socket.c:1627 [inline]
 __sys_socket_create net/socket.c:1664 [inline]
 __sys_socket+0x14f/0x260 net/socket.c:1711
 __do_sys_socket net/socket.c:1725 [inline]
 __se_sys_socket net/socket.c:1723 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6182:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 sk_prot_free net/core/sock.c:2200 [inline]
 __sk_destruct+0x5eb/0x720 net/core/sock.c:2292
 sk_destruct+0xc2/0xf0 net/core/sock.c:2307
 __sk_free+0xf4/0x3e0 net/core/sock.c:2318
 sk_free+0x6a/0x90 net/core/sock.c:2329
 deferred_put_nlk_sk+0x13f/0x2d0 net/netlink/af_netlink.c:740
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x99/0x7a0 kernel/rcu/tree.c:3086
 netlink_release+0x1206/0x1ff0 net/netlink/af_netlink.c:823
 __sock_release+0xb0/0x270 net/socket.c:658
 sock_close+0x1c/0x30 net/socket.c:1426
 __fput+0x3f6/0xb60 fs/file_table.c:431
 __fput_sync+0x45/0x50 fs/file_table.c:516
 __do_sys_close fs/open.c:1565 [inline]
 __se_sys_close fs/open.c:1550 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1550
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888048dd4000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1360 bytes inside of
 freed 2048-byte region [ffff888048dd4000, ffff888048dd4800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888048dd2000 pfn:0x48dd0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b042f00 ffffea00009c5e10 ffffea00012b8410
raw: ffff888048dd2000 0000000000080007 00000001f5000000 0000000000000000
head: 00fff00000000240 ffff88801b042f00 ffffea00009c5e10 ffffea00012b8410
head: ffff888048dd2000 0000000000080007 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001237401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5352, tgid 5352 (syz-executor), ts 38680626357, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 rtnl_newlink+0x49/0xa0 net/core/rtnetlink.c:3739
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6646
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888048dd4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888048dd4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888048dd4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888048dd4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888048dd4600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
