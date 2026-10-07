Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C91397
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340593; cv=none; b=hk2aguj2kUAz3yaBRWMPQGjpl+lsvw0gCTMbqJHnzHyxib16lLEZuI6XNRf3PCZbqmvpK9Q0WIooEQFzz4HYmBJ2/8hr6qPm1J+0rtdNf+Z3NrEfcALwyaK8sLc4psy/7SKy/9zT6wqhG4JaIuN5Nz4mTUZwiXzY10WYZlh1chU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340593; c=relaxed/simple;
	bh=hdN9Mvek8+9pJSrUMa+ORA3mcToX2aU5HpCB0qIkr1M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vCXMj4yi1SZE4XFXGxIrcrwwclwhutZ3YTC9SzCoLNa2O2lOKIn9Lryg/A02jOLEW3TOX2Izk7ESxMGlo8N7atPUjCjkhj9CUebVnBvq5z8Q2XITsJ//Gb8Q3h4U0XIDku3UYVnzZ+g2kFJ4kTHIGpgYm2IafDH+VVjzjGcpky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e937c5bd4fso3781063b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 19:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791340591; x=1791945391;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LP1HBNlbf2Dk4SvVDnqVQLNDZx/0CklhdALXJ1A79Jc=;
        b=KDKy/bXFTDKlbF6JaPvw+62fyySVMRbexwO79JMa+Cmh68TOTbBjvS3rpi9XLpEXpD
         DF3soAuB2DMAhFFEMqFKvx9Y2g+nAZvbYk75oiHGnky1Hkg+1Jo4GtsUwpotHJV3/4kn
         u16JVpUvPt0eSs34yALjEUjqYl4pDzp84IgF2w4CtGfledGMbcjc/WRonmOKhqcsNIyI
         /NielCwj6c+CgfEPAuzky8NujaFvxzMRWZMJZj+3lDxHvuiRrJ0HSnKSo68fvJ6COzYV
         BEZruJN4iGwNp957KKAcEI14djmT0m1WFkS89u69tVYyfN3hJILbf3+YTFRpJ158tva3
         KNzA==
X-Gm-Message-State: AFuF++l8iS7p2lFak5Mo6oNxdeKczfOTldsxoIf/rueckw6bOwgH8Q5Q
	ICaXqjMaYc0TR8Pm8OxwyYo2wEHvNhwphqWwXMFKNqY9+OZyr35FmTQrxZuElyxsTHUXVfWgG2s
	yzwYLdbzM6PeChjKr4W1ihtJazLj4QfkkVJn5jawGNiKhlwlUcCGIn4wA8sI=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a3:b0:4b3:98f4:f057 with SMTP id
 5614622812f47-4fc436fb3c3mr1295934b6e.3.1791340590785; Tue, 06 Oct 2026
 19:36:30 -0700 (PDT)
Date: Tue, 06 Oct 2026 19:36:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac5b02e.fe639fcc.32b100.000f.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mesh_send_sync
From: syzbot <syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b7cab693ba2 Merge tag 'block-7.3-20261002' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16041bf5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc812281b37d1115
dashboard link: https://syzkaller.appspot.com/bug?extid=f20755f37da70df33a16
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a71725580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3b7cab69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c13a12e5eec3/vmlinux-3b7cab69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69dc984f3177/bzImage-3b7cab69.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mesh_send_sync+0x3de/0x440 net/bluetooth/mgmt.c:2338
Read of size 1 at addr ffff88804e2ea83b by task kworker/u34:4/5875

CPU: 1 UID: 0 PID: 5875 Comm: kworker/u34:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 mesh_send_sync+0x3de/0x440 net/bluetooth/mgmt.c:2338
 hci_cmd_sync_work+0x1b6/0x4c0 net/bluetooth/hci_sync.c:336
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6185:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 mgmt_mesh_add+0x54/0x410 net/bluetooth/mgmt_util.c:413
 mesh_send+0x2b4/0x770 net/bluetooth/mgmt.c:2531
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1730 [inline]
 hci_sock_sendmsg+0x1574/0x26a0 net/bluetooth/hci_sock.c:1850
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __ia32_sys_sendto+0xdd/0x1b0 net/socket.c:2284
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 5875:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6802
 mesh_send_complete net/bluetooth/mgmt.c:1090 [inline]
 mesh_send_start_complete+0x1a1/0x210 net/bluetooth/mgmt.c:2314
 hci_cmd_sync_work+0x20a/0x4c0 net/bluetooth/hci_sync.c:338
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88804e2ea800
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 59 bytes inside of
 freed 96-byte region [ffff88804e2ea800, ffff88804e2ea860)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4e2ea
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801c042280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 144, tgid 144 (kworker/u33:5), ts 10148467167
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 lsm_blob_alloc+0x68/0x90 security/security.c:218
 lsm_task_alloc security/security.c:270 [inline]
 security_task_alloc+0x2a/0x260 security/security.c:2785
 copy_process+0x2c11/0x8380 kernel/fork.c:2293
 kernel_clone+0x176/0x9d0 kernel/fork.c:2771
 user_mode_thread+0xd1/0x120 kernel/fork.c:2848
 call_usermodehelper_exec_work kernel/umh.c:169 [inline]
 call_usermodehelper_exec_work+0xcb/0x180 kernel/umh.c:155
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88804e2ea700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88804e2ea780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88804e2ea800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                        ^
 ffff88804e2ea880: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88804e2ea900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


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
