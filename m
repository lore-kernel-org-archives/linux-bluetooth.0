Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C3C46467
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKZQaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKZQaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 11:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A71CFCE
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 08:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177E9601B6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 742A5C433D6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669480220;
        bh=psO1KanTSK3nRNq1qEl4YUtuXkVf+6IPAbajBI3Rb1Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BFEc61iVV5/Qn2aW5wq+ku6Wsvrrz8qMx0DSuKkahmJUaLUTmsIFh/6NykZzFP7Hn
         YJgCkC10FToRx+y57CmrMVRhXbpZNQRCvZNsDWvbwWNyihEo+DU4H5fTb3uTlJLuCl
         Jkh/M4VmW5OLU85UaNhCCEzL7Wzb7kjKdbEw7dOBtmUCjV5uJ3GFtlIVp1Vq2LX0N6
         foBWO/lkt0ZjU952rNFcYPj2E29/xbr8suNuOQ55VSCfcXTmlvxBhlkPaylUekWw//
         uYWHazyzJgEmYejYbf2QfEftfIM23DNh8tj6fTrHiOrj8T5cdlHptAxF7MCIiAh7mL
         /u7X9i1+pa21Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 631ACC433E6; Sat, 26 Nov 2022 16:30:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216742] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 16:30:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216742-62941-SaLybABrcY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216742-62941@https.bugzilla.kernel.org/>
References: <bug-216742-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216742

JustANormalTinkererMihir (justanormaltinkerermihir@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from JustANormalTinkererMihir (justanormaltinkerermihir@duck=
.com) ---


*** This bug has been marked as a duplicate of bug 216683 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
