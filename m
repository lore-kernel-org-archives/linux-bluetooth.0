Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE433E4C7B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845955; cv=none; b=tYvyXsCa0hIobd225sEKOUkI/X1oCps9iGbYlsN05e9H7XxS+ypy3q8Hwt5vGy0/DGw9PRfIAKCCg6NWxrK1+H0gF6/HbrtMc02DMQ7Qqx9fwZgjefWW9u8uhlGqga2riaot9SdCX4rOjR6XINrffa0PXbUCC6nEKfuTlTh00R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845955; c=relaxed/simple;
	bh=/tenJjqGDNb6FscvZ0s6TzBkImSM2F7A9iuJUGSqYhA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BIRvXQgdDNqNoxRnCTSqHgM/2vWDwmh7vXwwgdDO06uraB2xhrpIgapfcm+641RUniKgmOWeLdDt7zIc1TSrBaiNqDp3sqAgpoYYaJpqVAKWp9yn9XnRehia6SkEo2b4E1B406P6SPeDIRx2K+L3yZdNqewjKLFye0jHnebnqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDK1PakL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDK1PakL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb20bcff5aso216832685a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775845952; x=1776450752; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KRkTjXAELYOH0ufM1ajkPlezoZ6f+FraeWUtw2shfUc=;
        b=CDK1PakLE2JBNM5UxoQEqn5YB3v+lPlImN6X7Tq/fiED9UxRYc4TzX0sLG8mwGwadv
         c3PSS8/dZ+PafGFv3llxXc7P/uAYVWHF2fhnHHwZyT9ocXWbRN1SCC1xedDkJNGezwW1
         Gj49j4Zyt/WmresdajTkIW3vp5t5XYFWDCnE56JhRfkkIrQIYHORAVtaTcj7q2YchbHN
         PbxsKsM4sDJGIu2Nbdlk9PNf7AoxTDDa6e3sayUp2FBp5xWNT8eJelhPpzxzN88EH06I
         tlAnQupFxF0W5fcsVnbflVn6WWjMx4uk+ygjnVJxbN77cMEyWe1r6FZmkl4w/wbtvGJ7
         X23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845952; x=1776450752;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkTjXAELYOH0ufM1ajkPlezoZ6f+FraeWUtw2shfUc=;
        b=LTgNV2/Sf0NJdgxclilp57QZ3kr3lpYLAbRLXmLAlzyeLOnb6W20DV9LqQgo+GkyB/
         j/pQSGBW64qWDL4LYOLItic5w9TLR2XraTLjGwjk8MmtnNvRgvoyw/TSpgqx7szCIVxq
         NM4jxeW2nm3QRy8LynLvcIluQ561XclBshVu6Fh1KHUe0cTOeUYuaJJco8Ee8Wc39is9
         Sv9bcMFfBKpXLuaRmYN/N/WSL0xz2Rs/Xnhf9tFNxy+QYdTIjostdjT7DhhMgCuLxaTz
         PMxgO5///wdhc6a+E90rnr2Fbvr1MHTDlV3A0F/9JIIgxKY+e2h5/HWK94la91io+jgU
         8BCw==
X-Gm-Message-State: AOJu0YyBoWBNTGhMTtM9ls5eXMZ2w2Y6CA6M+gs66Z2yhy3+oUtbXXSb
	1rc/TZBrjSkG6P6iu+2a9FrSaoxwotzxfVnBj/pyG2PtgjhVyUrBPmLq7KBulA==
X-Gm-Gg: AeBDietb+f1kDck0Ia1xT2Vm95jWi4bx/fushNAzLKVO554TN6HB6qUBUUoFavAcHDZ
	+cRJj4O8Gn54aTfxpCND/D288MppdGNTT1n1Slyry5BYt9GoaqVp5Qif491wHGO03AL4Lxj/Bif
	DRA3cvADAElTHp/uIS9wDS6DMk/jiIiuT8aWvs3IMqKgl+26qU9eNIbQigge3E9SuGOzKqet+Sm
	3DFUBG16t7QYMKqLQIoC9CfHNPbNBniMNt4L8gMQXJax9lZAuKLdu1L6r1mUFRrEe1rPAT0qx7G
	SE4Pfzj48UWRyXjY4v1MODMp8Zk1oFr9wbgHJ103UIVcKJ+pzLJDA7gO+52mIJD025AdSBAR1yi
	L3LO+ePDaPT0gw2RSvccnDjGz+PU4NTyqzQzXD/GnJ6XTX4UJNSRVLaUChpf6iP93t3zjggGnlO
	b3HNY+pUq3Qs1Dg+q58SUbR7fsH6CeCiY=
X-Received: by 2002:a05:620a:19a6:b0:8cd:c011:fcc2 with SMTP id af79cd13be357-8ddd0293d0fmr662147985a.56.1775845952074;
        Fri, 10 Apr 2026 11:32:32 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88a19sm263587385a.7.2026.04.10.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:32:31 -0700 (PDT)
Message-ID: <69d9423f.050a0220.bf20f.d18a@mx.google.com>
Date: Fri, 10 Apr 2026 11:32:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4097868530736607931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnexen@gmail.com
Subject: RE: [v2,net-next] Bluetooth: hci_conn: fix potential UAF in create_big_sync
In-Reply-To: <20260410173451.4797-1-devnexen@gmail.com>
References: <20260410173451.4797-1-devnexen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4097868530736607931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079876

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      29.19 seconds
CheckSparse                   PASS      34.39 seconds
BuildKernel32                 PASS      26.53 seconds
TestRunnerSetup               PASS      578.39 seconds
TestRunner_l2cap-tester       PASS      28.77 seconds
TestRunner_iso-tester         PASS      46.74 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      114.92 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.83 seconds
TestRunner_ioctl-tester       PASS      10.53 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
TestRunner_6lowpan-tester     FAIL      8.83 seconds
IncrementalBuild              PENDING   0.31 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g3db70c75fd3b #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880020cb220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g3db70c75fd3b #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.738 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g3db70c75fd3b #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9a64d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/64

---
Regards,
Linux Bluetooth


--===============4097868530736607931==--
