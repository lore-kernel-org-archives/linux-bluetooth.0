Return-Path: <SRS0=zpSD=SP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6EC10F11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00927208E3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 18:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfDMSac convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:30:32 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45070 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbfDMSac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Apr 2019 14:30:32 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 953A628C07
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2019 18:30:31 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 8951728CE6; Sat, 13 Apr 2019 18:30:31 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199035] BCM2046B1 and hid2hci generates highcpu usage due to
 udev since 4.14 kernel
Date:   Sat, 13 Apr 2019 18:30:30 +0000
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
Message-ID: <bug-199035-62941-OHczqYHxS5@https.bugzilla.kernel.org/>
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

--- Comment #16 from John (jgwphd@yahoo.com) ---
These nerd-level suggestions all work but the root cause (the real problem) is
not solved and will pop up again. How is the non-nerd supposed to do this?
...would you want your neighbor editing your system files????  Someone needs to
fix this permanently!

-- 
You are receiving this mail because:
You are the assignee for the bug.
