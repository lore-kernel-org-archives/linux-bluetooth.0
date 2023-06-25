Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC36EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jun 2023 15:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFYPbQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Jun 2023 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjFYPbQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Jun 2023 11:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C41AA
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jun 2023 08:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F6060C1F
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jun 2023 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90967C433C0
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jun 2023 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687707070;
        bh=LP5RyLr5UOZGGdoBJkle5s+5eO9/wRPxjYLiJsSp9CU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FUvgpl8mNTJXvBo+4o5d6/LpCfBYRRmmWUDHMg11J2NYIQq/DNeJu19kBcKEXhDE9
         XrtKm04JB4txGCI7IUe8iz/HgcG7d9OLkSl2AJbarSzzxYYYtCDlkYrxnfkaaD9TFK
         30DJGe5vV41jordvn6IVFsPr1lcb0xsTrYjBTCp8xMm4tI6k6e4VCqCwpeJCqSvHy4
         FvpugXz9aotWxm6A8o8Dd4pSzhCsORXzki2lxmRfzpSNT6I50dnoAI2mL66J3tIMyZ
         yy+0SX+4SWBso42CGoiR4ny7cQtbxRtrQ+8SnlLIKKkC/TswdFwUEfjVYBfIck2pgk
         57Gk3aV8wmnRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 82965C53BD2; Sun, 25 Jun 2023 15:31:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 25 Jun 2023 15:31:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: blogmrcs@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-KxcyWiR7zp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #271 from Marcos Ferreira (blogmrcs@gmail.com) ---
The device support will be dropped down?
There is a possibility to keep this device working since the changes above =
can
make to the device work, even with some logs in dmesg...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
