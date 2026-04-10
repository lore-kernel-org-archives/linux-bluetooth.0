Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A65CA4E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852235; cv=none; b=cnb8HBnacSToNo0y1JgHOBargVA85EH3jCVai94o7UlV95KNnmPQp7KRjgvQbfoyJpu1DvVJzZb7JCm3TOyaQGSqHQfnqE52ACbrgreZgxSZRqKM/0Y9Fo/DG2ilvtKWHFTa09qnf9zvRBI2MO99t5AM/D8VvzOBrwIU2xfYuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852235; c=relaxed/simple;
	bh=DKmLKlxaRvDVcH/NsaiIYYz4Kx1odQrbXATWk+KgENg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l6gtbe6y/vTkxQpm0Bu4iW0sQfc2gG2FCO1+V9DwdHZL6zTesuNpdiJsBe6RklDAgyi2D5q9m64x6KjhwpW6RfJATmIpXC0xIX2AI9R7M0G4VAjtjXl1Ry3eZLDQ6fKhXFw2UzX+IQwApfFAGxc4Ce1JTgOKInRiuSj5dyjd90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9n9zACI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9n9zACI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfdac74050so255418785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775852233; x=1776457033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d16uMrKm31+oguuBP3++bh2QikrJb2SN2nXkWiPtUik=;
        b=i9n9zACImcPvwL0Mx89+KGwh609KQU0rNzSyFG/xguGEgl+GGaKyQTnt5MaycQjGjl
         KWdPwNJ7oAUNXzjOTErVcEAe8CexA/ey8j1cFL2sEjhbMW7m2ugiPBPFB9kxCJ6QOS2b
         4iiPOw5xsEGWhb0k014j4/H8MzIddH6OGIJagmKkBdOWX0Qc0jjLKfQkO1w5tIkNB4Uv
         m78sOFCP/bDl9xF0m2hl5h7eCd0Ntjy6Cz5QWSHS99xMv8XpGpQPu1QnMD1Urn3h1w89
         M/MN54PhPmWWqxsfoWgfYLZHlb3NGFXNG2S1pQT+67V4/eLPT9ze1sotz1F2YzDJQ3UZ
         ueJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775852233; x=1776457033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d16uMrKm31+oguuBP3++bh2QikrJb2SN2nXkWiPtUik=;
        b=FVGRSXmld3AohZstuoOa4iLIdbFIT3YhCKejaz/AvSVEPMn/jLoVi2LN73WoiWY1w0
         h25Eid7w3hASov64lzOnnxmImvlPtYcZlxTOQgYPdxhLXFF17P1wX1YXBwFgwt07k1fh
         3PMWZk9LIXTM1VFfQDM8h3aCjcKAgh1VYh9RZxjINc09tEaII6u7aDYCziCs4l3iTePP
         6Nt1lUaXWXE6sjltQ3CTIgmTqwLsQakBNBPG0Pl5Uhfi25nFKnlDp5/oQWWY4PaElshJ
         5g3vIsP3R9LOyvnGCuNwzMiyTl/l47C59ZKi20uuiTeVwBSKsNqPbA2nViHA76IeisKa
         P6sQ==
X-Gm-Message-State: AOJu0YyMV6SnTeF7XT2z+6dB3uiYuvO41klWji8ACeAccwLZhcO4N0s2
	plICvPgFkhbKeoOn6Drd1API8cu2XbPae7J1BAh5gO2rIUgWHHLCfa/qoqRfq4GC
X-Gm-Gg: AeBDiet3mVxdGroJeIrp9KntImn903AbTrJjDnWcWDDIPofzq2TpVzgBI7Kfi0La8Nd
	g41zppgpII7SHExxlbKsnE0CvccEycYAgO55jcT6oLi7GGKH5hVSTPrpzgXAaLORxZCx/l7kr1s
	sPi05gqsZ0kazXyCxQC4vNtwg8vIcsKQWbwFFQEYP/Io0yW4osnLNuFQJfn7fs2CMBRN2IRpvF8
	1zb/a2B3I/ou55BBB4IjWNwiwONBkRRuVztVE8bJmBDlxZLgGAY91DXC1xRnPG5UzCiGLGuInRG
	klEGhSGZ0HfKdAja2BFR0xa+fe4NlliSWXtGY6BRF+q2j4FgUEz//ZpYY4eGse4YFadSuWa/LXO
	Z+3w/5jdxScsi/VwwSpdpdzOGRSE1M9A2EWRUu6NdWC8UTGaUds6Q4J7gKQWZ/3hDpD3q4PYWi4
	swwYI1dryIGgPxyhs8PvKwvcHYCELW
X-Received: by 2002:a05:622a:486:b0:50d:7a9d:f171 with SMTP id d75a77b69052e-50dd5a8313emr73347541cf.7.1775852232976;
        Fri, 10 Apr 2026 13:17:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539c981sm28664411cf.4.2026.04.10.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:17:12 -0700 (PDT)
Message-ID: <69d95ac8.050a0220.151edf.15b8@mx.google.com>
Date: Fri, 10 Apr 2026 13:17:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5194274339105920022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
In-Reply-To: <20260410192952.206735-1-luiz.dentz@gmail.com>
References: <20260410192952.206735-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5194274339105920022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079900

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.76 seconds
CheckAllWarning               PASS      28.18 seconds
CheckSparse                   PASS      26.92 seconds
BuildKernel32                 PASS      25.12 seconds
TestRunnerSetup               PASS      560.04 seconds
TestRunner_l2cap-tester       PASS      27.39 seconds
TestRunner_iso-tester         PASS      39.76 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      116.51 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         FAIL      14.23 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.91 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
TestRunner_6lowpan-tester     FAIL      8.84 seconds
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
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9c83d7d691d1 #1 Not tainted
------------------------------------------------------
kworker/u5:0/115 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 115, name: kworker/u5:0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 115 Comm: kworker/u5:0 Not tainted 7.0.0-rc2-g9c83d7d691d1 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.809 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g9c83d7d691d1 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002760140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb484d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/65

---
Regards,
Linux Bluetooth


--===============5194274339105920022==--
