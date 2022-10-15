Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4695FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Oct 2022 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJOTMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Oct 2022 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOTMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Oct 2022 15:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4BC47B99
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 12:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E898609E9
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 19:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63AC8C4315D
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Oct 2022 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665861156;
        bh=w5kajXdBMPTRFrTmz6AyBTIhI2PTu+2rMMciAoYVZto=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d/Kec8hD1NWkSX20v3kJUyRcAutAe+o+CnJF2dwlAB8lSgOuH72XbyzXdaM98nDnq
         4Gg+xT/vFbCUlzYKS+5x1+4qyoqDFkoD0IJWao81ZJ2V5dyMdHWhetwGALH+S2qgNW
         go9264gmrevp/hqiV0WM7+Add4xMIJraKxSeGRLmnpgbVF6EBwy8xR5Wx/Dtl4u6nN
         W6tCCO52OpoEZuMr2d/ccJn2r4RG8rKWUY1HA3/tcFiz1HkVaq2Kp3KYRHtockB73j
         /o4e1OiE5JHy1vYlInf7hdug9wkxA96l9/boJZxxOV5oWUu6EUUZR9RmAcZxmIkIYj
         FlIBmVUVtzTWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 55F38C433EA; Sat, 15 Oct 2022 19:12:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 15 Oct 2022 19:12:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-7H0KpPInxa@https.bugzilla.kernel.org/>
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

--- Comment #237 from Jack (ostroffjh@users.sourceforge.net) ---
I"m working my way through the pages on reporting a regression.  I'm running
Gentoo, with the gentoo-sources kernel source.  This is not pure vanilla, b=
ut
as far as I can tell, no patches related to this problem.  Can someone conf=
irm
that I really  need to compile from a git clone of the vanilla sources to d=
o a
proper bisect worth posting?  Will a regression bug be accepted prior to
confirming with pure vanilla sources?

In my case, 5.19.10 and 5.19.14 work fine, but 6.0.0 and 6.0.1 fail, and I'm
compiling 6.0.2 right now, just to test, although I don't expect any magical
fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
