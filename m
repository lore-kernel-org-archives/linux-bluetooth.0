Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4352CD6E7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 15:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjJKPJx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjJKPJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 11:09:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA86BA
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 08:09:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59038C433C7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697036990;
        bh=imCsug9Hn6Og2iLAHBuopMprcJck1UHNr20IG/G+j9U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QAkWRgW7spromBvUm810W4nl7W4a5JeAdchMCD/+rHjVUK7keQigGgnbMXkcEopbM
         EDqEc5PF4v6sRixUMF3Ly57dKPs6GLBWMPiV6cCYErCmVyUHZwb0a0qqoxWb78BjFD
         TssJFYcogj+qPLk0EP/wy7u2PhEmm0nbf2BmECtEeDsKP0aGEiCS9NmkNInaAFFxMi
         D/ZYfzR3Od2IyawHAgNoNzr/f0SlWTn72VWo8HO4F8NLnKyfkEwqHfNk4+ewau4AOg
         Wz2fHR6E0z5YvzoiCSQ3lyUm47v1zEohbA+Y0oZ7IAmDs7K0WbtRNxwJecLKwzrIc5
         RmXSRpSz2TpNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 432E6C53BD4; Wed, 11 Oct 2023 15:09:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Wed, 11 Oct 2023 15:09:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-W34peJcxTo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

--- Comment #10 from Marco (marco.rodolfi@tuta.io) ---
With the latest changes and the default firmware it literally doesn't work.
Kernel loads a firmware, but the adapter is undetected from the OS. This wi=
ll
never be fixed at this point. Kernel 6.5.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
