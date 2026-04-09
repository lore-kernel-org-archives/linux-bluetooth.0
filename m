Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA229B8D3
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766090; cv=none; b=bcGyMuz2eU65HpxyiVbPeLrq1ZBkZBX2qHXffZL8qctdAdHMWWjqQHQTwxUC1MI46f/IWghS3J/EPP1v87XSZOnntLmJJQtbUSrfAti+4w4TYxEexUf3OgFaE5ckyZ1apSICBDLcsLWfDlgCpDDdDW2x2/EFk4w0OxDhhOS3K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766090; c=relaxed/simple;
	bh=CehaUw9GIKC16LOXxJxDEjx0AEHunq607kF7Magd8IU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CmfzNfUhQQn+yZrzFDf5MfLS4X40U64uPPreMLMB22OjYD2Nakerf6b5kN6GgPEX65C4owcngcrasuBspavdYBlV7BBcTYGesiakWYI1blRCEruRVu9XlcGQn5Njuv4lNzEbj9aYQMwjbCB+LOvDkdKKbVk4iDXzGlVPUX8cTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idk8X3Sa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idk8X3Sa"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d67a483d3eso134390085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766087; x=1776370887; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rzskeuKWHhJIonEGx7CYvWb/UqQBZHAbzhT/nSmY9GU=;
        b=idk8X3Sa/47VlH4DcJFHkd7eCAEpXYhxz/hySYNOncilzpST6An86a0xHMeyW78Dl6
         139pPtQkh7JGQRIOzzQByLBBCrjBgkkUBWPj9YEUe3tdvYCQ9aklDctLcUk9TLXZe/WL
         B+uPczeVpH2301E3GAUeXgkANzM8kJUFdgxdZ/Q18nE6x+fwDcOJeNPWy/mkXFZxYLci
         wYAhWl1rbRCzaqeyKVjMKyTEY2CBpiK88ZFlX3UbXlyQRWmc3VjvSzTzb7SHcdL37+hZ
         DBuCDq+8Hwj05uUkn0mM+QBj7kb+QIQtEoz6TQT2w0muOpVV6qg3kI7QMfiaT+1qUFt0
         kBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766087; x=1776370887;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzskeuKWHhJIonEGx7CYvWb/UqQBZHAbzhT/nSmY9GU=;
        b=PlyOAkkgqKlyihPR3KW4rCfolqYPeNCDlIJIOMgrZXqjclHsgxNC4IhQoHUfAPxdcF
         M4tLvZvNus+/QVAzh+Nk5oSkONPbpW0X+8rYQ/AWgMbX8MI+Oqn1u/iUgBQCB7HuK1YV
         hMx6cu8Qd0BWHsg9EN1a32PJc9bAhOmyOI28/19lsRidgdDMf5NE05Udn7VWyRl1nYwk
         k3LrD15Rra2xn5CZuXOz3KVqazmOQ9P8XlRcpeXO5bX9pEnhqyXRxju7SbcO/6yGQQFV
         JXisgeHAVBHLqWn74VYQBh6j+Cfx8IYTiOvDB0PHdOFozjjK2WZZEuTT3AYMwe7wPRD9
         4yDg==
X-Gm-Message-State: AOJu0Ywldhmastj7qxrhAHHjVi1T64XwGha+WhwqefHC2Uqw/zhSA3+u
	najE0vRa04Hur1e/4vK+HVB7+4Hix+TI17uk87EiRPbGGbnDBYuvsg3imj46+g==
X-Gm-Gg: AeBDieulRfwQ4d7ZhmWuklGzW2Yzv/79Q/TynkLriMThJs+dQAf7CiFaszIrwjiEgvK
	AQMf7rqPUG0zIrxBvjZW7ODMukcRMz9hR2xEX9a5XnvJpsaJicu0q5azbti4lde/bdl4a+oECu4
	iror9+nESmaLP3cbaoyDCN7fgy/DjWHPYUZ91SsEduhC22vFbeqitI45oV3opuMQmaqGBqgwSAu
	ImpQyUDxVlN1ag87py9s0wQ1fqU1ZTO92mvyzhyr8GZzYE7C2bvUffq1XsfKrAzw/JlI6z9xTYl
	YOXR8eW161Ugy/UJoFH2DB04d7fRfiKZuQV4MVmy3UOJM3oD0XK+wXYDChoVxUC5pwvxZRziR65
	i+JdMDGBkdYVYQEBkErsERmUyA7HJwDiVktKEJV1xLqRES6axwG4lDeNjD0SrHwoUpkRuBUKhtU
	EtvGU0sZ6tBQBnCV00Bwg7k2MbjMaWueg=
X-Received: by 2002:a05:620a:40d6:b0:8cd:80e1:5a0e with SMTP id af79cd13be357-8ddd069765cmr44182885a.63.1775766087157;
        Thu, 09 Apr 2026 13:21:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.149.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a3452fsm6665506d6.17.2026.04.09.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:26 -0700 (PDT)
Message-ID: <69d80a46.050a0220.3a23ec.5fbb@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0144258070490009704=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: add event filter to filter specific event
In-Reply-To: <20260407114851.3087886-1-chris.lu@mediatek.com>
References: <20260407114851.3087886-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0144258070490009704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078124

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.38 seconds
CheckAllWarning               PASS      28.79 seconds
CheckSparse                   PASS      27.55 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      566.39 seconds
TestRunner_l2cap-tester       PASS      28.51 seconds
TestRunner_iso-tester         PASS      44.08 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      115.17 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.45 seconds
TestRunner_ioctl-tester       PASS      10.43 seconds
TestRunner_mesh-tester        FAIL      12.67 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.89 seconds
TestRunner_6lowpan-tester     FAIL      8.75 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g5ca9da91b469 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002415240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002602220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g5ca9da91b469 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.715 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g5ca9da91b469 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb964d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/50/checks

---
Regards,
Linux Bluetooth


--===============0144258070490009704==--
