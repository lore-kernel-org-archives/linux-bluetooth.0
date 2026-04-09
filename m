Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FD33E351
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765966; cv=none; b=e7Beu4yMMN065mZxmf/l04qX3N9nmjQxHA/IxWoJAfW+rHG7DAZIDHn9JEtup3S6aQBTt3q4fIfKe+cS+y/cJkQtSuYf7lGzLHQPqxwfCXbp1+nY0LImyrrgQVJVtw2eO3eS8l1/fuEZfn9vPIEm87eSH8eKVumGphenk3MrSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765966; c=relaxed/simple;
	bh=FZgxbMiFrAvnk0xVPz6CrFC5BEsZE9f4MxLsnrY68Qw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mDLZxEZmuYvSh/UNEAISkE4UxVQKuG6xrUTXtxv76RfWidBghGo9fJiy7tfz0oe6VgBU287GhDKjOeaiEf7lwYX6VSEkcpHhHbyfdCWIVGbwxucd6cz6dXr7nGJ742+SlCrKHiCUoN1YSwurNt6729Q0QP3dCo3Iam60mV9Nzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCcdD2Cw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCcdD2Cw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cbb6d5f780so107310985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765962; x=1776370762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fqntucHoGv8WCUDQeo4mQ++vMo1ugBXUaX1ApwFxGP4=;
        b=pCcdD2Cwnm6SUnN9h6G35fNwdIGHyo+qFh7j2f/jJ2crF+1koOslExeQhVZCihEiK+
         8xoKtNM4ooYGF4FHqHCLdO1h2b7mKl2dP+e74LXgSPLvXU9+SaJwuZ8uGsxh0qpar53N
         JH/vBvUH/B0ksT8uCqTMvy3QiElANXN2uNjAJo1c+lXhO7xRiwu8Vtw44WxJy8bEwU0Y
         TDTZwxhsF4d3M4pK2TyKfX04POSf/joFkMHwWBt8NdyvVI3PP630egM8YbRSstxWesH6
         bteSBBadlbxZM+yGDrYonqpJR6eynB6n2h/AQypf+ZqKhznOfJtX4NfyeEvOT1hpUcKX
         69mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765962; x=1776370762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqntucHoGv8WCUDQeo4mQ++vMo1ugBXUaX1ApwFxGP4=;
        b=lYwhTSwD3NsUIiFbbF66A90pzVJCxUT/HvtQyIqL2fz5wZkrhNUel1W9RXcHWMBXO2
         gpX7sH1Di06vj/yOfV6jEcxBW2txnJYAWQnY95SluEcJUsb+6hPD+1eo0Pw3TFeWQ/kt
         sKOCyKqmm2jjMdckhvnCncjQ/6zAas2WOYdhY2RzEc7KzNWDaKmFkRIsT2vdqmCdwHX8
         RR+JxRJ8YX7cLGnJdWKOggw08wasjJliv7RVSvW/k3a6YeOqigZfvj0/rcaSnzbAYm94
         AkRb2fVyPxIIw8+AUIiuteyg3n2nIm31WynD/b8epjr6lm6AlCFBTlUPrhKF0fIzGq3N
         6xAg==
X-Gm-Message-State: AOJu0YxRgml1FeHaG2gS6t4bXFKKDxaA7MUZEFDqmgfbjVVX5tUg/owi
	WhussIl6pZ0ki+lWR0+j8lhEL94STd34RlBOBmtX2XzgtgZgVVUtvTujuI+9hg==
X-Gm-Gg: AeBDievDqD8rMuTuPQodI6I9cIV4xJA08GRW3Oil8cLpM928L52LfEX++JnPcIiz7/X
	Hn0ECM+9lpUYAqLUWFBAOJCbWZ1ISyAHvwgwOV1r2pFxdffxsh0G+aoEMitBEl8vSiwdmAWS9Tr
	ZqECXGFFRs19Rg2pvV/gi+7RE90GY4m3dUi1jJReOHpj5aaIoyre+yvC5ercfSVbzOWE8Ga3oxs
	Lj1HgCU3kI/87m3JX7dqKQLxEAOP+xLpefSuvlyq37bVh418cOzrCfkPJYptPvGFFcOZiN2kojD
	MLyjg/Ms2qNjGJsFW529QloFT3u9d2uJ4UU37c/oxbSy7ueIgBTKxCAWid5559hwGL3hEv8yVBS
	oiojRKx2dzWCPXkQtfdIBzW8mmQtjJsEaTRuQCMLZ3LpG903RetVX8nRdt9IL3ctveweW7U1w2/
	EqmOg4sjNLBSG4oFowgga7nvB4cKyK1aI=
X-Received: by 2002:a05:620a:7089:b0:8cd:b8d3:747 with SMTP id af79cd13be357-8ddd079b06fmr40379585a.65.1775765962138;
        Thu, 09 Apr 2026 13:19:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.174.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9637b97sm36561885a.37.2026.04.09.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:19:21 -0700 (PDT)
Message-ID: <69d809c9.050a0220.1199ce.268e@mx.google.com>
Date: Thu, 09 Apr 2026 13:19:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4151515375829072922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, moonafterrain@outlook.com
Subject: RE: [v2] Bluetooth: btintel_pcie: validate RX packet length against buffer size
In-Reply-To: <SYBPR01MB78812A5517C2CED45F5BD315AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78812A5517C2CED45F5BD315AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4151515375829072922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076292

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.15 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      25.86 seconds
BuildKernel32                 PASS      23.95 seconds
TestRunnerSetup               PASS      525.18 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      39.04 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      112.36 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         FAIL      14.18 seconds
TestRunner_ioctl-tester       PASS      10.40 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
TestRunner_6lowpan-tester     FAIL      8.77 seconds
IncrementalBuild              PENDING   0.24 seconds

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
7.0.0-rc2-gd598e357905d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f6220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gd598e357905d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.823 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd598e357905d #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff88800275c140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9104d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/42/checks

---
Regards,
Linux Bluetooth


--===============4151515375829072922==--
