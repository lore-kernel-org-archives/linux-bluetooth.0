Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ADCEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 03:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGJDeM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jul 2023 23:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGJDd6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jul 2023 23:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D6118
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jul 2023 20:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8976E60B56
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 03:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4DA0C433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 03:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688960036;
        bh=dk+whK9NwHbLgHtFIxLIPjG7Qw+FGoKQgJlIQAK9sks=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qp8yK36r04LTtXaf+1lxqi3vR4InU1pckzgHZZEVigg1OdUCpg38JElsJnl432Xjk
         XPUHNu+Sgo216WXp/wB2aAksdQCziQ6omvaqMJFzZpwhe1+EKVieVPR0MEqBc5PIQE
         oQdFTNYOBwWvC4grHPDWNreAhg9m2NxQZfaa61EFinuPy7lpikhbA4BUnJe46+MJDl
         W9lscGC9yphOXnyy0nph4tZSZnjb1I4kucNFMHStFxx/veEUosuczof5C0JmD7w29Y
         JBLrLyz2yJdYYSbUWrjTcBoLkJQCkU1x4EjSfuGmeqEo7EJWB8sGdfZBjauIxz8JTE
         BJC0tIu0YPkEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CF4E0C53BD0; Mon, 10 Jul 2023 03:33:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 03:33:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217651-62941-2yWPNB76cS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #2 from Bagas Sanjaya (bagasdotme@gmail.com) ---
Can you attach lspci and dmesg? Can you also perform bisection to find the
culprit commit (see Documentation/admin-guide/bug-bisect.rst for details)?
You'll most likely need to compile your own kernel anyway, so read
Documentation/admin-guide/quickly-build-trimmed-linux.rst for the instructi=
ons.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
