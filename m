Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478A2882C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764968; cv=none; b=g3u5pPhy5EeU8kVCS3wHMFUXBiTrK0TpFqboVQO2epewGrh44/C1Ce+NwwdcXZBTa/FL/XvqX9l5zEBm93XLFxzF6C0xwJxgeEOFM3PMNzNuTDHsOdvcoUJIJnKoC4J0HNUP7mUAhqBHHUS/XQKxzXV/MdA15YW/wcM9paSHO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764968; c=relaxed/simple;
	bh=LyTyuXQU3S6LI51i+KFM9Q1pCr5pkEBX2hnTa2ci3xU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s/t0psYGuYjlHlbSNj/Zt3fhofN7roGG+LyrfwkcnODyv+RuWO91INSGMxED25xjmDGv2ZoR+uxgAWVFsxxj1pFubo/Pe4DsUOsZ6F9V8JP65DWeo6qttHOcgvdMBfsbqewGT7f0YmHpODC8NH+P+a7tnYAbB+IvwMt93gSe/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwFeQG43; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwFeQG43"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c70b5594f4so127274085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764966; x=1776369766; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ugU5xL9MNaIXaBL3dyzPR+rIXbzq1OI5pe+A7hKBr0=;
        b=FwFeQG43vIT9l2F8LyIC2pei8N9mDlFIMwTc3FeVxosJ/fdVx46AyLNp9U85yQ0ZP2
         bPqDEEz4ZTqh/MO6k+OZoN33AkrWdH40rTixRvYx7qwX4whKUnlMYL6TJX/99gHzUoh0
         L2AYL0Crka1+4GMR2uriRtbmwNKqtiq/sOQ+oZ67xJ+H4iVIe8o7d88w16oyR5lxCiCJ
         Jx3Uf6CWLyaMD/UtTAp5nU/uZQCW/iIxFBPHOLRE8begkurM3RRhjLfNBc06Ye7pngya
         45517Pj4LpxRg0mvaXkYi4nMDB6p8/KjV4VudbtRftgKyiUho5MTw3/Lbv6/xTqZJ3Sq
         CjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764966; x=1776369766;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ugU5xL9MNaIXaBL3dyzPR+rIXbzq1OI5pe+A7hKBr0=;
        b=TVhwJgZ67rDV2pqqHMOic1nwX31y0w27C9o1MU1shmcJDAH791Spo/Kt467lAICVCO
         oGBQY8G7ZYKo9w4ytC9YdKD+nTu3rSVa46z845AYEeJx9C8UiP+Bhz9YhBXOFyLFvzWF
         iBxa+ClTJpcP6Z73JmvpCri95eKkvCN7DHVwqmDou8j788bwCJHXOurY4m3Yy7rXkpiP
         4DHbTB7OXphxCx3BIzrgD0dwof52Q3jTjOg52QLLUOitzK7srUJJOL94PtNbkQoRt5RW
         10hb+sxuocfAWS7ePG0WEQrqIkNxAGagYA5MMb8uOB9cqPosAO1tKdIw2cwl6+0Vj925
         +ZJA==
X-Gm-Message-State: AOJu0YzRKUdVkemgokctz6q7KlaKU+6CPU8qXScKwRrjea6Q+k6Tk/Pg
	buf0ESBmQVBZDo5ICvqy3isY3S1nb8F9Ib+IEVMbbVfKZ7sk97VDzUkq4Gm5Vg==
X-Gm-Gg: AeBDietzSxdevmqjV+fbxduodQ6U2QJtySfxgdc5nQilx+maouZJ97l28Gx9qT0ulcR
	papccMq0+Nj6+xWirWx0xuoA4kUXhXM0/igZBqB9Vv7De6txGWOrJmgiHGk5QSPFdCiNHZuywd2
	G9MoB4BvucZjHZVeYtQEU52BKZ9ZeGOk1n6CmHCH54WgAOkrZW6xUX9Fthu5mPNkvL4AtlUc9Vy
	Gm1hLo65o7E+lt2Iq0JnkZcdgCR8ULOcb708THaCZw4XTsqqwRePQ82te6lucmSrJRgD2CZhDXx
	JYsUa3mYpvmj2Vje9UQ/cOEtgMjnvqGpd7PThy4hFVTT7rrChIJRZqw6U0YXJ3NrMa7ImWH90i5
	yusUUYePGs3MNl6JEE2/O2oeIf8VXzy3sxhsnNwiTfnXKmkToGyqjIUkzdRUVIqjtZIeamJz8Ma
	U9evF5KL1Gu4JlSdVUgGVN+1DGWbKk9u2298jHNThARw==
X-Received: by 2002:a05:620a:3721:b0:8d6:795d:5b84 with SMTP id af79cd13be357-8dc45d295e0mr626819885a.21.1775764965605;
        Thu, 09 Apr 2026 13:02:45 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.135.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6dd41sm33752585a.25.2026.04.09.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:44 -0700 (PDT)
Message-ID: <69d805e4.050a0220.172fa5.be13@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6232609581982439983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Add support for handling PCIe M.2 Key E connectors in devicetree
In-Reply-To: <20260326-pci-m2-e-v7-1-43324a7866e6@oss.qualcomm.com>
References: <20260326-pci-m2-e-v7-1-43324a7866e6@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6232609581982439983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072784

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 FAIL      1.59 seconds
BuildKernel                   PASS      25.89 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      27.42 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      561.09 seconds
TestRunner_l2cap-tester       PASS      28.23 seconds
TestRunner_iso-tester         PASS      39.35 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        FAIL      113.22 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.77 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
TestRunner_6lowpan-tester     FAIL      8.94 seconds
IncrementalBuild              PENDING   0.34 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6917ac00db83 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g6917ac00db83 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.884 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6917ac00db83 #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff888002777140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb7c4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/33/checks

---
Regards,
Linux Bluetooth


--===============6232609581982439983==--
