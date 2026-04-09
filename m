Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFE30C61B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765993; cv=none; b=Gr1dVrcJINsOFbc6UmP2S8dAd86GNf4IE5LtZdP+DQhwuSSWg143Ei4Y/4WNsNexLf+VMxDqvki2eVTJoTFPWLLskXqMj51qLUV8Ionh4g3DR1+BiuQFf//EI7IMNExp+n4GQNT8hQdvvAM5AaN5XzwZJZvp0M6Jj41L9X54ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765993; c=relaxed/simple;
	bh=FV6JwbUt1cuy53RANF6L2GoCnZgrAQU/Q1WS5qAInWg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D5Z5IsRvaje0P67PoVN8OXkKVry6RlACRMpJw//7mwEScY3oY+80ap0rqWr9NgTykby+juNP0LE5ToZsqqg6Xuz/6SpLj6/EkE54uLB8M5B+DEHR1m4WeUv9UcBF3CeNVfBqyiBg9P+ar7WBxaxizuLsNieN6m6m9SK75hYfdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pW0DRm7T; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW0DRm7T"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c25b90264so1423230c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765991; x=1776370791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TN7ZfoSm4fSJIritl4rPq7K7AGxlweinRWS+yPsrxHw=;
        b=pW0DRm7TwEvKx+0qHOzSiNnY/+AajJoX9f3aleHBNIFfePpFOQdbiaDKNlr0U9I0Jc
         i8Zp47LyOiXHvBB6IubbqmrwhHxswuZYCwEoQvvtoEEe24kVGLU8XI2yM6cjx19Ar3kF
         OK4qxLkr/HDsHRQr8qP2TEapc5QaGsCfWB3ZtJDALJDOQqIiWRDNVoVQ8GoQ+9AkWSWW
         7TKw4p19e9A8fakr0d6OZ2L03y2lukQvnzm2h76VipItTRtkelNWAzB3jUIaM63+xeZk
         OlByyYGNABEEP6HtJfzGT0tTV9sP382MoFRPhnp36n/JUaMQm64cy3ajXcre4WPqiIlj
         z/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765991; x=1776370791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN7ZfoSm4fSJIritl4rPq7K7AGxlweinRWS+yPsrxHw=;
        b=DjPscRMyz5QgdPoX9/U8CiCLtxGp6WlTcrMHH15ZMNFn+sOsLOZH5ZlyUgFWk2qrbe
         B9VOXHAVDdEIFWCZrdNyv5JyfL+0Ta/2f37B3Q2xhPhKJTbygOTTX8uZ13J+dv3yQ9UQ
         yiQIRJL+f2wGlP5Ktb0feQgUJqjFi+8d8JUIB9izeMGHiH4JoaOOve1FambSQl6+m35+
         Vuzo2PWxnR4gyyq3LfU0/dhDjQin2m6irCOUOPycf08l23vq3FOg263fD0T+8fTatjaj
         jLzYBrlpaLL1yNYEfxXOTXJ/TJHL6pbQadm39A7QKomVKkD7nj/Opu7yw+ZnzwTx/GbS
         WhTQ==
X-Gm-Message-State: AOJu0YzaETNkNOrgTXPKCbHFuwTefQA4UHL+JIslbeTX5WXeS+OXhnWt
	GC1r5PK/8NQgVxgfLdRphpS2PG7p+el9AIXm00F18JgWl+YdTlcC+qp8w/OO7w==
X-Gm-Gg: AeBDiet3jF6z4TQBT0letphqYaTVYkeh9m7sW3CnFenQtZ1jfK9ygdGKf1n57ZhIimI
	QQPRvaMCqaYzazrUQ2T+WM4j4T5xur2SictxBx78ag2RL0fAxIaHNvOSN3bvUFLqe+lAoJ4Q6r7
	KLXni1eFB4fjEXURtTAOSxWrmgJMkqeoCIgxL5+Ehz2NSHeHrsQRwEbuDa80C/NMgwVVKESoLNe
	eYz+3pZQYZvmErgDbi5MLb1WKLxTDMpPvEDiUDHMkBZuF/Rs4oO6rZhmkZwvJ0H37ap4r8pyJxM
	PSwjeDoTYvaUjSoT76ZIOZrpfVHNGl76g9L24lpNMd5mWp41WFqax3uacY5p9a6ungJeapEzo1l
	vuL/hNl9wJbDVRwenE8PNN7JX1KKxFrpyM8xs6L8dApcupFKgn1W4l9r0vY7ExnoAuEitx5UZeW
	MqJl9tzmayM2VfWf7Q2g4FlOg19x5+wjk6
X-Received: by 2002:a05:7022:ec07:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12c34ef9089mr277579c88.35.1775765990809;
        Thu, 09 Apr 2026 13:19:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b6208sm999757c88.8.2026.04.09.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:19:50 -0700 (PDT)
Message-ID: <69d809e6.050a0220.3d3bda.0507@mx.google.com>
Date: Thu, 09 Apr 2026 13:19:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0945806995220525594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: [v3] Bluetooth: Add Synaptics 4384 Chip Support
In-Reply-To: <20260409013035.1923003-1-kaihsin.chung@synaptics.com>
References: <20260409013035.1923003-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0945806995220525594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078977

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.47 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.48 seconds
CheckAllWarning               PASS      28.63 seconds
CheckSparse                   PASS      27.53 seconds
BuildKernel32                 PASS      25.59 seconds
TestRunnerSetup               PASS      567.27 seconds
TestRunner_l2cap-tester       PASS      27.85 seconds
TestRunner_iso-tester         PASS      38.54 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        FAIL      113.62 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         FAIL      14.29 seconds
TestRunner_ioctl-tester       PASS      10.37 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
TestRunner_6lowpan-tester     FAIL      8.58 seconds
IncrementalBuild              PENDING   0.34 seconds

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
7.0.0-rc2-g4eb3d58cb92c #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g4eb3d58cb92c #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.859 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g4eb3d58cb92c #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e5140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb6e4d7a0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/56/checks

---
Regards,
Linux Bluetooth


--===============0945806995220525594==--
