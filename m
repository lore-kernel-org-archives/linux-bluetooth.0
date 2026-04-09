Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0553A8F7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766167; cv=none; b=lBwN8svu0Fh+LM/HdGhbNpzlMBtbugUxBJ2VDzUR3VxIK2nxItPqQ60GAp5H8nXyrxLbUlR4rftSHt0Jh54hnMq7SG/Jw1c6QtQ2r3ASLDplikDN/ecAWefLdzJqOWw0B99ASouUSOxeXedVDQBvH2d09mCJ7t04DS0E8OM5WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766167; c=relaxed/simple;
	bh=BTpBhHMRn2WYp/FCfPh5AuxRW+E2PxMPF476klScqAU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hMWthtVCBtOKaYW5MQx5J4LhyEfr6UhFu3rCjuN4okIJRgaFFZpcuF/gpLKG7LJWA/vzP7r50HMf134lstVAq3PRaoiJS/wyx6+w0Dv8KU/AfNhKrcnE7WZiA6n/K1U4di5h2rYDQuUJwz2gwUFUXlEwpW7Ngu4GOZIDjovfvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkgiWXDi; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkgiWXDi"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbb89ab229so1213538a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766165; x=1776370965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MW8sCyal99lGmCzhLpnJ+Wghcd77LFiLRXa/40FuwuE=;
        b=nkgiWXDiqCHb1M+l3+Vb6vUhtCLP3vz8y6HK1C/ciZZwcp76+bjoYC1xtH5G8YVU25
         c/WLqTUAzXGgOJIQEWeBqevcoQWO0zbSMw8Q/Tq+j04Q8lmsgB1cgys75ZHBGrQUU88s
         ebTjJm9S4ue868iByK47vp0XlzCWZwjL6ynTVo2I3c70A3MXQbOJQ5DtvaAnfu/jYG9J
         QaIIjdGUtSeGpOMSSOEMw3Mc5Aka9TJYNMu3nemU68KkCneLvcMZU6Gpa1MYd3Di0LEl
         NFZ09hGKjy8zX+X2DhSNFNQzsvYb5/2aXIzwdi8ySgxzXIycw0FHj8SpdnbJj7bWKFQi
         5poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766165; x=1776370965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW8sCyal99lGmCzhLpnJ+Wghcd77LFiLRXa/40FuwuE=;
        b=L99lBVYCQHTKJUgeDVhT+MI6eJKcEWQ32UuLJFg3Y6N9QeV4XaDg/b33knTe8i73qR
         wLjSgUQYxVXPWlboIPi9bX1YdJzvpdfszi6hhu1p0SUMs90p6HIM7wp5q5+ab4FrqlEP
         QiwGi26wyC4pzOmNZKFPptMGVSpbeQxwj4lDHXdniyDjed2x5N4F9tyDHgtI0btMNNLB
         DjFLV6bdO60ujKxJv5T4PQ+jT/3sKKs6WKDBiIG6iit3A4ppwmB8aQqRehobjxvargjU
         Foh/bZPBmV/aaAzbvDXoAb94k2zU1SbQrMk+NenbK4K8adbuorTT1ThA/6wczqYVaROq
         rdTQ==
X-Gm-Message-State: AOJu0YxPN8psFJZUsaAI4IGbbUmcXvsdCUQ+ltEYoZDh0vQe1EEeO8Y1
	GiH3bq6hbm35jEoqEmPH23gwxaGH2IX2euq8urZQs/LgjvbKs48WVJaSbaUD/A==
X-Gm-Gg: AeBDievaBiqIflgV3KLElFPaWc1XUnTC+mThoKQThJUXZpvgELfskAOQhGHkU8fbHbl
	uDbX/NbZ6DknGt4KtZmll1ndNgN4GBGYPDAuRbL3q98mqoPn/bVF/nagaP6YW7kf58i6S6YliYc
	llk7kidydyE7qk/5RdhPEPBzFFexww8PsW+tCtsDFRhRqhoa15bpnMJ8yYoSBdg1DqpYArQz+sm
	6FCCP9//BNXGuw9DuSduPFxE9nv1KLOcljNdvvE/Y5neQmqUYriIkuAGiWNMsuZSoqSteeZYqF5
	zAy0OcFuls9fLHJYW1pgGjZXXQF2BZHeUXwUKL27YgLK+ve43p6eApjBx5qgCdusVfmKAFInrH3
	fqGxvvHl1fDnGhaLAEufrAiaX01nLv8+o7Wp1XRQ49baO0s+bKq8CWAwzvhKw0v1jKScNRQgElf
	qL0muJ3QlQ0CEF49bNb91NRjV0W9l7mfePHXqCOMiaiQ==
X-Received: by 2002:a05:6830:81d5:b0:7d7:fd5a:37ee with SMTP id 46e09a7af769-7dc27f0ad01mr407967a34.15.1775766165101;
        Thu, 09 Apr 2026 13:22:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.123.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26573350sm554427a34.2.2026.04.09.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:22:44 -0700 (PDT)
Message-ID: <69d80a94.050a0220.ebd27.b77f@mx.google.com>
Date: Thu, 09 Apr 2026 13:22:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2051568504659822448=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
In-Reply-To: <20260407065053.3037036-1-chris.lu@mediatek.com>
References: <20260407065053.3037036-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2051568504659822448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077968

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.77 seconds
CheckAllWarning               PASS      27.71 seconds
CheckSparse                   PASS      26.56 seconds
BuildKernel32                 PASS      24.82 seconds
TestRunnerSetup               PASS      549.83 seconds
TestRunner_l2cap-tester       PASS      29.09 seconds
TestRunner_iso-tester         PASS      39.48 seconds
TestRunner_bnep-tester        PASS      6.72 seconds
TestRunner_mgmt-tester        FAIL      118.58 seconds
TestRunner_rfcomm-tester      PASS      10.13 seconds
TestRunner_sco-tester         FAIL      15.17 seconds
TestRunner_ioctl-tester       PASS      10.71 seconds
TestRunner_mesh-tester        FAIL      12.73 seconds
TestRunner_smp-tester         PASS      8.93 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
TestRunner_6lowpan-tester     FAIL      9.16 seconds
IncrementalBuild              PENDING   0.33 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2f68276e8bf1 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff88800248e240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880020d5c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g2f68276e8bf1 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.413 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2f68276e8bf1 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9ec4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/47/checks

---
Regards,
Linux Bluetooth


--===============2051568504659822448==--
