Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3790CC4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKZQ3c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 11:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKZQ3a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 11:29:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EC1CFCE
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 08:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A5E609EB
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A15E5C433C1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669480168;
        bh=s35yfsxPQxGlXBysfuW2tdhV095XZCN0B7raSw7xvQ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kV5W8wveChvcQPNL5z/7t+pW0/jPfW5xoLxHStw5D04mHQ35vJc+mvV49cM74FAVH
         RRgmBfbgoquwpA1kXqrteJixVicRDKzJ4okvPD9Csn7ij6eovz7yWWaoJQUrXyi1uX
         g5IHqzCQ0PO6LRrwZd5wpiH9FmcuGToheZUJkz0r9YVFFvimgFB4k1glqxs8iRVQjm
         A7iS2aSuJBVvNOJw7QIlvAeKM7Et3nW+5sZdFl+uPw1tL3xURXikMgZhB9EqaI/kJq
         wcM9xlX62rLsLziSubjEsySxfCma6jw5kgUIlsTTCkDopLDrk0Q4j1A5gsbD+RFL0w
         UlEVFxMi0XLWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8CF71C433E6; Sat, 26 Nov 2022 16:29:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 16:29:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216683-62941-zqnTlsdmyw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

JustANormalTinkererMihir (justanormaltinkerermihir@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|OBSOLETE                    |---

--- Comment #4 from JustANormalTinkererMihir (justanormaltinkerermihir@duck=
.com) ---
Marking the resubmition as a duplicate, it doesn't look like bugs submitted=
 on
bugzilla go to the regressions mailing list, sorry I don't really know what=
 I
am doing this is confusing as hell. And adding regressions@lists.linux.dev =
to
CC just doesn't work

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
