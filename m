Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7096FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Mar 2022 18:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiCJS0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiCJS0j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 13:26:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425C15879D
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 10:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FC19B827A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 18:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2DB0C36B08
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646936735;
        bh=g5H5wVfMiWpY2qUdNYkaOdlPmTn/P64h1aUuywA+Q98=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tL/FVpmtfMUh+5t0AfefhsPitK9lAWM20prG5zDyJa7n+JInxWaitjih1ccc64wa+
         o3wJ6ENzvQaPTk5v/4E3rhlLwM/qEE35RlEpd6ByKC2aSQwHau2bn6YglfHcnrsCod
         W/HI9REgCMKTq43IcQNQ8cd8NTT5FCvUg3BiN+ZLpO55Ftb9JWcvz/3HCJifw1Lf+4
         4FaghPebssSgX6S9hKI69g9QOTw2kwyHDf8gnwPMBViOplc+y/FrWVpI9UL69c3pSt
         /3eL82yjIfFZjo+Gklg5MvZqqbbhkLogJ9FNMGmP9SbwWmcMQjrJtNCUYIiSWjSNYm
         rUdS/ZVhtsz5A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2D4AC05FCE; Thu, 10 Mar 2022 18:25:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 10 Mar 2022 18:25:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-QrHO86KuXp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #226 from Swyter (swyterzone@gmail.com) ---
Super neat, the v4 patch series has been merged by Marcel in bluetooth-next,
maybe it even gets backported to stable kernels:

* https://git.kernel.org/bluetooth/bluetooth-next/c/d35c9b22957a
* https://git.kernel.org/bluetooth/bluetooth-next/c/4afc6c743557

That means it's probably going to get merged into the parent net-next tree =
and
if there are no weird regressions Linus Torvalds merges that and it's going=
 to
eventually be part of the next kernel version. Whenever that happens, thanks
for testing. @tornaria and @lemonteus are credited in the commit log. :)

With this all my Chinese dongles (even those purchased for kernel work) fin=
ally
work on Linux. I'm sure there are still more quirks to add, but hopefully o=
ther
random people will start chipping away at it as a learning experience. It's
been fun.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
