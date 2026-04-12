Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466126A1C4
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028876; cv=none; b=ppkZLtRQCQgGhvC2LGJY+/E95rl0cARwX7L5kb/2nAKcz3r3w/sk8WVqPkSCGtAy5qClpsTXXJtRghmXMeCgqCnOtRaa/2YxEm25mhoyXZRyXPCDuOhPdutKOUbNNgz6+F9pdg/sRsQmTXdq7NKMxOWwk82aLb47Mb4uaZ4qkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028876; c=relaxed/simple;
	bh=jtXVc3PlPQQyNAaYXfs2nYAqvP/Gtu/GU65lEK0/VPc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lf9/JP8ScitM1IBMq6z2QoIt69VNX8fbkX7cJoCHbdtQneAFZT37Fmtznj+virl2RNq3/LEG3YbYAJP9aTX/KrIuwYDoBSQgWK654OrrVVLda1WPrmRXXli3Xl86SEgygQLQkgXn+0EYNd0l2FEmDEyRM+tvT3AfELJjIw0+0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAIRU6js; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAIRU6js"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d6ab4476eso39503511cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028874; x=1776633674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AbRxMCat8rztUKLFN4JIY8CPCv8hiPLxBcjwm+/UiPY=;
        b=oAIRU6jsI0WC9v18ZmbhrSTArWdor+Hh/2pv9jIjc+Fj8oTA47rCRHvODmn5eA0h6F
         zS8p83KsO9TXOb3HaoiC/VLDpTNG9uEKrRAIu4t/bhagTQUnDv85OjZz6Z2+TLLn6lgV
         2TwBxZrIWn8t07tLgEmcDQ0ydM+UDjyQNcWdCMu8NrBRP3/9a2Bu+LAbx7YAdi9/L+qv
         4RKh68mEX1XSCTVqi0/C3A/EIKpswteps3RFkIUswAZPSy1bzbwVLGhznNmNU25kR6D/
         ad9nPatfv8s9z9aS6F3fHvALpobLEBGF016In8E8TT5JYDQXx+0S3jCNw6FUF3vqnl/R
         odYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028874; x=1776633674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbRxMCat8rztUKLFN4JIY8CPCv8hiPLxBcjwm+/UiPY=;
        b=P/YFTydjtjUAbGPTxsoUGaKWl6rkuNpX+ST0Jkyl8p1/3L4HrmhWMfsVU3/PX2qMz+
         H16LKJUnllBhLij5g0SBgj9R9SJbfksPZqawEcgKGZihF31Y2TNF/RClKuWI79lWqA/k
         xEvs4WJ3/oZsrxZYOZIY5eATJS/BGNenF8VqYLKFowBjymfpettcOOxaqvEiwR1UrHKT
         FaFYmi2TdYdGExw/2tN4T5mNa0nmyJKn0AHQqoP3JfGpeaMkksXkgozVwxx8Acml/jdc
         1IgL2OF68mWFGeQbG9MoDk1Su2CCrO8o3k1ysVSO0/IIgnRZzXnibhy6wcwPhE0JP/vW
         Pm1Q==
X-Gm-Message-State: AOJu0YzPnGXT/grm9xS85Rhk+tHuD+0E0y6kuOGJyC5/A0ktOOJ7fyMn
	p7BQMF/19bSTMIGE1Ahblb3Sb0gHfjn0CRoh0H+vkvN8erY9f9tWBWTYU4Xcxw==
X-Gm-Gg: AeBDiesv329RQcn7FhvsCUQOmA5oxL8bsAbS+ChXt3N9FTMw2nTWkDV7xxb9TTkTOLz
	XiJGmh06G7HQsV5psQnBErRtvGmsl3FDGNQRd92VdqHMTMMGwzWBA+PyBdRlC5jc4C5IqQbxpUL
	5FGqeVT+Y3QsVeMvikKie0eZISBYUkUbM8nfpqVXuriWtZGKpsYZvTt99eA0O8SjuTzF5pXtBS9
	fgOVP9aID114QFoqTn8AG70u6MjciV2OXXZWG0XduPkqpWFOCuTPISW3dm+ZV5GGzseSXkFmcc6
	wdnrUp/Xpjd5g27Gx7qobOb8katmCRevdsJRUf2D36GvkxRePK9LsJJGWFyIR2yVFPdoWPdCfsd
	JHuNVcsFd6xQex+3i3UOaNFsfrIG8lqA4sX3GaMtcvwTqRQG7PbXmXY9FV2Ak163QwSML5opwJq
	4gKkxJR89WUDAdpGIBFndT4XeOgR5GQkCv
X-Received: by 2002:a05:622a:30f:b0:50d:8350:9a15 with SMTP id d75a77b69052e-50dd5750e53mr183288671cf.0.1776028873846;
        Sun, 12 Apr 2026 14:21:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b3f3sm72800211cf.2.2026.04.12.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:21:13 -0700 (PDT)
Message-ID: <69dc0cc9.c80a0220.15cf24.c1ff@mx.google.com>
Date: Sun, 12 Apr 2026 14:21:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6681709198271802653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnexen@gmail.com
Subject: RE: [v4] Bluetooth: hci_conn: fix potential UAF in create_big_sync
In-Reply-To: <20260412202916.196282-1-devnexen@gmail.com>
References: <20260412202916.196282-1-devnexen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6681709198271802653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080419

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.52 seconds
CheckAllWarning               PASS      26.88 seconds
CheckSparse                   PASS      26.00 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      516.82 seconds
TestRunner_l2cap-tester       FAIL      27.49 seconds
TestRunner_iso-tester         PASS      43.05 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      110.72 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         FAIL      14.14 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
TestRunner_6lowpan-tester     FAIL      8.60 seconds
IncrementalBuild              PENDING   0.25 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.112 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gaf00b855bdd3 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gaf00b855bdd3 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.699 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gaf00b855bdd3 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8e64d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/74

---
Regards,
Linux Bluetooth


--===============6681709198271802653==--
