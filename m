Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA393644D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854172; cv=none; b=Ft73VxGVge0KittEEhKsBHDdSFOjIaszJyN7vN6du7XW4UVEa6tUZEW3WXIBX+DugEoZQjRvhMzJWdRJ/1vZq4VYwYjgKgwdmhFQKtQQM5/c/3oB0/CxAerYjU90qJXJt4mqZ+LQIhbdPapRZ1cJogfKIZsvbakCgW/sRrc+uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854172; c=relaxed/simple;
	bh=LPuoHdXXO1W/QyKwIX76GQORPhcSbg8jeJ5PTMGDM/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PXNgTEFGkZNVlGZTxn/WIGawiGZfyjrvFWAwQoiyJvcZDZiHM7w2nnCP7IoNctb+uLprAxKKarnz5QZcv9dfTN4kk0a8SP7APvl+dUhCS7xgP2He6tQpGAWAKPZ+MsLlXzhf7q1nXkuyEQNDa+uccsB+otLvMau+Blq3JpQycrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm4UEXMW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm4UEXMW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d933da14f0so270693685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854169; x=1776458969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+j7LqdUK4iESFloXbpkjQVqr2BvghE/jq4pTGTJadbo=;
        b=cm4UEXMWS18prJdQvUidwu2b4yB9y8nvjxZvDN79wjTBc9gAAOIydZh5r6/uQng+B+
         CaK5S3jV8w2DBylg4Zj7QFDyHnkL6gReOkoE6oav7u3ZdUcr6cjQiWj1oWNvWxnzg2ab
         YPr1J0FPyGv7HYf4MNLu4orjyxroVFuK6fbGVRBd+jnKjHBa5CQp/plIUB5ZJ+sSEZJ/
         bc9RsFOuwwWrW9QU8at3+PMw4b/atHDyuajHrbEw8yk6h9B3wWxaLoIiKw0+S0+xqKF/
         SFv9tz/RUA42R3mqmlgOuwBR17YP+Ckt/71GvmzOFFiH+K6XqMX7+JI/YcZQo/vhIFbG
         w6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854169; x=1776458969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j7LqdUK4iESFloXbpkjQVqr2BvghE/jq4pTGTJadbo=;
        b=HEU/LeE23WXx6XIDS2qgREffpc7rwNCA5cFFJdxL/ejxwuOg4dPxIW10NtJ+RffSVn
         NA1vYoZuz9pkgzJBJt9ExhEztrmV124ShoNqEbQp2OGuONxx54ipE5YjROnd/ofFLsI1
         JANchDCzpeJknY+zxRKrpr4rpkfvVPzCACMvf+bngs6FdGbs8kig+cShWPdkp2WgGDDA
         GJCJjqWpYPoBmUdQrsy6eiycypcRkc8c/hojgkGcGrSlGf8Jz1FrndM3BNTZGn80qi0D
         sD++b1w0HXzQtm1zNXj2JWzv9HXhvDVcZS01QkrIsvYnC3shBmaampcfGy/rhdcItjHC
         YQCQ==
X-Gm-Message-State: AOJu0YzRPrt4sWd+I2zs3k7ANoB56Lb9rlXGhDN+tsC+r2FZz9UvBSwT
	y+a81RxAMQa38ZcQEhAga+6Sl1eUwHJS2DixJpvrcKjg7BsjbAADqAsqN1wiyMJL
X-Gm-Gg: AeBDievH0uoYx0sqbITTI8PdHDQhIfQjMFfWbnQ0GwG7+oM+A4zd362ZekAK/19oyRT
	iA2XZwVS72Cd/iiH9uuVIkjPR1gTbiDYxRO9FYmZ4P9/atzvlBYx7u0IpUoPsfn+xoqYmq6QOXo
	+3VtlcjtTSbfbD6wgzCPfMs3iYmgiDaYAeP8caSdlnIWH8O2gR9EtUE8n1CNbF/GM/r+T5tgr1r
	mptyifhmuTAn7daXEKYH1IxUhyVpk/gKM5d9YyOaRLVU3Z7FdBVeueCGI8nGOYWlIMQ87n2jlWb
	dfCM9DP/c9VHVqsB3Wc2bOM77w9YZMb6wnQ5GHRTTnoy5T7sj1qT5et/bTORJd8ukUBcIBQ4Nx8
	GOO9ahLxM36Mk1a5RTnfAS+BLIyD4lhg2nlBwiDPi1/pUMGhWTahGksoUWnskPNeFX2qGWj24Tt
	0WXv0HQeTQYl9rdhCV5Tg2xa2swnTmzt0=
X-Received: by 2002:a05:620a:2905:b0:8cd:9bf2:60e8 with SMTP id af79cd13be357-8ddd0591fa8mr717483785a.59.1775854169398;
        Fri, 10 Apr 2026 13:49:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.149.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6e661sm316190185a.24.2026.04.10.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:49:29 -0700 (PDT)
Message-ID: <69d96259.050a0220.25e752.4764@mx.google.com>
Date: Fri, 10 Apr 2026 13:49:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6301767995204229967=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_conn: fix potential UAF in create_big_sync
In-Reply-To: <20260410201343.229470-1-luiz.dentz@gmail.com>
References: <20260410201343.229470-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6301767995204229967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079916

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.17 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   PASS      27.44 seconds
BuildKernel32                 PASS      25.68 seconds
TestRunnerSetup               PASS      568.50 seconds
TestRunner_l2cap-tester       PASS      28.60 seconds
TestRunner_iso-tester         PASS      38.29 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      114.64 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.45 seconds
TestRunner_ioctl-tester       PASS      10.41 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      10.61 seconds
TestRunner_userchan-tester    PASS      6.80 seconds
TestRunner_6lowpan-tester     FAIL      8.77 seconds
IncrementalBuild              PENDING   0.25 seconds

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
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9147c3c53c80 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001c66240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002607220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g9147c3c53c80 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.600 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9147c3c53c80 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9064d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/66

---
Regards,
Linux Bluetooth


--===============6301767995204229967==--
