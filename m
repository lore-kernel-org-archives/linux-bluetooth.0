Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiKMRPO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKMRPN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 12:15:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B049DFE4
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 09:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21EA60C24
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 17:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38285C433D6
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668359711;
        bh=U5q4ft1oAHCswAGto2/xR4FfgCcwo2paobiV7+S5LV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GljK1YMLM7dEWIFH4XRlYLqCmfmugk2Gm1xlWCYRjOvbLT2UcpgLaFiRstolUV8ZX
         Qd0xxu4u2qUCNLclFTToDKNJ/Lyk00/E3Qhz8+yUUzrfJxSuRCt2Cew38K6eA6aqvw
         fg7cxigXHp6z1ILnUAUNn9GRduJfz+HoGlOpq+Skqyg24O3tfH1Bxu3v78Ot4XtkJk
         X1Yq1+VEmTDU4N97567fpdpbjpCs+8981rBApkn3QBSKapc9SM0u1Px+gN6dZpgV2t
         KRIsHxLMmDuAeqzk8pf0zJp3kTMA1F9qw3c2TiXmMpn12FBt9RyhX+h5T2Fdm3NRAU
         5lEAD2aXRzUww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A910C433E6; Sun, 13 Nov 2022 17:15:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] notifier callback hci_suspend_notifier [bluetooth]
 already registered
Date:   Sun, 13 Nov 2022 17:15:09 +0000
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
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-216683-62941-wB8uFhEoT5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

JustANormalTinkererMihir (justanormaltinkerermihir@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|normal                      |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
