Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2CC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE0206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfAIMCo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:02:44 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44586 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbfAIMCo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 07:02:44 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 983A428E1A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jan 2019 12:02:43 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 8CAD528E3C; Wed,  9 Jan 2019 12:02:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202193] New: BUG: sleeping function called from invalid context
 at net/core/sock.c:2771 when trying to connect bluetooth headphones
Date:   Wed, 09 Jan 2019 12:02:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emilio@crisal.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-202193-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202193

            Bug ID: 202193
           Summary: BUG: sleeping function called from invalid context at
                    net/core/sock.c:2771 when trying to connect bluetooth
                    headphones
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.21.0-0.rc0.git1.1.fc30.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: emilio@crisal.io
        Regression: No

Relevant lines from the dmesg log are:

[ 5575.204953] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 5575.211918] Bluetooth: hci0: Device revision is 5
[ 5575.211923] Bluetooth: hci0: Secure boot is enabled
[ 5575.211925] Bluetooth: hci0: OTP lock is enabled
[ 5575.211927] Bluetooth: hci0: API lock is enabled
[ 5575.211929] Bluetooth: hci0: Debug lock is disabled
[ 5575.211932] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 5575.226315] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 5576.905092] Bluetooth: hci0: Waiting for firmware download to complete
[ 5576.906318] Bluetooth: hci0: Firmware loaded in 1666582 usecs
[ 5576.906972] Bluetooth: hci0: Waiting for device to boot
[ 5576.918832] Bluetooth: hci0: Device booted in 11958 usecs
[ 5576.919318] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[ 5576.922852] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 5577.016834] Bluetooth: RFCOMM TTY layer initialized
[ 5577.016862] Bluetooth: RFCOMM socket layer initialized
[ 5577.017011] Bluetooth: RFCOMM ver 1.11
[ 5577.309829] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 5593.413800] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 5609.419818] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 5622.955313] BUG: sleeping function called from invalid context at
net/core/sock.c:2771
[ 5622.955402] in_atomic(): 1, irqs_disabled(): 0, pid: 30395, name: krfcommd
[ 5622.955406] 2 locks held by krfcommd/30395:
[ 5622.955408]  #0: 0000000025ab6521 (rfcomm_mutex){+.+.}, at:
rfcomm_run+0x159/0x1820 [rfcomm]
[ 5622.955447]  #1: 00000000354a3c8c (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.},
at: rfcomm_connect_ind+0x122/0x260 [rfcomm]
[ 5622.955460] CPU: 5 PID: 30395 Comm: krfcommd Tainted: G           OE    
4.21.0-0.rc0.git1.1.fc30.x86_64 #1
[ 5622.955463] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET80W (1.53
) 09/14/2018
[ 5622.955467] Call Trace:
[ 5622.955495]  dump_stack+0x85/0xc0
[ 5622.955506]  ___might_sleep.cold.73+0xac/0xbc
[ 5622.955527]  lock_sock_nested+0x29/0xa0
[ 5622.955658]  bt_accept_enqueue+0x3f/0xb0 [bluetooth]
[ 5622.955683]  rfcomm_connect_ind+0x21b/0x260 [rfcomm]
[ 5622.955691]  rfcomm_run+0x1611/0x1820 [rfcomm]
[ 5622.955706]  ? do_wait_intr_irq+0xb0/0xb0
[ 5622.955715]  ? rfcomm_check_accept+0x90/0x90 [rfcomm]
[ 5622.955732]  kthread+0x120/0x140
[ 5622.955736]  ? kthread_create_on_node+0x60/0x60
[ 5622.955751]  ret_from_fork+0x3a/0x50

[ 5622.955807] ============================================
[ 5622.955808] WARNING: possible recursive locking detected
[ 5622.955810] 4.21.0-0.rc0.git1.1.fc30.x86_64 #1 Tainted: G        W  OE    
[ 5622.955811] --------------------------------------------
[ 5622.955813] krfcommd/30395 is trying to acquire lock:
[ 5622.955818] 000000009ba868fd (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}, at:
lock_sock_nested+0x36/0xa0
[ 5622.955857] 
               but task is already holding lock:
[ 5622.955858] 00000000354a3c8c (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}, at:
rfcomm_connect_ind+0x122/0x260 [rfcomm]
[ 5622.955866] 
               other info that might help us debug this:
[ 5622.955868]  Possible unsafe locking scenario:

[ 5622.955870]        CPU0
[ 5622.955871]        ----
[ 5622.955872]   lock(slock-AF_BLUETOOTH-BTPROTO_RFCOMM);
[ 5622.955873]   lock(slock-AF_BLUETOOTH-BTPROTO_RFCOMM);
[ 5622.955875] 
                *** DEADLOCK ***

[ 5622.955877]  May be due to missing lock nesting notation

[ 5622.955879] 2 locks held by krfcommd/30395:
[ 5622.955880]  #0: 0000000025ab6521 (rfcomm_mutex){+.+.}, at:
rfcomm_run+0x159/0x1820 [rfcomm]
[ 5622.955885]  #1: 00000000354a3c8c (slock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.},
at: rfcomm_connect_ind+0x122/0x260 [rfcomm]
[ 5622.955889] 
               stack backtrace:
[ 5622.955892] CPU: 5 PID: 30395 Comm: krfcommd Tainted: G        W  OE    
4.21.0-0.rc0.git1.1.fc30.x86_64 #1
[ 5622.955893] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET80W (1.53
) 09/14/2018
[ 5622.955895] Call Trace:
[ 5622.955908]  dump_stack+0x85/0xc0
[ 5622.955917]  __lock_acquire.cold.62+0xc5/0x227
[ 5622.955930]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[ 5622.955944]  ? retint_kernel+0x10/0x10
[ 5622.955947]  lock_acquire+0x9e/0x180
[ 5622.955951]  ? lock_sock_nested+0x36/0xa0
[ 5622.955954]  ? dump_stack+0xb4/0xc0
[ 5622.955957]  _raw_spin_lock_bh+0x38/0x80
[ 5622.955961]  ? lock_sock_nested+0x36/0xa0
[ 5622.955963]  lock_sock_nested+0x36/0xa0
[ 5622.956048]  bt_accept_enqueue+0x3f/0xb0 [bluetooth]
[ 5622.956095]  rfcomm_connect_ind+0x21b/0x260 [rfcomm]
[ 5622.956101]  rfcomm_run+0x1611/0x1820 [rfcomm]
[ 5622.956107]  ? do_wait_intr_irq+0xb0/0xb0
[ 5622.956114]  ? rfcomm_check_accept+0x90/0x90 [rfcomm]
[ 5622.956126]  kthread+0x120/0x140
[ 5622.956130]  ? kthread_create_on_node+0x60/0x60
[ 5622.956135]  ret_from_fork+0x3a/0x50
[ 5623.197411] input: 2C:41:A1:C6:01:C0 as /devices/virtual/input/input19
[ 5625.309788] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 5643.410973] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 5659.311917] Bluetooth: hci0: last event is not cmd complete (0x0f)

Let me know if/how I can help diagnose further.

-- 
You are receiving this mail because:
You are the assignee for the bug.
