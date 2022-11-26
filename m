Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B6C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKZQLH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZQLF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 11:11:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA01D646
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 08:10:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF85060BFB
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E261C433D6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669479053;
        bh=Nxi3KaOt7q+Yzchp5rcO4PKQjFNFr1CXUwvjXMfFIAo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JHKINI+lCXGgN54yNJEi2HDxq5Up8dPmFRlVUiqFaQA3Hekdw1P2lVn3Ko5uUODjJ
         IeRKhfy0l8OEp8qWxgmsucWtk5hx85Jk/a1z2sYuIt6jyngARm2aL8bzSik/Ld+zrm
         FajcMR4kNAS6xLSp95bQC9R89vusaJP+16mGS5MxQrN1i4LO4VqZIqTJNe4C/N5DRJ
         WGhajD3oHOepIt+FU1EIiLNTD6HTODFuXmxZ2khE2I5fn3Y1NJcHpI6TQ+ObecvkNa
         gtrMsXRZMd3Xvw0ZPXa5b5MRPRF8KIOrgUgxn4kwaF/+G9gP3AlGPGlvQHWJzcqkmY
         WG7x6RaQTHxjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0FC80C433E4; Sat, 26 Nov 2022 16:10:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216742] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 16:10:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-216742-62941-dKsGQZECXd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216742-62941@https.bugzilla.kernel.org/>
References: <bug-216742-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216742

JustANormalTinkererMihir (justanormaltinkerermihir@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
