Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80425C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8290320675
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 22:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgEMW7J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 18:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgEMW7J (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 18:59:09 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207629] BISECTED Bluetooth: hci0: command 0x2042 tx timeout -
 suspend fails - Dell XPS 9300, Dell XPS 7390, Dell Inspiron 7386, Intel
 NUC7JYB
Date:   Wed, 13 May 2020 22:59:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207629-62941-nGnGCzfvJA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207629-62941@https.bugzilla.kernel.org/>
References: <bug-207629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207629

--- Comment #16 from Len Brown (lenb@kernel.org) ---
re: firmware

dmesg showed this:

[    7.833706] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.835192] Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
[    9.324793] Bluetooth: hci0: Waiting for firmware download to complete
[    9.325473] Bluetooth: hci0: Firmware loaded in 1459099 usecs
[    9.355517] Bluetooth: hci0: Firmware revision 0.0 build 62 week 31 2019

even though there are apparently higher numbered of ibt in /lib/firmware/intel.

I downloaded linux-firmware-c5ac1add86be7a90d0c573c957e37c610f3d7f25.tar.gz
and I replaced /lib/firmware/intel/ with the new copy, but it appears
that the driver did not find a newer version for this device:

[    7.766736] Bluetooth: hci0: Firmware revision 0.0 build 62 week 31 2019

What am I missing?

In any case, a bunch of machines are failing with the firmware that they are
running, when they used to work before this regression, and so this appears to
be more of a Linux regression, than a device-specific firmware issue?

-- 
You are receiving this mail because:
You are the assignee for the bug.
