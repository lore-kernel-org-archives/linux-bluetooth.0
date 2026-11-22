Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795322978;
	b=crvB1XIbR++FUBfasAbHh+b6aHoXXY+pt4FtkxcJ9cuRiuMValEntVCkk5w6MdUIgb++
	 d+u2+u8HvD0aCOlF0B06bZlcGPCIOgWw119h2Q8mGXlHI6MhONLx9B4n826HF4Nt5xqQS
	 uulNUPdHeuhv523YXt4XVBod3V9VcJGatVmeQ+XJmgoEWTuCh0T3XHxWbPGynZjqr4SFD
	 a2b5is4gnmJ5MT828XohSiEMzmdeprrg8+JkOrB1BKjiBStbn/pz7GaiTD7u0kTSjOAVX
	 phP1dvMJQdm2XB9NYUa7CJAdMV+XcyRnhSYs5vsvM4ycFGWdAt50IPwEhRo779bzFcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795322978;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=o8BTl0u5Z65NjasTby1WfYBPwX0u2iS9ELdyH+h0w+U=;
	b=j+GwutmuOA2PgxR24pwW1i08jypWrIuy87wozpFrmmO5E1Z1IYWkNQoq3ViWer+P5LT6
	 rdY6v270JjyqiCjg5uZZbbhdAA8Hq6CLhRS04GO3kfmfzucEZfrP5xdLS4uDrNPLV6R1h
	 0pODDP5EdARk0G2gbUV1AHGN6lbhQyDptyK8VgFDA/zbQsEk2I77T6aqRAD+6Piq+8Ogo
	 1LECBTyAI3dthJaHqZFc9XruxP1mc5aTiOy7griq+L6Q1nDRgcg+9pQvvekCMiSq2HPmn
	 Hvy1bcQdtVRXjjHqKJ+LMkqUUi+VgvernWk2G4411Fx/pbkJqvDAvhzYxzZIspFSY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A570606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 04:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A570606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-574f8578e48so2202857b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 20:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795322977; x=1795927777;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8BTl0u5Z65NjasTby1WfYBPwX0u2iS9ELdyH+h0w+U=;
        b=S/eYGUmfyQApktz76VMRYrEcLN5I8A+PamIZcFCW+Ax7hr73XZzwT41eIeBb1oPYDf
         RknqTNB9YXykpzli8XyDuIDTk60lz0BzOJNbA6BJnk2JHOEDcE0Af6Z3l/gx7EtiDZq1
         u7QRzTO8L63+kMQxn3w5+ownu2F1whrIHdWsygHMtyJyxkvNOVxd9fn33WTkkP727rnx
         fB8daAPSznAJXHimeCEiFI8PLdfhVVwRk3dFZ8MPABNa6OpnSnuHMZCTgWWbDDJkSttn
         678607QrTB3uRYbQ29wFGjNf7sxgbHlWOyPdv4rNleobks8c6CfGafdLnIbkOmWOPvpc
         sJbQ==
X-Forwarded-Encrypted: i=1; AL+hErEHR1bJu6W7kL89VA/NLcZMS7mnDEQAZ9rA/Y0XVWoUIPXy8kNcM1iB4/t9v/Zo7SROmgP5WnRq3wNohiwmupI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vbh87dwrb7C+pG6TRdb21x1HVrBRehS7fsEJFI0coRsCCXLb/
	dezDEn0ajpTwN55UW/62w3/Tp+l2ZsqlrvxWFloVAWlNEN0KUK3qduxPj/9bpAnAJLfyC4jttGO
	4nxtI4rpgcNgZ1mB6Er/Hk7gSREQZkG60lTjkzFhBIYlM73GOBRNoQeVr2dI=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3cb:b0:574:93c0:5ae7 with SMTP id
 5614622812f47-57a09c11006mr8025631b6e.12.1795322977195; Sat, 21 Nov 2026
 20:49:37 -0800 (PST)
Date: Sat, 21 Nov 2026 20:49:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b027461.6ccd1e40.868ea.001d.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in rfcomm_dev_ioctl
From: syzbot <syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com>
To: gianluca@sottospazio.it, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	nicoyip.dev@gmail.com, syzkaller-bugs@googlegroups.com, tim.bird@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    909ef7a9a30f Add linux-next specific files for 20261120
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2b363580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b48986f5941b1488
dashboard link: https://syzkaller.appspot.com/bug?extid=11542ff1d167fdffa1fc
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bff3b272c5e1/disk-909ef7a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6fffa0ba5f/vmlinux-909ef7a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4ad60d5f27d/bzImage-909ef7a9.xz

The issue was bisected by AI to:

commit 5b899241874dcc1a2b932a668731c80a3a869575
Author: Gianluca Anzolin <gianluca@sottospazio.it>
Date:   Mon Jan 6 20:23:50 2014 +0000

    Bluetooth: Release RFCOMM port when the last user closes the TTY

AI reasoning:   https://syzkaller.appspot.com/ai_job?id=0137c921-439f-477e-b601-4d5010191e08

AI-generated root cause summary:
In net/bluetooth/rfcomm/tty.c, __rfcomm_dev_add() publishes a newly allocated
struct rfcomm_dev in rfcomm_dev_list and releases rfcomm_dev_lock while holding
only the initial port reference (refcount 1), without taking a reference for
rfcomm_dev_add() to finish registration. When RFCOMM_RELEASE_ONHUP is set, a
concurrent task can open and close the RFCOMM TTY device during or right after
tty_port_register_device(), causing rfcomm_tty_install() to take ownership of
that single reference and release_one_tty() -> rfcomm_tty_cleanup() ->
tty_port_put() -> rfcomm_dev_destruct() to free dev. rfcomm_dev_add() then
performs a slab-use-after-free write to dev->tty_dev (offset 992) and continues
accessing the freed rfcomm_dev.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=11542ff1d167fdffa1fc

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com

The cause commit was identified by AI and may be wrong.
If you agree with it, please also add:
Fixes: 5b899241874d ("Bluetooth: Release RFCOMM port when the last user closes the TTY")

==================================================================
BUG: KASAN: slab-use-after-free in rfcomm_dev_add net/bluetooth/rfcomm/tty.c:335 [inline]
BUG: KASAN: slab-use-after-free in __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
BUG: KASAN: slab-use-after-free in rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
BUG: KASAN: slab-use-after-free in rfcomm_dev_ioctl+0x1b9f/0x21b0 net/bluetooth/rfcomm/tty.c:576
Write of size 8 at addr ffff888029b7c3e0 by task syz.8.3942/18018

CPU: 0 UID: 0 PID: 18018 Comm: syz.8.3942 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 rfcomm_dev_add net/bluetooth/rfcomm/tty.c:335 [inline]
 __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
 rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
 rfcomm_dev_ioctl+0x1b9f/0x21b0 net/bluetooth/rfcomm/tty.c:576
 sock_do_ioctl+0x101/0x320 net/socket.c:1328
 sock_ioctl+0x57a/0x7e0 net/socket.c:1449
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:604 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:590
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007f28193a9559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f281a25d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2819625fa0 RCX: 00007f28193a9559
RDX: 0000200000000040 RSI: 00000000400452c8 RDI: 0000000000000004
RBP: 00007f2819438136 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2819626038 R14: 00007f2819625fa0 R15: 00007ffd396b8528
 </TASK>

Allocated by task 18018:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 poison_kmalloc_redzone mm/kasan/common.c:412 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:267 [inline]
 __kmalloc_cache_noprof+0x31c/0x610 mm/slub.c:5718
 _kmalloc_noprof include/linux/slab.h:984 [inline]
 _kzalloc_noprof include/linux/slab.h:1305 [inline]
 __rfcomm_dev_add net/bluetooth/rfcomm/tty.c:221 [inline]
 rfcomm_dev_add net/bluetooth/rfcomm/tty.c:322 [inline]
 __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:421 [inline]
 rfcomm_create_dev net/bluetooth/rfcomm/tty.c:477 [inline]
 rfcomm_dev_ioctl+0xc11/0x21b0 net/bluetooth/rfcomm/tty.c:576
 sock_do_ioctl+0x101/0x320 net/socket.c:1328
 sock_ioctl+0x57a/0x7e0 net/socket.c:1449
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:604 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:590
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 11:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:599
 poison_slab_object mm/kasan/common.c:267 [inline]
 __kasan_slab_free+0x70/0x90 mm/kasan/common.c:299
 kasan_slab_free include/linux/kasan.h:239 [inline]
 slab_free_hook mm/slub.c:2807 [inline]
 slab_free mm/slub.c:6672 [inline]
 kfree+0x1c7/0x650 mm/slub.c:6982
 rfcomm_dev_destruct+0x25c/0x300 net/bluetooth/rfcomm/tty.c:99
 release_one_tty+0xb4/0x280 drivers/tty/tty_io.c:1497
 process_one_work kernel/workqueue.c:3511 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3594
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3675
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888029b7c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 992 bytes inside of
 freed 2048-byte region [ffff888029b7c000, ffff888029b7c800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29b78
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c842000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801c842000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 150, tgid 150 (kworker/u8:6), ts 6692506745
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1872
 prep_new_page+0x22/0xb0 mm/page_alloc.c:1880
 get_page_from_freelist+0x2487/0x24f0 mm/page_alloc.c:3970
 __alloc_frozen_pages_noprof+0x211/0x450 mm/page_alloc.c:5512
 alloc_slab_page mm/slub.c:3423 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3538
 new_slab mm/slub.c:3589 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7578
 refill_sheaf mm/slub.c:2953 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4849
 alloc_from_pcs mm/slub.c:4925 [inline]
 slab_alloc_node mm/slub.c:5059 [inline]
 __do_kmalloc_node mm/slub.c:5568 [inline]
 __kmalloc_noprof+0x47e/0x720 mm/slub.c:5594
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1305 [inline]
 scsi_alloc_target+0x138/0xb70 drivers/scsi/scsi_scan.c:505
 __scsi_scan_target+0xff/0xd50 drivers/scsi/scsi_scan.c:1895
 scsi_scan_channel drivers/scsi/scsi_scan.c:2003 [inline]
 scsi_scan_host_selected+0x391/0x6c0 drivers/scsi/scsi_scan.c:2032
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2165 [inline]
 do_scan_async+0x10e/0x660 drivers/scsi/scsi_scan.c:2175
 async_run_entry_fn+0x9d/0x450 kernel/async.c:123
 process_one_work kernel/workqueue.c:3511 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3594
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3675
 kthread+0x38b/0x480 kernel/kthread.c:436
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888029b7c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029b7c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029b7c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888029b7c400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029b7c480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about AI bisection see: https://goo.gl/tpsmEJ#ai-bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
