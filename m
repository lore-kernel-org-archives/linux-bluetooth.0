Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE21C46467
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjAKTqj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 14:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjAKTpZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 14:45:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E713CC1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 11:44:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C259FB81C9B
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 19:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ACF6C433EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466249;
        bh=ZQtyafo06LAopPy/HVHbPo5HRoRVE13d17ZLiIuRUPM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dLHArG7DPoJe7OyZzLOhsCx1CASsG+5fTVwocwGw1PMDLq0UHGrPjxD4yKC0qlXEU
         UmeN+BPtrgeT/EWK3cBX7+4E5lF4C43qJJbU3XgCrdQZ5chu8zKVCqZyRwh3Mllrtc
         IaTxia4uj+h8HwT0IiVesW3qqHTtgmskH1/EcrX7HAusJHmNA2pDyBpSYEr7RPj5CI
         KC0kiyQ8F0b+PKywJSIgEpzogBGp8N4WVkSW2rDLLUPJm3AJCLRVfhN1m0p+WRgLsw
         J4akNgx+Dnz1MufLXWuPHcD5w7enFJULJQwdMZLjUfg//LqvnMQQUx+OeMYUGW458d
         M1WHS5PmvECdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49D48C43144; Wed, 11 Jan 2023 19:44:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Wed, 11 Jan 2023 19:44:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216817-62941-l33pAkN9VB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #9 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
As this completely broke bluetooth for a number of people, can you please
consider this to be sent up to 6.2-rc in a fixes PR rather than waiting for=
 6.3
and

Cc: stable@vger.kernel.org # 6.1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
