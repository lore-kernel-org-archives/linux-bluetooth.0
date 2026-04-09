Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237D27979A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764943; cv=none; b=UagJIVOp8GnF+PsZxgUIglfh36cyOFdOmSxHsCcobVP3kvonw3IAfkHegwk6auwYCbKOSh7APNXaxD06bymzfDIQZmrEx+T6hM9qJftvaNEQXC53DcDnhKkxfqccQ2wYsAlGvQFAXHJcMb8jP6T8ScY5SzGNzEWe0vsgc1L1JNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764943; c=relaxed/simple;
	bh=ceeazCM3mo7r3BOxVa217QytJVjAH4ywKs01tHbASxI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XxPDxeNEElVqDp0gJgDCwuzOshOPxUpmsM56rLeGVEPeBBwc1lq7MiNwU7R3g5pEANJ46ZYNfEMYaBUHRGADrMV+oVEaa3jMAgFHEQvEiK31Z9/FBCuN4b80eQI/dk9JvGqqjV8pioAItNJHjIs9+QFfS3GtxkJVBQ0xnojXXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENEz2dGj; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENEz2dGj"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c15414820so888249c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764941; x=1776369741; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F19icpN+eK2VnMAh9w5NIbf0j1s4omSVDV1OY0OqLwc=;
        b=ENEz2dGjZhpw3j79D2fcf8WFL43mhC6R5iotSxrvEdM4sXtJTW+TvJrdALCxZzenMH
         ljwE3qJAhYvDpHiRcoVZgotpxMDf7hrCCCi5wMP1TDfdzU7yOIrKa1QLbmXgfpCS+9vN
         Li+DpJL5DiLknVYMUGa2OufJ/zKWB6zEYbppnvQxX8R2Klnx3ndCEBUjaIi0EPUmvQn+
         BWFkcc0ah9oVZ3KZfT3kWrxRNcQsmElj1RvyZ9IRGX7daUJBVlJhH1fAF3EE/bfgku+g
         eY3x9XDXb/mQ/sHm5H2zqDkjgyKoshCMSOzBMfgPf+7/H31xEtTGnx5JcWc0MtdSW20V
         beCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764941; x=1776369741;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F19icpN+eK2VnMAh9w5NIbf0j1s4omSVDV1OY0OqLwc=;
        b=Z/oPiiYoj88CqBz/EIqumwXNbRQpXBVsewYIka18dgXJ9jriQqbyak9HtUitLwH1Ne
         dL6ap+V9ZgxeRttZzr6ZA5OWvDddzJPNfjwDM7uEf2xK6Xl+HGZCRSM/ztWxiGgyr1GZ
         veYPIxzuoxnXl5u+UEDXDwOUEVGIOsb3v6qvRPIkhUNVt+MHulJTCSxu+qerVh6b2Nka
         +rWAYlSWoAuA+DtcUbpYVx9Gpzd9Kn+0XwMkBXODrEUdgXjFbnnmtu0BBHqZhAqdCqHk
         CTyGFy+GSoXxKqss3hfY5Cy9G89sWZZqxiqT1GHNm7rkRN8ORyXrJQoOeBjtihEeX8F6
         jD1A==
X-Gm-Message-State: AOJu0YxCQd2Wrw+Q/ybRwhmuvgY8bgW+VSvB0yRB9IBvkzN2EztxC11T
	OgusnM7pCwrwUZQISt8GIqKrMrjZ9n1aKrv5Cwe5xWXJTRI3/7scBJp9li8W2g==
X-Gm-Gg: AeBDies1Cqm4aI3eVPqOExWs6ayi/Kxcdbx3n6u/XHwRShNLd5c77OIwo4uqUln5qyk
	VL3pGinAOIArxMBkyWLoG7jEQs/4nqVaibe5id/sObi3rUQB517ziQ8wrQBe7zPsxdp/wh/B8VS
	1FX6c4/ql805H45oZ9MS7QRd+Nk9EmZ/9jWrwlXx87UbDubMA2zYq+Es1VeW1Y7YoAC7Z4aVuDD
	+CXpcHzZScpSxHkzOzJrlXRG9z0ktyZzlhog5I60eYcwZGWduyeBMcrgHAi6fQzNcCTnTi/+Ngo
	Xcv9vcN7rTDJyoJKihGBdp9OUueLJHKWTmHT0hHdR+iigAfcs6TPQlN/8LdMFMoh+wwe3WZkm/s
	8J3ccS100t+8cYz3WzBwFEiUmuJ7w+2DOUy/rE8NMUexhG8jS29qoGaGQEgBG3f1TzVmtpIFhrX
	tXOPy11YX9QD6aLg/giKWlNPiR1gjKasI=
X-Received: by 2002:a05:7022:606:b0:12c:15ce:a71b with SMTP id a92af1059eb24-12c28c6b0d3mr2126554c88.25.1775764940793;
        Thu, 09 Apr 2026 13:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.184])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm738635c88.12.2026.04.09.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:20 -0700 (PDT)
Message-ID: <69d805cc.050a0220.5ef66.6a39@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2187797290580583818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.longros@gmail.com
Subject: RE: Bluetooth: btusb: add Realtek RTL8852CE device ID 0x0852
In-Reply-To: <20260329081324.123156-1-chris.longros@gmail.com>
References: <20260329081324.123156-1-chris.longros@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2187797290580583818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074128

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.71 seconds
CheckAllWarning               PASS      28.69 seconds
CheckSparse                   PASS      27.39 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      534.93 seconds
TestRunner_l2cap-tester       PASS      27.84 seconds
TestRunner_iso-tester         PASS      40.41 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        FAIL      113.62 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.56 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.59 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
TestRunner_6lowpan-tester     FAIL      8.79 seconds
IncrementalBuild              PENDING   0.31 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9a8f735034b9 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002045240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880020d4c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g9a8f735034b9 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.847 seconds
Mesh - Send cancel - 2                               Timed out    1.983 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9a8f735034b9 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa1a4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/36/checks

---
Regards,
Linux Bluetooth


--===============2187797290580583818==--
