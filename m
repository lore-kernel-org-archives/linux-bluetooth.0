Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BDFC3526D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB7123A82
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgLSUAf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Dec 2020 15:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgLSUAf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Dec 2020 15:00:35 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208965] not working bluetooth mouse low energy rtl8822ce
Date:   Sat, 19 Dec 2020 19:59:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: forum.viennet@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208965-62941-mb9ETJshEc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208965-62941@https.bugzilla.kernel.org/>
References: <bug-208965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208965

--- Comment #48 from Olivier V (forum.viennet@free.fr) ---
I bisected the bug on the rtl8822ce here :
https://bugzilla.kernel.org/show_bug.cgi?id=210453

It seems to bee the same problem linked to "rpa".


meloli@Asus-A17:~/Bureau/meloli/GITBISECT/linux$ git bisect bad
b2cc23398e8166b38f8715026273503b081c2a7a is the first bad commit
commit b2cc23398e8166b38f8715026273503b081c2a7a
Author: Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu Jul 23 18:09:02 2020 +0530

    Bluetooth: Enable RPA Timeout

    Enable RPA timeout during bluetooth initialization.
    The RPA timeout value is used from hdev, which initialized from
    debug_fs

    Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

$ git checkout b2cc23398e8166b38f8715026273503b081c2a7a
# give a bad kernel

$ git checkout b2cc23398e8166b38f8715026273503b081c2a7a^
# give a good kernel

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
