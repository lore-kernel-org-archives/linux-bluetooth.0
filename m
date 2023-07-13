Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCCEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 04:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjGMESG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjGMESE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 00:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A019BE
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 21:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2A661A0F
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52B84C433C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689221882;
        bh=fgtmmLJyQbjBPmD2LcqR9HK+IgDMWJVtp7BGChftGSQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s4EZLWk4Pitjj7Jwxa907Rv7P6vj/GEnz4l5oAH9bS+4QFjt0LFNLPBw93ahmghLb
         OKg/NCA9f5SXF6s6ina4TOQds3zSW+IuviyfCLBYxJUrhS8vgWymswumJGA+boxlmI
         8duvqRajDoxZURvpVD9kZQNSSG1RPBB6854+UeunCcpO8BY3evhYYiiurNUbYlKdoe
         WwAAgqU8GBZKARM62uBQcEe14PssMF6yTffFisqmsEJdARKvoa9J+8I/aWyf4jPt4B
         PNhOE47aeIKpLWXUfDmfSj6XNmgmRwF3e9zp8l/Jf4Yxc3a1QE9NjenbdkFzQkesQ5
         b7DO3KFz7lRXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3C690C53BD2; Thu, 13 Jul 2023 04:18:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 04:18:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217651-62941-HHVJcyjKtG@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #15 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
John sent a notification to the mailing list, so I am adding the back link:
https://lore.kernel.org/linux-bluetooth/552a361b-d699-5d96-543a-e3aa09e6c05=
c@molgen.mpg.de/T/#t

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
