Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79430C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 14:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKZOjF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKZOjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 09:39:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7813D67
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 06:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B5CB80159
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 14:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC6A9C433C1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669473540;
        bh=eU2wzPgddu6lxoeRNiU/K2EcdZqTZQOWfIOr2oYelFY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aSq9fojsIxG99G5dn3B5MYgX1owAle/rfqnDP0iOp2drPPXzKW3RcJtfNhHtIp8Qu
         pg/DeAiRPt7hRuKEHVbDS9jog7djGwOwIoFMoNWMGbeXbc7KLvvYhWmZWTmq1aHLLd
         s3WhTXNk9UAtaM4O/yNaeeLVWSojiFZ7J3sokl0CYIHOL5oZ0XMZSykdNCn0vaRhRg
         ALbTjQedLUUYOZWvhh2ln9VOOf/iNbUONFUuDtSTllXCFijVjEH2v6F9s1pSIQTbxo
         AXVvSxFYcIUclQo/+kpqrUEolXQrqREHvtZDj0DoZM7Ct72pMzXXiX8dXsogmlYFCA
         Yy6CMiEMSxyBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BCE10C433E7; Sat, 26 Nov 2022 14:39:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 14:39:00 +0000
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
X-Bugzilla-Changed-Fields: cc cf_regression short_desc
Message-ID: <bug-216683-62941-PwZlEYd75j@https.bugzilla.kernel.org/>
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
                 CC|                            |justanormaltinkerermihir@du
                   |                            |ck.com
         Regression|No                          |Yes
            Summary|notifier callback           |[REGRESSION]
                   |hci_suspend_notifier        |HCI_QUIRK_NO_SUSPEND_NOTIFI
                   |[bluetooth] already         |ER causes kernel panic on
                   |registered                  |fake CSR 5.0 clones

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
