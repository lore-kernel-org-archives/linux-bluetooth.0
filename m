Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1E0224B1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 17:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgLXRBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Dec 2020 12:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgLXRBg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Dec 2020 12:01:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2828A22512
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Dec 2020 17:00:56 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Thu, 24 Dec 2020 17:00:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: nizzi@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-dkl7pjq6H7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210681

--- Comment #8 from Lorenzo N (nizzi@outlook.com) ---
(In reply to anthony from comment #7)
> (In reply to Lorenzo N from comment #5)
> > (In reply to anthony from comment #2)
> > > Seems to be enough keep only the previous drivers/bluetooth/btusb.c file
> > 
> > Yep, from what I have understood that's the file that needs to be edited.
> 
> before compiling try to revert the commit (see above), for me it worked on
> 5.10.x kernels

Glad it did. I'll see if this fix will be implemented. Otherwise I'll stick
with 5.9 till I'll be forced to update :)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
