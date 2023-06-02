Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D5CC7EE24
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 16:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjFBQhp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjFBQhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 12:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D771197
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 09:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F03D463CF7
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6342EC4339E
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685723860;
        bh=l0VuUPCvk8EYTXZ/yx8lq7yakU1UjiR7CuHiujo4rJE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XD5SSEJtHz/ARWXrkq8xy43t3++58BxtduJsesvKcwKyfEOQjMsDtgLYPPfr315MD
         SFdYtUnMgbSS7urCk9PHlV5xSpzgLNusG3M98MT5YLzXFNhiQkXDiuNxUgNMusBgHa
         HQVqZ7+nM3AAMR47IGaX5uIRP49Q5cf6H5vYK7f0MQb5Wwe3Fktsfq7FUPPnwAbzKr
         d2rdY9PCQfP3yhql5tL3hWdq0Hj8Qefn2szlxsK+k+5zZ40wmhOjUPqLh00myDBYTT
         1X3meJHdFjTBJCBkBlDJ4bgiT+OjPeBlUuFMZ2V4izfbtZDDemCa7KTL1jEnecejn9
         voQEzaxuWLXRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4E333C43145; Fri,  2 Jun 2023 16:37:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Fri, 02 Jun 2023 16:37:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scherbakov.al@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-fzgG745jmi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #14 from scherbakov_al (scherbakov.al@gmail.com) ---
New error messages when communication is lost with Magic Trackpad:
I booted Ubuntu 23.04(kernel 6.2.0) from a flash drive - the same error:
https://pastebin.com/5KtUjCHQ
I booted from Fedor's(kernel 6.2.9) flash drive - error:
https://pastebin.com/4LJC7NJQ
When using Fedora, communication breaks also occur.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
