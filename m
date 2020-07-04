Return-Path: <SRS0=ITmr=AP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jul 2020 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD4B20747
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jul 2020 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGDP0l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgGDP0k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jul 2020 11:26:40 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206235] kernel BUG at mm/slub.c:294
Date:   Sat, 04 Jul 2020 15:26:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cf_kernel_version resolution
Message-ID: <bug-206235-62941-PdmxX8ZMHN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206235-62941@https.bugzilla.kernel.org/>
References: <bug-206235-62941@https.bugzilla.kernel.org/>
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

Steffen Nurpmeso (steffen@sdaoden.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
     Kernel Version|4.19.107                    |4.19.128
         Resolution|---                         |WILL_NOT_FIX

--- Comment #4 from Steffen Nurpmeso (steffen@sdaoden.eu) ---
Hello.
It happened again, but the trace is the same. I am updating to kernel series
5.4 now, so i close this, ok?  I post nonetheless because here the second RIP
comes without the leading [cut here], which made me wonder a bit.

Jul  4 01:04:15 kent kernel: wlp1s0: deauthenticating from d0:5b:a8:4a:88:84 by
local choice (Reason: 3=DEAUTH_LEAVING)
Jul  4 01:06:36 kent kernel: ------------[ cut here ]------------
Jul  4 01:06:36 kent kernel: kernel BUG at mm/slub.c:294!
Jul  4 01:06:36 kent kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
Jul  4 01:06:36 kent kernel: CPU: 2 PID: 2563 Comm: rfkill Tainted: G         C
       4.19.128-kent #1
Jul  4 01:06:36 kent kernel: Hardware name: LENOVO 81EU/LNVNB161216, BIOS
7PCN35WW 09/25/2018
Jul  4 01:06:36 kent kernel: RIP: 0010:__slab_free.isra.20+0x1be/0x2a0
Jul  4 01:06:36 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Jul  4 01:06:36 kent kernel: RSP: 0018:ffffb199c0ea3cd0 EFLAGS: 00010246
Jul  4 01:06:36 kent kernel: RAX: ffff99812a296d00 RBX: ffff99812a296d00 RCX:
ffff99812a296d00
Jul  4 01:06:36 kent kernel: RDX: 0000000080200015 RSI: ffffe21e84a8a580 RDI:
ffff998264d2b200
Jul  4 01:06:36 kent kernel: RBP: ffffb199c0ea3d60 R08: 0000000000000001 R09:
ffff99812a296d00
Jul  4 01:06:36 kent kernel: R10: 0000310c568441a2 R11: 0000000000000400 R12:
ffffe21e84a8a580
Jul  4 01:06:36 kent kernel: R13: ffff99812a296d00 R14: ffff998264d2b200 R15:
0000000000000000
Jul  4 01:06:36 kent kernel: FS:  00007f83a8795740(0000)
GS:ffff998266a80000(0000) knlGS:0000000000000000
Jul  4 01:06:36 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul  4 01:06:36 kent kernel: CR2: 000055e1a95c65a8 CR3: 0000000132bba002 CR4:
00000000003606e0
Jul  4 01:06:36 kent kernel: Call Trace:
Jul  4 01:06:36 kent kernel:  ? finish_wait+0x2a/0x60
Jul  4 01:06:36 kent kernel:  ? __hci_cmd_sync_ev+0x20a/0x230
Jul  4 01:06:36 kent kernel:  kmem_cache_free+0x19b/0x1c0
Jul  4 01:06:36 kent kernel:  btrtl_shutdown_realtek+0x2b/0x50
Jul  4 01:06:36 kent kernel:  hci_dev_do_close+0x3cf/0x480
Jul  4 01:06:36 kent kernel:  hci_rfkill_set_block+0x37/0x50
Jul  4 01:06:36 kent kernel:  rfkill_set_block+0x8f/0x140
Jul  4 01:06:36 kent kernel:  rfkill_fop_write+0x12a/0x1d0
Jul  4 01:06:36 kent kernel:  __vfs_write+0x31/0x180
Jul  4 01:06:36 kent kernel:  vfs_write+0xa4/0x190
Jul  4 01:06:36 kent kernel:  ksys_write+0x52/0xd0
Jul  4 01:06:36 kent kernel:  do_syscall_64+0x5a/0x190
Jul  4 01:06:36 kent kernel:  ? prepare_exit_to_usermode+0x66/0x90
Jul  4 01:06:36 kent kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  4 01:06:36 kent kernel: RIP: 0033:0x7f83a8882644
Jul  4 01:06:36 kent kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3
0f 1f 80 00 00 00 00 48 8d 05 b9 50 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
Jul  4 01:06:36 kent kernel: RSP: 002b:00007fff97dfdf48 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
Jul  4 01:06:36 kent kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f83a8882644
Jul  4 01:06:36 kent kernel: RDX: 0000000000000008 RSI: 00007fff97dfdf60 RDI:
0000000000000003
Jul  4 01:06:36 kent kernel: RBP: 0000000000000001 R08: 0000000000000003 R09:
0000000000000000
Jul  4 01:06:36 kent kernel: R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
Jul  4 01:06:36 kent kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
Jul  4 01:06:36 kent kernel: Modules linked in: r8822be(C)
Jul  4 01:06:36 kent kernel: ---[ end trace 4107545f4866f48c ]---
ul  4 01:06:36 kent kernel: RIP: 0010:__slab_free.isra.20+0x1be/0x2a0
Jul  4 01:06:36 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Jul  4 01:06:36 kent kernel: RSP: 0018:ffffb199c0ea3cd0 EFLAGS: 00010246
Jul  4 01:06:36 kent kernel: RAX: ffff99812a296d00 RBX: ffff99812a296d00 RCX:
ffff99812a296d00
Jul  4 01:06:36 kent kernel: RDX: 0000000080200015 RSI: ffffe21e84a8a580 RDI:
ffff998264d2b200
Jul  4 01:06:36 kent kernel: RBP: ffffb199c0ea3d60 R08: 0000000000000001 R09:
ffff99812a296d00
Jul  4 01:06:36 kent kernel: R10: 0000310c568441a2 R11: 0000000000000400 R12:
ffffe21e84a8a580
Jul  4 01:06:36 kent kernel: R13: ffff99812a296d00 R14: ffff998264d2b200 R15:
0000000000000000
Jul  4 01:06:36 kent kernel: FS:  00007f83a8795740(0000)
GS:ffff998266a80000(0000) knlGS:0000000000000000
Jul  4 01:06:36 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul  4 01:06:36 kent kernel: CR2: 000055e1a95c65a8 CR3: 0000000132bba002 CR4:
00000000003606e0
Jul  4 01:13:22 kent kernel: device v_i left promiscuous mode
Jul  4 01:13:22 kent kernel: v_br: port 1(v_i) entered disabled state
Jul  4 15:43:14 kent kernel: microcode: microcode updated early to revision
0xd6, date = 2020-04-27
Jul  4 15:43:14 kent kernel: Linux version 4.19.128-kent (guest@kent) (gcc
version 8.4.0 (CRUX-x86_64-multilib)) #1 SMP PREEMPT Sat Jun 13 18:36:47 CEST
2020

-- 
You are receiving this mail because:
You are the assignee for the bug.
