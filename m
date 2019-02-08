Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44050C169C4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 21:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F75218D2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 21:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBHVjb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:39:31 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:56830 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfBHVjb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Feb 2019 16:39:31 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 980992DE99
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Feb 2019 21:39:30 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 850282DF20; Fri,  8 Feb 2019 21:39:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Fri, 08 Feb 2019 21:39:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: master.homer@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-202515-62941-MBcct6Zop8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202515-62941@https.bugzilla.kernel.org/>
References: <bug-202515-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202515

Mathias Tillman (master.homer@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #17 from Mathias Tillman (master.homer@gmail.com) ---
To make a long story short, I've managed to figure it out: the latest firmware
actually fixes it, but for some reason it's not actually loaded on to the
controller until I shut down the computer and leave it off for around 10
seconds or so. A simple reboot isn't enough for it to load the new firmware.

I verified this by doing a cold boot with the distro firmware, copying over the
new firmware then rebooting several times. None of these times was the LE Set
Extended Scan Parameters reported as being supported. I then shut down the
computer and turned it on again after roughly 10 seconds, and after that the
command was reported. I then copied over the distro firmware, rebooted several
times and it was still working. Turned off the computer and on again, and it no
longer worked.

So aside from that odd firmware loading requiring a cold boot, it seems to be
working as expected without a patched kernel.

Thanks for the replies everyone, and sorry for all of the long-winded messages.
I will be marking this as resolved now.

-- 
You are receiving this mail because:
You are the assignee for the bug.
