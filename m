Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A028DC6FD20
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCGPLp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCGPLW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 10:11:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6FC88892
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 07:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6AAD61458
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B6CDC433D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678201500;
        bh=wUKU/I2+9FnFzxoUcf2MmA/2bv2+wg0H1ZOoYBPTwW8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uOd8G1FJL36Mqlm9QXFsaLWaUUYwDLqh46df6saomQ4OyWK7SFB8CmVLpyDgT9y+N
         PaK37g5Cm+eqqQkn63OxtzNDqAlLyEeZ5OmR6iucMQY2RlvGKtkoXWZ76w2xQQC+zV
         RdwjtrV9JCCw62dlve7OFkoL5n7/lfIYOC26xfZAmYMcZKOt7U3IBPuZYWMNpWH1xP
         JKsR9rxkaIyWNJEnIGpbhYxHCdpOa3/OHUbelFd1JYAMe5FIa0lm7yQFQjXV9/OgUy
         anUtQ9g3pAEDQcN7r+asQUbp1YmswfK7bQWZt2w/Ff2fS77dCVbqjljN4t2DQzBvAR
         kOmKH7QEd4T9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49B43C43142; Tue,  7 Mar 2023 15:05:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 15:05:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217150-62941-xRvW83th1W@https.bugzilla.kernel.org/>
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

--- Comment #5 from Smokus (cmarobnjak@cock.email) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #2)
> Could you please attach full dmesg from 6.2.2 and 6.3-rc1

I've attached it to the report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
