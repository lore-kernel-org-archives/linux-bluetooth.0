Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Nov 2021 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhKUP6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Nov 2021 10:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238424AbhKUP6K (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Nov 2021 10:58:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1070860698
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Nov 2021 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637510105;
        bh=Q9H9wm89scTmsSQBs9zwFvmHtDzQ1KmLLbtJxeJhOjM=;
        h=From:To:Subject:Date:From;
        b=MNRjsgkEvgPDwOZvQcGqfta4HgGnA6yRyas5xBSw8MuDLG0irECXh+z+tGxLBmsOr
         uXx82Imu7YBIA4yBCbvK28fSg0AQl70QhWAWfJHtEdJ7ItI9Ii5buanQBTk51Bx9Su
         NrJ3QeV3Xaoc1/050OVA+jYHwzZRtbmENpRT/b04L30TktdUlmSg9p8Z0QszoMdzdk
         iq+9XDHDTM/XwWgmrq9yQOdSxbir7DELYKEsmzPSJ44BuB6m1SaiO7QQllMFPcwATq
         sZ9Gi0ouq91c2/XIi6qq7maS+64nsKEeI1LQHZkLo6CJ9j3RLbugKUhOWqHPDw5ACD
         2rZyQVQi/xmcA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id F0AE060ED3; Sun, 21 Nov 2021 15:55:04 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215089] New: local struct uinput_event inconsistency with
 kernel y2038 safe struct input_event: AVRCP events vanish on 32-bit
Date:   Sun, 21 Nov 2021 15:55:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: spam@ipik.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215089-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215089

            Bug ID: 215089
           Summary: local struct uinput_event inconsistency with kernel
                    y2038 safe struct input_event: AVRCP events vanish on
                    32-bit
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: spam@ipik.org
        Regression: No

Under bluez (up to 5.62) compiled with time64 support (like musl1.2 or poss=
ibly
newer glibc with __USE_TIME_BITS64) on 32-bit systems (x86 or armhf for
instance), AVRCP events just never show-up on input device.

Tools like evtest will not report any event upon bluetooth headset media bu=
tton
keypress, whereas btmon sees them flowing through.

This bug does not hit x86-64 releases, only 32-bit are affected.

Issue has been discussed here [1], with a simple & replicable Alpinelinux 3=
.14
test case (based on musl 1.2).
Legacy local uinput_event struct might not play well with newer time64-aware
input_event kernel structure.



[1] https://github.com/bluez/bluez/issues/84#issuecomment-942155841

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
