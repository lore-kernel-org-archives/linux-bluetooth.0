Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7DC7618E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Apr 2023 16:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDVQgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Apr 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDVQgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Apr 2023 12:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D31729
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 09:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688C46109E
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 16:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD857C433D2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682181394;
        bh=nAKzzBip0pjIuY6JILk3rWU6YqDJBe8zqeEljoI/R4w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JdROZ7wVUu4NvAjm3VN6rY4M/R1VA/DrxkkhIGFP1HnmWg8jdvRZ8S6ekOHnuogPz
         5dnNA+fXAwUVpdaBzSEwsmbtvvdwAQ+nWOIxiHsEicoVvdwuMb9D3bIXSWK/OmW/c/
         bbVg1HoFcIxcZXRH8iRC2ChLJ9aCWjP4Lb0hFPwrWKnnU5+3hbqXWBsowL2y+syG1W
         yFaFUYgYFvUSgRBMV1p1Ipv7sK3gMBrurqj2PNHhen4XXipy0N7NDdjDuLQX3seVvd
         vgErYeoKj/yShhoc8GgeHzHh4JBowEeXMIwAU8GAbWS+U5cgNSXKmx+9MekO2etMQ4
         37ZWrhSIEUs+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0F48C43141; Sat, 22 Apr 2023 16:36:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB AX201 bluetooth (8087:0026) device is gone
 after system resume
Date:   Sat, 22 Apr 2023 16:36:34 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: nchajon@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209659-62941-HsEtlo4hSy@https.bugzilla.kernel.org/>
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

Normelio (nchajon@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nchajon@protonmail.com

--- Comment #7 from Normelio (nchajon@protonmail.com) ---
Can confirm the same problem on a Thinkbook 14 ILL,tested with Intel AC 8620
and Intel AC 9560. Works without issue while power on but after resuming fr=
om
suspend BT disappear.=20

BIOS:
DJCN30WW (Latest)

Tested distributions:
RHEL 9.1 (kernel 5.19)
Fedora 37 - 38 (kernel 6.2)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
