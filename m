Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109EDEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGJSuT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGJSuS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 14:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D0C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 11:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F766119B
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 18:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C175C433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689015016;
        bh=xgLXSy+NuLjHvMGmWcbd2E40LMv+ZRI58iRfoRu0aD4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RCSqIAtGvjZPHhfhwzB9z1OSH73dAmWr3MXmw4DedU1MpYCBHlq6FSLpXUAlxiXQ8
         rwiMh4m/5WBxOwdjdRthpiTu7IlELklVgI+TV69abrQlrfWf/NLUw6fXRPOsIbbcft
         rXA/ACZwe1oznvdvy+RkWIdsDjg7RhAshsrsLp5lIdqwFb4jH0XQ3prLN8CCdHPitE
         WAjHbjq+7BHIG6KbP1XLMGzBRdSEfPLed6RjNkjMYHntXP1OSko/fF48AsBylHaAfd
         z7wWVrnzGcYud2z1c2UMLsm6Q85axoG1TFOwJ1mlOgDMCNFug6GVegwlHma6NUYLMR
         GINKCMe+vNgfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 34C0FC53BD0; Mon, 10 Jul 2023 18:50:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 18:50:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-2e4rSTc87a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #10 from johnbholland@icloud.com ---
Since I recently retired, I have some time to put into this. I have=20
built 6.3.12 and 6.4.0-rc1 from kernel.org sources and tested, the=20
6.3.12 works and the 6.4.0-rc1 does not (in terms of the bluetooth=20
issue). Looking at the git log of 6.4.0 there was a lot of bluetooth=20
related activity. I've chosen a commit from before that and am trying to=20
build that and test it. If it boots and the bluetooth works, I guess=20
6.4.0-rc1 and that starting point could be initial points to use in=20
bisecting? This is somewhat new territory for me but so far it's been=20
pretty straightforward.=C2=A0 The kernel builds take a long time on this=20
macbook pro from 2014.

On 7/9/23 23:33, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217651
>
> Bagas Sanjaya (bagasdotme@gmail.com) changed:
>
>             What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                   CC|                            |bagasdotme@gmail.com
>
> --- Comment #2 from Bagas Sanjaya (bagasdotme@gmail.com) ---
> Can you attach lspci and dmesg? Can you also perform bisection to find the
> culprit commit (see Documentation/admin-guide/bug-bisect.rst for details)?
> You'll most likely need to compile your own kernel anyway, so read
> Documentation/admin-guide/quickly-build-trimmed-linux.rst for the
> instructions.
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
