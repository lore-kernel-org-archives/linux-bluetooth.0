Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2B13B7A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886645; cv=none; b=H28mvk6a6z3+oK8zxRSJ5uBGMXFc3pjoarpcHx4clNjGQyx7tEred1Ym5d5FPdXgdHBA4tXUSn905qCSifn+J2EFxJacgX8t5KOhh+Cyts/uxF3UsfDjqCUwyjsLgJqGL7F24k+/tKXxyT5XmjKKppMIdeqZy6OlVUrTZ8K/GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886645; c=relaxed/simple;
	bh=yzYrnvhSk8yZNw+x1xXu75XgM69f8ROO7GyY3agUkRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F3+fDXFQh5Ioq3j0gaEBNPbcdncyo1K3sINQL0K7BoHjaklKO3rWzgyZIr0qKSWDhZAoFWnDAi/pmQYzH2L1/Dq56fQD2xj/LXHu/zpozQ1onuS1790kXmXpy8ORR507i0RMIkLOPm+6Niwh2j7FNoztaYobTzWX2E7dlhwoLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so12296515ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 23:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886643; x=1729491443;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKSheJBeO2nONcWEgh9liFihVD7ld9gg3ti1TDkaXAQ=;
        b=Bg2JvCddYf/4yEAgURMCvY3bL5uVDocQ1mAjVtd8JeJGPbIQGOFlR9sinlqbl4dHne
         ia7hycPHnjohepwfRJDDUCYbDdskQfGagmI/Z9PD5DPxvfuvz2T+gIqRUh9nvN/ecRxy
         syu67RHQxsSHWkRD9R6e8xw6VNB0yNARoZQ5UBvUlhov4ZKM0nFaBSZk/iNQSPu2r9X4
         hrdwCNcu2ykGLwM7/fJCaeQyNuFiFudyi5HaKhyZ1aIhRg710Tx3IKO+zSObH4azQRKn
         KIo6hlUQHdTrvyZSkQpQhR57+s7J5VokupDqPOA4CfiEicww3r6vSAzszGix6u1TfuDq
         gWDg==
X-Forwarded-Encrypted: i=1; AJvYcCVRW1Baz0VO/oPaMB8GgO9aFGFtBpEYO8i9d4B/cVB3xMTtqZMzm04KPiHGspRFMSV8/2i6O+iXcuzzTbF/9QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzdYpAAXF8CTaysxGyOjDCKmmNYCx+Gn0zZtY6CEWfx4xgf4T
	O5lYvuv5Mk6deQFyU3bxr2bSmPDjDIhcyF5wUEIKOYnwOwss0B9AA4EyYFnvluyDsbrl8G8B82b
	xravLSvRz1n90QqQ5tJ+x7tRbaosLOthgTjKFh8BiryX/mtnehaBjNyk=
X-Google-Smtp-Source: AGHT+IEtZm32dMwNFUgK9OCYRzLs3aEkZmxcb33gSbSE+thXbkrHrEdHL3m01NClVZY2tVXhqo8JTGr0ws/h0DbVFk8+FJIb67jp
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8c:0:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a3b5f287dbmr64322125ab.6.1728886642844; Sun, 13 Oct 2024
 23:17:22 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:17:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb772.050a0220.3e960.0057.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_req_cmd_complete
From: syzbot <syzbot+2615eb80cf127508089a@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10117380580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
dashboard link: https://syzkaller.appspot.com/bug?extid=2615eb80cf127508089a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbcdc0af26ea/disk-fc20a3e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cc74223e92f/vmlinux-fc20a3e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad8cbbe121b2/bzImage-fc20a3e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2615eb80cf127508089a@syzkaller.appspotmail.com

Bluetooth: hci6: unexpected cc 0x1003 length: 249 > 9
Bluetooth: hci6: unexpected cc 0x1001 length: 249 > 9
Bluetooth: hci6: command 0x1005 tx timeout
==================================================================
BUG: KASAN: slab-use-after-free in hci_cmd_data net/bluetooth/hci_core.c:3107 [inline]
BUG: KASAN: slab-use-after-free in hci_sent_cmd_data net/bluetooth/hci_core.c:3124 [inline]
BUG: KASAN: slab-use-after-free in hci_req_cmd_complete+0x85e/0x9c0 net/bluetooth/hci_core.c:3920
Read of size 4 at addr ffff888065bb9930 by task kworker/u9:3/5229

CPU: 1 UID: 0 PID: 5229 Comm: kworker/u9:3 Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci6 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 hci_cmd_data net/bluetooth/hci_core.c:3107 [inline]
 hci_sent_cmd_data net/bluetooth/hci_core.c:3124 [inline]
 hci_req_cmd_complete+0x85e/0x9c0 net/bluetooth/hci_core.c:3920
 hci_cmd_complete_evt+0x51b/0x8b0 net/bluetooth/hci_event.c:4221
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0xa57/0x1540 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x3fe/0xd80 net/bluetooth/hci_core.c:4025
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5229:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 skb_clone+0x20c/0x390 net/core/skbuff.c:2084
 hci_send_cmd_sync net/bluetooth/hci_core.c:4058 [inline]
 hci_cmd_work+0xe7/0x6c0 net/bluetooth/hci_core.c:4094
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888065bb98c0
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 112 bytes inside of
 freed 240-byte region [ffff888065bb98c0, ffff888065bb99b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65bb9
memcg:ffff88802fbe5a01
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801e6d5000 ffffea0000bea0c0 dead000000000003
raw: 0000000000000000 00000000000c000c 00000001f5000000 ffff88802fbe5a01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 55, tgid 55 (kworker/u9:0), ts 138302256503, free_ts 138190182467
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 skb_clone+0x20c/0x390 net/core/skbuff.c:2084
 hci_event_packet+0x227/0x1540 net/bluetooth/hci_event.c:7461
 hci_rx_work+0x3fe/0xd80 net/bluetooth/hci_core.c:4025
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
page last free pid 5231 tgid 5231 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888065bb9800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888065bb9880: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>ffff888065bb9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888065bb9980: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888065bb9a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
