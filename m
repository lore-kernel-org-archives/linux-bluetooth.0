Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08471547C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764933; cv=none; b=RrNGztZL/bLkEfqt+77InMQ8F+leChr3aesg3PsKb+PbLDaWxWEFfvEmCLI9RtQRuyj9xi3rdOqBc9jw6+lWcVLrSc+Lw4ylRXLHeoZeXduT3Iy8IBGRJy/yLjQgaDzukf9OBQqhbGykA/UHiNbQCTq5kdzVcsu0DJgWE6G7o+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764933; c=relaxed/simple;
	bh=0qAVo9ojhKBMVKaEHrITKyhuyuDa86oUn53Bm1h29QM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WUO9ZA3SRpriSaNhcAHcH1jXk8LvyFItpddqSirn6jp8k956xh2Cfmzl98Bk4syQj6YhPb5z8zsAtgXhwnbl059JLoq7DQuw8l505NEBFolJjshgeWQJ4vPLcwVNnDeeWwfC+sAFZME1E3TKR7eb7cD1Bxmpm0BZ3hFfsX00mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3bQwSf+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3bQwSf+"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d68f702851so170368085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764930; x=1776369730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GnSb06ncz8f+qqlIqjFbPGdYfom2CbtuJT+XgolU5WA=;
        b=I3bQwSf+D59rHN2q/jk8DUYmS2yqTQveUJ7ZV1ht8uvtbGRVIgOqUwr9jQsa3WuiNB
         YoTTiTUrfl5+gwsNM0IkWggZe2ZV1ie6ryJa6Fn5QWCzPPLpnKGwxH6PMmRMXlryIVAU
         2rWYg7UDOQmq0vE+3LrYMQlGpGUYw2LZIOPSOmR52SdNUWLH3wcOr7XHRu3zRQrzP1ab
         pH1lKibNgJttfYEML80N8rRsu5uslXiCkWOu9kDkJwlrCOSGcMAB5e+1rqwj2dEVmVFs
         5HyWZHHv0ga4/sX7ymeGgD8XuTS2JvY9MMTCSGTOEK/I6u08fJqqXOZ5alMyGUH5lF1Q
         AaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764930; x=1776369730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnSb06ncz8f+qqlIqjFbPGdYfom2CbtuJT+XgolU5WA=;
        b=JYU4LMZ72pgqC7E7GePQLk75/pM4yNCV6fDUZMDjIOowvjL/eX53tPoVQK5jOOMte8
         kB58fHJ5dNPOr8DszJvvMvO/pwvuDCz1lzT8rEwUMA5d4j1uYC3/j5F5poTewulEaqyd
         C57NEsUaKHUq7XTDv0wFNzYp4aiAqwL0gHBY6VCwZZRxJY3Owad0JVtuwjaS+zyK9t/I
         YA8hqBASDTAk+ju1mdsBG9+CwOZF1RNgqXXj+QpPa/oVcYjyamde3PUP4JzeF9VkywKB
         N0KUCT1AdZkR/ufk3bt/TT6Wy6HVuP0g+MJ8scYB6r85kU7SJmShHIQ9EnIWsLDrRxiC
         sCaA==
X-Gm-Message-State: AOJu0Yw+P8UDXLGmLY0IjLkNUCsC8cgUzHky/nc++BqV2sFIdF+P5JJI
	6BNmmSXVdvEG0SAQ/EJxN245e3iBGCq3z9qISDussk3gnofUuXP8KSP8KTvTsA==
X-Gm-Gg: AeBDies9HuCxjzcGjF8ax5aK+PY2+KVP5RywV8L+aO6FAL1v02DLjknWjB9n8WzAqxw
	HPcQe3TK/+Xlk1Nb357JuJ5xR5QiL0CSh5FB1CYzskPbsgTJJrjsY8Iv543jzAMML7leWK2VSLe
	Q+FpI9ZWd0iMoRxokb9+F4U6sgXBDZRSr/+Fj9I3qzlRGapsD/iUexD48dWNwCkmUOzCPTBv10Z
	fuy5JKESkttaIr/3I8dLjTEmWa0/hr3NEL1uaJm8JdqyiGUzaXUKXrv7z/OmvibLre7EjmxHlhY
	TDpJdsJa/ArVvr5FNvM/bLbJH5pKDYt6B+SGw1ogdx7R3TEKe/64C3sUfwooCET00Q/613ikPWf
	a9JL/l4OUN0a3E+6EzcUkvP7ige/HIU2n22/carXgJOE88pMWgV5IQoKytqkoDz8L+0XoRcP56T
	aeVnL2a7OVU6GG5YWDEMFoCuAKGfO51Q==
X-Received: by 2002:a05:620a:4551:b0:8cf:e1c9:b29a with SMTP id af79cd13be357-8ddcd8f6c6dmr39733785a.20.1775764930089;
        Thu, 09 Apr 2026 13:02:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.44.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88861sm34354885a.10.2026.04.09.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:09 -0700 (PDT)
Message-ID: <69d805c1.050a0220.bf1ee.d348@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1239214217656651554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, moonafterrain@outlook.com
Subject: RE: Bluetooth: btintel_pcie: fix off-by-one in RX queue bounds check
In-Reply-To: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1239214217656651554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071681

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.48 seconds
CheckAllWarning               PASS      27.94 seconds
CheckSparse                   PASS      26.76 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      558.66 seconds
TestRunner_l2cap-tester       PASS      27.08 seconds
TestRunner_iso-tester         PASS      38.97 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      112.37 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.16 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      10.57 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
TestRunner_6lowpan-tester     FAIL      8.84 seconds
IncrementalBuild              PENDING   0.28 seconds

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
Read Exp Feature - Success                           Failed       0.118 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g53e63a95a86e #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888001dbe220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g53e63a95a86e #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.917 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g53e63a95a86e #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff88800277f140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9f84d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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
Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0

Failed Test Cases
Client Connect - Disable                             Failed       0.157 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/32/checks

---
Regards,
Linux Bluetooth


--===============1239214217656651554==--
