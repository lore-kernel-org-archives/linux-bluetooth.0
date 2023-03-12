Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED4EC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Mar 2023 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCLUVz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCLUVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Mar 2023 16:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1B2FCED
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 13:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEF960FDE
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 20:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD6B9C4339E
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678652512;
        bh=g6kEHUqvkCa2Gizy6Ry/3E6I/Qbif2emACGrddPGuU8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ck70VJyvryC/iBl4Gf9U/QIkhormvirpD0J9Gjw3xZt21ALXB+g/FLJ8d6t9GhN4o
         hc3CD7D3Um9IkzwyHRd7XC7Jedit5nXy/+e9TPX0QTD8rhnzXirw8jGwk+z4ieXmBb
         NOuAaqpFQ26yA9LsdVovNrEAaCKmshwPrm2m6o5fggjVml8MFi6Kl0gxzn2my2YlZF
         on7BznCH8RdSa9qVbyogy0QKzpKczxpl9dGDM5Tc08KZdy3+8PxlTvzEI07DfxpML5
         Ocy+4g34ntfpw3E7Tcr5tO1xqGNShBsvHmDGzluOaqSsn824/ZsQg9zZ+yvrtv7rSZ
         EDcnwW+NNFuxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 91BE3C43141; Sun, 12 Mar 2023 20:21:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Sun, 12 Mar 2023 20:21:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: toni.andjelkovic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-ZlWAEjlPB9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203535

Toni Andjelkovic (toni.andjelkovic@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |toni.andjelkovic@gmail.com

--- Comment #13 from Toni Andjelkovic (toni.andjelkovic@gmail.com) ---
Same issue here with a Qualcomm Atheros QCA6174 chip (Acer Aspire 5) and a
recent 6.1.15 kernel (Fedora 37).

Reloading kernel modules or messing with the USB power settings did not hel=
p. A
simple reboot won't do either, you need to poweroff the machine.

My workaround was to disable the Wi-Fi connection to my Android smartphone's
Personal Hotspot and use USB or Bluetooth tethering instead. Looks like this
bug occurs only when Wi-Fi and Bluetooth are used at the same time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
