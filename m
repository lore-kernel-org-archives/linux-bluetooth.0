Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C42641CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766040; cv=none; b=ZnumjBEBQHEs6nHo+FLpni8dtyz+sczidzR8R6UsALnRVQu+nz4MJ8ZgO49xpROWS8NAzpyYGHJmJyLyag5i0aUSwvkhi7G78HeWKsN2ioC29CcQ8yNdZmIwmug0qzkOY4MFNtPSprDjGPHk/zkLY6tAbqwa8RbuZLOoOOhkRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766040; c=relaxed/simple;
	bh=W6DU+hM5aiv/8dKUcWmmE3qWdXFUOpec/Ntw4qNoQoI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sNHMU5ciKelbYCNuNLsSJWsXZT33VAwQZKXyMFy/rkghVqpAYsp4XYy2kBV+Iq/lwWwZTXP9UmdpWvW4yaa2zFk3EkujkqASmJ5WVp3Bw69TMTOVLb8yHA4RgLerXp8OpRMN6Znw0WJuKg8PjjGSjhrIbx7vXV/1lwXAwkbdbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH+XNPeO; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH+XNPeO"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso9408766c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766038; x=1776370838; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6X8M/pGS9ctswmNcs7Vui7LLFAmpFikn4+RxPDurLA=;
        b=YH+XNPeOchX2OnIhgpCv4G0s4hccdXPJG35QQ02MxNLbBsV8Evkh2ga2SmE2jGaEVp
         f8WtFw+3fVX4hjnA59symayCTvtADxBd0fNuWp3yL1ng5xJzquc3sJCixZ5tNlG3nynq
         BU5ECTR56dKRy5MlAYqJyrt9PGBjDGlHna8HjN1bF5FlDoRv3jrIkTyI/9A1ZRp3HDKB
         F6l1HCRzkltoQzx17CCJujqFrnjHllUFUQa5QOfrflyEim+LPQI06MDuCvwQ7SQiAnxO
         RslfSvpTyM4USKjruxuwBEPPYbvjg50I8Fo4Bdh5HSxFm2VlpprM5GqZrO7bXui9BZBp
         9X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766038; x=1776370838;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6X8M/pGS9ctswmNcs7Vui7LLFAmpFikn4+RxPDurLA=;
        b=n/uNo0oG9p54SWAVUEetNt7BnyHzRsZ0Bife4+hHnb37Cwpq2sCW2AvLEaweM7g8sX
         F9BquBSc1j9LhxsShICVBKmG27NJT9NEtUCT6lilVXeDLK7wHICsI4JeEYaHDS/+jtBP
         ZxsyySIJIYUXFvPYOvOFtEubGoK2ACeAfkV81tHFCx2qZ+fANiE7fsH58Bs5oGlbjhM+
         f2M5pBepofrAhJKSpuCMTf16vvBfRdhDxbCSRZp1LWesxmvvtY0bsg4PSyYHT+8W8fgQ
         5K+XwK3YaIuZPZQv4B96NfmLPNSuLO0JAOkT5OfiepmK5Her0uig8fl56ZytjM4c7RQK
         4ATg==
X-Gm-Message-State: AOJu0Yzte5P2tZnTdg+befvI4OySKMUd21o76YQtuQnptUJjr7njUVGA
	I9HrGmJy2NFOlKbP3B7sbEhAFn6KN9x6wVvaLtbBj2MsBSiuju6JruzXjjCK2A==
X-Gm-Gg: AeBDiev9vavlr4qYvdBIRY0o7gOmIXTFIQXAdMCCt8jMKqU96eilcEFAwH5vHapSs7p
	lF2YN+cdelLBoXt5HK3xjG6idYpUDq1zpOH84X0gulR96UB4vYue+ggvnHHNK7kXlKMhonnYdQq
	BVfElKSA5Tfy/RTc4RFb8AYbexPLzQLDOKZlKNQnam4uR1NXcgkkdugaszDv8kp7qeD/lIVSplO
	aGaB9IDuyGmmg7S7DA+5sibGn5Pi6nePzUJTmeonjso/YQt521tE+3qMjRXCVBnxBLCUofff2+1
	3m8pIz8kalsFZxMI7wlUIObZJRfi7vuephfyeKeg8K5OcT+FysryW0t25NGlN3X299Wu14IDBBc
	f1y6q9xLqcE71800TRYHEAxyWdeydg0ic+Hq6BreJijNM4d3AiE3956IJNXlQw6Mp8kS1JDx6gv
	j06vyS8Kkbc/wCR/15BNtip1gk9tU6oxaC
X-Received: by 2002:a05:7022:eac7:b0:122:2f4:b251 with SMTP id a92af1059eb24-12c34edee1dmr284948c88.21.1775766038213;
        Thu, 09 Apr 2026 13:20:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faab010sm1210799eec.12.2026.04.09.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:20:37 -0700 (PDT)
Message-ID: <69d80a15.050a0220.2644b7.157d@mx.google.com>
Date: Thu, 09 Apr 2026 13:20:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6723729679282666577=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260402154810.2467291-2-johan@kernel.org>
References: <20260402154810.2467291-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6723729679282666577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076527

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.47 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      26.79 seconds
CheckAllWarning               PASS      29.28 seconds
CheckSparse                   PASS      28.13 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      583.75 seconds
TestRunner_l2cap-tester       FAIL      29.76 seconds
TestRunner_iso-tester         PASS      37.40 seconds
TestRunner_bnep-tester        PASS      6.60 seconds
TestRunner_mgmt-tester        FAIL      121.13 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.73 seconds
TestRunner_ioctl-tester       PASS      10.65 seconds
TestRunner_mesh-tester        FAIL      12.64 seconds
TestRunner_smp-tester         PASS      9.99 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
TestRunner_6lowpan-tester     PASS      9.03 seconds
IncrementalBuild              PENDING   0.39 seconds

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
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.120 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.576 seconds
Read Exp Feature - Success                           Failed       0.116 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g974015308a27 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002043240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g974015308a27 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.609 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/43/checks

---
Regards,
Linux Bluetooth


--===============6723729679282666577==--
