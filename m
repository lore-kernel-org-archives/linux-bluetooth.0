Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42A19D8BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781836133; cv=none; b=FpubQoY7eqsblnvWHDofmfbVQMjoLk7a3se7DM0pFMlvJJ4zYBhCAT2VsqT/V2mjXgBHwKDa7oiAQbpPgYgev/Cu/YZ3e6CBr8cTf4rYNbWxTNIV10ZS6ohMkyRjMFPwPUc3sISx4Z0Q4dohgDJD2whXy0R91cR4dB5Bkhg3jDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781836133; c=relaxed/simple;
	bh=o4j0Um7JDqdvIBEUhE+WoOOF5PG4Mv1vqWQ97r/Ddss=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KAz6nCgfZlnn9zTF8W5Wa9ZvY9dLav8kZFkQzgOZJctYFx2rwxIIrK1hvFXulZFi4FqT5KoMtKEhqVOaGZ0W4nJvg9l+CAjONsiLjo4pPHwuDsqmm6RDjHffSYV7Qmwf+WLVBUwRaJZEdkP6BpgkAXoutAKoUVoVsPOGjabpgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpRupLd1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpRupLd1"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91562bf6c12so197721385a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781836114; x=1782440914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2gsBn98f0VhQSJuyBoiMLjsL0Oaz23MQDeoAxzSV6y0=;
        b=rpRupLd1o4ZqISJgDJdzya7utHKMxgwljqngj32iTgUJRKlpzGRI0rJNNwac/nZCYD
         YTwPL8xEPGP4P5ue06/CV0KuqhWWHmvBP6my4KQwzqbz1a1KawCvTY3unyeD4jzu2Tmd
         y55hwrFSNXG2SOsupvc6YdXbag1LT59EiSOLvvdSD8SmWg0tyyreRuadjpW/4nH1gW1l
         dtqA2k5IdIpjVdCduoIWrSbdKXkCwBeBje/qlndjXbVJ0MTDhHdDmC0d7VMtNg/7BIyt
         XkxhQBOTpGAyIehWFzMHT6vhL+5zRykDAFTwoqsGVoM28AfAPs/zm3gNmsZuNuHJiqC0
         RWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781836114; x=1782440914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gsBn98f0VhQSJuyBoiMLjsL0Oaz23MQDeoAxzSV6y0=;
        b=cn1xccWN3STHpnfTcm1sEaazbqDe0ogqpzR5QAiJ7QL9TBLEycnSpo5Rq77paH+5le
         i91Nwz+0M2RSYrqvPNoRuIgSMWhAM+N8PN3ndtrnMU1opsuBJHYEKyigFwKkjUfkMn+x
         1oQaKeS4ra7mmxBYd5GrRHtO1QRmYrsFt3rUYizPcE44hWTXnTtqDjuUt849gcPaFQ1h
         fwIMTZ64zInUR1qq8yKdKdZLVjA91FdPTggKrGASU6G8JhirDl3OWZG0H0Qy3LaDu67J
         o8TdWTbDDnxflzYJmpC+We3ou1VdL8z+JSuYLo80ECl7xvFgPfAVyl5/ivD1w0N5Ydi4
         pUwA==
X-Gm-Message-State: AOJu0YxXHjoakvniWC4Q8hes0IiMddozg9o9plUK6ZsdcX6uTZShW3B7
	VA0JpfT/JmtzTyLUdsYRnzYW2YBC0uQ8eEiLEntsajVlSnCsqVy6H+Gl5zeBCQ==
X-Gm-Gg: AfdE7ck56AirLtaT6psa3fvUq0bDfMyV1dWvD4iNWSz0LdlYB+JN0pT/PH4N6Kh6WD4
	vHbcQdHtnsunSCp0pThgcXSx4k3yukxHRuZtqK82o32voN1rPcUxHJZH0DyvOBmGRiXhUkHChiP
	9uyeB7zvNzZRcfNLwEMF2d+rYKYBIVoFmf/PXyhLvrWqvp/BQUsIto0I2nCT29mOMiCZGe1WF1+
	82i0A7RvkFVu72/4i9Nh28Yyqc7ZdwfkPN3ErJeetSJKR3lEkdl7KrSOTWp8Lohu00eUPq+ZUk4
	ur75TV1l8oBs1OZV8GBBzzqVfWGgpslpuAaLdqkf3U0wVdPuJbQ9i3jtgIMFcTwytwkh44jwlCr
	suK9gizjqpblmOHPJfJ6czk1O1j5cVhUdtvmb0T7QQUnoanj7N+lGtdFkJ/+e4nR4BmI1mMy4TA
	Cqxez3M9oroGQI3MNl8C0=
X-Received: by 2002:a05:620a:2708:b0:914:d093:abbe with SMTP id af79cd13be357-920d12180fbmr106562185a.12.1781836109653;
        Thu, 18 Jun 2026 19:28:29 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425383dsm98365285a.28.2026.06.18.19.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 19:28:28 -0700 (PDT)
Message-ID: <6a34a94c.efad125f.312e9.481e@mx.google.com>
Date: Thu, 18 Jun 2026 19:28:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2049010454367649621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: hci_event: Synchronously cancel timers in hci_cmd_complete_evt()
In-Reply-To: <20260619004222.3764523-2-iam@sung-woo.kim>
References: <20260619004222.3764523-2-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2049010454367649621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113713

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.23 seconds
CheckAllWarning               PASS      29.75 seconds
CheckSparse                   PASS      28.36 seconds
BuildKernel32                 PASS      26.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      577.79 seconds
TestRunner_l2cap-tester       FAIL      59.53 seconds
TestRunner_iso-tester         FAIL      84.83 seconds
TestRunner_bnep-tester        FAIL      18.77 seconds
TestRunner_mgmt-tester        FAIL      211.45 seconds
TestRunner_rfcomm-tester      FAIL      25.23 seconds
TestRunner_sco-tester         FAIL      32.36 seconds
TestRunner_ioctl-tester       FAIL      26.08 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         FAIL      23.14 seconds
TestRunner_userchan-tester    FAIL      19.76 seconds
TestRunner_6lowpan-tester     FAIL      22.59 seconds
IncrementalBuild              PASS      25.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_event: Synchronously cancel timers in hci_cmd_complete_evt()

27: B1 Line exceeds max length (92>80): "BUG: KASAN: slab-use-after-free in hci_cmd_timeout+0x216/0x260 net/bluetooth/hci_core.c:1432"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022f3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002527d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002607d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? asm_common_interrupt+0x40/0x40
 ? hci_rx_work+0x156/0xd00
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 42, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/42:
 #0: ffff888001d3d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 42 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 50, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/50:
 #0: ffff8880026e6138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002517d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 50 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc12/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 62, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/62:
 #0: ffff888002406138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002767d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 62 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 68, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/68:
 #0: ffff888002554138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025a7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 68 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 74, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/74:
 #0: ffff888002722938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 74 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 80, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/80:
 #0: ffff8880020ac938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800265fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 80 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 92, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/92:
 #0: ffff8880022e8938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800265fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 92 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 104, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/104:
 #0: ffff8880020af138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800253fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 104 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 116, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/116:
 #0: ffff888001d18138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022a7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 116 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 122, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/122:
 #0: ffff888001d3d938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 122 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 128, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/128:
 #0: ffff8880026e9138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f17d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 128 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 143, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/143:
 #0: ffff888002720938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002247d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 143 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 155, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/155:
 #0: ffff888001d3d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800251fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 155 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 161, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/161:
 #0: ffff8880026eb138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800251fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 161 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 170, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/170:
 #0: ffff8880026a0938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800231fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 170 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 176, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/176:
 #0: ffff8880026a3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 176 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 182, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/182:
 #0: ffff888002721138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 182 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 188, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/188:
 #0: ffff8880020ac938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 188 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 200, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/200:
 #0: ffff8880022f3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001307d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 200 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 209, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/209:
 #0: ffff8880025e2938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880019cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 209 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 221, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/221:
 #0: ffff888002722938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 221 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/233:
 #0: ffff8880018f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880019cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 233 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 242, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/242:
 #0: ffff888002678138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800485fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 242 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 254, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/254:
 #0: ffff888002722138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 254 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 260, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/260:
 #0: ffff8880025a6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 260 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 272, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/272:
 #0: ffff888002678938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 272 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 284, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/284:
 #0: ffff8880022eb138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 284 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 296, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/296:
 #0: ffff888001d3e938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002107d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 296 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 305, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/305:
 #0: ffff888002679138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002107d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 305 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 315, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/315:
 #0: ffff8880022e8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002107d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb679ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 315 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
Total: 96, Passed: 96 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026afd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880022ab938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800229fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 50, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/50:
 #0: ffff8880026ae138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880023e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 50 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 53, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/53:
 #0: ffff8880022e7138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026b7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 53 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 62, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/62:
 #0: ffff8880025e4938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002577d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 62 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 71, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/71:
 #0: ffff8880018bf938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002477d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 71 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 83, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/83:
 #0: ffff8880024df138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025dfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 83 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 86, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/86:
 #0: ffff8880024dd938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022ffd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 86 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 95, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/95:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025dfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 95 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 104, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/104:
 #0: ffff8880024f8938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002517d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 104 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 116, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/116:
 #0: ffff888002462138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022ffd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 116 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 125, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/125:
 #0: ffff8880022f3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002317d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 125 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 134, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/134:
 #0: ffff8880022f5138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002567d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 134 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 146, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/146:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 146 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 155, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/155:
 #0: ffff8880022e6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 155 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 164, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/164:
 #0: ffff888002462938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 164 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 173, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/173:
 #0: ffff8880025e5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002427d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 173 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 182, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/182:
 #0: ffff888002215138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 182 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 191, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/191:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002427d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 191 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 197, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/197:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 197 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 206, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/206:
 #0: ffff888002475938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002567d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 206 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 215, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/215:
 #0: ffff888002461938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002567d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 215 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 224, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/224:
 #0: ffff8880022ab938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 224 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/233:
 #0: ffff888002474938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 233 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 242, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/242:
 #0: ffff888002476938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 242 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 251, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/251:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 251 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 260, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/260:
 #0: ffff8880022f0938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800265fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 260 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 269, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/269:
 #0: ffff8880024fa138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 269 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 275, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/275:
 #0: ffff888002462938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 275 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 284, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/284:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025afd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 284 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 287, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/287:
 #0: ffff888002217938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 287 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 296, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/296:
 #0: ffff8880024f9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025afd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 296 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 305, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/305:
 #0: ffff8880022e7138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 305 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 311, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/311:
 #0: ffff8880025e5138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 311 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 314, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/314:
 #0: ffff8880022e4938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022efd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 314 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 321, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/321:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 321 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 332, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/332:
 #0: ffff888002527938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 332 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 341, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/341:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 341 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 350, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/350:
 #0: ffff888002525138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 350 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 356, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/356:
 #0: ffff888002527938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 356 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 362, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/362:
 #0: ffff8880025e6138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800250fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 362 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 371, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/371:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 371 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 380, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/380:
 #0: ffff8880024f8938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800261fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 380 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 384, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/384:
 #0: ffff8880025e4938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 384 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 398, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/398:
 #0: ffff8880022a9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800276fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 398 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 404, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/404:
 #0: ffff8880025e4138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800276fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 404 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 411, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/411:
 #0: ffff888001305938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026dfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 411 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 422, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/422:
 #0: ffff8880022e7138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880027afd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 422 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 431, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/431:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800229fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 431 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 440, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/440:
 #0: ffff8880024fa138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880027d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 440 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 452, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/452:
 #0: ffff8880018bf938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880027cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8df9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 452 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022ffd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff8f59ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? skb_pull_data+0x67/0x100
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022c5138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024a7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/44:
 #0: ffff8880022ef938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800263fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 44 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 56, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/56:
 #0: ffff8880019c9138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800245fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 56 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 71, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/71:
 #0: ffff88800251c138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022ffd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 71 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 86, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/86:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001cf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 86 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 98, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/98:
 #0: ffff888002477138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800266fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 98 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 110, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/110:
 #0: ffff88800251c938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002627d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 110 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 122, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/122:
 #0: ffff88800269a138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001b87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 122 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 134, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/134:
 #0: ffff8880019c8938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 134 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 149, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/149:
 #0: ffff8880022f3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001b87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 149 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 161, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/161:
 #0: ffff8880022c5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 161 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 173, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/173:
 #0: ffff888001325138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 173 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 185, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/185:
 #0: ffff888002322138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800263fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 185 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 197, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/197:
 #0: ffff888002698938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002727d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 197 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 212, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/212:
 #0: ffff888002477138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 212 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 227, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/227:
 #0: ffff8880022ec138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 227 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 239, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/239:
 #0: ffff888002321938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 239 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 248, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/248:
 #0: ffff888002474938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 248 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 260, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/260:
 #0: ffff8880022ef938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 260 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 272, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/272:
 #0: ffff888002698938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 272 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 284, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/284:
 #0: ffff8880019c8938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 284 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 296, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/296:
 #0: ffff888002477938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 296 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 308, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/308:
 #0: ffff888002474138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 308 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 320, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/320:
 #0: ffff8880022c6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 320 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 332, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/332:
 #0: ffff88800251e138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 332 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 344, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/344:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 344 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 356, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/356:
 #0: ffff88800251c138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 356 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 365, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/365:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 365 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 377, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/377:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 377 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 389, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/389:
 #0: ffff88800251c138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 389 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 398, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/398:
 #0: ffff88800251c938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 398 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 413, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/413:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 413 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 425, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/425:
 #0: ffff888002659138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 425 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 437, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/437:
 #0: ffff88800251e138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 437 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 444, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/444:
 #0: ffff8880019ca138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 444 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 458, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/458:
 #0: ffff8880019c9138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 458 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 470, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/470:
 #0: ffff8880022ec938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 470 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 482, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/482:
 #0: ffff8880026d6138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 482 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 488, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/488:
 #0: ffff8880022c5138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 488 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 497, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/497:
 #0: ffff8880022f3938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800227fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 497 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 506, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/506:
 #0: ffff88800269b938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 506 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 518, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/518:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 518 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 530, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/530:
 #0: ffff88800251f938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 530 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 542, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/542:
 #0: ffff88800251c938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 542 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 554, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/554:
 #0: ffff8880022c5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 554 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 566, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/566:
 #0: ffff88800251f938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 566 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 575, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/575:
 #0: ffff8880022ee938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 575 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 587, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/587:
 #0: ffff88800251c938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 587 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 596, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/596:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 596 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 605, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/605:
 #0: ffff88800251f138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 605 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 614, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/614:
 #0: ffff8880019cb938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 614 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 623, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/623:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 623 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 632, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/632:
 #0: ffff888002697138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 632 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 641, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/641:
 #0: ffff8880022ec138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002777d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 641 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 647, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/647:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 647 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 654, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/654:
 #0: ffff888002696138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 654 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 657, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/657:
 #0: ffff888002578138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 657 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 660, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/660:
 #0: ffff88800251c138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 660 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 668, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/668:
 #0: ffff88800278b938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800270fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 668 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 677, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/677:
 #0: ffff888002579938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800270fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 677 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 686, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/686:
 #0: ffff88800269a138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 686 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 695, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/695:
 #0: ffff8880022c7138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 695 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 699, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/699:
 #0: ffff888001f11938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002787d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 699 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 713, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/713:
 #0: ffff888002450138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 713 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 725, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/725:
 #0: ffff888002453938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 725 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 737, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/737:
 #0: ffff8880019c9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 737 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 749, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/749:
 #0: ffff8880022ef938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 749 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 764, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/764:
 #0: ffff8880022f0938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 764 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 776, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/776:
 #0: ffff888002578938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 776 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 788, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/788:
 #0: ffff8880022ee938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 788 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 794, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/794:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 794 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 809, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/809:
 #0: ffff88800257a938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 809 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 821, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/821:
 #0: ffff888002698938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 821 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 833, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/833:
 #0: ffff888002699938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 833 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 842, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/842:
 #0: ffff8880022c6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 842 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 845, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/845:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 845 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 848, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/848:
 #0: ffff88800257a938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 848 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 851, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/851:
 #0: ffff88800269b938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 851 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 860, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/860:
 #0: ffff888002698138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 860 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 872, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/872:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 872 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 884, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/884:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 884 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 896, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/896:
 #0: ffff8880022ee938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 896 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 908, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/908:
 #0: ffff888002452138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 908 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 917, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/917:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 917 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 929, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/929:
 #0: ffff888001f11138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 929 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 941, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/941:
 #0: ffff8880022c6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 941 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 950, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/950:
 #0: ffff8880019ca138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880020e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 950 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 959, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/959:
 #0: ffff888001f10138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 959 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 962, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/962:
 #0: ffff8880019ca938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 962 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 974, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/974:
 #0: ffff8880022ed938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 974 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 986, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/986:
 #0: ffff8880022ef138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 986 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 995, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/995:
 #0: ffff88800269a138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 995 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1007, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1007:
 #0: ffff88800257b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1007 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1005, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1005:
 #0: ffff88800257b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002727d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1005 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1010, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1010:
 #0: ffff8880019c8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1010 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1016, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1016:
 #0: ffff8880018f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1016 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1028, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1028:
 #0: ffff888001f10938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1028 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1028, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1028:
 #0: ffff888001f10938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1028 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1031, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1031:
 #0: ffff888002578138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002727d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1031 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1046, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1046:
 #0: ffff88800231d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1046 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1058, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1058:
 #0: ffff8880022f1138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1058 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1070, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1070:
 #0: ffff8880022c7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1070 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1082, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1082:
 #0: ffff88800231f138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1082 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1091, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1091:
 #0: ffff888002579138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1091 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1094, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1094:
 #0: ffff888001f10138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1094 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1106, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1106:
 #0: ffff8880022c6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1106 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1112, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1112:
 #0: ffff88800257b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1112 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1121, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1121:
 #0: ffff8880022ee138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1121 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1130, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1130:
 #0: ffff888001f12938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1130 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1142, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1142:
 #0: ffff88800269a938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1142 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1151, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1151:
 #0: ffff8880022ee938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1151 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1163, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1163:
 #0: ffff8880022c4138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1163 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1166, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1166:
 #0: ffff8880022f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1166 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1178, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1178:
 #0: ffff88800231d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1178 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1187, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1187:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1187 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1199, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1199:
 #0: ffff888002698938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1199 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1211, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1211:
 #0: ffff888002579938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1211 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1220, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1220:
 #0: ffff8880022f1138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800264fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1220 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1232, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1232:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1232 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1241, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1241:
 #0: ffff88800257a938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1241 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1244, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1244:
 #0: ffff8880022ec938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1244 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1253, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1253:
 #0: ffff8880022c7138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1253 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1262, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1262:
 #0: ffff8880022f6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026c7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1262 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1274, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1274:
 #0: ffff88800231d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1274 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1283, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1283:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1283 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1295, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1295:
 #0: ffff88800231d938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1295 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1304, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1304:
 #0: ffff8880022ee138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1304 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1307, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1307:
 #0: ffff88800269b138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1307 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1313, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1313:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001f87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1313 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1325, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1325:
 #0: ffff88800231d938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1325 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1337, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1337:
 #0: ffff8880022ec138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1337 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1346, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1346:
 #0: ffff8880022f0138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1346 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1358, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1358:
 #0: ffff88800231e138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1358 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1370, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1370:
 #0: ffff888002578138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1370 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1382, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1382:
 #0: ffff8880022c7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1382 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1394, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1394:
 #0: ffff88800231f138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1394 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1400, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1400:
 #0: ffff888002579938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1400 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1403, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1403:
 #0: ffff8880022ed938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1403 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1407, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1407:
 #0: ffff888002316138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1407 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1410, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1410:
 #0: ffff8880018f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1410 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1410, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1410:
 #0: ffff8880018f7938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1410 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1413, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1413:
 #0: ffff888001f13938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1413 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1413, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/1413:
 #0: ffff888001f13938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1413 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1430, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1430:
 #0: ffff888001f12938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1430 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1439, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1439:
 #0: ffff8880022f6138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1439 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1448, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1448:
 #0: ffff88800231d138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1448 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1457, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1457:
 #0: ffff888002315138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800258fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1457 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1466, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1466:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1466 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1472, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1472:
 #0: ffff8880022ee138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024e7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1472 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1481, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1481:
 #0: ffff8880022c6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001bf7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1481 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1490, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1490:
 #0: ffff888001f12938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800013fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1490 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1496, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1496:
 #0: ffff888000138138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800016fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1496 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1499, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1499:
 #0: ffff88800017a938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800016fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1499 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1502, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1502:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888000147d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1502 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1502, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1502:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888000147d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 1502 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1505, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1505:
 #0: ffff8880001dd938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880001f7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 1505 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1514, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1514:
 #0: ffff88800017e938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800016fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1514 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1517, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/1517:
 #0: ffff8880022f1138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880001f7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9c79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 1517 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022f1138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022dfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880025a1938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800240fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 39, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/39:
 #0: ffff8880025a1938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800265fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 39 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 50, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/50:
 #0: ffff888002773138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800267fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 50 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 59, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/59:
 #0: ffff888002544138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026bfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 59 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 68, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/68:
 #0: ffff8880022e5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002537d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9b79ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 68 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff888001fce138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800266fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff888001325138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002477d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 50, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/50:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002757d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 50 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 53, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/53:
 #0: ffff888002483138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025f7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 53 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 56, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/56:
 #0: ffff888002480138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800259fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 56 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 63, name: kworker/u5:0
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:0/63:
 #0: ffff888001d86938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001d2fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 63 Comm: kworker/u5:0 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc1b/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 74, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/74:
 #0: ffff888001bf6938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024bfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 74 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 86, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/86:
 #0: ffff888002469138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 86 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 95, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/95:
 #0: ffff8880022f1138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 95 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/107:
 #0: ffff888001fcf938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_status_evt+0x290/0x880
CPU: 0 UID: 0 PID: 107 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_status_evt+0x6b1/0x880
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_status_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 119, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/119:
 #0: ffff888002469138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffba99ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 119 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022e9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
 ? __switch_to_asm+0x32/0x60
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880022f4138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880023ffd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 53, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/53:
 #0: ffff88800247b938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880025dfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 53 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 68, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/68:
 #0: ffff8880025a5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002577d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 68 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 86, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/86:
 #0: ffff888001271938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024b7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 86 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 101, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/101:
 #0: ffff888002242938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880026d7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 101 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/107:
 #0: ffff8880022e9938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880024f7d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 107 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 119, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/119:
 #0: ffff8880022f6138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff8880022cfd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9099ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 119 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 ? hci_send_to_sock+0x11f/0x6c0
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
Total: 28, Passed: 28 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff888002301938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002227d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9279ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __switch_to+0x9b9/0xe10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880025b3138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002707d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9279ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 50, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/50:
 #0: ffff8880022f9138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002607d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9279ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 50 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 59, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/59:
 #0: ffff8880018bf938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800259fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9279ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 59 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 65, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/65:
 #0: ffff88800232d938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800229fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9279ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 65 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.878 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 38, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/38:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002657d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9399ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 38 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 38, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/38:
 #0: ffff8880022f5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002657d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9399ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 38 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 47, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/47:
 #0: ffff8880018bf938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800268fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9399ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 47 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 56, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/56:
 #0: ffff888002700938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001a07d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff9399ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 56 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff88800230d938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800240fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb5d9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/44:
 #0: ffff888001d08138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888001b87d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffffb5d9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 44 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 4, Passed: 4 (100.0%), Failed: 0, Not Run: 0

Failed Test Cases
User channel open - Failed                           Passed       0.540 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 37, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/37:
 #0: ffff8880022fa938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002687d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff83f9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
 ? __pfx_kthread+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/41:
 #0: ffff8880022c4138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff88800219fd28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff83f9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 41 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 45, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/45:
 #0: ffff888001a07138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002027d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff83f9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 45 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
BUG: sleeping function called from invalid context at kernel/workqueue.c:4479
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 54, name: kworker/u5:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:2/54:
 #0: ffff88800251a138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0xdf0/0x1ad0
 #1: ffff888002437d28 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0xb56/0x1ad0
 #2: ffffffff83f9ad20 (rcu_read_lock){....}-{1:3}, at: hci_cmd_complete_evt+0x37b/0xbd0
CPU: 0 UID: 0 PID: 54 Comm: kworker/u5:2 Tainted: G        W           7.1.0-rc6-g0773f4c2dcba #1 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 __cancel_work_sync+0x69/0xb0
 hci_cmd_complete_evt+0x8ec/0xbd0
 ? __skb_clone+0x5a1/0x790
 hci_event_packet+0x4cb/0xb10
 ? __pfx_hci_cmd_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_lock.part.0+0xc10/0xca0
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? trace_hardirqs_on+0x19/0x110
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xba7/0x1ad0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2b0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x514/0xbb0
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? trace_hardirqs_on+0x19/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4a1/0x770
 ? __pfx_ret_from_fork+0x10/0x10
...
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


https://github.com/bluez/bluetooth-next/pull/333

---
Regards,
Linux Bluetooth


--===============2049010454367649621==--
