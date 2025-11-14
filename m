Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D07261B
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161948; cv=none; b=kvf7BVLwj37xpqBaYBnoS4HDVMbsSQRyqUbot2GjegXXzSkusrpPwiQ6j4mHwquCrihJh5uTknPce5NmjG/WFU0Oms8xnN5x6KHBH65LEc+up983UwKD+d1GqhXB9tzIqNozMTs8w6a9WmlPDx4kBLbJwCpLctvO9W9dmcHJV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161948; c=relaxed/simple;
	bh=PNsQxj8S9GoNHaSYs1/57Hk2TQEsaS9rVA3XBwZUrSU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hjbsh9cx7isJHgjYkRUNW1SJ0ThaJK7Y2B8p1EjLKL9xY02+IIkrkrjEDoD4WCuWuxSRFez2tf+GfjwuAoWnFprvsG0c1IWRNB+EN2Y3j7ihsHe7pQUYcFJDrsAZMkobBeLgEYYuBtdBApN2Zyh1Q5opv0aEqE2kFRWqkIoGVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43470d72247so24534915ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 15:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763161946; x=1763766746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hruo2ok1HAVaQ8w29cxPJEmoRJC2SWlMmL1Ku5Ix/wM=;
        b=QS3YU+1GS0InvO5XHDxY+vAopJ1rK6U+w/ivMfCG0A+tlQyWJF+2hM8H/E3HYUSgL5
         ZNHzLPHPdr2O1Trq6NOzY6U/DAh7rRpG98xGBdtE1CZ9zfhQuAXY5rgheyen1zcTHfXn
         b/3dOwq8U6xYWwhxvDXmO24s585uas84HhFOqFxKcLe7JN6pc+YdAk047B/9ovpdMdGA
         xQtBLzaP50i90oPiFDMwygYMfePzfupaPPczDpW6EOzyH9xISQ/sa4JTOUy0JeiqaBQp
         jQtnbhLVekkuoSztInhIY45aTND1hIFK9EhV28rsAy7s/5Rf1J9encJaLqORNkC6+Vte
         bo5g==
X-Forwarded-Encrypted: i=1; AJvYcCWaWK1sA4VIrqU+k5eEpcb1j5L6fN4p35u5BVUCD8HuGjOvy/A1Vl1arYbqK/kYBjscUtZIoFJiviCVwaAHWmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvliuH3JPAHg8d99Qt70gsf0qlwf0VXtW3AZC9gP+uBzII/m6P
	Zd3+d1DiBuAwIhwiKctyJEbZQoDLs93RBq92zl63AI8JC+yB12ie5PYTUTmLQv61K2ziJsCEgLf
	XvjiN/vP/+IdLLdO69I6IAN1AGGF+ClLyzrkjGC1M8o4vdA4zdRjq/3eIERE=
X-Google-Smtp-Source: AGHT+IHxOJkD0nWzmmtYe63cufaomrn8YPZ/EVNCdtBtATreaSDrKuAai9YzqJ91slFJwE8IrbNMSPsX7CUyffVAQRF2KtQMv3re
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8a:b0:433:7d04:55da with SMTP id
 e9e14a558f8ab-4348c93ebf0mr63758275ab.31.1763161946217; Fri, 14 Nov 2025
 15:12:26 -0800 (PST)
Date: Fri, 14 Nov 2025 15:12:26 -0800
In-Reply-To: <67161523.050a0220.10f4f4.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6917b75a.050a0220.3565dc.0047.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in bt_accept_unlink
From: syzbot <syzbot+a1595e656a83ea5b78eb@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    db9030a787e3 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13645c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdc83aa8a8b9d1ae
dashboard link: https://syzkaller.appspot.com/bug?extid=a1595e656a83ea5b78eb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cb37cd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8932d8648ef5/disk-db9030a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8446b6e4ef5c/vmlinux-db9030a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17118b94e44/Image-db9030a7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1595e656a83ea5b78eb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x8c/0x1b4 lib/list_debug.c:62
Read of size 8 at addr ffff0000f4f2f570 by task syz-executor/10110

CPU: 1 UID: 0 PID: 10110 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __list_del_entry_valid_or_report+0x8c/0x1b4 lib/list_debug.c:62
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_init include/linux/list.h:295 [inline]
 bt_accept_unlink+0x40/0x248 net/bluetooth/af_bluetooth.c:259
 l2cap_sock_teardown_cb+0x148/0x360 net/bluetooth/l2cap_sock.c:1616
 l2cap_chan_del+0xb8/0x470 net/bluetooth/l2cap_core.c:655
 l2cap_conn_del+0x2f8/0x5f0 net/bluetooth/l2cap_core.c:1787
 l2cap_disconn_cfm+0x90/0xe0 net/bluetooth/l2cap_core.c:7325
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2122 [inline]
 hci_conn_hash_flush+0x108/0x218 net/bluetooth/hci_conn.c:2609
 hci_dev_close_sync+0x89c/0x1154 net/bluetooth/hci_sync.c:5308
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_unregister_dev+0x204/0x4c0 net/bluetooth/hci_core.c:2715
 vhci_release+0x12c/0x17c drivers/bluetooth/hci_vhci.c:690
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:966
 do_group_exit+0x194/0x22c kernel/exit.c:1107
 get_signal+0x11dc/0x12f8 kernel/signal.c:3034
 arch_do_signal_or_restart+0x274/0x4414 arch/arm64/kernel/signal.c:1619
 exit_to_user_mode_loop+0x7c/0x178 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:81 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:725
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Allocated by task 13304:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5646 [inline]
 __kmalloc_noprof+0x3fc/0x728 mm/slub.c:5658
 kmalloc_noprof include/linux/slab.h:961 [inline]
 sk_prot_alloc+0xc4/0x1f0 net/core/sock.c:2239
 sk_alloc+0x44/0x3ac net/core/sock.c:2295
 pfkey_create+0xcc/0x520 net/key/af_key.c:152
 __sock_create+0x43c/0x91c net/socket.c:1605
 sock_create net/socket.c:1663 [inline]
 __sys_socket_create net/socket.c:1700 [inline]
 __sys_socket+0xd4/0x1c0 net/socket.c:1747
 __do_sys_socket net/socket.c:1761 [inline]
 __se_sys_socket net/socket.c:1759 [inline]
 __arm64_sys_socket+0x7c/0x94 net/socket.c:1759
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 13304:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 __kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6634 [inline]
 kfree+0x184/0x600 mm/slub.c:6841
 sk_prot_free net/core/sock.c:2278 [inline]
 __sk_destruct+0x514/0x780 net/core/sock.c:2373
 sk_destruct net/core/sock.c:2401 [inline]
 __sk_free+0x320/0x430 net/core/sock.c:2412
 sk_free+0x60/0xc8 net/core/sock.c:2423
 sock_put include/net/sock.h:1972 [inline]
 pfkey_release+0x254/0x338 net/key/af_key.c:186
 __sock_release net/socket.c:662 [inline]
 sock_close+0xa0/0x1e4 net/socket.c:1455
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:81 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:725
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the object at ffff0000f4f2f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1392 bytes inside of
 freed 2048-byte region [ffff0000f4f2f000, ffff0000f4f2f800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x134f28
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0002000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0002000 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3d3ca01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000f4f2f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000f4f2f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000f4f2f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff0000f4f2f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000f4f2f600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
 slab kmalloc-2k start ffff0000f4f2f000 pointer offset 1392 size 2048
list_del corruption. prev->next should be ffff0000d9262570, but was 0000000000000000. (prev=ffff0000f4f2f570)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 10110 Comm: syz-executor Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid_or_report+0x17c/0x1b4 lib/list_debug.c:62
lr : __list_del_entry_valid_or_report+0x17c/0x1b4 lib/list_debug.c:62
sp : ffff80009bed7370
x29: ffff80009bed7370 x28: 0000000000000003 x27: ffff0000f6f3e00c
x26: ffff0000f6f3e000 x25: 1fffe0001ede7c02 x24: dfff800000000000
x23: 1fffe0001e9e5eae x22: dfff800000000000 x21: ffff0000f4f2f570
x20: ffff0000f4f2f570 x19: ffff0000d9262570 x18: 1fffe000337dfe90
x17: 20747562202c3037 x16: ffff800082debe40 x15: 0000000000000001
x14: 1fffe000337dfefa x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337dfefb x10: 0000000000ff0100 x9 : 6db35dbdbd571600
x8 : 6db35dbdbd571600 x7 : fffffffffffce210 x6 : ffff8000805653c0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000807d6608
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid_or_report+0x17c/0x1b4 lib/list_debug.c:62 (P)
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_init include/linux/list.h:295 [inline]
 bt_accept_unlink+0x40/0x248 net/bluetooth/af_bluetooth.c:259
 l2cap_sock_teardown_cb+0x148/0x360 net/bluetooth/l2cap_sock.c:1616
 l2cap_chan_del+0xb8/0x470 net/bluetooth/l2cap_core.c:655
 l2cap_conn_del+0x2f8/0x5f0 net/bluetooth/l2cap_core.c:1787
 l2cap_disconn_cfm+0x90/0xe0 net/bluetooth/l2cap_core.c:7325
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2122 [inline]
 hci_conn_hash_flush+0x108/0x218 net/bluetooth/hci_conn.c:2609
 hci_dev_close_sync+0x89c/0x1154 net/bluetooth/hci_sync.c:5308
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_unregister_dev+0x204/0x4c0 net/bluetooth/hci_core.c:2715
 vhci_release+0x12c/0x17c drivers/bluetooth/hci_vhci.c:690
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:966
 do_group_exit+0x194/0x22c kernel/exit.c:1107
 get_signal+0x11dc/0x12f8 kernel/signal.c:3034
 arch_do_signal_or_restart+0x274/0x4414 arch/arm64/kernel/signal.c:1619
 exit_to_user_mode_loop+0x7c/0x178 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:81 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:725
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: 910d0000 aa1303e1 aa1503e3 974c6749 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
