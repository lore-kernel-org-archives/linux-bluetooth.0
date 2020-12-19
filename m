Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA2C0018C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA53227BF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgLSTyT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Dec 2020 14:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgLSTyT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Dec 2020 14:54:19 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210001] lenovo ideapad 5 RTL8822CE - built-in bluetooth not
 working
Date:   Sat, 19 Dec 2020 19:53:38 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210001-62941-1MDJXfx465@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210001-62941@https.bugzilla.kernel.org/>
References: <bug-210001-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210001

Olivier V (forum.viennet@free.fr) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |forum.viennet@free.fr

--- Comment #2 from Olivier V (forum.viennet@free.fr) ---
Can be related to this (bisected) bug on rtl 8822cu :
https://bugzilla.kernel.org/show_bug.cgi?id=210453

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
