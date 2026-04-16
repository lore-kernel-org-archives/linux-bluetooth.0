Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0702F7AAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357603; cv=none; b=SISB3feF52ga2e5QnHbcPnjmgCb/1e0TiZ3dQTbcT6syfGs8jD6r2ZB6xgZMPf3CAeoqyaH92lom0gWzWapFmFiQdG6+8+EsGwmDD1MTBIgK05LPgJKu/a8+z1TxJM5MwKRGWBKNvcneAtAZ7H+ql3nkFSjCXPmsJTtt/ttbboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357603; c=relaxed/simple;
	bh=xcnOfae65YY0DJVxgBeSssuQjH2nNg0+gNA5qKPJMHw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aGiScYuo93evp9ViA2fvlaUfkH+CLzeK52lGnbYx/U4AWXz8kQQddA5QTkrEc7TO3TRefH0VWjqCXT3DJufKtk5vRVjlIKFbEBaJSE+0rhQkmKE9cIKMcwco1CkdkiNHpuKtXhwVu4beEZlD1WLk4doiHFvGgMFV64NwPAKGdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JViKXXWG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JViKXXWG"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso617358485a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357600; x=1776962400; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+gXkPkTNChovKmMRav3G6vWS/lpeIOB6lub6tHJ+5Ak=;
        b=JViKXXWGRu1jU1AVlV0QojEiMyJ5DwCTCSrJ/Zbf32fuPNNpKf42kkOXt11kYj80RZ
         /y9ruLVbRLLUaymmtyEymfQEOhAgqb0lsqo2luQEYcaQ6ge8hY30DdfDB9IoWT/wBZ6/
         Vt2mMf5mnLibLIhIHpzITtgQXb6dSBqdJn2HmHqQ2Eqcdu1bLAQSzCyrSEsPsgX/v3Ie
         fWan7zS0vMt8D4BiRYnC3bBNqiyLv2IyYBcCZJD1gnAiA/uUBKU8F4iyqJCkCg7s7oDb
         830SeNtTwSYaSUkXriqGpeQ+RAMh5UEhV20LC6nFV1B55xkn+6NmoS7O32wnRpfdcXQq
         bstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357600; x=1776962400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gXkPkTNChovKmMRav3G6vWS/lpeIOB6lub6tHJ+5Ak=;
        b=GN9SBjXVutv5d0OKg+b0cJR0hgQMMYWFjdkCjIj4/IDVWSo6O110rdXHIUpfXUY7T/
         NUhtqT4XTH2D4YHCPcDcjhcKINt+QzkEIyBKHlOXufq5d1jGzDqeM5EGSebJedePauJa
         Px1HGqzCLBDlmb5eTy1kxf3rH+HUaYQpoQgn/Qj0V63BLEY/Wyz1zHzsuDzPw548OhJ1
         qKrpJaZHUebAfrTgvb1//wGUN49/UGY2gsToGVAMsViwJbeubLtmeYl3YqSx3ty6PHC0
         dmd55tPQIekhyQD3MLbdrgmn/fm3kaTc2ABrKPDaWLeb2KFbMww5wYHQObcLbFXKS9kB
         cX9A==
X-Gm-Message-State: AOJu0YyHeO3cicmgtW5Fv8hlYM0dHTHqt2S+x4fDtwXBBnrNd9GRAX1Z
	jIcoab1x1X+UmgpEA42J23iHPwkKkhNGZz7e5mQTnjSNkCADMSDzfBRfN/S8+w==
X-Gm-Gg: AeBDiesuXqiOIYRI6OVeyItIDPt8KlHZboH67TSdJLHKHcSJPc0RyVo6j2Op3E/VUdK
	pcomwvLhHbmxhhYfIaU/8FmEJvP0KPbnh3J0zDl9bQUrwOvxfNZX2ouxM+0mFaBI71NYrmKrl1h
	xHDgVY7jVfrPPecnycP9cLkGJ2OudZdSSJ/KdGxb+eClRNYDleCUW6+d9WycfoLwHDxXRvpXdS2
	93+WBUzc4EnTZBNsEoQzCLZivMlI4i7NX7yEZpGNGQ+0Q796edOMjVmagWMcO5z6hPaCh1wgZOk
	UJ1Sfy3fgE6V2vtHMdYJ4QkPxEu1FwEAAD2r+ym9WOrrpqSQwArh61ferOnZxZ/SBItutYh+TQ9
	uiLhsf9P44oFhXhL570VuTjuYN8OF8YNzAgicLi0QdOvKjy7zkfuhEBolch4CCFNBNvh88epWQh
	jg2VGP5d1qY8oLWdU3yJu40CGXjT/Q+Qv1LLIjCaS2HA==
X-Received: by 2002:a05:620a:1724:b0:8d7:a2b3:3aab with SMTP id af79cd13be357-8e74c593c8dmr5580285a.58.1776357600362;
        Thu, 16 Apr 2026 09:40:00 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33afc7sm409344085a.18.2026.04.16.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:39:52 -0700 (PDT)
Message-ID: <69e110d8.050a0220.283f56.6e42@mx.google.com>
Date: Thu, 16 Apr 2026 09:39:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4845294341505339350=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, venkat88@linux.ibm.com
Subject: RE: Bluetooth: btintel_pcie: Add ACPI dependency
In-Reply-To: <20260416152803.54396-1-venkat88@linux.ibm.com>
References: <20260416152803.54396-1-venkat88@linux.ibm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4845294341505339350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082108

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       FAIL      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.68 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   PASS      28.15 seconds
BuildKernel32                 PASS      25.74 seconds
TestRunnerSetup               PASS      572.30 seconds
TestRunner_l2cap-tester       PASS      27.89 seconds
TestRunner_iso-tester         PASS      42.05 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        FAIL      113.32 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.79 seconds
TestRunner_mesh-tester        FAIL      12.21 seconds
TestRunner_smp-tester         PASS      9.06 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
TestRunner_6lowpan-tester     FAIL      8.45 seconds
IncrementalBuild              PASS      27.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btintel_pcie: Add ACPI dependency

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (87>80): "Closes: https://lore.kernel.org/all/ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com/"
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
7.0.0-rc2-gbc0ec6b0810f #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f7220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gbc0ec6b0810f #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.694 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gbc0ec6b0810f #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8a84d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/95

---
Regards,
Linux Bluetooth


--===============4845294341505339350==--
