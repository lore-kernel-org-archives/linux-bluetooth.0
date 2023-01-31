Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF61C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 03:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAaDGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjAaDGJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 22:06:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80401298D1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 19:06:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113CC61362
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B3C0C4339C
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675134367;
        bh=PzYXWTUN0f/TzNUtVpUqfd9Jtlm5BrqtNB4ugLpc3BI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=byWNVFaGgM4HR/nKBcYJiraYdOCfL0Rr+MzXkLKolh2bU8f2wIj/RzgQ0b/LgIXzK
         BHcmaPiGJ9bOsfC6rNAm7FZzAH0D1LqlGiAEOP81AwoNaNCIkLsyCnxC71cdyRVWjw
         7WlVil1bTufCJOgTrpFm05UunbakN9c6a/J4lH/SaOGDg0AK/wolbS4FC14QFXd0eL
         HOAsA0KARygbv4o1yifUhDUYwx4YvdYyAdi397Zb0eSAODbUk6AMNw6EDBuc4RA7ox
         tCGoAmFJdJCnJlyzEr0I1HoZA4+bwm/ZeXQwR+lmYnRk5SrWUjizZ4G7qB37MRrp/k
         bbXPgpmydEzJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4095BC43144; Tue, 31 Jan 2023 03:06:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 31 Jan 2023 03:06:06 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-mplRfukZvq@https.bugzilla.kernel.org/>
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
                 CC|                            |johannes@sipsolutions.net

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Johannes, could you take a look please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
