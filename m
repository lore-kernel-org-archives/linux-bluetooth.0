Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A330EF6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124363; cv=none; b=JYegcPsXfuCu1lB53aGZ/JnaKyij3CpPM03mTpqVUWsr38bQG+FYMTys457mPe56FW92Dg5erKFe7GbdLaqsb0Gk7qhVmqvIeyjxO8xMTg1N6AlP5NJp88LliY8HJXvBDYntJZ+JZIVlp3ksF1HPtkGskVIwi3F3ttFTOPSOFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124363; c=relaxed/simple;
	bh=FD3YKlGvCQyCwYEn8QT8ea3cOMrhR0Cf1Jds2Rx/Nz4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VU7tiaPuVskgICKKzMkqva1Lg0xSnuCiMDfZo9Ek5D1c0SgYvaOsofnvYpGWkotrabP2UTtTcE+t/K6SiQmhwhEyXZSl8m7squxVsADfpIKZ6Wce1604nhsNHlLSgc6qjt0SgmRcl2EqYKoB8jobpQkz4MKNXX35Qrv8SEbZB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijm3jqEc; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijm3jqEc"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2dbb4ad19a5so639886eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 16:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776124360; x=1776729160; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b7xXU4DhQhKUxnPFRHcyTKueqwLZt8aYWAhIua9QCfc=;
        b=ijm3jqEcf7XOYD3Payn+OD4IBhGLIdB19DGbeeErb4K3ABfRDTO6ixfVfamX6aT8hR
         dKNoazP9Kheh6MGe2yYruK39xAM736t4AIugm8Jt5/OzmHZPUcCMkDc6LJnhp4nlzRkn
         7D6fb0mzsJANBJqioolQOS3e3WM2nXKIpUYVqza0YKslszlytBA41ukYpkqiDA+dJBlJ
         kTG5a4pbKpP2u6gU/Oivv9RMGlxRFKv7a5KKjvsnXSpmbgaFtTZIKBYnddnT7+7u9UoF
         zZ/s97xoPfMsuMZoCSCoy7Q1VMy0b4cMFbxCPf26rWbr2zJkOcRQLnDopu3nC77cclFT
         QWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124360; x=1776729160;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7xXU4DhQhKUxnPFRHcyTKueqwLZt8aYWAhIua9QCfc=;
        b=kV92jw6wMZ7vECud8ri0xOp9865aeuR+EHlLThCtMAiIOm73KejJv9t5tIPHJnLIhq
         FicZag1boWmnR0x/fLxaZxvsTUCPvEHUOkT69vKzIaaqObpBdPoz03o3aaxp7gQTjAWN
         3Q4lSYanrI5j44LXWwQAauMVIUSx/sAhRtodee6s92LAXAlzfp/EC/pKIxJSIxwZ5NWP
         nWqjVUfhQvda5bNOpgz6VxJx56ewRMT1X1BNSheACBp7YwjFYOxD/YpBe7DqSWiaW2x3
         G53t1Gu+i8F+m1VkXXueL4FFwDVPsM3RqjWoGu74iroPpjzZQXj+E87wzENfJWlpfio8
         UDTA==
X-Gm-Message-State: AOJu0YxEUY3aPjaHYpIWGa0CZ/UkP+Jydt9G3ODe4/dhFi8bjWiFVXrn
	ep523ZmSTnZdK6GNl2CcAh0gQYCLWQVhYZ83rlXPXRYuItVMmQNP/u8zwQMRIA==
X-Gm-Gg: AeBDiesecCtqbca2KPNi0kLOgctOzxoPBheZo0IR8MPmNZXGkx8NahVL2TZiK08Ic7U
	JbG6UJHXU+2VlzX76Xc8puB5q8+MlfC+KiQ9JEQ/CCm9T62gBapo3bkIll8qTmrnnDqO41/mhDQ
	Y8QFOaaoD+hHul0PaINfKc7iRfJnXZ55r9Cy3D1XroXul3My2i8UIRY/GHyx0mZx3L/sqHD+5IC
	vaLjgIfVxht/qSiGjuomrhy+LdZ58sDrcPeM//N2zRasmfxnviFiCYDe37F00y81/mR6bBe70o0
	Nuon5vNW0mdPkCBkFqERuA2sbAgkSJiXCaKWIMkCKC4XMd9QVQbOPDCu5X+zIxoYabCXBofuwod
	Zv+cT+GcJ0SD4wCdyBYN/oEtMejBrqxfyXJO1NYwU+SXhoJjDHLl3+CXQu5nYmtPeP8bb+b8gNn
	HxWb3zGFhQ6AH3HVppb11aUrFedYGdIHKjr27zzI6Zcp0=
X-Received: by 2002:a05:7300:d70e:b0:2cb:de38:c76d with SMTP id 5a478bee46e88-2d58a39c931mr8783043eec.30.1776124360157;
        Mon, 13 Apr 2026 16:52:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa42dasm18921717eec.7.2026.04.13.16.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:52:39 -0700 (PDT)
Message-ID: <69dd81c7.050a0220.11b73b.2aad@mx.google.com>
Date: Mon, 13 Apr 2026 16:52:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2067794660146529664=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v3] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
In-Reply-To: <20260413230813.21393-1-mikhail.v.gavrilov@gmail.com>
References: <20260413230813.21393-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2067794660146529664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080906

---Test result---

Test Summary:
CheckPatch                    FAIL      1.25 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      33.68 seconds
CheckSparse                   PASS      28.46 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      575.60 seconds
TestRunner_l2cap-tester       PASS      28.18 seconds
TestRunner_iso-tester         PASS      36.67 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.28 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.08 seconds
TestRunner_ioctl-tester       PASS      10.36 seconds
TestRunner_mesh-tester        FAIL      12.22 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
TestRunner_6lowpan-tester     FAIL      8.48 seconds
IncrementalBuild              FAIL      1.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
CHECK: Alignment should match open parenthesis
#229: FILE: net/bluetooth/hci_conn.c:518:
+static void le_conn_update_complete(struct hci_dev *hdev, void *data,
+					int err)

ERROR: code indent should use tabs where possible
#237: FILE: net/bluetooth/hci_conn.c:524:
+^I^I        u16 to_multiplier)$

CHECK: Alignment should match open parenthesis
#237: FILE: net/bluetooth/hci_conn.c:524:
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+		        u16 to_multiplier)

WARNING: Prefer kmalloc_obj over kmalloc with sizeof
#242: FILE: net/bluetooth/hci_conn.c:528:
+	d = kmalloc(sizeof(*d), GFP_KERNEL);

total: 1 errors, 1 warnings, 2 checks, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/patch/14523623.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v3] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion"
44: B2 Line has trailing whitespace: " "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gea668f64ba2a #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff8880021b6240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025f8220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gea668f64ba2a #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.640 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gea668f64ba2a #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8fa4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

fatal: previous rebase directory .git/rebase-apply still exists but mbox given.


https://github.com/bluez/bluetooth-next/pull/80

---
Regards,
Linux Bluetooth


--===============2067794660146529664==--
