Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BFCC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 09:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EBA20844
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 09:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfBFJHX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:07:23 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:47782 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbfBFJHX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 04:07:23 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1E0752AC28
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 09:07:22 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 126622AC9F; Wed,  6 Feb 2019 09:07:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Wed, 06 Feb 2019 09:07:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: master.homer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202515-62941-xtWcK5SV5C@https.bugzilla.kernel.org/>
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

--- Comment #3 from Mathias Tillman (master.homer@gmail.com) ---
I believe it is using the latest firmware, I haven't been able to find a later
one than the one mentioned in the kernel log anyway:
[    6.478466] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[    8.361085] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-18-16-1.ddc

And yeah, the controller clearly reports that the Extended Create Connection
command is available, so it is a bit odd that it's not working correctly. I
suppose the only way to find out why would be to debug the controller, but I
have no idea how one would go about doing that.

I haven't found this issue being reported at all, so I don't know if it's just
my card, or if all of them have this issue. I know the 9260 is commonly used in
laptops, but I couldn't say to what extent. Perhaps there is someone who has
this card that could test, and if it is in fact broken, add a quirk as you
suggested that would force legacy mode?

-- 
You are receiving this mail because:
You are the assignee for the bug.
