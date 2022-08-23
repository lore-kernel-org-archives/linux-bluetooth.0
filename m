Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EBC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiHWS4g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiHWS4N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 14:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CFC98A5E
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66A39B81FF0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 17:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1928AC4314C
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661275371;
        bh=4qL2Yvuezy+m4fDXohFJScNAUAo7gSNDC7CS6ZDu1L8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Si6pnU7sLU3aNm8QeSm3OFygp7t36pKUC1pPnb8CTq1xVJgQDgEsRWAsACcKk+US/
         h7HD4KracNA9Kap6FhtQ3ZJImYbI6EmSkLUP3sdVQ8xlFRBM/0sUfwJJh2Cki1EVhd
         mL+U15K8NpXDWQORkqYsqzVOu0bnYBQ46ojbriONEqZA/8X2kSoUXmsEeOlj34XSa0
         s6SL7bBDrQl/NBwf3+BQOJZvJ5cwn0uvCfhz/Sej3bI0iO73fD20PFyq+8tvaEGFDS
         mZZer+nbScq+a+V/fGx8LW0OJtY7BiwwZgyTxpfTpnoSeg4RREPhf+E2llRFpxmDfJ
         KRKFzf47Y+Uhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 003CAC433E9; Tue, 23 Aug 2022 17:22:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216389] net/bluetooth/l2cap_core.c fails bounds check with GCC
 12.2
Date:   Tue, 23 Aug 2022 17:22:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216389-62941-6A4KUSQIXx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216389-62941@https.bugzilla.kernel.org/>
References: <bug-216389-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216389

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #3 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
The following patch should fix it:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D1d71d9223e4143d3638f60c7bb291844c237556c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
