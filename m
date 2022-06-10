Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D43C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiFJQhO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbiFJQhJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 12:37:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78957171
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 09:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 425DFB83654
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4BDC341C4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654879026;
        bh=SwEjhRap3x2aUWYcqtFetsNysmTePGay1THeP61hKsI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q9yE/uv4umlQR7+mH3brhkDmhLTyiI64y53M6bWKX5mASzm0LEAxgcrwRp6lsr55b
         PRrDWuwUe90lzGSQyoBfc1kFJhC7O3gxxS1rp2QvS5AdEbLjQzjxPWDY7obCet5HnB
         kMB02AyKoyZK5EuWtXXJBtbrjmH/Yy0rDRe7o0eB0kVUIouiTgE3FLBzZ9IckYZBvD
         vJJ53mesixPIzuqJCGPhg113MFlmGgLi/MOKiCNvulM2POz6Y/BWyqKd6bZh4fRkyP
         KOlxmLYsuN4Z28seVI8oqXlyzhzl7ruDRMrIBLBkOr+SNyqqQJDHBIAFVY8qgLRqQI
         CJpeu+cFNbSBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DA46DC05FD5; Fri, 10 Jun 2022 16:37:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Fri, 10 Jun 2022 16:37:05 +0000
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
Message-ID: <bug-209745-62941-yfteIfFRoJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #23 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Massimo Burcheri from comment #22)
> Somehow I got it solved without removing IdentityResolvingKey with these
> settings in /etc/bluetooth/main.conf:
> AutoEnable=3Dtrue
> Experimental =3D false
> I guess the Experimental flag is important. However after restarting the
> machine, the pointer device was just connected and working.

It seems the problem is LL Privacy (aka. Address Resolution), when that is
enabled certain controller seem to be unable to resolve addresses so the ho=
st
stack is unable to reconnect. I guess we should be splitting the kernel
experimental features from userspace experimental features, anyway Experime=
ntal
is never meant to be enabled by default so if anyone is shipping with it
enabled on main.conf please reconsider.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
