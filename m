Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FA2E63C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816252; cv=none; b=T2pJfQMoS4M3MstUCsAcDnQmAQIYSXFUpbv5I0bqejp4KJ+YYsxIMM0gjBdC4X+B2zTp9CdEoTSiWtV1ssMYJpVhW+TYkemK/tTKIJgW+eutTJAMZill+qKTlu/LFvzHB5Qp8KwEUid6GsuJi3qVBfem/fUZLqJaoMQQCwmac1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816252; c=relaxed/simple;
	bh=DqHHs8px3AEnjBJvXJuDjQbZ6ehj2PS+9V4F/7ZnTfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CK8Pu2TPXhoFAXk4Yqo8VxDldSpa2WLNo3bDRxyYbD25VnMBww6xU3BtGsxOxD/YTU7018HieOjgsx1QpPkrsOMC31qATsMLfnlpvW91UvySMSOAl6SqYcv2qHk5HY1r7WIDW3ygfSgxZDpPF99JI6JDetpnEnXcwdr/9FumE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKODBB+X; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKODBB+X"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12bfa7fe691so1410892c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816249; x=1776421049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SystAXlnyBQqEqIlltUEPMevwl4/J4bG4U2Zd1Bjwsk=;
        b=IKODBB+XQdyS4zEF+9IPNxPfOxOxBpqGx2Q3yPsnJ/Mb9TbyHAdpCH5QjZm0xQS5pT
         MgqubFINnM5yZ+G0wYCdmx/zzak3cFE8ywYnT94C7T1XINtF4oxOOo64ELvKsOfm93HN
         VElgOP8jb3Z4N/4n+iY+Z57dKB8pIsW5ZZLhHZL1rQ2pUEetUgpH6nyyExUGXoy//siQ
         x/0SSCgw4i1TNCrbkXq2ErJxBfgCTPUZyhoKc88EtLJmYmc27vknHJFmqkkzkLo2oWHP
         qsBOyOS8S8n9qkJb0ICBB/9BN0ftCsQl2bKX1tCrm7OmWsBFMGRMEiDOsE6+qoyjiXcr
         lRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816249; x=1776421049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SystAXlnyBQqEqIlltUEPMevwl4/J4bG4U2Zd1Bjwsk=;
        b=SopO8Gu8CsU1q8CNGRMvNJBszrJ0o4OyzRsNFjkPCoIjucYf89x8q2hAZ7pju8aWt+
         se7UVF81H2NdbXes0UpCb1ywKE6iNiM56+LO5KePplDoUWyQn6V5G0On6ZbDtCLwhRBm
         rnJ9OuhB+jvkwOOxsKMcju96MyaO6vFA7mgJ+3dxC+msqhcIsXZ8BgODRliMZJrebbDs
         m+nDDuJ10LriAoIWpUwRIk2A62qYsNrrA+c43KfQJ8DQRdCKFf7IJrNG0DGEKPMGewXF
         TSgv/qXfk7Z+PfypB0oK4g/Qfm8hQDdQD/WaI3iUqnjxp1RWBmLGNBeKmGQW3zTEfUv0
         LM1A==
X-Gm-Message-State: AOJu0YyR7LsIUTelavM0BUeuv4zacN3xjCnCXNbSnwJt4qyw+k4pZtpM
	puZ1TQZcmGd00nWFRXILdUub2Fz/DVFU+JMBWD6RktJacAgp5Ti8jNID9jUGZQ==
X-Gm-Gg: AeBDies6dZV9aO0j3xHAtlamS28QfBu5HdHM8mOqTPOpycIm/kSD1xGthbFy9M3PZaj
	sCsmIF4Vt8ieSzydYXMjJ2M6bYpZRJJRhsaDSGlGGPCXYRIq5Mo+HDrAlvJibHP1m1ZTJ7mTKdx
	eMJT1xjgvIKTGhcADmd1M0zDCmZaiPCH+CHaZZnzgTkjG7o43kp1pUJxFCpC+TM2ZQId6LCe0zv
	bLEPqB/GqnIv7hn+ZW5M5hQuWg+/DEULrC6i67QhvXsa0BBA12PL2WB3NG6mw36L6nQ6UzkVPUE
	GblRY8MKLa41jKFytv8LZZEbbMCXmQjpmcYNTmVbK35SLJCI/JiIvLLa+6DafgDe3jnZvwuuEgh
	WDvKmueGE/11WxDDrHbtVojpDUsM0Hy3lchF9CMKelOFlQ3nzccRHgJ/hAEnaxDKDQXxT+AERzg
	HPZU5bmGEZnIQiKmARBuoonlgzkQUdEQ8b
X-Received: by 2002:a05:7022:6627:b0:11d:c86c:652e with SMTP id a92af1059eb24-12c34e45328mr1566286c88.5.1775816249226;
        Fri, 10 Apr 2026 03:17:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345a96f0sm2772337c88.5.2026.04.10.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:17:28 -0700 (PDT)
Message-ID: <69d8ce38.050a0220.1e97ed.cfea@mx.google.com>
Date: Fri, 10 Apr 2026 03:17:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5313283267558183855=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v6] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
In-Reply-To: <20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com>
References: <20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5313283267558183855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079639

---Test result---

Test Summary:
CheckPatch                    PENDING   0.60 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.26 seconds
CheckAllWarning               PASS      28.59 seconds
CheckSparse                   PASS      27.23 seconds
BuildKernel32                 PASS      25.36 seconds
TestRunnerSetup               PASS      572.56 seconds
TestRunner_l2cap-tester       PASS      27.69 seconds
TestRunner_iso-tester         PASS      37.70 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      114.46 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      12.57 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.78 seconds
TestRunner_6lowpan-tester     FAIL      8.63 seconds
IncrementalBuild              PENDING   0.42 seconds

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
7.0.0-rc2-gecb16c274d1d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001945240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fb220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gecb16c274d1d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.724 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gecb16c274d1d #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002492940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa504d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/60

---
Regards,
Linux Bluetooth


--===============5313283267558183855==--
