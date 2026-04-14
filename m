Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF941E2858
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139297; cv=none; b=JcxG0mrBPM1Op3h0s9ZIY2kHW0v8ZWWf4lUm79cK7t8loFh5ISpazvvvVAp4BT5BJKmA4Ep4ojYGDOcB6kFOpIAIiUXbmAb79DrD83iAmQdMJgdaeHREl443l5clY8HjTojXZWkyzTrpfcEWFkvm6vY8oL8z5dyMTmzLXKUfjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139297; c=relaxed/simple;
	bh=rQGtvm8/3iRrW1kFPtxbmFV2/xb4/oZY7q2vamUzit0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tYMugGn62yZAuU4vxlHjhsdDYxWXBTA89atKGz7OzQYwy9Wx3iGNEYnCtuhABTAK4YFTATafjvcu7qcj0oxVghLPyAn3UFtOX/EDblD6wQfwxMqChGFo+YpECrJC94+5Xj8Df+jluyDRRKJb0XQEfBITEZ+nmJLa7hoFjuno/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbAJF6Dd; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbAJF6Dd"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d64c756111so5458613eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 21:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776139294; x=1776744094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9hmkNmuO88BH/dlKnozjAmLm1Hive+CHuk9YUbeCjRk=;
        b=kbAJF6Ddyy+akOr+4nLQ/ibakgYveco6FJHt99h/eQmprximKfwc95pWkL9j+0O9qI
         963w9s1zaE83RKouetQheA4w6vtFwMu5jXe80VyaAHC3waq0YF0rZe98NKH9oM6F6bzq
         LKRhOUpW4TlCh27HsNtP6Frv9b3ZdRdkuu2JTxtCDy6uNFJ4V5KR7AKnEdZloQ5eIDlL
         srJr2QbZ3aShvkNF/BCrjwDZVLYrMpgUsroeT+FzBB6y5GfEHMKcm3wV1qA5Xoklj/DN
         qOWgis8VO+PrSj5U/B1G/J6o2eEEV3wVFDwEKu9XZWVqAE5wMXFdsZWrlo20YY+QH04v
         XN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139294; x=1776744094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hmkNmuO88BH/dlKnozjAmLm1Hive+CHuk9YUbeCjRk=;
        b=AW/FJr0GIHm5DrkJpTQlxdjPIl3jHVkIi0MqU5+eKhdfVq7v9eLnBx6XbwDl6B7zlq
         CHDfCsxGTU/V+/83W40Vfk00+sBhhVVlQwiS8/ix97JJZKnvALUi3TsDBYaFf/jS6ys3
         1mBwioq90R//GwWxUv1cQkJYIG85CCd9WOGFAQ3hTVbylHypythbS3De93NFUb5P+GA8
         yvdn9v7W6bu+u69c6adH4EyLxzxPFFkaRYLicC/fb6VjB3Bc8wuj6HOdctWfTbEPHovo
         hOh+5PeLp0+nIoHANr6p6fkNJbBW40BMQtVca32eoV8vsP3gkoYclp9zVV+tmcOUIABO
         4QGw==
X-Gm-Message-State: AOJu0Yyo0hFR8uLU+hD2DW7tAtzN5JLTK6HECf5TPZ3ldAASdY/9U0B3
	o/5Vawc0LR6xw9B31XhUn1XIsKLzWJbSrmJuCMCIYF6NnvhtMqxxSUbTesmBdw==
X-Gm-Gg: AeBDietezLS1pOIQdMG6BiEbRQ8c63ODpE8euND2aC6bi3NM/+oIvXYX2ZNUwgfyy/F
	AciqcnElC45sJnWQOIFJWq9oOSLB9e6z/AQyOVnzgJ1WjgONCEuV1JSQtBw6ymJI/BZUvf8Rug4
	24TDa4No36iycVPL6u52uBjGdE5WeKcPAAemCwGWODyCOcz3yK4MMOphm/L1/VtFIRiqVMMakWh
	83ZWzu/gO64owrNXusgDqaOTTmSBBSxa27xvoGa8zzqOpZop+Y/6WxhKB0wtiYVUdQlwKtLoJbY
	XBDbwhtfduYccWKDy+hl8SnEq2bBe3Nop4MOHrbEjVtxSpBoLSf4HvTavZQpnUjuTRIQLceRMOx
	395uKNeepy2JTE8Gf2eWWY7HGswFXnm97LEmcT7ueH8ev/HyMtIJjfeAugiTph1oImPLSa4xlU9
	71wW167TAXUejderMVjGlZDYqxoHbb
X-Received: by 2002:a05:7300:d08d:b0:2da:39e9:20fc with SMTP id 5a478bee46e88-2da39e96e53mr1927421eec.17.1776139294217;
        Mon, 13 Apr 2026 21:01:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.82.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm24758771eec.16.2026.04.13.21.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 21:01:33 -0700 (PDT)
Message-ID: <69ddbc1d.050a0220.1d3f67.fa16@mx.google.com>
Date: Mon, 13 Apr 2026 21:01:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8265011586270387977=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: validate skb length in MCC handlers
In-Reply-To: <20260414010741.233892-1-suunj1331@gmail.com>
References: <20260414010741.233892-1-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8265011586270387977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080925

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.89 seconds
CheckAllWarning               PASS      29.76 seconds
CheckSparse                   PASS      28.82 seconds
BuildKernel32                 PASS      23.72 seconds
TestRunnerSetup               PASS      547.38 seconds
TestRunner_l2cap-tester       PASS      28.62 seconds
TestRunner_iso-tester         PASS      40.16 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      115.76 seconds
TestRunner_rfcomm-tester      PASS      10.05 seconds
TestRunner_sco-tester         FAIL      14.78 seconds
TestRunner_ioctl-tester       PASS      10.80 seconds
TestRunner_mesh-tester        FAIL      12.18 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
TestRunner_6lowpan-tester     FAIL      8.69 seconds
IncrementalBuild              FAIL      1.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: RFCOMM: validate skb length in MCC handlers

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B1 Line exceeds max length (82>80): "  - Add a length check in rfcomm_recv_mcc() before accessing the MCC header (Paul)"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd702855ed9de #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002141a20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gd702855ed9de #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.082 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd702855ed9de #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9844d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

fatal: previous rebase directory .git/rebase-apply still exists but mbox given.


https://github.com/bluez/bluetooth-next/pull/81

---
Regards,
Linux Bluetooth


--===============8265011586270387977==--
