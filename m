Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18712641CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766065; cv=none; b=J5gX006yljLwEv6x+VW4qKLVnvp28/WV23ln+CO9nWs1wAKrIT5uAjnKxVa287IlgCpHfYqySafjoR+lKv/Uu0ltCMisNtConH53LuxCZuwt2b2R9ftUtO5YJTAZFgh5DudHREnI0HMI3h3INehg9O4R1q8c8zJQ8w8ZpwfvUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766065; c=relaxed/simple;
	bh=+qGLftvrHrvNLpCOIY7jyPyyifs8kKqKaZvgKcpiLKE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZFCuFDGQ5kbJo77IFi82r5jW91qyf5btQ/cG/3nXmcwPfwDDZWxjS1NYyqP5srwkxPP9aqed3HnTU0KwG/HoV06YLSTbpmT0aVBqmdMpXlMkObgbHVq3vRZtOiNSXFaf1SU6bzXfUb3Mc9T86V06yCz+nv/CAW3Qtrx7ehIH6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyr5BFKN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyr5BFKN"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2cf1646bd11so2185702eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766062; x=1776370862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHmJWOIxN7dAjUVKJTohro9G0AZ0nmD4IjHeu/pprlM=;
        b=qyr5BFKN1491DqcmxQeXjOwByg2Pv7S8s2sdDcyVXOWt4T5Wu3cYqfwL73VgtLRgf5
         /BaTEkNKpYfFkNtdqXSRkuCbvx7cxtwIGanzGrgQCYJhV9aVS0mE3jC5/CovTyqfJy72
         FfOIDrjGUjX909Z8oc5IGsBVgkSyMN7YkslLBQALUlibtQuMu3s/LWyVffO7svyhuTbX
         u4R0IGeAVJ00o8ODZ8U1VR6/ug5igT1aeHX/BKvFwhptr22G/YwNwPrBCwAaTBvQCBd9
         PwdI/cL1xDHbOwACvOBlVTeXRERi1ZGADVj94YfQUM8+kmBs/KEnVimxPukyQm6/yAEf
         rtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766062; x=1776370862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHmJWOIxN7dAjUVKJTohro9G0AZ0nmD4IjHeu/pprlM=;
        b=WjYVcyDJ+hkgNi9Jw5o1IryDcH48rv7wYKj5JjzV23cOy9alAc5nbeydKIOsSWEP4M
         hR9ReqRO9RxnjFs3v0pcJ98SJi7W8WpWVbYWU75AatwMdVibpwp8R2wIdkWRsZrUL9A3
         v/EpFSzc/HN41SXOGKPolQ7pJ8bNY8/P5bttBp00KNwV6o2QBTM2GYNv/NQqBqaYDTvy
         VRMZfHLq10vxXJID0xarOCvuYSV9BVIQ7IvjIPA3c/VyNy+l/eZ6GYRpZr5gtGtHUCcq
         Z6VKsdo8YK+tP+KZtehQEvf0y8Ia+cLLp959YN2USsaojPR+aQtdw7EiEVbUXPCWn8HI
         784A==
X-Gm-Message-State: AOJu0YyWKKHOT4JiZTO+JjUYP5NDW/7lwsCr9tgOxUjyEgX5rPBi5QHf
	Eb2Rc6wR6LLn3WmxtHn7M/vOM5sXvuNb5NlmMqUtQdqyAV1nDOi+goGRZjug1w==
X-Gm-Gg: AeBDieuAZkKcr4FATEi1RKzk+kblCvESiXNQDRelX82jR43Bvn5DKkz4/q0UQM8v6jK
	yHEmvAL8o+naOQ1ND+V7LG+EKbLAE89dVq2z2ORY8Hh8rIcWxxqKc8DOjgt9ASNNoFL9MC0MOy7
	w7kky5pcXm14NXM88858QIeKTD46DSSlLmArKE/JPQuRbdT/GZvCZbAPAgOYGVqnvdJ3AVxIv/0
	rL6O1DcLxce8C2SKLP9uldUpPW9PyHRvcWlVepgOtShRR4CnDlI4Knz1uvgivO4Bgsw7ThXAkfc
	Ki76A718X83DyiN9h+C0Q/rmDRyKr/S3CHmkOP0gGnY4znKEmAi4QgNCSKGL2IrTL8cN2PJuDoF
	Jy11Fr0w73tGvtMKgt//DCmgWEBl2KK7hir/CK8wjuRLCgLSh0bmiI0Q7WGYj78qQ+AZfF7Xaad
	bMI/ZCVx1/ej0T/BZWOG8B1ewgzcBzNGg=
X-Received: by 2002:a05:7301:434c:b0:2c1:6676:5ebd with SMTP id 5a478bee46e88-2d587e7a9e8mr304827eec.10.1775766062376;
        Thu, 09 Apr 2026 13:21:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.228.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm1403120eec.10.2026.04.09.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:01 -0700 (PDT)
Message-ID: <69d80a2d.050a0220.32b2c.aff6@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2934942237199164687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
In-Reply-To: <20260407065110.3037135-1-chris.lu@mediatek.com>
References: <20260407065110.3037135-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2934942237199164687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077969

---Test result---

Test Summary:
CheckPatch                    PENDING   0.72 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.06 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      25.73 seconds
TestRunnerSetup               PASS      571.24 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      37.87 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      112.63 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.53 seconds
TestRunner_ioctl-tester       PASS      14.50 seconds
TestRunner_mesh-tester        FAIL      14.95 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
TestRunner_6lowpan-tester     FAIL      8.81 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga3241c8666a1 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002195240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002601220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ga3241c8666a1 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.869 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga3241c8666a1 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002492940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb6a4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/48/checks

---
Regards,
Linux Bluetooth


--===============2934942237199164687==--
