Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D59ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiIFIFd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIFIFb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 04:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B52419BC
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 01:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F31FF61241
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 08:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61DB7C433B5
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662451528;
        bh=VxIO1zDtGYeAeQXFUWKT4aJn34Dx9vqGmz0m1WeWzPk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=krtoqP4+1E00RKxA0D9JCdiKn5ZfRg82OqEgRdAwGNZGkbpir49t3oLypvZOP78Tr
         OaPdB3wXXwxwByQnC8vQUl1fzNQSh9xNIXwM4INMwp8GFqnaDWSee7xf3S7NPfGa7s
         CEwDWQVdKt4BiEr0PIfmXpkdXpH0JUNo5J6cpHy02svvO7ZvHQqQa5ycYKVV7KSMCx
         HsJ4tyUDjE0i5DBEqxuxRHa9iUSGpPbWTpx1Tx0I7Z4dRY8nCG28RiBObtEgsg2lAJ
         CPuSg3j63XpEEolapt7webXzwxQmDuGsmFcMakz8smiYGw6VwUV2fxfHnpHb7OpqJE
         JwKrd/kt2/bJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 46007C433E7; Tue,  6 Sep 2022 08:05:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB AX201 bluetooth (8087:0026) device is gone
 after system resume
Date:   Tue, 06 Sep 2022 08:05:28 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pawelwod@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209659-62941-pjaqEglK9r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209659-62941@https.bugzilla.kernel.org/>
References: <bug-209659-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209659

--- Comment #6 from Pawel Wodkowski (pawelwod@gmail.com) ---
They officially admitted that Intel don't GF about that issue.

Official suggested "workarounds" can be found here:

https://community.intel.com/t5/Wireless/AX201-Bluetooth-dead-after-sleep-S3=
-and-resume-continue/m-p/1412902/emcs_t/S2h8ZW1haWx8dG9waWNfc3Vic2NyaXB0aW9=
ufEw3UEFKTFJFU1U0VjI2fDE0MTI5MDJ8U1VCU0NSSVBUSU9OU3xoSw#M43083

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
