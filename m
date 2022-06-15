Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5CC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 22:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350137AbiFOWA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347927AbiFOWA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 18:00:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E155490
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 15:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E80B82186
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C0BFC341CC
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655330423;
        bh=lCega044efQM4vwd/usp/m5pIj2UkOn3Rq0EZEJh6UU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PmhpSAUVgFHADM2a04hmmfZo/3X/aCQgxHo9VRDRllFxXvjTcLrewnKXg4AVu98KN
         d6U9vyc4yc9MDn2rTKFIWNgMJiH/V3nycqN/O1kEi7DAHoo23p42gg8FfvLOSFApEv
         OXTVOjJI/ZWr/hGyexsusxdcWk/FJmatsBScT5JyVqR/vVe2bo0Arx/B+GTbu4w/xB
         vgel8jvhHIDOjh1Nff57Nab0We4LMJH4Hs4gciPIBFag+cGhN7X0a56G/n2f9ZNM1u
         Td4y3Lx3zWXdD6y1RkVlOpgFzCRMKubehOpGZybFWuS+wRj5wgfDtbNVIA31Xrj8vW
         aVJmh8xBiHclA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 778FEC05FD2; Wed, 15 Jun 2022 22:00:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Wed, 15 Jun 2022 22:00:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-2FkTfZU4M6@https.bugzilla.kernel.org/>
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

--- Comment #25 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
We are going to change how -E works, it shall only enable experimental D-Bus
interfaces rather than Kernel Experimental features including LL Privacy:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D650352

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
