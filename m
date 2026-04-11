Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5742F851
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775915923; cv=none; b=ufzO+TNR8owNTQXRs/qP+RqOwg4aFCRG7jSMuMSxzfOJL3PxMy2K/AWDiD735xb0qGmrF0JPFshD3DAXD6xVIvsEYHjNRbvxGxzgonzlYSdNmDutZ3oi+K/abpHHUeULMR4h3/2uDBzrMCc6LShk1vY9jn7CVP4PZEDLTXPsq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775915923; c=relaxed/simple;
	bh=X9qpARMr7Ivyz6i6/2dnypxv8ZGHaFazQ/zBbd2dZY8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FZ/ctHNAts++tWRF2rDtv/73CoE4mEY1p2/v9OvX+eVp6X/oQr1DhtXuA0wODzCS186/nJXg803udY+lSUnzcU/ADimYg1ydFwQ1l305OrkUtaVb5PI4lu2EE9L3YhKs3HNgCxP3gezzgGgJrf/vWVjcOpYMApifOuYYi076paY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hce1R3mN; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hce1R3mN"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ce102afb0aso3880194eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775915921; x=1776520721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NaX+4DAa/SLvsdILRtJFhsrzSUqydaub+g64uNacbZQ=;
        b=hce1R3mNKRZ2sza4X6kP9T7kOHZToEiyyjQu8Jg1ryhPLlcoIwq49CTz3k947gQVL/
         mDTLgu41qLC6AHosKct9bCXhlNk18lsiDsN+0MJOms0Vn/bTWuSe3NJkGdjoYni56cY7
         YzuIDXySZ32UKa/sc0se5BNNbcZOZ8NZ55cxtHgKA/YKScFNIpZtlZk7K5P1z1oJYsm1
         zKdeMw+dUp2aS1Ozol3emkwbFEu2OopBv+Eerre0bd56+H15WhVteRZj1EhNRVWRm/m9
         H4K/uDpxc+oVas/AhcpqiN42rW+iAgK+2g878dRg7m2i4OHXa8GDwwGYkr+4ebebGaAi
         3XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775915921; x=1776520721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaX+4DAa/SLvsdILRtJFhsrzSUqydaub+g64uNacbZQ=;
        b=PT9uUSGQljX2iPHRC4/bNfCAdVpx/ipdIsyzY9RNrZWxWNMnWhsYdOCayV/f2t/lxp
         LeL34wLBoKenXB0hwla03Q7zlw13GMQw64oEmPMQVp7SlRfHHa85Qj4t28/v18LB62pt
         U6cGNBnF07oK9/ljtD4gBKTPslZEtGVu/GR2APV8Jh3P8MrL0I3DloIUpMb0D11JSz19
         6iLWCLq9qE1X6W6YawRSbxaJ8f1ktx7pKwgapeBmqS0R/S04mQf3Ur91YlBS0thTbVyc
         fV5leL1Iogr3hVkWSsTSsQNGvdSQ6rK6HbMfijhh6ug8SIPpP17/18tSJZHshV2UHOVv
         LQ1A==
X-Gm-Message-State: AOJu0YwXcPK8/kjnUsFl3JGQCcw1xZ7yWbOJKS6J+C7kQQn9ytYAC7vY
	2y6+2XBiSfbYqpz5VWtpqrzZHrK9UhrkKbGq1AVrfbWq+LXkH274Oz895x2qpA==
X-Gm-Gg: AeBDiesYWq+TjiwOGgY0jYccOY+VDiHyX1/w5swrzQdQFQ476BS5uLGNxxe7Zi9K8X0
	4hNzfVvmnrY913eHeLQFfUx8xa2upU9PYnp3/Mcv1gDBZ4pY/x4tpSvD4VtBFdVAgDdJFo+0jj9
	4SsdvmV0SIbqfnN1NpMv/bTb+bMjiPN+IIS2rPiFmt9WPmKid2ZqnxOyMd6aUW01XHjv49drJtd
	t21od0TnAyDVYyIVrVb6hB+7L2si1IvcKQH5OuteC2rJkoRFnnsS22FwmsZYnaAXubrvrz1GAkD
	QMrp46kADShUv5u9hi7HWKfJ2AlP/h+IAhqCM17J08pXBf478XlYuR7qBQD4eNA2YHtuO/LEGA1
	mfRrUdCIzDMpLGzgwP2akqzd2VH9ixkpDzaOdBdJJA23TBmemp3HZ8tOuPoRJnNFXWucl05E8pU
	A/1OvGQl78/nDOYtJzyGhxwBqNK9BV
X-Received: by 2002:a05:7022:e986:b0:127:15cd:9f52 with SMTP id a92af1059eb24-12c34e37b1fmr3971419c88.5.1775915920957;
        Sat, 11 Apr 2026 06:58:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.2.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb26dsm6770640c88.14.2026.04.11.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:58:40 -0700 (PDT)
Message-ID: <69da5390.050a0220.1307f.8857@mx.google.com>
Date: Sat, 11 Apr 2026 06:58:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0517483561337753911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_sync: fix hci_conn_del usage in hci_le_create_conn_sync
In-Reply-To: <8e7f8a9749b25162357bc8a64caf0429837a9191.1775911785.git.pav@iki.fi>
References: <8e7f8a9749b25162357bc8a64caf0429837a9191.1775911785.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0517483561337753911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080113

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.52 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.91 seconds
CheckAllWarning               PASS      28.59 seconds
CheckSparse                   PASS      27.16 seconds
BuildKernel32                 PASS      25.34 seconds
TestRunnerSetup               PASS      566.48 seconds
TestRunner_l2cap-tester       FAIL      28.61 seconds
TestRunner_iso-tester         PASS      37.73 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      116.89 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         FAIL      14.44 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.59 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
TestRunner_6lowpan-tester     FAIL      8.81 seconds
IncrementalBuild              PENDING   0.37 seconds

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
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.122 seconds
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
7.0.0-rc2-g92ec36913d92 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002625240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff88800246a220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g92ec36913d92 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.788 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g92ec36913d92 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880027a7140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffbe84d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/67

---
Regards,
Linux Bluetooth


--===============0517483561337753911==--
