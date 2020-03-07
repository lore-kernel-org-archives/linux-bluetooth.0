Return-Path: <SRS0=2pC7=4Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E68C10F00
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 20:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BE220684
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgCGUVZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgCGUVZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Mar 2020 15:21:25 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206235] kernel BUG at mm/slub.c:294
Date:   Sat, 07 Mar 2020 20:21:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206235-62941-utXXwkMxVb@https.bugzilla.kernel.org/>
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

--- Comment #1 from Steffen Nurpmeso (steffen@sdaoden.eu) ---
Hello.  I am now on 4.19.107 and "it happened again".
Semantic was slightly different, i realized the notebook is not going to sleep,
and found un-KILLable bluetoothd and rfkill instances, i even had to shutdown
the computer hard.  The following listing can be better understood with a
snippet from my /root/zzz.sh that is invoked if acpid emits LID (close) events:

while :; do
   down_off
   lid_exists || break
   sleep 1
   lid_is_open && break
done

Here is the /var/log/kernel snippet:

Mar  7 02:14:37 kent kernel: ------------[ cut here ]------------
Mar  7 02:14:37 kent kernel: kernel BUG at mm/slub.c:294!
Mar  7 02:14:37 kent kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
Mar  7 02:14:37 kent kernel: CPU: 0 PID: 2586 Comm: rfkill Tainted: G         C
       4.19.107-kent #1
Mar  7 02:14:37 kent kernel: Hardware name: LENOVO 81EU/LNVNB161216, BIOS
7PCN35WW 09/25/2018
Mar  7 02:14:37 kent kernel: RIP: 0010:__slab_free.isra.20+0x1b8/0x290
Mar  7 02:14:37 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Mar  7 02:14:37 kent kernel: RSP: 0018:ffffaaf146b0fcc0 EFLAGS: 00010246
Mar  7 02:14:37 kent kernel: RAX: ffff9a160521b200 RBX: ffff9a160521b200 RCX:
ffff9a160521b200
Mar  7 02:14:37 kent kernel: RDX: 000000008020001c RSI: ffffd9c745148680 RDI:
ffff9a1724d2bb00
Mar  7 02:14:37 kent kernel: RBP: ffffaaf146b0fd50 R08: 0000000000000001 R09:
ffff9a160521b200
Mar  7 02:14:37 kent kernel: R10: 00003847e37e51a5 R11: 0000000000001800 R12:
ffffd9c745148680
Mar  7 02:14:37 kent kernel: R13: ffff9a160521b200 R14: ffff9a1724d2bb00 R15:
0000000000000000
Mar  7 02:14:37 kent kernel: FS:  00007f225c950740(0000)
GS:ffff9a1726a00000(0000) knlGS:0000000000000000
Mar  7 02:14:37 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  7 02:14:37 kent kernel: CR2: 00005560e4d20008 CR3: 0000000137ef4003 CR4:
00000000003606f0
Mar  7 02:14:37 kent kernel: Call Trace:
Mar  7 02:14:37 kent kernel:  ? finish_wait+0x2a/0x60
Mar  7 02:14:37 kent kernel:  ? __hci_cmd_sync_ev+0x20a/0x230
Mar  7 02:14:37 kent kernel:  kmem_cache_free+0x195/0x1c0
Mar  7 02:14:37 kent kernel:  btrtl_shutdown_realtek+0x2b/0x50
Mar  7 02:14:37 kent kernel:  hci_dev_do_close+0x402/0x4c0
Mar  7 02:14:37 kent kernel:  hci_rfkill_set_block+0x37/0x50
Mar  7 02:14:37 kent kernel:  rfkill_set_block+0x8f/0x140
Mar  7 02:14:37 kent kernel:  rfkill_fop_write+0x12a/0x1d0
Mar  7 02:14:37 kent kernel:  __vfs_write+0x31/0x180
Mar  7 02:14:37 kent kernel:  vfs_write+0xa4/0x190
Mar  7 02:14:37 kent kernel:  ksys_write+0x52/0xd0
Mar  7 02:14:37 kent kernel:  do_syscall_64+0x5a/0x190
Mar  7 02:14:37 kent kernel:  ? prepare_exit_to_usermode+0x66/0x90
Mar  7 02:14:37 kent kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Mar  7 02:14:37 kent kernel: RIP: 0033:0x7f225ca3d644
Mar  7 02:14:37 kent kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3
0f 1f 80 00 00 00 00 48 8d 05 b9 50 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
Mar  7 02:14:37 kent kernel: RSP: 002b:00007ffee1a70358 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
Mar  7 02:14:37 kent kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f225ca3d644
Mar  7 02:14:37 kent kernel: RDX: 0000000000000008 RSI: 00007ffee1a70370 RDI:
0000000000000003
Mar  7 02:14:37 kent kernel: RBP: 0000000000000001 R08: 0000000000000003 R09:
00000000000a3490
Mar  7 02:14:37 kent kernel: R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
Mar  7 02:14:37 kent kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
Mar  7 02:14:37 kent kernel: Modules linked in: r8822be(C)
Mar  7 02:14:37 kent kernel: ---[ end trace 7e5fda7ca4b18e7f ]---
Mar  7 02:14:37 kent kernel: RIP: 0010:__slab_free.isra.20+0x1b8/0x290
Mar  7 02:14:37 kent kernel: Code: 75 6a 80 7c 24 4b 00 79 05 40 84 f6 74 1e 48
8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 4c 24 4b 80 4d 89 ef e9 03 ff ff
ff <0f> 0b 48 8d 65 d8 4c 89 e6 4c 89 f7 ba 01 00 00 00 5b 41 5c 41 5d
Mar  7 02:14:37 kent kernel: RSP: 0018:ffffaaf146b0fcc0 EFLAGS: 00010246
Mar  7 02:14:37 kent kernel: RAX: ffff9a160521b200 RBX: ffff9a160521b200 RCX:
ffff9a160521b200
Mar  7 02:14:37 kent kernel: RDX: 000000008020001c RSI: ffffd9c745148680 RDI:
ffff9a1724d2bb00
Mar  7 02:14:37 kent kernel: RBP: ffffaaf146b0fd50 R08: 0000000000000001 R09:
ffff9a160521b200
Mar  7 02:14:37 kent kernel: R10: 00003847e37e51a5 R11: 0000000000001800 R12:
ffffd9c745148680
Mar  7 02:14:37 kent kernel: R13: ffff9a160521b200 R14: ffff9a1724d2bb00 R15:
0000000000000000
Mar  7 02:14:37 kent kernel: FS:  00007f225c950740(0000)
GS:ffff9a1726a00000(0000) knlGS:0000000000000000
Mar  7 02:14:37 kent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  7 02:14:37 kent kernel: CR2: 00005560e4d20008 CR3: 0000000137ef4003 CR4:
00000000003606f0
Mar  7 02:14:41 kent kernel: PM: suspend entry (deep)
Mar  7 02:15:01 kent kernel: PM: Syncing filesystems ... done.
Mar  7 02:15:01 kent kernel: Freezing user space processes ...
Mar  7 02:15:01 kent kernel: Freezing of tasks failed after 20.004 seconds (1
tasks refusing to freeze, wq_busy=0):
Mar  7 02:15:01 kent kernel: rfkill          D    0  2586   2550 0x80080006
Mar  7 02:15:01 kent kernel: Call Trace:
Mar  7 02:15:01 kent kernel:  ? __schedule+0x248/0x760
Mar  7 02:15:01 kent kernel:  schedule+0x2a/0x80
Mar  7 02:15:01 kent kernel:  schedule_preempt_disabled+0xc/0x20
Mar  7 02:15:01 kent kernel:  __mutex_lock.isra.1+0x1ff/0x4f0
Mar  7 02:15:01 kent kernel:  rfkill_fop_release+0x1c/0xa0
Mar  7 02:15:01 kent kernel:  __fput+0x9d/0x1c0
Mar  7 02:15:01 kent kernel:  task_work_run+0x8a/0xb0
Mar  7 02:15:01 kent kernel:  do_exit+0x39a/0xaa0
Mar  7 02:15:01 kent kernel:  ? ksys_write+0x52/0xd0
Mar  7 02:15:01 kent kernel:  rewind_stack_do_exit+0x17/0x20
Mar  7 02:15:01 kent kernel: OOM killer enabled.
Mar  7 02:15:01 kent kernel: Restarting tasks ... done.
Mar  7 02:15:01 kent kernel: PM: suspend exit
Mar  7 02:15:02 kent kernel: PM: suspend entry (deep)
Mar  7 02:15:22 kent kernel: PM: Syncing filesystems ... done.
Mar  7 02:15:22 kent kernel: Freezing user space processes ...
Mar  7 02:15:22 kent kernel: Freezing of tasks failed after 20.003 seconds (1
tasks refusing to freeze, wq_busy=0):
Mar  7 02:15:22 kent kernel: rfkill          D    0  2586   2550 0x80080006
Mar  7 02:15:22 kent kernel: Call Trace:
Mar  7 02:15:22 kent kernel:  ? __schedule+0x248/0x760
Mar  7 02:15:22 kent kernel:  schedule+0x2a/0x80
Mar  7 02:15:22 kent kernel:  schedule_preempt_disabled+0xc/0x20
Mar  7 02:15:22 kent kernel:  __mutex_lock.isra.1+0x1ff/0x4f0
Mar  7 02:15:22 kent kernel:  rfkill_fop_release+0x1c/0xa0
Mar  7 02:15:22 kent kernel:  __fput+0x9d/0x1c0
Mar  7 02:15:22 kent kernel:  task_work_run+0x8a/0xb0
Mar  7 02:15:22 kent kernel:  do_exit+0x39a/0xaa0
Mar  7 02:15:22 kent kernel:  ? ksys_write+0x52/0xd0
Mar  7 02:15:22 kent kernel:  rewind_stack_do_exit+0x17/0x20
Mar  7 02:15:22 kent kernel: OOM killer enabled.
Mar  7 02:15:22 kent kernel: Restarting tasks ... done.
Mar  7 02:15:22 kent kernel: PM: suspend exit
Mar  7 02:15:23 kent kernel: PM: suspend entry (deep)
Mar  7 02:15:43 kent kernel: PM: Syncing filesystems ... done.
Mar  7 02:15:43 kent kernel: Freezing user space processes ...
Mar  7 02:15:43 kent kernel: Freezing of tasks failed after 20.004 seconds (1
tasks refusing to freeze, wq_busy=0):
Mar  7 02:15:43 kent kernel: rfkill          D    0  2586   2550 0x80080006
Mar  7 02:15:43 kent kernel: Call Trace:
Mar  7 02:15:43 kent kernel:  ? __schedule+0x248/0x760
Mar  7 02:15:43 kent kernel:  schedule+0x2a/0x80
Mar  7 02:15:43 kent kernel:  schedule_preempt_disabled+0xc/0x20
Mar  7 02:15:43 kent kernel:  __mutex_lock.isra.1+0x1ff/0x4f0
Mar  7 02:15:43 kent kernel:  rfkill_fop_release+0x1c/0xa0
Mar  7 02:15:43 kent kernel:  __fput+0x9d/0x1c0
Mar  7 02:15:43 kent kernel:  task_work_run+0x8a/0xb0
Mar  7 02:15:43 kent kernel:  do_exit+0x39a/0xaa0
Mar  7 02:15:43 kent kernel:  ? ksys_write+0x52/0xd0
Mar  7 02:15:43 kent kernel:  rewind_stack_do_exit+0x17/0x20
Mar  7 02:15:43 kent kernel: OOM killer enabled.
Mar  7 02:15:43 kent kernel: Restarting tasks ... done.
Mar  7 02:15:43 kent kernel: PM: suspend exit
Mar  7 02:15:44 kent kernel: PM: suspend entry (deep)
Mar  7 02:16:04 kent kernel: PM: Syncing filesystems ... done.
Mar  7 02:16:05 kent kernel: Freezing user space processes ...
Mar  7 02:16:05 kent kernel: Freezing of tasks failed after 20.005 seconds (1
tasks refusing to freeze, wq_busy=0):
Mar  7 02:16:05 kent kernel: rfkill          D    0  2586   2550 0x80080006
Mar  7 02:16:05 kent kernel: Call Trace:
Mar  7 02:16:05 kent kernel:  ? __schedule+0x248/0x760
Mar  7 02:16:05 kent kernel:  schedule+0x2a/0x80
Mar  7 02:16:05 kent kernel:  schedule_preempt_disabled+0xc/0x20
Mar  7 02:16:05 kent kernel:  __mutex_lock.isra.1+0x1ff/0x4f0
Mar  7 02:16:05 kent kernel:  rfkill_fop_release+0x1c/0xa0
Mar  7 02:16:05 kent kernel:  __fput+0x9d/0x1c0
Mar  7 02:16:05 kent kernel:  task_work_run+0x8a/0xb0
Mar  7 02:16:05 kent kernel:  do_exit+0x39a/0xaa0
Mar  7 02:16:05 kent kernel:  ? ksys_write+0x52/0xd0
Mar  7 02:16:05 kent kernel:  rewind_stack_do_exit+0x17/0x20
Mar  7 02:16:05 kent kernel: OOM killer enabled.
Mar  7 02:16:05 kent kernel: Restarting tasks ... done.
Mar  7 02:16:05 kent kernel: PM: suspend exit
Mar  7 02:16:06 kent kernel: PM: suspend entry (deep)
Mar  7 02:16:26 kent kernel: PM: Syncing filesystems ... done.
Mar  7 02:16:26 kent kernel: Freezing user space processes ...
Mar  7 02:16:26 kent kernel: Freezing of tasks failed after 20.009 seconds (1
tasks refusing to freeze, wq_busy=0):

... etc ...

Mar  7 02:22:25 kent kernel:  rewind_stack_do_exit+0x17/0x20
Mar  7 02:22:25 kent kernel: OOM killer enabled.
Mar  7 02:22:25 kent kernel: Restarting tasks ... done.
Mar  7 02:22:25 kent kernel: PM: suspend exit

-- 
You are receiving this mail because:
You are the assignee for the bug.
