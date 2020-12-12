Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22FC4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD74E221E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439210AbgLLO5t convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Dec 2020 09:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLLO5e (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Dec 2020 09:57:34 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Sat, 12 Dec 2020 14:56:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kalmaevlv@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-8jSaprdUgx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

Leonid Kalmaev (kalmaevlv@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kalmaevlv@gmail.com

--- Comment #7 from Leonid Kalmaev (kalmaevlv@gmail.com) ---
hi, i am seeing the same problem. I think the reason is the automatic saving of
energy.
In my case, if you use the powertop tool and carefully look at the Tunables
tab, you can find Autosuspend for unknown USB device 1-1.3 (8087: 07dc)
change the state to bad and the problem no longer persists until the next
system reboot.

uname -a
Linux dns-book 5.8.0-33-generic #36~20.04.1-Ubuntu SMP Wed Dec 9 17:01:13 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux

lspci 
07:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)

lsusb
Bus 001 Device 003: ID 8087:07dc Intel Corp.

-- 
You are receiving this mail because:
You are the assignee for the bug.
