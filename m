Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18F239E75
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766048; cv=none; b=TRZuU9yJoQsgjI/E1Ei+wbfVRNoJDxcIVVm0E+PFJlkHTWs5TvxtihHg7BLdA6s598kOJ9OqFSTNpaoJeRK80k+Q9IyotdZd+9sPyO88UuDMTAnXGCccJnnoBjE2P+Q/oQg/jtEzBnb6LVqTptRUWogPLuR4NH4vjCd7vzVfpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766048; c=relaxed/simple;
	bh=qrPd8wQlEIgdGAwgsYc4P52LhwwSsNWp9pIIwRAWKes=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XCw9ek5SOd8yRrcjqYf7nVdi9t3Dzxi/idz6zwitbDT9sKfY8o1l8HJYPsBc/8WjCcBhWovicDQJi/Gwu1O4cTM2zcGs9Cl4/fiMm2Zm/8/rnUVYv5r4XPfgfColopE/wTHc3HQKPYtiwuvC/+37sUy2panPWxjoMWvDP6Uv5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlfH8RZf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlfH8RZf"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d68bcf50fdso142825285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766045; x=1776370845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uKHMeTgkmCEBDn5++K4xLnwfYfOzgT5Hbzu8vtb5hv0=;
        b=qlfH8RZf+h6yWOD/AmJQ3ar5lLADHW98rfRBlvzoIiAPgpdBjAjE2apyBeqi5Lv8pv
         t7VAC7eEysioh3TwhwfFgp0VVwNqWL3812xeW01PPEdegLBwklxnrchwc5yAK8HZmHSt
         z0hbHnPZ5MJjngVNZjKsE7S0A2tR7qdkAMYlMdnuOraPuVmASzu7l00aAIRfK/jbElp4
         BsoZjrFwJAv1o6ZiWq9vHiwpZPpaslRkjN9nwdNLYKereWdPi4jlEH9CaQjEjYph90yr
         jM4SIt1IrFHtjiVEgZi82IHvroif74i2H6Kd02zAMWweAAMzZsNA9bUQrMVCb+ywNnNa
         +c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766045; x=1776370845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKHMeTgkmCEBDn5++K4xLnwfYfOzgT5Hbzu8vtb5hv0=;
        b=PvmDDz6/D6qbXAgW4+OdaUkwFZt7U0fXyAK30/jzB3Ev6GA9wZNfyvGHlR4ILykP1I
         V2TokMMWnY6tRIvjROwZ3Nv3COh8nyulfCYRIxBk/qRcwB6NnAgxbmsZS5TJ1/9bfWca
         Di8HwcjWccyYOhCk7U3QraVPZvcMGyop7oFjxYA7MFY6DKgEblPWjJSZYUXKJCcjd8GV
         tXBo0hKmpotCv+COo4ea/WUkUvNdX+Cv2oI80G6q5XdgcfAtsSlgOebZ6rNsVw9/+e8o
         1LCQLwDEz8oTITYqWRur1d54D+6F33kw6LXnO+A2N2eoR6TVmVOjvZRdoy4glfwIuR1y
         Z1CA==
X-Gm-Message-State: AOJu0YzA7QWkRTAjmcTcI41hXsKNA1Bs326CRfvpgjlQj8QBTRc03o8V
	mm4HsTQV/FlIEZAFfkaY0Zbka0kZH52CUqolSeSJfMvXqsxiLFXf0bBUfUTBgg==
X-Gm-Gg: AeBDietP1A3+tZSbq7DfjuXzjzhlSgQn02EgMfPEy8HpeXHMoVDJD8lZ0873xNcpf/j
	7SpHRxpxS+DitJPHRjk8v6VhVvq2ppPG9YcTuNZoqlDuNFlJwG+597WWSa/cMASXSH9cOqWZD5G
	qAZZECfjvwozrrsNAguLIR8VwL7dyKHJzeks+R0ten1HHjdfSZgqKNZqgHiuNlnz/uQBxqHuNaG
	tilVDu48xHj+8tRUuJcXURt1fY7PYRUAYm6Dh31cHU54/jD4E3LacU/QWBfReUpfurLUJ/szkVZ
	BxGTXvBG2/wtgGcMjBW6s/PBuas7MV1t+Xc10qU3YTxF/y2k9F0GiS3RhBRv78sE7ELZJ0Maghk
	5QX5ERno5C6O9WiDpEqy5zDtQZJAnblgA30y/rVWLur3vmqcl8KF63VbdK175eU59QV61pX22GI
	Mw4UZ93rCacOOOWX4vHjP+K5gXYI/iz+c/eTkESFyG
X-Received: by 2002:a05:620a:7085:b0:8cf:d804:4569 with SMTP id af79cd13be357-8ddcdbdc27dmr49748885a.23.1775766045228;
        Thu, 09 Apr 2026 13:20:45 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9a29749sm36129885a.47.2026.04.09.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:20:44 -0700 (PDT)
Message-ID: <69d80a1c.050a0220.4866f.1660@mx.google.com>
Date: Thu, 09 Apr 2026 13:20:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3196552298609513396=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Bluetooth: Add Synaptcis 4384 Chip Support
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3196552298609513396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078531

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.61 seconds
CheckAllWarning               PASS      28.40 seconds
CheckSparse                   PASS      27.03 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      560.33 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      39.17 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      111.38 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         FAIL      14.18 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      13.70 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
TestRunner_6lowpan-tester     FAIL      8.80 seconds
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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gf5b83b75cf22 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff88800192e240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002607220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gf5b83b75cf22 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.845 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gf5b83b75cf22 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002777140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb344d7a0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/53/checks

---
Regards,
Linux Bluetooth


--===============3196552298609513396==--
