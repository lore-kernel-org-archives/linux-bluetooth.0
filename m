Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBAC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCWAI7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCWAIz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 20:08:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEFA30B25
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 17:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7F17B81D52
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 00:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81901C433A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 00:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679530107;
        bh=ofEAV3cx6wHXp9PInqMrxOxPV4c3zH+eaDVhxoslPjE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NrmiphIMeVy7nfSXg7y669dW9iQmgWysOKH0B6RR/tDm7nA7cX053bVG/efcIEpoR
         qE2NJ+PDvBQPEr5U0BilRWUiF/CidHYhHUnIwktKRxBY6I8TSUdKRSYRf4ymnYbM5J
         0BWkBbWbVKfzXSYLFnDCEHLdA8MYhITluqoOhEjNFgmAy0EIEP7qo1TunelPKax8db
         /ORoHw6hRegz5PTTsefmBd3lMpiCGRnCC5MKTnvMr6Zm+3aaj8EsOqu9Xyd7EHBYMt
         MUt/tN/Kqi/UgcWE9pV6Wzh0DmGfLS4E3HXGFXUWzxEj5dKurAL6wESWinyzU6XUr+
         HK0tEuvefRgag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6E882C43144; Thu, 23 Mar 2023 00:08:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Thu, 23 Mar 2023 00:08:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dan@jallits.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-1PJZVZeXKP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D203535

Dan Jallits (dan@jallits.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dan@jallits.com

--- Comment #14 from Dan Jallits (dan@jallits.com) ---
I can confirm similar same results as Toni A. with a Qualcomm Atheros QCA63=
90
(Dell XPS 15 9500)on Kernels 6.2.7-arch1-1 and 6.1.20-1-lts.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
