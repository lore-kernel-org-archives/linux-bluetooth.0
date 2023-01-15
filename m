Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F11C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Jan 2023 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjAOW0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Jan 2023 17:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAOW0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Jan 2023 17:26:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C14116307
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 14:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC26560D40
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 22:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 425CEC433D2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673821598;
        bh=1E+YqaCB8/X4/oyPAnMBx0LgRJYtY/QVHidJ3rx/3bc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tZzU+6gsM6MrqR9lE2g1QD1jYqUXRyvXLI/3zCtYet3XQhRKOn8GsPFAto4hu/hzc
         vY/ejNLiuJ5W5J1gPjWzOxTMgEo2IIum/TvmGZ0VPxtNaR4VUkdNIINGLCXU5dAibf
         8W4dDgHlXj0JmSl5f6alqVVYQEh+U3PgkDxThh/DiQR8rCwxxO5TGs3IF6TYExmalI
         jydb6sxulW6RTYQzHXHLc43f4atTZXNxfF/Tn0VAlmtI7ImUqThPUWulwaDJgHmDcy
         lZmDXr8RDqIS96jQdQgCimqtdx1SJQtGPDY1G4W9sitzxgIFM79gTSJKe/aEtlBY9o
         UEGH2wD+wLHQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 27F46C43141; Sun, 15 Jan 2023 22:26:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sun, 15 Jan 2023 22:26:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-216936-62941-ATsTC6PFTr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|6.1.6                       |6.1.4

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
I had these errors with 6.1.4 as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
