Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064439934B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776712; cv=none; b=Sq0nHsAKCoWXvPMutL5NvIJlk+KZuc+aelo6QSCE2/XOaN948+Rb+6bpqq/Noc1ETVroxZWryf3F0YSuNICj3CqRgH8ywRdifl3iaHq6HR+dQgjahrboN6a1y0d2iH8c732uMwO8pSFDmnaA8QUXFaXV8cCTJKXgjtIMbrnHNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776712; c=relaxed/simple;
	bh=OF5aByFCZPkBdnyeNBVTgO5fcY8fH191srLCxGecCbc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dygMQ5X2XMbZz/NM8JRX6SuGAqE19/xIfyjdDSnVMc8sx9ZHhYvEUa3qo58sSo4Wy7SgHQHQ1m4Ey8FbDtprr7szFEW/V6yKZLFheVR9TlC6Pce9c1YQ/FeBx7owuOO2H6XC/3vUXiZocQ+JNAmJZwudHlKzrPpROr/PKVLOk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f25Vis16; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f25Vis16"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1410297eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775776710; x=1776381510; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dPtkRKZbPqZzhQEoONw++f586sTHPwcZRQzdt9Vd9Go=;
        b=f25Vis16SPCCP1Wngp4qhifY4aqIIXmO0soh/tVaZv+AEJBt+p8afMgAPhk11593fA
         rat2e25nv51kHreFnxi7IRCcrKMe+HTkf3vWE9UXJeg3hX3em++TuV6+0h0NWOpSxNta
         WmZvpXR384Vf9QU0kIxXVoZ1RkZYScxK4cvWQWypXOE2poFlzyhf4K68YMyX7eTtGjn1
         iP8erqwP0M7ig/x68Ek6n/B2f9SbyIf3WVkWXKSoi98WRb3J6neufwiSCOP2QWGm7ho/
         y9r+gASRoOAKctltbgqzZwiBzvU0l8EP9U4g4ZiksMi3zMfgIwNgglknibKtkuZ5YxI/
         1DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775776710; x=1776381510;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPtkRKZbPqZzhQEoONw++f586sTHPwcZRQzdt9Vd9Go=;
        b=RwWZfLJWVMD3Cj6U34pTJC0gJVUSxKECJp1wtJJKxXXfTErFwcXm66taPsmscIcUI0
         z1Xgz1ROA50TT2BxWpZIaHEn5rOjIu2O92cUX3Q6FihlpM3R0SHUkubAZ5tPfWu63fnB
         fJ8NTluxLk7G9bzvmvG/hhKV2CsG2cw7b9FgA/TiuYH/pGpBWdaJ6RkmbByymiqr9udb
         8r9D64GhRDbFOWLv7cxO4RRCnhDIerX3kL4JVnIHBxHiyfr8CO2ZCRQYtN+SnHmdz+81
         X9J+VuPH15jv2kv2UQwxmSIIZZwm86NU9thlxYjI7fpC6K+EwiTARdjcVJAQCEJnL1la
         A4oA==
X-Gm-Message-State: AOJu0YwnkTlZyijmQh2bMqoME8cP+8EKaC20bytzceE0C2MKgkgZz94N
	05wJUR9Zm9zq+GUw2pE4QF2ki8zTNJQsU7bIfPwvotoU9intieJbbLSgqWOIpw==
X-Gm-Gg: AeBDietTTfZs5MsclJ01RHfAWBr6jPBUOvQcAiSG/VnCvqsfBAXKgiZn50mC8CwHA3B
	+hBGB55y6MeQKO9J/7mE4dCZ8EAjz/64E9pd9SKT6EUoZKiw38Xeza/yOiHVqNDoq7ym/YAWjhw
	NwzoI3UIMO7Ybxk4Y61VfjPqEUBCpZGA+dQzQ3BthA+Lnkl3TkLhSFMz6fog7eVv1GdRnzHsB0j
	/AOrTR90/5MLu+8vQEUIFCp6gsQOvUmsgWBUwZEjZZKL2e9vIw70ZaZI80PmkI0N2qtnWLuiS6v
	TXkZChwffKFEUZIh7Ur3FAKQ42hpDDFoxAHlzBsTuDVW9FUrYXcTbGel7HlFmRSdJwGZFvRhdtC
	eqAP/sX+1TLmboJN4uJ23MDg89pLjw9F8RGKDGRqQ4RjWzFsyErbRPgqLPJ0ssRW54pQbhXMlQB
	/AHxcjuFhTaDJ/AhCUsGtwUBTksbHT
X-Received: by 2002:a05:7300:a14c:b0:2c7:2c0b:f33f with SMTP id 5a478bee46e88-2d58945e0admr519960eec.21.1775776709767;
        Thu, 09 Apr 2026 16:18:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.217.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69b3sm1778702eec.1.2026.04.09.16.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 16:18:29 -0700 (PDT)
Message-ID: <69d833c5.050a0220.1bafe7.1f62@mx.google.com>
Date: Thu, 09 Apr 2026 16:18:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4419877431984303030=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
In-Reply-To: <20260409222122.21394-1-mikhail.v.gavrilov@gmail.com>
References: <20260409222122.21394-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4419877431984303030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079450

---Test result---

Test Summary:
CheckPatch                    PENDING   0.63 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.42 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      28.65 seconds
BuildKernel32                 PASS      26.67 seconds
TestRunnerSetup               PASS      580.34 seconds
TestRunner_l2cap-tester       FAIL      30.12 seconds
TestRunner_iso-tester         PASS      40.08 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      115.69 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.67 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      7.05 seconds
TestRunner_6lowpan-tester     FAIL      8.82 seconds
IncrementalBuild              PENDING   0.34 seconds

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
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.120 seconds
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.120 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.115 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2b76e604820d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880023c6220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g2b76e604820d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.653 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2b76e604820d #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9864d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6bfc/0x8b20
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



https://github.com/bluez/bluetooth-next/pull/58

---
Regards,
Linux Bluetooth


--===============4419877431984303030==--
