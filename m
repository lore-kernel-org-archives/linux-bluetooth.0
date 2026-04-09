Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A002882C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764934; cv=none; b=uym62TzOEEpiRtFjkbkWE/pNL3593clGB4k8iV70WcBBvMC9qu9IHbHgJIPDsKIMKENTJMXHhkXfbzfmlaZk0/qIJ5SbVobXjYls2xdk3Fd1ZJdLl8ZTxZwobRyEkCYOe18w1ABrScpTHsvIK8uyI6puRpGn5XR2A7lj/SyW/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764934; c=relaxed/simple;
	bh=0Q6EVc8zi4THEDCc4AHQoyjXP1cfptDKBDapqL786+E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UDbamL1jIyjXxBZq0PQzS6J9269oUNdbxQfnRW20lVAnbdD7Vf1ZHBF5CJhAq5kpx2gndDspfiWroLQDZuO6IhTslBXbUAl+L4CH2Lzp+C2cXGYb/rOi2WrKWumBKarT6FomkoiHhjjAuCJqZSNSvpIu2ijtWDuChO3O33QUb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1ubqgB3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1ubqgB3"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d68f702851so170369685a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764932; x=1776369732; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ukk1X6z5WLEAddJZz8oNDGm8JrG0zvl+sQ3fp6nORQk=;
        b=l1ubqgB3PI9OWbmtj0ovkM++GmMGmulS+KCzW6xnZF7GEprMdoZlKzWmjBYa7VsVpi
         53umovoKJ33f9PW0KtE/WNS0PglKgbqcaWisIYQS4mjqGRXDmE+xWsr+eRUagNOCsKSx
         7Q5f+gOnbc/uDtJ0y2EJMAw6GTtIa8j1yxok3hMRvBiRJ/6Op+1e0NdNuVkEFVJCx3gW
         GMcjXTelk11nJ3IvS3gg/LcoejEeg4y5vnX6KcipcmxLQw/daZ+GuiDnf26fcKdJlaKg
         lBVJKybZ3MaGxR/mcmlkBPfe3nOJbQPlC9P9rizUkjSck49NGxv1Wc29E/PzsCeEQY8Z
         7LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764932; x=1776369732;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukk1X6z5WLEAddJZz8oNDGm8JrG0zvl+sQ3fp6nORQk=;
        b=q1nhUze4XXZZcskC2QLSLMxeGPr0VwzJHK3hMEAvh23aIXo0qJe/lpluDme2QAql1Y
         b2jv5j5YYKsIhot78+NtqOvmg1H//yPYe2Fsjs2fFiviPyzFqiyYxVBrL9+Ek4m2UXyY
         93M9gNPV0MxiScG9soHISOuaTe8P4k6skdV4IT7oiHzoSzTJfk6LsUPFWfln7hQCI554
         OkBDjOVALqFt8JA1r0Ji0IZY61Ftw2UvXwlUnzoXXkdZxS1sEf4g/ZHbLBj7c5CKPE1w
         2OWTX3O6PJx0F8Hv/jaMAVaciGuczBnCc24KrzTT+RGuJSRHaAthGYXPg2YfNJf7x1Jg
         o2+A==
X-Gm-Message-State: AOJu0YylMzY4DxgyFYMW/lMCa/h3DcfSbFbPAsxybX6+RBScXUgXYa1o
	tMoVfRBHJZnIUdKBk/JhwEpdEMpmnlc3xGoBvIugVBZoEvEl+AkxAr15d7knJw==
X-Gm-Gg: AeBDieuPFeCkpJFHvYtLPP+0hFia3DtX8n25CSRS8zQglApXErEfet+Ui7KGrnPrwMa
	M0nkDs4spCWiznLnvx2reyMfGQvnlVUDl0CgrSudJwsizZSimL/DIZ6Ocd0UU8N7SNNOH8aEFZu
	AYg+1XiXwk+UffmgsZK7bJhK0Wj/H2zU41pqkHDhbqzfgAXTEXqvsd2j2NHcw7dyoCa3eomCZie
	qr4hFp+WaE9tAiLS20lS9dRKm3H7trHZzxKFq3GOUc+pGgexjXxW1WQhhMcs2QSY5SYPZaYc818
	vSDwVBA2dhfkCKV4M0ueCzyjj1nX8YovO1qDd/rsculC3Pw/4Rledj82LMxCC5dW3d+PbXgilax
	2+fI58ZGlL1JfpGceAYO0qtnT2StU1Ib91lQxFeb2TL8G9mcaPNotkCXD+KsGqKsy9UcxVRKHBX
	YeGMbGW9k202cIA75cLKip9xxdPfH63Q==
X-Received: by 2002:a05:6214:460b:b0:89c:57b1:6018 with SMTP id 6a1803df08f44-8ac861a155fmr3061876d6.16.1775764931873;
        Thu, 09 Apr 2026 13:02:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.240.186.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cf55b7sm4158816d6.45.2026.04.09.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:11 -0700 (PDT)
Message-ID: <69d805c3.050a0220.373819.d70a@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9059388263782028804=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: validate completion ring indices
In-Reply-To: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
References: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9059388263782028804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071502

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.62 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      25.53 seconds
TestRunnerSetup               PASS      566.74 seconds
TestRunner_l2cap-tester       PASS      27.91 seconds
TestRunner_iso-tester         PASS      33.27 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      114.74 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.16 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
TestRunner_6lowpan-tester     FAIL      8.64 seconds
IncrementalBuild              PENDING   0.29 seconds

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
Read Exp Feature - Success                           Failed       0.114 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gfd94a4715e55 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888001930220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gfd94a4715e55 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.920 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gfd94a4715e55 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9944d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/29/checks

---
Regards,
Linux Bluetooth


--===============9059388263782028804==--
