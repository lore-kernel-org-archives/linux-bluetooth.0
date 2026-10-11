Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD3390600
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730083; cv=pass; b=V3LQdWprgBOpgMnxRkduByayMuOVrb4wubLXoRAiZlIaV3FhBuIDyKbhKKmMU/nf1WSytFsOSwuMS7XCUD19iFxNrHiI4ohOpj4vmXaXUHfwepiW/ojS5hXA0BRnDvFkzM9ABHj23IrczAUEAlwckH8LAJpCLDrXeoHYsj0cIUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730083; c=relaxed/simple;
	bh=2uXmL9Di3XVlxQhOgru72IqiU38xNauY8XWR+RtKzy0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qv7Hipyg2QrTQ4LhzEzIKD53sKIY7jSwqfb9FDsRYg5NZoa3EDlyD3Xfy97rPYcF4VVvHepglAX6pXlwqNFETo6/CVn9E68aqa6/ZDGJPRR5bbmslTWwx97UT4csmwOxpb45jh2Cy7iULAEBMyEQ34lrV3Mq1gHJHexAsJZRE3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKDo7mr0; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKDo7mr0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso192701166b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 07:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791730080; cv=none;
        d=google.com; s=arc-20260327;
        b=LkjuXXUv0XYN37MpA1zkCRjKT+rhjPzOxNC8jQNwj3g23UZa6bzTjaUFV+RTJkZlrv
         4VM7Mb4aMnj1yO3/nrDooBL/t8pl+QP6JP0SIIxrRbFq7xwqsb+q/ler8LQ1i4C4EZ7e
         MEfdfFfedWs87iTW2wlIr79ODQaXccxSNX9j7gyjOp6X2V2dDVzf3g6BIxR+62a1upiU
         1Ggy5SphWBKoxENsDRHN635eLr1MpxPrVTaQ166czYkMSCf5TuACRhaWL6w9CVXa5u+4
         bMsfE+ouRXc+YiogBp1CndVoPyZ/fJsOyRJAWzDz0VRuRg6nwROko+NukgTdjs7CrflW
         xYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=K/chmbJskVae5OKP2CKBzLuDTdHY4h4mDiBvA12ceqg=;
        fh=wYGNaWoHNEhIdl0VLbjxyHOqbMeoMYIFdFoax2dlrFI=;
        b=M9es0K2tvBhPKP5nGb8Zl5KuYjoqMdWNxTKf3Bb83wDlQi+Qfjxa80wU3bjQrfW0u+
         3erscLF4Otd+dvBT5nBAjA4sZLMs8FtEwtglyoEWCTQmGItKAXgijXUYoEwFj+HEYWYX
         nRSv1Fig/WxB5fdDvawX845n5zQoQtqEjB48TihhERXPXrKUE9ideW5R9IDi6ckCsWYv
         V4GQkL+k5ljJ0zY59SpLMGyTj3TrPo5Q/xDzKb74iiJIgGBjWblR3Brn8wrOoc1z9eJH
         /HFkmz43EhNjwfDIoDnhY4C50NgQX/Rpn7WZYOpnSpdfmhjXhdpB6lcOWoCT8i1MCp2/
         lIVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791730080; x=1792334880; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/chmbJskVae5OKP2CKBzLuDTdHY4h4mDiBvA12ceqg=;
        b=LKDo7mr0MChRVkecVI20w0GgKn9e4moZC4UR8AHcSEb9nxc8O/uEonHwKcnkIZMr9I
         MhMK53rJGm1+3/a3K1nRqTiB3ITHidkGsO371Nl1VJOriB1iOEwbkhsVabjOexPp3LPY
         zmQ4uqz6maJekHcrHNH9VzfdgFjn03xPSQMDvbUUnC4MIqDLvuAJnx2PhIjeoQ/ZDR3u
         VdVlQcXkeHkxFjSH9Ux5W+3PO77JxAQSTHY2BohgdKCOw89hFU3v8VCvZL8gxOIweBNp
         Ba8ANT4pCr0Ghxm4gDASsLWzkXj6+7vvW16zHzIy4nVEVknfC4oa6Ns4QxJHT5+PRirl
         b7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730080; x=1792334880;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K/chmbJskVae5OKP2CKBzLuDTdHY4h4mDiBvA12ceqg=;
        b=CPu+QMQTTs1b6bTwjsCAS7AcsIysHNqrtTq4k3Djim/YJ4R6ToyGLbcgEzqEiw56My
         dyMldK0T8Bse4fkYi06xYasSdNIvBOZP5TP2e0FYKg6U5gMXHC1cvq1ULPeOX6LR32nB
         ZNsIj5lBQbyVW8YYfzZwrdFcCZKl9fPvJuuTjqkeQvnlad/uFllnkuH9MZzg0ZZ3OM2S
         oQnB79k7gO9QzaisWA8LPUVU7+X1aGPaOE6pE+Nla8JaDXO7U//o/X23UMYSHd5gFY26
         ztwr3PDoSimy6+Me7aXgzBjL7j1WHpyr+Nce2t4ZjgNkqkmdI6U36rjvN6beSL9hZJxh
         7VHg==
X-Gm-Message-State: AFq9FYKyeEGnF0f3Y3CRHXsaKyNrlo+6mq3so6UJpTnrkDYM1y03gczW
	+0QpRzzTRK5lG2RnphQb4ADsdOu8SA8mGWisLfbiQ5pTVKMzBwHPo7dq5XER2PZGJNJe3WxOmOl
	FVFash9icpsjyZ9ZVu0wWinBsnowl9qw=
X-Gm-Gg: AYBFou3PNehUp2KOMbp5mM5lihLBNu9jL/JKTSIQKmL6el6r4Ert8gtEtqf3KW9J/Eo
	xjVwJ0455LphQ03sWA4BLihltnHJQcjsKSHQ2Ma1ZpsQa1mjzVICPqpiQ80Nk06BzSQIBm3w1lV
	2UaT5Ob3vQRRRIzsaeqi1bBVvM1BhZ3/zR2l5gRjHyd4DxUKiRPvJnt/bzdpzlW81D14yl8EL+a
	ogeYC0RBI8jw3kK2b7T0HQUslsDJ0afCOMpFzqFJDjWF7oIik9zRqnE6jf8gZkSHBSQDXkFOqNc
	DKMf+YOu153KT/tjSGFd7DE0fX1GPQFLKVP//5yBvIBJdj9u1YNE5tiGvwZeufpg00VjS12VLVj
	0hKh/My2amgB8sAjW2We8t3uJfSJA1NasMMLJz9J3ip8g
X-Received: by 2002:a17:906:4793:b0:c31:7495:e5c with SMTP id
 a640c23a62f3a-c31a9fd48dcmr793114866b.11.1791730079688; Sun, 11 Oct 2026
 07:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugene Siegel <elzeigel@gmail.com>
Date: Sun, 11 Oct 2026 10:47:48 -0400
X-Gm-Features: AclHuK8UT6eRtlzTYeJKuToxI9tTZiHJlosYCeZ_MylIkQAswabWiEZZNFLr5wo
Message-ID: <CALkdYjWpzCC3p_ZOSVgR2ieR+RaEd4M=8QijPvVSEk7DcKc2yw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
To: patchwork-bot+bluetooth@kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org, mikhail.v.gavrilov@gmail.com, 
	nicoyip.dev@gmail.com, pav@iki.fi, r772577952@gmail.com, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

With this patch on 3857c2fe54, I can hit a similar deadlock in
rfcomm_security_cfm.

Eugene Siegel

======================================================
WARNING: possible circular locking dependency detected
7.3.0-rc6 #1-NixOS Not tainted
------------------------------------------------------
kworker/u5:2/178 is trying to acquire lock:
ffffffff8eff81c0 (rfcomm_mutex){+.+.}-{4:4}, at:
rfcomm_security_cfm+0x37/0x5a0 net/bluetooth/rfcomm/core.c:2279

but task is already holding lock:
ffffffff8efe4d60 (hci_cb_list_lock){+.+.}-{4:4}, at:
hci_encrypt_cfm+0x4ab/0x720 include/net/bluetooth/hci_core.h:2240

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{4:4}:
     (inlined __mutex_lock_common kernel/locking/mutex.c:646)
       __mutex_lock+0x19c/0x1620 kernel/locking/mutex.c:821
     (inlined hci_connect_cfm include/net/bluetooth/hci_core.h:2164)
       hci_remote_features_evt+0x35b/0x8a0 net/bluetooth/hci_event.c:3786
     (inlined hci_event_func net/bluetooth/hci_event.c:7887)
       hci_event_packet+0x7f1/0xe10 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x3cc/0x8d0 net/bluetooth/hci_core.c:4087
     (inlined process_one_work kernel/workqueue.c:3396)
       process_scheduled_works+0xc99/0x1900 kernel/workqueue.c:3479
       worker_thread+0x8a2/0xda0 kernel/workqueue.c:3560
       kthread+0x38b/0x470 kernel/kthread.c:436
       ret_from_fork+0x43b/0x8f0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&hdev->lock){+.+.}-{4:4}:
     (inlined __mutex_lock_common kernel/locking/mutex.c:646)
       __mutex_lock+0x19c/0x1620 kernel/locking/mutex.c:821
       hci_release_dev+0x123/0x14b0 net/bluetooth/hci_core.c:2731
       bt_host_release+0x93/0xa0 net/bluetooth/hci_sysfs.c:100
       device_release+0xc4/0x1f0 drivers/base/core.c:2644
     (inlined kobject_cleanup lib/kobject.c:689)
     (inlined kobject_release lib/kobject.c:720)
     (inlined kref_put include/linux/kref.h:65)
       kobject_put+0x16c/0x270 lib/kobject.c:737
       device_release+0xc4/0x1f0 drivers/base/core.c:2644
     (inlined kobject_cleanup lib/kobject.c:689)
     (inlined kobject_release lib/kobject.c:720)
     (inlined kref_put include/linux/kref.h:65)
       kobject_put+0x16c/0x270 lib/kobject.c:737
     (inlined hci_conn_put include/net/bluetooth/hci_core.h:1690)
     (inlined l2cap_conn_free net/bluetooth/l2cap_core.c:1856)
     (inlined kref_put include/linux/kref.h:65)
     (inlined l2cap_conn_put net/bluetooth/l2cap_core.c:1869)
     (inlined l2cap_chan_destroy net/bluetooth/l2cap_core.c:494)
     (inlined kref_put include/linux/kref.h:65)
       l2cap_chan_put+0x1e9/0x260 net/bluetooth/l2cap_core.c:521
       l2cap_sock_release+0x198/0x1e0 net/bluetooth/l2cap_sock.c:1533
     (inlined __sock_release net/socket.c:735)
       sock_release+0x85/0x150 net/socket.c:763
     (inlined rfcomm_session_del net/bluetooth/rfcomm/core.c:782)
       rfcomm_session_close+0x1f6/0x250 net/bluetooth/rfcomm/core.c:821
     (inlined rfcomm_process_rx net/bluetooth/rfcomm/core.c:2086)
     (inlined rfcomm_process_sessions net/bluetooth/rfcomm/core.c:2171)
       rfcomm_run+0x7481/0x91d0 net/bluetooth/rfcomm/core.c:2261
       kthread+0x38b/0x470 kernel/kthread.c:436
       ret_from_fork+0x43b/0x8f0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (rfcomm_mutex){+.+.}-{4:4}:
     (inlined check_prev_add kernel/locking/lockdep.c:3209)
     (inlined check_prevs_add kernel/locking/lockdep.c:3328)
     (inlined validate_chain kernel/locking/lockdep.c:3952)
       __lock_acquire+0x17b9/0x2db0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
     (inlined __mutex_lock_common kernel/locking/mutex.c:646)
       __mutex_lock+0x19c/0x1620 kernel/locking/mutex.c:821
       rfcomm_security_cfm+0x37/0x5a0 net/bluetooth/rfcomm/core.c:2279
       hci_encrypt_cfm+0x516/0x720 include/net/bluetooth/hci_core.h:2243
       hci_encrypt_change_evt+0x6c9/0xde0 net/bluetooth/hci_event.c:3674
     (inlined hci_event_func net/bluetooth/hci_event.c:7887)
       hci_event_packet+0x7f1/0xe10 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x3cc/0x8d0 net/bluetooth/hci_core.c:4087
     (inlined process_one_work kernel/workqueue.c:3396)
       process_scheduled_works+0xc99/0x1900 kernel/workqueue.c:3479
       worker_thread+0x8a2/0xda0 kernel/workqueue.c:3560
       kthread+0x38b/0x470 kernel/kthread.c:436
       ret_from_fork+0x43b/0x8f0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(rfcomm_mutex);

 *** DEADLOCK ***

locks held by kworker/u5:2/178: 4, last CPU#0:
     (inlined rcu_lock_acquire include/linux/rcupdate.h:309)
     (inlined rcu_read_lock include/linux/rcupdate.h:849)
     (inlined process_one_work kernel/workqueue.c:3361)
 #0: ffff8880271f6940 ((wq_completion)hci1#2){+.+.}-{0:0}, at:
process_scheduled_works+0x94e/0x1900 kernel/workqueue.c:3479
     (inlined rcu_lock_acquire include/linux/rcupdate.h:309)
     (inlined rcu_read_lock include/linux/rcupdate.h:849)
     (inlined process_one_work kernel/workqueue.c:3361)
 #1: ffffc90001b87c60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_scheduled_works+0x94e/0x1900 kernel/workqueue.c:3479
 #2: ffff88802deec0b8 (&hdev->lock){+.+.}-{4:4}, at:
hci_encrypt_change_evt+0x84/0xde0 net/bluetooth/hci_event.c:3627
 #3: ffffffff8efe4d60 (hci_cb_list_lock){+.+.}-{4:4}, at:
hci_encrypt_cfm+0x4ab/0x720 include/net/bluetooth/hci_core.h:2240

stack backtrace:
CPU: 0 UID: 0 PID: 178 Comm: kworker/u5:2 Not tainted 7.3.0-rc6
#1-NixOS PREEMPT(full)
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
     (inlined check_prev_add kernel/locking/lockdep.c:3209)
     (inlined check_prevs_add kernel/locking/lockdep.c:3328)
     (inlined validate_chain kernel/locking/lockdep.c:3952)
 __lock_acquire+0x17b9/0x2db0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
     (inlined __mutex_lock_common kernel/locking/mutex.c:646)
 __mutex_lock+0x19c/0x1620 kernel/locking/mutex.c:821
 rfcomm_security_cfm+0x37/0x5a0 net/bluetooth/rfcomm/core.c:2279
 hci_encrypt_cfm+0x516/0x720 include/net/bluetooth/hci_core.h:2243
 hci_encrypt_change_evt+0x6c9/0xde0 net/bluetooth/hci_event.c:3674
     (inlined hci_event_func net/bluetooth/hci_event.c:7887)
 hci_event_packet+0x7f1/0xe10 net/bluetooth/hci_event.c:7938
 hci_rx_work+0x3cc/0x8d0 net/bluetooth/hci_core.c:4087
     (inlined process_one_work kernel/workqueue.c:3396)
 process_scheduled_works+0xc99/0x1900 kernel/workqueue.c:3479
 worker_thread+0x8a2/0xda0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x43b/0x8f0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
