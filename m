Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50BDC678D4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCGJIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCGJIC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 04:08:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BEB113D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 01:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FE2B816A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 09:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EA98C4339B
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678180078;
        bh=F6YNDUVJC/fc6gVkQFu1Rhzy00vvVabN4IGfNFwGoZ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iFAMSsrsO2+xMvNe7vIhBYGAr1FmjDHALPN+VGZ8sjwMuVOwIHgRfLe3HjyRxr3wX
         Zj2z43zgP0H2PGroT8ZWxv920EDSs06naRh428RaDI5D68E3/UT6mNLGl4xPzePsZC
         1zSFhjOqHWonBH5369KrH59i0c/93nYkO90Qv4CM+4IYRvkmBM4bidTaYDhP2ZF1Uk
         hjVtxAd5pepDyANYuMtfjZslfnuSHEgOC1Jwr5c83SMTaL3HjfTYp2tU21d4iWG5lV
         AaCC5sOhB6+kT/R5j4znVdbTWQATQzGfJswJ4Bbz99UJSKLYgZ3p73GlOa68rtFFc6
         NxBhDhYicha6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3CA58C43142; Tue,  7 Mar 2023 09:07:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 09:07:58 +0000
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
Message-ID: <bug-217150-62941-F5nIfh6vJt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Could you please attach full dmesg from 6.2.2 and 6.3-rc1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
