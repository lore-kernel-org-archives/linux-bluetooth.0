Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE46271A9A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766031; cv=none; b=sjn2sIsLHHBJcTyjcjlZe0L4UKsB58qUEpGZDQne82kjhtAqpZ+u4VSFaruulDHS5fX2/xIQtRnX6vt5gh5iI9sSLONEX+aQvcQdEw1W++DPn4685q9BvTW/mqXEz1EdsQcZO1dX60AUlgjkeZZKmvZYki8hjafKx4wCAOEcD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766031; c=relaxed/simple;
	bh=p/hGtAtMhWXH/f/3Y7tCTO5BZ2Wggur8tWlC1ko++7o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xr9Y/I+VM41j4GHBmvwnyVgcUkNfbWw1tEi/LRRPbyxJy3TnIO6EWlKaC3qBiNgpj5iIIm9vJFzLn76zuuAgQY8Ey0Zv3gh5PSl6ypzpkIjZBY6SKBy8LJzYDz+alAJVumwUfa9awtnNlpGotDfnKFsDX/bUT4ypHYnNRHy8BX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTzjhrPI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTzjhrPI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2b289925so10676331cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766028; x=1776370828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7M0AScn3DmxQ7tNwyUqzMpL2e96pQlqqMhd+WEs8H9U=;
        b=cTzjhrPINIR+paeaww6w4imStCmf7pC/LHXAOYgjkeZHt5nd5FANOUjKAejKMWVjvO
         eiGlqVbkOABnBYBmu8DDmauX1wepWZ78ZvsQPxSSe6N1RzT2I5JZbTRA7Ez73AQOMQPd
         25WQa9j9rR4lT5mC0Ezv04JgC9YUKQx/mycwejdgRXaIQLCw/eVTDcqzYhy3QiI/eg7R
         jBVNnKDDf5qjA6DFjrICcb66OTYfUQYlvlxTsnX5iDo3QCs4+qy2wd5EbzFGILL3vtIy
         ufJMXBEgy+X7FuFRCrwMYH2cpAYQoZ2wAuCldNCD1mF5BCxZiABIcnSpsDieF6OAqOvP
         tr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766028; x=1776370828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M0AScn3DmxQ7tNwyUqzMpL2e96pQlqqMhd+WEs8H9U=;
        b=g6NPeH9OBvOQzuLqwAGB3IDzVbDJ+VS2h1QsRu43Cmiv+qVwc4oIjHRVPOTQQbJwPX
         bxQQ8kMiYJZk0hkwsVhL5iPf/Be+jFMkCZhLnhZ2dsQfI59/9m/nJUKtT+x0gRhU/26m
         rlrBQPIYnqaXXmkNNeTzigpYWRRoo2ZPzLj2DI5Ru4Myql/Q0QE/1e5e1bRmP3XCFWe6
         KXbsFJnUkjtXrrvvVvXMEiAg13aLFEosFeSj5tijjKQvMnTD3MTCuxIu7bqTvnzI4wab
         BLvFmyBrYIV+RKNoycPj8epzntz0vC+QEKUbgy1Wi4Y4gg6aIBTLumBUSNOi2pHjZd+K
         qoPQ==
X-Gm-Message-State: AOJu0Yz5/EwBns4t/fWMnCQlxOyci1sV2rFJnXGyyxwQox/aNJGfHtV2
	eHfYWjggrFLBr/wjddZxMb20DHKBXXUt5X4dGNO/11bk/fKxygHLajpHmGoUCQ==
X-Gm-Gg: AeBDiesXI8Ia7aWBa7HPRHIKiUGtLpYtFSXCRZ95D5hs5V0yCi6+i7RyvDx7gaxi/+E
	sXZV33G+7HgwokwWbAnjMvkcHlO6M4YqAlLugktK6JuqIHsXP7WOrQfqNIxIQD1xRtw4RrXOvhm
	2V75zO2bd6BostRezxy/a0/tzGf52RcvGtUdO9OwGJTqC6V9OntfkQQtUxXs/IBZ2rQ3wIcxbIb
	e/kjgeQA//Fyr3FgYq/A8Vm+l/9TLnNDsBIY96a7clJVJ1bHx7lF8AY7QW/vopJCN0jtx8DJng9
	VvrKuTVw793DbzE0+FVbCeRumok8z3f/kOvFbVGocJ+C0l/VSkLbEJdpfgPKWs9+75u90u6/6jz
	WlaCspFnFpPCy88a8FCbzCifdxyCs5a1/zjo6puZ7rXMz/Gu43dS53kLweoF+bXZg55pFi0A+xr
	MCYle25emfCJEtJAvG3smhUMhzcRA8CU2ZmfxGrxw8
X-Received: by 2002:a05:622a:90d:b0:50d:b030:fc6a with SMTP id d75a77b69052e-50dd5bbe532mr11127841cf.49.1775766028436;
        Thu, 09 Apr 2026 13:20:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54fcaa4sm4473971cf.20.2026.04.09.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:20:27 -0700 (PDT)
Message-ID: <69d80a0b.050a0220.1603d3.49ed@mx.google.com>
Date: Thu, 09 Apr 2026 13:20:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4444092973663873778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [v3,1/1] Bluetooth: serialize accept_q access
In-Reply-To: <20260404162324.2789862-1-n05ec@lzu.edu.cn>
References: <20260404162324.2789862-1-n05ec@lzu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4444092973663873778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077317

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.92 seconds
CheckAllWarning               PASS      28.56 seconds
CheckSparse                   PASS      27.26 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      543.54 seconds
TestRunner_l2cap-tester       PASS      28.30 seconds
TestRunner_iso-tester         PASS      38.56 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      115.26 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.56 seconds
TestRunner_ioctl-tester       PASS      10.53 seconds
TestRunner_mesh-tester        FAIL      12.59 seconds
TestRunner_smp-tester         PASS      8.76 seconds
TestRunner_userchan-tester    PASS      12.94 seconds
TestRunner_6lowpan-tester     FAIL      8.65 seconds
IncrementalBuild              PENDING   0.31 seconds

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
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6ab4b2763829 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff88800215ac20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g6ab4b2763829 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.585 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6ab4b2763829 #1 Not tainted
------------------------------------------------------
kworker/0:1/12 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa084d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/45/checks

---
Regards,
Linux Bluetooth


--===============4444092973663873778==--
