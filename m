Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 09:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiGEJbX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiGEJau (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 05:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BD65AD
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 02:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEEC618D7
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 09:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FB0FC341C7
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657013448;
        bh=Nq90YoPpcDOyt7EcPCvlq6GKLRgWPS/Irgoh3N5vksY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=po6KALtBJXSE9TyhgXLGM63guXGskgZDLa6VTw3DKNL7WSXabS1SUraB2FBkXvzBF
         kvrY5U+F7dvo1esWF8fmevU9jJPJ4uKl5Dbh7iFCYhldU8KWQ2yYixSLt9+nB1hMFy
         A06GN7OonETLlJTcIMgXmKgR0GXItDWqazXgeKO9Iu6NQblFpwPJYI7l7AJGhW5lRr
         smJIZAedZvfu6V5SVTLoaeaMEylWyeLQXzIJ5qNctcyiEZgkXhBI/klMnH42ylEPsf
         04Wnu54AC3BctaLVltFdsrDRj6dv9kt1Uk4Em5V1i+cF/I1R+5GpM2mJ4NAbCOHhki
         zg9JD6GR+um8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5EFE4CC13B1; Tue,  5 Jul 2022 09:30:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Tue, 05 Jul 2022 09:30:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-KzRCHH10hy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #20 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Dmitry Nezhevenko from comment #19)
> I think that I've same problem with followed bluetooth adapter:

See the advice given in Comment 16 (and Comment 18, too) of this bug. In sh=
ort:
best to report this by mail (or a new ticket).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
