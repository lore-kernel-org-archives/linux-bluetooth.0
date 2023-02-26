Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43376C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Feb 2023 23:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBZXPM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBZXPL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 18:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B01205C
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 15:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 495FFB80CA0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15E24C43444
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677453308;
        bh=SxHwZezXHR/iWRmmjmi+gWEcNlJSHmJtX2AUApB5M0A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sNLWwxYBaAEhUI5JQuHkm25+I3umptFJahO77sZij8IW7FdZuFUiu+wJ5YBvS7Xpn
         8go6blVVjRuhrQasaBmR1ar3gbKek5Nvn5/DvmzeiP23EVck2A3DoCzFmDvjK76d1r
         cn97YsfKcF+5xo03c61LpZp3mr+zyLfO7ladPYe+bS5yVuT+nwZaABfIer/AyNHBUR
         Xdzn2xg42fb6pLwJD8FzOKIF1G80UxMMmygFQt1xz9KphXJjaKw+r5Tz7Y/Kub83WK
         Y/oRuKLAlFnGWrYavAz1seGfuZd2fADS9RPee95wiKYxUg4C8ccz1KZYjyTunlfvss
         gSJDSS2UfnHtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 05ED4C43145; Sun, 26 Feb 2023 23:15:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 26 Feb 2023 23:15:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chaimeliyah@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-xtFud826gz@https.bugzilla.kernel.org/>
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

--- Comment #47 from Chaim Eliyah (chaimeliyah@gmail.com) ---
Sorry, after patching.* Happened suddenly after patching.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
