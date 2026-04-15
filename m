Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD233C18E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291387; cv=none; b=MbHUxp8s1Cr6DweU7C6U1H/iXafV8QQQJE34FoJbwpsmtY41i9y9q4X8Rs4T9+QETJ8guUfG9SXQg1Dz68lIKrIqFSPetMpxYLu43uWBBrZMz/uW7eMlfEHzh5IsNogcVGbFvtqpMDnAqCx+gD+LsWbwkG+86mcp8t6VY8z6Eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291387; c=relaxed/simple;
	bh=ymW3p0iFsbf2tegQ2EUU8b0Ci891b/MnjYxAOYPoN7Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ab0QFqGmsDv0UgxRh8UAhx2M9QgDdAX1T8T95XpmAHF4imH+Q9I0Wfhtu/xjykjQkFwY8yEt9PNDN7MyZZAI9TiQ8HfteR77rZtt/uUC6ISnJkUBjHc+Yk2Sw91rSuzYWXgx0Ylgo/I4rLC9LsMIdHKrOugsf8ez+1lULjOYQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYaXEymk; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYaXEymk"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso10001855c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291385; x=1776896185; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qBh3zezvyQ60SDxgCNG8yiXVpQRc/tyEKK9/YBQefJY=;
        b=lYaXEymknS8Yw2gkxG9MBi96TTmGA1pl0UYM7JA4zJe4JI8PXqf4QWfvHHI14SOj/u
         aDYkYgoJ0MvsE85ugbhBUCt5eRjUyjlu3824d9dwE4WRpzMbV7gVwFjqkzBqS64fw+6o
         frTIHF+1qhvhIpEe0YukfzA6PXchOILlZOlR6TtmjjSeZ+k8oAHWD2azSoss95rP52R8
         KiMyk0FD08tYOhsTdtmwdaOgYqY5I8Ksc2wJCRubVzwEvK3DOcjBvU0w101Q6mr3Vn6q
         hqjbWs4ZjTCvQdvPSjCHRt9KsbaPtPJcqiFcmtFdrYn/VnipoRSRKKpyIRFCgEbG1iXk
         xXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291385; x=1776896185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBh3zezvyQ60SDxgCNG8yiXVpQRc/tyEKK9/YBQefJY=;
        b=PsQImgXSqq1vl0+XX0jmqG911NyTJQJ/Ju4NNViRt5y+LTVxF/FW6Dc3Za6AWwufTQ
         D2sVz4eZyZdWc9R4NwXYRDd/7Tvnn7jmfOS8pYXYTV3LJN9S3dcQLqzQ/J/DqVyCZqyJ
         X4qffxUkKrHj4CbtFrYlhTG7zGrm/tPyCbJk1A2HqRyY9RSYzcbmgfwSkZsfN4CJ2kKo
         Q1IoajT64dnzIcQZW733u3AWGUKc7ejmuKEHVmE1T3QiK0kvD+of2+CKchp4fiJygBQ3
         9MnRjt3aYphpYShYt5ZLnOf1hGdDpWl18gXZgdwZhYAcfLPMrdEVXdlBYbVcTQ/73QEY
         rSUg==
X-Gm-Message-State: AOJu0YzT6Ml3tgy0kuCJRINYDHU3rgpcmg6+J+VWT2cGiDtMalkz43aK
	SlyV50gAP/pY8d9C9usiyw39sVqiauWbgYrqIQrW//L7rziyRlgzDkZbn2A4hQ==
X-Gm-Gg: AeBDietuHiEFnzu75/T/XQrXy9cuQogafB7RyG8f8uCWjMZxBH2hCTTkJMUa8OSwnnx
	feJT2ONOoSfSXIMTFGqglgQCyeNZ61fMznh5i8BwLkkrLIWOPgk89uLiO+C1444L6pKkCMsydg2
	ZIoRKHOQoHAV+1LLdO2cho90EsicBQIp83/COGMB8q+3QldHJKIPNomGnoLrE3batDbIlhddumL
	asgJv4ANbzZLDOA5NnoZBBvC6QsFFYEhstNyvwLyB8qdOoSxLCCX9vn5DN1At2dBXGx6fIaR61c
	5GRXXLi14K+kJfo3KjeWnrp1Dy8kXTHUJatwM5iPf0xy8VR/Wm6vq/ZQrCTWVvt0p+C0BJ0IE/X
	sPJHgIAKBTsioiTYClnSN7NEO0YKkmjy3727nkqlUs3ADF4vQEnVSfwUcX9uNH5tLQUyFIyu9FU
	o+SLK9MmHNCCK9///FvTNH3ZOUG3fJV/R96MXExOhV9jqgpyh7dNI=
X-Received: by 2002:a05:7022:2393:b0:12c:34b9:61bc with SMTP id a92af1059eb24-12c34e8f1e2mr12150651c88.5.1776291384773;
        Wed, 15 Apr 2026 15:16:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.75.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e630143sm5437448c88.6.2026.04.15.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:16:24 -0700 (PDT)
Message-ID: <69e00e38.050a0220.1f51bd.3cfb@mx.google.com>
Date: Wed, 15 Apr 2026 15:16:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6503570027772053158=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2,RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260415204842.2363950-1-oss@fourdim.xyz>
References: <20260415204842.2363950-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6503570027772053158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081739

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      27.54 seconds
CheckSparse                   PASS      26.37 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      643.72 seconds
TestRunner_l2cap-tester       FAIL      28.11 seconds
TestRunner_iso-tester         PASS      38.10 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      114.42 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.10 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.15 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
TestRunner_6lowpan-tester     FAIL      8.28 seconds
IncrementalBuild              PASS      23.63 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.120 seconds
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
7.0.0-rc2-g9ad64244e2e7 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002056240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g9ad64244e2e7 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.801 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9ad64244e2e7 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9424d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/88

---
Regards,
Linux Bluetooth


--===============6503570027772053158==--
