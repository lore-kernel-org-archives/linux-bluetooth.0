Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8C313522
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291374; cv=none; b=DKAXPtY4K91c+PeaPDNiuY9K+SXpPD4myOM5G6SQrLkwKcJM9Sz7IgSuGQSkmKlgDdF6IyOA0gaZRTYFTix/X+Mbla1Gdwihx8eWgcmqGeCegf/ePfs2ELJ6qL9HaG6t6aXKeoEL1SQJsB6ObqebgxbIUI5lGtLtNF4c7z//8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291374; c=relaxed/simple;
	bh=mtQsxxJNTa46Iy+5HnBRsAv9PCkM8mwu+hai0Iz0nZc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YKNN31LcY8kgw4SwFBCODxnLBBVSyADPbQRqtsrFRQJRv0wRGZYccmh12sP+rGC/lb18cIqpEqrHZLG4dOxXW3goHS8SJvIF8NJ8iW+hdcH3Ra1g2Z6x29Xpr5P6L+IrAcswe5CdIvBEk5oCgkcGdouqoRw9R/u/ZpRbTFVo+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIV7XP9M; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIV7XP9M"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2de831d2b20so2361805eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291372; x=1776896172; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oRRGAkLLXYKwh95dKr7fpeSP7G4+ycefzUkC8Drry1E=;
        b=EIV7XP9MeM++XKJXxvdCRTvW5viv5A4xsxOzMrS4NsYeqDulz99fCtc3jrN/1BaJQ4
         6m2TRFqBiblBy5+ATym7Z4t5tI5T0Oe/jw2tgnIsZfBB2mPsYh953BcG78s0lLcqRqAm
         UQMB9YiBQ+J5wV4bYTUBs6yL5BR8KE04+ttTAecFqJEUQAx3ihLsV8Ok2CLX4o8WhY2y
         WgK1kKKUnM1DSr6lUIBstP2byepC8PMNKhcAJsEJ0mjkkja8Dg0slgtHgBluxhQ0YXVB
         J2tanP8G9Hu3xNSNkclIv4D6hTVtMmA/X/UCFqrRhNF1RiFv9SXhKpRN4nGW1CbZFgx5
         NKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291372; x=1776896172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRRGAkLLXYKwh95dKr7fpeSP7G4+ycefzUkC8Drry1E=;
        b=Rz/6nqvjNZ74VeSWVgm2epm8bvIATFhrQlXgGOEnVmfenjpEbseD4PbRK9/8nv4+Vy
         onU2MSQ2o3WM5O2wAZNngL4x3n2qRIsONZ4LjQ1R8KYZZCMvYZy+S1fqi26H3jUgUI4j
         9Q30wedW/5Bokguq7QKE+KP11LjUdUh1NBCeWosTL3SPdZatNUNKIToLoNbAvMavlqPo
         XCI54wgXNvYS1YWZ4A/OWKsLG0kU1ZD/jy+r3HnpeudwCamNSz1TX6KY0VyP22+PLJK2
         GCFWH4BFO8T2b+UeuqD9gKRerz8a/H1IwekBCHW9/1EYXLJrID61xzN6GpaY/hYfY9au
         eV9w==
X-Gm-Message-State: AOJu0YxwJYaMHZvDOR8Z6D6N4YnvzsmXJeXA3oCdwKRxZ5GtKAReFIHC
	j/DaEOkk5f9sO0XGIrZEokyukw75OJ0scegBVrEjFFfYprpmdbx+kB7AMrIoow==
X-Gm-Gg: AeBDievyVyokiRyQF/hnhnFqzNL3QrBY7YbHAsloYwRO8hmKIffHCXBqCEOHdE9SIFW
	4zAjybjxRCsRBL1X4ciXPiXIW3CfCJRfFwV/mTU0/Mtz/Q8mmzDluaTNBoUPp/ruZ9w08A38+bU
	SJLg3kwmYHmOy1PInuPXiMIuGg2YPbdlBgweOXYEWjK5R7eM9Wfz5ZH21qjO/e6daP8zFzfqxuh
	yqBIjJQ1aD+qZX+yAqKdXpqlKlR9nyYLu0MiMI6Vauy8+hA4L+qlKqrizaZTH5Sudt1g4Wu5pup
	19I7IM60TMjbyKAyXDuUA69r/+rThfTphRBwWYu3MkCpZ1SQKkRV2nHDZJe+Fs8ZrY8btDGJWZx
	15aPAtfGSPLqdLyyIZJ89I1WqTvBQKZi4H/Pmy8QcCT3jYACzjh9tm61+AzcgUrprGXbOKwnLD9
	/l1Zm3ebCC5rF9CXzBG6Gm/GuTwUXuQctY+u4O5Co=
X-Received: by 2002:a05:7301:6706:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2d5881ad264mr14579402eec.14.1776291371685;
        Wed, 15 Apr 2026 15:16:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.140.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10ad3dsm4839040eec.3.2026.04.15.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:16:11 -0700 (PDT)
Message-ID: <69e00e2b.050a0220.13c00e.7af7@mx.google.com>
Date: Wed, 15 Apr 2026 15:16:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5620584743321148937=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2,RESEND] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
In-Reply-To: <20260415205205.2366630-1-oss@fourdim.xyz>
References: <20260415205205.2366630-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5620584743321148937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081743

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.81 seconds
CheckAllWarning               PASS      28.74 seconds
CheckSparse                   PASS      27.01 seconds
BuildKernel32                 PASS      25.16 seconds
TestRunnerSetup               PASS      564.41 seconds
TestRunner_l2cap-tester       FAIL      27.53 seconds
TestRunner_iso-tester         PASS      39.39 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      111.97 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         FAIL      13.98 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      12.13 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
TestRunner_6lowpan-tester     FAIL      8.32 seconds
IncrementalBuild              PASS      23.99 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.116 seconds
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
7.0.0-rc2-ga84bb558bdec #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002042240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002090c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ga84bb558bdec #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.746 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga84bb558bdec #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff88800275c140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffad24d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/90

---
Regards,
Linux Bluetooth


--===============5620584743321148937==--
