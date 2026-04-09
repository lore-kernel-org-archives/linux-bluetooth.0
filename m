Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036B2EA749
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764919; cv=none; b=EbrGh8zLMGnZSLdSGOyiHC30vSp7ii4k4PQxKQ9fKI8cTqz7ZZYbN/LoSLkgNdscwNxWak9GtbQIPwN41ilWfANESVAiE2ElMnobHnevY0r9KOrff1kzxLzGWWlOYvg91SD5SAT7nBE85006fIUHBsvdEW8xVOTqApl6wYUNkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764919; c=relaxed/simple;
	bh=bN6HUtNlcvMZH1XkxzPFY+xIfHpmV2y1Oq7ND3g4cNw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XwBMnTdGnv12y0Ie6Qb98vdWSt02cTzEgwsi5hdemMFG6dGDdwNL5vY5diCi8qa+/huIVJnjP+uvuKs2k9pUoYphAI/2WactHPz24rUyCeCv+t7HzeEjuCIt2boWX1gG9AqLtGfv8ETcQWL6euvG67A1AS3jpz9+8SDm6UwiRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO+Fy3dF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO+Fy3dF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb4136d865so142998085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764917; x=1776369717; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EET1vntFTzocPni9crSuGwaj8bxrtsuQD5VUgItK4AM=;
        b=CO+Fy3dF2ftV5dGpH1hC6KKYbRXwrru46upDkJ42fLtejEdRIVYCma2Ga7w2G49Ay+
         uiAc9QD/n6QwXBnA2Iinw1V9j7dmhQaJYrYkqCiQfBdKD4sDXBJw2AJ/KjMemNwLJAd1
         bGDlTeGnP7CYaNDcI+CEZ6tz2DfRH4iynvz7JAtNhGPjP53MAKIMq9c2AjqVLkkMuWce
         /kkFWykeRN+b45KPQFh3Rh6WeFIFw3CEqFDR2NAuaKehD9hGNAdnZQjzghnQl7tuW6WW
         HzjFq9lP6IpiCztzurPpsxVMmiTorn/l3TA1lzfo0RaBXGNVEEaRfsGiZRQy0prkfTaq
         jSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764917; x=1776369717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EET1vntFTzocPni9crSuGwaj8bxrtsuQD5VUgItK4AM=;
        b=U8pS0uCaHcwTpICy+N81X80BwLU0wv5JYdrRqWgMiOfFC6LKywUyQ3MNp1mUDXmaF1
         8wcWwcDbFd8q7pvE0uBcqat3AVSgifz6iRY8RCvXTV033OCUstYiV6NSdpGtte6SC/OI
         g2nAzJKiVcVAJb24gPv6hCFMTrB4A1IDz6582vyOX1K+jcjcWvxFL1w/ZN7zM5qD1K5E
         FhTMhOhDQLIuIk8Mul9jkSINBnwIb+CAnTMWU6rHDeWhJhqfNf1yh917Q80NlAMniZJX
         kwSBb77Gp7ttdAIT6W+a+K4BXqy0wwF4E+yIW5HdmrtW9+AjxolGXuu3X5WrsUyDxP1Z
         3hSg==
X-Gm-Message-State: AOJu0YwIXoMpF4lTkVvz1CFE8Cl0b61YXwNqW4W2pD1CZyOZAibPtHSY
	PP7EnangMYlDE0Nr2ebB9ZxwRcTLNkByhCusHNMNCVnI+PKSp3sSVzjszhfYZg==
X-Gm-Gg: AeBDiet655UOzXk0Py2Mh20q1MITzrBdi6gIYWo/RcoUuG5hxeL+GpIfrzE4ygMH/ey
	SH9zkkMCVJzAenbUMwQL+NkyLWHpfEO80WZtLyRYD+xsiz3MmIvcDYsCB0MSlBnOLCL+tfYNgpm
	SI8sH/tnOwDNXQQlfRz5X+OjqceIWFX4uX7OgU+BmTw5j/fD+DFZrh5Fek6RyqJCWSQzsiKb+ZB
	YagXTRhF4tk977hPte1/GlZHSC825yh4zOV7NZpTJ12L37VRyoG1qMqLPedPXOuEyDbG0VQBXJK
	VQ1hHcgtU+qWaIYhlF8PG0yw6UTKYzQeXwWBEsYrHyTZ7B6lhr8dU903mprJ9qlkRSkftYVyz+x
	FbwglKHo5JLHqZC4ETBMEKSxFAQovNlURACWviXYtjDQTrRGeACrK0iqL/AeE6MyuoQxSue7pUL
	qKqhM5sVbB+DdeOsyxTWIx9jD8A21S3g==
X-Received: by 2002:a05:620a:4101:b0:8cd:7ba1:ad with SMTP id af79cd13be357-8ddd00a8f74mr32479185a.63.1775764916586;
        Thu, 09 Apr 2026 13:01:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.92.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9a29749sm32181285a.47.2026.04.09.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:01:55 -0700 (PDT)
Message-ID: <69d805b3.050a0220.4866f.8890@mx.google.com>
Date: Thu, 09 Apr 2026 13:01:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1164533044066992611=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: validate RX buffer tags
In-Reply-To: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
References: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1164533044066992611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070881

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.85 seconds
CheckAllWarning               PASS      26.75 seconds
CheckSparse                   PASS      25.84 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      523.86 seconds
TestRunner_l2cap-tester       PASS      28.24 seconds
TestRunner_iso-tester         PASS      43.87 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.70 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.38 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.60 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
TestRunner_6lowpan-tester     FAIL      8.56 seconds
IncrementalBuild              PENDING   0.40 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g82f7c36a4459 #1 Not tainted
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g82f7c36a4459 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.915 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g82f7c36a4459 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9884d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/28/checks

---
Regards,
Linux Bluetooth


--===============1164533044066992611==--
