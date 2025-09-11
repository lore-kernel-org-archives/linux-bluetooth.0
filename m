Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5714352FCD;
	Thu, 11 Sep 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606019; cv=none; b=kRlJo7c6sR+LuU75FeYUXWM6l7360GOsD9BH02RQPujIIDofl6MLSRNyxG9w9u/lDu4HLpmmX8Qn2o7qdeBjZUtAAIHJdiS1cxqt19gA7fvU8W35YKlhKZP2lki73a/0ZeDsPQ1ZWDoeIWjb6pameeRlp+BU8h3eiDG5MC/Rq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606019; c=relaxed/simple;
	bh=ejic9Ydpl1s5IMxgmzFSXx4gOtoiK+zcM93t1lGVahQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kOUXz/Pb5oVBeENv5ciVHgvdPWyLoBD6CDAxw0OIw+qxMvRwyLR0uToNueEX2ctT3VAGAlikrrvXd8UZtLApaO/E9emrP6TXKc/HQxkoyQK0KlOMElAghTe9QsA7e/zR6yhIM3nplnfVO5AFb3M8HiOFMg3bzzun7e9YSJE6AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAEPN/vA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAEPN/vA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-723bc91d7bbso7414347b3.3;
        Thu, 11 Sep 2025 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606016; x=1758210816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XC8JzkTbSTTeU/T/H/KX2J99FzXAX5f+4Bnm1UuSlfM=;
        b=EAEPN/vAuCjYC2P7prKZtozK/Ham/uS5NE9L8ebW64xnBuDE5PsoTYertLh9SOvILE
         DIaUo/lV69mrEdoUCwqIr+wvWFdukPn/PaxnNw+d2cljfkijUZmEG3FoSE5lo76Qc+I7
         TjqR9Q04hoh++MjmvXR2FUxCqX7Alekf9gtk0ammBXvCKUCcakniy0MFLecKjkSpPLO5
         sDOvHQhwZeqoZEEjgBLz2/wo6tksR4PV7EZAY5WtftzOVRQ2LarZHEAlfHwvM+zpTFDM
         +25YoZNEkfbrGcQAQTesQW9hccisDqpAumwuDYfdi9GoMidR4En/EAFTa960B3VCziqU
         +8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606016; x=1758210816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XC8JzkTbSTTeU/T/H/KX2J99FzXAX5f+4Bnm1UuSlfM=;
        b=pqoMHMRD4ckMNnaPcp2DCZX7DvpYLv5JAPnB5V8TjCutO9hao/GBYU4eK9E+P7+4fV
         dygllE06J/HAHgErv5my1NshJ5ieIMdGrGbZRGa8OivgJLfqXmQuh7mSBAXZ/aZP4TIm
         8Y1zbH+/dPMyIyTqcgy7aOpn22yQuu7c8owhYVEI4Dk43Z4LG6776vEG12Ip9ka34IFu
         EXxwRF6kLS/rmJRlOnOvov5m6Jjtb4sXzG+G+Sl9zE3oSuUXNttyXuQoFm5jb/u5GxJN
         bko/fFREZyPsiw+5i/4QEPXfuM6AuB2wOyA11OQN7oxwmKoJeW3Ex0AfdM6saWPjqdH3
         Yvvg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEGEyX2dK+w1k0gu3fSGKuIhHu8E7sQZSPGAgF8IZQCoShLsgF0w2JyacjD3ttExpuR8jHGISC+PgGOiEK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0KiPosoroMNqsZ5RkOFnxHHA42d2XlAqz+BMc7uIVg7me/wJ
	yKedLE9v3LVoLCN4zXQZJcjd9lCHy8ecLYgrXMv8XHJe9WzlbT9If4g+YpnfjuTUxGpYqB+jrV6
	oVJNzSQEQz1LJgJAAXQRbj1wAIbEq/grHXN3c0cA=
X-Gm-Gg: ASbGncvvBX0vVY/FRmh/p8dlGADmjIegxxK2I6MXCGCXbQRbkq+s+WUMUkUgf71ePOe
	JXbODeXpWxrZHyRZln+B9RjLIwFIbvP+FriXQ3Qt6IuX+I1De/VAZl9c5CCBanBzz/kjgeWLx8B
	nwz0LjxIog4IRKic6rbOpjcZQOaRUgcX71PBve3kY+FpkyCnjOzIh1JoNAnctieVbTTQEX5BQSf
	qIK17TGKPKTH/d3
X-Google-Smtp-Source: AGHT+IHyJ401KlRoqnSKNwW3P85G3S4uk5dfmuqVQZWgvq7RFgnXBcf8Ob5//SNxMjw4AhITN4kpBDfS93WYccV+Z7c=
X-Received: by 2002:a05:690c:3392:b0:71f:ede3:fc40 with SMTP id
 00721157ae682-727f534c72dmr162088207b3.40.1757606016240; Thu, 11 Sep 2025
 08:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Thu, 11 Sep 2025 23:53:22 +0800
X-Gm-Features: Ac12FXwwTCx1WdZ3n6mj5YIOSrHpP2qnz1AmFSQnSzVgUCDGoDI59rurvBNEkpQ
Message-ID: <CAFRLqsWnWnDaY2a23HctbxLKquvw7Ax30YB-tdBmS59RtQ4JBw@mail.gmail.com>
Subject: [BUG]: slab-use-after-free Write in sco_conn_put
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,

I would like to report  a use-after-free (UAF) vulnerability
identified in the Bluetooth SCO (Synchronous Connection
Oriented) connection handling code using
our customized syzkaller on 6.17.0-rc5.
The bug occurs due to concurrent access to freed
sco_conn structures during connection failure scenarios.

After my superficial analysis, the situation when race occurs may be as follows:

CONCURRENT CLEANUP PATHS:
   - Path A: Socket close operation (Task 31374) triggers sco_sock_release()
   - Path B: HCI connection failure triggers hci_abort_conn_sync() in
workqueue (Task 352)

RACE CONDITION SEQUENCE:
   a) Task 31374 releases socket, eventually leading to sco_conn_free()
   b) sco_conn_free() sets hcon->sco_data = NULL and calls kfree(conn)
   c) Task 352 (workqueue) executes hci_conn_failed() -> sco_connect_cfm()
   d) sco_connect_cfm() calls sco_conn_del(hcon, bt_to_errno(status))
   e) sco_conn_del() attempts to access already-freed sco_conn via
hcon->sco_data

The detail KASAN report as follow:
==================================================================
BUG: KASAN: slab-use-after-free in sco_conn_free net/bluetooth/sco.c:87 [inline]
BUG: KASAN: slab-use-after-free in kref_put include/linux/kref.h:65 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_put+0xdd/0x410
net/bluetooth/sco.c:107
Write of size 8 at addr ffff88811cb96b50 by task kworker/u17:4/352

CPU: 1 UID: 0 PID: 352 Comm: kworker/u17:4 Not tainted
6.17.0-rc5-g717368f83676 #4 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci13 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10b/0x170 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x191/0x550 mm/kasan/report.c:482
 kasan_report+0xc4/0x100 mm/kasan/report.c:595
 sco_conn_free net/bluetooth/sco.c:87 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0xdd/0x410 net/bluetooth/sco.c:107
 sco_connect_cfm+0xb4/0xae0 net/bluetooth/sco.c:1441
 hci_connect_cfm include/net/bluetooth/hci_core.h:2082 [inline]
 hci_conn_failed+0x20a/0x2e0 net/bluetooth/hci_conn.c:1313
 hci_conn_unlink+0x55f/0x810 net/bluetooth/hci_conn.c:1121
 hci_conn_del+0xb6/0x1110 net/bluetooth/hci_conn.c:1147
 hci_abort_conn_sync+0x8c5/0xbb0 net/bluetooth/hci_sync.c:5689
 hci_cmd_sync_work+0x281/0x380 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x77e/0x1040 kernel/workqueue.c:3319
 worker_thread+0xbee/0x1200 kernel/workqueue.c:3400
 kthread+0x3c7/0x870 kernel/kthread.c:463
 ret_from_fork+0x13a/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 31370:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4382 [inline]
 __kmalloc_noprof+0x22f/0x390 mm/slub.c:4394
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0xae/0x220 net/core/sock.c:2239
 sk_alloc+0x34/0x5a0 net/core/sock.c:2295
 bt_sock_alloc+0x3c/0x330 net/bluetooth/af_bluetooth.c:151
 sco_sock_alloc net/bluetooth/sco.c:562 [inline]
 sco_sock_create+0xc0/0x350 net/bluetooth/sco.c:593
 bt_sock_create+0x161/0x3b0 net/bluetooth/af_bluetooth.c:135
 __sock_create+0x3ad/0x780 net/socket.c:1589
 sock_create net/socket.c:1647 [inline]
 __sys_socket_create net/socket.c:1684 [inline]
 __sys_socket+0xd5/0x330 net/socket.c:1731
 __do_sys_socket net/socket.c:1745 [inline]
 __se_sys_socket net/socket.c:1743 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc7/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 31374:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x3d/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x199/0x3b0 mm/slub.c:4900
 sk_prot_free net/core/sock.c:2278 [inline]
 __sk_destruct+0x4aa/0x630 net/core/sock.c:2373
 sco_sock_release+0x2ad/0x300 net/bluetooth/sco.c:1333
 __sock_release net/socket.c:649 [inline]
 sock_close+0xb8/0x230 net/socket.c:1439
 __fput+0x3d1/0x9e0 fs/file_table.c:468
 task_work_run+0x206/0x2a0 kernel/task_work.c:227
 get_signal+0x1201/0x1410 kernel/signal.c:2807
 arch_do_signal_or_restart+0x34/0x740 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x68/0xc0 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x1dd/0x240 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88811cb96800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 848 bytes inside of
 freed 1024-byte region [ffff88811cb96800, ffff88811cb96c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11cb90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea000472e401 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811cb96a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811cb96a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811cb96b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88811cb96b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811cb96c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Best regards,
Cen Zhang
