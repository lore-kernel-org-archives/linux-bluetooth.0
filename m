Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E80B207CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 10:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgL2Kuv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Dec 2020 05:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgL2Kuv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Dec 2020 05:50:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 874C8208BA
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Dec 2020 10:50:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Tue, 29 Dec 2020 10:50:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: brad@pocketinnovations.com.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-210681-62941-pQZx4HWyOB@https.bugzilla.kernel.org/>
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

Bradley Jarvis (brad@pocketinnovations.com.au) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |brad@pocketinnovations.com.
                   |                            |au

--- Comment #10 from Bradley Jarvis (brad@pocketinnovations.com.au) ---
Created attachment 294393
  --> https://bugzilla.kernel.org/attachment.cgi?id=294393&action=edit
fix hci0: don't support firmware rome error

Avoid returning error code when bluetooth version match is not made from
qca_devices_table and version high is set.

This reverts an error check that was removed to support WCN6855 which does have
the high version set. The fix is to move the check after the table is scanned
and no version match is made.

This fix will still produce the error message for example (for ATK3K 13d3:3402
IMC Networks Bluetooth USB Host Controller)

Bluetooth: hci0: don't support firmware rome 0x1020200

But the bluetooth hardware still works as it used to

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
