Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E91A08A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777733; cv=none; b=fYq8uE2P2yPXoE7Vug0gZA4AaXFYhiX8dD13cq/a7ep6kMXVP3CB5Bc40e4JY6736WFBXENyTKyK9UH7WSeGGg0zweSfercMmLWHMgDOa7KYeVzuvVNEh/fTILi/0+fNMy+MyT43pA7x3nM/amZ+8IYfXLC4fyAabJY+PhTYmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777733; c=relaxed/simple;
	bh=lc/E+luZd1F0MNzXV7BZPZja1beqMPB1l595a90Ds9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q/VBA+TPxQLXvXnThOf4EnoBb0OReSStP7Gh/1Gg7d/tN1H8ANgtoOBT2+P03JbP4THiMNhi8yJ8IJbGvd5Jg9S4iHPQj+FUilqJ20/CCDyLi7U6pzilVqPzl2dOSX3ZRfp27oQReH8iytWzccL0PAW0elYRk15j6gC2LISXUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so50003585ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727777728; x=1728382528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptr5r2SpkMbHm5MxrAOzGN6piib9APQNVGMdCf7EpM8=;
        b=OVKUmRE8Hgd8kvxTp2TQOqiYvYBUCokScDpc/b7ARsiOwd03gbmQI/lXJtMZFJDY7w
         e4j70kz49v95YXHI/SIxSzWvDd9H5D3o1z6U1Hq/OXSKfhPiy4Tdvqb16vUidwLHDFqA
         pSK2Bi/9y3nOcDqeW//InFxC8Vhp9Nlnfquh7Qb56RIKaQkwIRdfMNqzpJoL+lYULtJ7
         ipEtzxC6ySXUJPsHBOuyN5dD8q0EBlugRLaQ0MubjeCrsDW8lzLHVlaJ4SwyxXKNPysb
         Ghdk4htpk6kDfsBM0se9OtxbDVNdmNhB1ZuexGNRqV95osvC034eryhfOZsAVsmvlDKy
         1viA==
X-Forwarded-Encrypted: i=1; AJvYcCXIrEKJzJcE20HSo093s2TcF5CufCtq8soSWzSaGYT77H4CHJxJPLkRM1RBcdepdcWOBbRELTzxLQuewN6rdrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmgzy8oMaKttSDCmmNiGRBxUbJnDJYUPUl3fywbd3QcF1whasD
	egpLT4Ut59o6t4ypnnS+nAlVal4E62p652FVqy+qtJNkiqfuGqES/PynuoS77zikV5PzScXl0kQ
	kRwXVsAp/H9JXIUI8nZozAyDcjgJ2Pl5RrHOiog/DSJgIsZQ6FrfCLzU=
X-Google-Smtp-Source: AGHT+IEfma8UNMcsxL0kSSN3RDomzWpJaEIsamZceUEnGiKsmdDamfYeVA7XXNhO1RkEkP4wr2wIS59EDAAMAWCrMLpxFgl7M/2N
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:3a0:cc84:9859 with SMTP id
 e9e14a558f8ab-3a35eb6177fmr18980275ab.10.1727777728417; Tue, 01 Oct 2024
 03:15:28 -0700 (PDT)
Date: Tue, 01 Oct 2024 03:15:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbcbc0.050a0220.6bad9.0058.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_sock_ready_cb (2)
From: syzbot <syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12881980580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com

kobject: kobject_add_internal failed for hci0:201 with -EEXIST, don't try to register things with the same name in the same directory.
Bluetooth: hci0: failed to register connection device
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_sock_ready_cb+0xc4/0x130 net/bluetooth/l2cap_sock.c:1670
Read of size 8 at addr ffff0000da74b188 by task kworker/u9:6/6425

CPU: 0 UID: 0 PID: 6425 Comm: kworker/u9:6 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 l2cap_sock_ready_cb+0xc4/0x130 net/bluetooth/l2cap_sock.c:1670
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1256 [inline]
 l2cap_le_start+0xa6c/0x1384 net/bluetooth/l2cap_core.c:1368
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1624 [inline]
 l2cap_connect_cfm+0x57c/0xe24 net/bluetooth/l2cap_core.c:7286
 hci_connect_cfm+0xa0/0x13c include/net/bluetooth/hci_core.h:1960
 le_conn_complete_evt+0xa1c/0xf0c net/bluetooth/hci_event.c:5761
 hci_le_conn_complete_evt+0x114/0x404 net/bluetooth/hci_event.c:5787
 hci_le_meta_evt+0x2a4/0x478 net/bluetooth/hci_event.c:7135
 hci_event_func net/bluetooth/hci_event.c:7443 [inline]
 hci_event_packet+0x890/0x106c net/bluetooth/hci_event.c:7498
 hci_rx_work+0x318/0xa80 net/bluetooth/hci_core.c:4023
 process_one_work+0x79c/0x15b8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x978/0xec4 kernel/workqueue.c:3389
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 6795:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:565
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_noprof+0x2a4/0x498 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 sk_prot_alloc+0xc4/0x1f0 net/core/sock.c:2096
 sk_alloc+0x44/0x3f0 net/core/sock.c:2149
 bt_sock_alloc+0x4c/0x304 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1877 [inline]
 l2cap_sock_create+0x140/0x2b8 net/bluetooth/l2cap_sock.c:1917
 bt_sock_create+0x14c/0x248 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x43c/0x884 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x134/0x340 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __arm64_sys_socket+0x7c/0x94 net/socket.c:1718
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 6794:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:579
 poison_slab_object+0x128/0x180 mm/kasan/common.c:240
 __kasan_slab_free+0x3c/0x70 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x154/0x3e0 mm/slub.c:4598
 sk_prot_free net/core/sock.c:2132 [inline]
 __sk_destruct+0x4b8/0x74c net/core/sock.c:2224
 sk_destruct net/core/sock.c:2239 [inline]
 __sk_free+0x388/0x4f4 net/core/sock.c:2250
 sk_free+0x60/0xc8 net/core/sock.c:2261
 sock_put include/net/sock.h:1884 [inline]
 l2cap_sock_kill+0x12c/0x234 net/bluetooth/l2cap_sock.c:1250
 l2cap_sock_release+0x138/0x1b4 net/bluetooth/l2cap_sock.c:1421
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1421
 __fput+0x1bc/0x774 fs/file_table.c:422
 ____fput+0x20/0x30 fs/file_table.c:450
 task_work_run+0x230/0x2e0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000da74b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 392 bytes inside of
 freed 2048-byte region [ffff0000da74b000, ffff0000da74b800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000da74e000 pfn:0x11a748
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 05ffc00000000240 ffff0000c0002000 fffffdffc369c610 fffffdffc3093810
raw: ffff0000da74e000 0000000000080006 00000001fdffffff 0000000000000000
head: 05ffc00000000240 ffff0000c0002000 fffffdffc369c610 fffffdffc3093810
head: ffff0000da74e000 0000000000080006 00000001fdffffff 0000000000000000
head: 05ffc00000000003 fffffdffc369d201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000da74b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000da74b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000da74b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff0000da74b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000da74b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
