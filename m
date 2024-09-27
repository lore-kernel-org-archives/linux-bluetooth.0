Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE839AD6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449829; cv=none; b=F/E6tjq2+efwiz5U9S+OEzeYkotSEunqIeSO4fhuZN6mdMrLS3OkGFAMe4PIWyTSP09ZUN1I/a9Uh364OXJX4sp0RR0ARqPz37t5cYf7tsp4H7vi9KQFp30n+i9iM2aXb3CgKVlbaq7urbqGJIDjgH3Odimwm+3RMnzNaIsd/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449829; c=relaxed/simple;
	bh=RU/ep/F0MfWF0KVpkBGYfIKFc/9cIaYiVqoNYrKALYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kSFVpMkwBb2TBK3AdUu5jsCOF6t/LxcOW0oPpTH9w89BNJ1ViKHCjqxeOLMmVhliIy9LoSqnOBFaJiAUMtu+KvvuoDli6y4ZBiX/GhcDoyOqEAkb0vm/a12Fa+UVH0mkLd8irVf7202RFkJiXxb+rVdFgn0HNi5pgNFy0NYPkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82d40afd0ddso240273139f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 08:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449827; x=1728054627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Us/krW6xEHQWPnvD7rWX/NAPA2lNNq7M6EfbHDhyKs4=;
        b=PCvoccLUv7ZZjQsHlr66++qLglhpuFoszzb47GwGS9nJ1Iyy9N+wSVj9oPa9EfEh/0
         0wXNV2zVTPKOhFW2gbtT2+xBWCaGTx4drhZmN/FvxcUkYu3ckpyt/oaCSsHv+mvWjh8D
         oTX4c3P3k09seIjaf4dodEaitZJrhvOjWlh2EoczM5kFhxKVKbaZDLx/Qcg2UbNUeNBP
         9GFaEU4Bw81LAgUR4dVWzSdvhZHhAcNdQ/scW110aWci+OEbXEGuzRjS7NIscmbJp3w2
         wEcgYkQzDUL1CA29q9/006+vuQ9vb6vbVk24nl87ftVb63ctHyPz2H4UqVFbVRw7c21l
         ROng==
X-Forwarded-Encrypted: i=1; AJvYcCURGIPHkY8/qTNcchlz2hJwJb2ji6b9f/x2PIU8mUvJKsJyUfqUE13PltavtFEMCcZsE5XRraLnSEm/wK63rjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dCPYeh3dj70noYqh0vdqwtmrz3F6TuV1UK+vt5jV9j3pWQKs
	oy2GCqcrL2PPJBEk50KiJqD0YkYiwl09qeV7GYbjrRmJSY/HQaXg+E2eYikq2ghnHUhdiRddPI0
	rGDNuH2CRQZdHRirIaOKGRHlANLv2Hu9h1ox1zk0AaFcbqyPyVq3f6XI=
X-Google-Smtp-Source: AGHT+IGKqNJez0CVrkIdg15a7qO+Pj5FU8hpIFvegftscbpIqV4KFYZE29D3ayoiuGHz0Acl74EbXpnQP5IeiwvI5iiN40iBWpVk
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:39f:558a:e404 with SMTP id
 e9e14a558f8ab-3a34516039bmr36325895ab.4.1727449826766; Fri, 27 Sep 2024
 08:10:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6cae2.050a0220.46d20.001f.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in mgmt_device_connected
From: syzbot <syzbot+ea704362ec2bbf4ddcca@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1201531f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=ea704362ec2bbf4ddcca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df54f4a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f4a1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea704362ec2bbf4ddcca@syzkaller.appspotmail.com

Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
BUG: KASAN: slab-use-after-free in mgmt_device_connected+0x48/0x524 net/bluetooth/mgmt.c:9650
Write of size 8 at addr ffff0000fa89c838 by task kworker/u9:2/6409

CPU: 0 UID: 0 PID: 6409 Comm: kworker/u9:2 Not tainted 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci3 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 kasan_check_range+0x268/0x2a8 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
 mgmt_device_connected+0x48/0x524 net/bluetooth/mgmt.c:9650
 l2cap_connect_req net/bluetooth/l2cap_core.c:4077 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0x1324/0xc914 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x4ac/0x15f0 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3785 [inline]
 hci_rx_work+0x2b8/0xa80 net/bluetooth/hci_core.c:4022
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 6409:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x244/0x374 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 __hci_conn_add+0x25c/0x13cc net/bluetooth/hci_conn.c:934
 hci_conn_add_unset+0x78/0xf8 net/bluetooth/hci_conn.c:1043
 hci_conn_request_evt+0x4fc/0xb08 net/bluetooth/hci_event.c:3288
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x8dc/0x106c net/bluetooth/hci_event.c:7498
 hci_rx_work+0x318/0xa80 net/bluetooth/hci_core.c:4017
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Freed by task 6412:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:579
 poison_slab_object+0x128/0x180 mm/kasan/common.c:240
 __kasan_slab_free+0x3c/0x70 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x154/0x3e0 mm/slub.c:4594
 bt_link_release+0x20/0x30 net/bluetooth/hci_sysfs.c:16
 device_release+0x8c/0x1ac
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 put_device drivers/base/core.c:3790 [inline]
 device_unregister+0x3c/0xcc drivers/base/core.c:3913
 hci_conn_del_sysfs+0xf0/0x170 net/bluetooth/hci_sysfs.c:86
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x72c/0xaa0 net/bluetooth/hci_conn.c:1162
 hci_conn_failed+0x244/0x350 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x500/0xbb0 net/bluetooth/hci_sync.c:5545
 abort_conn_sync+0x224/0x25c net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:328
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:551
 insert_work+0x54/0x2d4 kernel/workqueue.c:2185
 __queue_work+0xe20/0x1308 kernel/workqueue.c:2341
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2487
 call_timer_fn+0x1b4/0x8e8 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1838 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2447
 handle_softirqs+0x2e4/0xbfc kernel/softirq.c:554
 __do_softirq+0x14/0x20 kernel/softirq.c:588

The buggy address belongs to the object at ffff0000fa89c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2104 bytes inside of
 freed 8192-byte region [ffff0000fa89c000, ffff0000fa89e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13a898
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 05ffc00000000040 ffff0000c0002280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 05ffc00000000040 ffff0000c0002280 dead000000000122 0000000000000000
head: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 05ffc00000000003 fffffdffc3ea2601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000fa89c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000fa89c780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000fa89c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff0000fa89c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000fa89c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Unable to handle kernel paging request at virtual address dfff800000000064
KASAN: null-ptr-deref in range [0x0000000000000320-0x0000000000000327]
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
[dfff800000000064] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6409 Comm: kworker/u9:2 Tainted: G    B              6.11.0-rc5-syzkaller-gdf54f4a16f82 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci3 hci_rx_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : l2cap_send_cmd+0x484/0x770 net/bluetooth/l2cap_core.c:964
lr : l2cap_send_cmd+0x478/0x770 net/bluetooth/l2cap_core.c:964
sp : ffff8000ab0c71a0
x29: ffff8000ab0c71c0 x28: dfff800000000000 x27: ffff0000ccc2c90e
x26: ffff0000ccc2c90c x25: 0000000000000010 x24: 0000000000000000
x23: ffff0000ce726010 x22: ffff0000c8eec000 x21: 0000000000000322
x20: ffff0000c5fd7640 x19: ffff0000ce726000 x18: 1fffe00036799fe6
x17: ffff80008a4ba0fc x16: ffff800080a863f4 x15: 0000000000000001
x14: 1fffe00019985922 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000100000 x10: 0000000000032ad3 x9 : ffff800093f02100
x8 : 0000000000000064 x7 : 0000000200090000 x6 : 0000000200090000
x5 : ffff0000ccc2c918 x4 : ffff8000ab0c7888 x3 : ffff80008a4ab374
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 l2cap_send_cmd+0x484/0x770 net/bluetooth/l2cap_core.c:964
 l2cap_connect net/bluetooth/l2cap_core.c:4034 [inline]
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0x25c8/0xc914 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x4ac/0x15f0 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3785 [inline]
 hci_rx_work+0x2b8/0xa80 net/bluetooth/hci_core.c:4022
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 9769fc8a f94002a8 910c8915 d343fea8 (38fc6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9769fc8a 	bl	0xfffffffffda7f228
   4:	f94002a8 	ldr	x8, [x21]
   8:	910c8915 	add	x21, x8, #0x322
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38fc6908 	ldrsb	w8, [x8, x28] <-- trapping instruction


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
