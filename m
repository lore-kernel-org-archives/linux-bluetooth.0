Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CA3EC2FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182632; cv=none; b=pfFngLzaCVowxXPDUhm1j5bm7L2IbMrdRVi9gq+1TTFHZ8b0zfB6m+0HN424ugD5sHySmGEvY9M2tR5iUvdgSdn9FLBNlmefc+A2SEzq0KiNW8LJlKWaUzExylv7DkzNpyiFFD6YNIAf2V1kK0WwuZuo1EoN4mdjvtC66NS55+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182632; c=relaxed/simple;
	bh=rWkxjiWxdTqn8+bEphYVMC8/M04w3zEQ+FKOZGBEDjw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AUCqxUUiOhfG0A9V3kWJ2mURE8tOOuR933ecGrEnquxjoiL1yIDWy9+gG4taMvRY+idXK91E5hTCyqsuuyve5cG6l2KV7jp/u2B0zLqvMNEMIXHu++vkYHX5Omu1o6AIu/Kb/FSSR1CWhxJiA5mZC13l07/rzFj7C0ximTGR0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdylGr/B; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdylGr/B"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-68244d317e5so3537301eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776182629; x=1776787429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=65WNEW04oY81qAzIJwulK9o7aUcyEqma/eqL+Yl6h9o=;
        b=IdylGr/BLrcPULsuQ1DNDMw6iAWjAP9MQhPv8JuP6WgNemkxU6OU37ZQQAhfdU+XZ+
         RNbeGDdL3X3H0gfVsg3cMwzkN5F74P+eW8pEeDNgwaA4pqrsGqTJG53l9zh7gPhNqFRE
         w8oLbPp64VsQFzzFN/oMNcGojvXTXm8E8KsZr7tqab8vMzZkevnVjag4bMFtqCwORhaK
         KYtaqfxdZO5I9/3gRi00bsheM973N94q2u7plIFk6gh8piuYokssRvc/DRBs2r5lIGNj
         YW8DARWrdhcI0QGsghpHMHLo8lE//+EbGfg9Mm5ARNC2TbTmNElSBnOq5JQT+j93XGTz
         ouRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182629; x=1776787429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65WNEW04oY81qAzIJwulK9o7aUcyEqma/eqL+Yl6h9o=;
        b=PdicUxUe8Bg0bs3Xnop4ftqo+M9pwpjdt3sJUOz9U9OhTFrWzNiGFZoR6+FbeeVcVv
         iP3KWmRZ4Aapkft2wFYLDR9t7sgMcdnyOgRtW+HYlGJD/vSVpmrLZL8af7GF8tJsG0RW
         w6LUB0grntOsGeQVSHOKoXoM9VgDOkkIqgDip9ycUY/Gpdff3Re77gz04IdWUQLn8fW7
         wGG2nT9ssgVoPeJk5e36n5Vnk6iHF8+WY+f8NSTldYHkOm2icwzKU5lD3/MyS8E73t/U
         2CsjY8/24Yo/kA21lCSC+Vs12HgDpyVNh7U3WO350vRoS92BpmuC6tnalioS5QvydAE5
         FMMA==
X-Gm-Message-State: AOJu0Yw76V1blSxTsx3yhtiyR1Sve5eegilSnziMvwi/usk3JQs35CzY
	aL3OwqGmNr2LUzNM4RZDvgnlZ8pw0BtQ+xVGWWrPaHG+KvwANQZQAZxOqwoPsA==
X-Gm-Gg: AeBDietbw3oiJF+KZRI4hhyyob6BBLJDuhUU+oH3tG+LQISjMFt0a7T95YEnVNSsrB9
	HwDx5m0/QXOget3GX2sFAuhdTInxy1ywFPYbaWPgSJqxAdohW9W2+SJPOaZZRA7TfdeEzeJLruV
	Tv2g2RtFi3dNvkoKYaIHYfsYKHHpePazGb/Nanll9JibC9vDcMA1ScgerPzOTZ7LGarQlOJ4mot
	Dq349Tx/rYT3FySRpK4zeU2R3eo9b/BmOfhtRQsAh20Easu7Xz/8eRrFkohNVHFTv1VLeCjwiP9
	0Lj1Fvw1xo6EkGloXZTuYhakvpy/GdhiNxurQzrUoPvDlUHeM35CSWmX0MLWb6E56VzcxqWN76d
	vXQz0lG7MItSwcU3lgsFnH2x/xnXsnHGfDpD8QRs8tlKdt1JZxbLn7JA4bP3lfoXNlXYYFkcRFM
	mjYXG4vKeu/CXm/ItXXug9MXEYD0e6OdoEWFqWPhrt
X-Received: by 2002:a05:6820:1886:b0:685:dcfd:2305 with SMTP id 006d021491bc7-68be57780femr9504584eaf.3.1776182629203;
        Tue, 14 Apr 2026 09:03:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc4d03ea1sm7783019eaf.0.2026.04.14.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:03:47 -0700 (PDT)
Message-ID: <69de6563.050a0220.47b4d.be24@mx.google.com>
Date: Tue, 14 Apr 2026 09:03:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1291068905635699921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
In-Reply-To: <20260414144641.1168084-1-luiz.dentz@gmail.com>
References: <20260414144641.1168084-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1291068905635699921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081189

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.35 seconds
CheckAllWarning               PASS      30.09 seconds
CheckSparse                   PASS      28.67 seconds
BuildKernel32                 PASS      26.72 seconds
TestRunnerSetup               PASS      584.01 seconds
TestRunner_l2cap-tester       PASS      28.66 seconds
TestRunner_iso-tester         PASS      35.40 seconds
TestRunner_bnep-tester        PASS      6.67 seconds
TestRunner_mgmt-tester        FAIL      117.98 seconds
TestRunner_rfcomm-tester      PASS      9.72 seconds
TestRunner_sco-tester         FAIL      14.66 seconds
TestRunner_ioctl-tester       PASS      10.62 seconds
TestRunner_mesh-tester        FAIL      12.19 seconds
TestRunner_smp-tester         PASS      8.89 seconds
TestRunner_userchan-tester    PASS      6.92 seconds
TestRunner_6lowpan-tester     FAIL      8.61 seconds
IncrementalBuild              FAIL      1.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (91>80): "[v5] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ge2297ca80d65 #1 Not tainted
------------------------------------------------------
kworker/u5:0/115 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f6220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 115, name: kworker/u5:0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 115 Comm: kworker/u5:0 Not tainted 7.0.0-rc2-ge2297ca80d65 #1 PREEMPT(lazy) 
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
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? _raw_spin_unlock_irq+0x23/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x498/0x7e0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x9e4/0xe50
 ? __switch_to_asm+0x32/0x60
 ? __pfx_kthread+0x10/0x10
...
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.613 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ge2297ca80d65 #1 Not tainted
------------------------------------------------------
kworker/0:1/10 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa5a4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

fatal: previous rebase directory .git/rebase-apply still exists but mbox given.


https://github.com/bluez/bluetooth-next/pull/82

---
Regards,
Linux Bluetooth


--===============1291068905635699921==--
