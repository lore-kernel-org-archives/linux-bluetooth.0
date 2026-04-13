Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C881DFF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115491; cv=none; b=ciFwsAkUpb4rqyYS62A/ISfZir/0lCcRw4/sB/G2286wu5LzmzjBg88e2mUwhjZYcoa3NOco4MSuhkWjD86wXH410aidEhp0T3zeQnKho44O6ITS4TlRIC8ItbDuq9TzWr9oL+P/E3bGqlSyF80ys/J5x1tEQ9TwgaXjlUvqXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115491; c=relaxed/simple;
	bh=CrSRb5YuifBrG25aau4Ds+KviK6lF8ZauBf70clKKag=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WwFndiPPLOMvFaRXvmmq5RtpQ1sA/jTU4Yb2BPQhjEggNHfRHzdIu2z61gz/I75r9FXAau4zxTzs4iq+s7cqeTStJ/NQ7F3znkEFbCPtLkCTN+WFvBdI1sG54kpBS62k6cuLioCwVusPgXsxscjqmOGMS/kEYViVYyxXX+vPcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmfqSCUQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmfqSCUQ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6144877aso51975051cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776115489; x=1776720289; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dFJbyKyuwBrH1bkh/TNO2XVzHSIKWBkdM0SHiC8cjHM=;
        b=YmfqSCUQWHSGZbtTcOLLl0PNqnVS/MfBqzL2RNDnEZ6Jp9a8Ut+wdVZyNbRXLfQxTy
         b3fisCP0La3ox96zb4ksN6+t2J2vS7Bxsc2GapvnXkZr1f02CA6BWsGdtaHwavsIlttm
         xL8mU6/TEkqvnBMzycroDW0WwZO4pJtmhs3r3MAdGLvepbC7yLftTEGDvMobDAyaLZut
         vZ5ISbn8aGfCBUqH+SvCbHdmJksg+Ke4asF95OPZGnvA2JS9qb9HsiNmTV/x/CDZlIlh
         VNISkKnwwyUh/jCPQLBogXpz0X7WDNgsoK1yXxy53JUa0iYJRMGAXWkSdyz51w1SnDgZ
         7rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115489; x=1776720289;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFJbyKyuwBrH1bkh/TNO2XVzHSIKWBkdM0SHiC8cjHM=;
        b=CfK2qFZCGBeYYgphL9juzF3e6Laq8YfvDSJsV8jJ0r3POCapFiWJfuAdr7C/rJa+hJ
         GfOAweHCp6v/dKQix4VRt+os5b95zVpnm+S9eAZ5nZvd8TnhL7savZL/dV3Tz3jc5dMt
         64wZLIOVoHiqew2R6+dzFNWv5rS8K4ADrTFiaLBL0AoK24CZgQXVRdth7QH79JszMHCS
         zQQsyp9kJnGqz5CKUYInhBiXOlYsrU+oO+/TajIOOs/PprDHKeaCAewSDv1JlHRn3iVv
         rgvonsJPyj023uj2209ZgkrloB9AX4SkukIShQp7RQh1nGjTPyIo8BvbGR1q7n3zYz6m
         YHpw==
X-Gm-Message-State: AOJu0YwiqVR6xCcJW7/upGpXDhOaSbxIOKUfAKzDjOa8D7Yn5rewVGQL
	jOzlTdcr/TLKnnE4BnS1e/RCZ0YD4UXc8uAgTBjSVHW0+W9KJ5YNQ+5Bi3NOKQ==
X-Gm-Gg: AeBDiev9kCJBGHW+nTrvCt7tu9IZzl+edHc0WZm2x22Tkl+W4UlX0wnncosaVJ2abbA
	Jx2z5/zSw+ZbwFUoM5MCmu3so7Ms9pqHFhR0Z5N9/qiYAAPhnTD2l1/ys7PJmjo1pwOYiQsVsoG
	oQri2LvYe2WlkYdNXvjygObWHdp9ziF5uG+44piqzdvbSonj+Bo6HKKB3XzwZoIrISDjoKwOH5f
	R5Ycr+OQwFqgmpW6SBJbJHLWxoHM0jLIBJ5fzakNJ8QCQPYixbIoCoz4cGwX8ywhMwk2Bonu6DI
	Lck2UJGwokZO7LxTy1V9xn8AI1jDMYizidup0xWKCFqN4+Z/O+Wpc/VNGlO9Em65hrnYKtzwpE3
	tJdhjO+427/fF9ldEg/7fKKXfaoG9YHNX1acWgu9gh3ut1vQcyeKIWywG1X4aobaN9O1DAAKe5h
	G425HpkxvBa1pkVgNjyDOCYiECb6+ROxg=
X-Received: by 2002:a05:622a:4a08:b0:50d:9174:cf27 with SMTP id d75a77b69052e-50dd5ada552mr214023021cf.20.1776115488921;
        Mon, 13 Apr 2026 14:24:48 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd541a559sm93765691cf.13.2026.04.13.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:24:48 -0700 (PDT)
Message-ID: <69dd5f20.050a0220.184cab.a397@mx.google.com>
Date: Mon, 13 Apr 2026 14:24:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4532464391137069883=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
In-Reply-To: <20260413193212.1014200-1-luiz.dentz@gmail.com>
References: <20260413193212.1014200-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4532464391137069883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080874

---Test result---

Test Summary:
CheckPatch                    PENDING   0.00 seconds
GitLint                       PENDING   0.00 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.47 seconds
CheckAllWarning               PASS      28.73 seconds
CheckSparse                   PASS      27.39 seconds
BuildKernel32                 PASS      25.21 seconds
TestRunnerSetup               PASS      564.47 seconds
TestRunner_l2cap-tester       PASS      27.72 seconds
TestRunner_iso-tester         PASS      37.92 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      114.53 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.03 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.21 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
TestRunner_6lowpan-tester     FAIL      8.40 seconds
IncrementalBuild              PENDING   0.00 seconds

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
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ge28a9dbea782 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff88800206b240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ge28a9dbea782 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.950 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ge28a9dbea782 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002760140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9c44d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/79

---
Regards,
Linux Bluetooth


--===============4532464391137069883==--
