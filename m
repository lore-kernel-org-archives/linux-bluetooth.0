Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2324C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Feb 2021 06:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F0B64E09
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Feb 2021 06:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhB1G6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Feb 2021 01:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhB1G6y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Feb 2021 01:58:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DF0BC61601
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Feb 2021 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614495493;
        bh=nR605XLYxmM113lkhTAmI86OhfJ2Nt3nV3Z4lTFCOPY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n2WbUEphf+XtFddOixnsl7sgYC7eFU9Vfo5pwmpIsz5X3cJkDmTMxgTfM4u4ZPnxP
         ZWnM42BN9JHsCLLLYov5iR2Jb1emt+7UgWd6GV9uCaN0ogXiPzZr/X3JJ+S+YpuPD3
         3X6zOYgQD/95pIKKKWu1JhoR9AZnkzwKlqHN5PS4ITY2YTOuAgvRccla8WEFbJjtna
         nSik0RdzLkwtTAvniWjAg9kcZnre99UFAPliSUjTCvxR3E8FA2Tu3RK4Rd7jDi2OlX
         6Su0dcKS8pWLe+DSluW+g8e6JBgZdI7axvVbbG2g/OgCtnLXVTP4UL5iomhzrmwsSP
         V+2HDu4glc5/g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211983] BUG: Unable to toggle bluetooth ON once switched off
 using rfkill
Date:   Sun, 28 Feb 2021 06:58:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: USB
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kunal.bhat2001@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component
Message-ID: <bug-211983-62941-fQwQHb8wSE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211983-62941@https.bugzilla.kernel.org/>
References: <bug-211983-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211983

Kunal Bhat (kunal.bhat2001@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Bluetooth                   |USB

--- Comment #1 from Kunal Bhat (kunal.bhat2001@gmail.com) ---
Changing the problematic component to USB since it seems to affect more than
bluetooth. My USB mouse is recognised on connecting, but doesn't seem to
function unless I boot up the system with it connected.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
