Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CEF610A8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhKANBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhKANBV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 09:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3EB57610A8
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635771528;
        bh=7lKAOJkpzC0DsKC8y991AVH8BHXUCU+SnCf8jGpiWY4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DJ48YyWtEMjZvV8h4dmTl/vgIOiRuGhv1Qsp0Dgc9zxPzRO74xfXQtP9ESjsGcxrd
         cm5W/+n7NyTu5OILEAweXsMEL3VqHu7zoOEJ+wtX/3eTd5TM/Idfpd4sRljDU19pwH
         CovdWG26Mt7MMTIVNUxdpEunvDwwvQ6fjjghfClMufcLHJ6+uBGIWz/R8KFTzxFrU+
         S6kSq9SDFEm6IouYfpiE6FmP9WwmTgRTJitdd442U6tB5KJTnDAsHiZ/Kvp+aWBQyx
         BWQJzzOh9YUcrTQ+7/8A90mtAH39hZjRkL5cdQ/ourDMPiUgf/0K1/xKxtRHld6uQ/
         /ij+0n+B5MTOA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Mon, 01 Nov 2021 12:58:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bryanhoop@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-214111-62941-ukBm31iENn@https.bugzilla.kernel.org/>
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

bryanhoop@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.13.10                     |5.14.14

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
