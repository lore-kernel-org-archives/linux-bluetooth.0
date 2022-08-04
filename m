Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531DCC25B06
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 22:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHDWPR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiHDWPP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 18:15:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10A1FE
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 15:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C73DB82771
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 22:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E919C433B5
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659651310;
        bh=WyAkrkXFxkX/sonOZiETk+XCU6/brRsKmyjLo8Gq9cE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Oqa43gqcjUrCVxtzP4lZjgYybSGb79ZHCbQ/glBxbh/qWex3D0qUP7mmo/c1x3aJG
         6etgtf921w8wI30ADSMyPGZddUniR72T8jNfmaT/w0g8Zw1yRIoaaKTAcm6rsmkEyZ
         jjG9E6vcH38cZv6bw+XNlzNnyWs2PIMTd3pE6MLF9e7xf1WqnJ7wBmx9RTyQvT9aPB
         etwnbJOSCHMmrkUck/PxCxmzrCSyg/o0+KwJpBFPigHY/BfVLJLmLIXZr2STfoTVBz
         4wejc6qzW9bWzsLsT9mHV8M7XcnU6UXOJB2Z6Rntb4SZgtLZ+mQUQZW6+/0/iPbeV9
         ZuNkgLhoAltUg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 312F5C433EA; Thu,  4 Aug 2022 22:15:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Thu, 04 Aug 2022 22:15:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nechtom@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215768-62941-lOll7ZSzws@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

woky (nechtom@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nechtom@gmail.com

--- Comment #34 from woky (nechtom@gmail.com) ---
The problem seems to be fixed by commit d50f2557 ("Bluetooth: Always set ev=
ent
mask on suspend") present in 5.18.16. At least on my box (Asus ZenBook UX41=
0)
it doesn't resume few seconds after suspend with bluetooth headset connected
anymore. Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
