Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC519EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKOiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjGKOh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 10:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DC10FD
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 07:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EC261503
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC173C433CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086267;
        bh=hikQaNItGMb8q8Ew4PKeQYlNy7DtXt2JWTOi8iPgqCk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YIjStERxA79cz+8mlE6O24equUc5IQq6Y7P+YwdXUT1GBBPt9dvYhxua2FvDfJgXe
         qA4uPBA7wfizvLOzbXtvNiIw9vyc2oE/0gjBVu6kytXT86SZ0ggdDI/A5SM4XUyGIR
         YjYmbQVR8axGTMrHSmk7zK6dPg6eZ+w+S5M2brgtYZkokwwwTiXDoi2fRD1VVNMPiT
         pXAGrBoQfgI8ooyt+01fCc67OjwXaEWEyJcAv4rA0jEHkcffw65Lp9OQf63nJNyBKd
         69QIivTjNY0Con8Texq8OoiPhUuHolUfQ5MpYQRKyke8+ndZXrqPHMphF7EyUleGdL
         dHpsVQfASbwfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D7B64C53BD1; Tue, 11 Jul 2023 14:37:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Tue, 11 Jul 2023 14:37:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217651-62941-SKvR2l4ezI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #12 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to johnbholland from comment #10)
> I've chosen a commit from before that and am trying to=20
> build that and test it. If it boots and the bluetooth works, I guess=20
> 6.4.0-rc1 and that starting point could be initial points to use in=20
> bisecting?=20

Thanks for trying to find the cause, that helpful and simply needed in cases
like this. You might want to bisect between 6.3 and 6.4, as maybe it's some
change outside of bluetooth that broke things (but it's possible that you a=
re
on the right track, too).=20

Side notes:=20
* might be worth giving 6.5-rc1 a try, with a bit of luck it might contain a
fix (but there is a decent chance we are unlucky).
* cross-compiling might help to speed things up.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
