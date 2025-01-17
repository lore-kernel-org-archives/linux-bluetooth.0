Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF521A0B0E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132751; cv=none; b=JjzaUMOpVf47OIdiQnMpnI+vQBOkgTU3ldgn9/hAO8zBpgsd6ToTS0PHH66L/WJKAqBL+MMZpXogjm2uIhLvW5d+jjW8h5Q76/i5sSRgTNhro3jmtyBZB9JAnqRL0Oy3HOIsZiNwIwaDg9ubzagiBLzXyWliEzhNhB0Z2dLuD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132751; c=relaxed/simple;
	bh=8AwAZClq6khtG9JHk+6715kUtJDFGHG7Mkgs54+a5eE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AxUi7tN8ZEAA/q+10vvSdLXC8vuV/iJKzxZ5Oss/i2p70fWkyrOqLY4BO8nQ0xDUFNp487JNr/sCH6YIIjDCFJSzglzmdtFVEbdjuAqIGEniFyEYKd8S30M7v2Rt2xCJcQiNGLlzQ8rybYOsnmehs+7GNeBxKTmoAA+KcQmCy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so39586005ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 08:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132748; x=1737737548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joTZyvmCDUkSmjvhmD3zr/rv/ul2DpYM5kLaf29hsDE=;
        b=klVOXuQAISB0rxlMTLLxYEiJDbsVVi3EODJltIL3Qt2syMRpxfQ4HIWc/9CmKWOCqz
         hSqPP6Iadzsm34f+TdsBKf1VbVoeuW4yYoSt/sFR/4gp04azjI4zS/pO/3s8mQDiT9lg
         QTqS799vn7gODMbH4voUmKgJOC3HD3o58i8org7ZXj/5myL3b+hXEGwmPUu8f1xwtUYe
         WproWaWquwe+du3tiiToxQ/zeZEQsIuxRqo5FrNM+6q2fFhhFmb6LYWxjsDQHglSfdHn
         R7FdnxbIj/y1XUKwsIio70aT2p7GL2JS7bUES1E69vb6GqHD4LoeMesy/VQlBIooIbN5
         w7EA==
X-Gm-Message-State: AOJu0Yw3xPUul+NuqYmgWx3emH8KRcchb2Y+6LXKOckD8cPyVqtYYsxT
	ohBKBG6TfSt3ttXJnve/V3ITKbp+1zso4uuViFS1nDjE/r9PwknzxV4j2sOxs0QaXvF4NWBeXfj
	stGNY9s+9Ck10Ny5rQ6/uzP6P3WYsGWq7LcM/wJ5gmQXAnRo1ExvIHfAQpw==
X-Google-Smtp-Source: AGHT+IEKzcw82JP9RNWz9XZUjLcFB4F0lpxXsVIRpjUzGntM7osXA0NjdfuEEA5+qfig3ILGviDtTShrCCIOwe23Q8fcmtAcJkva
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca49:0:b0:3ce:9193:20ee with SMTP id
 e9e14a558f8ab-3cf744906edmr24780115ab.17.1737132748723; Fri, 17 Jan 2025
 08:52:28 -0800 (PST)
Date: Fri, 17 Jan 2025 08:52:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a8acc.050a0220.303755.000c.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in full_proxy_read
From: syzbot <syzbot+72d4e2d4ed673547627a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    619f0b6fad52 Merge tag 'seccomp-v6.13-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129f7cb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e182416a4b418f
dashboard link: https://syzkaller.appspot.com/bug?extid=72d4e2d4ed673547627a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e45ec228698d/disk-619f0b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ef45a473fa3/vmlinux-619f0b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3aa0394de2de/bzImage-619f0b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72d4e2d4ed673547627a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in force_wakeup_read+0x136/0x150 drivers/bluetooth/hci_vhci.c:170
Read of size 1 at addr ffff88802f902231 by task syz.5.2422/17024

CPU: 0 UID: 0 PID: 17024 Comm: syz.5.2422 Not tainted 6.13.0-rc7-syzkaller-00043-g619f0b6fad52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 force_wakeup_read+0x136/0x150 drivers/bluetooth/hci_vhci.c:170
 full_proxy_read+0xfd/0x1b0 fs/debugfs/file.c:364
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c50785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c51602038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f9c50975fa0 RCX: 00007f9c50785d29
RDX: 0000000000000026 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f9c50801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9c50975fa0 R15: 00007ffc58b0d0c8
 </TASK>

Allocated by task 16:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xe6/0x1630 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_inform_bss+0xf1/0x10f0 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x8b1/0x1e40 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x254/0x3e40 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x252/0x8a0 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x474/0xac0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5232 [inline]
 ieee80211_rx_list+0x1bac/0x2990 net/mac80211/rx.c:5469
 ieee80211_rx_napi+0xdd/0x400 net/mac80211/rx.c:5492
 ieee80211_rx include/net/mac80211.h:5166 [inline]
 ieee80211_handle_queued_frames+0xd5/0x130 net/mac80211/main.c:441
 tasklet_action_common+0x251/0x3f0 kernel/softirq.c:811
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 16:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 ieee80211_inform_bss+0xa36/0x10f0 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x8b1/0x1e40 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x254/0x3e40 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x252/0x8a0 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x474/0xac0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5232 [inline]
 ieee80211_rx_list+0x1bac/0x2990 net/mac80211/rx.c:5469
 ieee80211_rx_napi+0xdd/0x400 net/mac80211/rx.c:5492
 ieee80211_rx include/net/mac80211.h:5166 [inline]
 ieee80211_handle_queued_frames+0xd5/0x130 net/mac80211/main.c:441
 tasklet_action_common+0x251/0x3f0 kernel/softirq.c:811
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802f902000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 561 bytes inside of
 freed 1024-byte region [ffff88802f902000, ffff88802f902400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802f906000 pfn:0x2f900
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801ac41dc0 ffffea0001918410 ffffea00020ede10
raw: ffff88802f906000 000000000010000e 00000001f5000000 0000000000000000
head: 00fff00000000240 ffff88801ac41dc0 ffffea0001918410 ffffea00020ede10
head: ffff88802f906000 000000000010000e 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000be4001 ffffffffffffffff 0000000000000000
head: ffff888000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5499, tgid 5499 (start-stop-daem), ts 44277312221, free_ts 44236417748
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2de/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 tomoyo_init_log+0x1268/0x1f60 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x30c/0x1180 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x193/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xe6c/0x2070 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12e/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x1b9/0x1e0 security/security.c:1296
 search_binary_handler fs/exec.c:1736 [inline]
 exec_binprm fs/exec.c:1790 [inline]
 bprm_execve fs/exec.c:1842 [inline]
 bprm_execve+0x642/0x19b0 fs/exec.c:1818
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:1949
page last free pid 5498 tgid 5498 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 __put_partials+0x14c/0x170 mm/slub.c:3157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1c8/0x3b0 mm/slub.c:4175
 ima_inode_get+0x120/0x580 security/integrity/ima/ima_iint.c:99
 process_measurement+0x63e/0x2370 security/integrity/ima/ima_main.c:253
 ima_bprm_check+0xe8/0x210 security/integrity/ima/ima_main.c:547
 security_bprm_check+0xa5/0x1e0 security/security.c:1296
 search_binary_handler fs/exec.c:1736 [inline]
 exec_binprm fs/exec.c:1790 [inline]
 bprm_execve fs/exec.c:1842 [inline]
 bprm_execve+0x642/0x19b0 fs/exec.c:1818
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:1949
 do_execve fs/exec.c:2023 [inline]
 __do_sys_execve fs/exec.c:2099 [inline]
 __se_sys_execve fs/exec.c:2094 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2094
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802f902100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f902180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802f902200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802f902280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f902300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
CPU: 0 UID: 0 PID: 17024 Comm: syz.5.2422 Not tainted 6.13.0-rc7-syzkaller-00043-g619f0b6fad52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x3d/0x1f0 lib/dump_stack.c:120
 panic+0x71d/0x800 kernel/panic.c:354
 check_panic_on_warn+0xab/0xb0 kernel/panic.c:243
 end_report+0x117/0x180 mm/kasan/report.c:227
 kasan_report+0xe9/0x110 mm/kasan/report.c:604
 force_wakeup_read+0x136/0x150 drivers/bluetooth/hci_vhci.c:170
 full_proxy_read+0xfd/0x1b0 fs/debugfs/file.c:364
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c50785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c51602038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f9c50975fa0 RCX: 00007f9c50785d29
RDX: 0000000000000026 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f9c50801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9c50975fa0 R15: 00007ffc58b0d0c8
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
