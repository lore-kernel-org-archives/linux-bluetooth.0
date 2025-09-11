Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0B158874;
	Thu, 11 Sep 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590166; cv=none; b=GFCshC1Ocl3I+9F52e1EutQHv7v5QU8JzmEjQlG8jEvqlYOSsyEPRlV6euGg//ydxgibYEsm9c5K777SvaQJai00TNvtLBfv5Gz3WIv3aUqvAOeJwgC8P+p8OESfGK6ZboD7mwgFMg1ntAz/7NuRm7N1A3upLcXQQ+eb8epe/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590166; c=relaxed/simple;
	bh=G04fZUgZ56U7kuJQcoIi59GBIQEdaCTZDqola+RrWck=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q7S+QaoewaMQ/OJ2eo7CH/zQ/wuIbdu6HUoFYdNHKjNvB5QVmvu+qg5plI/UDZ5g5nXzKLS1xxwPMBsShV5AQQDV3EZZ71Amjs7BMncKRTTFuURrYS2l1hzXpkY5cUq8Kp213Me/AO+dDfewNxEj0sLnYnNjTH6XO3Cei4qJEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrhP5YFW; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrhP5YFW"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea3ca65bd38so480781276.1;
        Thu, 11 Sep 2025 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757590163; x=1758194963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swVoqDhFQ/vPGTflDZUW+C/qPhgN92jVoj2mi0sdqY8=;
        b=GrhP5YFWcSnOYocSWxfvMEBTONv/pgE3JoTYiSG6XVHsA9dfORfvxaEy0tCLxZUjmB
         fmM0MtOCsAa6qQHIesFtJShFomjFhvWS4sWzmNwYVddwGNiViF+yb165oQ4F/qycDpt+
         ZCvMSnKRlaqirRu9W59c6MvYyEPWCZ8qa7c7033INHIrQb5ZkGqF2bmGvhVUCaxsCDlr
         jpH+4tiOtJpjMu3JBWRAtd4HX7BUKGU10d/pFL5Hhl+j6hmCfTh63MwInxAQILvSvE+4
         P0m+RU4Xb2o93NBXCqZOUpeiAA8xeiwBdEqXGksE4ME2d2mZbMco1KllNlmTYxCJb15s
         hFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590163; x=1758194963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swVoqDhFQ/vPGTflDZUW+C/qPhgN92jVoj2mi0sdqY8=;
        b=fQQ19b+pxD02T43U4mNU4OJuSTACcFv/2P4R3qFA+FDfCbHLC+QAGxAQBQfvtAjZl5
         kM5q/q5wejOnnDLK1O2oFgBsJYZdsRR7gA5LQjv2jccE9nWC9zlZe8UU5NIQwhV87ToW
         qXp7W3lr20+H5FFcqQrQLxlRO6468AcwsuEMAS7qSxACcCeZt3zyLNPO0CgX77DaGf2/
         RAOuMJbn3GYRD5wo6krNpeux8vId9ZvlaXqp6aW2cGax9r3HhZnmpJ+4gT+LYN5y8A1G
         +5oUFGihqTW+78Rmrs4t9yu39QmTUZdsqUvm0M6JRgE/ldJENMIynxwV5EdSYo/LOAqO
         GveQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUWy8ezkgNi7IkGU2rSzR8FxK1FpVdi3ndDXSU64+DwHKEW0/xyNKXK2jEww5g58xbHHVXKF/EDDYq8fkV2lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcZa+AEss9GR3pg9Qj7sB0OyaHVaVnqACGdcxs6vdUkeSJk17
	sgv6uPFIdd5W5AFyo5tH2qXMEn+GCHpKfnPoKRF6D2azAGcVWIrgGbCc/gcPCzfdGnbIw3faTUS
	1cW7A0cVtfrPzFf5klllCxE9FnctwF/fIwUx3
X-Gm-Gg: ASbGnctHSR9si6WBymtgwVPpX6RrwCauM0btYpEdKrKUEcRBP5/IjRWOIy9WPqpKYDE
	Kst1IvgNpLVLgRuv+OBqlNWEsaYBPvFEd/KI3/Hdy5IXE6Edq68REcstBtRGCVxNYBBZV+irKIn
	JtHqeL68FEFwq5+zKRz2V5dcmmetOeAP560RWyvnGK1BJ5bLO2QNNCxWTXPKD+7GQNlS27HKENu
	toAYA==
X-Google-Smtp-Source: AGHT+IFbbRwxxOFNpkjKWoC5iW5UUk6YqxzJ7HZ3lqyFuL0OFFLIDA9DbAHgigts20vNG7oSxZWYOjIfdGAgkPjIT2U=
X-Received: by 2002:a05:6902:15cd:b0:e98:a18f:a33f with SMTP id
 3f1490d57ef6-e9f67da8224mr14710232276.42.1757590163234; Thu, 11 Sep 2025
 04:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Thu, 11 Sep 2025 19:29:12 +0800
X-Gm-Features: Ac12FXzBVqIeXKrWAWLEZknIiwh2aK-Q8JFL78mSJkBPWzHEhIa2f0B9VqQk71s
Message-ID: <CAFRLqsWWMnrZ6y8MUMUSK=tmAb3r8_jfSwqforOoR8_-=XgX7g@mail.gmail.com>
Subject: [BUG] Bluetooth: mgmt: Use-after-free in set_name_sync due to race condition
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, gality365@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

I would like to report  a use-after-free (UAF) vulnerability
identified in the Linux Bluetooth management (mgmt) subsystem using
our customized syzkaller on 6.17.0-rc5.

The vulnerability is caused by a race condition between an
asynchronous command execution running in a work queue
(`set_name_sync`) and the synchronous cleanup process during an HCI
device shutdown (`__mgmt_power_off`).

After my analysis, the situation when race occurs may be as follows:

Thread A (PID 189):
  1. User sends MGMT_OP_SET_LOCAL_NAME command
  2. mgmt_pending_add() allocates cmd object (ffff88810c9cd080)
  3. hci_cmd_sync_queue() schedules set_name_sync() for async execution

Thread A (PID 20963):
  4. User initiates HCI device shutdown
  5. __mgmt_power_off() =E2=86=92 mgmt_pending_foreach() frees ALL pending =
commands
  6. mgmt_pending_free() deallocates the cmd object

Thread B (kworker):
  7. Work queue executes set_name_sync()
  8. Accesses freed cmd->param =E2=86=92 UAF triggered

The detail KASAN report as follow:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in set_name_sync+0x72/0x190
net/bluetooth/mgmt.c:3896
Read of size 8 at addr ffff88810c9cd0a0 by task kworker/u17:0/80

CPU: 3 UID: 0 PID: 80 Comm: kworker/u17:0 Not tainted
6.17.0-rc5-g717368f83676 #4 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10b/0x170 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x191/0x550 mm/kasan/report.c:482
 kasan_report+0xc4/0x100 mm/kasan/report.c:595
 set_name_sync+0x72/0x190 net/bluetooth/mgmt.c:3896
 hci_cmd_sync_work+0x281/0x380 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x77e/0x1040 kernel/workqueue.c:3319
 worker_thread+0xbee/0x1200 kernel/workqueue.c:3400
 kthread+0x3c7/0x870 kernel/kthread.c:463
 ret_from_fork+0x13a/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 189:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x66/0x200 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x35/0x120 net/bluetooth/mgmt_util.c:296
 set_local_name+0x1cc/0x4f0 net/bluetooth/mgmt.c:3951
 hci_mgmt_cmd+0xc9f/0x11a0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x69e/0xfe0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:729
 sock_write_iter+0x2ae/0x3d0 net/socket.c:1179
 do_iter_readv_writev+0x67b/0x900
 vfs_writev+0x3ed/0xea0 fs/read_write.c:1057
 do_writev+0x144/0x2c0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc7/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 20963:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x3d/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x199/0x3b0 mm/slub.c:4900
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x2cc/0x340 net/bluetooth/mgmt_util.c:257
 __mgmt_power_off+0x13a/0x390 net/bluetooth/mgmt.c:9439
 hci_dev_close_sync+0x769/0x10a0 net/bluetooth/hci_sync.c:5290
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_dev_close+0x135/0x1d0 net/bluetooth/hci_core.c:526
 sock_do_ioctl+0x84/0x330 net/socket.c:1238
 sock_ioctl+0x558/0x700 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf3/0x160 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc7/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810c9cd080
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 32 bytes inside of
 freed 96-byte region [ffff88810c9cd080, ffff88810c9cd0e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10c9cd
anon flags: 0x200000000000000(node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100042280 ffffea00042c6000 dead000000000005
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810c9ccf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810c9cd000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88810c9cd080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                               ^
 ffff88810c9cd100: 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc fc
 ffff88810c9cd180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
