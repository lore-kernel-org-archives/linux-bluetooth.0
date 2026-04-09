Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C38239E75
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766115; cv=none; b=qgcDf0XUrLB4AZmejOF1O02SbCtReqLRR9mGlxnRE7NTO6I8pIwNIEDEk4wfl0bJ0kfhS2dAb6fIfN/GnMPUqc8+bsUvx33qFd2gtR3pDfLvUbzFptE2rvk1fSKJ5+OIKvlA6iWxCJw6mRndIGYLIHYB0ENkCFpDP/1tu3e1YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766115; c=relaxed/simple;
	bh=Hp86QiLcCPOw8C4RFMKnWtAeKYGDy1LT3zWhGtyJhO0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YnotjfSqytuaql+rIEogjOBjymxURPzCREg9BIBjpRM8YbfLvMjqUFTeYqCkSE2f2uzDP8/taHGamNoPS6jNGULJVnkBgao/vz13HtFdUJrllqVBWCOKRiyDENl36jB8gbvx8+zl2yWxcgNBH/05LopPi6mESRDT34kJYua4AOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QumERcBN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QumERcBN"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a23f802e0cso20222026d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766113; x=1776370913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exBkGpU1wvSOyxHkq2z3TZT7dCx+Z4YuZFMN8+2F8I8=;
        b=QumERcBNDUBZiiuKKRFmaaAFC8pkwCbvhiM+vV3HQWvtKs3AA4PhZFC9l1IP0HQvpp
         i6mYtLGruy7ZYHYgTxUapPHCVwulFOa/J6T2PQ0AxuvF55D8lt870SZBiIvUetD7ak7L
         HaeOg4BOa3smmZnEMOeJGkMFQyijfWc5DI95jo0Ew0Ahui6/7w3tFgb/cRahsrPwoq1t
         g/QaXqV551pugola4EhQ2aN9DgjPdBIbu3JfqTRXTibTuWvIvSF1ZNTLTOxMFD8o3lBY
         Ci9G8pEFByrwNGdLbYdR2lutO/5Xo+PLVOl+HKG4FAO0BWOlM5k0veSB0fZD4SQ4dcaM
         iukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766113; x=1776370913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exBkGpU1wvSOyxHkq2z3TZT7dCx+Z4YuZFMN8+2F8I8=;
        b=g4lNviW0Htd07csKH0XQn+v0tSROSszSpOlW0XHwbUNARLZFeZNcAC8a+QMUnY/A6P
         Pd3gZl20Ggn4xA8hmcXMBH+W5yjh38y7WDR4gS91JjVDtrrUAgw/kXsOXlv0v9b8r6WJ
         lf84/Oa0dmbFOvfgFSo1uqXOIEWRBhGbkhWDchQBJEpeNdRWFtr2APn7jJqBzptYX2mK
         5zWaMLGIy932Uyzb/YW303Prak/LI0L8F/AX0i7qhRy+v2BuefELUqj6dB8HU8A6iDmD
         EcjgRm2ycvwP1iN66Xslu6wjsoJv7nT8dBkh/1AQJHJO5kHzzqSqWx+WDcIvb7+OJ1GI
         oTIQ==
X-Gm-Message-State: AOJu0YwBDqDK2lPi7qdk6q1Fr94Zxup97h1CG3RnoKOdQihI+keGjk25
	NjmxzmpqBV0ZlZtoTy3UCSsyMmKgDyR9Vngq61lPs2/6iIl/+tttFhbhU0UtmA==
X-Gm-Gg: AeBDietikFU7M3QAL+scw6+cQYuOOzNTubN9fTFqydFPRTMAnP36xlQwUV4H/tO5GZC
	lEqWxgSgN2Wsf5rIG3ZpZ2M7VMDFM0V06MA4tuFRo8nOwOEG7PYxoBGGw4q3xxZsnZiwFDCdRED
	JqnKLf/ClNm7zdEduSGZFS/F9Db5SgAP31xHvS63xENikTsZBO56B35h2j6joiPOvbOstREgLHp
	q9R6Qb7+ptc4hqm8YfmiL/SEtI59Qw22PQie73s84gMNosgab6cQtbcTN04euIHZaY+8sz9nuGe
	HcV2ru52vhqWJhGJjj9MXlWGDG3sYQHRqN6O4hTSC9UslLVT9S15q055zuti5AKCkVFyuhTXyam
	8jm8jPrR//pqvLmy/Nf3Sp7Zj7d7RmAbJTnWiTXrYgqnEeXvuL949q9WnmN/O+XnAsdOaG4mbRy
	4ECrxlgO4w49J88v6v2nsNaI1nhbE0f7g=
X-Received: by 2002:a05:6214:4989:b0:89c:ed3a:995e with SMTP id 6a1803df08f44-8ac8642c07emr3564936d6.36.1775766112885;
        Thu, 09 Apr 2026 13:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.167.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84ca1d19sm4655276d6.37.2026.04.09.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:52 -0700 (PDT)
Message-ID: <69d80a60.d40a0220.2fb984.8b3e@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1800822707051357829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hkbinbinbin@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
In-Reply-To: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
References: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1800822707051357829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075230

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.23 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      29.00 seconds
BuildKernel32                 PASS      31.33 seconds
TestRunnerSetup               PASS      583.67 seconds
TestRunner_l2cap-tester       PASS      28.78 seconds
TestRunner_iso-tester         PASS      42.38 seconds
TestRunner_bnep-tester        PASS      6.52 seconds
TestRunner_mgmt-tester        FAIL      114.53 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         FAIL      14.36 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      12.56 seconds
TestRunner_smp-tester         PASS      9.06 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
TestRunner_6lowpan-tester     FAIL      8.66 seconds
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
7.0.0-rc2-g9f419c47155d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880020be240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g9f419c47155d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.659 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9f419c47155d #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026f4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9e44d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/40/checks

---
Regards,
Linux Bluetooth


--===============1800822707051357829==--
