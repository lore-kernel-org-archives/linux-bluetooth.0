Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97232C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 23:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiE0XBB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355166AbiE0W7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 18:59:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126113C1CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 15:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C59BB82650
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 22:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2CBBC341CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653692388;
        bh=AzaTTyHf8h4p4nXjPCdpndCEunMWJqzoVnHYIodKUk0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=paqcFgnwdNyKek27+B3eW6Sg+/xsoQceAjbGg2oC/CLsc4EHuC1qqsXdqOfA/k49p
         sdmvtubfmuMRzRmMZjDj8YnOZXdJ9HbN2GT4QwOxmgCChHzupxIN+Lz4c/fQ/r8K0l
         XDT5PJ2H1DkOdpPOFlmP2ubaWlflmgrqoNi38CHCCPh5YGELOyLBkGnha5yYSDGATG
         Z1CFYZWpJjz3aFvDIN5J0WmCIXxV33HOchomuYtM+YWmwSLWJrQLhNNG2/IRt54WNJ
         oB8cEC7nsc06Hou7xQ3FKMPhhzW//qTtaaKKuCLNw3xz66y2cDTW5DnT3EjMSCwlMt
         RK0mFw/RGC9fw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C78ECC13B4; Fri, 27 May 2022 22:59:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Fri, 27 May 2022 22:59:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daniel.wennberg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215576-62941-MknQQx8Pum@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

Daniel Wennberg (daniel.wennberg@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |daniel.wennberg@gmail.com

--- Comment #12 from Daniel Wennberg (daniel.wennberg@gmail.com) ---
I'm a rookie here but it looks like the fix entered the mainline tree with =
this
merge:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7e062cda7d90543ac8c7700fc7c5527d0c0f22ad

The fix itself is this commit and its immediate parents:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd44e1dbda36fff5d7c2586683c4adc0963aef908

So it looks like it will be included in the 5.19 release. Hugely appreciate=
d!

However, not having a functioning bluetooth HSP mode is incredibly inconven=
ient
in the age of Zoom, and there are now three major revisions where this is
broken: 5.16, 5.17, and 5.18. Any chance we'll see some backports to get th=
is
in people's hands faster?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
