Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA1C6FD1E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCGVKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCGVKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 16:10:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56939A17D7
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 13:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E979461574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 21:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52445C433D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678223399;
        bh=sHQCf2/4di4EhVPrtQNGMuWoGoue+Nk/beO8HzI3RvA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mWpkkYriesHZEOo/WRM2F/CrIcgHVwufrS7jrtDBXpU2pA7B82jFQWFmQe28me7Jt
         mzzW2ayYJ45KF0U+0sUS/F8JK9yQF6RmfbhZQNeKceU9iI6XPJSfXFGZQx8XDS6jtW
         4Q8e2hrncCz5y48pEVviFzoukQHw5kkyQBRD9abcfgkYQaywZ1wqN0eUycMdTV09Sa
         9eTjqE18uviAfGYyJwDq1xXGZkvKnvmi9nGw1Jm29vjSRHssGhE6WbGOfBVZNiU81U
         vYDmogJGcOEAvATBlQ7909Wh2Td5IrpbHEstNO6T3cY/2Xo97RkqHtAquucVyMS1rw
         dD4sIdCXeSTqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2B49CC43142; Tue,  7 Mar 2023 21:09:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 21:09:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217150-62941-q73wxYf8K8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #9 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
I guess we can close if it is not in mainline yet, this type of problem sho=
uld
really be filed to the distro first so they can triage and only in case the=
re
is a bug upstream it shall be filed here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
