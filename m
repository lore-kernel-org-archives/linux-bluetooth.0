Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D69C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 09:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbiFUJGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348009AbiFUJGC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 05:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E309186D0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 02:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883336157F
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDF44C341C6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655802361;
        bh=JF/axrrJ5KSoPO7eoMzUmWnF837IdlLpP17QKTFe/bk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qN9vLfUxrN/F0UMOFm/cmApgcmpJsyKbLf+Sifn2Sh69FbkySdqmWBosj+vawHX0O
         f8VpH8agxxDtzPj1mvHqKlUkFogI8cOxb/so8GnR7kyhyZJTCvDt9ysF8DqCWQiv/u
         MfL3mzBSnL5x4kjlTcuE93ZYWkP513U1JcOgzwg2XnB/3Ft6OYib6DuWnhEOyqFsTX
         kn/u5T182cC2tu49ssd0+eyCjFJp6L105sqothRWE3md2mn+YHnHGttF7SSzYeeC0P
         YQHI6gI2UT5x6Ln+iwsI2boN+5/Mh2B2AABHgSQLSows8swxispcEKtgfx/xurUhk1
         lwdrg5pYIoYEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CFB3DCC13AD; Tue, 21 Jun 2022 09:06:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 21 Jun 2022 09:05:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Krzysztof.Krason@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-NS7fxrZ9v5@https.bugzilla.kernel.org/>
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

--- Comment #27 from Krzysztof.Krason@gmail.com ---
Just adding one another note.
I didn't have the issue for few months (I'm not sure what I did back then) =
and
now when I upgraded to kernel 5.18.5 the issue is back :(

I need to manually connect to my mouse (MX Master 3) and also keyboard (MX =
Keys
Mini) and also my bluetooth set (Jabra Elite Active 65t). So it looks like a
general issue with bluetooth.

I'm on old Ubuntu 20.04.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
