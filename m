Return-Path: <SRS0=B4Et=OZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B92C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Dec 2018 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA63206C2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Dec 2018 06:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeLPGee convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Dec 2018 01:34:34 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45950 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729709AbeLPGee (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Dec 2018 01:34:34 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 46A8628521
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Dec 2018 06:34:33 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3B14829C31; Sun, 16 Dec 2018 06:34:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198303] Bluetooth dies after a while.
Date:   Sun, 16 Dec 2018 06:34:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: rishel.nick@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-198303-62941-KbeefU3q1X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198303-62941@https.bugzilla.kernel.org/>
References: <bug-198303-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=198303

--- Comment #5 from Nick (rishel.nick@gmail.com) ---
Created attachment 280027
  --> https://bugzilla.kernel.org/attachment.cgi?id=280027&action=edit
btmon.log

Experiencing the same issue as the original reporter. Attached is the result of
the btmon.log command, where the error occurred ~1-3 seconds after the error
occurred.

-- 
You are receiving this mail because:
You are the assignee for the bug.
