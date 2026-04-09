Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5933B955
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766006; cv=none; b=c4j8LiK0mZJPWbFJ4QahYqAvriSK5LG5W4dP+B5EH5J2/52frx4QCg0X8X4SZXeN6qRxtCkNtRkpV2Benu34s17hoqsIyIjXx/sa050I1nfrfiLY0mc9TsOI2UQYg2uApOND7bgIcujTqHqSsvCDc/+Jpz59XZ3SPXLhPOy4A/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766006; c=relaxed/simple;
	bh=h+kFzPetbBvSg4BJz2mcRomWF+gtML+gkOtYCViY+nU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FMEg7HKVqSd1SGkEvxl/AXyUAnETX+IMMD53Sap0foHx01B5/WdYYyzRYZc1sm14taZ4S+XfjrhKgZgls65mcJRNm22k4bYtcMupBZaBXSnjF4mEdVtsHmUqnWHYNir+ap/3HqwRDmzLpf0qEFn+oXHEtcOvE0l0jvbAGhXgm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV/uhr9/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV/uhr9/"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89e8e352dc1so7159206d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766003; x=1776370803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vAGzakol4qoz0uB/GVWytJCHuNQg7KJFQC+AoI+TCN4=;
        b=GV/uhr9/JElB+4to1TwUZTXtJm3maFEPBhfsVy9UyZ6qIw+07AP+uSzInx/YbT7LQv
         KGZLinFi3Co8AW3cc6qXxoC7laFWLwVj6r6HcJwxjP42Of2T4eooA7naH7ntd6kdUQjH
         ivyoyJTVhE6EWpCSUb+voHEn1C5jSK2Y+iaFLqLebqWUvpKGQJxY+5ZG9DDB+lJQ2RGa
         XakzfZnWCHAQOm1gtRDdaTHiIi1Ko0pUs8KCMpKjZuPMgdLkvi0IrPFbLg3NdzhOZdPq
         UTWQtqhzej5YQYw3ZA+MbVznPVF/7G4mt5shNiGfiI2909IhReyKgu4/BNWWX1+UwRqJ
         e0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766003; x=1776370803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAGzakol4qoz0uB/GVWytJCHuNQg7KJFQC+AoI+TCN4=;
        b=oZozXvoFfCYTF5CvAZHpanIJpiO3nvt87oYKY4gpzGIrfj0HWhtLR2hy2lu6fro9H4
         e2YYB+wUDD51wFgiRm/Ksm/rFH42jmg96WYyjzw8eUbVSDXmM5LdJNaWGPQrG0foVgDk
         DWZ3jjBD7TmyuifI2UWhnO00w8KaMqBT1PiMqPB6JHYPyoqiW3Ju3/ph9uWyjaofoi2A
         GbFUMi2psQAVESGfA5im7wLgiKg+Tuk0RIam3IsEbnvWmiiIJcoBJ1U1aJsDcP0zseyJ
         YlRNw0kOwBWA/s2K8PhNd8z4jofEa5bcT98R/QNsYofc6sHVLlnhwdi6fRt9Qob0kht0
         9VSw==
X-Gm-Message-State: AOJu0YwYQMr4HIfc+CHuQeX2tw+EROkXsEqHQ+8hSdF2j4Ofho8VNiaQ
	hEMiK3qvSyvTi1T8MS0xeS5gFwABZ6Tu3cUsSenArPDkkAsiLumXR/lOofWEjBRr
X-Gm-Gg: AeBDietkJkPsP/jR9YfJHKj8h3DVVXRO4Q0HOqGHBUbcQSV9DI7vh7HrbzduGK3Lu1O
	HHU8sVgbLWMJpsslP0FBsmYGRR7GEhBMBc7E9X+udd4BW3Nl0xoZ5Blj3HMrb9FvEJwA0Ayv6tL
	HNVH1e4nyZpWYYNkKVpyWBaOZx/K3fCPdRJmnSaJuHyqbxHop8t2ukF1kZXfBcAhKNnaiCPSrNo
	+/Xqsk0Rf1m/eUPq6nadsdd0RSce1q+y/WyJL2Mzms9WOTY+IZWeYyLidA4Zv1RmBzT9g6Hk8+F
	eD0jwo9WP9Guai9H7NwEmb/2C3Mv0ugqQnVPLDulN4EH14S+rZNYnEvfc84d+IXu/urvCooxapQ
	QFEMWgR+bdBx+WZqA/ZMxji+1hGBWpNU+V+JqMLsstl8nQ7tLeqESzJtlUJXgFhzeomRtUqiwd2
	61raxRf8HgYr1FdSWMajP6xFdzJvSR/5cwTadOUtN2Ig==
X-Received: by 2002:a0c:f40e:0:b0:89c:ede4:ea35 with SMTP id 6a1803df08f44-8ac8613e90bmr4535286d6.24.1775766003076;
        Thu, 09 Apr 2026 13:20:03 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.117.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849dbb44sm4763956d6.10.2026.04.09.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:20:02 -0700 (PDT)
Message-ID: <69d809f2.050a0220.343f80.b35c@mx.google.com>
Date: Thu, 09 Apr 2026 13:20:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5999256066958943028=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Support Product level reset
In-Reply-To: <20260407092940.1272507-1-chandrashekar.devegowda@intel.com>
References: <20260407092940.1272507-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5999256066958943028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078042

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.22 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      26.02 seconds
BuildKernel32                 PASS      24.38 seconds
TestRunnerSetup               PASS      516.99 seconds
TestRunner_l2cap-tester       PASS      33.93 seconds
TestRunner_iso-tester         PASS      42.63 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      110.63 seconds
TestRunner_rfcomm-tester      PASS      9.39 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.63 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
TestRunner_6lowpan-tester     FAIL      8.58 seconds
IncrementalBuild              PENDING   0.32 seconds

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
7.0.0-rc2-g52c2e89e5f6c #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025b6220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g52c2e89e5f6c #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.843 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g52c2e89e5f6c #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffab04da60 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/49/checks

---
Regards,
Linux Bluetooth


--===============5999256066958943028==--
