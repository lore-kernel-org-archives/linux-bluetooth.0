Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A00EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjGNO6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjGNO6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 10:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E81991
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 07:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D7661D5C
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 14:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC035C433CD
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689346694;
        bh=WCLwADHtg87tMlLp4uYH0NFu4nD/WNN13PrNM7hmlV4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sJeeag2lK5QsHxCoS0/9dJvx76MPfya8/lKGziJbnHazWmZkqUAj2gpIV3njTKQUt
         6uGwkf6ghZUl0fEsTS1c92pO0VgYU5EedfNM1gwfHIM5u5L3w60+ez/pSfrZIvBPXi
         LdmMKewy9QBtO29J9ZhINAa9ZP6+NHdMR66cjlWQ/In+oCLC5yK/aBnrW6Js/lTZdI
         11XYrv0F2+9QEgSLTEEkJXzb/P6SbrZC6rCqRLg77dNSAeACYS+TZNGhJt8gCP10G/
         +4eMsYOHWql5roNEuAOrvS64QO03VOtAQ3trrDE3CjWett7M9TVUBkvjqJ5lZFUIAa
         9PKzwUnLeioAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BF3DDC4332E; Fri, 14 Jul 2023 14:58:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 14 Jul 2023 14:58:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marwane.elbaraka@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-344NKWUP9m@https.bugzilla.kernel.org/>
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

MarTCM (marwane.elbaraka@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |marwane.elbaraka@gmail.com

--- Comment #272 from MarTCM (marwane.elbaraka@gmail.com) ---
(In reply to Marcos Ferreira from comment #271)
> The device support will be dropped down?
> There is a possibility to keep this device working since the changes above
> can make to the device work, even with some logs in dmesg...

That patch doesn't seem to work anymore *sigh*

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
