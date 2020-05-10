Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D187C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A43B2082E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgEJQOI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 12:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgEJQOH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 12:14:07 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 10 May 2020 16:14:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: m.novosyolov@rosalinux.ru
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-gidtqrNI80@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #70 from Mikhail Novosyolov (m.novosyolov@rosalinux.ru) ---
(In reply to Sergey Kondakov from comment #69)
> It's detectable but the only device I tested it was Sony DualShock 4 which
> acts as master that connects PC to itself which uses "sixaxis" hacks in
> bluez. And, in the end, it was a failure: DS4 does not want to pass input
> data and then promptly shuts itself off after "pairing". It does work under
> Windows® with that dongle but on Linux I had to resort to old BT 2.1 one.
Thanks for clearyfying.
> The more important thing is "fixup" parameter patches that allow to at
> select hacks per device and at least figure out what it needs without
> recompiling and rebooting kernel every time. But, apparently, BT maintainer
> is not interested in BT stack being as robust and easy to test as USB either.
+1, it would be very good if users who do not know how to build kernels could
easily participate in testing different hacks for hardware that they have.
For example, I came to this bug because a user of the distro package of kernel
which I am maintaining asked how he can build the kernel with that patch
(https://forum.rosalinux.ru/viewtopic.php?t=10066)
I had to read this bug and then just tell the user that I do not see sense in
spending time to test this patch (include it into the package, build it, give
him instructions how to install the build). Nobody benefits from the fact that
an owner of hardware is not able to participate in hardware enablement in the
kernel.

On the other hand, opportunity to make such hacks in the kernel module config
by the user may lead to that kernel will not have many needed hacks out of the
box, users will just copy-paste device-specific solutions from the internet,
then somebody will add them to e.g. systemd's hwdb. It is not good when some
device-specific options are hard-coded in the driver and some are in other
places like systemd's hwdb.

-- 
You are receiving this mail because:
You are the assignee for the bug.
