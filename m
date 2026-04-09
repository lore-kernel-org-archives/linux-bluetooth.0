Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF43279DA6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765057; cv=none; b=kt+BJlDZzEukhW8t3fF1FVY4+PwjIlO8nw7YPHVn8+ts4gZrgavHsWYlMjhnfLQ5I13mkirTxshWVz0B0MnKziMS/lB/B4Dq54UirymvhI+6OUGTxPaJuV75sfkwEX0dbEWmV0MxIg/SIcNlNViGa/aVH/150Y5qtgta2J+zLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765057; c=relaxed/simple;
	bh=XKc2lCD+MiQ+joWkn+wQtIaBlvEYPJ8ANwbEO6tOX8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BIUKE5QnUl7O4Y7NKLquJ7yOicYrwMqf/+ONwwq/WTXFzlunGFMv3Xvk8N4DuYsJRrMbnE7EE08yscWihP/9dWJyVk3hPS58lbD/ggl0nhFcLU2/LP12OKJaZoSd7jBxy2GwexJHQmu/l7nXYxjrnBa5yV/U7Dvp1ZPep8QQNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW4wZgMX; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW4wZgMX"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c080efc1eso707259c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765054; x=1776369854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SSu59tAA0UEscYk/BFsVp3H79kDdLbYMwDyYPuSbwaE=;
        b=NW4wZgMXzMVq6DS1IkGm9QIPHZGmesHwe4AMagYLsLfhiwZM+faTPT0GI/POlyZTDy
         L8KB8WXq4Sk96kFmwamsYCa2KVztifxzfdzrvAU2e1B4tIgZvadHW1rTb0zyS9Ne6rHm
         guLEsBKGfAHcJBehu4BxWg2/syV0MvSXwAVmnRPK7zHLidaoIWUyR/2dkhAzt7jtw38M
         bJ29s5QDl1Ei1A9sG0Durd0bP2n4Z4/tYFHmUpIXVCru8GDDQm2m32Rk7RDyAgZ4crgH
         3AwMo8ugNaP8BzLuZ0yFVp/XU1vLUkKklWHRNfF1BYBjPz+AtkrZnoRqt2+rY5+JgdXM
         cmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765054; x=1776369854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSu59tAA0UEscYk/BFsVp3H79kDdLbYMwDyYPuSbwaE=;
        b=ClpXYXlSpwt9qs3dq66dgtpFyCyBKx9GtjALrdq16Fk7UBFxZjVqdXkFUT8meTxYy8
         1LxbSh3cQsjY8RbaENjB92p90/9QhrJPnKreiZQPgADG4C/W+oPP1uCam6RgFLzkC8UU
         ak4HuBG6hspxXnebu8rbpkHKUOF+91J4wA1oDE7sllHr3p2DsKkwhTO1mREqwxn+lAZh
         hB4f46hl1XKOhDNCmq0hNx1MushqtetLJeD2W6vzed1MTMoHCzjhExisXVf1oAojmz0Y
         ZUQh7N3sVv9isyJkj43nk/OXujWZK6ETF3GCHOrdSCB4Zk/ejjGcOTed4aSF1+xY97E7
         +BFQ==
X-Gm-Message-State: AOJu0Yw+EwcJK9Mmih6fUTOmVjtCw8eUGVFzyOLMBAJrrcH0m4+fqIT9
	zT3s92peIdsyFcc+AAwG3d+9NHBnid7e8Zxfz4uMrlkPjGM/DVMbCTugAkYM+g==
X-Gm-Gg: AeBDievl0tJNV3z0ARElBIF9P5t3uhnlMO/qjnn3C94qVV/rnI6xU4zAJ7tKUc8pSbj
	1iYDMGZ2Y8Xm8EZOkSa7tZnpxn4zBZdGAGCWi5XGloZor3tOpxbej/4/JaV4i8m54L+BxY1JDkx
	ULeldGFXxZhyc8xwKDlIOP2sho+Nora/Qb5y3OyjqcmkQBkcfzbAJ1lD9gCV5oawHN+LJhJD9z4
	vw9QyOW2rlh8FPxwdWOshgkC38fsh/0F5X6HHuTG4WNueDNnHsOagwftZzss3iyqQ+9/1/J69Nw
	fqj8vYVUPGs1MR44sk141wp4qHpHPqnze9ZGcwJqGGql8C3r3CdPy21FlRzq3KN9wIw6DT0AzSK
	h4L2swR/ffKYI0ETGoD141sCDXzdQxcAa4BfpDPY3jTvPRJe5u7vVC4LK4fh0VQ8IuLbUfd04I4
	BbeEwGBbkXMXDw/EgcUrn3GWBDDGc+sQo=
X-Received: by 2002:a05:7022:606:b0:12c:15ce:a71b with SMTP id a92af1059eb24-12c28c6b0d3mr2129569c88.25.1775765054228;
        Thu, 09 Apr 2026 13:04:14 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459faa7sm948786c88.2.2026.04.09.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:04:13 -0700 (PDT)
Message-ID: <69d8063d.050a0220.9c980.443c@mx.google.com>
Date: Thu, 09 Apr 2026 13:04:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6426076960302693972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fnkl.kernel@gmail.com
Subject: RE: [v2] Bluetooth: Add Broadcom channel priority commands
In-Reply-To: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6426076960302693972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078304

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.66 seconds
CheckSparse                   PASS      25.54 seconds
BuildKernel32                 PASS      24.24 seconds
TestRunnerSetup               PASS      515.24 seconds
TestRunner_l2cap-tester       FAIL      51.34 seconds
TestRunner_iso-tester         PASS      38.77 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      110.50 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         FAIL      16.39 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.70 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
TestRunner_6lowpan-tester     FAIL      8.62 seconds
IncrementalBuild              PENDING   0.36 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out   23.777 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gaa582b6f213c #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880025fe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002141c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock){+.+.}-{3:3}:
       lock_acquire+0xf7/0x2c0
       _raw_spin_lock+0x2a/0x40
       sco_sock_connect+0x4d7/0x1280
       __sys_connect+0x1a3/0x260
       __x64_sys_connect+0x6e/0xb0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       check_prev_add+0xe9/0xc70
       __lock_acquire+0x1457/0x1df0
       lock_acquire+0xf7/0x2c0
       lock_sock_nested+0x36/0xd0
       sco_connect_cfm+0x358/0x8d0
       hci_sync_conn_complete_evt+0x3d3/0x8e0
       hci_event_packet+0x74f/0xb10
       hci_rx_work+0x398/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

other info that might help us debug this:

...
BUG: sleeping function called from invalid context at net/core/sock.c:3782
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gaa582b6f213c #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 lock_sock_nested+0x47/0xd0
 ? sco_connect_cfm+0x358/0x8d0
 sco_connect_cfm+0x358/0x8d0
 ? hci_debugfs_create_conn+0x190/0x210
 ? __pfx_sco_connect_cfm+0x10/0x10
 hci_sync_conn_complete_evt+0x3d3/0x8e0
 hci_event_packet+0x74f/0xb10
 ? __pfx_hci_sync_conn_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_held_locks+0x49/0x80
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xb16/0x1ac0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2c0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x4ff/0xba0
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? _raw_spin_unlock_irq+0x23/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x498/0x7e0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x9e4/0xe50
 ? __switch_to_asm+0x32/0x60
...
BUG: sleeping function called from invalid context at net/core/sock.c:3782
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 123, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 123 Comm: kworker/u5:2 Tainted: G        W           7.0.0-rc2-gaa582b6f213c #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 lock_sock_nested+0x47/0xd0
 ? sco_connect_cfm+0x358/0x8d0
 sco_connect_cfm+0x358/0x8d0
 ? hci_debugfs_create_conn+0x190/0x210
 ? __pfx_sco_connect_cfm+0x10/0x10
 hci_sync_conn_complete_evt+0x3d3/0x8e0
 hci_event_packet+0x74f/0xb10
 ? __pfx_hci_sync_conn_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? percpu_rwsem_wait+0x390/0x400
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xb16/0x1ac0
 ? __schedule+0x7a0/0x1750
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_release+0x39/0x260
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x4ff/0xba0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x498/0x7e0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x9e4/0xe50
 ? __switch_to_asm+0x32/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x19/0x30
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.977 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gaa582b6f213c #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffbd84d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6a06/0x8920
       l2cap_recv_acldata+0x790/0xdf0
       hci_rx_work+0x500/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

-> #3 (&chan->lock#3/1){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       l2cap_chan_connect+0x74e/0x1980
       lowpan_control_write+0x523/0x660
       full_proxy_write+0x10b/0x190
       vfs_write+0x1c0/0xf60
       ksys_write+0xf1/0x1d0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #2 (&conn->lock){+.+.}-{4:4}:
...
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/52/checks

---
Regards,
Linux Bluetooth


--===============6426076960302693972==--
