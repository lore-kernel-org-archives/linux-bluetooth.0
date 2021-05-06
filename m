Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C88C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 03:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B8361185
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 03:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEFDee (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 23:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhEFDed (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 23:34:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F16D5613ED
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 03:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620272016;
        bh=hjjNiPxD71VT+ThRPJb0kuseeO6gFfZ0rc9Xx0LxCLg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LTmlEGIJKMqYJjJkcmqgHi8OplRJQDIeiQfCvTNBvQHXZaLBLmwiohiPMxTurSu+F
         l6I9gav0Z1ynuD53Yc5UMQzGpCrcmjAwT4yS1nFcOhg1Hm37TJiu3K7To1HD7ApmIQ
         wrTL8bJ5fsqQyybXEW4VvcUwlaPAH3BMGKCsdsWgBrKUi+8xoKnM6SDww5ZkqMm5mJ
         eads4k+rTLTCkH44wlF3oXZNQ0DicP5ujpNbdPst2Awh4yg+pVXwkB6DR8FT3tEs4x
         1SxByZP1dnpj1xRsxhPRWxaIP2rOI2nUbm/b1JvBhariVHvCitK/LwE9SHPO4NDUhU
         LJ5ALiwYz2oFQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 06 May 2021 03:33:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: diegosiao@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-DPaaWwwSAI@https.bugzilla.kernel.org/>
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

Diego Morais (diegosiao@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |diegosiao@gmail.com

--- Comment #174 from Diego Morais (diegosiao@gmail.com) ---
I have a CSR Dongle with the exact same problem on Debian 10. I am a new li=
nux
user, so my question is how to apply the patch suggested this comment (In r=
eply
to Gustavo Padovan from comment #6)
> Created attachment 107379 [details]
> mark Delete Stored Keys as non-critical failure
>=20
> Please apply this patch and check if it works. Also capture logs and send
> them here.
>=20
> This is a modified version of a patch Johan Hedberg did some time ago.



Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
