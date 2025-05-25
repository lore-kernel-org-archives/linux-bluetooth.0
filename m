Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01551422DD
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159074; cv=none; b=LnTkPszyS1NVLkjyK23Cx9hZeXWOgXN7uCvj9EeUkFCs4aLjSNDXokQL1bF4qwsUf90/E4r364PtglXYc8vvFEoHXvYtBYixRpA9oVM7BCApqgMt/7CABSLeOFUpTGafJwkI3/Dn6vzjQtloCevpa1VZZnyYhporkoeXPhjRXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159074; c=relaxed/simple;
	bh=42AWrA9nk8USUNwUphmLJmzaussggf4obiVqkNQPlqU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QMOTu2FvHcKbIsyOPgXc6WF5QMxBBObq2CyH0ID94zYuakjJq/Ss1XtIGBewxjqJ1vcRNrK3TfGMMZBOtjjNFHwNwyzIq0FGySTnKZLkB+DrM0yax8qQJQAV+47RhrLfRha61laDy+Pshg8VeW688N2ECiacYx5BeZmQv5x0RRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86195b64df7so226724939f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 00:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748159072; x=1748763872;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEXfHO69tyhOAOLcVHfaPoFhFBAZSOh92UDJmBkwl7g=;
        b=A/rNHagen4RM9h//wDQ4m9h5dKtm/qYetjdQK78Nwm7f+4+bGh+gU8fbHkHqSI1F5G
         hggrnr1lMTSaZ61jufS7jt4SZ3zCwVzXMlgbIr4eCAvssXzHu9oRdzpis5RplmYqnVVF
         yMiY+AxiBJ9y00d0Hz30RbXksNgoX0lQlFBHoOHTi7Fz8LINaEgirHU3wsvdRu5pgpiY
         3d41CNg/R8QmDmYHNQMl2A6lON9lLvVWh0/WqZ5p28HZMMClJ2WE+JoGtavVHnNHVO4x
         /X2PBkf2OtcEvSo0XNW3Nji5NOA8yqtqvV1f+80oao8wcUUkrNCI931hgMXVgXz7jp8K
         7wMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW/PeWl2IlqTkf0ZwaJzyNfvRtbi2KmpTU5pQLuDbIKS4lGJ0u9ztA5V5PPxGqQqkyhTTlFmANSP7bm3NWTJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOETzdolbNi98/w18bXk0fzazQDufj9brYGSUTEm1v+A3iSwt
	W5UHgCC3cI8IquBJTxaJy4B1slHYT92ObbKuuDTxgmyffJcABPh3xGH2Q0IUQNfYlMsOBuNjcoE
	kmKMjB28ULwTvm/upm842akpZLA22zEMzdApXn/GkeHxTGmVFo5jrAkoMFJg=
X-Google-Smtp-Source: AGHT+IFqvHcNf21AgZdJFNp0p41j/eXWVEyCZYAp7MWR8c93qiVA+sWmoKvspmeUry8kBF3GgK7p1HSAlhpRIFoZyZimRUnsMzLG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a09:b0:85b:3f06:1fd4 with SMTP id
 ca18e2360f4ac-86cbb88d517mr519875239f.9.1748159071951; Sun, 25 May 2025
 00:44:31 -0700 (PDT)
Date: Sun, 25 May 2025 00:44:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6832ca5f.a70a0220.1765ec.015d.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_sock_get_channel
From: syzbot <syzbot+0a7039d5d9986ff4ecec@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    187899f4124a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5a0e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=770ccfad24d7220
dashboard link: https://syzkaller.appspot.com/bug?extid=0a7039d5d9986ff4ecec
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1648fe70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d14028020c58/disk-187899f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5416eb354254/vmlinux-187899f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02cbbb8d7877/Image-187899f4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a7039d5d9986ff4ecec@syzkaller.appspotmail.com

===================================
==================================================================
BUG: KASAN: slab-use-after-free in hci_sock_get_channel+0x60/0x68 net/bluetooth/hci_sock.c:91
Read of size 2 at addr ffff0000c48885b2 by task syz.4.334/7318

CPU: 0 UID: 0 PID: 7318 Comm: syz.4.334 Not tainted 6.15.0-rc7-syzkaller-g187899f4124a #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x254 mm/kasan/report.c:408
 print_report+0x68/0x84 mm/kasan/report.c:521
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 __asan_report_load2_noabort+0x20/0x2c mm/kasan/report_generic.c:379
 hci_sock_get_channel+0x60/0x68 net/bluetooth/hci_sock.c:91
 mgmt_pending_find+0x7c/0x140 net/bluetooth/mgmt_util.c:223
 pending_find net/bluetooth/mgmt.c:947 [inline]
 remove_adv_monitor+0x44/0x1a4 net/bluetooth/mgmt.c:5445
 hci_mgmt_cmd+0x780/0xc00 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x544/0xbb0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x25c/0x378 net/socket.c:1131
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x62c/0x97c fs/read_write.c:684
 ksys_write+0x120/0x210 fs/read_write.c:736
 __do_sys_write fs/read_write.c:747 [inline]
 __se_sys_write fs/read_write.c:744 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:744
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 7037:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2fc/0x4c8 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0xc4/0x1f0 net/core/sock.c:2198
 sk_alloc+0x44/0x3ac net/core/sock.c:2254
 bt_sock_alloc+0x4c/0x300 net/bluetooth/af_bluetooth.c:148
 hci_sock_create+0xa8/0x194 net/bluetooth/hci_sock.c:2202
 bt_sock_create+0x14c/0x24c net/bluetooth/af_bluetooth.c:132
 __sock_create+0x43c/0x91c net/socket.c:1541
 sock_create net/socket.c:1599 [inline]
 __sys_socket_create net/socket.c:1636 [inline]
 __sys_socket+0xd4/0x1c0 net/socket.c:1683
 __do_sys_socket net/socket.c:1697 [inline]
 __se_sys_socket net/socket.c:1695 [inline]
 __arm64_sys_socket+0x7c/0x94 net/socket.c:1695
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Freed by task 6607:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x68/0x88 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x17c/0x474 mm/slub.c:4841
 sk_prot_free net/core/sock.c:2237 [inline]
 __sk_destruct+0x4f4/0x760 net/core/sock.c:2332
 sk_destruct net/core/sock.c:2360 [inline]
 __sk_free+0x320/0x430 net/core/sock.c:2371
 sk_free+0x60/0xc8 net/core/sock.c:2382
 sock_put include/net/sock.h:1944 [inline]
 mgmt_pending_free+0x88/0x118 net/bluetooth/mgmt_util.c:290
 mgmt_pending_remove+0xec/0x104 net/bluetooth/mgmt_util.c:298
 mgmt_set_powered_complete+0x418/0x5cc net/bluetooth/mgmt.c:1355
 hci_cmd_sync_work+0x204/0x33c net/bluetooth/hci_sync.c:334
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

The buggy address belongs to the object at ffff0000c4888000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1458 bytes inside of
 freed 2048-byte region [ffff0000c4888000, ffff0000c4888800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x104888
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0002000 fffffdffc3279400 0000000000000002
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0002000 fffffdffc3279400 0000000000000002
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc3122201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c4888480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c4888500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c4888580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff0000c4888600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c4888680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Unable to handle kernel paging request at virtual address dfff8000000000b6
KASAN: null-ptr-deref in range [0x00000000000005b0-0x00000000000005b7]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff8000000000b6] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 7318 Comm: syz.4.334 Tainted: G    B               6.15.0-rc7-syzkaller-g187899f4124a #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hci_sock_get_channel+0x28/0x68 net/bluetooth/hci_sock.c:91
lr : hci_sock_get_channel+0x18/0x68 net/bluetooth/hci_sock.c:90
sp : ffff80009f3477a0
x29: ffff80009f3477a0 x28: 0000000000000000 x27: ffff80008d84e588
x26: ffff0000d7944000 x25: 0000000000000002 x24: dfff800000000000
x23: ffff0000c2586528 x22: 000000000000000d x21: 0000000000000003
x20: ffff0000c2586500 x19: 0000000000000000 x18: 1fffe0003386aa76
x17: 0000000000000000 x16: ffff80008ad27e48 x15: 0000000000000001
x14: 1ffff00012553cfc x13: 0000000000000000 x12: 0000000000000000
x11: ffff700012553cfd x10: dfff800000000000 x9 : 00000000000000b6
x8 : 00000000000005b2 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009f347018 x4 : ffff80008f415ba0 x3 : ffff80008a076e80
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 hci_sock_get_channel+0x28/0x68 net/bluetooth/hci_sock.c:91 (P)
 mgmt_pending_find+0x7c/0x140 net/bluetooth/mgmt_util.c:223
 pending_find net/bluetooth/mgmt.c:947 [inline]
 remove_adv_monitor+0x44/0x1a4 net/bluetooth/mgmt.c:5445
 hci_mgmt_cmd+0x780/0xc00 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x544/0xbb0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x25c/0x378 net/socket.c:1131
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x62c/0x97c fs/read_write.c:684
 ksys_write+0x120/0x210 fs/read_write.c:736
 __do_sys_write fs/read_write.c:747 [inline]
 __se_sys_write fs/read_write.c:744 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:744
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 9116ca68 d2d0000a d343fd09 f2fbffea (38ea6929) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9116ca68 	add	x8, x19, #0x5b2
   4:	d2d0000a 	mov	x10, #0x800000000000        	// #140737488355328
   8:	d343fd09 	lsr	x9, x8, #3
   c:	f2fbffea 	movk	x10, #0xdfff, lsl #48
* 10:	38ea6929 	ldrsb	w9, [x9, x10] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
