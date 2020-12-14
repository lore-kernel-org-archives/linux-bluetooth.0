Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E51C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 10:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3388C22838
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 10:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407238AbgLNKNo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 05:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgLNKNc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 05:13:32 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199271] AR3012 [0cf3:3004] - Bluetooth: hci0: don't support
 firmware rome 0x31010000.
Date:   Mon, 14 Dec 2020 10:12:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-199271-62941-qCPk1FASe0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199271-62941@https.bugzilla.kernel.org/>
References: <bug-199271-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199271

--- Comment #17 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
(In reply to anthony from comment #16)
> After upgrade kernel to version 5.10:
> 
> kernel: Bluetooth: hci0: don't support firmware rome 0x31010000
> 
> previous kernel 5.9.13 was ok.

The last activity on this bug was more then 2 years ago, so this sounds like a
comletely new (introduced in 5.10) and unrelated problem. Please file a new bug
for this.

-- 
You are receiving this mail because:
You are the assignee for the bug.
