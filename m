Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D91F91D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764917; cv=none; b=iFO0YB5V4KpuhVixOBnCDaU9LodBJN3NI5aLbSAeoEXMuftcGgXWCs5OWEfPpa9FIREPXQw5D/jNaOYxJJuCN9KPTm++gi9kHiG/Z5Er+y5QIoA9hiEtO35OiJRoXRjz9SlwZRDXz5SgxQJGoVSi0erEhpDYKOIl0jYkoXlL6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764917; c=relaxed/simple;
	bh=+bQ08B/ntrHvfsYdJh54mu67d4jRYuY9egyJP8yYv3E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ne5eKRTi9wtRhbfyjhKtM2YxRR4KPpTyOf5q/s+i9NzF1SKDmmu+oCbmlIzTZGfpiGaTdlV69JNLG9iNvV2ctnmKUVH6ISd7FmPavTKsTrQrPQZeyFyatL41EQ3cP+dJihyRwG060tkigaJw/KmDocIyjovp9beqUIORoACGTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7dAJEvM; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7dAJEvM"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ff05af29b4so432719137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764915; x=1776369715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G3t6t0seRb5X4VcLfYkvvZ9tpBUmXRFtzkvhwCMaTO8=;
        b=i7dAJEvMukkl5K3sxykfLi5xQtVBUVVMw/gTJEkvmQaG3hRlX5vWBDZXz9mbondgEw
         SNjNGk8oEZsUgBpzcYhRO0wap1bVpubd2yJgr7rEbIkfNl3MPgVb8ik9kssGM3lIb4ju
         LD7S9553o3eaaHU1siIRWf731gWz6tern6Zs9r40W3UQNqRMoub8dBMm5KBH77Ckt+PH
         F17FhVTKx2i78SbHafPAQJ/ORhJyxYZHyaRPJwG+7PZ1HronmjMu9YUAlIJADVmdH9Pc
         5V8a6JQH/D/TXfz3nNg3sbeMaYsItT2ntLqsicrD0Q8sFUZGE1kOIRicZToQ7gu4qLaJ
         3XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764915; x=1776369715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3t6t0seRb5X4VcLfYkvvZ9tpBUmXRFtzkvhwCMaTO8=;
        b=cdo1BiPa5H8Q0UjqnwdzA4iZLuInoHz48uL0y918iwPK9rEZBpdCg9yJyNckhPmrg2
         4RCD2EL7C5kQMVs9tdDxmswP8DaUke+wkkS1zR3IXkGKN1a+2tejSap8ZUQ9Y7q/trdY
         11AC0QHrTo6h+f+9WmKvDhihXeHU5EfGPmv9xLRO9zaVK44mVxxB1qXHeYlb8O8V3OTp
         0oOCN2SEa0X61TuGaN3W9Mg2/6IP/oi5G+oQOhY6H+9zBNk16ijJPhAEBk/YE37DDeKx
         QH8a8BocKJMIEsFjVaqn2DSzOlIzdfWs/dRApazVdR49tfR8DigJIXis3mZilkRrEskR
         A6cA==
X-Gm-Message-State: AOJu0YwP72zUZ//Rv+yIpvGvIDDKlvGHN5mwno4l1Hp4uZsHmI1aC7VN
	p6D6wjOx5jjAYO85kWDMQ3ppWDNTdKvflwjN34sI3hKmFdktF0aUG4QRa4wIxg==
X-Gm-Gg: AeBDiev5zx1QCXopKjGUTUNcbAuqNaIrKUElDhpL/UBioqPlX4IFLWytD+/TDNZEvjn
	ZnVxjVNmQgA7s0aWTXzBL8r0NpWz2vziCjAI9BgVnSfDE1hFQcMpD8FuHFsDevfTR/c3irjOjAL
	nQVP10L26830YWzlybS9LJxuekn4rUo2pnCNTpSk/VZ+i2k05wU9Pvnae6379ZKLyyE4nA7PwBG
	H8wO1kN3UQsU1Pny/d3Jwnuro1dv4E2jcQG1lSgcWOuYZWmtkR5NqqjzD0/ion+Q5v9KC4kUbf2
	qztbyANIi/oGY83DjqgST+FsvAfjZ4RkbZqvPTWS+4+wpfVr26XJcfnKJZlMBTWKdU7hwiEubVk
	jcU24KmwfekhAFIWXvAVOLpTFiKoNbjFqceMxxqfkfIBcthGn6d/20dlTkpBNON2q0SDyzk7FoW
	Ug73/0SMCPN5E77WinXAtVwdP9pJkd
X-Received: by 2002:a05:6102:4a89:b0:604:eeb5:5b38 with SMTP id ada2fe7eead31-60a00b36d56mr169962137.22.1775764914578;
        Thu, 09 Apr 2026 13:01:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.14.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac8449e664sm4533726d6.0.2026.04.09.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:01:54 -0700 (PDT)
Message-ID: <69d805b2.d40a0220.88c29.5ffd@mx.google.com>
Date: Thu, 09 Apr 2026 13:01:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0206411794152649178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: SCO: Fix use-after-free in sco_conn_ready() due to missing sock_hold
In-Reply-To: <abwSbezp8_z0K_eY@v4bel>
References: <abwSbezp8_z0K_eY@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0206411794152649178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069343

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.01 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      27.17 seconds
BuildKernel32                 PASS      25.04 seconds
TestRunnerSetup               PASS      563.89 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      33.50 seconds
TestRunner_bnep-tester        PASS      6.57 seconds
TestRunner_mgmt-tester        FAIL      112.66 seconds
TestRunner_rfcomm-tester      PASS      12.17 seconds
TestRunner_sco-tester         FAIL      14.41 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.75 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
TestRunner_6lowpan-tester     FAIL      8.93 seconds
IncrementalBuild              PENDING   0.25 seconds

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
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g5a33dbd55f1e #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001dbe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x3e2/0xa70

but task is already holding lock:
ffff8880025ff220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x235/0xa70

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
       sco_connect_cfm+0x3e2/0xa70
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g5a33dbd55f1e #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 lock_sock_nested+0x47/0xd0
 ? sco_connect_cfm+0x3e2/0xa70
 sco_connect_cfm+0x3e2/0xa70
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
 ? __pfx_kthread+0x10/0x10
...
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.835 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g5a33dbd55f1e #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002767140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa444d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/23/checks

---
Regards,
Linux Bluetooth


--===============0206411794152649178==--
