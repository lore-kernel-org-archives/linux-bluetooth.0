Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C1C46467
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Jan 2023 15:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjAGPvK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Jan 2023 10:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjAGPvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Jan 2023 10:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7604A974
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Jan 2023 07:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0A68B810B2
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Jan 2023 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF23C433F0
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Jan 2023 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673106662;
        bh=CwKpH26a6ip5jEG52vrvq59um8eLk+G5vp62qXoqEg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h6HlCNa3jiNdr7b8/fjWRMQPzIc3wX3UaMr8KppFb1VdXVsnI69B4YbHo4GWeLBjQ
         pk384FbycHVPMEERGLCA6RBqiNmIasx8GfPMSgUmE75FAkfZrGhq48QuEirKzqnXKl
         5aYsM4rkTapYYAqgmC1CWSHGcOqpxwhqDzHSIEifN0uyl6qilSIblJ26Lvi+RL5UAL
         3dE7nIb9jiXfE5/cRNJZNgFy6+qrTet9/Q5mOThi3kKS3pcyXnJLG2Op6MsN5qnU4H
         kABJaFoo2HPSihah23HuVOWGY4+QFSdW+AnhZfVSx479a7tlwFiWXombZBQmdGiKCj
         Uw2B+zXhi8WLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3E563C43141; Sat,  7 Jan 2023 15:51:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216819] kernel detects Mediatek bluetooth does not work
Date:   Sat, 07 Jan 2023 15:51:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216819-62941-to3E7EsVxU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216819-62941@https.bugzilla.kernel.org/>
References: <bug-216819-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216819

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #2 from jeremy (jeremy53561@gmail.com) ---
Looks like it needs a patch similar to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.2-rc2&id=3D393dc5d19c825906f955210f10ee3befc39854f7
for it to be supported

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
