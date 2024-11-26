Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145312FB0A;
	Tue, 26 Nov 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593261; cv=none; b=BR1UfsJpd3vRoVFwXcJRwznHEPEDUd3VdP8fnjxaBY0CYxS/DSgN51s47V1nbrsqEKzGPsyhCu+rGVKifRVh2YfVal6cDH7eIboerR5TMP0JTH3pensHr1UgZoSQqOwP4SvYvSOT41bMRYZ+TBz8EPATg6p9HI9HySILs21o0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593261; c=relaxed/simple;
	bh=KcJfkwDQzRZKm8U6RazxnIwLF4GNammUSG5pNvPDGW4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hefwCi9IC4GOB8s5n6kJNhSZ1Ay0dixiSc5/hz99GAZQJ11b1FHVkE0eRj6pXNcx/A3IPGSPblndvuvzlgs7+0IqQPCyzqNrYoiCS8GeNQoghn0v9ZJzka48dgWDtzTV/FHxYYoYAjh4zsa2KZpZGAb+6M4U3RSAhdOgAnnV70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9ym1JFH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9ym1JFH"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5150f63db70so1128886e0c.3;
        Mon, 25 Nov 2024 19:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732593258; x=1733198058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KcJfkwDQzRZKm8U6RazxnIwLF4GNammUSG5pNvPDGW4=;
        b=c9ym1JFHtrJxAnrvYlvqkjEvdAcPXmNU7yr6jHOkw9TJ1fThdbt8BmrSMj26gNO0mz
         QO0RsiE5SNZFPIGumdvjiqxp9h6kRvjCtYat6g2J5R9XCV9eE69/KTuxGvMMgkTj8CdY
         sGfMJqe/zGsnEEmDnuk2Zy2NA0dflOlCA71iqYgYB8ZOhtyCrjgC7aVLV+/k8P/oSDz2
         JFRIfJ/0ab0GcrByhu/fbG+JLy8639G423u8FfNvuDMioNpy3ngQu8CqB72oAasMT5SO
         zAaTl25DJp+WYhsumieL+O5HDGg2K+QDd6PEdWC7gacLWpBC1z/jbLc/OPebbxBqRphy
         LoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732593258; x=1733198058;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcJfkwDQzRZKm8U6RazxnIwLF4GNammUSG5pNvPDGW4=;
        b=nAVmSJK/Vk2eE2krR6SVX8iLIXc29UYk++AlvPO8DiaBzl1jE1xF4MjtCQ5HHdZFsJ
         5txECfcxmWXSXVFK3sYBEyKeg60SZk9Z4kd77zF3EcL/14GZh+9SkW8yfMw5LcNFOtn5
         tI511fex8OyDk2gsq4FzBtykegpvlKsLRm0tMsTXqC7irTgGCsuBwcVf3Z/yWRNk7uiz
         0xPcMnpaYLi2J2Tc/fQDoyolpccBe4Pd+u+tzlJpB1eUhQlArSEWVQHeLCFFjPnqebK+
         uizECAUvInZM3u3uWGx2oRfQxBGe/ZTROBtjYX2qo7j5u83c6XiayFCIRd+zNWhYBvqQ
         ioQg==
X-Forwarded-Encrypted: i=1; AJvYcCVScI+fVGYSe5vMgROkUJ9VEuXtQHTYAKrKVbt6TFwpsyd7uXG0MXaSl/myxAvuHTK0cREtxV4mUDNLb5OzI5o=@vger.kernel.org, AJvYcCXYfthDU43aA/XChtQGhVISYSoP//QTLJZYG0FFrFJrH4+vUJGS9eLrwNFGMhawGBmP14OD8rdONzvYBUAE@vger.kernel.org
X-Gm-Message-State: AOJu0YyAl8cmXNlDeDSTh1PCAnvQIK6nfSoNT7xRo2hwwKmOaE8Rmr6l
	8uUEa6e+aZBbmrmwkT2SsSg2CmDd7nsKP7is7edZfgP0EF5cdXzp37JGvLsWFUoZuXBoHVInrL0
	mEpaYLNCm/A7E5ISnothmdXWQHbc=
X-Gm-Gg: ASbGncszc5qYoyASY3f6Pbu6qTGnVjcYIjuyrUX3vaKBMpiyt08CYIzuB21xx/StOGw
	DUaKUztbfWZTGy0JIDbVec73dELAjaA==
X-Google-Smtp-Source: AGHT+IGW1+jrlvHSiINAErTGvpXIMdmcR6TKbk0tp8wqC8cmLuphFyqTohQQ5zpT9WalSkLy4BpTD72GCkxHpauDkk0=
X-Received: by 2002:a05:6122:4fa2:b0:50d:7a14:ddf7 with SMTP id
 71dfb90a1353d-515009c176cmr16406687e0c.8.1732593257484; Mon, 25 Nov 2024
 19:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Tue, 26 Nov 2024 11:54:06 +0800
Message-ID: <CAHOo4gK39vp=BiQ2mkiOeJYU9NVMZ-6pcx6b44L-gfAv+P0r2Q@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in lookup_object_or_alloc
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
we found a crash "KASAN: slab-use-after-free Read in
lookup_object_or_alloc" (it is a KASAN and makes the kernel reboot) in
upstream, we also have successfully reproduced it manually:

HEAD Commit: 28eb75e178d389d325f1666e422bc13bbbb9804c (Date: Thu Nov
21 14:56:17 2024 -0800 Merge: 071b34dcf715 a163b8950778)
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/6.12.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/28eb75e178d389d325f1666e422bc13bbbb9804c/6c36a187a46a303da83a68b5edb341c1f04ea717/repro.log
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/28eb75e178d389d325f1666e422bc13bbbb9804c/6c36a187a46a303da83a68b5edb341c1f04ea717/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/28eb75e178d389d325f1666e422bc13bbbb9804c/6c36a187a46a303da83a68b5edb341c1f04ea717/repro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/28eb75e178d389d325f1666e422bc13bbbb9804c/6c36a187a46a303da83a68b5edb341c1f04ea717/repro.cprog


Please let me know if there is anything I can help with.
Best,
Hui Guo


This is the repro report
=============================================================================================
BUG: KASAN: slab-use-after-free in timer_is_static_object+0x86/0xa0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/time/timer.c:733
Read of size 8 at addr ffff88802256a8a0 by task syz-executor302/162870

CPU: 0 UID: 0 PID: 162870 Comm: syz-executor302 Not tainted
6.12.0-07749-g28eb75e178d3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
<TASK>
__dump_stack data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/dump_stack.c:94
[inline]
dump_stack_lvl+0x116/0x1b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/dump_stack.c:120
print_address_description
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/report.c:377
[inline]
print_report+0xc0/0x5e0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/report.c:488
kasan_report+0xbd/0xf0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/report.c:601
timer_is_static_object+0x86/0xa0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/time/timer.c:733
lookup_object_or_alloc.part.0+0x407/0x590
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobjects.c:679
lookup_object_or_alloc
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobjects.c:426
[inline]
debug_object_assert_init+0x1ed/0x360
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobjects.c:1008
debug_timer_assert_init
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/time/timer.c:845
[inline]
debug_assert_init
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/time/timer.c:890
[inline]
__timer_delete+0x78/0x1b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/time/timer.c:1412
del_timer data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/timer.h:202
[inline]
try_to_grab_pending+0x80/0x840
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.c:2064
work_grab_pending
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.c:2157
[inline]
__cancel_work+0x8d/0x350
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/workqueue.c:4322
sco_sock_clear_timer+0x4f/0xe0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:180
sco_sock_close data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:522
[inline]
sco_sock_release+0x77/0x2d0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:1298
__sock_release+0xb3/0x270
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:640
sock_close+0x1c/0x30
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:1408
__fput+0x3fb/0xb40
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/file_table.c:450
task_work_run+0x16c/0x260
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/task_work.c:239
get_signal+0x1ce/0x2540
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/signal.c:2789
arch_do_signal_or_restart+0x81/0x7d0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/signal.c:337
exit_to_user_mode_loop
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:111
[inline]
exit_to_user_mode_prepare
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/entry-common.h:329
[inline]
__syscall_exit_to_user_mode_work
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:207
[inline]
syscall_exit_to_user_mode+0x150/0x2a0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:218
do_syscall_64+0xd8/0x250
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23b7809cdd
Code: c3 e8 27 27 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23b6fa6198 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f23b78ad080 RCX: 00007f23b7809cdd
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007f23b6fa65f0 R14: 00007f23b78ad088 R15: 0000000000000000
</TASK>

Allocated by task 162708:
kasan_save_stack+0x24/0x50
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:47
kasan_save_track+0x14/0x30
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:68
poison_kmalloc_redzone
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:377
[inline]
__kasan_kmalloc+0xaa/0xb0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:394
kmalloc_noprof data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/slab.h:879
[inline]
kzalloc_noprof data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/slab.h:1015
[inline]
sco_conn_add data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:199
[inline]
sco_conn_add+0xcd/0x400
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:184
sco_connect data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:336
[inline]
sco_sock_connect+0x342/0xbf0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:645
__sys_connect_file+0x14c/0x1b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:2055
__sys_connect+0x174/0x1a0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:2074
__do_sys_connect
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:2080
[inline]
__se_sys_connect
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:2077
[inline]
__x64_sys_connect+0x72/0xb0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:2077
do_syscall_x64 data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:52
[inline]
do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 162708:
kasan_save_stack+0x24/0x50
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:47
kasan_save_track+0x14/0x30
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:68
kasan_save_free_info+0x3b/0x60
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/generic.c:579
poison_slab_object
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:247
[inline]
__kasan_slab_free+0x54/0x70
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:264
kasan_slab_free
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/kasan.h:230
[inline]
slab_free_hook data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:2342
[inline]
slab_free data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4579
[inline]
kfree+0x14b/0x4b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4727
sco_conn_free data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:97
[inline]
kref_put data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/kref.h:65
[inline]
sco_conn_put+0x2cc/0x4d0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:107
sco_chan_del+0x9c/0x1b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:236
__sco_sock_close+0x80/0x220
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:508
sco_sock_close data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:523
[inline]
sco_sock_release+0x7f/0x2d0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/bluetooth/sco.c:1298
__sock_release+0xb3/0x270
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:640
sock_close+0x1c/0x30
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/net/socket.c:1408
__fput+0x3fb/0xb40
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/file_table.c:450
task_work_run+0x16c/0x260
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/task_work.c:239
get_signal+0x1ce/0x2540
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/signal.c:2789
arch_do_signal_or_restart+0x81/0x7d0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/signal.c:337
exit_to_user_mode_loop
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:111
[inline]
exit_to_user_mode_prepare
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/entry-common.h:329
[inline]
__syscall_exit_to_user_mode_work
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:207
[inline]
syscall_exit_to_user_mode+0x150/0x2a0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:218
do_syscall_64+0xd8/0x250
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802256a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 160 bytes inside of
freed 256-byte region [ffff88802256a800, ffff88802256a900)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22568
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42b40 ffffea00010e5400 dead000000000003
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42b40 ffffea00010e5400 dead000000000003
head: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
head: 00fff00000000002 ffffea0000895a01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask
0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 5294, tgid 5294 (systemd-journal), ts 38269438886, free_ts
38258013698
set_page_owner data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/page_owner.h:32
[inline]
post_alloc_hook+0x2e7/0x350
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:1556
prep_new_page data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:1564
[inline]
get_page_from_freelist+0xe4e/0x2b20
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:3474
__alloc_pages_noprof+0x219/0x21e0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:4751
alloc_pages_mpol_noprof+0x2b6/0x600
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/mempolicy.c:2265
alloc_slab_page
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:2412
[inline]
allocate_slab data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:2578
[inline]
new_slab+0x2d5/0x420
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:2631
___slab_alloc+0xbb7/0x1860
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:3818
__slab_alloc.constprop.0+0x56/0xb0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:3908
__slab_alloc_node
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:3961
[inline]
slab_alloc_node
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4122
[inline]
__kmalloc_cache_noprof+0x2be/0x310
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4290
kmalloc_noprof data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/slab.h:879
[inline]
inode_doinit_use_xattr+0x54/0x420
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/selinux/hooks.c:1361
inode_doinit_with_dentry+0xcf2/0x11e0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/selinux/hooks.c:1555
selinux_d_instantiate+0x27/0x30
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/selinux/hooks.c:6372
security_d_instantiate+0x142/0x1a0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/security.c:4070
d_splice_alias+0x90/0xde0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/dcache.c:3001
kernfs_iop_lookup+0x286/0x330
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/kernfs/dir.c:1229
__lookup_slow+0x252/0x470
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:1791
lookup_slow data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:1808
[inline]
walk_component+0x346/0x5b0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:2112
page last free pid 5294 tgid 5294 stack trace:
reset_page_owner
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/page_owner.h:25
[inline]
free_pages_prepare
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:1127
[inline]
free_unref_page+0x714/0x10c0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/page_alloc.c:2657
qlink_free data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/quarantine.c:163
[inline]
qlist_free_all+0x50/0x120
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/quarantine.c:179
kasan_quarantine_reduce+0x195/0x1e0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/quarantine.c:286
__kasan_slab_alloc+0x67/0x90
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/kasan/common.c:329
kasan_slab_alloc
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/kasan.h:247
[inline]
slab_post_alloc_hook
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4085
[inline]
slab_alloc_node
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4134
[inline]
kmem_cache_alloc_noprof+0x121/0x2f0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/slub.c:4141
getname_flags.part.0+0x4b/0x560
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:139
getname_flags+0x95/0xe0
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/include/linux/audit.h:322
do_readlinkat.part.0+0x90/0x340
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/stat.c:561
do_readlinkat data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/stat.c:557
[inline]
__do_sys_readlinkat
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/stat.c:593
[inline]
__se_sys_readlinkat
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/stat.c:590
[inline]
__x64_sys_readlinkat+0xbf/0x110
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/stat.c:590
do_syscall_x64 data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:52
[inline]
do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
ffff88802256a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88802256a800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802256a880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88802256a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88802256a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
