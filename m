Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B23A8F7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766088; cv=none; b=Qp8yf3i/0yehtyy7hLz74DiJEE/waD6VgIjv1dF1szVWJ4vYhtBSGuERB2gpGKL8G/fkZFK6QtW6x1aaHUDYkChe63eMcfTmvbRss9CJWVNfqKnJB954VXoaQkbOmzCuXzEuhgDZtP8tpluruCpHTemu1Al7hbvKE9FMo+slb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766088; c=relaxed/simple;
	bh=OqTG8Y+vpbFSe6vskq+A9JWFUSMW68FuXYrHuN/QUzI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a9IGoCoiKTTdwgPvjl1+RGI9wCxYE/yf0JlJtWONDkeuRBJDhS/m6WlIpmb1T4KB6dJhPhLljGhoDhmx6KBUWOzIKbbKhp3NiJ22xpaKfjF3RXFFenxzQN27Db92QJ4dZP7RsQRfmYI5WLGWGA+G5loBojLrA0RwoDAsPh7mVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe9JJVgZ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe9JJVgZ"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-68244d317e5so776181eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766086; x=1776370886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uUP1HpqSXiCpPpEzQLgfJ+utxTE93xHT58/jwY5fTZA=;
        b=Fe9JJVgZ9FAOkJ9amu8KEqU5mKk6YMZUHj1fSVKg5TEZJERorPCv1w4jBKj/sriXPT
         piXxCXXM02x3A80Bhx0oVP8JKOkJZVrbPaRb0jOoztytyDYRDtERKW4ktfKvg5A8Hheb
         rfdxXl7cvIf8qHYPewarMSIOBj6rEIddxJoYjIuZdt1pj2dp9UCNDq9OmmfFx+N3SzRA
         b4HsKm1gQgiBcgYpEpUp+f9aWaij5mcbFtwX+Fjh+rxOr97GetVVw1YMrc8VNZPwho8+
         1fuUvbqRxLF7BeYkwDsVW+MEh7l9po931YU35GOy9EVyzCovJC+aJcyxqUF8PF+J7vzE
         riTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766086; x=1776370886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUP1HpqSXiCpPpEzQLgfJ+utxTE93xHT58/jwY5fTZA=;
        b=sduc5XS5G2NnBYIq30/Ae49J3x5BHlkROliWhWOZRVXg8vtsLce3F+iDicLITAarOp
         Aq2SkfUPZNzUEpDk0cPgihcDN0qWApOL2JhL8kmIYakbd7w4K5Zk72GxoXieJJYDv59M
         d6NggFiPxm0sRtk0ISphuwg3jgrKw2GqAz8zbaEIAwZrq+ldXTiljUjUqCifEnYtNzQx
         gZw3O8vzRfIrJ7MeMnPPr+ZyUiOjk1hBId/rVk3WnhYGHgl3epg6bZ0ctmGQo5TOU122
         RUz4hHunqmE506Vww6dhA7D0+iylH64gmVbnuN5XkOWMAdJ1WqYnJOIVHOYMkU34OHT4
         Nw0g==
X-Gm-Message-State: AOJu0Yz0UtWd+cKSH+Z3hXZnOaJJ573xZyO3LxPvmuq0opJbr59OgEZU
	OlyKC01S3NSjdTzRTdDCoNIRXClnnzj62kfVp802Qh+G66aLyzg3Z4/3ozIfNg==
X-Gm-Gg: AeBDievf7jZU8oPIi4krWEK8nHwvavHpZL0KgM0SfLVqVGyHCLF4PVCop64ZYM6fthh
	Iidzr+k9dSHcfsnblFhyT3vOMdBNeWP9WRAMztoc57TLV7lNfAMkpxTT1lHKsyxVuiMoHeWldqM
	KTlxzJi3EIiDE1RET8LN75+WhDSGN963M0R1X1fhDsQ7MsuIs4eGnzPReIGz/nRk/YTtgqqHWBw
	KleGW+Vh03UgDpvb4AxbGGwbwSz5wDenTgu3rMTnrkGbt32deWE2mQPg22sJXWKw2W4fVfV+FIy
	1uVrWaTaR2ZNOT0NXTJgGVGObzatKXEFBMolQdgcSJZrQ5J2EdLMV2Zr1qdhzSaWpRcoIRUWskE
	q1HieQFatBN5jQydWHHZFwuW5zcMqjCB5npJ6HX1lgn1ubetzDhKAvm8EtCbwJOoMU4ieKuvm4t
	nkXwwbhLt8AiQwXfKdmvLINFfkihvYRmA=
X-Received: by 2002:a05:6820:a284:20b0:68a:c014:5c6b with SMTP id 006d021491bc7-68be7ee7f5amr205610eaf.43.1775766086137;
        Thu, 09 Apr 2026 13:21:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.213.177])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc88c80a7sm342235eaf.8.2026.04.09.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:21:25 -0700 (PDT)
Message-ID: <69d80a45.050a0220.237129.bf4e@mx.google.com>
Date: Thu, 09 Apr 2026 13:21:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8641010108128311417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan.c.rebello@gmail.com
Subject: RE: [v3] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
In-Reply-To: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
References: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8641010108128311417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074833

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.89 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      27.06 seconds
BuildKernel32                 PASS      25.06 seconds
TestRunnerSetup               PASS      561.18 seconds
TestRunner_l2cap-tester       PASS      27.27 seconds
TestRunner_iso-tester         PASS      39.10 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      114.28 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.23 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.51 seconds
TestRunner_6lowpan-tester     FAIL      8.52 seconds
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
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6320f7500a9b #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002365240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g6320f7500a9b #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.855 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6320f7500a9b #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e4940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9344d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/38/checks

---
Regards,
Linux Bluetooth


--===============8641010108128311417==--
