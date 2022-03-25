Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B775C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 10:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiCYKt5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346366AbiCYKt4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 06:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3706150
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 03:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 942F9B827F9
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 10:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54AA5C36AE7
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648205299;
        bh=hnp6WTYJAEpbMyLA9/zKcPWzF7maTHH+jg4++E2PqSE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QwfzBPR3COGSC+poAFP9NqBQJLHnSU/9ZXPEeMCJM3MPCc7aVvUCNIgLo3Blc8qzn
         30aEBl0aWa0GMhHO6cYy2c5sqQmad67GbEbNCEmYs8G9lzCqtz5U68iYL1vkcgPhWI
         wQvtb2BIrHcpIXMegWz2wunWYUzeIikn7udQNouOKwIO0oMe6LOdiXAMMB4i5nk2qG
         LxOQ0RyuWfUfteAsKFFCWjPcQWlskOZDvyjrRiFUvH4+ilvQrcibuzPevjNZAxok0k
         yN0HOOTtuAIaQA1WHvu/hiLLVERbJPm9p6rI0mxu71oYeiw6oN76G+lvA6PEAa3A3k
         Q2brNV3qLytcQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3C3A4CC13AF; Fri, 25 Mar 2022 10:48:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Fri, 25 Mar 2022 10:48:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-2BFygQQDmg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #13 from Artem S. Tashkinov (aros@gmx.com) ---
@Luiz Von Dentz

Why doesn't Linux 5.17 include this patch? Could you please push it to stab=
le?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
