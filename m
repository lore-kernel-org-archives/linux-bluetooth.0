Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5826B2AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806385; cv=none; b=IAygUv4L6oB2iSGnanYI5551lrIrand1zfzhGHzppNIQrCS6+KRdpr9L5Du+ITJCwbtYI7eMiP+2EQ31+lNU7Avh/ygJfjiy7bQSBbtaZXhn9voJ/kd/wY27QjtgW92vUbiXyhdKOjXnNXp18EWnDdr2/wn9BIUzOGpdVw767Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806385; c=relaxed/simple;
	bh=7O3kO9ICsQwn7jkFYThrqWqpG/H9C6iON/r6gdzNVgE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l6eKoSG49LHViCVzTAz6QBhoOzhTIvzWrz5hCrsnZdi3+3X/bFDbdaQgX0GGuhjSkwbfH1O0wyh+ILYwzqjibb3dXdgCWnFsTSzJPuVhHMUzasWVE9/Zfih3tSv95O5tMH7b3fNHlTKLw6FYDKgvNYeIBoJQBbrpPPC/3gc+uMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5/WHG7v; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/WHG7v"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a154cc6a48so18866236d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806383; x=1776411183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LWdWm4o67e/MehYdz0+ycMDNBGtah41l24ae2C3vHcA=;
        b=E5/WHG7vEC3CWLYPndaNTNCN3xLnNytW3cPHgBLdH1hGj6W5e1aAhAoI9uL9ZBL+x5
         O3fBvJqeE6E59W3AJAP51dtPKMDYd9vj3Si1ac2Q2BsAceDMRcEo+rUFuAnYmBHf9a1N
         Ch2Dz8b2udArsYt2hapIj13KCwNStdXUGgO3Bb6hLSkQdozjFRQ/looJQwnQ+PXKEIQK
         Xz1+Lzghi5WOCDdYusZgTDa9vLnXvzdWFTbZvvIjjuFj76yZw69f4GKxu6LyzsTo4LH6
         502cZl4tL7Nu7Diqr7kw2pzhIBDEKB1Mv8psvp0A9HtyJ0W6qa126Khl7JGT5kYSaKc5
         zzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806383; x=1776411183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWdWm4o67e/MehYdz0+ycMDNBGtah41l24ae2C3vHcA=;
        b=g4qAEUCXQ1LBKbxeHCZe5WGCjKMXU2oqh+VG4jJi8P63e14izzdxaldQdN75hfNyrf
         MfN/M7Vhp6439hoxAxe8B/aim6WhxRRBTrXdPGuDRNvHaf4lPZdbeNWnPPpNFdkdODxy
         y0ZFPXxhD4R0EZyb5j3sYy6wGFDGszqinHGIkQoxML/KIyo8DBtS3vZ66xO2Wlhfg+US
         QJnynj3bqorprP9LRV/louNx6f+sf9uusXUqEJ5dvJkEnjd+873NAFukvwn5bxekVgvC
         TOBkHJvZOiIi3ZobCnuZ25p2N+mCbMhYWZsPCDy/YjX5TnIX/T9T0Xk9znNxnnuUj+l7
         L6Yw==
X-Gm-Message-State: AOJu0YyRKwrgAD8ZuPc8nP5yRw9f7rB8GaGeAsQswMtIHimqRuTLJSsW
	LgNJ7+yktGFJFlyQCkjFAXhOF4T/WGPwsOZunNlmKcRq30Ev8L551LKK4kdyOQ==
X-Gm-Gg: AeBDies28hDNouXcRJwAJ0zXm3By4c91NbfaP/wsnwqLsFJvITWIyY+Men/WrXb8IiD
	cxYxw36L0wvDLCGtExX1rAAGY3+6xTNAAuEWfhQTC8b0lInYOX/KsaZZn/m50opPWQ6TMyLIvsc
	kjIhckgbygcO4v3cSjPJKWPDb0Eyrdx7ASgeewhCmihIYyIJwG6rCGkVeVYL1h2otB/pcj7Uc6W
	GK1bpJZOTLoDEtoipMCOE3FMXRE1tjHesnqw+JpnSQ3mO8jFd5Wa8obEtb6N6rnDtzlrIKT1Fpf
	zqrBUnCEXnWt8TQPU9hqpNSX2RZye7I66ffJkUBsPBWB2tv+YAxY7HHSvVYTeItOuyIZPJVGGJJ
	g/knXkdRvdecdd8JeB1x3kWfMMF+i0Wk9qLuXwMgLJ2QDrPb48IZ1gYDvgo8JPwMR94OQLi0l9y
	0EoITGQrdkbyaj5AcAn1WKVqmLDvrr8hE4
X-Received: by 2002:a05:6214:5290:b0:89a:c64:ca6 with SMTP id 6a1803df08f44-8ac86296524mr24393916d6.38.1775806382703;
        Fri, 10 Apr 2026 00:33:02 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84ca1d19sm17228896d6.37.2026.04.10.00.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:33:02 -0700 (PDT)
Message-ID: <69d8a7ae.d40a0220.2fb984.e89c@mx.google.com>
Date: Fri, 10 Apr 2026 00:33:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7917527930968624799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v2] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
In-Reply-To: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
References: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7917527930968624799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079574

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.97 seconds
CheckAllWarning               PASS      28.59 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      25.14 seconds
TestRunnerSetup               PASS      565.16 seconds
TestRunner_l2cap-tester       FAIL      27.91 seconds
TestRunner_iso-tester         PASS      37.58 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      113.08 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         FAIL      14.87 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.62 seconds
TestRunner_6lowpan-tester     FAIL      8.81 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.115 seconds
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
7.0.0-rc2-gc006ce61ce3a #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fa220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gc006ce61ce3a #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.909 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc006ce61ce3a #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff888002777140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9804d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6ca1/0x8b20
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



https://github.com/bluez/bluetooth-next/pull/59

---
Regards,
Linux Bluetooth


--===============7917527930968624799==--
