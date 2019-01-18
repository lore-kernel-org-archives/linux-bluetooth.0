Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D08C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DBC2087E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 07:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfARHWO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:22:14 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:53194 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfARHWO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 02:22:14 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1BF182D869
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 07:22:13 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 07F962EAA9; Fri, 18 Jan 2019 07:22:13 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198699] Kernel regularly logs: Bluetooth: hci0: last event is
 not cmd complete (0x0f)
Date:   Fri, 18 Jan 2019 07:22:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johan.hedberg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198699-62941-xVLYoeNY57@https.bugzilla.kernel.org/>
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

Johan Hedberg (johan.hedberg@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |johan.hedberg@gmail.com

--- Comment #24 from Johan Hedberg (johan.hedberg@gmail.com) ---
The "last event is not cmd complete" is in most/all cases a red herring, so
please don't focus on that. There's a patch in mainline that will remove it for
all valid situations (i.e. when the command completed with command status
instead of command complete):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1629db9c75342325868243d6bca5853017d91cf8

It seems like this issue has probably lots of different bugs mixed into it, all
incorrectly attributing themselves to this misleading warning message, when in
fact there's something unrelated going wrong. Those that are experiencing
issues even after applying the patch I referred to, please open new issues,
especially if the "last event is not cmd complete" message goes away for you
with the patch. This one can probably be closed since the misleading message
should now be gone.

-- 
You are receiving this mail because:
You are the assignee for the bug.
