Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701A1F91D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764896; cv=none; b=tTwdlN/7CMwElOaLk3p5wStjvoFN/Uis2sH5Du5necZCQws46KZ1B1VHznltorNX1BBCMBis64N7JJyhu2+3x3YjkLTnS83gqex+qp4IM9wqyhpueRgDyNatcuDLRUjLXE3mmZEedaZN9HiN5R62GVPcUSqzRzUYmQBLOejm66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764896; c=relaxed/simple;
	bh=Fjxk4JPOLx7uwoumNL1hNd2eiegmHObr76jK+R57JYQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l1QIGQqReaZt2WP1Z5apw2ZcNw5McfjFhpaO7pN3wzWtCqf/KreSOJUAZkMyv77ooJBJoazUgvPvObmthFXgmLCUXNbo7zXG9le/4VbPyKnT3z/RMSQ1zguxPu3ESuhN6nhExOJefXHEpaEo6qjlZu1ZRnuzOe8u9ywXgGSGqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HknTfFqb; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HknTfFqb"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d958880ecso452382e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764894; x=1776369694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H+An/9OgPjSgQJ9wqM+JJQ/3TtE4tO08AF9wJeea6MU=;
        b=HknTfFqbvXQLwDRJ6sPFWwaZBWV+j9DlvnBEczUEo+4/QgzkMzqgdSCE4W+qmNyctO
         G7LXr+S3H0roL8GoYoA2TfeH7hhLQglOAVMOELeWBVdOluIsjSy16qm+uHV0yJm4+9yx
         5BwvcWvEQ8bg16yHlA3ukfgebdV7TNoWm2RIe84P01vlV6AimBQJf3QpMI0sn9Vm5enj
         GeIp7WIJnx37OhUyK1Id2XMQn9Y6raoIQhLapoJws22CTjjuEoImKqzVodLC8y3NB6uv
         egI4Dvm1cuyhwia6E2PDqYZgNzm48FpsKQ5IPLxuamCXedWE26j6gEOL9UXbzPGWCYzF
         Y+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764894; x=1776369694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+An/9OgPjSgQJ9wqM+JJQ/3TtE4tO08AF9wJeea6MU=;
        b=BK/+0HYX3zErvtHoXBuR71u9S9Q9IV1PyUXVLpIQncS0zFWN6FsP+pkoaMd/dxO3Ng
         ERMV6dxFw30QjYNoAmWF8VFVdZ5FIx+5m+65GyGCkymd4wLZ64QF9H3VWVcn76UQrkea
         8BSkyGC6Vo8RN0M2cXBx+TvjOwzexiWFAYqVkfKbEoQYv7ldr6Lqi+p4yRjPy6DOsNSc
         zy2aEDO7ypupG1VpEyd0/y52m/Symrkp/BxekllV/HauDb/EzXuIcA8EQwTrmjS5kk0c
         xsJv4kIPzQQqZ4CdF+qXt3nxBaWBy4RUraWfD70UMIWPfDdW7aw41JCi1C3CqBzfYQKw
         lvig==
X-Gm-Message-State: AOJu0Yzq5lEedmtw2tI2bjkCSb7LnBAmu02004J3qnhAoVeWBoGlTlyb
	qhzGjTjOcaOXOvowIHlWGoPDJYmZ0umAO+l+NXVrO+c0cyGie9J8LHTTlefa9A==
X-Gm-Gg: AeBDietVNOyctCwqNfoxyVJu3qEbzb7tDt0ijZdLDlDQ/n81wdIqWSncneLgv/udneU
	VVFw8aqf+rwadBbhjMtLyIqC86a3QEB6qkiAQe/ApEnvxk+xdMBka7sslytvQPTC1Qlh/YbW00A
	uyMC2kKZ6GtuPpklN9YMJGYTg/tb/2tAS+9m/FDTtGsP/PX4+/aMrXToNgcjW+VAiRS2zCI3jFm
	/qAtgqIxo8q02ciyTjX8XQAbA0YV139ZY2zJKHs+cVNkqilhQOiL9wP9Z0AGXjnTekSoDNUIdHG
	WCP8xdRSXcOeuATl40Z02zTApOgN5WHPv/PdnBLGgx6kXDJT6/n6CM6CZc5xmkIOsXyh/eGCpu7
	dOVpnGPCzbshCaTNZfsAKoNIGt6F2xijPXqArfUAFR/j6qGNZGwwwK4eD358j07f4801lKmfjvr
	eWIu/p5/4hivjCSpZ3cjojtb+EzTozWh4JIzXnCRp9
X-Received: by 2002:a05:6123:14b:b0:56c:d66b:7516 with SMTP id 71dfb90a1353d-56f3bd5a74cmr266940e0c.13.1775764893395;
        Thu, 09 Apr 2026 13:01:33 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.159.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c88dd6sm4133596d6.34.2026.04.09.13.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:01:32 -0700 (PDT)
Message-ID: <69d8059c.050a0220.2f13e5.cf9c@mx.google.com>
Date: Thu, 09 Apr 2026 13:01:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4839448991958303428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: support setting send Time_Stamp and LE Read ISO TX Sync
In-Reply-To: <08692f3273776c975e6bf5974c77673a28dd0236.1773245666.git.pav@iki.fi>
References: <08692f3273776c975e6bf5974c77673a28dd0236.1773245666.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4839448991958303428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1065140

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      25.19 seconds
CheckAllWarning               PASS      27.58 seconds
CheckSparse                   PASS      26.99 seconds
BuildKernel32                 PASS      24.46 seconds
TestRunnerSetup               PASS      528.24 seconds
TestRunner_l2cap-tester       PASS      27.63 seconds
TestRunner_iso-tester         FAIL      58.02 seconds
TestRunner_bnep-tester        PASS      6.78 seconds
TestRunner_mgmt-tester        FAIL      112.09 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.33 seconds
TestRunner_ioctl-tester       PASS      10.35 seconds
TestRunner_mesh-tester        FAIL      12.70 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.80 seconds
TestRunner_6lowpan-tester     FAIL      8.88 seconds
IncrementalBuild              PENDING   0.30 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 140 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Ethtool Get Ts Info - Success                    Failed       0.116 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.130 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd45675a8dbf8 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f7220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gd45675a8dbf8 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.753 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd45675a8dbf8 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8ae4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/20/checks

---
Regards,
Linux Bluetooth


--===============4839448991958303428==--
