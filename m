Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B83859D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114158; cv=none; b=XcSDAvJWYTQdL1LZqaFYrYF44meAfYM41M9HaFOLGfWKx2nMED5u4DrsVDgwfJG81ZUI9Ww+9xiHPHqFkLB9FAVZgYJgSs98bYPDK8ufbZ01P/dhAe5MhW6qbwZP3QfYf5tuTHsKR5bc2xQy4fPb8BdQMCmKYzB2IDVlUbUWulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114158; c=relaxed/simple;
	bh=sHfYeS/yJ/RT/Yoki8T0TvhO/ogG1d091sd3KCGrXlE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XhuDiIk0NEr6JxC1Vwo69VpdxDtygrUyP8f0heYwJMy7xQeRRQNjYJ4L1+NJnSjbmVlTbrBAzchApZlN9cuMnb9mt0Kmzvx5dzDqGhlR6nU+6md5axLcJBxSs1Ui/EsIFhQ/MjLtpEdoh+tIN+pB2m0PIjS86dBCdwjseMw5/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb4T3myC; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb4T3myC"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64eaf8aa893so4042864d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776114156; x=1776718956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LLBYcL9eBHLjbmCfEQy5opHZcaSCAPGHTDHWtToZ4Ek=;
        b=Tb4T3myCwdozgargerN9eLIMAW495nYFT3kYTY4ImAeNeA1M2B9L9kmfnlsat8C5Un
         MTH8vZpv5R5bREdijqZGH0mGUew2nz1Z/lQpCHjgrpFl+bw5AJ8aE5v5gjvoW3YEg0+a
         KrwVGyEtwpXGxtovcF4k6MQya9vgtqAneSqvGIMK/0EMpYC4DTvEjD8oTAxLNJmaowBb
         Tz9o206cv247aPbU94ClqQgA4eiFdimCNEnJNr9Yl8rahcBbQiOVCGh7JbatoMgGWYnq
         0DhJK/CyAtncGUuOtwvzwPOkpvrHY1cUKjPArsg2CLXct9WDi4uPNjffr4p1hphGi7SM
         JZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114156; x=1776718956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLBYcL9eBHLjbmCfEQy5opHZcaSCAPGHTDHWtToZ4Ek=;
        b=EnNQ48XPC5KMgYYgfH2ihQxjXVFdRlsi0poklbJYhD8zMSmUdENWHIs21+onKzaZn/
         ivasxl5ezoblGIKjEXw4IrVPyIyj8lM0KLYfBVmcix/7O0gn41/hZaD7nhyZAAnjn+yj
         oaa0q1RxNH3hg672Tz1taM+PPw1FQ411aw2mjfgi65E2KoWPXUwITO4UNFztd1Z/vxkE
         eHXI3lZWFl0nS+2t5H6SAxei1y3BBXFdWvtugN335Z/XkVnxqFnEURjMYuJ/Xo//UGU9
         nPkdEWOnyNCVPmlr9I9W4PJzCCMw8D6ODEuf1JvHhr46IqTIUHx8VODNRcYnN25CtPal
         EapA==
X-Gm-Message-State: AOJu0YyjZRDo7IqZH18fzBdRGJwtCXhYfwPFqhmEORwIN9S3LviCuxuj
	aUclYyXwmjJJk1rj+mimr+51XX0g0+0AGRdXy/Lp6G4yjH3NsoLGJu6DTs6bKA==
X-Gm-Gg: AeBDievCn50oo895hjwz9bb702tgTS9bRqMQvvjLYPRrKxLsZsA7hScnMjHn4QX3hNj
	0P2Zf6wzQ7hXe7Av/kQ8EpTdz0xA5OBdp0TjZLtIC+0fqUx494Tx2j9UD7Xrzx/du+/jzaim0aN
	hdAxRo1pZ1jochhD2kxwDfGpTHDhhTNs6OZwZ40e+KDkbH7DLOcmp1O8SJBqEmho2eLeJrrtWmJ
	ccOExXmihp2zR0veBuyZ3KrNmb9a5YlCgohShEQjU3wjp31YmE+Fo8wglugVtpjI05Y4pJenvJ1
	G0vMjVt+d5rGpqvyBj2PlDKeZ4p7yKQldbMm1kRDNmJb2uYrVQ8Yfzxjd9wA6XGswBZE9sWmLkB
	2KFZbOZBIhTWUQDWyPe19w7QUn21B0Exw7Wjk5bxVASaynu9LmGU/R/gZ7czyEQc+7zgWXnsax8
	i6byjVQK4I0iyDSKqG/YiZsq975q7QR7k7Cst6DeE=
X-Received: by 2002:a05:690e:4801:b0:650:3bbf:6a60 with SMTP id 956f58d0204a3-65198b48573mr10196117d50.37.1776114155739;
        Mon, 13 Apr 2026 14:02:35 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.152.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934dcd3sm984516185a.34.2026.04.13.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:02:35 -0700 (PDT)
Message-ID: <69dd59eb.050a0220.291763.78bd@mx.google.com>
Date: Mon, 13 Apr 2026 14:02:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8706073956643357179=="
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

--===============8706073956643357179==
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
CheckPatch                    PENDING   0.00 seconds
GitLint                       PENDING   0.00 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      27.14 seconds
CheckAllWarning               PASS      29.87 seconds
CheckSparse                   PASS      28.56 seconds
BuildKernel32                 PASS      26.53 seconds
TestRunnerSetup               PASS      580.32 seconds
TestRunner_l2cap-tester       PASS      28.34 seconds
TestRunner_iso-tester         PASS      46.27 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        FAIL      115.20 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.50 seconds
TestRunner_mesh-tester        FAIL      12.22 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
TestRunner_6lowpan-tester     FAIL      8.57 seconds
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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gcd52505d5434 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002090c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gcd52505d5434 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.654 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gcd52505d5434 #1 Not tainted
------------------------------------------------------
kworker/0:1/14 is trying to acquire lock:
ffff88800275c140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9a44d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


--===============8706073956643357179==--
