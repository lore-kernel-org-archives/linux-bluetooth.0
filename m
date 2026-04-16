Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690730EF9A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357613; cv=none; b=PhOPJdSfJfsuI0fzkbny4Y/pR83NG4VxglOMsxLK+IU+w9+BXy2HgQJaAjrVwDH6wBLPBYbFmKgsIu6T+sFmiJRsDW9aqAlpLJrmXnzP6d+IaHq0XqEaHKopQFD13D3KkpPNfRg6O6QsBiJHfZH1Tg0cK1jnSrg52hHJtb4EEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357613; c=relaxed/simple;
	bh=6FK1QM/tWFLdlmhisO1KM7PjEgFTHU3/AUdDQzFhEoA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HAgIJDXlr3cpvBSsv/XtAi5ukuM8p5JM9ltkPtk4oT2FmTZemJN1IQ154wL5HBCjIfJdjXFBfhRe5ApU51BAQy29j+XeoJpaYBjqmxQAzvA/0oqY36T8thxaf1XZrJX6GEsT1EO65WN7esa6YwQWj77tjJIVTjCKW0Tew2QpbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmTk95Ar; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmTk95Ar"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50dedb18ea0so42172721cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357610; x=1776962410; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdn4ChNnSh3m6wWVKVNnJ8hiVJumjn+xx9Itiupzh1E=;
        b=qmTk95ArliU+xPygApQ2qO3pQCU0X+HgoBGcriPFxphYplnpXqXvCVZfdsBjgiPybP
         jfIVfj8QmvSfyu76eHxNomI621ltu9Z0Nom9b6U6fv1bkqt8TVGCFppS7XchJXkW+XJE
         RKEFvcPAfyRTZc0nIi2pIG0Wc+hvb6t/HCQnTg27DlQCvAao6c3XnA8uWqMn24arbCJb
         BmWVBY5LiRjVdGIk8BO+SAdlYVrt4+24jrIQZaV4JdZyNxkuif1Ypb+Wx5jpybZ+KmVz
         p6ZcG511N2iZgm51R7kGFfX5hGgYSVPKrkYat/Qs4nmaH6sIWv1PVPGbXfz7r61AGZd6
         NzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357610; x=1776962410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdn4ChNnSh3m6wWVKVNnJ8hiVJumjn+xx9Itiupzh1E=;
        b=QmNaukJM6IYEyiVA7KcXSLhThzvs8fCu2tq1ORwWmTstfjfs5QK3uVil36bcg/NQ89
         6ZbcB1S8PwA1uHgcD7o3pXNaI5AXxEc1mRlShUESYT2AGWLH3ZZ7eF9/biCFbxOLXmaP
         N5eqhTeKFDS/tfaiFj5MxC5FZqeS0VwuPDtrwOYYYc/Su7EKJ5TgKdUjCENvxLL5vQEP
         V9G4ojpebMQDAVdOMJ37iYWlbL5u3GjeDheZ7BwP9ZPAL/v879O6I28br/necaN4ZgnO
         vwYOpPltCG1IIoSM05E6Jf9u15N8Cr/ccQlwfGv2RlZ0y373L75qxqvQdg7/JB9PKzzQ
         tn2g==
X-Gm-Message-State: AOJu0YxiQl0rV8s6bTdDkYcsTlU3TvXTtemAqKWskT/hcG4ltJUC9bVW
	0UbJkhTrzs59+be45Ikobd7Y2kDTV+jfgSxJyBSPd4gtqaQClMxyHzP5Qeemfg==
X-Gm-Gg: AeBDietWYsSTbTe3TA5S4jx0/ZIlbozC/dXKCO0g34IgkceVy/YNk3vwtK2nH4wYD/J
	z3NiWLRvbdk2O6TO66vIm9d2nGCFAHY7nZEqVaUZam1MriE35obs31VuXSACpGTilzW8ZG39Vkq
	lu/fQv0LG6F6AIoEqWfno+sOkDj+d6ZRtI+HhLKExdahYr15FXMOh1l2COLjXy4l34Wdaw7Ucvl
	kRF7IWCy13m1EM/B8iuF+xoUOi0ZHI0ZCmaIjnNWBF7gmPPrccSmLjuAaSCTwTAgX7++pGpI5qV
	ITUxY2Wb3SWnXaJF/6/G80RLHJtZCTe5qwwGvatcoWTA8RcJJSF5WmV88OeBw0Wi+F6rs3f+Eld
	FMlSx34fIUxa9H3rdQVUE1o+kDL7dOEWocwFXdBmBeoSjJjj+jDu49ZRoeJFoIga1QrJDhYtTwk
	+ew4NE6uDUrZXZzUQkWMPEXdQO6ta+rIt6r8A9naQ9Ig==
X-Received: by 2002:a05:622a:aa49:10b0:50d:aa29:2b67 with SMTP id d75a77b69052e-50dd5d11558mr328613701cf.49.1776357610070;
        Thu, 16 Apr 2026 09:40:10 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afebd48sm41284661cf.26.2026.04.16.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:39:52 -0700 (PDT)
Message-ID: <69e110d8.c80a0220.2efe25.ed02@mx.google.com>
Date: Thu, 16 Apr 2026 09:39:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6333799468037883937=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, conorkotwasinski2024@u.northwestern.edu
Subject: RE: sysfs: return -ENOENT from move/rename when kobj->sd is NULL
In-Reply-To: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
References: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6333799468037883937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082102

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 FAIL      0.11 seconds
BuildKernel                   PASS      24.72 seconds
CheckAllWarning               PASS      27.23 seconds
CheckSparse                   PASS      26.09 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      517.22 seconds
TestRunner_l2cap-tester       PASS      27.33 seconds
TestRunner_iso-tester         PASS      45.68 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      111.08 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      13.81 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      11.21 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.56 seconds
TestRunner_6lowpan-tester     FAIL      8.38 seconds
IncrementalBuild              PASS      23.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
sysfs: return -ENOENT from move/rename when kobj->sd is NULL
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#136: 
Reported-by: syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com


WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14527101.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gfc81722c1c6d #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff88800207e240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gfc81722c1c6d #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.895 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gfc81722c1c6d #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff888002754140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffade4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/94

---
Regards,
Linux Bluetooth


--===============6333799468037883937==--
