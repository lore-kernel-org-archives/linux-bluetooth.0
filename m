Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A434C989
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252121; cv=none; b=r3L1qZWvJHnZPibqZoKGr9soy/zyi+mXq2tDQhfhUo9tTA1ZEFT++xPWly1hCkE/ANKylnTd70Kcubo96gYsLGcUu+VsI8/cpB+KWfANjYircQv0FPw6kiwe7S1c06E3ecJ4FC9poVVf0leLC7yZNilnztyXhbtxme4QuCDmuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252121; c=relaxed/simple;
	bh=7IdzDXLqAzj7/Z+ufzRI7HryTCAOtxaZzXXnm9mr7y4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PdHcNynpI+PnzdujUhg7jSnjNP9ue87zydMBY6kb5Dl+GPtwsWh7kigXMxE6SA8/DUZbnlMLrXSgKH6sn0+q4tDJ4Vpl3BZ8aB43raPFArHnBD1kjW4b08Qzugwrt0EfkObrG2SyhsvmXJ3FngMigtuyOEcW5GP0kYiJ00sT3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxby3EQp; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxby3EQp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so13270916eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252118; x=1776856918; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tYEZv1rW/gC6joIP4x++o1kzJohXLWgdPxUmcG5UJT0=;
        b=qxby3EQpbLfsgL3tcQ/Gx8x4wMtdsgzuU9pXKqTGVUfJNVzbLliyCxeRzVsRFQ76Jm
         CbeYYffb4ZD0h4A5k5H6pFKZxLt0jT7HZar1IVTIYzj+XOA7ic4b4yQcd+OSLCCDqmBl
         a/O4a7CU9NhSKg4xVWt3J1g+uM04AWFUtCpkx8QYYcJbJ1zoTZjP6oRj9yT6nMtkdlwN
         NSKbY2p7Pn0O4PMbudeUFuVGCIdqmLSVbWe5gRrv/yeY7Yg0HEK90vF3rl6p4Rgs2bf3
         xC9bcM0E2KhxJocQ93I2DY0xWfPQ+gLWOUzE2MBSOZ+wwU+LFH2Jnh/tKuVCgDYbGfNL
         6LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252118; x=1776856918;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYEZv1rW/gC6joIP4x++o1kzJohXLWgdPxUmcG5UJT0=;
        b=sisQ7Ce/azrnI3g3pEv7SG/m5C9AQmUGl+UJVh5xUxLmBn6ar7abWD5QAGz46Cwv+Q
         G3L0sVT058+QxQXtJZns9wVGhZQHb262c9VCvbHHvA3ySJAs/tS1jG+chMchI1ey6iHI
         cUTqBGgXPzg6G51ELNXojOi5YinoTvxUcmv8oqYv+xFW2iWkzNfMOzU5/VgYsVjshW/F
         oOjpI75lXYmlpogNIUsgxE2jYFFnXX9wITzZR8J2bcnMx8hX7mJQsXuXryKCjyd/LK3c
         4Joj/docEZKIF/m686p+9KFDhBRiTZYbWf0K6Dqj5/VB30AY5lpGmwPQNPr39Lcc5sRA
         mTtg==
X-Gm-Message-State: AOJu0Ywzp5W8JP+5GeJymAnCJIeBUuywE9g80/kGTXqTuOH8IZUbuvk5
	9nyzi2Pgqn43HN8S3mYcKC6riHUZBqos6O8M0YWchklf14w5MCrm9lP69J/iDQ==
X-Gm-Gg: AeBDietQn5RivPQrylQIEZURdChNpzgs4qqt5J10EweTXg2t9Qby7oDIw5UZw33Wj64
	Hz4RqdMYJlCsutmJFCEf8pKBvHu4w4VovQf8Ye1c04mdGlGjZdlCYH7qePGsYJafUf32+fab455
	c0K1uvS0chOz1HKSLn5Qau4M0VivKMDfeEVshoh5wzdlNgATRcbB2HiYL50/tGgGZZuEmpLuS+L
	gtSFkTGu4d8CngIdKDKaT6m1MvoIRH7ozRAaWPjv+jujN02NG87U+SIIXgDspAGrhPtS+jGgzJz
	9CQN1ksNIcHk/J2fbpDu6Re0iweuaBKTi5h5wUR4oH0prVGELBll9fDpl03dPbBsIf0jhmn57tl
	dWJOC+bgZpp9WshimjagtlOdSuyLH1W1VJinsDIlVyey6BE1DXXpImsS25h/V7G3EhSirjup7MI
	qfeY1NkFqHv2K5X1Tjky3xkUymQBsyn0g9SGoJCQJQyQ==
X-Received: by 2002:a05:693c:2d91:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-2d5898a73famr13482518eec.20.1776252118351;
        Wed, 15 Apr 2026 04:21:58 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm2480030eec.22.2026.04.15.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:21:57 -0700 (PDT)
Message-ID: <69df74d5.050a0220.3d9965.3a22@mx.google.com>
Date: Wed, 15 Apr 2026 04:21:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6989679526858577077=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req
In-Reply-To: <20260415104355.76524-1-phx0fer@gmail.com>
References: <20260415104355.76524-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6989679526858577077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081515

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.28 seconds
CheckAllWarning               PASS      28.48 seconds
CheckSparse                   PASS      30.18 seconds
BuildKernel32                 PASS      25.12 seconds
TestRunnerSetup               PASS      563.75 seconds
TestRunner_l2cap-tester       FAIL      28.18 seconds
TestRunner_iso-tester         PASS      41.64 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      115.32 seconds
TestRunner_rfcomm-tester      PASS      9.93 seconds
TestRunner_sco-tester         FAIL      14.26 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      12.16 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.80 seconds
TestRunner_6lowpan-tester     FAIL      8.46 seconds
IncrementalBuild              PASS      24.79 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client - Set PHY 3M                     Failed       0.112 seconds
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.120 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g7259c040a595 #1 Not tainted
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g7259c040a595 #1 PREEMPT(lazy) 
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
7.0.0-rc2-g7259c040a595 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002767140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb644d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/87

---
Regards,
Linux Bluetooth


--===============6989679526858577077==--
