Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC71AAE28
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765008; cv=none; b=sT1xwgeiwB7JUJK0E5zhQ2HvpioL9K6Y+dbs2wpXUiEQmzxdvq/eUS/ORadT32HmItn8kARB2Bb1r21MKFfFv6h3laaTk8tzffbjfwrrzqXrc9md5X1y14KblqhJTPF6ETjC3bj3HPAL+IZNI5wwTnS71U/XTbrQ6thrkTh9kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765008; c=relaxed/simple;
	bh=woDYFrjW7wIq/EYIZDmQ5Pgj8cVvVa8zoYj/TvxUOdk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=doe/FMpG7q1iWtWRLTev+vTDnlBV71b6byLLnRFyJEcQMlr9pbK/2zY+GEVATCx7eeC9hw37lvSQidjdvkbIw9eyRwYxbUGSY9ceF/nV/v9AlxdDryrDWUwloHgtHDPXRV+ThF11gaHcJ0z0d+EHi0BHQpgYmu/ezmy96/Yhx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaB82goo; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaB82goo"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c20010f10so3148355c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765006; x=1776369806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pXoDgXixCRzkK4tZ81tCm4AwfeJfsw15ycm8VaF7vaA=;
        b=OaB82goovwg4CIkorB1/ujDapwhX17uCUkTzhEF3v3kQSQBegpgeH4Wg+twIZ9dejt
         MMwoDvJCgxUWYiWUwZDGdAv/20AWHEkpBuw+2wEZ0kQ/GmNDmSSaepCEIz4EgjyaJpr+
         YCwsRXTqk+b2cV1uJbnVXDCWGxN/kdJM6Vslbng8rU4KA5c3GgPpDn+kxkFbHUL/Qvdi
         7tpPi0vrH7Bp3RjSzON+PDJiRcB5iKhmN+/K8CPzencl89LRT84zxHPLtA2UlxgVzxbW
         kkRxi+lD8FQxVJJddDhUcVLj09rQnXGkfgiqLe9BsxhFWpfKiy5TTQsu/m62crBZN6ie
         v3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765006; x=1776369806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXoDgXixCRzkK4tZ81tCm4AwfeJfsw15ycm8VaF7vaA=;
        b=I3vJBDvgpguhG1AwZq+Q1gCahIsHgnBEg1JS5xntOHIwlLqeJG6bTZFjNUhG6anXLZ
         qL3lyh8TLi+QSMMVZNp/oWBdj9hQ6dO4lzoHp7XNGUBguk++OO+YNIJZyZGCw9DjQqFa
         ROHQc/2/23WfaCLxD+ZGzGEuVD2MCNndEdbSwQ96iZGz43YrLK8bJUeXsqVXIe4Kq4SA
         gtSMGsOBYkfjqtcajJywD8vHm+E97rI6440/rKbDSqO0U7hClwqIWc5wLUsKAmNapJiG
         OKI1Viic5dgriP/1KtZgqKlcW2bvymcYLs5OA4nK7wy1aEn/mnlE+feIQ3j6Km6LD0aA
         V9sQ==
X-Gm-Message-State: AOJu0YxEkHufzq1L5xS5mY1/9cPB3zh97zveCjpkAUf25j8O3aeJqw+D
	4GFqMkecGZJQiaXu8RRZM3C5rH2AwxiN36SSHoGddAkS/Ag7w6XGzfVVhENkIg==
X-Gm-Gg: AeBDiesxS6emwntvn3K3vKUkw17bO9mtmr/8FJ6FhL/2/JEt7Te9W1eF6iNwdyl90xD
	oZu4O1GigTCsgcrxWLAcXOiNwPq72VFjPavG6lnFiCd2yZ4A0T+5n/ROv/iLctJyBVnGzOO79Yn
	v6fZ4NyehtvD0tNQBmgFotM/6ZiVBMpGUrfGu/U6E9fsjXHTJWTj8vDhW215Axszm5MmaULH9tc
	atkwQTIiOQj8JgX8xVEXUgQ2h6JrnEU/igp0uExsJyjkEMN9Ie2hfCz6PUHbABbU3JrtHg2wpqD
	tEMjYqJ5mKPMH8WKKeYA7rAVHVima+Y63dZKRQDg9vzToeKPZF5EiENxIqaXuswf1x2GozvzrJd
	eGKD0x4SRwpKIPH031wdrX0TWbhcgnrPOhiprHV5PRZcGW/KM9DkxZR0fgxzd5HdIVFrojk4THM
	TFEgV/4omd3ZO0AgboYJHaNkPnDC0r
X-Received: by 2002:a05:7300:d70e:b0:2c5:3b87:2fec with SMTP id 5a478bee46e88-2d58ac80366mr281730eec.31.1775765005878;
        Thu, 09 Apr 2026 13:03:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.186.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69casm1388621eec.2.2026.04.09.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:03:25 -0700 (PDT)
Message-ID: <69d8060d.050a0220.53cf0.6c85@mx.google.com>
Date: Thu, 09 Apr 2026 13:03:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3464046568826697859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaoguai0992@gmail.com
Subject: RE: Bluetooth: ISO: validate ISO_END fragments
In-Reply-To: <20260328200938.140528-1-xiaoguai0992@gmail.com>
References: <20260328200938.140528-1-xiaoguai0992@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3464046568826697859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074052

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.44 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.12 seconds
CheckAllWarning               PASS      29.57 seconds
CheckSparse                   PASS      28.25 seconds
BuildKernel32                 PASS      26.17 seconds
TestRunnerSetup               PASS      586.43 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      36.86 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      117.45 seconds
TestRunner_rfcomm-tester      PASS      9.69 seconds
TestRunner_sco-tester         FAIL      14.83 seconds
TestRunner_ioctl-tester       PASS      10.47 seconds
TestRunner_mesh-tester        FAIL      12.56 seconds
TestRunner_smp-tester         PASS      8.83 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
TestRunner_6lowpan-tester     FAIL      8.83 seconds
IncrementalBuild              PENDING   0.35 seconds

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
Read Exp Feature - Success                           Failed       0.117 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga495e056aeee #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001945240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ga495e056aeee #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.668 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga495e056aeee #1 Not tainted
------------------------------------------------------
kworker/0:1/10 is trying to acquire lock:
ffff888002476940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa5e4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/35/checks

---
Regards,
Linux Bluetooth


--===============3464046568826697859==--
