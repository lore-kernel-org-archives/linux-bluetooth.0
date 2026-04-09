Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2133B970
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766032; cv=none; b=uETNkuOzeOug7Fd6h+tGwwF6AJ4k5uIM1MDA2knx80KTTVYY7xSvVYylBP5LfZQKNEyAZhvbV9EmYzgWDoDUZSRoQOhu93Aw3bxvyID5PZulPoL0XGCNKjkTq2RWreJ9ImVNqXsUJd1l+YaKefYB2GLDxDj3aIz7eJf5YK4iAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766032; c=relaxed/simple;
	bh=iojUXoKRIQIrWbVHMIIr9xt3ps3tMDrmVLkerFmjDDc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Oi5GDeCe0WH1hjkKUkxv9UpQnpgKVhNgNSc3g+10wh4fAB/Yf0g6ZLPrpW0SFpt0Sw0bjZYJ08zmK5EC76xxMMZmXW5jErgczGjrwpcR5BClK40TE872mUkTRsYTWTzsbZwrl0OGvP4u3kvTGBQ6OsufGhnNvBLK6JBWnOvGRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJAWDhMD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJAWDhMD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d67a483d3eso134280985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766029; x=1776370829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bSdONkMeYBMDMEnON25ZqVAmnYujB5S17BgXFadXeK0=;
        b=XJAWDhMD9zLbskalN7EzZdkpYalBMRZGjJz2nmXOeHi/sWSlP/RoHwHAg0JxvCO9Xj
         BonG5VYa53gq6lKJiJ61tps2eedRXgGX/hK4UA6wNGfCpC52oK9BPmisX1vhaaGiwmjt
         5TXNhjUFMAyk1Zfccq//Mzxw7ANhvSdkYDqlKGCuKmoDMW1tJ8vgr2dArQsIYiZfvfsC
         VKSyevJUF1TMwm7HuhlnOJaRfHjLMteKe3H+1+AJoYva3z8ZbPLuRfkQFBLYxLWKNV83
         xw8a1Sqwf3Q1nqSFt+Cv50Rf9Xn2hnUWg8BM0Fy5JVktvCgdwoLYNqnzKg+msQMAwG85
         Lcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766029; x=1776370829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSdONkMeYBMDMEnON25ZqVAmnYujB5S17BgXFadXeK0=;
        b=JBBanPsyiOk3Lrf56/APbbbqUeEd9Ru3Id9eciSCV38F1kZDOcy4Cq1vGRgxlc9TQr
         2WcxugLP1+GbJk57EH1SWPKmbCy3IPn+LyhGY36ZzrbyKxLVKGvJUUmpqLZQqjqjb9R4
         6i5hmTd/rUKnBOZd4WAW77t+eNuQPKaLXQl7PQsSf8RM6OwUulMwgWidqgJ7argM22KN
         Ovff8AiRn3hURGWMY+ULZhvhkGEJtTwH1LiiLaffLlclxlBtjZT6TBZqd4kntsPnDSx5
         qYIP/6l04V4S0tM/VTQYlewRBsFvNCuoWY5XOogvSWvog7eA7Vi0oMJQJV7w8/nQgQWN
         XNWA==
X-Gm-Message-State: AOJu0YwYx5MsH9DsA49nykVqwBsCr7BLkzQfXqY8IZ6YoMhjPBpZ1ysA
	CNzZRN95xabfvoYZPcR/vnM7I7T3LkfprY5ktN664sFVMvGKXihdzG+HIMhFgw==
X-Gm-Gg: AeBDieu3iMTsQepcHiOvURZ0D5atVjyAqPDYdMPHCITnWrz5UxtoB20l404Hdp3JNxC
	3jOWu2sGRu7KrwIlZ6s/7y5V7qg3T7aYkrwcI17XdBlOAiL0th5wB5ZDSIHI2+xpI7BWG1h4i4/
	Pu+DNwCDZXR5ctmx5MV13Kd85pQXzD6LoYy5SucJZngLRIm4dZzDixQxWremuDdNfcPf25sqPuz
	+2cjK0NOSSMY3Dn5pR209J91NFhE7fJuXp91OwZNUSKRLsfwwfvomHoCRZol/4oX0F5ovWA/3qe
	+BvHzXoe9I+5MfoVW3F1q5JS85jzgEfUyo/43vr+doQyyigwOtQA8wNMiyjdLFl8Ru3nXDC7ID3
	IAfZZulGSql6q46OFezGT4dNqjrQpxBOAYSJXsoEG6M6sDuwSjWILwLERQ0552o3ai0n0YiKxMe
	H8G5SKkLz1AvU8Ca55CjfzjT4bHPVg8dKk
X-Received: by 2002:a05:620a:2901:b0:8d6:39c0:e6b6 with SMTP id af79cd13be357-8ddd078bea4mr43588885a.64.1775766028982;
        Thu, 09 Apr 2026 13:20:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.118.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb646ddd8sm36637585a.18.2026.04.09.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:20:28 -0700 (PDT)
Message-ID: <69d80a0c.050a0220.133026.2837@mx.google.com>
Date: Thu, 09 Apr 2026 13:20:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7126192504187349238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuvampandey1@gmail.com
Subject: RE: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers
In-Reply-To: <177567405034.77733.13793767420759611909@gmail.com>
References: <177567405034.77733.13793767420759611909@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7126192504187349238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.90 seconds
CheckAllWarning               PASS      27.17 seconds
CheckSparse                   PASS      26.39 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      517.50 seconds
TestRunner_l2cap-tester       PASS      29.54 seconds
TestRunner_iso-tester         PASS      40.79 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      113.79 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.19 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      9.65 seconds
TestRunner_6lowpan-tester     FAIL      8.59 seconds
IncrementalBuild              PENDING   0.29 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2db23f73a0dd #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g2db23f73a0dd #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.886 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g2db23f73a0dd #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9a24d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/55/checks

---
Regards,
Linux Bluetooth


--===============7126192504187349238==--
