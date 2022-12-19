Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20D4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 08:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiLSId0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIdZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 03:33:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56D95AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 00:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6660C60D14
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 08:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2377C433F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671438801;
        bh=v7ZYJ1K66SK22UrbZ+53zRHuucWHDkrNBeWR16Sac24=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T7CSov8SXokBdREYWqsBq9diM9EbZLT97SXgIH1iEPCos42tjPD7azPPWKKv2Pge0
         iaODv8Kp1XQZGWaSDMUqQ5LS0ipBXQuhaA2ErKhJG0ZuiGwTTzz1iGRjcSjtPs2XJ7
         FxX0rPhhPxvw5V86PfMnr3kx7U5vLc77y75CbaggCdffmdk3ijDxnl5656N0+KQ5X0
         Bk/A5qRQaMrom7LYvNdqTs+RwFX4tqIFx76nm68hUryYk0y9+DBeaD4dGqr8NcpJ7o
         JWqEfG+R5J2HiYIifjcz/q1FXDwI0ErSckAPkz3ogpy0dIiApAdu0Hqa5kgzQpEr2N
         wtkbUXNrMTuTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AB01DC43143; Mon, 19 Dec 2022 08:33:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Mon, 19 Dec 2022 08:33:21 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216817-62941-m9bol45Pfx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
FWIW, there is a fix for that patch that might or might not be related to y=
our
problem (I'm not a bluetooth developer):
https://lore.kernel.org/all/20221206012323.3684462-1-luiz.dentz@gmail.com/

You also might want to check if 6.1 works, as some fixes are not backported=
 --
and 6.0 will likely be soon EOL anyway

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
