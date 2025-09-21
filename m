Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E031DED63
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444612; cv=none; b=jCrDSs7gGlWASz9ub53kryHnDIhNOfYFxBCczUNwlBqPI62Gh7WX/jxFAiSUDKL89I5aM0yaSuHGWiCJHi8WAjq1lk4GMgR34lAXIXkGSq6phozHxYbSEE0LmloGSxv0AIfTl07XW0WhCBHcPSFMRqDL5INt9xlHlWwjdeGWhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444612; c=relaxed/simple;
	bh=qKobqPXjbzJkURaCIr1E0autBxv8G/ZskK4w1oeQtJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XZOXLTzCawqBrMm7H2StJsLnFXVrFE34Xr1bKFjRKxUecRZ1kJkddUL9MGhO0Rw/CzPpmeRVozTmOmJhDZ/QPgIKP5veZ+iQKmQ+R942aDdA7LTmJhSSIFl4VIjF13fONgGV0TTT+UODmewyhiYgZnUNxDHej9Xzfk2kkouDjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maHOz2rt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maHOz2rt"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso3352635276.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758444609; x=1759049409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zDEVEqOXG6+p3ZgaagcezUlQsqQHRzvGMKTwJSm1sOE=;
        b=maHOz2rt4mV0tuucnljc8uFypy1rfczrE7wYhRyNLS4CxBLH+QyG+TJjfkL+bArLm2
         RaWYoxMU41xNxjle2zCwkMOugN4TsQo4Yg9C+hFCiXew76Br20RVsC/WS+c2kxg41QvJ
         C3IBDqJQo2R1+g+nYwqqRDpgSV9ieuiKiUTvbbC1MRw18PGRX1JbO2JpwTnxbiqYGAlk
         OlzE+0fqOw/P8bP91iouMqNLtDiSyFGfARAxMndnHH3BsVwGaKS8ZKkacpGCfyXLMtpG
         DWP0OdAuKjP2uzKxqvBX7UhWAeOjgLRqAJ2oMugujWaCMUGO2RppXSmq7Q/26Sx7kxyB
         vzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758444609; x=1759049409;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDEVEqOXG6+p3ZgaagcezUlQsqQHRzvGMKTwJSm1sOE=;
        b=AqcmvdjZdr+nZGQU+pJ8AlJmNKQS7Ee0oHsEKy2Er9jSn+oHjhH73tyBdv27JYW7Fk
         c2Gp0SJKQwMMQMIxxl2nTv+Mc4Ui5EYCebeC0GUgZuDn8hxl8q//6dOh4r49TVHHU4TE
         usUQtBATXirkaBz93AE5Mscuwy4NpREGaR8mz4N5pOmHKXzskdcSeLY8e4e3zaBVf3eP
         ZITLnXKJMgN2tM/y5mN1q6uccpBtxsZAx1xQktwRCFoedy9TBJxiWdsZyW5bbdF2z3Lm
         5HYnVjJU4y/k9fez6L0QxXQx0myyphVfjpXFS3GxKPEDcz90w2k8M7oqFKy3btpVKKMD
         Muzw==
X-Forwarded-Encrypted: i=1; AJvYcCXYeWWYVfQgTWXPmAm91YcLHzmVdvPKuYldGUDGEKmHTPfdss3iefuJyRM6gKEeJ15LLH7NJ44bMaee9Hrjt38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKyhkvnSpT8BYS+JBf4hz4QQQCbXVz9QB9pmey/l2w+ex2cPu
	fFPq6LqkOsi1XLjUiTh8YGw0taq/SQdh/BiotQIzaWASb+ChxXHAfjewutCTutBhUqkYDPz+gXv
	ycUuMdMSFAfxCsV82XvRY/SHMIx0e2aGSbr1mTulbVNMO
X-Gm-Gg: ASbGncs0ydfbV8yXjRSnKkfCeHTQWBudh3rivrzJZxXAI0qnXRmUQW/KhESPvo18E8X
	U0VpmA+PDtdJJ9W+Wu7XXRPxVA1VVUz438WsCKtPCvGv7dLDVhjSi2STr7iIGHyTgIre3RfugqM
	2hYDMBP5O4jW43V3BAllgzYTZGppscOU2yslXQ7I+cFg8DXxy1GYVaAF+ww5J97iLfzaI93QmY/
	jZzIA==
X-Google-Smtp-Source: AGHT+IHlMDEd1tQ9O31JvReW0lUbnz6bNY4oRGu2JF4f/o/X8rhPYZs2HHg1UDyYjOMCAgAcTaRxf8XoPxsJhKzjVx4=
X-Received: by 2002:a53:ec47:0:b0:62a:2327:9ff6 with SMTP id
 956f58d0204a3-634779def96mr6461768d50.10.1758444609206; Sun, 21 Sep 2025
 01:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sun, 21 Sep 2025 16:49:57 +0800
X-Gm-Features: AS18NWDBRTBAx4VM1Sxu1LjM0XlA01KSp3jHD7-E77JTmkNBTAmE4ZcXYVmAYtA
Message-ID: <CAFRLqsVkqLHo9tNNEhFiJWEn506nVOM-Bnz_=b36A-kXgzb+mw@mail.gmail.com>
Subject: [BUG] Bluetooth: Use-after-free in hci_acl_create_conn_sync due to
 TOCTOU race condition
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

I've applied the full v6 series (1/3..3/3)
(https://lore.kernel.org/linux-bluetooth/20250915161504.814410-2-luiz.dentz@gmail.com/T/#u)
but discovered a use-after-free vulnerability may caused by another
reason during testing.

After my analysis ,I think  the UAF is caused by a TOCTOU
(Time-of-Check-Time-of-Use) race condition in
hci_acl_create_conn_sync(). Two concurrent flows race on the same
hci_conn object:

1. Flow 1 (Task 74): hci_acl_create_conn_sync() validates the
connection with hci_conn_valid() and proceeds to use it
2. Flow 2 (Task 76): Connection failure handling path calls
hci_conn_del() and frees the connection object

The race window exists between the validity check and actual usage in
hci_acl_create_conn_sync(), where the connection can be freed by the
event handling side due to errors, leading to use-after-free when the
original flow continues execution.

The detail KASAN report as follows:

==================================================================
BUG: KASAN: slab-use-after-free in
hci_acl_create_conn_sync+0x134a/0x16e0 net/bluetooth/hci_sync.c:6861
Write of size 2 at addr ffff8881199b0038 by task kworker/u17:0/74

CPU: 2 UID: 0 PID: 74 Comm: kworker/u17:0 Not tainted
6.17.0-rc5-ge5bbb70171d1-dirty #20 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x171/0x7f0 mm/kasan/report.c:482
 kasan_report+0x139/0x170 mm/kasan/report.c:595
 hci_acl_create_conn_sync+0x134a/0x16e0 net/bluetooth/hci_sync.c:6861
 hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 60621:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __hci_conn_add+0x647/0x51d0 net/bluetooth/hci_conn.c:949
 hci_conn_add_unset net/bluetooth/hci_conn.c:1061 [inline]
 hci_connect_acl+0x650/0xe60 net/bluetooth/hci_conn.c:1672
 hci_connect_sco+0x61/0x1c90 net/bluetooth/hci_conn.c:1734
 sco_connect net/bluetooth/sco.c:339 [inline]
 sco_sock_connect+0x638/0x1ed0 net/bluetooth/sco.c:658
 __sys_connect_file net/socket.c:2086 [inline]
 __sys_connect+0x277/0x350 net/socket.c:2105
 __do_sys_connect net/socket.c:2111 [inline]
 __se_sys_connect net/socket.c:2108 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2108
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 76:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x189/0x390 mm/slub.c:4900
 bt_link_release+0x49/0x60 net/bluetooth/hci_sysfs.c:16
 device_release+0x9c/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x16f/0x270 lib/kobject.c:737
 hci_conn_del_sysfs+0x1e2/0x380 net/bluetooth/hci_sysfs.c:62
 hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
 hci_conn_del+0x1f91/0x37a0 net/bluetooth/hci_conn.c:1211
 hci_conn_failed+0x662/0x820 net/bluetooth/hci_conn.c:1314
 hci_conn_complete_evt+0xf2b/0x3330 net/bluetooth/hci_event.c:3215
 hci_event_func net/bluetooth/hci_event.c:7569 [inline]
 hci_event_packet+0x17cd/0x2da0 net/bluetooth/hci_event.c:7623
 hci_rx_work+0x982/0x2210 net/bluetooth/hci_core.c:4071
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8881199b0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 56 bytes inside of
 freed 4096-byte region [ffff8881199b0000, ffff8881199b1000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1199b0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100043040 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100043040 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea0004666c01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881199aff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881199aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881199b0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff8881199b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881199b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Thanks for taking a look.

Best regards,
CenZhang
