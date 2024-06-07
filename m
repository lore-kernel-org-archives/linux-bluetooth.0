Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90F155354
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800387; cv=none; b=XJrEA2q5NVWaEJKQwFmG+EG8Nc4gxVO6lKUphHLnQgmazbCMVXu973E8QTTX+/6jII6HRY1FZBzp+9uZgR3xNTAHmwwP5/OcSWlx5V2Bjq7J7fV4GhIX/p3JaOk30uUHETgAgezkdpM9BzyrPItg7R0WI3TaHkyAyBjSzKg2Uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800387; c=relaxed/simple;
	bh=Hg2aXzMkEDNkIG+fuJLdIaAQvRfVQxQaaw4wIhvnkRQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nLHrqOs4dUDWToleo/4OuhJEjzm0zCsNfm5bTuQGe6dd36Kjw4HLFw0PlFN2SWcaVr0v+GsaB5GoPXrEj4XKV38O6fpVY5yGjUVTO/itW4p9Y491TpVTVjTrPFGY6tFUB3nhbOuRPMJ6AJDbeRgVreneJ8qOyX9n+37rQWYQEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so306085139f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 15:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800385; x=1718405185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nu/HJFTDdg5B4W4eMaBSQujn0ZePmg/9rHnE1JagnM=;
        b=opgycOpVfN2VNIFCQaZDmi0fvKbYFM5/Y6y/Z7+eY8vij0sjAZr3OEm/gwYW0ilwX1
         80mYTP4y8cSIDMnnUzvvW6Gd2KniEqur3eyQmcHMQw2YVuIFQ9xkalJ9z1pBPGBwAPgd
         yg0ZZTJhFfjK9pjw97q+KmNmpkKYZ+Oy/UskoJLfdBjsavTPYLwjqnE3zTpnr0YIDssU
         NGfMKdxCRuHBLPP2K8nnGzckmGYN9MQyy8g9xTzfrgJA7KiY6PV/rnJzOm18f9Ct2oAE
         9edC1cJep1m8evJxQEyCp5i7LG/1CKlk9C+5Fyz2PxltKFe70wXZpG0DOlFVkOtSHfAn
         c43w==
X-Forwarded-Encrypted: i=1; AJvYcCXJzfrmH3mu5DihpTTczjR1mCeSvjwD5xqxr+7VaFTVK5l5V/puUUhc6vc7MsAhXWl96Wr3En9M2qMRy5QS9m3ng9znMkL8dCRDBTl+oW8A
X-Gm-Message-State: AOJu0YwuH9mWXkSOg8m/SFM2+xvI/13qW8hERfVMGFW0d9EVe1f63mf9
	Hrk86LhZWNbL7ddrbsNBpj6zd/ds1ZL9D39C8LyTWhGHASitzQST/pYckH+zE8nBx/C3q4lipfV
	y76sf/6mrQqHU+byzJ62TvdKmDVgq7Vro4TI49RhIappZUJc2jitzBk4=
X-Google-Smtp-Source: AGHT+IHJ7+d7g6tWVRrf4fUgCnwJOjb5//CUUtGdwokdWx5q0bJb79ffKJYmJEK+frPM6VrGbDoWufBaoVlOR9VgkoGxSAuNtd0C
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6416:b0:7e2:b00:2264 with SMTP id
 ca18e2360f4ac-7eb5725411fmr11942139f.2.1717800384596; Fri, 07 Jun 2024
 15:46:24 -0700 (PDT)
Date: Fri, 07 Jun 2024 15:46:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b81ce0061a54910a@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_req_sync_complete
From: syzbot <syzbot+275d418cae2e1a853717@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32f88d65f01b Merge tag 'linux_kselftest-fixes-6.10-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101f8474980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=275d418cae2e1a853717
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04303d59486c/disk-32f88d65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a4ffbd5434e/vmlinux-32f88d65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fd6a8ce84ec/bzImage-32f88d65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+275d418cae2e1a853717@syzkaller.appspotmail.com

Bluetooth: hci4: unexpected cc 0x1001 length: 249 > 9
Bluetooth: hci4: unexpected cc 0x0c23 length: 249 > 4
Bluetooth: hci4: unexpected cc 0x0c25 length: 249 > 3
Bluetooth: hci4: unexpected cc 0x0c38 length: 249 > 2
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1222 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1195 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x41/0x3b0 net/core/skbuff.c:1222
Read of size 4 at addr ffff888069060724 by task kworker/u9:2/5099

CPU: 0 PID: 5099 Comm: kworker/u9:2 Not tainted 6.10.0-rc2-syzkaller-00022-g32f88d65f01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci4 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1222 [inline]
 __kfree_skb_reason net/core/skbuff.c:1195 [inline]
 kfree_skb_reason+0x41/0x3b0 net/core/skbuff.c:1222
 kfree_skb include/linux/skbuff.h:1257 [inline]
 hci_req_sync_complete+0xe7/0x290 net/bluetooth/hci_request.c:109
 hci_event_packet+0xc71/0x1540 net/bluetooth/hci_event.c:7479
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4074
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5099:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4007
 skb_clone+0x20c/0x390 net/core/skbuff.c:2052
 hci_send_cmd_sync net/bluetooth/hci_core.c:4123 [inline]
 hci_cmd_work+0x29e/0x670 net/bluetooth/hci_core.c:4143
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 12074:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4511
 kfree_skb include/linux/skbuff.h:1257 [inline]
 __hci_req_sync+0x62f/0x950 net/bluetooth/hci_request.c:184
 hci_req_sync+0xa9/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x4c5/0xa50 net/bluetooth/hci_core.c:787
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888069060640
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff888069060640, ffff888069060730)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69060
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888018ae6780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4479, tgid 4479 (kworker/u9:1), ts 498722212871, free_ts 498178479206
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4043
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 mgmt_alloc_skb net/bluetooth/mgmt_util.c:64 [inline]
 mgmt_send_event+0x46/0x1a0 net/bluetooth/mgmt_util.c:116
 mgmt_index_event net/bluetooth/mgmt.c:326 [inline]
 mgmt_index_added+0x117/0x260 net/bluetooth/mgmt.c:9327
 hci_power_on+0x4a2/0x6b0
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page last free pid 5150 tgid 5150 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888069060600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888069060680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888069060700: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888069060780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888069060800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
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
