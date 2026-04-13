Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765C32E6BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059350; cv=none; b=k+f4SygfHIdfosxUL/anKINhXoQG6Ake4yQeZB8PEMMJeeQ7AkXpx5rZnSzFZY/A4t7+QIpMpB/ygop5uoifgMKefZuDBFrB+rGLlZFqhZ6v3gByQCqlKQRqJcFCquKPPkH5fA711117m0AecqoFFABVwQYtVbnsyDzRByOD7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059350; c=relaxed/simple;
	bh=rAfExXEVsJOkT9TnMyHXICpP5wcQK7WefKKpf3KbmGg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k49b28orOh54bLvvGm8fUpUCPPbgZn4JW5/H/7MiL/FrJLQHLEOngWl8k6Di5vhNsDr/Waae8Wb3OrVyYasN8L37LQqxCvJQwHqqIVBI7mke8qYLAises2mwol8geCs4znnTDvY46F7wcT1Cn5bFjf0PpfLRZii0GDEV4+NqWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLxUwUjl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLxUwUjl"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8dbbc6c16b2so517296785a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776059348; x=1776664148; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3FgYgclFOTik69zzyMY2Hb1eQTus/2ll+xliF+DBIXI=;
        b=WLxUwUjl4kaFaaoNmyEm8wDkoPpMt7ZUGei6sIVAAnPT8vO79dpuIMhMZqeS/UcIMN
         L850xDP45MHSSS0FLvkAEOTmNgV70wLzrSSEFu25qrjXZyCLl2AtsnDd9XkweFdQSWY9
         g5W7cGr6BWdmd7AMHTUNagOuq2xdvsAFs+aVLzN+Al2Xe9Gtc7ZVGiWTFUtBW3NWrtkp
         Evyn5DcNmjpHhZXebahInhe/OaEBs16jML/RrLgbrVt8sDlyadK4LQMK/syTpKK/JgJM
         HY8OlUMku4WB+toAXd24d+q+z2xcUIFZk4G4Mc+w5zp9FMvqL+wgSEjC1Gj7L2aEiB1w
         kRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059348; x=1776664148;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FgYgclFOTik69zzyMY2Hb1eQTus/2ll+xliF+DBIXI=;
        b=ADhfeS21NwPNw6cHSDmxqu/oUVaFktBFj/AA9KdYAkkYK9owPHNmULJjkvDo1eqUJp
         ZTncQtAxhUzUWk8Pc6sIUJHbXhZuH/QBbnD+ws2o+kw6UH3w06gBBdM0tqqfF0SS2EQH
         1YJ569xfmfNewFC9sXJgVf0CNQJk7SB8IGkzLaWEdEN8Oznym/gH1L6LvMnRZheqRz82
         GpXkMb36OqJyZzEH+6xvvaACWHomtxx2Q2RN3g2uGEHDNk21EXKuHkwM7LubrZkD7e2P
         2K149GciR8uP1nBNSDM3UYX1MngMUE8O+TTk7Um/7zUpeYyv6W7AhIqTZvzLmTIp11tB
         ECdw==
X-Gm-Message-State: AOJu0YyE1t1Kt+IXZMX+Ca+C/owE6KHLk5mtGth/wxmjUt8W7IntsJgn
	ubejHFJrKq7N9XGZju1F/UcduhGJBl/k530v9PYZw8KRGcNxSjxdVwsDVizAfg==
X-Gm-Gg: AeBDies6x6HONanhmdV0k1MU3LEvYZAOpnYUe2Ma5Xwr091AXuKYWYVIEASFaQQ5Z8U
	64mhY/otXkLLwI6Rg+L5Px/biDKa6bRkh2ezCjnxX37uYO7v4c5uCUYV/E+c0R+lh0nOnu1HP5U
	/D6AJd49OSN3QOddT9TATRE94ERxeDkXhVIySEMOD2O9vivJTlIgRlA0AqiUQbPIPLA6/Rnd3GX
	Id4uym1g+MN/rEKrzbjOV/Hs4kg/RJl7zP24JOHU7E7p+2losGELYurQo69dG9Y+i4Ld4Jzg/5f
	SeYz6MvI3p/qzHsXCtjAOBLD17phe4Ro/mDjTentsXmGsFy7ktH7OmwM5rF8XCJJvS4mIFGEVrF
	UwHzQKsux/je3b2eYyldk36bVOWe8rGsYUhKzepFJbkjvRTZE0leD+Cr2W+L9XzRaFvrVhggs8O
	OVeMKG2AxnTsHOzMEZcqJsximK3TAbUDKyRifPHc+F+A==
X-Received: by 2002:a05:620a:294d:b0:8d5:8815:ffbf with SMTP id af79cd13be357-8ddce3c948cmr1444714085a.2.1776059347897;
        Sun, 12 Apr 2026 22:49:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6de73sm777117485a.26.2026.04.12.22.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:49:07 -0700 (PDT)
Message-ID: <69dc83d3.050a0220.2def.2a47@mx.google.com>
Date: Sun, 12 Apr 2026 22:49:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6211252409181824865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Support Product level reset
In-Reply-To: <20260413042041.1318723-1-chandrashekar.devegowda@intel.com>
References: <20260413042041.1318723-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6211252409181824865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.17 seconds
CheckSparse                   PASS      25.90 seconds
BuildKernel32                 PASS      23.94 seconds
TestRunnerSetup               PASS      521.22 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      39.04 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      112.09 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         FAIL      14.34 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      10.61 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
TestRunner_6lowpan-tester     FAIL      8.55 seconds
IncrementalBuild              PENDING   0.26 seconds

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
Read Exp Feature - Success                           Failed       0.119 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g649bfa1e536b #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002365240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff88800260c220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g649bfa1e536b #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.466 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g649bfa1e536b #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e9140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffbae4da20 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/75

---
Regards,
Linux Bluetooth


--===============6211252409181824865==--
