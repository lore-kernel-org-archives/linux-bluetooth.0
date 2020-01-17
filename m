Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF6C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230F20728
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgAQNix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgAQNix (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 08:38:53 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206235] New: kernel BUG at mm/slub.c:294
Date:   Fri, 17 Jan 2020 13:38:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206235-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206235

            Bug ID: 206235
           Summary: kernel BUG at mm/slub.c:294
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.94
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: steffen@sdaoden.eu
        Regression: No

during a "sudo rfkill block all" with a bluealsa device still paired (normally
i unpair first, first time i did not i think) i got this oops:

Jan 17 01:34:05 kent kernel: ------------[ cut here ]------------
Jan 17 01:34:05 kent kernel: kernel BUG at mm/slub.c:294!
Jan 17 01:34:05 kent kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
Jan 17 01:34:05 kent kernel: CPU: 0 PID: 16328 Comm: rfkill Tainted: G        
C        4.19.94-kent #1
Jan 17 01:34:05 kent kernel: Hardware name: LENOVO 81EU/LNVNB161216, BIOS
7PCN35WW 09/25/2018
Jan 17 01:34:05 kent kernel: RIP: 0010:__slab_free.isra.20+0x1b8/0x290
Jan 17 01:34:05 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Jan 17 01:34:05 kent kernel: RSP: 0018:ffffa6b840cebcc0 EFLAGS: 00010246
Jan 17 01:34:05 kent kernel: RAX: ffff95323b657a00 RBX: ffff95323b657a00 RCX:
ffff95323b657a00
Jan 17 01:34:05 kent kernel: RDX: 0000000080200005 RSI: ffffdd2dc5ed9580 RDI:
ffff953324d2b080
Jan 17 01:34:05 kent kernel: RBP: ffffa6b840cebd50 R08: 0000000000000001 R09:
ffff95323b657a00
Jan 17 01:34:05 kent kernel: R10: 00001a05f5d98974 R11: 0000000000001400 R12:
ffffdd2dc5ed9580
Jan 17 01:34:05 kent kernel: R13: ffff95323b657a00 R14: ffff953324d2b080 R15:
0000000000000000
Jan 17 01:34:05 kent kernel: FS:  00007f21f93c3740(0000)
GS:ffff953326a00000(0000) knlGS:0000000000000000
Jan 17 01:34:05 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 01:34:05 kent kernel: CR2: 00007ffb6241f9d8 CR3: 000000010dbee002 CR4:
00000000003606f0
Jan 17 01:34:05 kent kernel: Call Trace:
Jan 17 01:34:05 kent kernel:  ? finish_wait+0x2a/0x60
Jan 17 01:34:05 kent kernel:  ? __hci_cmd_sync_ev+0x20a/0x230
Jan 17 01:34:05 kent kernel:  kmem_cache_free+0x195/0x1c0
Jan 17 01:34:05 kent kernel:  btrtl_shutdown_realtek+0x2b/0x50
Jan 17 01:34:05 kent kernel:  hci_dev_do_close+0x402/0x4c0
Jan 17 01:34:05 kent kernel:  hci_rfkill_set_block+0x37/0x50
Jan 17 01:34:05 kent kernel:  rfkill_set_block+0x8f/0x140
Jan 17 01:34:05 kent kernel:  rfkill_fop_write+0x12a/0x1d0
Jan 17 01:34:05 kent kernel:  __vfs_write+0x31/0x180
Jan 17 01:34:05 kent kernel:  vfs_write+0xa4/0x190
Jan 17 01:34:05 kent kernel:  ksys_write+0x52/0xd0
Jan 17 01:34:05 kent kernel:  do_syscall_64+0x5a/0x190
Jan 17 01:34:05 kent kernel:  ? prepare_exit_to_usermode+0x66/0x90
Jan 17 01:34:05 kent kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan 17 01:34:05 kent kernel: RIP: 0033:0x7f21f94b0644
Jan 17 01:34:05 kent kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3
0f 1f 80 00 00 00 00 48 8d 05 b9 50 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
Jan 17 01:34:05 kent kernel: RSP: 002b:00007ffc78824028 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
Jan 17 01:34:05 kent kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f21f94b0644
Jan 17 01:34:05 kent kernel: RDX: 0000000000000008 RSI: 00007ffc78824040 RDI:
0000000000000003
Jan 17 01:34:05 kent kernel: RBP: 0000000000000001 R08: 0000000000000003 R09:
0000000000000000
Jan 17 01:34:05 kent kernel: R10: fffffffffffff088 R11: 0000000000000246 R12:
0000000000000000
Jan 17 01:34:05 kent kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
Jan 17 01:34:05 kent kernel: Modules linked in: r8822be(C)
Jan 17 01:34:05 kent kernel: ---[ end trace 56293fc55f5cc3e0 ]---
Jan 17 01:34:05 kent kernel: RIP: 0010:__slab_free.isra.20+0x1b8/0x290
Jan 17 01:34:05 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Jan 17 01:34:05 kent kernel: RSP: 0018:ffffa6b840cebcc0 EFLAGS: 00010246
Jan 17 01:34:05 kent kernel: RAX: ffff95323b657a00 RBX: ffff95323b657a00 RCX:
ffff95323b657a00
Jan 17 01:34:05 kent kernel: RDX: 0000000080200005 RSI: ffffdd2dc5ed9580 RDI:
ffff953324d2b080
Jan 17 01:34:05 kent kernel: RBP: ffffa6b840cebd50 R08: 0000000000000001 R09:
ffff95323b657a00
Jan 17 01:34:05 kent kernel: R10: 00001a05f5d98974 R11: 0000000000001400 R12:
ffffdd2dc5ed9580
Jan 17 01:34:05 kent kernel: R13: ffff95323b657a00 R14: ffff953324d2b080 R15:
0000000000000000
Jan 17 01:34:05 kent kernel: FS:  00007f21f93c3740(0000)
GS:ffff953326a00000(0000) knlGS:0000000000000000
Jan 17 01:34:05 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 01:34:05 kent kernel: CR2: 00007ffb6241f9d8 CR3: 000000010dbee002 CR4:
00000000003606f0

Linux kent 4.19.94-kent #1 SMP PREEMPT Sat Jan 11 22:44:47 CET 2020 x86_64
Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz GenuineIntel GNU/Linux

-- 
You are receiving this mail because:
You are the assignee for the bug.
