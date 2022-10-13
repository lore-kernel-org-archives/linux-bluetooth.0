Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 12:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJMM2V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJMM2U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 08:28:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29911B2D6
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 05:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 491D0B81E20
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 12:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB066C43147
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665664096;
        bh=QhZqgpxH7ri5QLbBPQwGXw9C5tDesEen4c2QSP1o5MI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rw7pb3iwUzeUZqCHwzEveEBq8+ELPqiV4luz4sHwaf+SkWIFg73bw6sRQgmg+QhFQ
         wPAhI/sApLcWpBpoE2iPSLfRQSJ8zIMb5ckqvc4dPGdG/0r0kn162gV6ur86397iqi
         HOxA3rhafv7gErDRwLZlZoonXiBR6pE/1zAcKkHjI5Z6PkyUbmQKkHcy1r8ksRxMNY
         /UEKfMBjO3Bkr7cFKNHCw9ACYb7jieRGLXM7/tVGEltUatJ0atMFjigq53rZdxfLBw
         WdwdKnEHHUCqGqqy9YYPalCg18nQKBq6I1w9U65yW/h1yyBtkHjFwqON9eia/dfIxp
         7F6lPDdapSovg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DA635C433E6; Thu, 13 Oct 2022 12:28:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Thu, 13 Oct 2022 12:28:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-NJnXyqnEsK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

--- Comment #32 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
According to Patchwork, version 2 of that patch [1] was committed as commit
ab345b04433da6191f5cecfc036c9419ce05011e. I only see that commit in the tag
`next-20220722` though.

Searching for the string, it turns out, this is commit 0900b1c62f43, part of
next-20220728 and successors, and part of v6.0-rc1, so in current mainline
release 6.0.

The people with the Logitech mouse problem, could you please test that vers=
ion?

[1]:
https://patchwork.kernel.org/project/bluetooth/patch/20220714181224.3793757=
-1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
