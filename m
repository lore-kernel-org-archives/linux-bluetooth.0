Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE45C10F0C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70420684
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 07:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCHH1F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:27:05 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48236 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfCHH1E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 02:27:04 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C13872E614
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2019 07:27:03 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id AEE102E618; Fri,  8 Mar 2019 07:27:03 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202429] No Bluetooth Adapter on boot - Works after woken up
 from suspend/sleep - Intel Ac 9260
Date:   Fri, 08 Mar 2019 07:27:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: cordleztoaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202429-62941-4grHZ7HO9L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202429-62941@https.bugzilla.kernel.org/>
References: <bug-202429-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202429

--- Comment #4 from Tp (cordleztoaster@gmail.com) ---
Intels response on the issue:


Here is a summary of the engineering actions, results of our efforts, and
recommended next steps:

We were able to track down the same system and reproduce the issue
We were able to successfully enable our BT device in the system after boot up,
which points to something in system boot/power sequence preventing BT from
enabling
The RTK 3rd party module exhibited the same behavior as our Intel module, which
points to a system level setting that doesn’t allow for any device to be used
other than what ships with the platform (Qualcomm card) – thought to be likely
due to BIOS or Linux Kernel rule setting
We checked with Lenovo as they used to have a BIOS setting that wouldn’t allow
another adapter to work (called mutual authentication), but this was removed a
few years ago
Unfortunately we cannot debug any further on this as we do not have access to
the proprietary code needed to do further debug. Our best recommendation is to
take the engineering debug analysis we have been able to provide above and
contact Lenovo to determine if they will conduct further testing to determine
the boot/power up setting that is preventing the BT from being enabled. Please
be aware that our card was never validated on this platform since it’s not an
approved platform combination from Lenovo, and so they may not see this issue
as one that needs to be resolved.

-- 
You are receiving this mail because:
You are the assignee for the bug.
