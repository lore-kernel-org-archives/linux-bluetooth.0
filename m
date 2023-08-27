Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF9C83F11
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Aug 2023 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjH0P6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Aug 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjH0P6D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Aug 2023 11:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92739129
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 08:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E186118A
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89EC5C433C7
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693151880;
        bh=soR9wTSeLpJ2aGbcmgoQOI06pKJIwt90+Sw1lIZAo6U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qz5dlW6Zhc5RVQdiZc4kXPIIAYFX2eZt6AChoW7c7aUj4aL7Cx2QXi8gh+O2t+0EI
         PmqG+dps41gtvk3cT7wN1CHzeL+xW08e0L4M7t93zugTd0KFcPeUkfFMjNfjDaYHQy
         wZ3ILwGShJNCpa0R1VlzDHyB1bdiyE0XZwdi02to1gCIEhyn3abhzZKi0UjirC5Gad
         lRhU6FsnSwTlXmEwGegx7pCDF2p2/X+ttjaZ7jI5J3o9XA5Hi27Y85H5Fb2B9W2Boh
         smsK8czuFxC12JLCy0IXiLOiUMxJCc+yGdrM126RgiiA3YFdGKXmwXLClmnNlv30UW
         UC/9A+28hKL/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 74CBAC4332E; Sun, 27 Aug 2023 15:58:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTc4MzBdIGFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh?=
 =?UTF-8?B?YWFhYQ==?=
Date:   Sun, 27 Aug 2023 15:58:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pingo-power@hotmail.fr
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217830-62941-mV0U52BhJe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217830-62941@https.bugzilla.kernel.org/>
References: <bug-217830-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217830

pingo-power@hotmail.fr changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
