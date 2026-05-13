Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABE3D4119
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659964; cv=none; b=BrnJcMbdTSB6+mJPXs9mHPmZDb3bYcBg+e9/8wm6kgPOodUhScvFurEsLiVU9rZxj3/y+qBxe6wvRTkTkGEuxqPGvCBVEbLG9SZFvfS4SjGnbm2Eco8y5azT+/NFcYnQMLDvsFb+XFn9geVLWo4sq9pv2yQhCt1KHlrYVzoM9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659964; c=relaxed/simple;
	bh=RDK9pQBNPOR6O3xTKOEYo7tJBEe5cIT5qGvKxpF2uY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jBhBA/ozgAkv5Q2oeg8WJxP+SEQjy0zb0OY7DcLABYMZt8jAdzcDlcquTHt/bJ51yhkz2O9OwBqnurAanr+Io0xOX5HmqLFh/RZnXTdl5YK3+Tj4p2rWRaCVf/Hx+aBZFCyodmZMpxmDeU79/HtUeRzj5PYFvxGdpwxrUH+2ZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-42343e87c3aso6660190fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 01:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659953; x=1779264753;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30UNBm8o7O9Kwn8ZOLFdFlpOky8GaggEVtwu5zglG1I=;
        b=irAykCrHmfhSfGsHvAxQeCNkhLVIS6tlCBpyclNIQq1nQdSk0TEdbGOlZ7J5StNpTK
         WdGLR4+mijoACmybKwVUrDhIOiWyzF1H3un3wkyffb3T6Ajwr5vY93T2+zD1tegC5MNO
         lHjwZxOyZumcaoYKPlZ5Nov60Nl8qeno5xbZqA1vMme8BTHQwlN8ppjeL7revHWmWQsz
         R5RzvvCub9nd+q3FGtDitxCMd3sIW3UEZGgbr6n6RgGy3P66LA31u/CG5DfI2JZCkNwt
         +3/foD9M114z1AvhZhAkUbo33wvWAdN9hRTwUC640NYBugOZavXhTZXVcTcJ8Z5YLZcJ
         9vQw==
X-Gm-Message-State: AOJu0YzHyN3AxOTAaa8A8vHrdCrNwiYLGOkwL+okVOVdNGvMsLNmxhVL
	Rj/gNzVSKffDNssDpKRR2EL2tKhLz0ISQ0q3TKlg+4klurjgSn7JHPetitI3UqoVsjWmsHnyrzD
	xLgQU18F8VuDOaH/rDO/6HifyUGU4372MR4r/p1+dX/RkO8HIEtf2daWKDNcGMw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d49:b0:696:21ad:a4f0 with SMTP id
 006d021491bc7-69b78dd27acmr1148667eaf.36.1778659952951; Wed, 13 May 2026
 01:12:32 -0700 (PDT)
Date: Wed, 13 May 2026 01:12:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a043270.a00a0220.3890a0.0006.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_disconn_ind (3)
From: syzbot <syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1bfaee9d3351 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132d7e96580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=9c40ad7c6ed7165e46e8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5cda08ac5a6/disk-1bfaee9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aad7c1ec90c4/vmlinux-1bfaee9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a51d7d927815/bzImage-1bfaee9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_disconn_ind+0xd7/0xf0 net/bluetooth/l2cap_core.c:7430
Read of size 1 at addr ffff88807ee53278 by task kworker/u9:1/4933

CPU: 1 UID: 0 PID: 4933 Comm: kworker/u9:1 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: hci2 hci_conn_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 l2cap_disconn_ind+0xd7/0xf0 net/bluetooth/l2cap_core.c:7430
 hci_proto_disconn_ind include/net/bluetooth/hci_core.h:2115 [inline]
 hci_conn_timeout+0x1dc/0x230 net/bluetooth/hci_conn.c:646
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3466
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 16760:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 l2cap_conn_add.part.0+0x60/0xb00 net/bluetooth/l2cap_core.c:7001
 l2cap_conn_add include/net/bluetooth/l2cap.h:840 [inline]
 l2cap_chan_connect+0x1435/0x1f90 net/bluetooth/l2cap_core.c:7192
 l2cap_sock_connect+0x37a/0x770 net/bluetooth/l2cap_sock.c:256
 __sys_connect_file+0x141/0x1a0 net/socket.c:2148
 __sys_connect+0x141/0x170 net/socket.c:2167
 __do_sys_connect net/socket.c:2173 [inline]
 __se_sys_connect net/socket.c:2170 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2170
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16756:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6250 [inline]
 kfree+0x223/0x6c0 mm/slub.c:6565
 l2cap_conn_free net/bluetooth/l2cap_core.c:1823 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1835 [inline]
 l2cap_conn_del+0x57f/0x710 net/bluetooth/l2cap_core.c:1815
 l2cap_connect_cfm+0x9bb/0xf80 net/bluetooth/l2cap_core.c:7374
 hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
 hci_conn_failed+0x188/0x360 net/bluetooth/hci_conn.c:1409
 hci_abort_conn_sync+0x7d9/0xb20 net/bluetooth/hci_sync.c:5763
 hci_disconnect_all_sync.constprop.0.isra.0+0x155/0x430 net/bluetooth/hci_sync.c:5786
 hci_suspend_sync+0x8b7/0xa70 net/bluetooth/hci_sync.c:6262
 hci_suspend_dev+0x31d/0x540 net/bluetooth/hci_core.c:2850
 hci_suspend_notifier+0x21e/0x330 net/bluetooth/hci_core.c:2421
 notifier_call_chain+0x99/0x400 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
 blocking_notifier_call_chain_robust+0xc8/0x160 kernel/notifier.c:333
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:172
 snapshot_open+0x189/0x2a0 kernel/power/user.c:77
 misc_open+0x26d/0x450 drivers/char/misc.c:163
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
 do_dentry_open+0x6d8/0x1660 fs/open.c:947
 vfs_open+0x82/0x3f0 fs/open.c:1079
 do_open fs/namei.c:4699 [inline]
 path_openat+0x208c/0x31a0 fs/namei.c:4858
 do_file_open+0x20e/0x430 fs/namei.c:4887
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807ee53000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 632 bytes inside of
 freed 1024-byte region [ffff88807ee53000, ffff88807ee53400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ee50
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe34dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe34dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1151, tgid 1151 (kworker/u8:8), ts 131280693452, free_ts 131177469088
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x11a6/0x33b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7255
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __do_kmalloc_node mm/slub.c:5294 [inline]
 __kmalloc_noprof+0x688/0x850 mm/slub.c:5307
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 neigh_alloc net/core/neighbour.c:521 [inline]
 ___neigh_create+0x1545/0x2950 net/core/neighbour.c:655
 ip6_finish_output2+0xffa/0x1ce0 net/ipv6/ip6_output.c:128
 __ip6_finish_output+0x357/0xdf0 net/ipv6/ip6_output.c:208
 ip6_finish_output net/ipv6/ip6_output.c:219 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x2aa/0xa60 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:470 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xa85/0x1bf0 net/ipv6/ndisc.c:512
 ndisc_send_rs+0x129/0x680 net/ipv6/ndisc.c:723
 addrconf_rs_timer+0x424/0x880 net/ipv6/addrconf.c:4049
 call_timer_fn+0x19a/0x640 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x75f/0xaf0 kernel/time/timer.c:2374
page last free pid 5637 tgid 5637 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x747/0x1040 mm/page_alloc.c:2943
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_noprof+0x241/0x6e0 mm/slub.c:4905
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x35/0x390 fs/namei.c:182
 getname include/linux/fs.h:2526 [inline]
 class_filename_constructor include/linux/fs.h:2553 [inline]
 do_sys_openat2+0xc5/0x1e0 fs/open.c:1363
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807ee53100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ee53180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ee53200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88807ee53280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ee53300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
