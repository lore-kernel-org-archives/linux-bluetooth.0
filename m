Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DBF9E8
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194306; cv=none; b=DjsJ6ctVjFd628Ty2FLvomrrh/xacfilUK1M9nM+C2B6NPxkNsK4BXNXRSsUT9NUxLg6890Gab1P3e1qNyVINw6hs1VyWVliFJMSev3q6a0MhlLyX/0TrS4y5GEq+yQqwSTdvinyK280qulvN9SYn90kL2j+I7sM1jTg6Fm8JFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194306; c=relaxed/simple;
	bh=i1qk1jTVjKMoT4TvoKviWnQCOuc+58HCtsPYK7us/5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FpnK6ejs9TnlHGmrruQz00LhUTLQetk+XvIYMMKta0U9KmN7UXqgpxe3i4RlQMrsewhBrdVsHQcuFLlWKq3PBfIm8v2/o4JVomUEgRIRWmGRkhy5oQou0fgFJGDjBpvpzcC1LzNOnNABhnyjNKZwnIw3v7nxbnyGOBBR3smdJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ1xIKPR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ1xIKPR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6ab4476eso61482361cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194304; x=1776799104; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s8BPjWf/CxzQLNN7KeX4/zgZfvd1hI6uS5heHs+2yPI=;
        b=eQ1xIKPRivzqOczqEJBXKyetXA0YwJ3KAqcBezg1nP02mmbGlzxex/4Rr4WvOlnxDA
         n7HejtEiVvwgmxnl5dD3tm0NCtNUa/96XZHaqU+MsqeuPfEUNAib7VAMbOYeWrwO1bNj
         2qjsR6Kb19WkqM637Ledo4Lnk27fDFG4QJsIPyEcmQv6wMFirS8AU8Mzsql8R88IopE8
         pR3GZr86c7oWUIWlM3sqVyOxkNUBXM4YwZLAgfk+Cm38mbPosQG6NzxjAWUcXh0mJ7Yt
         RO7xOFjNZ72KAouVH/4uzdiVSXykpC5o9tkLeGfT3+SmG60fOi8GqvKPfkOO0pomw/5Q
         +liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194304; x=1776799104;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8BPjWf/CxzQLNN7KeX4/zgZfvd1hI6uS5heHs+2yPI=;
        b=T7EbeeYLBaS7uCDEymC3KlMdnhAFN2dhiJuN2j06SNHVita2xAGSMpP2AwfMHyoy01
         GE53reETFrDGJaqBrdwvuv0DOvEwm/2E+lN3Adw6NEnGdNAi2LRbgu9fveC2DiBNWTng
         0yNEeXkA8MPDg7zwwVGdWgW8o6ZBkhVCBobYBxgIn95KTv59vtDhTKR0JrC+hiZ8eGZD
         2X/Eibpr9NjqHKOvFm8WUo53imPweBWParGsvjS+YvtFoO5nuTB7XEt+/CdkLNqrhyCK
         lPCjYMhnRkUFGq1ZGFb+ksyeRqCWw2Wl7anyjEvNld1axMXevajK1BOkmawZh+0uDVkM
         3GMA==
X-Gm-Message-State: AOJu0YyxUs+X8H4pbZSYKv1bvkjpogHL9HU3B5tY3zTbBy/0T9uMYX7x
	5VWoDIKKBkaUpqQ2aoiWfdvBPEGCZgNaBeGJ2l1+tqiBHGn8UntIUrYxuK/eww==
X-Gm-Gg: AeBDiesqspavKesDnXEkgpKWjX5mhQWNxJek9XJrKUefWJhc767vX16TPs1b22YvDfN
	x6Awd2Z6WzgHO/80Iqo7K+iOdXVXbUqn+Mi+wrY9obje8kyqYGhpOurH+CpdSby+gLwyiIrisQs
	8m/aOKwHM17Z/7Ft+7TsK7kDGlKLzNjC+Lqw4M1h+dVBhrEmkc0xzCVz1p1JE0mKdWAVX4PYglp
	IgIPkRhJy8FfaTN63xnjV+qSGIUhrk2tQQXmQmoDGwOes/elm1WKk0bbPY6emL73M5NZAl+otZO
	HcqYzoPQMSKAQycVhWNDxLqBI7n3Tmmle5LmN5NGWBzzwEX3K3mawe+OkOzN0vlrp6vFcTCxEMS
	e8l53pkQmBAcaJDI0KUkWPSgRtmOYKQ4rC4etugr9Tbjm8toyAeGyUDSMnSwahA2qZYOxw8sYgo
	f3XjR0djFehVgo3zBYsp96rnZP/CJmGzOaJOuulOAycA==
X-Received: by 2002:a05:622a:15c5:b0:50b:48de:5448 with SMTP id d75a77b69052e-50dd5ad0a9amr277375901cf.6.1776194303347;
        Tue, 14 Apr 2026 12:18:23 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.142.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b49dsm121925691cf.6.2026.04.14.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:18:23 -0700 (PDT)
Message-ID: <69de92ff.c80a0220.10988c.d4b1@mx.google.com>
Date: Tue, 14 Apr 2026 12:18:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7833922036402956150=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v4] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
In-Reply-To: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
References: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7833922036402956150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081253

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       FAIL      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.88 seconds
CheckAllWarning               PASS      29.13 seconds
CheckSparse                   PASS      27.61 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      579.82 seconds
TestRunner_l2cap-tester       PASS      29.45 seconds
TestRunner_iso-tester         PASS      44.08 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        FAIL      120.96 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         FAIL      14.47 seconds
TestRunner_ioctl-tester       PASS      10.66 seconds
TestRunner_mesh-tester        FAIL      12.21 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      6.89 seconds
TestRunner_6lowpan-tester     FAIL      8.80 seconds
IncrementalBuild              FAIL      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v4] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion"
47: B2 Line has trailing whitespace: " "
54: B2 Line has trailing whitespace: " "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.120 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g40cbfa4250a5 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abd240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f7220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g40cbfa4250a5 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.631 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g40cbfa4250a5 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff88800275c940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffaac4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6a07/0x88a0
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
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:
Failed to reset to base commit


https://github.com/bluez/bluetooth-next/pull/83

---
Regards,
Linux Bluetooth


--===============7833922036402956150==--
