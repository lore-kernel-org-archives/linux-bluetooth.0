Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 16:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiC3QSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiC3QSy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 12:18:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDBBE22
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 09:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C906CB81D6E
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90A05C340F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648657026;
        bh=HpgMc3I4DlH1IzgC3w6CneuKgzJPvi9sRwSWFIWNHk8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AGgfxU5Wq8vMz8kQcNH9UCbOQNg6xA7MzyLIN2i4Y3KijBKrYeqA0fmBv/NCMa+Je
         HkJbhL0cWs6syEKp6xnYHe2Ros/BZCHAjlEL8dCx2PucNsyJghVLOdQZgqgSeWqaIF
         KjJY5q08nhfxOIXBkU8DIeOa+W3ihXqnp3Fk852lUZJIx3LDfoCfYWQsoEegZj/H2H
         GfQIdXCkctABgY26PrrY9mtl4LmD1k2NUrI76knzGdE6o7UBuJhS/ynsv2Q2kalvVd
         O5gBP3YejJyvuaFZL1FC74Yz+SKy30B6/85nR8EvPqMSbjD8J8mccAIRr1/GkseNV5
         Fpq/D0zSBdbDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8011EC05FD4; Wed, 30 Mar 2022 16:17:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215776] Unable to reconnect Bluetooth keyboard after
 disconnection
Date:   Wed, 30 Mar 2022 16:17:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215776-62941-7AXFElgDgW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215776-62941@https.bugzilla.kernel.org/>
References: <bug-215776-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215776

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |CLOSED
         Resolution|---                         |DOCUMENTED

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
> Could you please advice?

Since you're using the Ubuntu Linux kernel, you'll be better served by Ubun=
tu
developers.

https://wiki.ubuntu.com/Kernel/Bugs
https://bugs.launchpad.net/ubuntu/+source/linux/+bugs

This bugzilla is for the vanilla kernel which you can trivially compile from
sources if needed.

Kernel developers are very unlikely to help you because they primarily work
with the mainline kernel. It's not humanly possible to keep track of billio=
ns
of kernels by various Linux distros.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
