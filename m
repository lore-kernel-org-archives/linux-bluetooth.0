Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 01:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhLGBbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhLGBbI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 20:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD3C061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 17:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9954B81644
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 01:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54134C004DD
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638840456;
        bh=+gifeAM9BTDu+9eEqNJv/cXipELkeqvDajCw77PI8rE=;
        h=From:To:Subject:Date:From;
        b=Im9odE6oVVPPTTCzRUqWzb1pPdHXzhFx9w4WS9EUqckaVNgaTztT63/BQQyFNHgMv
         ojAACwI19fva4RmVFmib4CbaTIqqHHnm7SlXFZzh5sJrNxKBUzYwAhlmpWrWy2Cwwf
         gEm9zROi3fvoAplsUztvuK9mrSMd5YSdoySjR+Hzw5ZxR2NA/NBz+RMYMiC1vxoZrS
         eZILJrxtKvCaukp2aL14leXPVQcNnQk6ko5ol2nEp6GYacZB3KyNMjYuJlYSq1eyl6
         D45ODqq5shAPjhoM1SFPXT1vVDAtI9/jwpdzdcAI33Rz0Xhc9jOlWLiS0UsIdO4cdO
         zzBRJVHKDx0Lw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2B6C2610C9; Tue,  7 Dec 2021 01:27:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215245] New: KASAN: slab-out-of-bounds in
 hci_event_packet+0x2d8c/0x4e90 [bluetooth]
Date:   Tue, 07 Dec 2021 01:27:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gouhao@uniontech.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215245-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215245

            Bug ID: 215245
           Summary: KASAN: slab-out-of-bounds in
                    hci_event_packet+0x2d8c/0x4e90 [bluetooth]
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gouhao@uniontech.com
        Regression: No

Unknown ioctl -1072131215
Unknown ioctl -1073191904
Unknown ioctl 35123
Bluetooth: hci0: hardware error 0xff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in hci_event_packet+0x2d8c/0x4e90 [bluetooth]
Read of size 3 at addr ffff88817262a77f by task kworker/u17:1/222831
CPU: 1 PID: 222831 Comm: kworker/u17:1 Not tainted
4.19.90-2108.8.0.0106.up5.uel20.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: hci0 hci_rx_work [bluetooth]
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xab/0xee lib/dump_stack.c:118
 print_address_description+0x65/0x270 mm/kasan/report.c:253
 kasan_report_error mm/kasan/report.c:351 [inline]
 kasan_report+0x146/0x290 mm/kasan/report.c:409
 hci_event_packet+0x2d8c/0x4e90 [bluetooth]
 hci_rx_work+0x288/0x510 [bluetooth]
 process_one_work+0x4ca/0x870 kernel/workqueue.c:2148
 worker_thread+0x6e/0x790 kernel/workqueue.c:2303
 kthread+0x1dd/0x200 kernel/kthread.c:275
 ret_from_fork+0x1f/0x40 arch/x86/entry/entry_64.S:415
Allocated by task 222894:
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xa0/0xd0 mm/kasan/kasan.c:553
 slab_post_alloc_hook mm/slab.h:441 [inline]
 slab_alloc_node mm/slub.c:2740 [inline]
 __kmalloc_node_track_caller+0xcb/0x1a0 mm/slub.c:4364
 __kmalloc_reserve.isra.50+0x37/0xa0 net/core/skbuff.c:137
 __alloc_skb+0xd1/0x320 net/core/skbuff.c:205
 vhci_write+0x70/0x265 [hci_vhci]
 call_write_iter include/linux/fs.h:1886 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x2f4/0x430 fs/read_write.c:487
 vfs_write+0x10a/0x290 fs/read_write.c:549
 ksys_write+0xb4/0x190 fs/read_write.c:599
 do_syscall_64+0x96/0x410 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
Freed by task 221695:
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x130/0x180 mm/kasan/kasan.c:521
 slab_free_hook mm/slub.c:1389 [inline]
 slab_free_freelist_hook mm/slub.c:1416 [inline]
 slab_free mm/slub.c:2989 [inline]
 kfree+0x7d/0x140 mm/slub.c:3950
 drm_release+0xf3/0x140 [drm]
 __fput+0x198/0x3f0 fs/file_table.c:278
 task_work_run+0xc0/0x100 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:193 [inline]
 exit_to_usermode_loop+0x121/0x130 arch/x86/entry/common.c:167
 prepare_exit_to_usermode arch/x86/entry/common.c:198 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:271 [inline]
 do_syscall_64+0x359/0x410 arch/x86/entry/common.c:303
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
The buggy address belongs to the object at ffff88817262a580
The buggy address is located 511 bytes inside of
The buggy address belongs to the page:
page:ffffea0005c98a00 count:1 mapcount:0 mapping:ffff888107c0ec00 index:0x0
compound_mapcount: 0
flags: 0x17ffffc0008100(slab|head)
raw: 0017ffffc0008100 ffffea000494cc00 0000000800000008 ffff888107c0ec00
raw: 0000000000000000 0000000080190019 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
 ffff88817262a680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88817262a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88817262a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88817262a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88817262a880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Unknown ioctl -1072667619
Bluetooth: hci0: wrong event for mode 0
Unknown ioctl 19314
Unknown ioctl -1070571007
Unknown ioctl 1074304026
Unknown ioctl 19314

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
