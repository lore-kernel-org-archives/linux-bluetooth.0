Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954C27979A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764918; cv=none; b=bIQGhJL+cvIrVP0KZk14ODZjB5LpD/Vgbdhd0XVfkvw1eCiRXjzCDxJDKfMOOPrPG12qx7ESn8wJBsHmC3K4OKMic4UxTVEPHl5a9znXQWasX/qWNgH1j8oaxsCEvB2eeZ+R9QXlqQvnn4GldS0a3XnnoEPVqmh75/6ABxbydtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764918; c=relaxed/simple;
	bh=JO+FgSVvPhab6IrTpdsyFbK/mS/TrHubs6zeLs6WlsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pg0w7xpA1fcisvjhtNR3zOf9fioqNjR4noa4yzJhyRjQQRXuCIY8KrbGNxhANsPm5sF93SeZUWD3lKuJzbjOAOIeb6Saoc2ty+9wBUoed972sZl/BEqyMAhEJ1QvY/uiRZKwQuPK6PExym0GwZ4OUEJ5gF7LzGjOK9pgDcySIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4MXEwKh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4MXEwKh"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbec19732eso1231831a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764916; x=1776369716; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Db2DbGPJBxlqAW8qZVYflkQNFqetzosxzzAh6JRijpY=;
        b=L4MXEwKhr9oA7Js9BlRQ4bRdFzLS4r2oBKPufR1eQNw7mmHwEHSrXqvi0QTnlwd+qL
         EUc7anTs/dy2ldLLxOpCPHhmAsdrzHFb91kgNwwdSz92MXRNnzngqjM2uq5uS0/ImLZu
         OIKYKC77InXP0kt9SEt+EANkHqJTmm30d7q93A4HN7bJBUsbzWQSNo+igogCzTJq1713
         M/XPt76tH3fuHFuorwWQmfxJhuL9qyjw44IIpf7AZtFUzTsKcpc89Hv1nxnyGqdMmDug
         RPhRPWs2i+gf+8qihz3IxG1joesZegWOMmjgO0bkrvXogHbjHrPv+ALcFffAwXdFJqz3
         vDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764916; x=1776369716;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db2DbGPJBxlqAW8qZVYflkQNFqetzosxzzAh6JRijpY=;
        b=OLNlrVmzAA2dC1wkfD30oVUPHfUE+r7+5QYOqNVWpG/43SAah78lUCsPT9mhQ8cKcH
         JSrm2CNkmHxRfQMttEXOCJQ8nnfjO/X/TGlsO63O1x0qe2mFSWiRJTP21ZunYjfGZaMD
         X/A6oQw/Wv5V7O0IHHAXOXIo48X0sDeG+EoX7gs9BFQpAujr1Sw2cayU7zqkswwpSwwd
         TCp6hXcNcBty8Ouwn0eOmJnOKSZ5xCRCIf8aqiZ3UzbkgxbV3rsNg/nQNEd/AlSiAwUb
         Pnd5eMnZ2aXmeT3z7X9mFnNMXABhVy4Tx83q395H8gOvIUhmBffMWt09aUYJ1wZjyDEr
         LcVw==
X-Gm-Message-State: AOJu0YzzgLL/TJouhCInnvUPIvvd/DUVoktS61G0w74aKH4haml0FAvA
	7b8mcgpL7SnsTO7u9NAYo8/2L28V7BXSNqsggBOei3aEUHGAbi8ogl+E5FqDRA==
X-Gm-Gg: AeBDiety/X86ZZDEuknd6bM2kZyP2FXOXs1E0AbM8mnuREa7tEbbNbvOtpzqWGmGmut
	k5uIudd1bD0zyC5TSEUgautScLe2Ry9CM20EN7vZf9/ygmYSJDxHFYeE2GLQInxdUdogYJmXsWW
	E+xdoDk4ADTcUXOZXg+FC5RtZXFFYWWcGweD9pEv7gmG6o4VjBvCNrpg33F0+lComO0YDHbNmC2
	RtbWnPOUkXT5dcrDZPkLIGh9F4vh4Ij6qeKOF8TASBC1pCZNYu7lJhOPHH42nfsDcmO16z7x5Wd
	fpXTc+725cJqJ11djGc2BB9kiyg/RtYrauveSSP8blal5u5Z1C96ngC/O39Ph+JaF7xXJafmWBK
	XOalZUkWSoT0ZN+fv3P+Xof2G+rFulFAI+Jwq9q7RLY451cZfoKzcKHuYkU6qE4AOPaedY7LgGL
	4ZeYZlXepUl0mmIcBGShu08FPNyYGbEw==
X-Received: by 2002:a05:6808:c2bf:b0:467:2be8:6687 with SMTP id 5614622812f47-4789f9ff599mr394655b6e.32.1775764915350;
        Thu, 09 Apr 2026 13:01:55 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cc9b8esm4064966d6.41.2026.04.09.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:01:54 -0700 (PDT)
Message-ID: <69d805b2.050a0220.94ce2.b67d@mx.google.com>
Date: Thu, 09 Apr 2026 13:01:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4765691401751377452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, abysamross@gmail.com
Subject: RE: [v1] Bluetooth: hci_release_dev: disable delayed devcoredump work
In-Reply-To: <20260322210849.68743-1-abysamross@gmail.com>
References: <20260322210849.68743-1-abysamross@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4765691401751377452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070558

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.33 seconds
CheckAllWarning               PASS      27.93 seconds
CheckSparse                   PASS      27.17 seconds
BuildKernel32                 PASS      25.03 seconds
TestRunnerSetup               PASS      530.15 seconds
TestRunner_l2cap-tester       PASS      27.92 seconds
TestRunner_iso-tester         PASS      39.73 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      111.81 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      12.58 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
TestRunner_6lowpan-tester     FAIL      8.77 seconds
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
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g58df065202ea #1 Not tainted
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g58df065202ea #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.679 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g58df065202ea #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff88800275c140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb2e4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/27/checks

---
Regards,
Linux Bluetooth


--===============4765691401751377452==--
