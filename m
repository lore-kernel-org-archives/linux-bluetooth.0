Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D518BC77B61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjDYTCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjDYTCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 15:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B018BA4
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 12:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A641B63121
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 19:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 151BAC4339E
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682449327;
        bh=Ue0ReGK2FChei9aFGQNH0SPlKtKNsqbRr9kzs/2+sIc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Anprywnd0oN0a1CKE96ng8hbupW0BvwHgN1dW1sHnnFAt7U88d63pP5NZ0fiQUj1K
         Nbbdfu3sfPSCpK7Qw8IY/G5iszG0KuPs2OoMFtGzKaz67DJnbgV57HXRn4IKfMzjXg
         S6EsCVbaBFuMOhpxN3lq/RMm4qHodB0ZHgmgL/nkgxdZbv/baw8vjj1t7m8hRVRE2U
         2lgLmbUdwWy2b1BiiZtVqaaDUuWB5iPxQOj/K4qb/wBYMTA4vaTApC8cOPXcQCcgP+
         zuTsisvLYir9+UWhbEPg8No2xW0M9GlkGr/6BUSe7aipX4SWbsPVlf2MJOhq+ZRw+u
         fwm56yIgecOkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F2B3EC43142; Tue, 25 Apr 2023 19:02:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB AX201 bluetooth (8087:0026) device is gone
 after system resume
Date:   Tue, 25 Apr 2023 19:02:06 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: abuse@basmevissen.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209659-62941-KtcxOsH2Pp@https.bugzilla.kernel.org/>
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

Bas Mevissen (abuse@basmevissen.nl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abuse@basmevissen.nl

--- Comment #8 from Bas Mevissen (abuse@basmevissen.nl) ---
Same here with Thinkbook 15 IIL.
Bus 003 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth
Device dead after a suspend and actually disappears from the listing given =
by
lsusb. No way to get it back. Can this please be picked up?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
