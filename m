Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861111CDFD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813586; cv=none; b=U3zyH2pF1NCjgr2InZLKcTgKhkS4ft0gUi+kNDWgyY+smNXm0BJm1Hz4uYwKHIiAdXZu+L48Ko0xG3Cf3GAY04UJmRQeW4KWLeCS8BwOTlRSqO/7tWVrGGdsJEndezk1JCunWzM1XgMovEU9obq9qjMGlhOTXvGIwmsoPzqaPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813586; c=relaxed/simple;
	bh=P/Eg2qzmxH6FpR1YjShh0k+F/2g8dONx70mi4rvbtP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UTC7NFwykAt+iobie6lKb+/07a+Y2eNZpXgik/T+WKzVUzUcEeF6R2sspeztQdWWJp5F+U9I6KR/O5lKo18Z4e88HKZEgJ0JbkuTEtx34Zpf7cR/V2wXmYq5S1EdufMo4zSMbali6VEC3pm+cZmneZ+RRxQFe0GrFr3Gki0g/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343860e72so57475575ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 13:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813584; x=1728418384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgEb08Ir6WaU8Lx/dmx/9a2CpRpHBgcLsIMZgQtvMEQ=;
        b=MXtsnqRN/NGLJYyC7yf2m8OhVpVLxzz0Sl6TCLY5aqSBPd4jposKhwDPCRXrz2iFK0
         /1o4/om/ShwTeREZWp4Weu2KYS+sepPWxg9gGIEZLap+aXu1ruZv3lIVZ0NmowhetaE7
         TYz9ehnrojx0EdXJ5zbr5318XqK9fAY8sLbtBdFs7MpZwCm9f2uXX7lD/SKC+OqmBcIv
         dHKxRU25xBRyoxxeXFD8H3xHn4GF/P3MHPwqRUKf5ClTW97AfOWmOSViVy32x59AYI+F
         qKBSfueoMEZH+olKLyGy9+/Ajgq3lJUmQIxvZ0kRe4opa+AqNL8Hu1sqL2eEXTn7vBsA
         xU9A==
X-Gm-Message-State: AOJu0YyzFyXirceGyNscu93RXHkYtZq5Bsx/aGJnrbCZOsHUY7Peo9SF
	tgrYBLE2s65hYNhoRZ/YVfnTsbD3CgRhSAz8Gy87wZq724VT7PVQx5bzY7L2N1gYXeeCLj6GTe1
	1MJS1GXHocwqfWvj9BsFMyoseJV/iCtYk708UDOEd09Wg+kEYw4AUvGM=
X-Google-Smtp-Source: AGHT+IGgDDoWvyhn3sxw2vqMgRcczVIhsLYa5tUdtqFR+AI0HBJFGOC9Q7yD1sBNSwcDSJerK7UrLPoGD0vWGqOpp8xqziRyJjvl
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a36592bc6fmr8227775ab.12.1727813583683; Tue, 01 Oct 2024
 13:13:03 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:13:03 -0700
In-Reply-To: <CABBYNZKmxnB=QK7REZvoT-32uH3Oy8SwgP+Ars8ok6ZD-HjvLg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc57cf.050a0220.f28ec.04cd.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_sock_timeout

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
Write of size 4 at addr ffff888022136080 by task kworker/1:0/25

CPU: 1 UID: 0 PID: 25 Comm: kworker/1:0 Not tainted 6.12.0-rc1-syzkaller-ge32cde8d2bd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:781 [inline]
 sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 4550:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x777/0x990 security/security.c:3107
 do_dentry_open+0x369/0x1460 fs/open.c:945
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 4550:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 tomoyo_realpath_from_path+0x5a9/0x5e0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x777/0x990 security/security.c:3107
 do_dentry_open+0x369/0x1460 fs/open.c:945
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888022136000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 128 bytes inside of
 freed 4096-byte region [ffff888022136000, ffff888022137000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22130
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000884c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4550, tgid 4550 (udevd), ts 121918980453, free_ts 121043303487
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 kernfs_iop_get_link+0x67/0x5a0 fs/kernfs/symlink.c:135
 vfs_readlink+0x170/0x3b0 fs/namei.c:5267
 do_readlinkat+0x249/0x3a0 fs/stat.c:551
 __do_sys_readlink fs/stat.c:574 [inline]
 __se_sys_readlink fs/stat.c:571 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:571
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 54 tgid 54 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4491
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 hci_cmd_sync_submit+0xcb/0x2f0 net/bluetooth/hci_sync.c:710
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888022135f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888022136000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888022136080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888022136100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888022136180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e62580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5997f8b13c390e73
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12698927980000

