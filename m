Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DEC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 07:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB2920828
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 07:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCRHsA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:48:00 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:56890 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfCRHsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 03:48:00 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id DB079292A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 07:47:58 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id CF154292AA; Mon, 18 Mar 2019 07:47:58 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202963] New: [REGRESSION][BISECTED] Bluetooth broken on MBP and
 kernel NULL pointer dereference
Date:   Mon, 18 Mar 2019 07:47:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ronald@innovation.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202963-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202963

            Bug ID: 202963
           Summary: [REGRESSION][BISECTED] Bluetooth broken on MBP and
                    kernel NULL pointer dereference
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.0.2
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ronald@innovation.ch
        Regression: No

Hardware: Apple MacBook Pro 13,3

As of kernel 5.0 bluetooth is not working anymore and there are a couple null
pointer deference bugs in the dmesg during boot (this also delays boot and
shutdown by several minutes). The issue has been bisected down to commit
75d11676dccb643de1e850c8a29f5e9aa58157c0 (Bluetooth: hci_bcm: Add support for
regulator supplies). Further investigation shows the reason why: at the top of
bcm_get_resources() processing is short-circuited on apple machines, and hence
dev->supplies is never initialized; this then eventually leads to the null
pointer after bcm_gpio_set_power() calls regulator_bulk_enable().

Two obvious fixes I see are:
1. don't call regulator_bulk_enable() if dev->supplies is not initialized
2. initialize dev->supplies on apple machines too

For reference the BUG in dmesg is:
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000088
  #PF error: [normal kernel read fault]
  PGD 0 P4D 0 
  Oops: 0000 [#1] SMP PTI
  CPU: 2 PID: 439 Comm: kworker/u16:2 Tainted: G        W  OE     5.0.2+ #4
  Hardware name: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS
251.0.0.0.0 10/>
  Workqueue: events_unbound async_run_entry_fn
  RIP: 0010:regulator_enable+0xe/0xc0
  Code: ac ff 8b 43 0c e9 e2 fe ff ff e9 98 22 00 00 66 66 2e 0f 1f 84 00 00 00
00 00>
  RSP: 0018:ffffa8f1c25cfd98 EFLAGS: 00010282
  RAX: ffffffffac63bef0 RBX: ffff926c1eda6ec8 RCX: 0000000000000002
  RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000000
  RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000001e1f80
  R10: 00000010213103a9 R11: ffffffffae650180 R12: ffff926c2d812000
  R13: ffff926c2d859b00 R14: 0000000000000000 R15: ffff926c21a4a6e8
  FS:  0000000000000000(0000) GS:ffff926c2e000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000088 CR3: 000000016b616004 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   ? sched_clock+0x5/0x10
   ? process_one_work+0x1ca/0x5f0
   ? __lock_is_held+0x5a/0xa0
   regulator_bulk_enable_async+0x12/0x20
   async_run_entry_fn+0x39/0x160
   process_one_work+0x24c/0x5f0
   worker_thread+0x3c/0x390
   ? process_one_work+0x5f0/0x5f0
   kthread+0x120/0x140
   ? kthread_create_on_node+0x60/0x60
   ret_from_fork+0x3a/0x50
  Modules linked in: acpi_cpufreq(E-) x86_pkg_temp_thermal(E) brcmfmac(E)
intel_power>
  CR2: 0000000000000088

regulator_enable+0xe is this line (i.e. regulator is null):

        struct regulator_dev *rdev = regulator->rdev;

-- 
You are receiving this mail because:
You are the assignee for the bug.
