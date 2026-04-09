Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B0284880
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766233; cv=none; b=AajzIrddzPIG8n/9xv1AjYX/nQiTfBOukHyhlyZ9qsw5p6FyXazLfYgu1KiCo2JkhqCR7GOxh8p5PRw44GP8+arqCUA10wWuiXV1rutdjHAqCmSqfbEmuk4xCnK92tI6vkk0lptJTpnEdMjpYxB19+vuT3oMAfBYilU+PS9dquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766233; c=relaxed/simple;
	bh=GOqNYBjcB61XzH2UxMZ//bJ2qgzUL/0FjDWIzZcKgXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sTlGxcUn6d33xt3iK1H7R/FO64EipeonoW+Flcij18pKoOOV09Ngj5EMT0uywVA5Kn7b5WrMq8GgUwoaNFpqKpRjF4rWTj4SHD81kds5KtyKQmLcYIJC5aBYjp5yFpGvyQ7jsjSHXVciLasxz0pHYSGUK5kL//NoY9NiQhIKOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLxQNsI5; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLxQNsI5"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d68bcf50fdso143169285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766231; x=1776371031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=16hR01tTRZGk7C8VrFVBoMae4y3GvMVTKO2LhwHH84g=;
        b=FLxQNsI55bMubImBhiaRxWOz9bigUBjpLB8hORctaX9wEBEc73aLeAIXrLVGr2qkdu
         ucswWMUUl2Wc+haDx7HX176j3Xwa10HQjUxcAoLHt9D19Fe2WHduT89yM99clWMgf2jm
         RnNV8uj3VyEk2ZpVXH8ZjRxkKgSNTldQ0hL2r7BRV95wSTQIfB7svOJpxM3eqRKp3MYl
         lkVFV6mxYCKW72roT128DLTArZiHauMC5RXjOR4mxxLVektucmxQv41e0pjI9bskV2sx
         fHoMYmI8hXjP+OYyPCZxzRbWTNbFavnF64KVS/QPrFWeQVjN/Iz/OIGLlEWXqgrgV65l
         DQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766231; x=1776371031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16hR01tTRZGk7C8VrFVBoMae4y3GvMVTKO2LhwHH84g=;
        b=CAnnum3DYmztOlHvGPC65X7cmBPO5toe1pgr1gsJt1x8/bCnFXoWBFwcecJjQU5avx
         LX0CYlyPkNKycmrpm8pK6t4SIIUueJIyHowzlOXrW4mjKdc8VFEWEvb2h/VRpp0hHYH9
         z3HQP0wOno6NR0wJ8qaPu0OiZO7Re3QB48ypg5zV7NFnNYxVjhGqEHX5aJZDcht+RwSA
         /JWNQI9nVor10LaWwIne+TJVWAIRvF7nTYy/1CNG+N+vgBljAj4XWJx4Bqe8ShXqlwNH
         hXDIrz1j8JBnnRvAsTCe6CusQVsqXXS3HJRf3S85gkswSpU5gcDlXdehrFmHAJ9sa7uq
         qRXQ==
X-Gm-Message-State: AOJu0YyR41hCNvLodzOxWev+pLrgtpOqMYZjSTQuthWIYvO8qJyAY4Jg
	HRSGMJ5nIw7lImBVLk+JR8MPUNyLbljeJNp3pmODijQQR9IwAbjiu1b5d8dQFg==
X-Gm-Gg: AeBDiesbtr/Ti2anBeD2FF56twg3aU2hYKYXqzw8mQymL39z6MEGYmX+i/9RedOZWmd
	c3SSpQV6mKSc1Z38wfOYNIMOA9simi/HZxHjIGLWb9XQNWMjMiEd+iYM7PMDQ7RVPMdNxM3tprp
	8KswSEZGHQ2RHrgr5ZY2bgVvm9MCqrIj1Ko8PMSYy0EESdQL2ER1dTBQDNR2LKN0A/azbJqo0xZ
	jSNDqSPhsbccAlDrnMKyaNl2qk74y7hQuA8zGjpITJAnK5Avi49uXroJPZXxNqz7vEYIpa6yAyp
	zUqqFG6Fb/kJd0GVpzR4eBnMOF4LjbTwoD+CGAn9gQ/sPyPityP5zYANezUUQiwHmXIBIxQD0aX
	DZuKHMWdfVjfPPaYnHrHtCm+q1kue0c7G5Xw2CL3ONoJScvCDvp9SINtGwN3dIeGnBm/+zdraw2
	IUz237epl+PSMV095jRgar61JycZgeHA==
X-Received: by 2002:a05:620a:1725:b0:8cf:c141:435c with SMTP id af79cd13be357-8ddd0696f38mr44273885a.61.1775766230531;
        Thu, 09 Apr 2026 13:23:50 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9934b79sm38242085a.46.2026.04.09.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:23:50 -0700 (PDT)
Message-ID: <69d80ad6.050a0220.15a509.605e@mx.google.com>
Date: Thu, 09 Apr 2026 13:23:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4368531318423140849=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, metze@samba.org
Subject: RE: uaccess/sockptr: copy_struct_ fixes and more helpers
In-Reply-To: <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
References: <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4368531318423140849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078270

---Test result---

Test Summary:
CheckPatch                    PENDING   0.97 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 FAIL      1.00 seconds
BuildKernel                   PASS      26.30 seconds
CheckAllWarning               PASS      28.71 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      25.68 seconds
TestRunnerSetup               PASS      567.74 seconds
TestRunner_l2cap-tester       PASS      27.95 seconds
TestRunner_iso-tester         PASS      41.46 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      112.93 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.32 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.61 seconds
TestRunner_smp-tester         PASS      8.97 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
TestRunner_6lowpan-tester     FAIL      8.69 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
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
7.0.0-rc2-ga0d9588efccb #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880021b5240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fc220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ga0d9588efccb #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.786 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga0d9588efccb #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff97e4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/51/checks

---
Regards,
Linux Bluetooth


--===============4368531318423140849==--
