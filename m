Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1FC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 02:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647642075E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 02:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfC0CKG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:10:06 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:42380 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbfC0CKG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 22:10:06 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 30D1728C95
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2019 02:10:06 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 21CE628D9C; Wed, 27 Mar 2019 02:10:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198699] Kernel regularly logs: Bluetooth: hci0: last event is
 not cmd complete (0x0f)
Date:   Wed, 27 Mar 2019 02:10:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daniel.van.vugt@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198699-62941-xFJv8jG9Z1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198699-62941@https.bugzilla.kernel.org/>
References: <bug-198699-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=198699

Daniel van Vugt (daniel.van.vugt@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |daniel.van.vugt@canonical.c
                   |                            |om

--- Comment #26 from Daniel van Vugt (daniel.van.vugt@canonical.com) ---
Comment 24 suggests to me that this bug should be closed (?). Because it seems
to eliminate the possibility of the message appearing with (0x0f).

-- 
You are receiving this mail because:
You are the assignee for the bug.
