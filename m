Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F10C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B859261BF8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 07:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhKQHUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhKQHUT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 02:20:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 047F561BF8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637133441;
        bh=EO7qyOev9DbdkJ2e96cJcRtI5CAXNKItwnlMdQSR5+E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L8eX/8Kdhu8L47DJFT1Ghnaybsvf5eT98v3g+82Whk+Ab6DhKCUisjVfewxFaZLAg
         1oKoEF8OLvAG2IpgGQQilkyqV5LDmWNBqEG8kZwoFY1fKVzkuYxjxQ52YxURIRp0Fu
         BbtC+3jB+sEvHU4beHWkpGhE37u+SD7PqqjKtdvLXPs3AcULOTeFQ+Iwj/B0h8+KYq
         UyRoQXddMnctmS2qHIKAXr4u86xhEwemi0mTSKvctA0WF+YpTTQGKiqWywwNdzpR7o
         UmOvIqZr/LKhXeHTYVDfUQbxctYF8HeFbjmyYJwzqNYjl5qgca/EEZM8lXrJJ9ecTQ
         1iLaGEHNf78BQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214273] AX201 Bluetooth unusable after: Shutdown controller
 after workqueues are flushed or cancelled
Date:   Wed, 17 Nov 2021 07:17:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mavckhunterk@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214273-62941-q85fvdp0Mn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214273-62941@https.bugzilla.kernel.org/>
References: <bug-214273-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214273

M (mavckhunterk@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mavckhunterk@gmail.com

--- Comment #2 from M (mavckhunterk@gmail.com) ---
In my case it just does not work at all. Using Debian and a Lenovo Yoga.
This worked fine for me until Kernel 5.11 (Ubuntu) and also works well stil=
l on
Debian 11 with Kernel 5.10.

The problem also persist in the new 5.15 kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
