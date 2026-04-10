Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926538AC7E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819305; cv=none; b=h+vRKKwGSSqgJFHoqMC/iXdQRL/sGq5FLB0h85JcHqIC8ySqcK/FsR59CYTnD2tzB2JwuvaCFaVXyCT6OVnvxm3YyiW6qvgL1IaPzo4IoLiFkwvMs5vrhf7DSUNHU6dnle7uoHSQU23u76YqcOtMD083qV4Zauz7VuDuTfWS9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819305; c=relaxed/simple;
	bh=yWyBy54TcMciqEXdLatGYglbKz5ERdv+Cus8e8JvaGA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JhIeB/rpIVjORHN5s+rSUKf4pf1pcl2WfdX29NI9vJ8qmIviVwlqtGtRLkZv2+068I6nfOoQOKeP3lAHGfNrZx/xuQQvD9FIgzh6DMW97Ak5i276Dui6ztUZMIZxDY3cHDT2YQbRaxLhP+aqCslKBFMX5WN1wF6R+1lx/GjERuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgeQCEgj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgeQCEgj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d4694105e5so141124285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775819302; x=1776424102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5+CsOy6GxgsmBI3V88oI24KfGKY7khQ7WLRtF9wnuqk=;
        b=bgeQCEgjID8Jxxr/GDvBvH6v623BTYzKl9ErqThWUjrZ0e+kTPOzvtuq8zrhasvFtN
         CEynv4evRvgXfv5cvDbfhdCrsxJpNygKWQX/kOBdaXpCj45LV6pyY1KUUox1N7h0hkM7
         7h3k2Tuqqj6Z1ZgK/Lerx2m6aLcs2ksuVupOicMqq/erHH9gHUEHydfbiFn96Kj624Gc
         TZEIynz/h0HtKuFpQ0jpVPW8IG17/KBK5ZUiCDTIyWZhkxPXrC0HRWt2YzEaRqh9sYoA
         b6JEYbgMLZIHI50u0wiwctpGhwMXaf/o6cmJmlMjVGwpATs+g/hHrf6RieNzLHO/u1SC
         GQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775819302; x=1776424102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+CsOy6GxgsmBI3V88oI24KfGKY7khQ7WLRtF9wnuqk=;
        b=qh/c6wQt6tzK7NeTt4pgEYm1pK2U1v0Dhh55bZzqhhjEJjGHt0kMD7H+YiVN81Gxr3
         hxWqgl26+metwDfbEDxNM4MsQo3p/cVhMp8MI1kNs3JT8rNhK+wCng+Icz7+SAHNIRzZ
         RJNU1i3CXwc9wDIiPR9yDwDJ+3XWasVMv1E27KoLrW8kF6QzBfze69CLCcWdeCVeAjuE
         VKe5yIcRJXAq0+G7DthTZmMUVvPW32EDcGGbNXLOA+ZgtDF4mtaRP2Vs00+2NCi4f6QO
         Rs/9T5yrhKJaL5vBgkIjwdTVqBN1MYG0fSTTe33ukOTcCDETMLsUofDKF5BP6QR896U0
         972w==
X-Gm-Message-State: AOJu0YxFH/k4OGqgB2KVVauWOV3Y7Z3Ep99CM9D7FCFfN+rfbKC7TZeb
	zUmZ3suqjdfS6T8abJCQwlAfj5C0LdvsFQzxn6hvdol4FLNPPWD+sKLtXj63BWam
X-Gm-Gg: AeBDietjO81+baUjduyiemoO4irij12bM3Sd3YghC13WNhoGL5fnnh3B0t7RsQRWnOq
	6jinMgi6TbZgh4+5e1FBtAiU8qblpxNgt7r+mhOaQG1o5jME8+pDtIxu2U0xbYFn82YD4Azn7Gn
	slTifHsQrGMkLKo2NeLEgYZKrn19SLsOrKg+0AIZ3NzkzAnT3uBbAeXvtYoFs6167vLaCbHahDV
	NgCF+08xo/IAc98KoHmgFmX9XsHJrQ+uYnVHt8s4sOs9NrT9nGbQvL0alFUcHiiP+LLuOgWypwx
	RKeNKN4rNuB8r4vSBucoiRBUPAiN/ompV8ckNZRfJ3ZwDz+lQL0NfkprlSsIOgEHWcGp8ApoeNz
	6tHDU9wDfT873wi1VlPeynmUNhUSLPSkxVWMjNENYGd9/QcqyXzBNoJP5rJmn8CWdqAdK63BXnl
	FJhFljFFXPSUI1UrmLi2J9pMYd/zfIfIgj9KbSrcrs7A==
X-Received: by 2002:a05:6214:328c:b0:89c:4812:cc2 with SMTP id 6a1803df08f44-8ac860fe5a8mr39996146d6.15.1775819302446;
        Fri, 10 Apr 2026 04:08:22 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.251.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm20866636d6.22.2026.04.10.04.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 04:08:22 -0700 (PDT)
Message-ID: <69d8da26.0c0a0220.8a82a.35b5@mx.google.com>
Date: Fri, 10 Apr 2026 04:08:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1057367153285473877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: Bluetooth: hci_event: reject incoming conn request when MASTER conn exists
In-Reply-To: <20260410104222.537901-1-suunj1331@gmail.com>
References: <20260410104222.537901-1-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1057367153285473877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.00 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      25.98 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      526.05 seconds
TestRunner_l2cap-tester       PASS      27.68 seconds
TestRunner_iso-tester         PASS      38.71 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        FAIL      115.26 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         FAIL      14.41 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.68 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
TestRunner_6lowpan-tester     FAIL      8.70 seconds
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
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc12cd1423cb0 #1 Not tainted
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gc12cd1423cb0 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.872 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc12cd1423cb0 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002482940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9004d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/62

---
Regards,
Linux Bluetooth


--===============1057367153285473877==--
