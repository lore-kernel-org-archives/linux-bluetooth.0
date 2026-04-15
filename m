Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4939FD4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248578; cv=none; b=J9eIZJAV8RwKehvzwVOfCd2zcSStUCJJAdskCiSra1kfz8O2Cvb8Rm0zrXwAAVwUAzkS9syaT7DQS5oA+t9GQ84gy91JW94orU3jnwA981otzXv3hg5BiJ0mO4+orivTorDCBE4qNULb5qJavfE3F1VIwrgH4aLI0fid+LBZHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248578; c=relaxed/simple;
	bh=CcSempTPGr+RsxlwccztFLHImSGaUEM1pBIg4LHP26w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uZqmNCGsUWqA/stE+Zg3FsJjc6Kdwv1GU2yJ1+LmEA4DyI33Xb6/h0X8zKRR2vDAwAaCkDxZfmNLI8kRqDcsQO4d7Ir51DZc+JLnt29UL4MVKPlfoXb7Xt6AzVOUY2AuwDFljIDqIZYOD95hl+pxp1n2vzOGGzr71P2Wc0/ZzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHcMRKKB; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHcMRKKB"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so6613944eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776248576; x=1776853376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NyqgCkSVDF2Ih2SMpd8teCPR8rN74Gb9quekLvxknBg=;
        b=UHcMRKKBq1Ssq168aWOu4FUJhT1fMuw1PW1/jT7Ut1Dv2UDHoALKL6APqqNMy8TMjS
         djcRZ0iu2b+QGUTS4yLRXtv29rfB8picSToNX2CMbeEO3OJzNS8+XO5buZbACuAmB5M7
         sISHcoNfOA0HvkszOH22Z7zh4oUla5P99AxA7PzGvYgDX7WmJKxh5Mw+d17UOwi/SCkH
         fIxbRwpPtmUTl+bTQg9OxsdtkoaB4jlaByGFCgI/0omnOL5joEKBEsVu8Sf6z2BGutma
         8jvz1cZ8xf75FIzI/R9TVyNEe/gxT+Uw1CZ6NpjlHuYl6OrdskBD8Zd2AZkuSOyh7i/P
         sOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248576; x=1776853376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyqgCkSVDF2Ih2SMpd8teCPR8rN74Gb9quekLvxknBg=;
        b=TK46ruTlSp/Lg1GOw3qV2p8ZewwrmGs1rEXm49UtydBfXDKmpENN7zaap7mHppPmMP
         gPMwBCA+0X0LW3Niypvqcgn/E6e+afpUdGS7qFhxuLHL+7SceFbMZXyQePsQwaN4OJ7V
         Co2Wvwl1Stb0acDgPdqOf2Rihp5ysxNRcNLNxHCuPLHbf/nn2CeSLMh2rRmPtjrJfjLC
         uYeeGF7FeKpnKmhYjAQn8LVkoFwEGUNIrj3/FCZn7Jd/wVIAhRWaBL17242/2znfvJST
         RC8iLQ4x4Ep2p6Tau9FVQqrwc8/vKg0kBKr1f62BQmDmDUpHIZUv7Qaw8FMsVgyzgwAH
         W6yw==
X-Gm-Message-State: AOJu0YzL894AiNMfmU6cJJMHiO5gZ83GLA51Y/COEyCUmtCKnTQtjH5R
	Wdt1rp/w2o+Jqr7dyJrO5lmFPSXYxAyi3lRnheehdsPw5/BMPiNxtLE3dhm8ww==
X-Gm-Gg: AeBDievT+GHZgneyzdeWz11rVg+AiQzNdOv1mD1VoIKcwPlqf98L5FFmHG95uoZyFbr
	/HaRl8Wpd+kxTQBBMx70XiUetbLOt5ISGuHpbVQxbG/EGAx9R9eexXPTqFhT3JbqcWULlmvCxsL
	MAF1w5E2D29LkUrA3uofOdNMmcWrBK5rhtWoXejsuJN7K4oZ7BGRux9R28V+usCU2v/psyZAGWk
	q5PFZuUbbkSUjOW9zB52ITq/Th1enYtOKxYUtn6Isxzk4skWOfEV+1Gz/OElWamigYZYP7s020V
	bOBBVTdhdCsDmYela8xQ6+p2onNPaTcEf4na7gEe/2lGDOPgHrWJzuBUg6Cy8p8E5T0PYb/zqt8
	ffkV3lHAr3G6Ld1y0KvqQYG/SPjuawv2kCVTS17h0jQd2LBuSJYGn8r3RxhcNtieIc788ScqSFH
	M5/807Ay0YVqGDLpvtBCJCkI2zN/5BoyYn7pAfr0Lj5MU=
X-Received: by 2002:a05:7300:d513:b0:2da:b77a:d7a0 with SMTP id 5a478bee46e88-2dab77adbfdmr4035919eec.9.1776248575919;
        Wed, 15 Apr 2026 03:22:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f068b53sm1943442eec.20.2026.04.15.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:22:55 -0700 (PDT)
Message-ID: <69df66ff.050a0220.3db0.8096@mx.google.com>
Date: Wed, 15 Apr 2026 03:22:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6352504030156131344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
In-Reply-To: <20260415093953.39340-1-phx0fer@gmail.com>
References: <20260415093953.39340-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6352504030156131344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081496

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      27.42 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      579.38 seconds
TestRunner_l2cap-tester       PASS      28.08 seconds
TestRunner_iso-tester         PASS      40.20 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      115.67 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         FAIL      14.02 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      12.14 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      7.82 seconds
TestRunner_6lowpan-tester     FAIL      8.30 seconds
IncrementalBuild              PASS      24.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling"
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
7.0.0-rc2-gc0f338b85a8d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002094c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gc0f338b85a8d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.672 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc0f338b85a8d #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e1140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa064d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/86

---
Regards,
Linux Bluetooth


--===============6352504030156131344==--
