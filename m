Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A93A8F7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766106; cv=none; b=FQ+h34dw9gdIBZai4Zjbx4Yv1I1b3hIDLw4EZDcd+6wwet4t3TYLoLeOa9VBBI/BpWyHHiAeM0ShMd+tHs7C3GuS60cVhwI9TM1fCqWSK0fxwZ26jyV4U+FCffPVeZOsm3arYc3KRWlWhhqZ1o7vfOS6/72wZx8aPRTL75+jNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766106; c=relaxed/simple;
	bh=hZVBC40SGurSB/4Iv5Dh9pjiHTu8jcz2I/9iaZy3UUI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TMrjyFu+iJnt1kMrFgQ0oWusB5eyur8F+MCu06M+g9bwtd3EzzkApGgBG+XVVTezuu91hoyuWZmfFSu7mUsTEma/LsW23EDfmNHWLzVWMqpCBNGCLkhb6Hco9+eyYQ8pr/Yp4P2uSV5XVT5AN7nUxj4fKYqMDespY+Yd/yYSS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTUZR+YH; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTUZR+YH"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbd8c6fc84so818661a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766103; x=1776370903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8jo0YQQTt12hBYjkfrql5OIujMBB29vc+EZdfMNUUBc=;
        b=RTUZR+YHowZ+7ek1/CSHGDAWshZv335WE3056NTDOdEw1zJqOifzhjAlwxJKpHlEl4
         khSj/0mF9rZ+38T20StzcIJTAFG+XLket62+T1oEzss7jQ2aT4a8935f7HuM0zEo8uOX
         DyhpvGS1w8aFVR2NE4jS7DlxjIWFqPP4CVDFgDN6UtJz/b8JHuqTvXhQzOFk/yB4sS3g
         B75piU+k7eVYvC3YVg+jqQS5Wg4QQC8+XXmexF6ZeYFpq5hz77GBW+u8/lxM0VLqOZ+M
         9IjPxsZt5EXmykWzYQOOJ2QXkLTQkJjRS2z1q010nw2LpUZpJKHPcqz+4gcHDnGNT9Mz
         +3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766103; x=1776370903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jo0YQQTt12hBYjkfrql5OIujMBB29vc+EZdfMNUUBc=;
        b=Yvy2y4i74DxT3uR0Sj8HL6q5YK+mwxZFJye4raoy8G+qFgARi0rBCAwMZcktko4Sbh
         hmF26eJ8PX2x25Yi2wdOvqYBkSRZgYfR02hT6CkVV/vXZ2ej+PzWJXRvqlcn4VtEVclm
         Q2pa/3qxarJvzegfnIVqi9wCN7XjZsx5vtDvodQvuRSUyTLhJOQ6UywIy5MIPtUqrUft
         L73d/bQEPqjwQtcm+pgX0/fj0588C+6PAgFUd+nZl2zMQWRt/XraF4pB3a6IcxZ1uvF5
         O++FMyscOdRYcVpoqR3dpn8T55G2JcM/rsRYNquz+U90/p9FfPdZpNZyEoPCxHK4LWNS
         t+0Q==
X-Gm-Message-State: AOJu0Yx3A6FbYzxgdanrGGzDxUcwiD37P7OvP5jA/88w44dtTt/lnuOe
	oQmVHDrVZIGi5Vdk9YNfuPP0pdm8J7FUjQDurN/zFvamu2Jw+aVomMVl10JKXg==
X-Gm-Gg: AeBDiesSy6MK7yraq4aOrSbfvNwD+1uQ5R1mqUB9XFlmbTXOcXdKIZiLQhWr4SDlkgj
	FR9Hz4eSJMtFwyJdiFT9B3+t9YA1BWqJLVWqs9AJFelwutByi2Hh68Fnu4A4TCrDtN1rNm8g6pQ
	79a5Zs9E46Jny4FqJhZRhU9MZpRStD9lpdZbJfcDtg0znG4JTOnpKDFRpdvRCtMrw+zfYTeTg7T
	AlAyleOz0g6QeE1+b2An2FL++GLfCDhW7J8nPnHC8n0w9bWeOFIR6NyaQb+ya78+Yxu7smWWc8b
	v8OyjKM4VJAg0s5xCFEBtTAwFrHCqsToMi0J3dGhUKTGLO3AcPO9gEb8ZkLMhKEKPfLpUUGOyqO
	qLOhOdRE6tA8HPrKbomsxhq3ujNdffEELf0xriuokqvoi5tzodirFFf1DLkz3KYOExMJUMYvnNj
	yyB6x37cFiZOV6D6cD6abU4vyniouGKdU=
X-Received: by 2002:a05:6830:82e1:b0:7da:557:b9aa with SMTP id 46e09a7af769-7dc27c63d59mr422554a34.6.1775766103302;
        Thu, 09 Apr 2026 13:21:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.167.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2664157fsm530459a34.12.2026.04.09.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:42 -0700 (PDT)
Message-ID: <69d80a56.9d0a0220.3a66a7.58c1@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7945929927189248453=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ebiggers@kernel.org
Subject: RE: Bluetooth: Remove unneeded crypto kconfig selections
In-Reply-To: <20260404200645.28902-1-ebiggers@kernel.org>
References: <20260404200645.28902-1-ebiggers@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7945929927189248453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077352

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.48 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.46 seconds
CheckAllWarning               PASS      28.80 seconds
CheckSparse                   PASS      31.38 seconds
BuildKernel32                 PASS      25.59 seconds
TestRunnerSetup               PASS      565.96 seconds
TestRunner_l2cap-tester       PASS      27.91 seconds
TestRunner_iso-tester         PASS      37.55 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      114.21 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      10.56 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
TestRunner_6lowpan-tester     FAIL      8.63 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gf37b57a3b774 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880025be240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gf37b57a3b774 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.812 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gf37b57a3b774 #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff88800277f140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb7a4ce20 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/46/checks

---
Regards,
Linux Bluetooth


--===============7945929927189248453==--
