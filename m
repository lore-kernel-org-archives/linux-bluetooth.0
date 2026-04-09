Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6A2E4247
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765154; cv=none; b=rASyRzsD+i1RhXU/sUoHMilBRqEBNQfQ4ZlO3q0FEPAsxEacLWlUlCZut+V9qc+L8SzfCLPV82CbgKyETJoIFhFZBbnIqhyheeXHZn5TLj91X0z+5MhAWOitThiT6xAdyzLU9yqQTSZitPEF49nSzrnQ5+D9qjGE8ufm7VBOvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765154; c=relaxed/simple;
	bh=A0FrIYUJC7scCD6i5FC26TU/lax/4xLT5cLfLQFBrm8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bGTMGMN7m2fs6DlE3OUiZ6T+AZqboNm12kZUiyY1ppOB7gpeoqnEQW/z/ClPJRA+yoks5U3Rr+Y/gv4jYhiGJEdOhOB2GDHrR6g6HmpX84rr42lqFRLDHTLdSe4V6D424mmFz+MS0l86woSgXl0wXIZG1iGMgfQM5dEOXUOIVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI17ZsvO; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI17ZsvO"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2cfd69b564dso1774827eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765152; x=1776369952; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjm92osGo+88vJ8dlllD0Yls2tBW5QDmwA5iI5pGlDY=;
        b=mI17ZsvO+drYNnasgRIO14Kl/fUdFlBsfDijQHflAt5C1cQT6ipEGTgEKuMKOORmMU
         RHOZws62SPk4OvL3CV+hH0CMUYPO+9Zu1kk2QvC5s87F/4FxnF4+JbyECLOInAB6YRPH
         gSxv9KImyibRj1j+Noxv/8d5WM8D9sjlRQ6XdnBlfIJrYD3ztJefYczHtlvPv2644Iyn
         Jg0WYg9GFFDJERqX3/owQ+BpTAa5VID3TZo7v790WAFCkueu6PGLQzl9BYmHI7S6XgcM
         0c0oN1ZdPPcyZWVBFk3NKCcx0YTg+xYXFtobB8DYwb+NbtTz2DU1B7iPJ6p3V9PSHPQ6
         Crag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765152; x=1776369952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjm92osGo+88vJ8dlllD0Yls2tBW5QDmwA5iI5pGlDY=;
        b=W8zMs6n1Oz62Z6K1iSPc+2uU0QjxW/EioLZNumpXUN83G4NxSCbh6kxqztmcKv61SK
         DAvWCdtUVMoXna3Crb5cuiQTf4KkGgwEX7ABeNqFEG/yyXDv4PW6SW0Nl9elqLGpb6Cv
         AauLAKyytnKxaviKjQP24pWm0OAqlFlqSKRUV+lVY0JA7DUlWDQNg3c01vU90+Unjw4G
         JjqOlazh/g5Q/n8TDN5e+3kR94m0U7wQHlX3Qc3IhONM5kuffq2A1iBmf2pq2DfQKAcw
         mjS4mA6e6ssUcmPcxB88Vp2a3AqKkw3E8XQ+0ijky46HHcJyXniFORdXBHsqu1xBWISX
         U6Ww==
X-Gm-Message-State: AOJu0YxlnCGEucgybR9BLDjo+HrShyKwEc+SMJ6jhlQ2PihGYVbfr/Ul
	SP4I9Lowr6agmpthXyFqBBvrp/MRZReiz9YNwgqGxie8i8Ime8/zD6lKxGBacw==
X-Gm-Gg: AeBDiev1nzBCA80atmdNjOZoOyWP2BPXpnC3Weus15hv1V5QcfShIc8dLfqdp6nTApD
	UMRLuIdcwc4RQBvliR2dMFfgzWxiQSs+W9xpYx9TmPhJq/u+0QMPbocZSb8gOoGQORl7oqKwxD3
	8aXSgobXTq0EE3tsDzprfl0cqcV6FE0vlZDOfbJemKov5PQfsVXEKa/96hk8Gn9v39a5SQWvWDG
	boAPYGg2rBYhK2orPnQuDOXWxDrru1Y6B8cZrWf7zzJMNcMAFqUjGZ2EaU709fcQ/VH7WBehNTz
	BhGTICpKH8IOL/i1/WpmMLY1xgA9SFRFT3r3NkYsb52dtg0BXyzi9kXya6ntyTV4OmviaSQu131
	IwcSLp1rwbHIC9dX71xNQbFSnRuXWII2PAj6/7Q7ZxeHnBcb1FR6RBUpUEvp5rLc4wPbFWWtG3J
	r2+FhQF2oDmC/rIrJRxrmFDuWzKsI=
X-Received: by 2002:a05:7301:6706:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2d5881ad264mr332299eec.14.1775765151460;
        Thu, 09 Apr 2026 13:05:51 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.63.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c6b10sm1158783eec.5.2026.04.09.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:05:50 -0700 (PDT)
Message-ID: <69d8069e.050a0220.22f54a.5b65@mx.google.com>
Date: Thu, 09 Apr 2026 13:05:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4632784623394116640=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@linux.dev
Subject: RE: Bluetooth: btintel_pcie: use strscpy to copy plain strings
In-Reply-To: <20260401164622.752376-3-thorsten.blum@linux.dev>
References: <20260401164622.752376-3-thorsten.blum@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4632784623394116640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075961

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.75 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.79 seconds
CheckAllWarning               PASS      29.73 seconds
CheckSparse                   PASS      28.43 seconds
BuildKernel32                 PASS      26.45 seconds
TestRunnerSetup               PASS      580.38 seconds
TestRunner_l2cap-tester       PASS      28.76 seconds
TestRunner_iso-tester         PASS      40.49 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      116.59 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.59 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
TestRunner_6lowpan-tester     FAIL      8.59 seconds
IncrementalBuild              PENDING   0.49 seconds

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
7.0.0-rc2-gd1618b48ce77 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fa220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gd1618b48ce77 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.822 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd1618b48ce77 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e1140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb7a4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/41/checks

---
Regards,
Linux Bluetooth


--===============4632784623394116640==--
