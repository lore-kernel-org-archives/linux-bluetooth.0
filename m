Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9040DFC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929389; cv=none; b=nvBdj5BDMKRav1zeI/kIFolX2xqOAQJUyH3CV1+EpwaJZuvIH+9UbtBvvJY037l/Ms9jhhJspLtb8hA1Xu/R18au6t5TABuiKNp4A+TrJ+SjkaGhjWFzscMl5C6HaOI5pVv4ifihwdZdlPrGJiZBSLz0Dgi0ZV1kWjh9ZT3MDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929389; c=relaxed/simple;
	bh=zY1TGrkoXc+YDh2qmqTKnUXvVpJwlXypdNIW1qivqyQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GjS5wPZqgmGEhP2J6JIwc79kzQ/wu29jdDTZ3Th+t/ihVKvEqhrOO2WiltjsgqXccn0UrPK+Wy1VBF+QGkfWdDhAnxlki4P941vfa4Oj9ezCN4NXF0cEr5y2nKuBauq2DxxP+jf22x58B1fx7XZOKbqNlJHdym06ppjQeroVeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL5hYIGw; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL5hYIGw"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c444dbe8eso648340c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775929387; x=1776534187; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F2vm7n4ujZ+cEK73qY+Lnj9Cxdv2JBZ38UjxrbtRbow=;
        b=dL5hYIGw3l54LD4q5c1J10JKfvkWsuK3Dl31n6iSgVOjJm74armHLd3NQu5rV11tXG
         8wnBQZxLW+Ccy1ZXzVNB9Bu0YaUcto3Qn9nX56UYQyr2Q9oCoW8JJM8G9BDxkhdhg7Su
         lsIFqIrX3FJ/A/HlcJsR2pAULxxZlhYLZhsMMRkGetZC4wNgKfpTObfIL2WNi0Uy76jI
         ZZnCLvFHQBD+f/W1G2/0Xi92OZKAln4h44FjEtexQou2U4VMcYrFTYaLYruk283iNhHM
         J5WZYRqaihhoq0LO5mgj6VJkiAd+HT1R9Bd0VydHMRmwEVTEoRMc9ppdxYhiX2h+4ti6
         Zrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775929387; x=1776534187;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2vm7n4ujZ+cEK73qY+Lnj9Cxdv2JBZ38UjxrbtRbow=;
        b=Rl7aYaLhn2YFCc1on24xLPc3WQp4S97axyAE5Mh1MQRyWzGg//zk06+SfbMY1WAQMP
         Ex4n9GrdfEbLDC1lhzUe4lqTDMRVupAifue9U4tbqASvK4ctb8ry84fCcyKi7AGapjlj
         tNoBEs++00E/mWbH+8RKYlHt20iWUjAQ0iJpbnknrsg7zGq3GXk+XWa7ahdDULU5qWga
         JQejAz9v47yVk/GFpjqdC7NRbARY12z/s67MiUv7gjgULf+Ljsx5MtAX0lgPr7o64cY9
         uC4Ai2NnQV9cwTk1LZ8WxXRjjcy/N115UmaCiJ0EXSd1Dg+Sta8Wpd68M/mS4UUP2F5j
         5IRw==
X-Gm-Message-State: AOJu0Yz4rKL/Iys0eRoPg5OzVleOrud4zfkAY4uDKPhhlA/OTuva1Nt+
	OHb1tCYp7YZbyn77M4Meeet4anmx21cgCEjE5t0hMphCatk3+j3Am4J13q42gQ==
X-Gm-Gg: AeBDiet8BgdxXtVFd9IlXNUsG3ALTsFje5v2Rtv8amsFifyCoTIKWLcdQfl+xRvq+mc
	zqe/14BcqFYzzUR3CyMqzvDXkYCiPM6tq4v+cGcMwbRO6gprbQvYwJuStOKaZoYw80KJ7J6AyR4
	8sQRPfKZXD4c9Q4YTx9gQVMtKaSmiGJOszz6BujvRzTXHANlswza57t0d6fYQLcRMZqYs5hLh1y
	PZZMFGLVqryNH2NWurc8tCGb7BtrVELbCuSDIAimACMUrFRrheLN/Jo2VLX1Jg3kfMuDR6oCRkL
	BiaXx74b0uxooV3bfbcWR/HUaRPfJw05NiMrPPXdErKD3NnVuZ43KAT3Oi+VEdNungMCqp+zeFo
	iVjOOsYDr2Xx0QAOrx2hle7G+fOu9Cqo8tcwKDIbZq1+EE1RDt/mQThQolKk/A42sO15d2SrIKr
	bEts8Riju42HuT7Xk+5NuG4uyMLDMBmSe2mLIG4+fLFUw=
X-Received: by 2002:a05:7022:6282:b0:12a:796b:7cf1 with SMTP id a92af1059eb24-12c34edb8f8mr4852129c88.23.1775929386732;
        Sat, 11 Apr 2026 10:43:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34acb077sm7298105c88.6.2026.04.11.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:43:06 -0700 (PDT)
Message-ID: <69da882a.050a0220.e5073.4150@mx.google.com>
Date: Sat, 11 Apr 2026 10:43:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8643228173072045657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
In-Reply-To: <fec5396d32d1ad2c3c097d39c67b8b7a2ef7d1bc.1775927513.git.pav@iki.fi>
References: <fec5396d32d1ad2c3c097d39c67b8b7a2ef7d1bc.1775927513.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8643228173072045657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080177

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.27 seconds
CheckAllWarning               PASS      28.86 seconds
CheckSparse                   PASS      27.50 seconds
BuildKernel32                 PASS      25.64 seconds
TestRunnerSetup               PASS      570.02 seconds
TestRunner_l2cap-tester       FAIL      27.97 seconds
TestRunner_iso-tester         PASS      38.83 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      113.79 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         FAIL      14.57 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
TestRunner_6lowpan-tester     PASS      8.74 seconds
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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.115 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g37c0ebcf808b #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g37c0ebcf808b #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.894 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/68

---
Regards,
Linux Bluetooth


--===============8643228173072045657==--
