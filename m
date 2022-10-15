Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3AEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Oct 2022 18:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOSCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOSCr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Oct 2022 14:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735149B72
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 11:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7398860A4C
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 18:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC7DC43470
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665856962;
        bh=qGeZVK1LKp8ahut2Hwmep8eNzwNThowrWvlHy9cVT4k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b8p82SwQJ78teWuVlWrSw4CeB8LscqeeILmZdJYLfuXmxJ7ITt1cR+dFOV0GWo7Fg
         8h98StRr1BLjHWsf/XcJgb+L+A8UvScxwvoAVdQ8vBQEEUuEmnVR4fKtwz3UbiCLhl
         pFe1sn270qLhU6eZAo/CAnDqs7qJWjO5Z8WS/hZLRtaUNPCTIEWa5NSF3tkpVnj3ve
         szWuy6AWuIUqorSiLyOs/Xg7g5rkwLtB7cPGVPVNF+/CKsc+u+lLA1T+Len+jjaR8T
         UxnbrSG0yI1t1cNXKpLn1GjG6VeABkQPPXfh9BH4DxiVXZK0/imoziJQJ/skIWqLzR
         W2y6Ll0GvHUMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BE1B4C433EA; Sat, 15 Oct 2022 18:02:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 15 Oct 2022 18:02:39 +0000
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
Message-ID: <bug-60824-62941-31iS170p4C@https.bugzilla.kernel.org/>
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

--- Comment #236 from Swyter (swyterzone@gmail.com) ---
Quirk, or workaround, not 'quick'. And yeah, if someone could `git bisect` =
this
it would solve half of the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
