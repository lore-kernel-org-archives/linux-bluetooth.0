Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B921547C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764936; cv=none; b=WxN4e4W/AfPL/Vmjzpeb+5nOvDGrhKV1GOZy/YypsCuC4JWwVq0xWm2UJeNwBXWZMmwnNbHZlQh+krclMqPirNU7TWZkIzpdNaVOldW/hxT6vRMsw0w3uyIEmO+Q4bqie2oKcaHKHWmlUOkmvCY/7MkCB1forxaVO35QLMZIjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764936; c=relaxed/simple;
	bh=qaFHMHR8KzE6rzzhmv2l79xMrunvwVUmeHQ51Hq14XY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tRcCR1cMoizVosxlCTNcEOj2jI9sh6s5JBEY1UI/mnCHLOPRhYK3H8mJche4mq5duC1t0pn1t+RHLxroWDY/qOmauYi926QwRWREp/WU7yywKygk7N39Bf9kvxKOm5xBt8oo0+T8FlffrQT4Nh/Xt37Zh3JAW225W3LtRmW8ffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd/x3yBP; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd/x3yBP"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67c1b8b1f96so651790eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764933; x=1776369733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7gNsaH+F7Cgb5PnOk840Qvl/mUCMH3ZecbtuDReqmW8=;
        b=Vd/x3yBPhKkzTBek4pZ/h8L6guUDcG6hGKSwAn6QONVbNPZPMozh8Pa1fabOTXw42x
         p6U2SztsoHyhOa8z9HFPJI7Sr36t1wDuZudsOrO7gy9e2AlamTnclTvGrm+9HwPFSD+I
         d0kEhZxYZh4TWAzzYCVQG0Wa6c8+Hj8EO8ys6fUzYXFdGLeaIsGZmhb3yf3yAeV5zw7M
         ioFOTuctVmXQ4ED4FaTT2owWd/6BOP2K/pjmno1uUDeUwHCMbRDy6U8WhNj5PgaBc2et
         8DwMTEZlhhOb9oWO6a5UGO7pfc5LvTRXqki1esGxvCkFj3vqMPmkSRGFQIkoMXV+tiil
         H1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764933; x=1776369733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gNsaH+F7Cgb5PnOk840Qvl/mUCMH3ZecbtuDReqmW8=;
        b=btRNLtkKCDGVG7FsRa/PSXr/vNWnuaNgFxzG/tnc9Y9jNmf4m0hwmYfKfu0elehjTW
         TyLNzcHubZDVvCyjoR7zsKhWNxlhBplLNvPVbVIV2/Uw8k7XbRh9eFuKdy4/banvXapE
         G5UVFsYG4dKA0Gt7Hc3iprl4xM9l5nhi93YdpA9HoDkuXU377V9BkI86wHA8I0Qeoq3V
         MPLgzNhAKRGZMFjYz7D21PMpvDKVylyoRtJ7o3RB6e2jWRz1vHKecX7jiudqqKH1XZsf
         c5vidEt8LNrQWTKoqRv0VvutDeR8NPivJVP8Yo/tzinSKMBGb4oa88r2EyeiNB/8RKgu
         LPEw==
X-Gm-Message-State: AOJu0YyVl/0LfMWVaJ2QeoZW63AZEBSkFBI1HeM8InYqzIA2iRk/tY0G
	PeFa5bb7+tXo+hLEBRk580uszGkub0z8bOyzUTFBjupYkgZva2RfyLHahfe5TUbz
X-Gm-Gg: AeBDieutI2iL97dUCaDByBoVK2fpi4wtg8rbFaLgUiF9+E0nAXmqXNDvpPj+JwUs5Gu
	g7PlX1LQswCb4rqzJVy9q22nsVLV3KPEzQlVELz2g8L+vyDunEWvS0Pn3T/0A4GXkHtT8ho97h+
	Tpj26MTbyUWDffn0RPZP4oIfumMNJyzpfesjd3CQY3tVGF6LHjnBOFL8adZVnhvvTN4gzmMMqrs
	9ck5kCzcbmS2NUdovYlAQco02OG+zmhQgQHom1JapvaAFdlEf0R2nc3oYapNTmIrGpZkVZAckgN
	TSylBRpqITTunCsk+0i1cuCL59J/Ub35nJINiFqCtTEaH597bf+CPCwNDg8t40HhWYiz+PllYVo
	PpiKdjPbM6a2ZRqDckJFOC5OMoVRyNg2K8/YJ1RCrPbj0gTD+6igCBDbc/h3bbiKXam8CEAT98g
	rfvT3+uKMpJKS22uqdmaDUU3MpjEsSnQ==
X-Received: by 2002:a05:6820:6409:b0:68a:72d6:7668 with SMTP id 006d021491bc7-68be87e8eb5mr178009eaf.47.1775764933363;
        Thu, 09 Apr 2026 13:02:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.19.225])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcb2969b3sm301453eaf.13.2026.04.09.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:12 -0700 (PDT)
Message-ID: <69d805c4.050a0220.10e7e8.2d5f@mx.google.com>
Date: Thu, 09 Apr 2026 13:02:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4443362001959916437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
In-Reply-To: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
References: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4443362001959916437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.95 seconds
CheckAllWarning               PASS      29.21 seconds
CheckSparse                   PASS      27.83 seconds
BuildKernel32                 PASS      25.82 seconds
TestRunnerSetup               PASS      574.90 seconds
TestRunner_l2cap-tester       PASS      27.97 seconds
TestRunner_iso-tester         PASS      40.39 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      116.37 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         FAIL      14.32 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
TestRunner_6lowpan-tester     FAIL      8.56 seconds
IncrementalBuild              PENDING   0.36 seconds

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
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gb89f44c2faaf #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002075240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002604220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gb89f44c2faaf #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.854 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gb89f44c2faaf #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e1140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffabe4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/21/checks

---
Regards,
Linux Bluetooth


--===============4443362001959916437==--
