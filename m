Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 14:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbiFGOfl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbiFGOfd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 10:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09173647E
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 07:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97060615D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 14:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04A19C341CD
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654612532;
        bh=sWv61qMsQM1G7whJilULB2k6IHvqTr4JOM8HtCdCVmw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YxPWNZopB77n3sIDk7NCC94/bGhJmgw35TUHQqAIExG+YCqrxnCD0t/a3IgZ9RIro
         09gXc4h9XBrBxNks+8C+Vw2tN1IDTCOHmu9hZr84JtKhFPR38Wy55ymu7sonJ2avzQ
         7weO4HvxuUM9RnjpAqXyexILuyQjbVlwoyCgTo1AO5QcLxn+M3sPLpNfzyfrKCLNja
         lEPibcl6mQyLxMQIpsZSqjO4LE0DWiYGBeBBRiwt9hc68z7U5QgJ2PIiMer81rcJQv
         xIQ1oHamciJSfNb2RzhKuvbyWdas/n2vljFJgkXWhBu83WlMQhi2aX6MeHiXfv5JYH
         L6toegZnAPHaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E6B72C05FD4; Tue,  7 Jun 2022 14:35:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 07 Jun 2022 14:35:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: massimo.burcheri@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-a8moE3usCQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #20 from Massimo Burcheri (massimo.burcheri@gmx.de) ---
Same issue with a Logitech MX Master 2S on a 5.17.8 kernel.
Isn't that a bug of the Logitech mouse changing the bluetooth address on ev=
ery
restart?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
