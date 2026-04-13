Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F523AC0DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073296; cv=none; b=uM8X8YQiruLmgTcbuzyy0CTeSvLnnStP8IYUQaiDiQX1arOHkxuM/VkH6TBQFSTN0arT5GoWSdlPFz6kHDYtXdGRDQPK+XKv1nLc9bcjpki7XAzIT6km5NgPRgLPfN/DdjD7tylquYzIwNEw3UYkQzpXSHBUZZNU511KdQUYy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073296; c=relaxed/simple;
	bh=yUC7hH4BSOmLgNhr7e6VYpZKqSSSqZcj+527ogzVz88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O3y4An25RNJZJuLAQHG9ikVZ5d/qjRK+2o4dAMHH7ipg49ECxsrjZD8HLISNZ6CfBd+FYxWvXdI7wa9aBr07J0SsmJ65bEw/CwDyvYUyvQGVkJOZMTIdipkD1p/KoE4r2XYgwP1P0fUdtFwtQgBA77Fhga35hp4N231c5EG9XmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y69tn10u; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y69tn10u"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d560ede296so488599385a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073293; x=1776678093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1fGjwXyS+nXjdZU0GG5UxKmzLHDROeSBVVLzNcTU81A=;
        b=Y69tn10uFalC7cPUTpJnMYHNdOBiTegoySO4sqnhQLfdjB3h8J/sbObHc+8UsravgU
         8Ai83GkvNbNBGzUH3IU/WKDrtdoFTxwDY/W9WlktuaCEZveTQon++aL8B+d2OGc33ZYC
         0QiOE0UZ18jNWFaomvL2jyLci1Rgn1/F/cVzTF5Qf3oVP+kU0YBECQ1/rOLFXxD8aw2m
         dpN8NxKIR4n2wTPi+KdD00nQjs9FGCTAu3c0Ds4jAfejBZeJpKAxBx+hXCwmyZPqnqh5
         OrkV72t5Qy62z9KxNcyQVnJ2thZXzppqJuV1sbxOxzlH9CanTxIf3/zjukhfizd2dFch
         u+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073293; x=1776678093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGjwXyS+nXjdZU0GG5UxKmzLHDROeSBVVLzNcTU81A=;
        b=J2fZtQnyBaG6q7SCS9zRJ/x4gAF9SXa5Ylvi3a+i12VDJIE5RuYDSLdH38g1xizjYh
         p1ctrNG88XPK/0XBPRuoCGiJXUjFe0oMtxAuXr3yuvUQ57UEjmVebsLRfZ/ICH9Yerpc
         UvfchlhHImHoWqkBrsb18a/xXxjTllOduZFcu6RPQKk0lAWNs19+rhWRJWe5+knDROxi
         N/1ZqjoEfiu2CZ/fDSFohRUSVYgK/blMFGrVmmzqxUx0dyGjcomln8nD3cYvAaH9xpLU
         uO9EIPjHfA+N+xS4gdoyJKFw9tPllWm4nyLBLZoQ05noSGqYqPHFldcRvoEpy7jlxmgr
         sHrA==
X-Gm-Message-State: AOJu0Ywkc7tQmOU0mcek6db/zNUHAoTitViUgnJU8h49X1mz6CBr8a2g
	ZS08EAKsd4qj9/wn9Ef2aDeMV6g3+Xh31K2/8fs2PX5oZyOj+hw0gjsBu07b7w==
X-Gm-Gg: AeBDieuXUuxCTv1CwSleUdLrnTZhBEpD2GuTb2qbh/U9pL2CtA6xdyN8iGS/NQjCMWi
	lESAiGVcyvIBzX4ifn6NyZbOGHGZ/4wXlw+zsP93WdBxchm5LWEDUvP+HMvM3TDVooTXv+FaSqp
	9h9tlxFo+Z7WqeaIijJgmoC/m8eXIcIcmkHDZNPIwiko71bxxS6uk7CMAcJTgt9+VvR+2yRHcAv
	H3NGVBHhuOte/dnwSfMpciJWA6PWEaQozYUBUHgCPXl9HGC1JDTzHPTVErjTPhun88tqJgnr1Ri
	9oQQqMJP5KsqC/V5TEvhc2gME1tKFaI0o6err4Ajh0aomaSca0+4bwatSN3ViIwR/L6tVjjwSmM
	BJKVOvn8QsjxssM3drTHasQYGS+UqkBQsGGslCpMo9CptKm53fQ6zM1ggjW1ZrJNNOFxrHPq3+V
	eXIG5Wbm4Bpg9DpOlKAn2ek2aTYTMiRw==
X-Received: by 2002:a05:620a:179f:b0:8cf:d510:3b5f with SMTP id af79cd13be357-8ddcf1b7d26mr1694993785a.31.1776073293137;
        Mon, 13 Apr 2026 02:41:33 -0700 (PDT)
Received: from [172.17.0.2] ([48.211.211.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm804836385a.36.2026.04.13.02.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:41:32 -0700 (PDT)
Message-ID: <69dcba4c.050a0220.209e1a.4997@mx.google.com>
Date: Mon, 13 Apr 2026 02:41:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3235576929046218931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: l2cap: Fix MPS check in l2cap_ecred_reconf_req
In-Reply-To: <20260413085600.75248-1-phx0fer@gmail.com>
References: <20260413085600.75248-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3235576929046218931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080587

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.08 seconds
CheckAllWarning               PASS      29.06 seconds
CheckSparse                   PASS      28.35 seconds
BuildKernel32                 PASS      26.03 seconds
TestRunnerSetup               PASS      564.70 seconds
TestRunner_l2cap-tester       PASS      28.13 seconds
TestRunner_iso-tester         PASS      39.45 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      114.54 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
TestRunner_6lowpan-tester     FAIL      8.75 seconds
IncrementalBuild              PENDING   0.26 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g8a170d9e02f8 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880023c6220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g8a170d9e02f8 #1 PREEMPT(lazy) 
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
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.733 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g8a170d9e02f8 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002777140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb964d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6465/0x8910
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



https://github.com/bluez/bluetooth-next/pull/78

---
Regards,
Linux Bluetooth


--===============3235576929046218931==--
