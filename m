Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B0FC00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 00:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiHKArt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 20:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiHKArs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 20:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C0844DD
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 17:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C93C7B81247
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 00:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559EFC433C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 00:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660178865;
        bh=FCLQv0C7+1B66Mizpe5nTwX5ebeDHhfl79KjMLYTo7E=;
        h=From:To:Subject:Date:From;
        b=f4jAXiWSLTo1l/QRsWaOH/53RNSj3Yhmjl9P3rHW6h+oTwD2/eAh1Zh0sLomWrkLo
         TjBy+puHIOjJy4IiXJh7pk1mqDG1lEOqgWBTNg4vQWqOCkjYPpWR6NKWlzPBErJ/bJ
         Qy6hWajjjd+lELzZOMZ6Wi3NqGWuJHsN3fmYbyInJu+q5lnf/uUBIKClEMDzpX9N+I
         4VYY57j3ILD8aEzOACic7P37TzzftWf31ydG1UK8uZWZVxR0Po8LrwuDxX+sO8tVT5
         Hjbidn6exXJ07FwqZ8Pnzn2aYHWLeRnwiR8YZj8Uc/f9QngomOsVuN4Gf/UuEYZIzY
         POOSdME9g3N4A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 42914C433E9; Thu, 11 Aug 2022 00:47:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] New: [BISECTED] 250 ms system suspend performance
 regression
Date:   Thu, 11 Aug 2022 00:47:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216352-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216352

            Bug ID: 216352
           Summary: [BISECTED] 250 ms system suspend performance
                    regression
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.19
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: lenb@kernel.org
        Regression: No

My skylake laptop suspends with median performance of 427 ms
up through 5.19-rc8.

After this commit, median performance slows to 684 ms in 5.19.0.

ef61b6ea154464fefd8a6712d7a3b43b445c3d4a is the first bad commit
commit ef61b6ea154464fefd8a6712d7a3b43b445c3d4a
Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon Jul 25 15:34:21 2022 -0700

    Bluetooth: Always set event mask on suspend

    When suspending, always set the event mask once disconnects are
    successful. Otherwise, if wakeup is disallowed, the event mask is not
    set before suspend continues and can result in an early wakeup.

    Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
    Cc: stable@vger.kernel.org
    Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
