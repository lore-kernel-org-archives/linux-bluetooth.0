Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7E060F48
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 10:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhIXK2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhIXK2c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 06:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0DCC860F48
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632479220;
        bh=W4BqoyyD3UZoDsSagG5PwINfinDZOmjh7qKZBI/ytIw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TdcPQ2lgNuFYozX/uyZc6NbSA/RVUR85rmHEGn/i7OfdC1PReVC7j4LTgIwGuE+6u
         pUiAUc5OGHq6WrWt+3sCaXyaVzo7aFw3rz0PmmJXhTHjAeDfvrleegaSLFuXflT+jZ
         AH+lA7+cDHshkj4omQW58WGEBUZAPCkgfuUV6YPRWGfF+3wC7325yzkVCVoOc+Hnol
         /Rx5/6FMXER08GRiZ7tmmyznkf/wQb2HdCrhMortARxKmROhi8HMwRtX75VJ2qCqMd
         8Ovsr9+KvsAiaJ2sYmNhWS7HMNa4tyTxbafh3ABHzPIqOpH2V8yeE7iPMSovCALgs6
         2Rqx8+5vvAwGQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214287] Bluetooth firmware rtl8671bu_fw.bin fails to load
Date:   Fri, 24 Sep 2021 10:26:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: tadej.obrstar@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214287-62941-JfjCeDzbdZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214287-62941@https.bugzilla.kernel.org/>
References: <bug-214287-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214287

Tadej Obrstar (tadej.obrstar@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Tadej Obrstar (tadej.obrstar@gmail.com) ---
I finaly got some time to look into this more. After bisecting the kernel I
learned that after tripple checking the spelling I should quadruple check it
too.

I tracked the problem down to this commit:
9fd2e2949b43dea869f7fce0f8f51df44f635d59 is the first bad commit
commit 9fd2e2949b43dea869f7fce0f8f51df44f635d59
Author: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Date:   Fri May 28 17:26:44 2021 +0200

    Bluetooth: btrtl: rename USB fw for RTL8761

    According Realteks own BT drivers firmware RTL8761B is for UART
    and RTL8761BU is for USB.

    Change existing 8761B to UART and add an 8761BU entry for USB

    Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

So after changing the name of the firmware blob to be built into the kernel
from rtl8761b_fw.bin to rtl8761bu_fw.bin everything works again as expected.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
