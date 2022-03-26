Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 13:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiCZN4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCZN4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 09:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E72612D
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 06:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D378B60E93
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 13:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFAAC340F0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648302905;
        bh=3GNBNUmlI73okecS49/FDSbq62z3YaVisksY19WGSGo=;
        h=From:To:Subject:Date:From;
        b=jamCgZMKJqMNR3pTl17cj0cDcpoDsmUi0x0RpbqbYJDxFbXbkHdg3erSw/3WXJoDq
         VriFCKfsnolsz+nmmSIz6eNsmZck1rz+nhGGI5r/qHcUyqMZ67oc6Ir+t3Kj/tFaSN
         b6LsoWENrPu13E0mszlX8o9iUArbOTk6GGr9Bw7agGOZE6RooI13I6947Mm/QNnvg3
         jR6DOw4h+H+ky9ADsa3E4LpMj8bycNWGcO5vb/zdLXkRnilR0oaWoyEwMDVP+KRUll
         okR5lpHYFNLx5FqGUnG/eUZGY8L3Ld5F52Hp6vKviR3Jf8E+H8bNj2QCWCkkXkPcaa
         IRBfqSqqwkukA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 26861C05FD0; Sat, 26 Mar 2022 13:55:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215746] New: rfcomm: WARNING: possible circular locking
 dependency detected: rfcomm_sk_state_change <-> rfcomm_run
Date:   Sat, 26 Mar 2022 13:55:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: travneff@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215746-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215746

            Bug ID: 215746
           Summary: rfcomm: WARNING: possible circular locking dependency
                    detected: rfcomm_sk_state_change <-> rfcomm_run
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: travneff@gmail.com
        Regression: No

Created attachment 300617
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300617&action=3Dedit
my changes on 5.17

I have this kernel trace often while connecting bluetooth headphones:

     WARNING: possible circular locking dependency detected
     5.17.0+ #1 Tainted: G        W=20=20=20=20=20=20=20=20
     ------------------------------------------------------
     krfcommd/2671 is trying to acquire lock:
     ffff9c11062c7940 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:
rfcomm_sk_state_change+0x4d/0x120 [rfcomm]

     but task is already holding lock:
     ffff9c10a0360f40 (&d->lock){+.+.}-{3:3}, at: rfcomm_run+0x1342/0x1860
[rfcomm]

     which lock already depends on the new lock.


     the existing dependency chain (in reverse order) is:

     -> #2 (&d->lock){+.+.}-{3:3}:
            __mutex_lock+0x93/0x840
            rfcomm_run+0x1342/0x1860 [rfcomm]
            kthread+0xf5/0x120
            ret_from_fork+0x22/0x30

     -> #1 (rfcomm_mutex){+.+.}-{3:3}:
            __mutex_lock+0x93/0x840
            rfcomm_dlc_open+0x30/0x340 [rfcomm]
            rfcomm_sock_connect+0xd5/0x130 [rfcomm]
            __sys_connect+0xb9/0xe0
            __x64_sys_connect+0x14/0x20
            do_syscall_64+0x3a/0x80
            entry_SYSCALL_64_after_hwframe+0x44/0xae

     -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
            __lock_acquire+0x1429/0x2410
            lock_acquire+0xc3/0x2c0
            lock_sock_nested+0x2e/0x80
            rfcomm_sk_state_change+0x4d/0x120 [rfcomm]
            rfcomm_run+0x135e/0x1860 [rfcomm]
            kthread+0xf5/0x120
            ret_from_fork+0x22/0x30

     other info that might help us debug this:

     Chain exists of:
       sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM --> rfcomm_mutex --> &d->lock

      Possible unsafe locking scenario:

            CPU0                    CPU1
            ----                    ----
       lock(&d->lock);
                                    lock(rfcomm_mutex);
                                    lock(&d->lock);
       lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);

      *** DEADLOCK ***

     2 locks held by krfcommd/2671:
      #0: ffffffffc0acf130 (rfcomm_mutex){+.+.}-{3:3}, at:
rfcomm_run+0x135/0x1860 [rfcomm]
      #1: ffff9c10a0360f40 (&d->lock){+.+.}-{3:3}, at: rfcomm_run+0x1342/0x=
1860
[rfcomm]

     stack backtrace:
     CPU: 5 PID: 2671 Comm: krfcommd Tainted: G        W         5.17.0+ #1
     Hardware name: ASUS System Product Name/TUF GAMING B550M-PLUS, BIOS 24=
23
08/10/2021
     Call Trace:
      <TASK>
      dump_stack_lvl+0x4c/0x60
      check_noncircular+0xe0/0x100
      __lock_acquire+0x1429/0x2410
      lock_acquire+0xc3/0x2c0
      ? rfcomm_sk_state_change+0x4d/0x120 [rfcomm]
      ? rfcomm_run+0x1342/0x1860 [rfcomm]
      lock_sock_nested+0x2e/0x80
      ? rfcomm_sk_state_change+0x4d/0x120 [rfcomm]
      rfcomm_sk_state_change+0x4d/0x120 [rfcomm]
      rfcomm_run+0x135e/0x1860 [rfcomm]
      ? __init_waitqueue_head+0x60/0x60
      ? _raw_spin_unlock_irqrestore+0x3b/0x60
      ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
      kthread+0xf5/0x120
      ? kthread_complete_and_exit+0x20/0x20
      ret_from_fork+0x22/0x30
      </TASK>

Kernel is tainted because of another bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D215740

BT hardware: ID 0b05:17cb ASUSTek Computer, Inc. Broadcom BCM20702A0 Blueto=
oth

Kernel is built from
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
at v5.17 tag (f443e374ae131c168a065ea1748feac6b2e76613)
with couple of simple changes, adding them here just in case.

Also reproduces for my distro kernel:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1948294

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
