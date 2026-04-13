Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB703A383B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073274; cv=none; b=R8z6qJQKqd0oK+hW4Zjq9IfNGwN2JVwTnfESw52er09UPEVajOVDsGKA7N9X7KTmW+SpLxPo87DtPyDk0/EhT8HPNEpAK5+TRyvueQ2R8o0R9chGA2bdJ4JgCk7GIctSlaw6bEwU+5DjTSog0Yf84M351lJuym4aRazsg3p26Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073274; c=relaxed/simple;
	bh=SmaD1m1Tw+vvxq3dZEA6WNet7D7+H/LUcihnSufwR18=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fZpE+tojprMC4EIy9EFr65P8B1ucnP042MSVpT3L0hjnFGl0QZPw7lhRODBJZXX2ZPGvKRgLEmA6D40Oy1egzTillk6PqX71qW7+FAAdGXGkTEbSTjyEXkEqHcEeHsmtyRrbpbyPopg6k2FTmDJOgEd7lDBjKZxmqRpi51GOFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiHdPMmt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiHdPMmt"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d6d5e45c43so504289485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073272; x=1776678072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=13zBnJJy6dEaJqEEdxEgGphHAehD2KfcU3xAr20TcoU=;
        b=YiHdPMmtACmzCy1+/l2uy40ajoyCunjdnHqnzckpvqT3bQcnSxs6tHpiOqnshvYeRv
         uKIoZO2frIF4aKy94BmxBbh+QZ/JeeaG/IeOu89YnTnQEPiB1EudN9izVlxa1H8MJdV2
         T7Wgsd3m5n5BTQebsil5tdSKR40GEMlVBd4xHmZWOPYm0nbXFWHsiEB38v/gttDUWXOW
         DRDkAhPjSyfGPtDK7TKkfE8Z9Jnq3ZpPQfs4VlA1R8MIl83kyLzgcV2XYCg+x+2fd55z
         3S10Ri2ntCuO6jO59Tysjn9qtkVZUPWAYmiyX7I4VvTKHocz3U69HSp18IPesk+oN85a
         2S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073272; x=1776678072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13zBnJJy6dEaJqEEdxEgGphHAehD2KfcU3xAr20TcoU=;
        b=Mu2oeFSQyV5Ze89CShElE21N/nzk51ha+Ayu2Ou58gmJv2R9Bn4KuhQd66+fNmr15i
         YSNJjDJe0ch+csV77fwVgjkFjnwqIzdhNtH/zZH72GporHZa/OHBpVF2IsI+LsXkyNdd
         uvOnpbJubL/zt213OUbfpBXyMcLNSu746PSE92Oi1IqyKSLIFrzs3q3TJDWGzvT1qHqu
         5KKbAwOeBTy445zqg9fP3Iq9oPaXflCBulwjc0z8/kTTx7fE/BCpGwSC6cugA9Y/DbMu
         6A9RPuIl7XRfQLNRjt9s0t3PuE1GUt01CPz5QIWG2VUxUBfSstFRvKx+H395GejhOoMb
         23GA==
X-Gm-Message-State: AOJu0YxXIOo2PThHZvNGWIuWQO3BMasb6elx0zDNwEQRBBU4SLYbuI9N
	cXpq/pO52JS+XcB5C7qprn7es9gjp3EEcyQhv7+hEd2H5YwGb73Tx27GezH9bw==
X-Gm-Gg: AeBDieuX52qg7MEmn/4842wRc5ql3Z8ODAO4U9RGASunsepqz7CcWW9CWD3m2GoUQzs
	+/eIBa3OrLbsH2jAn2mzvPRaYQfCPb630bUJ/IKUs1onOLXZsktVcQywGSN8cSog5IpYjjuSwd7
	UV6emLSsMR96fEivDNlUrkKLe4pVPN1q87gSwvwlvQtLg5h4U8ITrG/XDsEThL7aIEhCKPLnWkp
	GqfIE793ZEoTpzYzLgVZeoeVQSFpevRR+0z3jAull6f8jjllmzSRKHKK7LrZC+BUlH4/sC/RbkV
	CqzItRvT1WQG6NaOz0y09Pu9fEowfURUfGy49djrCzFSS9REqhj2sgiObbWxi7nDThF/a8VqU4y
	Lm9wi5YCyCoxtjPxckrltFByPb2R4lNxlTFRjegVMHPGVLryoa7m121uNDTL6vI64x0OsSz40FG
	tYnikzU+6PZiCEVha5sTDA7VW9b3S7R98=
X-Received: by 2002:a05:622a:a18f:b0:50b:56f7:c141 with SMTP id d75a77b69052e-50dd5bf072dmr151641791cf.44.1776073271968;
        Mon, 13 Apr 2026 02:41:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.174.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd561a34asm84311671cf.26.2026.04.13.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:41:11 -0700 (PDT)
Message-ID: <69dcba37.c80a0220.3aead6.ab24@mx.google.com>
Date: Mon, 13 Apr 2026 02:41:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9043279290761517072=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: bnep: Fix endianness in bnep_rx_frame() extension parsing
In-Reply-To: <20260413084442.68604-1-phx0fer@gmail.com>
References: <20260413084442.68604-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9043279290761517072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.05 seconds
CheckAllWarning               PASS      28.97 seconds
CheckSparse                   PASS      28.08 seconds
BuildKernel32                 PASS      25.95 seconds
TestRunnerSetup               PASS      539.48 seconds
TestRunner_l2cap-tester       PASS      28.18 seconds
TestRunner_iso-tester         PASS      39.47 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      116.46 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         FAIL      14.30 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.60 seconds
TestRunner_smp-tester         PASS      10.58 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
TestRunner_6lowpan-tester     FAIL      8.84 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc26941412ef4 #1 Not tainted
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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gc26941412ef4 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    1.788 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gc26941412ef4 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e8940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff98c4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/76

---
Regards,
Linux Bluetooth


--===============9043279290761517072==--
