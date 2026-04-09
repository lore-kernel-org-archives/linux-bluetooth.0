Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D31332EAC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765991; cv=none; b=gw5AnsMJ4s0wSO5F0Lf+3ertqgJ0mmQBG9qrxv832+UekazbuQBCPJfiZagXiGiUZc851pzRlKhafY+Ugo3hCm7E7IoSLKeSFLmvytY0GRNe7TspGKkkBG0nYZaSh9a89Zi1Die/TUnP2m+/BRZRoKv6/3JoDPPT9oU59czO0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765991; c=relaxed/simple;
	bh=Xvw58RNp+AWKxrBFZ/UEnv72iCj78E8Au8uGqx42K2c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MycoQ6axRKBydp/IIUxc46xKL3ml3j331fTKYkzQ23FDYdUbUlgFu7TkaXiSgqONCKSGYnbEB3caAF/S3vMhVLlZvfDPqUEmEcyZC7CGM7luWGAfa6kFl2Utsv7Gng5wKyWCDAl+DWBwA+c6ir+wgo1e5ws8GSjXnZMNLEX4sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/Vhd/AQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/Vhd/AQ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d736211595so95456385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775765988; x=1776370788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbyju4NaP1w+0muPyRPKjcb6HeO3E+EQgW13SUOOZkI=;
        b=m/Vhd/AQbD0kVsvBWpCTQXJ5nMFUN4MxQ+Sta6FfHU9QNZFo4XVhleTFkeSPYEsDCc
         XFl8vIZBK1bnt2J04D36HtTQC3kvw4jvmAS7cKfh1nSye8y+utGECX1/U5mXBV1dySfT
         XS+5QNzgHNtkGNXYEGTBk/hnQn1qMXwFG8p/6ydz3OTlBDDYl9f3DxxYztzYIAqLIpwE
         AWcU9tkaldC4Exwhc1Ux9aCmJbhQgH6/Bmsk+FbsYA2IvBp2XJz5zoUOnu9GErzPyv8d
         HmEslffUxhMU/3FpcfOJEv6gXym9k8z+DCM4qQceQGySOAC158BCg4c4YWhNILi49igK
         YcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765988; x=1776370788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbyju4NaP1w+0muPyRPKjcb6HeO3E+EQgW13SUOOZkI=;
        b=h6gw5Vy+jgMMRmawzinLGt4FnBO4al05jaIMX/FovdRKoDeqV4+s3aByjbH51as6R6
         x4dc7EcJxxvwlcYY8+1+vAztxHpS1uNcTSplTQJBWce7gF5r6x1qM2fwtb1F/8k7pqDs
         RplTCXvoMANO4VRARxjpF9/tVyn5TKPSpSsgmo2hjVAdowF5uLIBMNj0Mpo9HqJJxdTb
         IyUhNZ5b6T5flBkfCYyNXW3brJ0cui8AOQaUFmhQB51vGxGhTfJEv3Tl15M1BUetTepX
         igJCMQixPC9AG0/bQkZaZY2pQAH7Huf8fIiF9nqIHoVKck7t6VO/T/UR1iT7MAjM4DE0
         mWRg==
X-Gm-Message-State: AOJu0YwfAlaqAq/MqDQepCrPZDy460iPdT+JwVaplGXZm+eYv5DTdLCC
	MRgBszIardAcjcRgAtHqMGp6mkten7O4Xhwmme04CktMb17729iBNgQf2Pq+oJQs
X-Gm-Gg: AeBDiesbuf+3ykerU5rqWbheqRfkNaf4QNYIe4JFDEYb12v+BQVqhg+o3rJieNCTf9Q
	FU+uq49wXbNtpusjTi9wutNiTOfrlbmjufgO/1EKQMs4dgsp87FWIR2kKfWI8z37vTwhXUo4fiZ
	JrcWEaY9u2YDTz16Whse2dbUFWUGhNNiZryr3PZBy9P+ea60pU5c6jzeywqJEb5mQ1V5+/fKRM2
	rzMHAx7diVGB020LSzsd8NLB92jP89cbV7zWxJD+3/wKZ7wXrwqW7cdGtVOCZz9p+Cz4hi++s8z
	J4e9Ckd+HlGFUtE+mdE4clM33kerg93FGhUSfZSmRcEz0PsBHykHwYEnq22b1BNF6m9mjPPf2MN
	Qx7yP9aE3yhxwH0fGGa3bZhJ9ycyUSVzC+CPr3zaIFhXJ1kszWfAoUQiMt7b9ivwODS+zvMxMJH
	HhWUiQtog6BJhOcKPtUTrH2D72yWm9bsBvzlxhudh2
X-Received: by 2002:a05:620a:6914:b0:8cf:c63c:b974 with SMTP id af79cd13be357-8ddce0d1433mr50910685a.26.1775765988318;
        Thu, 09 Apr 2026 13:19:48 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.117.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6b859sm34600285a.22.2026.04.09.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:19:47 -0700 (PDT)
Message-ID: <69d809e3.050a0220.a3b32.deaf@mx.google.com>
Date: Thu, 09 Apr 2026 13:19:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2005179111921709437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie:Support Product level reset.
In-Reply-To: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
References: <20260330063842.1121545-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2005179111921709437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074376

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.96 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   PASS      26.00 seconds
BuildKernel32                 PASS      24.34 seconds
TestRunnerSetup               PASS      527.21 seconds
TestRunner_l2cap-tester       FAIL      28.29 seconds
TestRunner_iso-tester         PASS      38.27 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        FAIL      114.21 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.43 seconds
TestRunner_mesh-tester        FAIL      12.62 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
TestRunner_6lowpan-tester     PASS      8.99 seconds
IncrementalBuild              PENDING   0.23 seconds

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
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.116 seconds
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
7.0.0-rc2-gdb8a83754e8b #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002090c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gdb8a83754e8b #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.705 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/37/checks

---
Regards,
Linux Bluetooth


--===============2005179111921709437==--
