Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3CC27979A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764954; cv=none; b=hDmneQFxK3q7wUiO6GoTeP+7QLzE8mhTeC45PfmPuHGkJACdVPBZ3pCFn1uNIqqds/BVqJV8WWZ0dRibC4Gs0cehqflPZYSFou7vilzj1+jcA2sRfMAjIgNuO9IW8dm1OfYC9g54gFhBpTTg8yJx5b1gZF4YXIRK3weNzSGQeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764954; c=relaxed/simple;
	bh=5Zyk1i6hI6iDK8A3D0fzeMlVHp3E6HaeZRAG1u7UoQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jteEexj5aCVLgzVqbbIwWhZelhyIAEWlPmtyXGm8vTiwO0hnnrNnkGqA6bhW5Wy6i/V40JRmTI8R/lzBBBGPW6CYQTYX9UfDPpJFjZ7aol5yxfZxnvS944sZXGguVyKWUDlgjHsZLLTaslKAgKpnyZ5P6BwnXMGf3M79coZM43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owNQ+T99; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owNQ+T99"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c33bad4bbso59747c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764952; x=1776369752; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5x+HB0qpfKBH4zD4c7flUsTaGfi4I8qNw4bMPb+mJLk=;
        b=owNQ+T99PWRdkWXX8BS2cFSoSVBG3TdVwiUdMUyaocz479pQGOQKEnCpsRaDAI/1/M
         f9FISFEUaCJ73v+3jl8/rDJPWVmp06PkBNkeEfZoa4jhp3JEl83bOys7N+17Em+ir1Bs
         vxMi/J++8DcOhBeRC5SGxb1KefLv/utb/oPHTJxPLzZHOjI8fzVgcAhL5L6aSSaMw2Dy
         c4Cc+29Zwcs0uCgmEdcGHaJkmr2Se9BJA5cY2SJsHtqdRTfGw/v9rcx3bOCCh3+jFtXk
         v6QE3hsUjXa0qgCTdr0NvZKI1iXtpIiihULjGfIcASRSuBXVVrYSLI5dbTCvhdjClsyF
         DW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764952; x=1776369752;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x+HB0qpfKBH4zD4c7flUsTaGfi4I8qNw4bMPb+mJLk=;
        b=dn8kLbycZ+X3vHpougv+/nu9FQbmfCjPmwblF5Od1NGKd1bBmLelyj9FnKsKNTdh9p
         e3Z2mVE7EtEw1wZnHTekydhH3XawHSgL7DMcp0nHJnEpx4L3k1OkCzfRZhzgY+gVNqn2
         JhOUj5Y6Vjd6xq1gKrjm/dF/Cnga7sZ9AJS6gMv2d0mkCF8wh0R7OqFqN3/ko64bE13g
         LvazMlNy3KGlrmY5Y0W2Zmz71glgDEZTe7m/Afycfi2x00lSHfVs300Nf/ZOctH7vHe4
         swmPSFbqkZEJYVckZkaNJP15SYLq5gzd0Gj3CmmXn3Ho9k2Ytz4Y9pkIlT+bDjAADp0c
         QVow==
X-Gm-Message-State: AOJu0Yzq+fJjz0LiFs3hDFyx9V+q5/XYZyiurMmo4halLmHReYy05g0P
	S3FYcr1Y8QtF8GzeVwpxnwR2Su4cogd51bLZ1fMDXxuIs+PHD6K1qi0cowSdgA==
X-Gm-Gg: AeBDiet8NTl32vNCbMeoQ+a7qlXrzXVO/3Ji/MBZM9ZbsabkUeszERvs+6Tbv8E+Acx
	UAuubLaQWdCFpfGqrbHfFSo7VWeDBnbk0lCYcNW4LPiZ/+sDnjmOsuu53iLFc18oWOeW2N/+Uur
	U/yOKNZGTdO04jWaefJPJXgbwW7TF3cgf2ttzWJ/WSHyXBCVYD5dmCtrU4q1gkGVWzG1MB6xBrh
	/Yu5V/eV0sEZSY3Wf1I/ChG1RuFRd3STcuSvgF+sPLEvaPncT81BHzawhMDbF+FtKD+DWpbWo42
	ERBok4Xq/ZUVRC7vpPDE/v/Gr7Rf0HV8huyUF+mokONsXEuCCHvdHtXbOQ1hiPcfbRvXmdvqeEK
	ffv/f6MuicsztBfnMrUMwoi8V91zucwVf9SedXGxAvsVxGIn7leHkIsD6cnO1PvtlRmVT6kxsSf
	R2UZw1uU0m+7DjA4c40aOuGZzFJKsLo/5/dokEN1vptJA=
X-Received: by 2002:a05:7022:ec1:b0:119:e56c:18a5 with SMTP id a92af1059eb24-12c34ea3102mr263169c88.13.1775764951923;
        Thu, 09 Apr 2026 13:02:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm739235c88.12.2026.04.09.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:31 -0700 (PDT)
Message-ID: <69d805d7.050a0220.5ef66.6c5c@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0095132910955540267=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop
In-Reply-To: <abwS8q6yvVAGI-ci@v4bel>
References: <abwS8q6yvVAGI-ci@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0095132910955540267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069345

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.13 seconds
CheckAllWarning               PASS      28.72 seconds
CheckSparse                   PASS      27.52 seconds
BuildKernel32                 PASS      25.16 seconds
TestRunnerSetup               PASS      564.21 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      43.39 seconds
TestRunner_bnep-tester        PASS      11.38 seconds
TestRunner_mgmt-tester        FAIL      115.13 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.65 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
TestRunner_6lowpan-tester     FAIL      8.82 seconds
IncrementalBuild              PENDING   0.43 seconds

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
7.0.0-rc2-g79a719fe1e1e #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002415240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fe220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g79a719fe1e1e #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.820 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g79a719fe1e1e #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff888002760940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb284d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/25/checks

---
Regards,
Linux Bluetooth


--===============0095132910955540267==--
