Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98031C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbiC3Nwn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbiC3Nw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46579122987
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 06:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E353561337
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58526C3410F
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648648243;
        bh=CQh1rj5EAWxrgnSnNHGWiyPCbXKJZY+yWVbdV06LYDw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tsbXTBm7IkVDVjjZ4yHCr8UKwSEdIrr9SOMmdDUiaOBbZEkgm2/zVnD6UHhAomXR0
         32wdnRk2spU6zPiXrCDKoj+iQIZ4DV9gALC5djM87EsP5KAn0vbmSm8X+EC1khZY3C
         XmqaD/vTTBAd7mslVNM61SHq6YzUKcFR9/unmlgyH05LPhD2867YdHmsmbM7g5IE7H
         QkDR/6NyDulam1sPstYSrdgyuSks9LaNF8olnwafJqDxhURaVkhJ7rbUNrtaVFR4Me
         MhIgBej7eSMikNwPM+uX6nlNfD22hrDcrxHQF/2esECb5r2vTyZvbt+tA1RY7I7IlH
         TbqJfWW46ZdNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 46F0AC05FD5; Wed, 30 Mar 2022 13:50:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Wed, 30 Mar 2022 13:50:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc
Message-ID: <bug-215776-62941-ppT3tywmU4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215776-62941@https.bugzilla.kernel.org/>
References: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |aros@gmx.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
