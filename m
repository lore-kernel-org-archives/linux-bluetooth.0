Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BB375F69
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988905; cv=none; b=WfChsAixVX2gDklrpx3Isj3dt1/83fV/bQ3t6nEWFxB3ZvvdukfZYkVTvUshyoR0kS8uegq9Zhs7oqUIYvX7URFIfwqHCCvBpAIYLLyxYPKPB9Lhq5vSNQgoBcveSBtWzRfJ+HU8Vdv867OlzH35M/pQ5ZgNc5U7IguKYQQbvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988905; c=relaxed/simple;
	bh=qne00DFPDGSYMcX3qr2QOMfZqvsAowQouompdHq4CNk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TMvsVvbz/3OvFZguICttdl/Ll04chkkHRsHn0DXsA4aCPW5c6q+JhyaK4ZmY/RQVAfALSfWbHA0MXYG5h5GD59NhtDj+aDU8dWYbuXOO6y8Wn/tVoCIw1M3hapN0VQyzVtO4SI+DWMYwL2a1ACJ8b9RPNZ5Y83EsBxMUAobaR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apnPs8dY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apnPs8dY"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8aca4e14411so4963876d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775988902; x=1776593702; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkv6k6nMo2ls4UwGSGldxa0/tAzFB+2v4eGBsvl2oBQ=;
        b=apnPs8dYFFsejATyIjJ5r7ZPuxOwLknD1sD1F4726buXBRAMq+bAb1T0SVFb3DfPnJ
         N/Y2A7qwOLWL3i6Jj/g93+fwK6+1U2W/Jf0U5OW+OeHKF+pOx11BXW6PcJwqmyHrfzh4
         Iapmfte8q4iNQT8jOchAdVYMwSMVWE5WyjdIWzkJDT9RHvlZK7dPno3K6JTFMRyxl0wv
         uY7HG9tdCKyyVS+lEOdCrzWKuIYELpukSZRBcz2QwpKLKnPNiQ7c1Eh/XRVeUMzGTVJK
         aJyFyY/AaN9Y4iMFXx3QUa3tsx1nhancJb7ubOyGlKoU7bjlBFAciyOwaGkvVVactBNV
         h/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775988902; x=1776593702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkv6k6nMo2ls4UwGSGldxa0/tAzFB+2v4eGBsvl2oBQ=;
        b=kER4Wizha8ayoZx5n9AyRIrxbqZ+JG8zamlyQlmUi5sUgVEFs6x6i6rxbKuZaIjL3X
         Ms3tY5xA8eNnF4KRj7/L0oU3rzbZjXc+lCYnqE7dN9dtm1bpPw+mNUVR6+mKN4vlBrlF
         J0kGBbWpijTb2J5jqFaq2kTtroMLhocKn8azbWc5gRHtRBl7T1TshYDnI6uvroeZpbcZ
         2RbyDbsWMFLat6m5ilQKuxphuuYJv+sxiCPAWS84kH/RhQwamjy0T6WguFhCYKbSBfTC
         WPJTg439rvrhX1JADnbjzwbK8rvKDTozwf9dv0u1LRfLyGHFRVla0BJm6o3Bdp0WlR04
         0RIQ==
X-Gm-Message-State: AOJu0YwqxnIBv97km5qup6dKeomgE8vR0L80DBK6b/zICzkvi6ShgAAs
	YML6uNeR4T9Xv2w+U2Mxs/MGhJN3y+bPVc7Spx9gCWqiGpLQ79bavj32krwUpg==
X-Gm-Gg: AeBDieuWGhYMl7QsT18+NdZX07xLbBKmAXT7N+TeqPMjOdEXxElCMyvpB5YXSpOHdVU
	EqORNH/IjI+ypcDQfSf6CFeHQj+PZEZ7ae+MUyrbcEbm1R0w+5liSKiFhtH/CmbRUBB+rrOJEUf
	Ih0TxHfM5/QVohkBYKD7qn8OdiPYMSyYhMpYnk0xyOnhynFNBtmrTPYTamj+2e+GfC1RZZ+w+yD
	tfmfr//0nX2joyvg6MMpmuVxR4sAZag8pP3mtvs5NrIrkgsX4I/boqRjBT7N6gOVp/YmFfxlGA4
	5AcuhiEVX8DRIuWzFIFgnvbw07SAzyiG5YDhXhcLhq9OceoNAp3Wkzrc1aHNNfjM1wvAm/ignHA
	hXDVqz+pZijqb9cloicnx1NHtTpCj7wRk/AbEPDp2kgHm9oILTOC+GOsb3oHLn+q+6tF1AJb2FC
	Ck2EWk0E8NNiR0nmkJF93AXhjIx7CLcPI=
X-Received: by 2002:a05:6214:3bc6:b0:8a5:fa79:6ec8 with SMTP id 6a1803df08f44-8ac8617ee66mr153772686d6.18.1775988902135;
        Sun, 12 Apr 2026 03:15:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.94.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca57b465bsm12994196d6.38.2026.04.12.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 03:15:01 -0700 (PDT)
Message-ID: <69db70a5.0c0a0220.7559e.4b7e@mx.google.com>
Date: Sun, 12 Apr 2026 03:15:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2608478391524616820=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v3] Bluetooth: btmtk: add event filter to filter specific event
In-Reply-To: <20260412090242.1129701-1-chris.lu@mediatek.com>
References: <20260412090242.1129701-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2608478391524616820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080298

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      26.68 seconds
CheckSparse                   PASS      25.28 seconds
BuildKernel32                 PASS      23.41 seconds
TestRunnerSetup               PASS      528.57 seconds
TestRunner_l2cap-tester       PASS      27.63 seconds
TestRunner_iso-tester         PASS      35.57 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      111.27 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.47 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      11.67 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      7.14 seconds
TestRunner_6lowpan-tester     FAIL      8.74 seconds
IncrementalBuild              PENDING   0.26 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g937faf72cfaf #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002166240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002094c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g937faf72cfaf #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.820 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g937faf72cfaf #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002780140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
fffffffface4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/71

---
Regards,
Linux Bluetooth


--===============2608478391524616820==--
