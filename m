Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDEC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Aug 2022 12:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiHXMgb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Aug 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHXMg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Aug 2022 08:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA280484
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 05:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6DB8B823EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 12:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A01A2C433C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661344585;
        bh=E9hmqH3s+GtBbaQfKiFcYNZM1e7Mxe+wiVPLWRFJzKc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oo4aPU6T1+jAGXKI3YRuOjIgyPmluuBS/E5lzrcQF8eJMsrmVD3P6n10TPHDcmFu8
         WlZ5XDcbhddTYFzGlfFrAgVUmGah/0TZPCbVKthOgnz+ZNGcd8sFhg9FpKoy32pL2I
         t7ZwIGiisGzxGapXy08Q89lcUqdCK/Hvb+L/isgRPH1BQYKv1tVa/J2mO6DaifY9dI
         6XawvCgVVHP+v7+79vR9yjwuO8jpzVDdUVlLqHTBqfWHIzelYAsF6CpTMmtrYgpxSQ
         1Hs/d+nHQ/ZeF+jkOxU5PL0aXHclO387AA4rpTfQfMuhX5tzfNLhLTfBNl1UWrxphs
         2njjblGaqTjow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8B540C433E9; Wed, 24 Aug 2022 12:36:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216389] net/bluetooth/l2cap_core.c fails bounds check with GCC
 12.2
Date:   Wed, 24 Aug 2022 12:36:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216389-62941-y9J6WOuzpW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216389-62941@https.bugzilla.kernel.org/>
References: <bug-216389-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216389

--- Comment #4 from Erhard F. (erhard_f@mailbox.org) ---
(In reply to Luiz Von Dentz from comment #3)
> The following patch should fix it:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/
> commit/?id=3D1d71d9223e4143d3638f60c7bb291844c237556c
Correct. Thanks!

I'll close here as 'fixed' when the patch makes it into -rc.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
