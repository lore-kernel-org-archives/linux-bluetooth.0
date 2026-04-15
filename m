Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A82C3757
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228696; cv=none; b=UjBa5RKDwtPdrclaAuJPstK3ybSr5cuI/5yvDS64vAKbUX6QfPKqWA2mIDrY8J8yMii/tmbsZ7J64jb8xx8FodRSDMyrorkinMKe8WQmzPJIFiJg7svEVN7hZR80Y0xUkTvk2sagV10C5azN+Xcio/2IpxKgxuZ+Q4f+ouoF8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228696; c=relaxed/simple;
	bh=p6uiSuVfpjNFPVdAadmvogm6+8Lv80g2w9VpXB/VeXs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PG8pA+VykNZSoZ6yWSVJwAO1j4hmuAZ1BzzBlUHMfjiwfOAjtF8btm9j71lQjgEnkDAXCvvz7I1R6GMkcvqmwiBv9bCvqrXCHeCWOd/y7aHLpqiOto8jp8zAedl7sT90OpzfbLTcS958zFtyW9FgxBo+hxtPkVLV8Z7b5JcZezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf3KgZrM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf3KgZrM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d4f78fc9f6so761457685a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776228694; x=1776833494; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IVZIh3/4f6qFCSsWcldjAibl6b4GG6nfU2+gYiBnTr0=;
        b=Tf3KgZrM1tKqahBacQ1mynKJDGTNqOe/QtL/pKcbSFNU2ytw1eYdWreDQLamU3h4iM
         hU8B2KKzO0bK7xmjRZQn4O7sZ134MLkjicWchjAT57RF6Euc42zVpP0rKwUDAgjXAoC7
         c01AvBDyv86Yju2qymtJihQgDRe2VJNfWAQGYw+VsKB5dIE4oit1ETXY7ThoAH7Zf0l0
         ZTPW40iNCf9/eMcwbFdqch/F5+iV7bLYP2QTULHHRAGUgWj1+A/nQgV8z5tTB7E8XhU2
         v2aHdbWEe3dJdUUmKlspoEcOtzNmzKTKCB1tndzBoDppFBWGEOBq/wGDr4irK5n1m+Ql
         3xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776228694; x=1776833494;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVZIh3/4f6qFCSsWcldjAibl6b4GG6nfU2+gYiBnTr0=;
        b=MirpomLZcvrV0fzIfA3Lxx4+T0Ci5yqpAlLa15cD1oaH58GtB3c3IaxtCr92SWc6Da
         SJYG+uS9nmqT+X6ygHDePsyVGwi+Y8xs6ENJ8iZl+i7c+Gr6OAYYFCUakuDLKOmr+Xct
         pCRvilhwmi3i48sLdCy+S0jUZcuAZ4NufUHZ8mzxhUJMg9e/bxhi09tggce044Fv916N
         nQ6uKMFSnRJKOJeCwkdeaZCmstwH/y31hOglwuUBSjHIIojVujJSubvIWo/DiQBegZiq
         +Mo34FmpnziWjH1LpnEtBt6Nes6BCGjCmi0aDqsPpSLKfwk7hR1GGOKVzSXyOaFGmlfG
         /uVQ==
X-Gm-Message-State: AOJu0YyLOvrWHvB12NFSlGCuWbpEwbwawCE4h3q/2a6dwnstJowZ8XMd
	v3BLULsp7S5t2A3ayozlS2dbItaeLvi1gALv+rqd8qbRmgpcw9Nq6xcjWIFk/g==
X-Gm-Gg: AeBDiev1xd75h7v163nFH/z5caPjJR7TOOaISN2ZZbxIIqHzrh810pXMJ8Ll3brG0FG
	tCb3UtMkt+QB+zg0jQvfqNMVdRh2Anl0mAKWtDYWpGscc2WJge4h0AxcNGDw+ohPBNq2nGrRBqS
	DSbBqwUhRfOqqlnAMAoL/+9Afjp+iWlZX7dKKrcTPNQn+D4ORNhzSdLRpQG1AwzBg9w7nGWNQpC
	HwbPW5rbWiZFnPORx5wtiLOrTtrrnSJBULJ0k/XqwAa6sATCFT0zO1ydKAfW05qiVaT6E2K81Ry
	2lHPOTrO0R5vXqrckGM3ZyDEWVbb3RscS9iQGMx9wL8Kw3RwRDAxH4yTVIQG94dBlNr9LeSh+YZ
	wBA8NBQApqtuYnsYucdsx6L8SboD+fri0+aT+S1MA4IrDmkHj42OwDcdVvXsux1VSA7kmMfz1x6
	QBAgHZCK6M1r+KFT1gIM3UeSfpTjhU8c5mBg2QZPFlAjTqvcrJmic/mA==
X-Received: by 2002:a05:620a:4610:b0:8cf:d1fa:7b3d with SMTP id af79cd13be357-8ddcd119910mr2972409685a.10.1776228693390;
        Tue, 14 Apr 2026 21:51:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.118.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f243a25asm38915685a.28.2026.04.14.21.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 21:51:33 -0700 (PDT)
Message-ID: <69df1955.050a0220.aacf5.9abc@mx.google.com>
Date: Tue, 14 Apr 2026 21:51:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8999925632832207799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, feng@innora.ai
Subject: RE: [v3] Bluetooth: L2CAP: Fix ECRED reconf rsp channel teardown race
In-Reply-To: <20260415032318.78543-1-feng@innora.ai>
References: <20260415032318.78543-1-feng@innora.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8999925632832207799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081350

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.15 seconds
CheckAllWarning               PASS      30.67 seconds
CheckSparse                   PASS      29.20 seconds
BuildKernel32                 PASS      26.75 seconds
TestRunnerSetup               PASS      584.93 seconds
TestRunner_l2cap-tester       PASS      28.57 seconds
TestRunner_iso-tester         PASS      48.75 seconds
TestRunner_bnep-tester        PASS      6.60 seconds
TestRunner_mgmt-tester        FAIL      118.42 seconds
TestRunner_rfcomm-tester      PASS      9.76 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.51 seconds
TestRunner_mesh-tester        FAIL      12.27 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      6.92 seconds
TestRunner_6lowpan-tester     FAIL      8.69 seconds
IncrementalBuild              PASS      25.55 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.117 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6e16399eb91c #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fb220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g6e16399eb91c #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.558 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6e16399eb91c #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002760940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa624d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x698d/0x89b0
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


https://github.com/bluez/bluetooth-next/pull/85

---
Regards,
Linux Bluetooth


--===============8999925632832207799==--
