Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF2235C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894070; cv=none; b=GTn/srnQJYMSkG+08UDDaM/DXKuCGSZPLV9uAgYros1touP1kaflDGEhOtVU6yaB4ZjCumo7UOrFeJz4JpNREOhq594Plh/MclUNmjLDfowE0Bb92dy192x6WgzYwIy5k3pi6jfbNHk66t/E6SmFefj/3HXnI6LtvxlcFgyiEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894070; c=relaxed/simple;
	bh=LSm2YeYzYxIdKZxksJ/Z9m5X3nUiIrS9TZOKX5QkOo8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mP8ADxTjj8BvBEFHG4uofdqZKUxgkm6nETCnl2LLIUAczfyqptKmODmoJ8kghdRRm/rmyHpvwWnnwJYv1egIF85LMn+PWgzMmp+aZVcW5GWL8qA4o0bjNHGp6W8MHhAEwZ+4FJKGdNez4ofhSybsjfYWbcpZ9da8otY+OM6dmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a49f09233dso174833b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 04:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784894067; x=1785498867;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZrzaXUU4adCoHuav1t7RSHeps+njlzAD+ETtaY+gxo=;
        b=hoYeQWxQ1exRdHPYATB+7J9KkrHvDm4fbmru6e0ttTOQUOm0/oZA5i4BZ6wxVbmp0R
         RcWNpbSRHvKSiYt/JJNy0uRWCGqjrVXmq3BeW4ny3JFoYTdeR4PaOZeXcR4IGXCWedfm
         1CBEQGW+XowGB1l+fLyrsQutx31be4hMqFLqNw6PCgkN98vONjYXdLYz+VvDbx+gMwT5
         X4z5WesIcNZyGGrfnX18YcHwFH8nW8BFNbuS/oNUzoX1s9UEFsYnZ9FvdpaKw9EkLLqx
         Cd2Wb98bybCw+v1BCJwd8xQPM7tnsnxpbLZTSkbRiXdT7ddT+EMuM1vSiUmjt1Mg7U2w
         0yPA==
X-Gm-Message-State: AOJu0YwpcZl8KS0tRa2478dcZvIeP87jDqHOg+SJdnTEjbhnm73TwUhm
	7gwZYnlo3Y7NkzrO5+9hWKotZVmiFTbty8sxaQl3hs0W9kHvKu35WVAiscWkF7tpCsJD1Cbesxk
	EKBUYYPsoJ5tnMK6cfpup3/6mTfolYxuSop4HuQn+eCqGlXcX8UTGM38+Td/9/A==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1646:b0:49f:a87e:2316 with SMTP id
 5614622812f47-4ab35497d33mr3972267b6e.31.1784894067184; Fri, 24 Jul 2026
 04:54:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 04:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a635273.dde6c935.cf6c8.001f.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in
 l2cap_sock_setsockopt (2)
From: syzbot <syzbot+b106284c2a0b7bc80cf9@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6859eed755d Merge tag 's390-7.2-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fc3789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=b106284c2a0b7bc80cf9
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c6859eed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d3a7ae02103/vmlinux-c6859eed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6da93fb737/bzImage-c6859eed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b106284c2a0b7bc80cf9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in l2cap_sock_setsockopt+0x22c3/0x2330 net/bluetooth/l2cap_sock.c:1003
Read of size 1 at addr ffff88802803c362 by task syz.1.1719/10814

CPU: 1 UID: 0 PID: 10814 Comm: syz.1.1719 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 l2cap_sock_setsockopt+0x22c3/0x2330 net/bluetooth/l2cap_sock.c:1003
 do_sock_setsockopt+0xf3/0x1d0 net/socket.c:2368
 __sys_setsockopt+0x195/0x220 net/socket.c:2393
 __do_sys_setsockopt net/socket.c:2399 [inline]
 __se_sys_setsockopt net/socket.c:2396 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdccd9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdcaff6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fbdcd025fa0 RCX: 00007fbdccd9de99
RDX: 0000000000000008 RSI: 0000000000000112 RDI: 0000000000000004
RBP: 00007fbdcce33eaf R08: 0000000000000004 R09: 0000000000000000
R10: 00002000000005c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbdcd026038 R14: 00007fbdcd025fa0 R15: 00007fffc6ab0ee8
 </TASK>

The buggy address belongs to the object at ffff88802803c340
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 34 bytes inside of
 allocated 704-byte region [ffff88802803c340, ffff88802803c600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2803c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801cb40500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801cb40500 dead000000000122 0000000000000000
head: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2000(__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5813, tgid 5813 (kworker/u32:4), ts 280325981720, free_ts 280258613659
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab mm/slub.c:3408 [inline]
 new_slab+0xa2/0x650 mm/slub.c:3454
 refill_objects+0xe3/0x410 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 kmem_cache_alloc_node_noprof+0x52c/0x6b0 mm/slub.c:5017
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xd2d/0x18b0 lib/kobject_uevent.c:611
 device_del+0x605/0x9b0 drivers/base/core.c:3979
 device_unregister+0x1d/0xe0 drivers/base/core.c:4002
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim_main.c:6228 [inline]
 hwsim_exit_net+0x8c2/0x14f0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:7207
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
page last free pid 10776 tgid 10776 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 hci_release_dev+0x4ef/0x630 net/bluetooth/hci_core.c:2739
 bt_host_release+0x6b/0xb0 net/bluetooth/hci_sysfs.c:87
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
 vhci_release+0x185/0x230 drivers/bluetooth/hci_vhci.c:701
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1009
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1161
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802803c200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802803c280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802803c300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff88802803c380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802803c400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
