Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A98C282C4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229BF2175B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGXFD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:05:03 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41404 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfBGXFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Feb 2019 18:05:03 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7682E2A916
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Feb 2019 23:05:02 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 6A9452E449; Thu,  7 Feb 2019 23:05:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202515] Bluetooth LE Extended Connect returning Command
 Disallowed
Date:   Thu, 07 Feb 2019 23:05:01 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-202515-62941-ByqrilVQAR@https.bugzilla.kernel.org/>
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

--- Comment #13 from Mathias Tillman (master.homer@gmail.com) ---
Created attachment 281053
  --> https://bugzilla.kernel.org/attachment.cgi?id=281053&action=edit
Check if ext scanning and ext params are supported independently

As a test I created a patch that removes the set ext scanning params check, and
instead only checks it when actually sending the appropriate command (which is
once in the code).

It's working perfectly now, and it's using the ext scan command, instead of the
regular scan command - which is what caused the Command Disallowed error.

Like I said before, I'm not too familiar with how bt le works, but is there any
case where the set ext scanning params would be a requirement for ext scanning
to work? Of course, working around buggy firmware that sometimes reports a
command as supported, and other times not is far from ideal - but seeing as it
is working for me now, I can't see any reason why the commands should depend on
each other.

-- 
You are receiving this mail because:
You are the assignee for the bug.
