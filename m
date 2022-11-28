Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7317EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 18:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiK1SCn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiK1SCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 13:02:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117F46646
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 09:48:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E2C612AF
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC6AC433C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669657736;
        bh=bW/LqSpbHv/gfCX0BeyN+ol7/9bxu6S1iIjJyVlmcRE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WwKFksE5sqrvItIGIy91I0reBv1j+aGFf7eTgGeDgusY4MnCnxQRyZM3yg0cjk8p/
         koef9JTPUnE+E0Pgx5Gud/eGOyE/j8ZRrYJXiAuu/hHe5eDKKY0k749wtOTQOTiV5z
         peJWrogv7xTy9DeRfII/gyB+Yy0QNzCWevhtF1pi/dbxB9cCxgsrkf6SeX5d26h9mk
         r0p2n42FizS00OinTykMmU0vAaZLxyWlfcF3kbAK6mZltilJtY2YViFJz2U+iFP4b8
         8no3rnQRZfkonoyMAA8FUDBOldKCmW76SRa1dNv+OBeF0zHWpB3/TM6ifjq330A1Xx
         uKsoJ2/L2YeBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D1F2DC433E9; Mon, 28 Nov 2022 17:48:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 17:48:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216683-62941-c2HwjPErMv@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #13 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to JustANormalTinkererMihir from comment #12)
> I am now able to reproduce this issue on kernel 5.19. Same kernel fault,
> same thing happened again, the dongle disconnected and reconnected causing
> the kernel fault.

I don't think this is related to HCI_QUIRK_NO_SUSPEND_NOTIFIER as it was on=
ly
introduced by the following change:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/drivers/bluetooth/btusb.c?id=3Db3cf94c8b6b2f1a2b94825a025db291da2b=
151fd

Or did it reach 5.19 via stable?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
