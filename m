Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Dec 2021 08:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhLEIL4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Dec 2021 03:11:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLEILz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Dec 2021 03:11:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E74B6B8075C
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Dec 2021 08:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DFD7C341C9
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Dec 2021 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638691706;
        bh=8TBhDctZ0S1bFaEzOTeBEl9/zqAB+YIFBwR3/wU3X5s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dgPgUUoJQOfqhQcN4HvPxxI27SYJSGBrfXYQAIMQSKD4gHEKfh5wFRV/TCBukZJLf
         QBN8VJ2DsVgpr9wCjfpzmDhUZ9zz3ByHqXL6rKP7uKCPRsdTTPyrf2X1AuN5TTNd0Y
         oJ8Bts3UAYgrFU88Id3PWWbadZwAPSV0Lp0SHdaYn3cO3gCky0F8wIaKPTV3vtWxeM
         jglWuvnspc0Qc8Lzj9KD2lqv8R4yjt1pDf5+k2FW3ndUrK0yUVBf93NgM0TB/XKYHM
         XgU9Wqzx3WIm4vSEAM4Xj7pz8pVwUhmILmjW3YCDJ5RL4aJK4ZFDKE4s9oTnA+6sVJ
         E5JSMgkmgARhA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 641CC611C1; Sun,  5 Dec 2021 08:08:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 05 Dec 2021 08:08:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tiwai@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-L5hKfr9C2Y@https.bugzilla.kernel.org/>
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

--- Comment #13 from Takashi Iwai (tiwai@suse.de) ---
FWIW, a potential fix patch is found in
  https://lore.kernel.org/all/20211202162256.31837-1-tiwai@suse.de/
and being discussed in the thread.

It might be that the entry 8087:0026 in the patch is superfluous, and we ne=
ed
to check more.  But at least it cures the problem with 8087:0a2a.

Check whether you have the timeout error as mentioned in this bug descripti=
on.=20
If not, it's something else.  (e.g. the problem with 8087:0026 might be an
issue of USB side instead.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
