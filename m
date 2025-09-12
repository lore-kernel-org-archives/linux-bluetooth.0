Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761A3081D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680447; cv=none; b=dJtR8PX/+XNE3zIoW4Yqz8YzMEi5bkKluYJhXTDMav+XOIbIg69PZZQc4RM63vIt5EP9k3f5E4NMDmNwGGw5Nk14yijlJtT48yeokB6K2Ty3kDJDL+L+quUXZTfCvH3VPpUoGE7ZvWP0r9i7gxgaBDjJMjxDQwnA+LA0G36ma9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680447; c=relaxed/simple;
	bh=+XPqbX516hI+cQw05AmgNv3Ek7Tw6q3nXyfUTfVrhek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P3N4nbHlZQbZJmr6zGLpnf+HrD9rZXTU7DxxxO+xTmUlGAUr4s6chaffvysu+EbvdsfJdt6bjHigfDUpUHnoBn+sHw2TIa3exeJ+KkT5JUGt+EDVaj7KuDz0V0aRoV3hi1zFDNr+eX6J3CRfrH4uwCo5Udqn3haoZf4U2pkA8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnzQEbFC; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnzQEbFC"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea3e82483d3so245902276.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 05:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680445; x=1758285245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DuvMxcFE5N0x3cvon6RUHiFurPTszusWZEjqpqYpeOM=;
        b=ZnzQEbFC2U0xvF4APC39rPRSBlDjrkzOdQ3xuwwTMVQSbQo5nduBT1QzZc4raTNVjP
         QSxxOCJjDYYw5DK8OD3TbUvRzEUvRd8GZTwKWLNjUd1VsM46f6oWQ6uI1y4a1FPn/gdQ
         NpP8+I2Rk1xQaxeydLQSvQ4ofYXE5GBvKdTol0XKlnByTLHCAXRTpAhEQ26mOYdwVe1c
         k6njQ03Oma37BC0Y8A4RWVIcUsrat0JkGCkmk9O1dezUHh/e2ovfA/J44WKR+jBIWuW5
         4PsuzTvNj3RLnLlxg8NJiHybbId19RwcgdXszfgRpc5ufadO9wjRiltAwoqXG+yI8VpW
         RZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680445; x=1758285245;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuvMxcFE5N0x3cvon6RUHiFurPTszusWZEjqpqYpeOM=;
        b=PawV0b1/YGBkgc/Gj8CjCjoeGrzI+atTK/nidjE11o6w2KJcG9hz/I4K/UnTiS6I2R
         X+ZA543k+nv0vActH+7P8Gs7PVq67jHcYy3qTCQpX/ACipGvwpfameL6oyCls1EaBlA+
         K7nsxgp/osuvgSM/CU1IGdRccBVvOHl35xmkWir4kqNhThu8M5Qkrcx/FEeJ5mtRn9Zs
         EWz5hg+r2KFBnF05a4tlApPRD8C8Jk9VFmAw/zpGFr/akyQpZ8ADj3zwJcklGLYCA6ps
         aPbD5GYRpVTJPF3ut5CiBVFqJ2TWLsBgVQUMzM9VCBERGjBZWlGDLW9L0Eu1wOBf2F38
         GGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3lO1nNT6Jg2h6REbO+VKv4M+jMYi9/kfvrd4JJ/zWzh3W01bgH3XzoEJtN07Y+IrCF6aKbwTv80+RW28kMac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SnO9r1yWNzmoPvsNphCDIxMMzgfySSYeAbg3Oq6e0s5j8btB
	UjHOQaewUneh0W7vuiP0ypjTcJmndQQva4GRPVgzw+mIROKEUNySIhDGe9RANEhkkXLJCJbMooA
	WqYO2KOl9IiMjGVaxwb9jvROxyWO6ie0=
X-Gm-Gg: ASbGncsc+ArfIe6/yFyxcIUd49D0lf5Vv4xLD4tYqJUBIFccAj8B1cTN71qhhRnFlzD
	sRj1BcNdUc9tLJrYLumUqnKu/UJiFP2QamolkxUuiNqek/ksCrF/9dnMNSx6Y9M2rvKA/N8w+Fz
	EKSdg41AkC6Hz9ER+B8GSiPDIQKr/43UGGYWCeKODeND4rujk8rx8R545VszgpkH1fHSFZEI3FG
	8n/f8FbZL7T4qeI
X-Google-Smtp-Source: AGHT+IHdmfBql5i3xm8+nIIOV3db7ITq1VWg/vaUFfu3+H05qGdAZWsPU3EYOa2xrAEKiL4s5qJJdqlfZkwTQSTWE1Y=
X-Received: by 2002:a05:690e:425c:b0:5fc:e0ba:8a95 with SMTP id
 956f58d0204a3-62749bd84fdmr1586557d50.5.1757680444722; Fri, 12 Sep 2025
 05:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Fri, 12 Sep 2025 20:33:53 +0800
X-Gm-Features: Ac12FXw6WRQZW-4Sm1poTyOWaUnl4x1FMHibXeaKIGo-aRxo_iirVP_pLoC-WII
Message-ID: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
Subject: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,

I would like to report  a use-after-free (UAF) vulnerability
found in the Bluetooth management subsystem using our
customized syzkaller on 6.17.0-rc5.
The bug occurs due to a race condition between HCI command completion
callbacks and HCI socket bind operations that trigger device cleanup.

After my superficial analysis, the situation when race occurs may be as follows:

PATH 1 - SET_POWERED Command Execution:
1. User space application sends MGMT_OP_SET_POWERED command via HCI
management socket
2. set_powered() function creates mgmt_pending_cmd object via mgmt_pending_add()
3. Command is submitted to HCI work queue via
hci_cmd_sync_submit()/hci_cmd_sync_queue()
4. Work queue executes set_powered_sync() followed by
mgmt_set_powered_complete() callback
5. mgmt_set_powered_complete() attempts to access cmd->param (line 1342)

PATH 2 - HCI Socket Bind Cleanup:
1. Another process attempts to bind HCI socket with HCI_CHANNEL_USER mode
2. hci_sock_bind() calls mgmt_index_removed() to clean up management state
3. mgmt_index_removed() calls mgmt_pending_foreach(0, hdev, true, ...)
4. All pending commands are removed and freed, including the
SET_POWERED command object
5. The mgmt_pending_cmd object and its cmd->param are freed via
mgmt_pending_free()

RACE CONDITION:
The issue occurs when PATH 2 executes between the time PATH 1 submits
the command
to the work queue and when the completion callback accesses
cmd->param. The current
protection mechanism in mgmt_set_powered_complete() has a TOCTOU
(Time-of-Check-to-Time-of-Use) flaw:

    if (err == -ECANCELED || cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
        return;

    cp = cmd->param;  // <-- USE-AFTER-FREE occurs here

The check allowing the cmd object to be freed between
the validation and the actual memory access.

The detail KASAN report as follow:

==================================================================
BUG: KASAN: slab-use-after-free in
mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
Read of size 8 at addr ffff88810edd90b0 by task kworker/u17:3/811

CPU: 0 UID: 0 PID: 811 Comm: kworker/u17:3 Not tainted
6.17.0-rc5-ge5bbb70171d1 #7 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x171/0x7f0 mm/kasan/report.c:482
 kasan_report+0x139/0x170 mm/kasan/report.c:595
 mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
 hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 197:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
 set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1407
 hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 sock_write_iter+0x1b7/0x250 net/socket.c:1179
 do_iter_readv_writev+0x598/0x760
 vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
 do_writev+0x105/0x270 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 100890:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x189/0x390 mm/slub.c:4900
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
 mgmt_index_removed+0x164/0x530 net/bluetooth/mgmt.c:9370
 hci_sock_bind+0x151a/0x1f30 net/bluetooth/hci_sock.c:1314
 __sys_bind_socket net/socket.c:1858 [inline]
 __sys_bind+0x229/0x2f0 net/socket.c:1889
 __do_sys_bind net/socket.c:1894 [inline]
 __se_sys_bind net/socket.c:1892 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810edd9080
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 48 bytes inside of
 freed 96-byte region [ffff88810edd9080, ffff88810edd90e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10edd9
anon flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100042280 ffffea00041e07c0 dead000000000003
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810edd8f80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88810edd9000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88810edd9080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                     ^
 ffff88810edd9100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88810edd9180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================

Best regards,
Cen Zhang
