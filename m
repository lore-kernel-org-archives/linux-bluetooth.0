Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 13:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiB0N4F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 08:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiB0N4D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 08:56:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CB91BE88
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 05:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29BB9B80CE5
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 13:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FEB9C340FC
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645970123;
        bh=MYSbiZa41kMelcap2Nx8pas7UhsykYYhl7VXWiECmfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p8vwbt3XMnxLP5Fd5XdJ8LfftZCRbW3SEtFnyoG+/hv4KD6W217NKaxEAVklCVb4X
         00ZyEFGtgAHq3IwSiMZWmJKqj1qsnRmwq+mEptFBm9NfMu+QGbpRbJjWpRMJTnOsUL
         D1COcnduQTui+vxJTRjPALho17pqbDr2JqaNkjY6hY+tWfVeX3jnBmKYwIMmRpksjD
         byLDo3KkYpi2tOup2yERY2+4QJAhkj8LmO8sMnJudPQ7bHrgOcTa/Q3mq90SOREB1L
         VsUsUjFNRPJ+DFN7y2rqepJiCd7IlLjansuv4eTkIpET5fDdKuAomaFVb2FUBOm7jV
         8ZKPtM8qKk05g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 915FBCAC6E2; Sun, 27 Feb 2022 13:55:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 27 Feb 2022 13:55:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: priit@ww.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-xqeqdwlRfd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Priit O. (priit@ww.ee) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |priit@ww.ee

--- Comment #27 from Priit O. (priit@ww.ee) ---
Same problem with MS-7C84/MAG X570 TOMAHAWK WIFI (MS-7C84) and Manjaro:
[    5.048112] Bluetooth: hci0: command 0xfc05 tx timeout
[    5.048112] Bluetooth: hci0: Reading Intel version command failed (-110)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
