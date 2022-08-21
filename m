Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA1C00140
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Aug 2022 11:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHULuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHULuS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Aug 2022 07:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15E1C135
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 04:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 318C5B80A08
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 11:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF48DC433D7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661082615;
        bh=/wJKc+svlJ92s/rV92WRPjCr3wE4Nh35mzlyVKZ5fNE=;
        h=From:To:Subject:Date:From;
        b=CjIOa2Y9RbEKLOBZ80NfB/RyPXeH8gxqnHWgMEzdq/G4I44OZPTvA4rDFc2i8iaoi
         06FftlQJNtkb8Mu9o/haMYmAxud1dxzrrPF93xgwLFoutrdL8fxWzhjBMHdl/GqmV0
         7MrmCc+eJqly3kr8zqamCPDYSO548fGZIHKLFlNEUGTbm15PVKl9wt+L3fOQMst6XK
         /l3JkPIwXlaJFF/Ba3r+J5fHxLuDPSg6r/gimVErqjEeW8qCC9wZCQQW7Jv1i70Yly
         P5TG1WaSe1APH/ax4HwkTLFC6JPo8Ry5cM12CUTYB79eUC/g+ORLYLzPb1jqbsRxH4
         sLB/9iop+pfoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D89B1C433E6; Sun, 21 Aug 2022 11:50:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216389] New: net/bluetooth/l2cap_core.c fails bounds check with
 GCC 12.2
Date:   Sun, 21 Aug 2022 11:50:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cc cf_regression attachments.created
Message-ID: <bug-216389-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216389

            Bug ID: 216389
           Summary: net/bluetooth/l2cap_core.c fails bounds check with GCC
                    12.2
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19.2
          Hardware: PPC-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: erhard_f@mailbox.org
                CC: marcel@holtmann.org
        Regression: No

Created attachment 301616
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301616&action=3Dedit
kernel .config (5.19.2, Talos II Secure Workstation)

I get this on my Talos II when building v5.19.2. Does not happen with GCC 1=
1.3.

 # make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CHK     include/generated/compile.h
  CC [M]  net/bluetooth/l2cap_core.o
In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/mm_types_task.h:14,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from ./include/linux/module.h:14,
                 from net/bluetooth/l2cap_core.c:31:
In function 'memcmp',
    inlined from 'bacmp' at ./include/net/bluetooth/bluetooth.h:302:9,
    inlined from 'l2cap_global_chan_by_psm' at
net/bluetooth/l2cap_core.c:2002:15:
./include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified
bound 6 exceeds source size 0 [-Werror=3Dstringop-overread]
   44 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
./include/linux/fortify-string.h:420:16: note: in expansion of macro
'__underlying_memcmp'
  420 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249: net/bluetooth/l2cap_core.o] Fehle=
r 1
make[1]: *** [scripts/Makefile.build:466: net/bluetooth] Fehler 2
make: *** [Makefile:1849: net] Fehler 2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
