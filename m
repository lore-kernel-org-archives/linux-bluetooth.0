Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685F760F0F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKANYP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhKANYP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 09:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7CB860F0F
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635772901;
        bh=CXw+ATBW93YmqZspJK08IyB3+DYg2/jFvLVjJq4Ivw4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lRhr+yBLpCrPQGLtdVwzie6vbI5dpOId9wbYqGdmJhb04EU3BLSmdgsgBxnxaLCK7
         thv+Ek4FwZPnX1yImZ3YtZfgfKxMxF9DHHWmGZ7c8Bse6BA7Ig4jYnygKsSJ8YkQE7
         6+sS/gAG7bdwlhhWZQk00hKiMwNKBtzn/ri5ByvTo6b1PQ6CBIUgYN6n0NyGhLUGmH
         +mET966Susby/7ZCPz/vlcNvlykULakLE3L/yqZGU/45XrfdKeutQTn9SdxFBnuUK1
         E/qeB8j02uamX2lN33r/6JF+JRpRE5iqJ75E11c3p9tVnj+goqLroRMuZCsrXdC+50
         sd8zZP/GKQ8+g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Mon, 01 Nov 2021 13:21:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-45IDQfKQ8I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

--- Comment #8 from Marco (rodomar705@protonmail.com) ---
(In reply to bryanhoop from comment #7)
> Unfortunately after the update to linux-firmware-20210919-125.fc34.noarch,
> it appears that the workaround is no longer working. Even with the updated
> firmware I still have to unplug/replug the dongle after startup to get
> bluetooth working.

Recently tested this, and even with the new firmware on my side the workaro=
und
still works here, even leaving the old config in place. Don't really know w=
hy
it's not working for you anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
