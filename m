Return-Path: <SRS0=zpSD=SP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ACC10F11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCEB2147A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Apr 2019 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDMX15 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Apr 2019 19:27:57 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60622 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbfDMX14 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Apr 2019 19:27:56 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 11ECE28C26
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2019 23:27:56 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id EC72C28C59; Sat, 13 Apr 2019 23:27:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199035] BCM2046B1 and hid2hci generates highcpu usage due to
 udev since 4.14 kernel
Date:   Sat, 13 Apr 2019 23:27:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gustavo.willer@hotmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-199035-62941-6rIgN7FfwJ@https.bugzilla.kernel.org/>
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

--- Comment #17 from gustavo.willer@hotmail.com ---
I agree with you, its not the best solution. This bug impact many users! At
next release of this softwares this bug has to be fixed.


But I lost many days to fix this problem, and I'm sharing this 'hard approach'
at forums I had visited before. So other people do not waste so much time!

-- 
You are receiving this mail because:
You are the assignee for the bug.
