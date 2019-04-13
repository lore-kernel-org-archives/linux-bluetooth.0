Return-Path: <SRS0=zpSD=SP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807DC10F11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1562147A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDMRX2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:23:28 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43394 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbfDMRX2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Apr 2019 13:23:28 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 245A428C4D
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2019 17:23:27 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 18D5F28C2C; Sat, 13 Apr 2019 17:23:27 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199035] BCM2046B1 and hid2hci generates highcpu usage due to
 udev since 4.14 kernel
Date:   Sat, 13 Apr 2019 17:23:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jgwphd@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-199035-62941-k8LzPuV5tR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199035-62941@https.bugzilla.kernel.org/>
References: <bug-199035-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199035

--- Comment #14 from John (jgwphd@yahoo.com) ---
An update: The problem I reported in January went away on its own after a few
weeks of having the problem every single day when I booted each morning. I was
installing Ubuntu software updates when they became available during that time.
There is something going on during boot that causes this problem. 

"my speculation" is that I suspect a timing issue with the way things are
initialized during boot up that leads to the problem. Some strange timing issue
is occurring which causes systemd-udevd to fall into an infinite loop
(continuously looking for something or to be notified about an action
completion) and drive one of the processor cores to 100%. When a new kernel was
installed or something was done to change initialization activity during boot
the problem went away because the timing problem that created it was changed. I
believe that some kind of race condition may be at the root of the problem.

From my earlier search on the problem symptoms, it seems that when
systemd-udevd isn't working correctly you can get numerous confusing symptoms
that mysteriously go away when the something changes timing conditions during
boot. Since the problem is in the kernel then it effects other systems besides
Ubuntu.

-- 
You are receiving this mail because:
You are the assignee for the bug.
