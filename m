Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278024CEEA
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206144; cv=none; b=jKEYqBOwVOwNH2ZKsKyLbi5U5UqmWJ4hpw9zp7y/KehjoDN/6COheaYDqMBYXD9FbKeGQpDaxVlbFlWzZ5+zi7rs/KhHs2xQhSFAUI2xndcm5+OvNBkffoCdL6g2BiAVvbB9pZwOWjXLmDLz5LdFnsBLHEoB+LvgDqEIwg5bgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206144; c=relaxed/simple;
	bh=jzwX1hKeT+Mn77aSH0yzc+mUTXYUmjKOrWpElRY3W2E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mAOPs5CEp7lfmNAFDWnyhjaxFx2x0hVsRnbjjVYLJld7CpJzOPLvf/B9s3cJXaMVq091/cBTzXVBAPb+JvLD5QI1NGTkh5cwDyO7HhX7D2ckONczkEd67JviN+wZkB/3MC51Z52wyYJK6g8rVKoqiijUqKtygy/dWY7vq/jhprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVbM/5Ov; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVbM/5Ov"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca0469204so32992886d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776206141; x=1776810941; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf8fQMH42W+xqk9l1Si4N5O3K1z+4ARx+pgD1a9ohlQ=;
        b=AVbM/5OvXQgXZtho4gG0AU6tZcbuHcnQAA2fpiErlKMDm8Vdzw23vpfwTineA2INkD
         +vUkva8B73XWExWLT8V43DW0kDZS9v38cCB0vQDCauISjmCNSjUoYEPfrNGYTze1+kr1
         xUtePTP2KXrBVZE5UxaTYzaByt5FTmu56Otq50s1x4zsRiY11DsmQjBkJ9/B9wmtU3ub
         UlwArsw470xsn6cDFlHu74vaLx9T3bMXEJ5Q7Q68m/ZwgNIBP0NgKncNf9SOoTyVZgAo
         4vMnT1+yE5/Z8JYiFdeTVAtLvK2kCuIXHnwCnZagJt5pGywmL8NnEp/ruOvXj86QrU4z
         gXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206141; x=1776810941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf8fQMH42W+xqk9l1Si4N5O3K1z+4ARx+pgD1a9ohlQ=;
        b=TB3MoAtTlx5pXGCfxrZio1Z9XjmrZGPKqF1jkugYyGMf0muIczRje7XmrLVNFbz/43
         nGmMGARPgT2AamYinDz20N0eN3U2xBtsoK0qVRLMcm97PKFjaIjPJWiB6/geDd9dS2RA
         1bSYGSThoidgAgj/AXVSOW1ccdKCVsauQqGb0xnf6USnVb4rAb93OCwLSZeXUNp0+6WE
         vMDOFnI3NPymyB1VPb4WkW+Zd+06KgIvSWEMowPv9kpJKEh7NdJRVhYtGg6OhevuxURl
         qNQ5gJq9WEbucWrjrkCyCSr9NSR/6Za6PR3eJSp5H85+2YvLFaSUkLd8lE4kd7bx2pGu
         5pxQ==
X-Gm-Message-State: AOJu0YyLg+7Bwt10xNQR54KTrN0TKGo300cCRevNsgttig+sT8fpMVj7
	zG3VippceSYuxP5zjDerTzLZ64zpNIkYSnPXjDoJLwXuRSQLHFf/MEOT7xGbJQ==
X-Gm-Gg: AeBDiesGhjoJjnDN7bZgGurjTGrwklrzQBSPpFZ/pGf6GEW9wjjd9MKbe9ynn6V+YlD
	8FEuxDOEY0UlfbqbsZeVn9XhkpLXZ+IaOe3VI9Bfw6IuIU1e/OypReuCIYARGLHwJn77S9P2lRn
	9QtuXE5ZGyQ791fo+4+4CxvXKMYBgVd0bsfB+YryCn0i8iwYa9GmWocuIQtinrYHH5xcxxvmJy2
	E/X0zX2hesgaaqIBzXq8r1OV1qCCwEPHqVWvN7oeMw7kVMqwr/oXjI00mB1RoqCNLsEd3d7tIwX
	lJi03GV6UqAbY1oFNlNiCep05Eie1LTP6CbyUBRjBpayn+PXtWGD0j2bYiH8p19LTT6gGYqPnVC
	ajCQwhoV7XmU/o1Z0c8sI8CEgoqvYJ0cFaNTcuSb5vUZ+KQl9EB3QycKrAxL30jd9jIP0i2rD0m
	a5k6HLRCNV0Qs0YukaseUdC0fIYoa8uClVH3n3d+c=
X-Received: by 2002:ad4:4ea3:0:b0:8aa:a025:78e3 with SMTP id 6a1803df08f44-8ac8613a0d8mr319734296d6.6.1776206141312;
        Tue, 14 Apr 2026 15:35:41 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e2891sm167852536d6.5.2026.04.14.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:35:40 -0700 (PDT)
Message-ID: <69dec13c.050a0220.37dada.2fff@mx.google.com>
Date: Tue, 14 Apr 2026 15:35:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3041066954435566932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v5] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
In-Reply-To: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com>
References: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3041066954435566932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081298

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.79 seconds
CheckAllWarning               PASS      28.07 seconds
CheckSparse                   PASS      27.00 seconds
BuildKernel32                 PASS      24.89 seconds
TestRunnerSetup               PASS      558.96 seconds
TestRunner_l2cap-tester       PASS      27.81 seconds
TestRunner_iso-tester         PASS      38.85 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      111.87 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         FAIL      13.93 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
TestRunner_6lowpan-tester     FAIL      8.43 seconds
IncrementalBuild              PASS      23.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v5] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion"
47: B2 Line has trailing whitespace: " "
53: B2 Line has trailing whitespace: " "
60: B2 Line has trailing whitespace: " "
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
7.0.0-rc2-g2d47e6ef8f27 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880023a3240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002141c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g2d47e6ef8f27 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.092 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2d47e6ef8f27 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002482940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffba44d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6a07/0x88a0
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


https://github.com/bluez/bluetooth-next/pull/84

---
Regards,
Linux Bluetooth


--===============3041066954435566932==--
