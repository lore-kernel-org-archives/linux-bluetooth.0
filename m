Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F6FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiK1RK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiK1RKo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 12:10:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993DC53
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 09:10:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D59B80DE3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B91DC433D7
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669655441;
        bh=pJsFIjWn73fZdJZ89++ib2nNeaKUb/VrQUbxjqvW3sE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ndf4fyWcxL/duEdPxGgd1fICVjWOoxbAxqw0pIYcX92Aj0Gh0P7GC/kC1OGTEVmNg
         ATqvZHofN9/+8Wa5jI93Ze1YB9A+M+gbWdlMfEMnAkrQI3Ej0RosYNK3+IMvmAN4Qi
         8BVBUKkkzD+kiKo1aO5FS7OCUwStnEPndMDXYPuooUJX/idDfqhTyJsq8fCeyWhoSU
         SdZb+cEaJ6RT0FMpXsBut+39sd4K45qqWffUsPGor/Q5mZZIvp7hYg44W90j0D0XUD
         51TCd+90Q7AY0zcssIXqIQ3wd/l19OZ6JNDGeAX2csm1DoqKGY7L+LlYxBHtFOn7wA
         ScoX8qnU1PA8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 42162C433E6; Mon, 28 Nov 2022 17:10:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 17:10:41 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-1ZmsE0upjE@https.bugzilla.kernel.org/>
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

--- Comment #12 from JustANormalTinkererMihir (justanormaltinkerermihir@duc=
k.com) ---
I am now able to reproduce this issue on kernel 5.19. Same kernel fault, sa=
me
thing happened again, the dongle disconnected and reconnected causing the
kernel fault.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
