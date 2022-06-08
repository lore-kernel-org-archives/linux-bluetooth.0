Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 20:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiFHUM1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFHUM0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 16:12:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79DE86E3
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 13:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FD05B829F9
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 20:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA999C3411F
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654719143;
        bh=pMzYSI4XjlV8McLPVz5FjqBFvTATXZ9i7u1lXMACSEY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=POrnB2zPhHvOxm/Ok+JC8Y6EW+s8+CeERG5f2W8unX08r6s9P/t64I5t4b37UZbNV
         zm8mBLJ+OxKJJhBt1qnP1Kv7iti+/XxpMsiiFr0yn+25tqri+hJ+enm3rBYs6FumqO
         aZML6DMOdGHgCzDn7H6P2AgdCvmlul3xNg7rtJgutwmkahAyXDqyNGF8xeEnJsusLJ
         4dZmhDdYGe5icZ45bhht50md+SuySQtir3XCYIRiGwWMNjsIDJfyH35eZMIka/ow9l
         g+eRcek0mZOqDOm3TtVoPHQgQw3pZRBeEpJhPky9Qg2pJjdBgiCmFaqiKS28NI+rVj
         4gG6HnQNwMT5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C947ECC13B1; Wed,  8 Jun 2022 20:12:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] QCA6390 firmware crashes after some time
Date:   Wed, 08 Jun 2022 20:12:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kubakici@wp.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215872-62941-5N4OMG7yLf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215872-62941@https.bugzilla.kernel.org/>
References: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215872

Jakub Kicinski (kubakici@wp.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kubakici@wp.pl

--- Comment #5 from Jakub Kicinski (kubakici@wp.pl) ---
I believe this is closed by
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3Dd44e1dbda36fff5d7c2586683c4adc0963aef908
upstream.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
