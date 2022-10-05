Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D148C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 05:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJEFbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJEFbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 01:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A3659FA
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 22:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5A66155F
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 05:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05A5EC433C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664947892;
        bh=ZEvwCP8NnfTOxRnSmt3fDY6zI4R9umCFfIY/R2Yusfo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZOD+reDpEstbQ4MzwSf+DIL0cNvJEJn+IHd9+Tu/q3Nvywv8NNHGOE8dLq5xQMkHg
         vPU74jPA+X2bHNWD6OkK63iZc6YOx/PNR2ULtsE722UQ2zp5KNGCdRhyFEIbupn137
         46XHzLo4GvaoGmN2wo9y36qSd33W3RszzWw1x7U4ZQWxW/+uEmyhovGBnqszRSzMES
         ds3gR9Tni0/YhqENjPQQQO9M5ae2vKXxC5/XxqEwRkwtzWK+JCCabGKWH+hnUmVwkG
         h/RVuReEhJrJlxRVS3IObvmUdsB2B1mZP+GpF08AeNWtJfBF17YTvlLXS2x15mog8l
         Y4WrohqKMSSoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D9DF9C433E6; Wed,  5 Oct 2022 05:31:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Wed, 05 Oct 2022 05:31:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216532-62941-uOn7exOo5F@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

epistemepromeneur@free.fr changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #12 from epistemepromeneur@free.fr ---
There is some progress. with the kernel 5.19.12, at the PC i can connect the
smartphone

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
