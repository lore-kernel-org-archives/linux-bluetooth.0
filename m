Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiBYPuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiBYPuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 10:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995B6BDD7
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 07:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A266192A
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 15:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA6B9C340E7
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804187;
        bh=UhHYw4tjhWmia0vLGTXrhSEV9FQT2jf1OrfUT2DGXrA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y8+Bm+6wtAzTgHGetxwKWj4UlQYWzAQrP/tNUEyfBNhowpllpt+Un9fmVPFYLb38g
         s7U96pVAq1RXsNxuJNVEv10HsswrnS9kjEQ4DGmEURTRTES939lC1orFDQT5IQlVhI
         5zZYij8SsLIMsf2giEI8ZIv/SFk8y9wDGA6JT6N+63cvJ3GtgXXaPKVOUcZgNftSPO
         pI3scZIO5mIYrC55gPOgAQvhqFTAFXu3tvdYtHsE99Y+qF7s2R/1vVMXmKnblpnyD5
         NtLHXqXD1vDJXeIXSJFmGycEHmp5r9q2A+LHfug6i/xDEJ3fGXJEJmhMM4CDGVBngJ
         z6JlpnMbPqBIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8CBDAC05FD2; Fri, 25 Feb 2022 15:49:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214809] MX Master 3 stops working after resume and at boot
Date:   Fri, 25 Feb 2022 15:49:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnicola@dend.ro
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: MOVED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214809-62941-aq9N3JArWp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214809-62941@https.bugzilla.kernel.org/>
References: <bug-214809-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214809

Laurentiu Nicola (lnicola@dend.ro) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |MOVED

--- Comment #1 from Laurentiu Nicola (lnicola@dend.ro) ---
This was actually https://github.com/bluez/bluez/issues/220.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
