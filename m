Return-Path: <SRS0=T6Hm=DZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B5C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BD022240
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJRRY5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Oct 2020 13:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRY5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Oct 2020 13:24:57 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209717] Bluetooth mouse Logitech M720 doesn't work
Date:   Sun, 18 Oct 2020 17:24:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: leho@kraav.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209717-62941-kGeM6QDeyH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209717-62941@https.bugzilla.kernel.org/>
References: <bug-209717-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209717

--- Comment #2 from Leho Kraav (leho@kraav.com) ---
(In reply to Leho Kraav from comment #1)
> Yes, something is wrong with 5.9 bluetooth stack.

PS I went straight to 5.9.1.

00:14.3 Network controller: Intel Corporation Killer Wi-Fi 6 AX1650i 160MHz
Wireless Network Adapter (201NGW) (rev 30) on XPS 7390 2-in-1 Ice Lake.

-- 
You are receiving this mail because:
You are the assignee for the bug.
