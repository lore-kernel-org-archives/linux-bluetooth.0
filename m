Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17744881E
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706717; cv=none; b=QmCoQTRaa51RAIWO9Janlulc5+VHb2RMDUYVyEXQfLIoX+wquPv609QB/a8bc+bevTweIP/YWuc+jSiPzB2D9oQT3rGhONiV3nC9KtNO4ccbaaDQhbfsdY5FjfrxzQev0i+Kr1qYmxLO8MNI5JS0KKheA/54mn1TNrbxA68Z9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706717; c=relaxed/simple;
	bh=UgxBd/mRWTMaqrzvvHdKipa6J0qjgwA1IikuPhuehUQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E4iLjwBRhyR+NoaXIznRWm8nMcRo9gspdVFuK6V1QMm7cEkAg9aZ9l6zA77nTKIuYxLNr58IxNtDy8FkhIk68QAA/Fhy1Lev3Pwo9kkj817ikD4HBaZULT3lH3XIlx5zvoyMhZh7a0Rk4hHWhMcUodDnZL+fzu+jUqQvTf9DDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=BRpv7R3B; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Y3NrXDDv; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="BRpv7R3B";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Y3NrXDDv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724706716; x=1756242716;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=UgxBd/mRWTMaqrzvvHdKipa6J0qjgwA1IikuPhuehUQ=;
  b=BRpv7R3BO5Wy2XCbOLcvvKVrmMr60JdJ7q9qzf0lcfWiXhFgjB8BBw28
   egGQI+rHZtKUL7k8AgG/JtyrGpJNvC2DkVRGHDkHBgicgHxw0tDxC1EDN
   gir15ybNbZrGurdraFNUBtnRXdTEUaXVZ8Yct3dcfdGizDruu0CBpg2fP
   UcX8iclqJb4qCN/GtN6hA7rJJ09PPnl+X0934XrsPhvudL7wmyDS3ej7M
   sitSrDKgYUXK2XkaKXQp/qYDaMbPyC/rN1UzeVPqHwgXxu8WZSt3RJ7Nk
   fzYcpV45YJc8i/qH4sb63F+UgNyaZaTwxG3bqZy7fabfXNLBTP0oioJ+h
   Q==;
X-CSE-ConnectionGUID: I5B6bXJlSPOOiq+j4kDUFg==
X-CSE-MsgGUID: B1tTmIWORzqli3RF6r9fJA==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Aug 2024 14:11:55 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so490060839f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724706714; x=1725311514; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGOtBtlKDN6HnB8IthMrTA23RN9iLz3v/HiIv2JP034=;
        b=Y3NrXDDvM16gOuoRfi/ulsjgkVZnrYsXFX3jTDVpN0RXoRcfwqeKXQ7kjacvXBPmDh
         UjSTPwGq/OA/ul6Aq0Xu9V7ut2RxSQCqxFm6pdHi8xwkxFpHyXNh+JR5qQ4vuuJoUugp
         NUGwkpg+2gzdgE9EgD/opasCB5+uD+8NQygIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706714; x=1725311514;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGOtBtlKDN6HnB8IthMrTA23RN9iLz3v/HiIv2JP034=;
        b=uboQHsgPScVtVPU6qmbeFDw1eLmTTrP7Kvw+NcNsofoUsXk8+AtCK3qsgdhWZjzvku
         HrmRHyJ6qwXFFzfwMcS+B+5sx5XEGRkL3gpy0Bg8tYqlHUVTqIb1kb8NQ4y9cdAVXR66
         tfKtmEulBlCA/BZnDe1H8vMfYYYzxgIE/13syl0ZzBKUFPvq9m9BpeU11/Q6Y6dZ+bR3
         71UXro2anixd2tv404w0dl22xLHW/o7xMe5cld5kaByhc2w1gB5E2Aiac7tgwRb3Ddvj
         Ohx57x6zCCiR/nuJEcJDGvEA6SUzzeTydi5cKLZPJapOzUzVd6MkiAr7Q/iEu8tDiFs8
         cc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyTpcOPED0hs/NlCUuYy5DJWFTqsEko9PtesHF6bJcdJ2kty8sGpsRDbHM8OvWRnpU/rSHKJdZTNr5E816nF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBOlXEo4Q2SNDhioCcn77vwS/yNOjnsPEwq9XRldBg0FsTkD2
	P38xViwojrK+SZvgJMBeTnKoyjf2330kZj4XtFWfBmavrkAp4oHehUzCFnGSqO7wil6UeUj4b91
	P/xgvT/B8QmWpubJZFfYDxm39sVrFayRjJDNMsAFVadqXI+58uTcWZLKzauJOljHqQ6NZ4Lqjee
	NAcfmACxgoNpx66SjRZSlIdPWY09/3xqobXxUkoOWLKQ==
X-Received: by 2002:a05:6602:6c16:b0:7f8:c0eb:7adf with SMTP id ca18e2360f4ac-827871356f5mr1548607639f.0.1724706714118;
        Mon, 26 Aug 2024 14:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8UKXgHVZyvUe0zdJOLbZ19XLPMrg7ncUbhcl/s9YX+vbZlobXBJyZO25RPkktOVScecK/am/v5z5zINMxr/E=
X-Received: by 2002:a05:6602:6c16:b0:7f8:c0eb:7adf with SMTP id
 ca18e2360f4ac-827871356f5mr1548605439f.0.1724706713729; Mon, 26 Aug 2024
 14:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 26 Aug 2024 14:11:41 -0700
Message-ID: <CANikGpck2+ziQBWy5K0YfAQhbZnjtyohU5BxPp=v8ZWNdb5R6A@mail.gmail.com>
Subject: BUG: possible deadlock in hci_dev_do_close
To: marcel@holtmann.org, johan.hedberg@gmail.com, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
A possible deadlock issue was discovered in function
`hci_dev_do_close` when it attempted to acquire the lock
`hdev->req_lock`

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/5f32d2f519bf24b651580496e07497b2

The brief report is below:

Syzkaller hit 'possible deadlock in hci_dev_do_close' bug.

======================================================
WARNING: possible circular locking dependency detected
6.6.0 #9 Not tainted
------------------------------------------------------
kworker/0:3/4591 is trying to acquire lock:
ffff888031c5cdc0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at:
__flush_work+0xeb/0xa40 kernel/workqueue.c:3403

but task is already holding lock:
ffff888031c5d0b8 (&hdev->req_lock){+.+.}-{3:3}, at:
hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552
       hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
       rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
       __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
       rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

-> #2 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       rfkill_register+0x3a/0xb30 net/rfkill/core.c:1075
       hci_register_dev+0x43b/0xdc0 net/bluetooth/hci_core.c:2656
       __vhci_create_device+0x399/0x810 drivers/bluetooth/hci_vhci.c:437
       vhci_create_device drivers/bluetooth/hci_vhci.c:478 [inline]
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x2bd/0x470 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:1956 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x99d/0xdd0 fs/read_write.c:584
       ksys_write+0x122/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x40/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x6f/0xd9

-> #1 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x147/0x940 kernel/locking/mutex.c:747
       vhci_send_frame+0xb4/0x120 drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x229/0x480 net/bluetooth/hci_core.c:3039
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3651 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3736 [inline]
       hci_tx_work+0x13bf/0x1c80 net/bluetooth/hci_core.c:3835
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

-> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ab/0x3b50 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
       __flush_work+0xf4/0xa40 kernel/workqueue.c:3403
       hci_dev_close_sync+0x191/0x1230 net/bluetooth/hci_sync.c:4982
       hci_dev_do_close+0x31/0xa0 net/bluetooth/hci_core.c:554
       hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
       rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
       __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
       rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
       process_one_work+0x838/0x1560 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x855/0x1200 kernel/workqueue.c:2784
       kthread+0x2cf/0x3b0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304

other info that might help us debug this:

Chain exists of:
  (work_completion)(&hdev->tx_work) --> rfkill_global_mutex --> &hdev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock(rfkill_global_mutex);
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->tx_work));

 *** DEADLOCK ***

4 locks held by kworker/0:3/4591:
 #0: ffff888014476d38 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x735/0x1560 kernel/workqueue.c:2605
 #1: ffffc90002f2fd88 ((rfkill_op_work).work){+.+.}-{0:0}, at:
process_one_work+0x797/0x1560 kernel/workqueue.c:2606
 #2: ffffffff8f0c7868 (rfkill_global_mutex){+.+.}-{3:3}, at:
rfkill_epo+0x55/0x1d0 net/rfkill/core.c:462
 #3: ffff888031c5d0b8 (&hdev->req_lock){+.+.}-{3:3}, at:
hci_dev_do_close+0x29/0xa0 net/bluetooth/hci_core.c:552

stack backtrace:
CPU: 0 PID: 4591 Comm: kworker/0:3 Not tainted 6.6.0 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events rfkill_op_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2f8/0x3e0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ab/0x3b50 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __flush_work+0xf4/0xa40 kernel/workqueue.c:3403
 hci_dev_close_sync+0x191/0x1230 net/bluetooth/hci_sync.c:4982
 hci_dev_do_close+0x31/0xa0 net/bluetooth/hci_core.c:554
 hci_rfkill_set_block+0x175/0x210 net/bluetooth/hci_core.c:956
 rfkill_set_block+0x211/0x560 net/rfkill/core.c:346
 rfkill_epo+0x8e/0x1d0 net/rfkill/core.c:466
 __rfkill_handle_global_op net/rfkill/input.c:60 [inline]
 rfkill_op_handler+0x223/0x250 net/rfkill/input.c:108
 process_one_work+0x838/0x1560 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x855/0x1200 kernel/workqueue.c:2784
 kthread+0x2cf/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>
