Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB2C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 22:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D54020848
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfERWK2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 18:10:28 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43636 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbfERWK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 18:10:28 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E2DB828569
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 22:10:27 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id D05FD28573; Sat, 18 May 2019 22:10:27 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203643] [REGRESSION][BISECTED] Sixaxis gamepad no longer
 connects via Bluetooth
Date:   Sat, 18 May 2019 22:10:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: joakim.soderlund@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203643-62941-fFezuRwKnf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203643-62941@https.bugzilla.kernel.org/>
References: <bug-203643-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203643

JockeTF (joakim.soderlund@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |joakim.soderlund@gmail.com

--- Comment #1 from JockeTF (joakim.soderlund@gmail.com) ---
I can confirm this bug for DualShock 3 as well.

-- 
You are receiving this mail because:
You are the assignee for the bug.
