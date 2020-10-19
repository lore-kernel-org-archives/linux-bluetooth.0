Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB6C43457
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9062177B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 11:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJSLvD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 07:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgJSLvC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 07:51:02 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209717] Bluetooth mouse Logitech M720 doesn't work
Date:   Mon, 19 Oct 2020 11:51:01 +0000
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
Message-ID: <bug-209717-62941-kkCfsTaSAv@https.bugzilla.kernel.org/>
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

--- Comment #4 from Leho Kraav (leho@kraav.com) ---
I downgraded to 5.8.16 and everything seems to be working fine again across my
home / work locations.

So this does not seem to be about BleedingTooth patches, but something deeper
changed during 5.8 -> 5.9 cycle. Unfortunately I don't have to bandwidth to
bisect.

-- 
You are receiving this mail because:
You are the assignee for the bug.
