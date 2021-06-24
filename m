Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C2C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B839A613DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFXLpi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 07:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXLpi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 07:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9AD44613C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jun 2021 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624534999;
        bh=6/tVaIWjp/d2BqocKFYPvCSIZbmuuizOf70KWwNYa08=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nDMYj3HSQ1jwt3fU8ZOAhluIxDdehBBjUqzQAk6jLDENrax9uth/+1BV58Ycz+zYb
         /mG6GfvsGZIplQBwX+MzvveiQMeylGMVphgooI1mhvb0T1yUmzPcxT1s5XgiSYW/mN
         5LvDcI/58sle+bcYULCWJsnJdSUoPVCJEr5KXTyEqyAtbfeYBS2jk0pkjkTiXY4AQu
         vBUKWG0QHcm0gOuRLcq2kWuVmAuR8pW8FQnyrgVjZGa9XVPi4UFojDtEJHwuclG/b+
         KRCHA+oCx4RgKYMkQGgIDm9ntmz+C11UfSGZs00md7uUukujbBebus9m8vwGDHa2rG
         ldJl15HWMzqqg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 24 Jun 2021 11:43:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brettcrisp2@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-kexiTCre9Z@https.bugzilla.kernel.org/>
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

Brett (brettcrisp2@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |brettcrisp2@gmail.com

--- Comment #185 from Brett (brettcrisp2@gmail.com) ---
Hey everyone!  I'm currently running 5.12.12-arch1-1 and I'm having the same
issues with the CRS bluetooth dongle. I've found that it begins to work if I
suspend my computer and then wake it up.  This has worked every time I've t=
ried
it so far.  I'm not sure what this means for figuring out a fix, but I beli=
eve
it should be helpful.  Let me know if you need more info regarding my setup.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
