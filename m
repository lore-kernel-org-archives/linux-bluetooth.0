Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F08C4321E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 16:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKZQaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 11:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKZQaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 11:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36E1CFEC
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 08:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450D160B52
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95EB4C433D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669480220;
        bh=IcFUk47ZAyZxCb1pMBHIyTAIeaetOpLXnqeo47QvP/w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rM/d3W+hFiTA0HzhO6JFU38qxeMtwr2HC0kI2fWuqt5XcN1l47Td9s3MsOzq84OQO
         WXxq2Qa89SMPujPxTDAcV1aBWlkxzNB7k/uPNdfYfKAGyc53ML9GwTrKjS0cSpqObU
         NC1pfUAt0Za5oP4d7B4Gj2kjw74tkwUWEaKX3Y2LCwoxuevPqH95XA5iPn43re9anf
         0C2qfak3m/BjwtFV5u9bF62QUz631659S+jbqlj4BzbHiHaUSP48mR7xgIWWlyyg1H
         fHCnYAC6FPD2bXUWT27mXyOq9GSn9P3oKRA3qW71xd6c63XkBURMh4igm5UVYbZf7c
         1ibdoKcVbzJWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8218BC433E9; Sat, 26 Nov 2022 16:30:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 16:30:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-pgwJuHmRSL@https.bugzilla.kernel.org/>
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

--- Comment #5 from JustANormalTinkererMihir (justanormaltinkerermihir@duck=
.com) ---
*** Bug 216742 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
