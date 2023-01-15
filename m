Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC38C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Jan 2023 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAOUiZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAOUiX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Jan 2023 15:38:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB513519
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 12:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E6360CF5
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 20:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B17C433D2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673815100;
        bh=N/T3a9hGAnzJPnFoArIa+fv94W9NcYArIiPE6/R10t0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fbz87FLz5z0zMbfGf5sIL0xWsnjQ20l2Yvc0/qoI/MGo7/k7HLBdYx2heJW029GkB
         JdyL4Z4vlZB2RMv5WWcY/YNShUV7xLmkoTTfDOxjxg+irB163m/92n1v/bZ7j264gs
         8kRbzztW0K8vOC5TObkiBZsKZNSzPYz2hGrp/Pv0/9n91HMgKMeGo+EtpNhjez57Mi
         8W+ckgp5yDD4OioqJOHFNv8b+nrar2nSXu+y+JoOGQWJuLqtqQ4WsT91JrqcZuWfuQ
         36X8KdquZnyfh6LqA8BifHd4/oBd6R3k3wNT3GaY7zDNYCv811OJQ2o3Qo4px0qAYv
         wH6YL7rQ5RweA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 69C7DC43141; Sun, 15 Jan 2023 20:38:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sun, 15 Jan 2023 20:38:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-216936-62941-RZKk69tdYu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|[REGRESSION] The first      |First attempt to upload
                   |attempt to upload firmware  |firmware for Intel
                   |for Intel Bluetooth fails   |Bluetooth fails (a timing
                   |                            |issue?)

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I see no Bluetooth related changes in 6.1.6 or 6.1.5. This is probably a ti=
ming
issue but it's still not nice to see.

If there's any additional info I could provide, please let me know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
