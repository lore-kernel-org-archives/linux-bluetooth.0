Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CC19D07A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747196853; cv=none; b=u1V34hIDTKhtdSQ6nmoRbpOTIPI3aZ84L9dwbWpuZQVFPt2Qyis2Y1ECvGFod+kn0l0+CdgBgRpJ+Kt/fsZ7Jw8hbyKdCSwVGdBY74WlecF3Qo3Grval/CccmPn8Kn8MEpJ3mo23Y+IDZYA0C3kXFULruDhkBNanfJ91VZcjbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747196853; c=relaxed/simple;
	bh=X7sGOjukBJDPCD/uegnJjqMxnYe5GGikR1YK4wLxyWk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mm1n6bDWFnUrdPzC+XXKE34LtjeFsLAz/FVGHtxy4jh+UJWbhNOOnWuXfg36dT7rpQeITvIcL+MAcEiWR+ABhX0drjI8R7fWg8sEA8lc+dytm3ilp+BEeia2jRrKFQdoRcpfm180WlrgwECLbjmGmVW9l3nP5AiWnovjzsi2agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85e318dc464so1004428739f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 21:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747196851; x=1747801651;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEvgBXnYBbxIwjOrkeJm4RrzRL8xB65KuC/6b2rGeYI=;
        b=jzetPV4+FBGQVYFccCP+mo12xRW8s5B733Ds380URMfh+LGTOX9RzTq0+GHAi/98Z6
         /JgjNlH/WZZrZ4Q/4rJYnmSlAOBoVb5+35zKZaEq7mM/sWitbr2Y5PNI3d8D9hd9hFLD
         ux8A0VTN+6rY5/Jew9XsrLEAV0U1izM7GWwq8P8zOQjGmjAvxMIxdNKWl4wrb1wUWzXG
         BaMYCPM063wEmNWr2bPgiX75iUQfxMMJNmmcgJ1Bi8Fz/9tSPXRUpeWrqhT/hBrke29G
         S95M3J+teI5yNcHb/t31HNyIeLb6OgMLBdWgY4TomFK4VPeLT2RRPL6JC6ypxyR/a53J
         IMvg==
X-Forwarded-Encrypted: i=1; AJvYcCUcDJRVfunrpODXy2eUANfkEvJwqOC6RfMLsnU0AQjaLbHTailx+wY6efccNrtE57VzR8UeSHbMUK42UQPqmsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtHJLpgWZEH7GLe2hAW5Z09vo+927TaxLDpB1zSGpdhs3ND4M
	+HjKmhg3t6369HxFFSuW8mnYX61DkSU9qDDTm+L7+0Q2rg4BaFJJA2QdWt/up9hhAEnN8+8kFJi
	/2luxawAwfK27uzjhQ4ONmXLrSu+FUeuqeFxIrOjOyRbBfh9ROXd0RFY=
X-Google-Smtp-Source: AGHT+IHslH0GX571YXch4gUhfIDIsvSY7ZHJXkQQNMm4YP3p8y9QTPaUgnGRH0CrPttG9zDzranQKSrTyhLBO2q35CgA9px6tKdN
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7208:b0:867:1a39:842a with SMTP id
 ca18e2360f4ac-86a08e6de55mr255677839f.13.1747196850844; Tue, 13 May 2025
 21:27:30 -0700 (PDT)
Date: Tue, 13 May 2025 21:27:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68241bb2.a70a0220.3e9d8.0005.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_complete (3)
From: syzbot <syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea34704d6ad7 Merge tag 'drm-fixes-2025-05-10' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1663acf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c351a0f6229e67
dashboard link: https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112c9768580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1526e670580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ea34704d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7e586f1a091/vmlinux-ea34704d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd61ffd40938/bzImage-ea34704d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
Read of size 8 at addr ffff888048891a18 by task kworker/u5:8/5333

CPU: 0 UID: 0 PID: 5333 Comm: kworker/u5:8 Not tainted 6.15.0-rc5-syzkaller-00197-gea34704d6ad7 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
 hci_cmd_sync_work+0x25e/0x3a0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5702:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x65/0x240 net/bluetooth/mgmt_util.c:252
 mgmt_pending_add+0x34/0x120 net/bluetooth/mgmt_util.c:279
 remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5453
 hci_mgmt_cmd+0x9c6/0xef0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x6ca/0xee0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5700:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x193/0x440 mm/slub.c:4841
 mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
 mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9362
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1810 [inline]
 __sys_bind+0x2c3/0x3e0 net/socket.c:1841
 __do_sys_bind net/socket.c:1846 [inline]
 __se_sys_bind net/socket.c:1844 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1844
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888048891a00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888048891a00, ffff888048891a60)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x48891
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a041280 ffffea0000d6e3c0 dead000000000008
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5317, tgid 5317 (syz-executor420), ts 80512529929, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4970
 alloc_slab_page mm/slub.c:2452 [inline]
 allocate_slab+0x65/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_node_noprof+0x29a/0x3d0 mm/slub.c:4366
 kmalloc_node_noprof include/linux/slab.h:928 [inline]
 alloc_node_nr_active kernel/workqueue.c:4872 [inline]
 __alloc_workqueue+0x6a4/0x1b70 kernel/workqueue.c:5726
 alloc_workqueue+0xd4/0x210 kernel/workqueue.c:5786
 tipc_topsrv_work_start net/tipc/topsrv.c:635 [inline]
 tipc_topsrv_start net/tipc/topsrv.c:679 [inline]
 tipc_topsrv_init_net+0x37f/0x830 net/tipc/topsrv.c:725
 ops_init+0x359/0x5c0 net/core/net_namespace.c:138
 setup_net+0x238/0x830 net/core/net_namespace.c:364
 copy_net_ns+0x32e/0x590 net/core/net_namespace.c:518
 create_new_namespaces+0x3d3/0x700 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:228
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3375
 __do_sys_unshare kernel/fork.c:3446 [inline]
 __se_sys_unshare kernel/fork.c:3444 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3444
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888048891900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888048891980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888048891a00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888048891a80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888048891b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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
