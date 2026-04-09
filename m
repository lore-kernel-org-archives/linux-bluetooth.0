Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0003A8F7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766101; cv=none; b=St9MmZoWYUd66YjQae2BYrj2eGBC4VaetStku8krKDVi8fF9bmOcsUr6e7HkcgsAGMSgt3e4TrV5dDVMbHQk7vOGb9HJ9fepoJiPFeASy3tVQYGv5muEBglGstZLMxBcLh1hK5R9FxqsngCVWoahLo748zq6bT2cCkn9i6g5VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766101; c=relaxed/simple;
	bh=PSjcY35OvoX+hsWrEIjH44NXzrh7i3hiMCZZHRebp5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EJX38gm9hbAcW003sfdN2wtyn+iwTLsojaizaUWU2uFBaAKKoliIYFhQR8UJaGR/faZnux0ahEKMJnW3KIbZfC8qVMcYaplRendmG20DPJgL21UpzPqw8vC0fyf8CvWD9jZpLZm+WPJgQQLM+jAGziSEZsrUNFZJeIUh4G6rVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejg4AVkH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejg4AVkH"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506251815a3so10596721cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766099; x=1776370899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq+jpoE0E1QLM9Zkc/Wu9O597JwwBDUthCuWHND6jdw=;
        b=ejg4AVkH1nPBCvi4vtga98IQYtN9bVn7Lr9SBWvF8a2jm/Mb85lqqwwFNYPrDgH+9F
         aicINO87z/cst3Jjd/zPV32923KNgnAJaAHtp/QiDIHE2tOpHJtSAwdf2Ci7kloeSsHz
         /WBsBYZrXDdYBkRm+UmTSOtsoem9d9ZIanMBfy2urG7b4qgrX4tkfPWxPPLvZZLrofzt
         rxNQdtChZ+v8CW0VdsXsWYUeu/ZcRVrHAgG+iKzzBYqd7/Cv2RN2oMyOD3S6hG1k5YN0
         wJfzUStAmISIGyZtjl3uehBEnNf+IAD4mQ5vZXTIP0TsqkNg9bWig57oX6kO61w3RpuF
         jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766099; x=1776370899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq+jpoE0E1QLM9Zkc/Wu9O597JwwBDUthCuWHND6jdw=;
        b=BDSkSPjI7b6GGmU2rQDGP6nfBFs+r2Q5GbvRFT6NspKidP6XFoV6/56DmuC2z0mZF0
         ZOnVeKH7FXMJ+CyY2F4MbZNggja/X0DgRz86DsQfV76rNcHzs6pd3nTHsLNI+a6+N/Sf
         7DU7Sgs64r65U9E5mEKroX4Wl0APVb9uQUJyoHuSHKWY6QXb/hwU4YzLKoHWV/8WefCe
         G3Ay4OtoBPf9auCRVz/RQq9m1QbiPwtPnKzqHplte6MKxA1P62wEn4LNNsGWsTSsEjOD
         mroFYgWQa4bsrfkLDq2fRCekGMqQqlYgYYcE13L75qwDpua3rjuiI4+7mSzsUpttf3r9
         JDmg==
X-Gm-Message-State: AOJu0YyLtcWhata+aUaZvCYRleRJ+emfUChb+lLQU2qcJmo/xsKhZfmp
	72rGHvACmYp6YwIYYpT4yk9jvw/VUIvz5ZJoKUwYTJyS8CMpXDWwF7oSq/QO0g==
X-Gm-Gg: AeBDietL6IJ0iWG7R/1LQs5ptGFHEXzJs63+oUX/I4L7XeuEKjm5Yb9bWmMREjYe9eQ
	2AVfcRS+zNKikHFC7RA3jdD8ad6CGGj82abHy9O3LxMhXyOWN1u1fJqfWTM72+Tvi2FU682jUpb
	TMNvxWha9MTiFC2BxdDJ7SbcwmQrEZ38dS6vf2cv9a6fCDus0EoOo8uGiRGF/ZZ2vWcgD+lrNYU
	ePIShTVtVMYpEISoBYK1QicJTbLVNKy38MH4JlTmzHaQsDX5KLMXtRLbL/HRw9CFCQNR+xBEd/0
	ovAKBHvxW6IQrKWHXMguSrdvz2+8D+QIlFqBpk2xWouqeriF9/lzU4zgDfRcM4hD/FnSVw66Iwv
	y3iuoLVE+6JUv8sFQ/VWrmxtHZ7SzFntfq/6/lxmVexXvMori3vf80fRfbSZqtdau5jApfnHIhG
	YWiZAi6H9fCj9iZ+k0R3/I2RhDsIWh8qA=
X-Received: by 2002:a05:622a:a988:10b0:50d:a987:89b2 with SMTP id d75a77b69052e-50dd5baac89mr9044101cf.31.1775766099065;
        Thu, 09 Apr 2026 13:21:39 -0700 (PDT)
Received: from [172.17.0.2] ([48.211.212.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd564c160sm4793421cf.30.2026.04.09.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:38 -0700 (PDT)
Message-ID: <69d80a52.c80a0220.1a6141.bfcb@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6678967228041184115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hkbinbinbin@gmail.com
Subject: RE: Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6678967228041184115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      28.49 seconds
CheckSparse                   PASS      33.68 seconds
BuildKernel32                 PASS      25.50 seconds
TestRunnerSetup               PASS      561.70 seconds
TestRunner_l2cap-tester       PASS      27.46 seconds
TestRunner_iso-tester         PASS      36.85 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      115.85 seconds
TestRunner_rfcomm-tester      PASS      9.88 seconds
TestRunner_sco-tester         FAIL      15.12 seconds
TestRunner_ioctl-tester       PASS      10.36 seconds
TestRunner_mesh-tester        FAIL      12.61 seconds
TestRunner_smp-tester         PASS      9.16 seconds
TestRunner_userchan-tester    PASS      6.88 seconds
TestRunner_6lowpan-tester     FAIL      9.59 seconds
IncrementalBuild              PENDING   0.33 seconds

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
Read Exp Feature - Success                           Failed       0.115 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gae498cc69c41 #1 Not tainted
------------------------------------------------------
kworker/u5:2/116 is trying to acquire lock:
ffff888002086240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f9420 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 116, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 116 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gae498cc69c41 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.099 seconds
Mesh - Send cancel - 2                               Timed out    2.008 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gae498cc69c41 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026dd140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff92c4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/39/checks

---
Regards,
Linux Bluetooth


--===============6678967228041184115==--
